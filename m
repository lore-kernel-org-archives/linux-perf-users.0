From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH] perf test: Fix test trace+probe_libc_inet_pton.sh for s390x
Date: Wed, 17 Jan 2018 09:38:31 +0100
Message-ID: <20180117083831.101001-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45476 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750931AbeAQIii (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 Jan 2018 03:38:38 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0H8YXnT090646
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jan 2018 03:38:38 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fj0s1wxh2-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jan 2018 03:38:37 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Wed, 17 Jan 2018 08:38:35 -0000
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>

On Intel test case trace+probe_libc_inet_pton.sh succeeds and the
output is:
[root@f27 perf]# ./perf trace --no-syscalls
                  -e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.037 ms

 --- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.037/0.037/0.037/0.000 ms
     0.000 probe_libc:inet_pton:(7fa40ac618a0))
              __GI___inet_pton (/usr/lib64/libc-2.26.so)
              getaddrinfo (/usr/lib64/libc-2.26.so)
              main (/usr/bin/ping)

The kernel stack unwinder is used, it is specified implicitly
as call-graph=fp (frame pointer).

On s390x only dwarf is available for stack unwinding. It is also
done in user space. This requires different parameter setup
and result checking for s390x and Intel.

This patch adds separate perf trace setup and result checking
for Intel and s390x. On s390x specify this command line to
get a call-graph and handle the different call graph result
checking:

[root@s35lp76 perf]# ./perf trace --no-syscalls
	-e probe_libc:inet_pton/call-graph=dwarf/ ping -6 -c 1 ::1
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.041 ms

 --- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.041/0.041/0.041/0.000 ms
     0.000 probe_libc:inet_pton:(3ffb9942060))
            __GI___inet_pton (/usr/lib64/libc-2.26.so)
            gaih_inet (inlined)
            __GI_getaddrinfo (inlined)
            main (/usr/bin/ping)
            __libc_start_main (/usr/lib64/libc-2.26.so)
            _start (/usr/bin/ping)
[root@s35lp76 perf]#

Before:
[root@s8360047 perf]# ./perf test -vv 58
58: probe libc's inet_pton & backtrace it with ping       :
 --- start ---
test child forked, pid 26349
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.079 ms
 --- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.079/0.079/0.079/0.000 ms
0.000 probe_libc:inet_pton:(3ff925c2060))
test child finished with -1
 ---- end ----
probe libc's inet_pton & backtrace it with ping: FAILED!
[root@s8360047 perf]#

After:
[root@s35lp76 perf]# ./perf test -vv 57
57: probe libc's inet_pton & backtrace it with ping       :
 --- start ---
test child forked, pid 38708
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.038 ms
 --- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.038/0.038/0.038/0.000 ms
0.000 probe_libc:inet_pton:(3ff87342060))
__GI___inet_pton (/usr/lib64/libc-2.26.so)
gaih_inet (inlined)
__GI_getaddrinfo (inlined)
main (/usr/bin/ping)
__libc_start_main (/usr/lib64/libc-2.26.so)
_start (/usr/bin/ping)
test child finished with 0
 ---- end ----
probe libc's inet_pton & backtrace it with ping: Ok
[root@s35lp76 perf]#

On Intel the test case runs unchanged and succeeds.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 .../perf/tests/shell/trace+probe_libc_inet_pton.sh | 23 +++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
index 8b3da21a08f1..c446c894b297 100755
--- a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
@@ -22,10 +22,23 @@ trace_libc_inet_pton_backtrace() {
 	expected[4]="rtt min.*"
 	expected[5]="[0-9]+\.[0-9]+[[:space:]]+probe_libc:inet_pton:\([[:xdigit:]]+\)"
 	expected[6]=".*inet_pton[[:space:]]\($libc\)$"
-	expected[7]="getaddrinfo[[:space:]]\($libc\)$"
-	expected[8]=".*\(.*/bin/ping.*\)$"
-
-	perf trace --no-syscalls -e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1 2>&1 | grep -v ^$ | while read line ; do
+	case "$(uname -m)" in
+	s390x)
+		eventattr='call-graph=dwarf'
+		expected[7]="gaih_inet[[:space:]]\(inlined\)$"
+		expected[8]="__GI_getaddrinfo[[:space:]]\(inlined\)$"
+		expected[9]="main[[:space:]]\(.*/bin/ping.*\)$"
+		expected[10]="__libc_start_main[[:space:]]\($libc\)$"
+		expected[11]="_start[[:space:]]\(.*/bin/ping.*\)$"
+		;;
+	*)
+		eventattr='max-stack=3'
+		expected[7]="getaddrinfo[[:space:]]\($libc\)$"
+		expected[8]=".*\(.*/bin/ping.*\)$"
+		;;
+	esac
+
+	perf trace --no-syscalls -e probe_libc:inet_pton/$eventattr/ ping -6 -c 1 ::1 2>&1 | grep -v ^$ | while read line ; do
 		echo $line
 		echo "$line" | egrep -q "${expected[$idx]}"
 		if [ $? -ne 0 ] ; then
@@ -33,7 +46,7 @@ trace_libc_inet_pton_backtrace() {
 			exit 1
 		fi
 		let idx+=1
-		[ $idx -eq 9 ] && break
+		[ -z "${expected[$idx]}" ] && break
 	done
 }
 
-- 
2.13.4
