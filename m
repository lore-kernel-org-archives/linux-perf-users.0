From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 40/41] perf test: Fix test case inet_pton to accept inlines.
Date: Fri, 16 Feb 2018 16:17:45 -0300
Message-ID: <20180216191746.11095-41-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Thomas Richter <tmricht@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

Using Fedora 27 and latest Linux kernel the test case
trace+probe_libc_inet_pton.sh fails again on s390.  This time is the
inlining of functions which does not match.  After an update of the
glibc (from 2.26-16 to 2.26-24) the output is different

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

Fix this by being less strict on 'inlined' verses library name and
accept both

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180214070303.55757-1-tmricht@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
