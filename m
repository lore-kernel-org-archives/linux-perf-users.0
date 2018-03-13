From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 31/31] perf test: Fix exit code for record+probe_libc_inet_pton.sh
Date: Tue, 13 Mar 2018 09:05:08 -0300
Message-ID: <20180313120508.29327-32-acme@kernel.org>
References: <20180313120508.29327-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180313120508.29327-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sandipan Das <sandipan@linux.vnet.ibm.com>, Jiri Olsa <jolsa@kernel.org>, "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Sandipan Das <sandipan@linux.vnet.ibm.com>

This fixes record+probe_libc_inet_pton.sh from always exiting with code
0 and making the test pass even if the perf script output does not match
the expected pattern.

The issue can be observed if this test is run with the verbose flags as
shown below:

  60: probe libc's inet_pton & backtrace it with ping       :
  ...
  ping 19602 [006] 16988.413767: probe_libc:inet_pton: (7fff9a2c42e8)
  1842e8 __GI___inet_pton (/usr/lib64/libc-2.26.so)
  130db4 getaddrinfo (/usr/lib64/libc-2.26.so)

  FAIL: expected backtrace entry 3 ".*\(.*/bin/ping.*\)$" got ""
  test child finished with 0
  ...
  probe libc's inet_pton & backtrace it with ping: Ok

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Fixes: e07d585e2454 ("perf tests: Switch trace+probe_libc_inet_pton to use record")
Link: http://lkml.kernel.org/r/20180312124450.30371-1-sandipan@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 52c3ee701a89..1ecc1f0ff84a 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -47,7 +47,10 @@ trace_libc_inet_pton_backtrace() {
 		[ -z "${expected[$idx]}" ] && break
 	done
 
-	rm -f $file
+	# If any statements are executed from this point onwards,
+	# the exit code of the last among these will be reflected
+	# in err below. If the exit code is 0, the test will pass
+	# even if the perf script output does not match.
 }
 
 # Check for IPv6 interface existence
-- 
2.14.3
