# Installing and Configuring DNS Servers

|  |  |
|--|--|
| Exercise 2.1 | Creating a DNS Zone |
| Exercise 2.2 | Creating DNS Subdomains |
| Exercise 2.3 | Creating Secondary DNS Zone |
| Exercise 2.4 | Enabling DNS Cache Locking |
| Exercise 2.5 | Configuring DNS Debug Logging |
| Exercise 2.6 | Configuring Recursion and Netmask Ordering |
| Exercise 2.7 | Delegating DNS Administration |
| Exercise 2.8 | Create internationalized domain name |
| Exercise 2.9 | Create DNS zone using PowerShell |
| Exercise 2.10 | Create DNS zone using dnscmd |





## Before You Begin
The lab environment consists of student workstations connected to a local area network, along with a server that functions as the domain controller for a domain called adatum.com. The computers required for this lab are listed in Table 2-1.

Table 1-1
| Computer Name | Operating System | IP Address | Role |
|--|--|--|--|
| server1 | Windows Server 2022 | 10.10.10.1 | ADDS, DNS |
| server2 | Windows Server 2022 | 10.10.10.2 | Member Server |
| server3 | Windows Server 2022 | 10.10.10.3 | Standalone Server |

## Credentials
 The credentials required for this lab are listed in Table 1-2.

Table 1-2
| Username | Password |
|--|--|
| contoso\administrator | P@ssw0rd! |
| administrator | P@ssw0rd! |

## SCENARIO
After completing this lab, you will be able to:
- Create a DNS zone
- Create DNS subdomains
- Enable DNS cache locking
- Configuring DNS logging
- Configuring recursion
- Configure netmask ordering
- Working with IDN and Punycode
- Use DNS PowerShell and command line tools
- Use DNS administrative tools

Estimated lab time: 120 minutes

## Exercise 2.1 - Creating a DNS Zone
1. Log on to **server1** as **contoso\administrator**.
2. Using Server Manager, click **Tools > DNS**. The DNS Manager console appears.
3. Expand the **server1** node and select the Forward Lookup Zones folder.
	> Q1: Why is a zone for the root domain of your DNS namespace already 	present in the Forward Lookup Zones folder?
4. Right-click the **Forward Lookup Zones** folder and choose **New Zone**.
5. In the New Zone Wizard, on the Welcome page, click **Next**.
6. On the Zone Type page, leave the Primary Zone option and the Store the zone in Active Directory check box selected and click **Next**.
7. On the Active Directory Zone Replication Scope page, click **Next**.
8. On the Zone Name page, in the Zone name text box, type **adventure-works.com** and then click **Next**.
9. On the Dynamic Update page, select the Allow both **nonsecure and secure dynamic updates** option and then click **Next**.
10. On the Completing the New Zone Wizard page, click **Finish**.
11. Take a screen shot of the DNS Manager window by pressing **Alt+PrtScr** and then paste it into your Lab01_ worksheet file in the page provided by pressing **Ctrl+ V**.
12. Double-click the **adventure-works.com** zone.
	> Q2: Which resource records appear in the new zone you created by default?
	
Leave DNS Manager console open for the next exercise.

## Exercise 2.2 - Creating DNS Subdomains

1. On **server1**, in the DNS Manager console, expand the Forward Lookup Zones and then click the **adventure-works.com** zone.
2. Right-click the **adventure-works.com** zone and choose **New Domain**.
3. In the Type the new DNS domain name text box, type **HR** and then click **OK**.
4. Repeat previous steps to create the domains for the **Sales** and **Production** departments.
	> Q3: Which resource records appear in the new domains you created by default?
	
Leave DNS Manager console open for the next exercise.

## Exercise 2.3 - Creating Secondary DNS Zone

1.  Click  **Start**, point to  **Administrative Tools**, and then click  **DNS**.    
2.  In the console tree, expand  **server1**.    
3.  In the console tree, expand  **Forward Lookup Zones**.    
4.  Right-click the zone that you want (for example,  `adventure-works.com`), and then click  **Properties**.    
5.  Click the  **Name Servers**  tab, and then click  **Add**.    
6.  In the  **Server fully qualified domain name (FQDN)**  box, type the host name of the server that you want to add.    
    For example, type  `server2.adventure-works.com`.
7.  In the  **IP address**  box, type the IP address of the name server that you want to add (10.10.10.2), and then click  **Add**.    
8.  Click  **OK**, and then click  **OK**.    
9.  In the console tree, click  **Reverse Lookup Zones**, right-click the zone that you want, and then click  **Properties**.    
10.  Click the  **Name Servers**  tab, and then click  **Add**.    
11.  In the  **Server name**  box, type the host name of the server that you want to add.    
    For example,  `server2.adventure-works.com`.    
12.  In the  **IP address**  box, type the IP address of the name server that you want to add (10.10.10.2), and then click  **Add**.
13.  Click  **OK**  two times.
14. Log on to **server2** as **contoso\administrator**.
15. Open elevated PowerShell and run the following command:
	```
	Install-WindowsFeature -Name DNS -IncludeManagementTools
	```
	Wait for the installation to complete.
16.  Click  **Start**, point to  **Administrative Tools**, and then click  **DNS**.
17.  In the console tree, under  **DNS**, click  **server2**.
18.  In the console tree, click  **Forward Lookup Zones**.
19.  Right-click  **Forward Lookup Zones**, and then click  **New Zone**.
20.  When the New Zone Wizard starts, click  **Next**  to continue.
21.  Click  **Secondary Zone**, and then click  **Next**.
22.  In the  **Name**  box, type the name of the zone (`adventure-works.com`), and then click  **Next**.
23.  On the  **Master DNS Servers**  page, type the IP address of the primary name server (`10.10.10.1`) for this zone, click  **Add**, click  **Next**, and then click  **Finish**.


## Exercise 2.4 - Enabling DNS Cache Locking

DNS Cache Locking prevents an attacker from replacing records in the resolver cache while the Time to Live (TTL) is still in force.
When a recursive DNS server responds to a query, it caches the results so that it can respond quickly if it receives another query requesting the same information. The period of time the DNS server keeps information in its cache is determined by the Time to Live (TTL) value for a resource record.

1. On **server1**, click the Start button, type cmd, and then click Enter.
2. In the command prompt window, execute the following command:
	```
	dnscmd /Config /CacheLockingPercent 100
	```	
	Cache locking is configured as a percent value. For example, if the cache locking value is set to 50, the DNS server does not overwrite a cached entry for half of the duration of the TTL. By default, the cache locking percent value is 100. This value means that the DNS server will not overwrite cached entries for the entire duration of the TTL.

3. Execute the fallowing command:
	```
	net stop DNS
	```
4. Execute the following command:
	```
	net start DNS
	```
5. Take a screen shot of the command prompt window by pressing **Alt+PrtScr** and then paste it into your Lab01_ worksheet file in the page provided by pressing **Ctrl+ V**.

## Exercise 2.5 - Configuring DNS Debug Logging

DNS logging is a troubleshooting tool that provides detailed, file based analysis of all DNS packets and messages. The full title is DNS Debug logging. There is a processing and storage overhead in the use of debug logging. Remember, you do not want DNS Debug Logging to run all of the time because there is processing and storage overhead when debug logging is turned on.

1. On **server1**, using the DNS Manager console, right-click the **server1** and choose **Properties**.
2. In the **Properties** dialog box, click the **Debug Logging** tab.
3. Click to enable **Log Packets for debugging** check box.
4. Take a screen shot of the command prompt window by pressing **Alt+PrtScr** and then paste it into your Lab01_ worksheet file in the page provided by pressing **Ctrl+ V**.
5. Click **OK** to close the Properties dialog box.
