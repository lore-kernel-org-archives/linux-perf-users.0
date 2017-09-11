From: Milian Wolff <milian.wolff@kdab.com>
Subject: perf AppImage - perf stat fails to count child process
Date: Mon, 11 Sep 2017 17:14:57 +0200
Message-ID: <4549240.M84I420bcG@milian-kdab2>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart41825203.zCzliQ2AsB"; micalg="sha256"; protocol="application/pkcs7-signature"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:46952 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750715AbdIKPPD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 11 Sep 2017 11:15:03 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho <acme@kernel.org>, linux-kernel@vger.kernel.org

--nextPart41825203.zCzliQ2AsB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hey all,

because many people only have a pretty outdated perf userspace toolsuite 
available, I would like to package a recent version of perf into an AppImage. 
My current .travis.yml can be found at [1], the result is available from [2], 
e.g. [3].

[1]: https://github.com/milianw/linux/blob/wip/perf-appimage/.travis.yml
[2]: https://travis-ci.org/milianw/linux/
[3]: https://transfer.sh/IX3zr/perf-git.5b330557-x86_64.AppImage

This was build on a Ubuntu 14.04 VM using Travis CI. All libs that got bundled 
are those available on that system, except for elfutils - for that I used a 
custom build of the newer 0.170 release.

So far so good, this actually seems to work for most purposes I've tried so 
far. What's missing is proper `man` integration, I'll try to look into this. 
But one issue that I've found which is puzzling me is the following:

perf stat does not work when filtering on an application. I.e. when I use the 
system wide mode, it works fine:

~~~~~
$ ./perf-git.3a73b7f9-x86_64.AppImage stat
^C
 Performance counter stats for 'system wide':

       4510.197963      cpu-clock (msec)          #    3.998 CPUs utilized          
               205      context-switches          #    0.045 K/sec                  
                 3      cpu-migrations            #    0.001 K/sec                  
                 0      page-faults               #    0.000 K/sec                  
        16,396,597      cycles                    #    0.004 GHz                    
        13,065,398      stalled-cycles-frontend   #   79.68% frontend cycles 
idle   
        11,340,112      stalled-cycles-backend    #   69.16% backend cycles 
idle    
         5,718,881      instructions              #    0.35  insn per cycle         
                                                  #    2.28  stalled cycles 
per insn
         1,197,336      branches                  #    0.265 M/sec                  
           101,136      branch-misses             #    8.45% of all branches        

       1.128056669 seconds time elapsed
~~~~~

But when I launch an application most counters are empty:

~~~~~
$ ./perf-git.3a73b7f9-x86_64.AppImage stat sleep 1

 Performance counter stats for 'sleep 1':

     <not counted>      task-clock                                                  
     <not counted>      context-switches                                            
     <not counted>      cpu-migrations                                              
     <not counted>      page-faults                                                 
     <not counted>      cycles                                                      
     <not counted>      stalled-cycles-frontend                                     
     <not counted>      stalled-cycles-backend                                      
            68,696      instructions                                                                                   
            13,573      branches                  #    0.000 K/sec                  
             1,410      branch-misses             #   10.39% of all branches        

       0.000023100 seconds time elapsed
~~~~~

Also note how this did _not_ sleep for one second but rather quit sooner than 
that?!

Stracing (as root, due to AppImage), shows the following issue:

~~~~~
$ sudo strace -f -e fork,execve -s 1000 ./perf-git.3a73b7f9-x86_64.AppImage 
stat sleep 1
execve("./perf-git.3a73b7f9-x86_64.AppImage", ["./perf-git.3a73b7f9-
x86_64.AppImage", "stat", "sleep", "1"], 0x7ffea0ec02d0 /* 18 vars */) = 0
strace: Process 21593 attached
strace: Process 21595 attached
[pid 21593] +++ exited with 0 +++
[pid 21592] --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=21593, 
si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
strace: Process 21596 attached
[pid 21592] execve("/tmp/.mount_perf-ggA4YJW/AppRun", ["./perf-git.3a73b7f9-
x86_64.AppImage", "stat", "sleep", "1"], 0x1ce1b70 /* 21 vars */) = 0
strace: Process 21597 attached
[pid 21597] execve("/usr/libexec/perf-core/sleep", ["sleep", "1"], 0x3075650 /
* 22 vars */) = -1 ENOENT (No such file or directory)
[pid 21597] execve("/tmp/./sleep", ["sleep", "1"], 0x3075650 /* 22 vars */) = 
-1 ENOENT (No such file or directory)
[pid 21597] execve("/home/milian/.bin/sleep", ["sleep", "1"], 0x3075650 /* 22 
vars */) = -1 ENOENT (No such file or directory)
[pid 21597] execve("/usr/lib/icecream/libexec/icecc/bin/sleep", ["sleep", 
"1"], 0x3075650 /* 22 vars */) = -1 ENOENT (No such file or directory)
[pid 21597] execve("/ssd2/milian/projects/compiled/other/bin/sleep", ["sleep", 
"1"], 0x3075650 /* 22 vars */) = -1 ENOENT (No such file or directory)
[pid 21597] execve("/home/milian/.bin/kf5/sleep", ["sleep", "1"], 0x3075650 /* 
22 vars */) = -1 ENOENT (No such file or directory)
[pid 21597] execve("/ssd2/milian/projects/compiled/kf5/bin/sleep", ["sleep", 
"1"], 0x3075650 /* 22 vars */) = -1 ENOENT (No such file or directory)
[pid 21597] execve("/home/milian/projects/compiled/other/bin/sleep", ["sleep", 
"1"], 0x3075650 /* 22 vars */) = -1 ENOENT (No such file or directory)
[pid 21597] execve("/home/milian/projects/compiled/kf5/bin/sleep", ["sleep", 
"1"], 0x3075650 /* 22 vars */) = -1 ENOENT (No such file or directory)
[pid 21597] execve("/usr/local/sbin/sleep", ["sleep", "1"], 0x3075650 /* 22 
vars */) = -1 ENOENT (No such file or directory)
[pid 21597] execve("/usr/local/bin/sleep", ["sleep", "1"], 0x3075650 /* 22 
vars */) = -1 ENOENT (No such file or directory)
[pid 21597] execve("/usr/bin/sleep", ["sleep", "1"], 0x3075650 /* 22 vars */
 Performance counter stats for 'sleep 1':

     <not counted>      task-clock                                                  
     <not counted>      context-switches                                            
     <not counted> ) = 0
     cpu-migrations                                              
     <not counted>      page-faults                                                 
     <not counted>      cycles                                                      
     <not counted>      instructions                                                
     <not counted>      branches                                                    
     <not counted>      branch-misses                                               

       0.000033074 seconds time elapsed

Some events weren't counted. Try disabling the NMI watchdog:
        echo 0 > /proc/sys/kernel/nmi_watchdog
        perf stat ...
        echo 1 > /proc/sys/kernel/nmi_watchdog
[pid 21597] --- SIGTERM {si_signo=SIGTERM, si_code=SI_USER, si_pid=21592, 
si_uid=0} ---
[pid 21597] +++ killed by SIGTERM +++
[pid 21592] --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_KILLED, si_pid=21597, 
si_uid=0, si_status=SIGTERM, si_utime=0, si_stime=0} ---
[pid 21596] --- SIGPIPE {si_signo=SIGPIPE, si_code=SI_USER, si_pid=21595, 
si_uid=0} ---
[pid 21592] +++ exited with 0 +++
[pid 21595] --- SIGHUP {si_signo=SIGHUP, si_code=SI_USER, si_pid=21595, 
si_uid=0} ---
[pid 21596] +++ exited with 0 +++
+++ exited with 0 +++
~~~~~

I couldn't yet find a way to get a backtrace to the SIGTERM. I also wonder why 
I don't see any error message anywhere...

To make this even more confusing, extracting to AppImage (it's essentially a 
squashfs image that gets loop-mounted via fuse), things start to work 
again...:

~~~~~
$ ./perf-git.3a73b7f9-x86_64.AppImage --appimage-extract
..
$ ./squashfs-root/AppRun stat sleep 1

 Performance counter stats for 'sleep 1':

          0.559792      task-clock (msec)         #    0.001 CPUs utilized          
                 1      context-switches          #    0.002 M/sec                  
                 0      cpu-migrations            #    0.000 K/sec                  
                60      page-faults               #    0.107 M/sec                  
           922,471      cycles                    #    1.648 GHz                    
           564,261      stalled-cycles-frontend   #   61.17% frontend cycles 
idle   
           441,173      stalled-cycles-backend    #   47.83% backend cycles 
idle    
           743,424      instructions              #    0.81  insn per cycle         
                                                  #    0.76  stalled cycles 
per insn
           145,166      branches                  #  259.321 M/sec                  
             7,726      branch-misses             #    5.32% of all branches        

       1.001073810 seconds time elapsed
~~~~~~

So clearly, it has something to do with the FUSE mounting / AppImage... But 
has anyone a clue what could be going on here exactly? Any suggestions for 
what to try in order to debug this?

Thanks
-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
--nextPart41825203.zCzliQ2AsB
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCDEIw
ggXmMIIDzqADAgECAhBqm+E4O/8ra58B1dm4p1JWMA0GCSqGSIb3DQEBDAUAMIGFMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYD
VQQKExFDT01PRE8gQ0EgTGltaXRlZDErMCkGA1UEAxMiQ09NT0RPIFJTQSBDZXJ0aWZpY2F0aW9u
IEF1dGhvcml0eTAeFw0xMzAxMTAwMDAwMDBaFw0yODAxMDkyMzU5NTlaMIGXMQswCQYDVQQGEwJH
QjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQK
ExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVudGlj
YXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AL6znlesKHZ1QBbHOAOY08YYdiFQ8yV5C0y1oNF9Olg+nKcxLqf2NHbZhGra0D00SOTq9bus3/mx
gUsg/Wh/eXQ0pnp8tZ8XZWAnlyKMpjL+qUByRjXCA6RQyDMqVaVUkbIr5SU0RDX/kSsKwer3H1pT
/HUrBN0X8sKtPTdGX8XAWt/VdMLBrZBlgvnkCos+KQWWCo63OTTqRvaq8aWccm+KOMjTcE6s2mj6
RkalweyDI7X+7U5lNo6jzC8RTXtVV4/Vwdax720YpMPJQaDaElmOupyTf1Qib+cpukNJnQmwygjD
8m046DQkLnpXNCAGjuJy1F5NATksUsbfJAr7FLUCAwEAAaOCATwwggE4MB8GA1UdIwQYMBaAFLuv
fgI9+qbxPISOre44mOzZMjLUMB0GA1UdDgQWBBSCr2yM+MX+lmF86B89K3FIXsSLwDAOBgNVHQ8B
Af8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADARBgNVHSAECjAIMAYGBFUdIAAwTAYDVR0fBEUw
QzBBoD+gPYY7aHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2VydGlmaWNhdGlvbkF1
dGhvcml0eS5jcmwwcQYIKwYBBQUHAQEEZTBjMDsGCCsGAQUFBzAChi9odHRwOi8vY3J0LmNvbW9k
b2NhLmNvbS9DT01PRE9SU0FBZGRUcnVzdENBLmNydDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3Au
Y29tb2RvY2EuY29tMA0GCSqGSIb3DQEBDAUAA4ICAQB4XLKBKDRPPO5fVs6fl1bsj6JrF/bz9kkI
BtTYLzXN30D+03Hj6OxCDBEaIeNmsBhrJmuubvyE7HtoSmR809AgcYboW+rcTNZ/8u/Hv+GTrNI/
AhqX2/kiQNxmgUPt/eJPs92Qclj0HnVyy9TnSvGkSDU7I5Px+TbO+88G4zipA2psZaWeEykgzClZ
lPz1FjTCkk77ZXp5cQYYexE6zeeN4/0OqqoAloFrjAF4o50YJafX8mnahjp3I2Y2mkjhk0xQfhNq
bzlLWPoT3m7j7U26u7zg6swjOq8hITYc3/np5tM5aVyu6t99p17bTbY7+1RTWBviN9YJzK8HxzOb
XYWBf/L+VGOYNsQDTxAk0Hbvb1j6KjUhg7fO294F29QIhhmiNOr84JHoy+fNLpfvYc/Q9EtFOI5I
SYgOxLk3nD/whbUe9rmEQXLp8MB933Ij474gwwCPUpwv9mj2PMnXoc7mbrS22XUSeTwxCTP9bcmU
dp4jmIoWfhQm7X9w/Zgddg+JZ/YnIHOwsGsaTUgj7fIvxqith7DoJC91WJ8Lce3CVJqb1XWeKIJ8
4F7YLXZN0oa7TktYgDdmQVxYkZo1c5noaDKH9Oq9cbm/vOYRUM1cWcef20Wkyk5S/GFyyPJwG0fR
1nRas3DqAf4cXxMiEKcff7PNa4M3RGTqH0pWR8p6EjCCBlQwggU8oAMCAQICEAf6KCF9+1doL2oE
OTPysLwwDQYJKoZIhvcNAQELBQAwgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1h
bmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0w
OwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWls
IENBMB4XDTE3MDUyMzAwMDAwMFoXDTIwMDUyMjIzNTk1OVowggFZMQswCQYDVQQGEwJTRTEPMA0G
A1UEERMGNjgzIDMxMRIwEAYDVQQIEwlWYWVybWxhbmQxEDAOBgNVBAcTB0hhZ2ZvcnMxGDAWBgNV
BAkTD05vcnJpbmdzIHZhZWcgMjEPMA0GA1UEEhMGQm94IDMwMSYwJAYDVQQKDB1LbGFyw6RsdmRh
bGVucyBEYXRha29uc3VsdCBBQjEdMBsGA1UECxMUQSBLREFCIEdyb3VwIENvbXBhbnkxQzBBBgNV
BAsMOklzc3VlZCB0aHJvdWdoIEtsYXLDpGx2ZGFsZW5zIERhdGFrb25zdWx0IEFCIEUtUEtJIE1h
bmFnZXIxHzAdBgNVBAsTFkNvcnBvcmF0ZSBTZWN1cmUgRW1haWwxFTATBgNVBAMTDE1pbGlhbiBX
b2xmZjEkMCIGCSqGSIb3DQEJARYVbWlsaWFuLndvbGZmQGtkYWIuY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAxrzfNBVvRbiAknuTBXuQnNm9sLIFLo0vbPB6kswk78A3tA++Zn5c
lQUHhGlQq1cdYxagnUpqwvG3Sod15mPSOLkAPf/mabLN7p+lFbRaUP+97ZkTZtvb4BCC3osIEFI4
G393OSFWqc2qmIPE/SwSASbAA20Fcaa2M6P1lhOk/ttUh2jIurTPF0wUycIA7lBddrOgaOA8e2m6
iLTNHtlrfRbBaUX91D5ebY+UWmIjXSQ9+CtutMzBkwnF0rZKririvOkklg9VzEGNQVHrQfDF2s/U
pOtmtuVSwElauGT/KALyCFuIrYC1pmaKH8S1xODJqiRaf6jH8E+KQzKjyM/ErwIDAQABo4IB1TCC
AdEwHwYDVR0jBBgwFoAUgq9sjPjF/pZhfOgfPStxSF7Ei8AwHQYDVR0OBBYEFN+m99RtIuA1bSdw
6b1brOX7X3AJMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUF
BwMEBggrBgEFBQcDAjBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEDBTArMCkGCCsGAQUFBwIBFh1o
dHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3Js
LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3JsMIGLBggrBgEFBQcBAQR/MH0wVQYIKwYBBQUHMAKGSWh0dHA6Ly9jcnQuY29tb2RvY2Eu
Y29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAgBgNVHREEGTAXgRVtaWxpYW4ud29s
ZmZAa2RhYi5jb20wDQYJKoZIhvcNAQELBQADggEBABf47LSJADqH+ow9INv3QM1NC/qq2bjxGvsZ
68iD11VEUAFlsYfsVTgQqUirwPVTYenXtwVBELHZyywsui1JxL7HKQetLQegDDP/RyfjReVaWxhy
3OpuItsgLVbru9QVgPifnoBFPtfZcwjeJDmeSbLT8oj4Rd0KYBOIve7WKvsfNPsNwfbLwY2zILkE
LjxZcVi2AwZHDyab+dzL/3YcLuJj1lSawBGn7ilpcdZydlv4aye51pD/MemLIYLcylt+ImrmjnTV
y+QlAHRF3s5FE8yAr+W1MBD/1bKZCSgFt8VQoAlz3hiQh8QqZp4Zl8WuVL4+mP/mT6VDEWgq/0Bo
cukxggJuMIICagIBATCBrDCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hl
c3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNV
BAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EC
EAf6KCF9+1doL2oEOTPysLwwDQYJYIZIAWUDBAIBBQCggZMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTcwOTExMTUxNDU3WjAoBgkqhkiG9w0BCQ8xGzAZMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAvBgkqhkiG9w0BCQQxIgQgtePVcrPTdN4B2zzu1NMjhpTH6Oz2
Png0GbJBAQTHn+EwDQYJKoZIhvcNAQEBBQAEggEAkI7jgle+Uuh+zV8Ja4QY7/lsj5uxSpYAMXMo
vVmo2UMWP++6kugNXplPMYb+Vy8FGk3GtpeZT9XkJie47FxJTOMxkTOsDcwjSegL+GhwXr5X+GxS
RBDgWen/zntFkgUkY0sg6K9IF0IdA8lf78EGQirn/9wkp+w7+KUKhDpZlN4VqCXuI15q3DLBLcEW
R8oyycvcY3JB8AxqFTH3bJ3CH8JTzm9plzZJj4T7IS6wtRQGWQRBwuS/sqdv9/DzDt4n60SZ5ndT
4sUB74WPCTUwAx+b/UOASz6LYaw1KgxFFP5G0ejLIgHuAbb5IWaaO2R7njGnWwsiP7ypRT1wZLg3
CgAAAAAAAA==


--nextPart41825203.zCzliQ2AsB--
