From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf: test 60 fails on s390 inline missing on s390
Date: Thu,  3 May 2018 08:58:37 +0200
Message-ID: <20180503065837.71043-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

perf test 60: probe libc's inet_pton & backtrace it with ping
fails on 4.17.0rc3. It turned out that function __inet_pton
is reported as inline:

[root@s8360047 perf]# ./perf script -i /tmp/perf.data.111
ping 12457 [000]  1584.478959: probe_libc:inet_pton: (3ffb5a347e8)
                  1347e8 __inet_pton (inlined)
                   f19d7 gaih_inet.constprop.5 (/usr/lib64/libc-2.24.so)
                   f4c3f __GI_getaddrinfo (inlined)
                    410b main (/usr/bin/ping)

Allow __inet_pton listed as inline.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 016882d..ee86473 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -16,7 +16,7 @@ nm -g $libc 2>/dev/null | fgrep -q inet_pton || exit 254
 trace_libc_inet_pton_backtrace() {
 	idx=0
 	expected[0]="ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)"
-	expected[1]=".*inet_pton[[:space:]]\($libc\)$"
+	expected[1]=".*inet_pton[[:space:]]\($libc|inlined\)$"
 	case "$(uname -m)" in
 	s390x)
 		eventattr='call-graph=dwarf,max-stack=4'
-- 
2.9.3
