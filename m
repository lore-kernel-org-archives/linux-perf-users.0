From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 8/8] perf test shell trace+probe_libc_inet_pton.sh: Be compatible with Debian/Ubuntu
Date: Thu, 19 Oct 2017 14:45:15 -0300
Message-ID: <20171019174515.7407-9-acme@kernel.org>
References: <20171019174515.7407-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171019174515.7407-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Li Zhijian <lizhijian@cn.fujitsu.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kim Phillips <kim.phillips@arm.com>, Peter Zijlstra <peterz@infradead.org>, Philip Li <philip.li@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Li Zhijian <lizhijian@cn.fujitsu.com>

In debian/ubuntu, libc.so is located at a different place,
/lib/x86_64-linux-gnu/libc-2.23.so, so it outputs like this when testing:

  PING ::1(::1) 56 data bytes
  64 bytes from ::1: icmp_seq=1 ttl=64 time=0.040 ms

  --- ::1 ping statistics ---
  1 packets transmitted, 1 received, 0% packet loss, time 0ms
  rtt min/avg/max/mdev = 0.040/0.040/0.040/0.000 ms
  0.000 probe_libc:inet_pton:(7f0e2db741c0))
  __GI___inet_pton (/lib/x86_64-linux-gnu/libc-2.23.so)
  getaddrinfo (/lib/x86_64-linux-gnu/libc-2.23.so)
  [0xffffa9d40f34ff4d] (/bin/ping)

Fix up the libc path to make sure this test works in more OSes.

Committer testing:

When this test fails one can use 'perf test -v', i.e. in verbose mode, where
it'll show the expected backtrace, so, after applying this test:

On Fedora 26:

  # perf test -v ping
  62: probe libc's inet_pton & backtrace it with ping       :
  --- start ---
  test child forked, pid 23322
  PING ::1(::1) 56 data bytes
  64 bytes from ::1: icmp_seq=1 ttl=64 time=0.058 ms
  --- ::1 ping statistics ---
  1 packets transmitted, 1 received, 0% packet loss, time 0ms
  rtt min/avg/max/mdev = 0.058/0.058/0.058/0.000 ms
  0.000 probe_libc:inet_pton:(7fe344310d80))
  __GI___inet_pton (/usr/lib64/libc-2.25.so)
  getaddrinfo (/usr/lib64/libc-2.25.so)
  _init (/usr/bin/ping)
  test child finished with 0
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: Ok
  #

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Philip Li <philip.li@intel.com>
Link: http://lkml.kernel.org/r/1508315649-18836-1-git-send-email-lizhijian@cn.fujitsu.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/trace+probe_libc_inet_pton.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
index 462fc755092e..7a84d73324e3 100755
--- a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
@@ -10,6 +10,9 @@
 
 . $(dirname $0)/lib/probe.sh
 
+ld=$(realpath /lib64/ld*.so.* | uniq)
+libc=$(echo $ld | sed 's/ld/libc/g')
+
 trace_libc_inet_pton_backtrace() {
 	idx=0
 	expected[0]="PING.*bytes"
@@ -18,8 +21,8 @@ trace_libc_inet_pton_backtrace() {
 	expected[3]=".*packets transmitted.*"
 	expected[4]="rtt min.*"
 	expected[5]="[0-9]+\.[0-9]+[[:space:]]+probe_libc:inet_pton:\([[:xdigit:]]+\)"
-	expected[6]=".*inet_pton[[:space:]]\(/usr/lib.*/libc-[0-9]+\.[0-9]+\.so\)$"
-	expected[7]="getaddrinfo[[:space:]]\(/usr/lib.*/libc-[0-9]+\.[0-9]+\.so\)$"
+	expected[6]=".*inet_pton[[:space:]]\($libc\)$"
+	expected[7]="getaddrinfo[[:space:]]\($libc\)$"
 	expected[8]=".*\(.*/bin/ping.*\)$"
 
 	perf trace --no-syscalls -e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1 2>&1 | grep -v ^$ | while read line ; do
@@ -35,7 +38,7 @@ trace_libc_inet_pton_backtrace() {
 }
 
 skip_if_no_perf_probe && \
-perf probe -q /lib64/libc-*.so inet_pton && \
+perf probe -q $libc inet_pton && \
 trace_libc_inet_pton_backtrace
 err=$?
 rm -f ${file}
-- 
2.13.6
