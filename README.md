# Get-VLANHealthCheck
Exports the results of the vCenter's VLAN Health Check.

If you work with a lot of VLANs, you should find that the HTML5 vCenter Health Check really starts to be come unusable.
There is also no way to dump out that data, that I could find.

This script is an attempt to provide that functionality.

The script performs these steps.
1. Collect the VMhost names, vmnics, Nic speed, Nic MAC address, SwitchID, and PortID.
2. Collect the VLAN HealthCheck results.

Now these two tables of data are rather useless because there is no common element between them.
However, the Uplinks have common elements across both tables.

3. Collect Uplinks
4. Merge data together.


Credit where credit is due.
https://kb.vmware.com/s/article/1007069
The initial script just pulled the VLAN information from the CDP. But I found that "observed traffic" wasn't reliable enough over time. VLANs would disappear. However it was useful in getting the switch and port information.

Luc Dekens' code here https://communities.vmware.com/message/2643890#2643890 helped me figure out how to parse the Trunked and UnTrunked VLANs.

https://www.vnugglets.com/2014/07/get-vmhost-fc-hba-wwn-info-most-quickly.html
Then I happened across this post about HBA WWNs a year or so later.
This script was bazingly fast. I rewrote how my script gathered hosts' information to follow the method employed here. Sure enough it chopped down the runtime.

I had one spot which was still taking forever to process. Collecting Uplinks. So I reached out to Matt Boren, the author of vNugglets, on vmwarecode.slack.com and asked him for help. He worked up an alternative which was 10x faster.

This script will get the job done but I'm sure could use more refinement. 
