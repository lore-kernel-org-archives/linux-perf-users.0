From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/19] perf test shell: Add uprobes + backtrace ping test
Date: Mon, 14 Aug 2017 13:27:41 -0300
Message-ID: <20170814162741.6101-20-acme@kernel.org>
References: <20170814162741.6101-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170814162741.6101-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Installs a probe on libc's inet_pton function, that will use uprobes,
then use 'perf trace' on a ping to localhost asking for just one packet
with the a backtrace 3 levels deep, check that it is what we expect.
This needs no debuginfo package, all is done using the libc ELF symtab
and the CFI info in the binaries.

Testing it:

  # perf test ping
  61: probe libc's inet_pton & backtrace it with ping       : Ok

In verbose mode:

  # perf test -v ping
  61: probe libc's inet_pton & backtrace it with ping       :
  --- start ---
  test child forked, pid 1007
  PING ::1(::1) 56 data bytes
  64 bytes from ::1: icmp_seq=1 ttl=64 time=0.058 ms
  --- ::1 ping statistics ---
  1 packets transmitted, 1 received, 0% packet loss, time 0ms
  rtt min/avg/max/mdev = 0.058/0.058/0.058/0.000 ms
  0.000 probe_libc:inet_pton:(7f75fce12a20))
  __GI___inet_pton (/usr/lib64/libc-2.24.so)
  getaddrinfo (/usr/lib64/libc-2.24.so)
  _init (/usr/bin/ping)
  test child finished with 0
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: Ok
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-idrntt4nbg15aafu8hjmv7sk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/tests/shell/trace+probe_libc_inet_pton.sh | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100755 tools/perf/tests/shell/trace+probe_libc_inet_pton.sh

diff --git a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
new file mode 100755
index 000000000000..1b9a276e2ace
--- /dev/null
+++ b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
@@ -0,0 +1,40 @@
+# probe libc's inet_pton & backtrace it with ping
+
+# Installs a probe on libc's inet_pton function, that will use uprobes,
+# then use 'perf trace' on a ping to localhost asking for just one packet
+# with the a backtrace 3 levels deep, check that it is what we expect.
+# This needs no debuginfo package, all is done using the libc ELF symtab
+# and the CFI info in the binaries.
+
+# Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
+
+trace_libc_inet_pton_backtrace() {
+	idx=0
+	expected[0]="PING.*bytes"
+	expected[1]="64 bytes from ::1.*"
+	expected[2]=".*ping statistics.*"
+	expected[3]=".*packets transmitted.*"
+	expected[4]="rtt min.*"
+	expected[5]="[0-9]+\.[0-9]+[[:space:]]+probe_libc:inet_pton:\([[:xdigit:]]+\)"
+	expected[6]=".*inet_pton[[:space:]]\(/usr/lib.*/libc-[0-9]+\.[0-9]+\.so\)$"
+	expected[7]="getaddrinfo[[:space:]]\(/usr/lib.*/libc-[0-9]+\.[0-9]+\.so\)$"
+	expected[8]=".*\(.*/bin/ping.*\)$"
+
+	perf trace --no-syscalls -e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1 |& grep -v ^$ | while read line ; do
+		echo $line
+		echo "$line" | egrep -q "${expected[$idx]}"
+		if [ $? -ne 0 ] ; then
+			printf "FAIL: expected backtrace entry %d \"%s\" got \"%s\"\n" $idx "${expected[$idx]}" "$line"
+			exit 1
+		fi
+		let idx+=1
+		[ $idx -eq 9 ] && break
+	done
+}
+
+perf probe -q /lib64/libc-*.so inet_pton && \
+trace_libc_inet_pton_backtrace
+err=$?
+rm -f ${file}
+perf probe -q -d probe_libc:inet_pton
+exit $err
-- 
2.13.4
