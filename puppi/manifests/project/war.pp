# Define puppi::project::war
#
# This is a shortcut define to build a puppi project for a single WAR deployment with autoloading
# It uses different existing "core" defines (puppi::project, puppi:deploy (many) , puppi::rollback (many) 
# to build a full featured template project for automatic WAR deployments.
# If you need to customize it, either change the template defined here or build up your own custom ones.
#
define puppi::project::war (
    $source_url,
    $user,
    $deploy_root,
    $report_email,
    $enable = 'true' ) {

    require puppi::params

    # Autoinclude the puppi class
    include puppi

    # Create Project
    puppi::project { $name: enable => $enable }
 
    # Populate Project scripts for deploy

    puppi::deploy {
        "${name}-Run_PRE-Checks":
             priority => "10" , command => "check_project.sh" , arguments => "$name" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Retrieve_WAR":
             priority => "20" , command => "get_curl.sh" , arguments => "$source_url" ,
             user => "root" , project => "$name" , enable => $enable ;
        "${name}-Backup_existing_WAR":
             priority => "30" , command => "archive.sh" , arguments => "$deploy_root" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Deploy_new_WAR":
             priority => "40" , command => "deploy_file.sh" , arguments => "$deploy_root" ,
             user => "$user" , project => "$name" , enable => $enable;
        "${name}-Run_POST-Checks":
             priority => "50" , command => "check_project.sh" , arguments => "$name" ,
             user => "root" , project => "$name" , enable => $enable ;
    }

    puppi::rollback {
        "${name}-Recover_latest_WAR":
             priority => "30" , command => "recover.sh" , arguments => "$deploy_root" ,
             user => "$user" , project => "$name" , enable => $enable;
        "${name}-Run_POST-Checks":
             priority => "50" , command => "check_project.sh" , arguments => "$name" ,
             user => "root" , project => "$name" , enable => $enable ;
    }

    puppi::report {
        "${name}-Mail_Notification":
             priority => "20" , command => "report_mail.sh" , arguments => "$report_email" ,
             user => "root" , project => "$name" , enable => $enable ;
    }

}
