From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH] perf test: Fix test case inet_pton to accept inlines.
Date: Wed, 14 Feb 2018 08:03:03 +0100
Message-ID: <20180214070303.55757-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754469AbeBNHD2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Feb 2018 02:03:28 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1E6wwnX069109
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Feb 2018 02:03:27 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2g4eshba2x-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Feb 2018 02:03:27 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Wed, 14 Feb 2018 07:03:26 -0000
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>

Using Fedora 27 and latest Linux kernel the test case
trace+probe_libc_inet_pton.sh fails again on s390.
This time is the inlining of functions which does not match.
After an update of the glibc (from 2.26-16 to 2.26-24)
the output is different

The expected output is:
           __inet_pton (/usr/lib64/libc-2.26.so)
           gaih_inet (inlined)
           ....

The actual output is:
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.061/0.061/0.061/0.000 ms
     0.000 probe_libc:inet_pton:(3ffb2140448))
           __inet_pton (inlined)
           gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
           ...

Fix this by being less strict on 'inlined' verses library
name and accept both

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 tools/perf/tests/shell/trace+probe_libc_inet_pton.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
index c446c894b297..8c4ab0b390c0 100755
--- a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
@@ -21,12 +21,12 @@ trace_libc_inet_pton_backtrace() {
 	expected[3]=".*packets transmitted.*"
 	expected[4]="rtt min.*"
 	expected[5]="[0-9]+\.[0-9]+[[:space:]]+probe_libc:inet_pton:\([[:xdigit:]]+\)"
-	expected[6]=".*inet_pton[[:space:]]\($libc\)$"
+	expected[6]=".*inet_pton[[:space:]]\($libc|inlined\)$"
 	case "$(uname -m)" in
 	s390x)
 		eventattr='call-graph=dwarf'
-		expected[7]="gaih_inet[[:space:]]\(inlined\)$"
-		expected[8]="__GI_getaddrinfo[[:space:]]\(inlined\)$"
+		expected[7]="gaih_inet.*[[:space:]]\($libc|inlined\)$"
+		expected[8]="__GI_getaddrinfo[[:space:]]\($libc|inlined\)$"
 		expected[9]="main[[:space:]]\(.*/bin/ping.*\)$"
 		expected[10]="__libc_start_main[[:space:]]\($libc\)$"
 		expected[11]="_start[[:space:]]\(.*/bin/ping.*\)$"
-- 
2.14.3
