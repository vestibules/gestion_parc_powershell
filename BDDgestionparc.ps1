#chargement du module SQL
$mysqlnet=[reflection.assembly]::loadwithpartialname("Mysql.data")
if (!($mysqlnet))
{
Write-Host "Erreur MySQL"
}

#Définition des variables de connexion
$dbhost = "localhost"
$dbname = "gestionparc"
$dbport = 3306
$dbuser = "root"
$dbpwd = ''

#Connexion à la BDD
$connectionstring = "server=$dbhost;port=$dbport;uid=$dbuser;pwd=$dbpwd;database=$dbname"
$conn = New-Object Mysql.data.mysqlclient.mysqlconnection($connectionstring)
$conn.Open()

#Affichage des tables#####################################################################
Write-Host "Voici les tables de la base dont le contenu peut être consulté :"
$reqStr = "SHOW TABLES"
$req = New-Object Mysql.Data.MysqlClient.MySqlCommand($reqStr,$conn)

#Création du dataset et dataadapter
$dataAdapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter($req)  
$dataSet = New-Object System.Data.DataSet  
$dataAdapter.Fill($dataSet,"test")

#Affichage du résultat
$res = $dataSet.Tables["test"]  
$res | Format-Table
##########################################################################################

#Sélection de la table et de l'action#####################################################
$table = Read-Host "Sur quelle table souhaitez - vous effectuer une action ?"
$action = Read-Host "Quelle action souhaitez - vous effectuer ? Vous pouvez AFFICHER, SUPPRIMER ou AJOUTER du contenu"

#Traitement de la requête d'affichage pour toutes les tables##############################
if ($action -Like "*Afficher*")
{
$afficher = "SELECT * FROM $table"
$reqafficher = New-Object Mysql.Data.MysqlClient.MySqlCommand($afficher,$conn)
$dataAdapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter($reqafficher)  
$dataSet = New-Object System.Data.DataSet  
$dataAdapter.Fill($dataSet,"test")
$res = $dataSet.Tables["test"]  
$res | Format-Table
}
##########################################################################################
else
{
    if ($table -Like "*Utilisateur*")
    {
        if ($action -Like "*Ajouter*")
        {
        $ajouternom = Read-Host "Veuillez saisir le NOM D'USAGE de l'Utilisateur"
        $ajouterprenom = Read-Host "Veuillez saisir le PRENOM de l'Utilisateur"
        $ajouteridlocal = Read-Host "Veuillez saisir l'ID du local d'affectation de l'Utilisateur"
        $ajouter = "INSERT INTO utilisateur (id_utlisateur,nom_utilisateur,prenom_utilisateur,id_local) VALUES (NULL,'$ajouternom','$ajouterprenom',$idlocal)"
