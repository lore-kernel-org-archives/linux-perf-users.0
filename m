From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/27] perf tests: Fix record+probe_libc_inet_pton.sh to ensure cleanups
Date: Wed, 25 Jul 2018 14:59:48 -0300
Message-ID: <20180725180001.15108-15-acme@kernel.org>
References: <20180725180001.15108-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725180001.15108-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sandipan Das <sandipan@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Kim Phillips <kim.phillips@arm.com>, "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Sandipan Das <sandipan@linux.ibm.com>

If there is a mismatch in the perf script output, this test fails and
exits before the event and temporary files created during its execution
are cleaned up.

This can be observed on a powerpc64 system running Fedora 27 as shown
below.

  # perf test -v "probe libc's inet_pton & backtrace it with ping"

  62: probe libc's inet_pton & backtrace it with ping       :
  --- start ---
  test child forked, pid 18655
  ping 18674 [013] 24511.496995: probe_libc:inet_pton: (7fffa6b423b0)
  7fffa6b423b0 __GI___inet_pton+0x0 (/usr/lib64/power8/libc-2.26.so)
  7fffa6af90dc gaih_inet.constprop.7+0xf4c (/usr/lib64/power8/libc-2.26.so)
  FAIL: expected backtrace entry "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\(/usr/lib64/power8/libc-2.26.so\)$" got "7fffa6af90dc gaih_inet.constprop.7+0xf4c (/usr/lib64/power8/libc-2.26.so)"
  test child finished with -1
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: FAILED!

  # ls /tmp/expected.* /tmp/perf.data.* /tmp/perf.script.*

  /tmp/expected.u31  /tmp/perf.data.Pki  /tmp/perf.script.Bhs

  # perf probe --list

    probe_libc:inet_pton (on __inet_pton@resolv/inet_pton.c in /usr/lib64/power8/libc-2.26.so)

Cleanup of the event and the temporary files are now ensured by allowing
the cleanup code to be executed even if the lines from the backtrace do
not match their expected patterns instead of simply exiting from the
point of failure.

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/ce9fb091dd3028fba8749a1a267cfbcb264bbfb1.1530724939.git.sandipan@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 1220e5e052bb..0502a9e04c79 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -52,7 +52,7 @@ trace_libc_inet_pton_backtrace() {
 		echo "$line" | egrep -q "$pattern"
 		if [ $? -ne 0 ] ; then
 			printf "FAIL: expected backtrace entry \"%s\" got \"%s\"\n" "$pattern" "$line"
-			exit 1
+			return 1
 		fi
 	done
 
-- 
2.14.4
