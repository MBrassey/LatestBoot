$list = get-Content rebootlist.txt
cls
write-host $list.count "systems targeted, listing details:"
$stat = 'sys.osuptime.latest'
$now = Get-Date

foreach ($vm in $list)
{
Get-Stat -Entity $vm -Stat $stat -Realtime -MaxSamples 1 |
Select @{N='VM';E={$_.Entity.Name}},
    @{N='LastOSBoot';E={$now.AddSeconds(- $_.Value)}},
    @{N='UptimeDays';E={[math]::Floor($_.Value/(24*60*60))}}
}
