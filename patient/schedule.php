<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/animations.css">  
    <link rel="stylesheet" href="../css/main.css">  
    <link rel="stylesheet" href="../css/admin.css">
        
    <title>Sessions</title>
    <style>
        .popup{
            animation: transitionIn-Y-bottom 0.5s;
        }
        .sub-table{
            table-layout: fixed;
    width: 100%;
    margin: 0 auto;
            animation: transitionIn-Y-bottom 0.5s;
        }
        .sub-table td {
    padding: 0;
    margin: 0;
    width: 50%;
}

.dashboard-items {
    word-wrap: break-word;
    overflow-wrap: break-word;
}
    </style>
</head>
<body>
    <?php
    session_start();

    if(isset($_SESSION["user"])){
        if(($_SESSION["user"])=="" or $_SESSION['usertype']!='p'){
            header("location: ../login.php");
        }else{
            $useremail=$_SESSION["user"];
        }
    }else{
        header("location: ../login.php");
    }

    include("../connection.php");

    $sqlmain = "select * from patient where pemail=?";
    $stmt = $database->prepare($sqlmain);
    $stmt->bind_param("s", $useremail);
    $stmt->execute();
    $result = $stmt->get_result();
    $userfetch = $result->fetch_assoc();
    $userid = $userfetch["pid"];
    $username = $userfetch["pname"];

    date_default_timezone_set('Asia/Kolkata');
    $today = date('Y-m-d');
    
    $limit = 10;
    $page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
    $offset = ($page - 1) * $limit;

    $sqlmain = "select * from schedule inner join doctor on schedule.docid=doctor.docid where schedule.scheduledate >= ? order by schedule.scheduledate asc LIMIT ?, ?";
    $stmt = $database->prepare($sqlmain);

    $stmt->bind_param("sii", $today, $offset, $limit);
    $stmt->execute();
    $result = $stmt->get_result();

    $countSql = "select count(*) as total from schedule where scheduledate >= ?";
    $countStmt = $database->prepare($countSql);
    $countStmt->bind_param("s", $today);
    $countStmt->execute();
    $countResult = $countStmt->get_result();
    $countRow = $countResult->fetch_assoc();
    $totalPages = ceil($countRow['total'] / $limit);

    $insertkey = "";
    $searchtype = "All";
    if ($_POST) {
        if (!empty($_POST["search"])) {
            $keyword = $_POST["search"];
            $insertkey = $keyword;
            $searchtype = "Search Result : ";
            
            $sqlmain = "select * from schedule inner join doctor on schedule.docid=doctor.docid where schedule.scheduledate >= ? and (doctor.docname = ? or doctor.docname like ? or schedule.title like ? or schedule.scheduledate like ?) order by schedule.scheduledate asc LIMIT ?, ?";
            $stmt = $database->prepare($sqlmain);
            $likeKeyword = "%" . $keyword . "%";
            $stmt->bind_param("ssssssi", $today, $keyword, $likeKeyword, $likeKeyword, $likeKeyword, $offset, $limit);
            $stmt->execute();
            $result = $stmt->get_result();
        }
    }
    ?>
    
    <div class="container">
        <div class="menu">
            <table class="menu-container" border="0">
                <tr>
                    <td style="padding:10px" colspan="2">
                        <table border="0" class="profile-container">
                            <tr>
                                <td width="30%" style="padding-left:20px">
                                    <img src="../img/patient_icon.png" alt="" width="100%" style="border-radius:50%">
                                </td>
                                <td style="padding:0px;margin:0px;">
                                    <p class="profile-title"><?php echo substr($username,0,13); ?>..</p>
                                    <p class="profile-subtitle"><?php echo substr($useremail,0,22); ?></p>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <a href="../logout.php"><input type="button" value="Log out" class="logout-btn btn-primary-soft btn"></a>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr class="menu-row">
                    <td class="menu-btn menu-icon-home">
                        <a href="index.php" class="non-style-link-menu"><div><p class="menu-text">Home</p></a></div></a>
                    </td>
                </tr>
                <tr class="menu-row">
                    <td class="menu-btn menu-icon-doctor">
                        <a href="doctors.php" class="non-style-link-menu"><div><p class="menu-text">All Doctors</p></a></div>
                    </td>
                </tr>
                <tr class="menu-row">
                    <td class="menu-btn menu-icon-session menu-active menu-icon-session-active">
                        <a href="schedule.php" class="non-style-link-menu non-style-link-menu-active"><div><p class="menu-text">Scheduled Sessions</p></div></a>
                    </td>
                </tr>
                <tr class="menu-row">
                    <td class="menu-btn menu-icon-appoinment">
                        <a href="appointment.php" class="non-style-link-menu"><div><p class="menu-text">My Bookings</p></a></div>
                    </td>
                </tr>
                <tr class="menu-row">
                    <td class="menu-btn menu-icon-settings">
                        <a href="settings.php" class="non-style-link-menu"><div><p class="menu-text">Settings</p></a></div>
                    </td>
                </tr>
            </table>
        </div>

        <div class="dash-body">
            <table border="0" width="100%" style="border-spacing: 0;margin:0;padding:0;margin-top:25px;">
                <tr>
                    <td width="13%">
                        <a href="schedule.php"><button class="login-btn btn-primary-soft btn btn-icon-back" style="padding-top:11px;padding-bottom:11px;margin-left:20px;width:125px"><font class="tn-in-text">Back</font></button></a>
                    </td>
                    <td>
                        <form action="" method="post" class="header-search">
                            <input type="search" name="search" class="input-text header-searchbar" placeholder="Search Doctor name or Email or Date (YYYY-MM-DD)" value="<?php echo $insertkey; ?>">&nbsp;&nbsp;
                            <input type="Submit" value="Search" class="login-btn btn-primary btn" style="padding-left: 25px;padding-right: 25px;padding-top: 10px;padding-bottom: 10px;">
                        </form>
                    </td>
                    <td width="15%">
                        <p style="font-size: 14px;color: rgb(119, 119, 119);padding: 0;margin: 0;text-align: right;">Today's Date</p>
                        <p class="heading-sub12" style="padding: 0;margin: 0;"><?php echo $today; ?></p>
                    </td>
                    <td width="10%">
                        <button class="btn-label" style="display: flex;justify-content: center;align-items: center;"><img src="../img/calendar.svg" width="100%"></button>
                    </td>
                </tr>

                <tr>
                <td colspan="4" style="padding-top:10px;width: 100%;">
    <p class="heading-main12" style="margin-left: 45px;font-size:18px;color:rgb(49, 49, 49)">
        <?php echo $searchtype . " Sessions (" . $result->num_rows . ")"; ?>
    </p>
    <?php if (!empty($insertkey)): ?>
        <p class="heading-main12" style="margin-left: 45px;font-size:22px;color:rgb(49, 49, 49)">
            "<?php echo $insertkey; ?>"
        </p>
    <?php endif; ?>
</td>

                </tr>

                <tr>
                <td colspan="4">
   <center>
      <div class="abc scroll">
         <table class="sub-table scrolldown" border="0" style="padding: 50px; border: none;">
            <tbody>
               <?php
               if ($result->num_rows == 0) {
                   echo '<tr>
                           <td colspan="2">
                               <br><br><br><br>
                               <center>
                               <img src="../img/notfound.svg" width="25%">
                               <br>
                               <p class="heading-main12" style="margin-left: 45px; font-size:20px; color:rgb(49, 49, 49)">We couldn\'t find anything related to your keywords!</p>
                               <a class="non-style-link" href="schedule.php"><button class="login-btn btn-primary-soft btn" style="display: flex; justify-content: center; align-items: center; margin-left:20px;">&nbsp; Show all Sessions &nbsp;</button></a>
                               </center>
                               <br><br><br><br>
                           </td>
                       </tr>';
               } else {
                   $counter = 0;
                   while ($row = $result->fetch_assoc()) {
                       if ($counter % 2 == 0) {
                           echo '<tr>'; 
                       }

                       $scheduleid = $row["scheduleid"];
                       $title = $row["title"];
                       $docname = $row["docname"];
                       $scheduledate = $row["scheduledate"];
                       $scheduletime = $row["scheduletime"];

                       echo "
                       <td>
                           <div class='dashboard-items search-items'>
                               <div style='width: 100%'>
                                   <div class='h1-search'>".substr($title, 0, 50)."</div><br>
                                   <div class='h3-search'>".substr($docname, 0, 30)."</div>
                                   <div class='h4-search'>".$scheduledate."<br>Starts: <b>@".substr($scheduletime, 0, 5)."</b> (24h)</div><br>
                                   <a href='booking.php?id=".$scheduleid."'>
                                       <button class='login-btn btn-primary-soft btn' style='padding-top: 11px; padding-bottom: 11px; width: 100%'>
                                           <font class='tn-in-text'>Book Now</font>
                                       </button>
                                   </a>
                               </div>
                           </div>
                       </td>";

                       $counter++;
                       
                       if ($counter % 2 == 0) {
                           echo '</tr>';
                       }
                   }
               }
               ?>
            </tbody>
         </table>
      </div>
   </center>
</td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>
