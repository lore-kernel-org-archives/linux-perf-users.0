From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/10] perf test shell: Replace '|&' with '2>&1 |' to work with more shells
Date: Wed, 16 Aug 2017 17:20:50 -0300
Message-ID: <20170816202050.8865-11-acme@kernel.org>
References: <20170816202050.8865-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170816202050.8865-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kim Phillips <kim.phillips@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kim Phillips <kim.phillips@arm.com>

Since we do not specify bash (and/or zsh) as a requirement, use the
standard error redirection that is more widely supported.

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Link: http://lkml.kernel.org/n/tip-ji5mhn3iilgch3eaay6csr6z@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/lib/probe.sh                  | 2 +-
 tools/perf/tests/shell/lib/probe_vfs_getname.sh      | 4 ++--
 tools/perf/tests/shell/trace+probe_libc_inet_pton.sh | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/lib/probe.sh b/tools/perf/tests/shell/lib/probe.sh
index 61da3b2c9bca..6293cc660947 100644
--- a/tools/perf/tests/shell/lib/probe.sh
+++ b/tools/perf/tests/shell/lib/probe.sh
@@ -1,6 +1,6 @@
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
 skip_if_no_perf_probe() {
-	perf probe |& grep -q 'is not a perf-command' && return 2
+	perf probe 2>&1 | grep -q 'is not a perf-command' && return 2
 	return 0
 }
diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index f832395daad7..30a950c9d407 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -1,6 +1,6 @@
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
-perf probe -l |& grep -q probe:vfs_getname
+perf probe -l 2>&1 | grep -q probe:vfs_getname
 had_vfs_getname=$?
 
 cleanup_probe_vfs_getname() {
@@ -12,7 +12,7 @@ cleanup_probe_vfs_getname() {
 add_probe_vfs_getname() {
 	local verbose=$1
 	if [ $had_vfs_getname -eq 1 ] ; then
-		line=$(perf probe -L getname_flags |& egrep 'result.*=.*filename;' | sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/')
+		line=$(perf probe -L getname_flags 2>&1 | egrep 'result.*=.*filename;' | sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/')
 		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=result->name:string"
 	fi
 }
diff --git a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
index 99dafad61954..462fc755092e 100755
--- a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
@@ -22,7 +22,7 @@ trace_libc_inet_pton_backtrace() {
 	expected[7]="getaddrinfo[[:space:]]\(/usr/lib.*/libc-[0-9]+\.[0-9]+\.so\)$"
 	expected[8]=".*\(.*/bin/ping.*\)$"
 
-	perf trace --no-syscalls -e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1 |& grep -v ^$ | while read line ; do
+	perf trace --no-syscalls -e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1 2>&1 | grep -v ^$ | while read line ; do
 		echo $line
 		echo "$line" | egrep -q "${expected[$idx]}"
 		if [ $? -ne 0 ] ; then
-- 
2.13.5
