Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C63170A37;
	Wed, 16 Oct 2024 06:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729061815; cv=none; b=ipKOYnFpaYmYQ6iS4BZt+WXZlPmzotq/pywkKnN6MCepfG6NBbysXobPxOcc6nV6gSu6vWJpMUUnWHjBJZue2tCUNQLy96HG1RAmZDHxWqBF850+BT3rTtewLVR+2wgLFyMHjBvta5w7TQvDvML7aCVlIbUbhhC3O24VGI+ksR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729061815; c=relaxed/simple;
	bh=67Lo5XWuBMF7Ka0ADi5GW/RvQSjy2I7Ba8q6tBW1DUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gepOozrWvWZYJnykiKJMXBeI9PlMBirdN2zeerPy5833/YzacqaYNnmU8dsvl8LABUnRm1FuyvxWmQ2kIIlGQyiKt3I2AVQ7XEGEHbKR0DhYOMWLNe8R2TANnGnDiaQYKf0POBLEb6MT5593bRHKsobjTpZynoPzfWxrC3/5pMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXEDOe0r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXEDOe0r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8430C4CEC5;
	Wed, 16 Oct 2024 06:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729061815;
	bh=67Lo5XWuBMF7Ka0ADi5GW/RvQSjy2I7Ba8q6tBW1DUo=;
	h=From:To:Cc:Subject:Date:From;
	b=eXEDOe0rgoY9xpwBoNmyk5+/AH5CT2frDv5ITkGgxoBKBKAOLMkT72jI3p96nrSR6
	 MoluXHpBjU+09J053pkrjDyYIQ2ft3odWhaLrnAzAX6OAwIXX6WktZJF8XT55G8mJP
	 nKsyuxpLfT65r4++IS8wVcf3JQ47Vuupzp6YBAQWmFK+txyC1vrmZ83O557I4D8sRP
	 tMhxnXUNuif1NAAdtn/p2a9cyQWez1i6e0bG/uLffLn5dwl3dLn1MxLnATXOymjBam
	 /hen14b0mqLmyJvwEOxD7CCx6UwC/4sO4yEBPnIMAemWvgXiOL0lTTE+IyN1ZX0mVh
	 mzVy+kTV1eGaA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	James Clark <james.clark@linaro.org>,
	Leo Yan <leo.yan@arm.com>,
	German Gomez <german.gomez@arm.com>,
	Carsten Haitzler <carsten.haitzler@arm.com>
Subject: [PATCH] perf test: Speed up some tests using perf list
Date: Tue, 15 Oct 2024 23:56:54 -0700
Message-ID: <20241016065654.269994-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On my system, perf list is very slow to print the whole events.  I think
there's a performance issue in SDT and uprobes event listing.  I noticed
this issue while running perf test on x86 but it takes long to check
some CoreSight event which should be skipped quickly.

Anyway, some test uses perf list to check whether the required event is
available before running the test.  The perf list command can take an
argument to specify event class or (glob) pattern.  But glob pattern is
only to suppress output for unmatched ones after checking all events.

In this case, specifying event class is better to reduce the number of
events it checks and to avoid buggy subsystems entirely.

No functional changes intended.

Cc: German Gomez <german.gomez@arm.com>
Cc: Carsten Haitzler <carsten.haitzler@arm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/lib/coresight.sh             | 2 +-
 tools/perf/tests/shell/lock_contention.sh           | 2 +-
 tools/perf/tests/shell/record.sh                    | 2 +-
 tools/perf/tests/shell/test_arm_coresight.sh        | 2 +-
 tools/perf/tests/shell/test_arm_coresight_disasm.sh | 2 +-
 tools/perf/tests/shell/test_arm_spe.sh              | 2 +-
 tools/perf/tests/shell/test_arm_spe_fork.sh         | 2 +-
 tools/perf/tests/shell/test_intel_pt.sh             | 2 +-
 tools/perf/tests/shell/trace+probe_vfs_getname.sh   | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/tests/shell/lib/coresight.sh b/tools/perf/tests/shell/lib/coresight.sh
index 11ed2c25ed912649..184d62e7e5bdf9f4 100644
--- a/tools/perf/tests/shell/lib/coresight.sh
+++ b/tools/perf/tests/shell/lib/coresight.sh
@@ -18,7 +18,7 @@ BIN="$DIR/$TEST"
 # If the test tool/binary does not exist and is executable then skip the test
 if ! test -x "$BIN"; then exit 2; fi
 # If CoreSight is not available, skip the test
-perf list cs_etm | grep -q cs_etm || exit 2
+perf list pmu | grep -q cs_etm || exit 2
 DATD="."
 # If the data dir env is set then make the data dir use that instead of ./
 if test -n "$PERF_TEST_CORESIGHT_DATADIR"; then
diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
index c1ec5762215ba430..30d195d4c62f74d0 100755
--- a/tools/perf/tests/shell/lock_contention.sh
+++ b/tools/perf/tests/shell/lock_contention.sh
@@ -27,7 +27,7 @@ check() {
 		exit
 	fi
 
-	if ! perf list | grep -q lock:contention_begin; then
+	if ! perf list tracepoint | grep -q lock:contention_begin; then
 		echo "[Skip] No lock contention tracepoints"
 		err=2
 		exit
diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 8d6366d96883edb3..3eee72242290d1fb 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -94,7 +94,7 @@ test_per_thread() {
 
 test_register_capture() {
   echo "Register capture test"
-  if ! perf list | grep -q 'br_inst_retired.near_call'
+  if ! perf list pmu | grep -q 'br_inst_retired.near_call'
   then
     echo "Register capture test [Skipped missing event]"
     return
diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
index 3302ea0b96723b1a..6b8c4831eedc6f10 100755
--- a/tools/perf/tests/shell/test_arm_coresight.sh
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -12,7 +12,7 @@
 glb_err=0
 
 skip_if_no_cs_etm_event() {
-	perf list | grep -q 'cs_etm//' && return 0
+	perf list pmu | grep -q 'cs_etm//' && return 0
 
 	# cs_etm event doesn't exist
 	return 2
diff --git a/tools/perf/tests/shell/test_arm_coresight_disasm.sh b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
index af63e3757cb0a930..dba086a40d846721 100755
--- a/tools/perf/tests/shell/test_arm_coresight_disasm.sh
+++ b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
@@ -8,7 +8,7 @@
 # the script. Test all 3 parts are working correctly by running the script.
 
 skip_if_no_cs_etm_event() {
-	perf list | grep -q 'cs_etm//' && return 0
+	perf list pmu | grep -q 'cs_etm//' && return 0
 
 	# cs_etm event doesn't exist
 	return 2
diff --git a/tools/perf/tests/shell/test_arm_spe.sh b/tools/perf/tests/shell/test_arm_spe.sh
index 03d5c7d12ee53d07..6c21fb1f10d8f129 100755
--- a/tools/perf/tests/shell/test_arm_spe.sh
+++ b/tools/perf/tests/shell/test_arm_spe.sh
@@ -9,7 +9,7 @@
 # German Gomez <german.gomez@arm.com>, 2021
 
 skip_if_no_arm_spe_event() {
-	perf list | grep -E -q 'arm_spe_[0-9]+//' && return 0
+	perf list pmu | grep -E -q 'arm_spe_[0-9]+//' && return 0
 
 	# arm_spe event doesn't exist
 	return 2
diff --git a/tools/perf/tests/shell/test_arm_spe_fork.sh b/tools/perf/tests/shell/test_arm_spe_fork.sh
index 1a7e6a82d0e34124..8efeef9fb9564a56 100755
--- a/tools/perf/tests/shell/test_arm_spe_fork.sh
+++ b/tools/perf/tests/shell/test_arm_spe_fork.sh
@@ -5,7 +5,7 @@
 # German Gomez <german.gomez@arm.com>, 2022
 
 skip_if_no_arm_spe_event() {
-	perf list | grep -E -q 'arm_spe_[0-9]+//' && return 0
+	perf list pmu | grep -E -q 'arm_spe_[0-9]+//' && return 0
 	return 2
 }
 
diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index 723ec501f99abe03..bf9017b812aa6ed9 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -5,7 +5,7 @@
 set -e
 
 # Skip if no Intel PT
-perf list | grep -q 'intel_pt//' || exit 2
+perf list pmu | grep -q 'intel_pt//' || exit 2
 
 shelldir=$(dirname "$0")
 # shellcheck source=lib/waiting.sh
diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 3146a1eece0789ae..97b4b9cd23784c89 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -19,7 +19,7 @@ skip_if_no_perf_trace || exit 2
 . "$(dirname $0)"/lib/probe_vfs_getname.sh
 
 trace_open_vfs_getname() {
-	evts="$(echo "$(perf list syscalls:sys_enter_open* 2>/dev/null | grep -E 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/')" | sed ':a;N;s:\n:,:g')"
+	evts="$(echo "$(perf list tracepoint 2>/dev/null | grep -E 'syscalls:sys_enter_open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/')" | sed ':a;N;s:\n:,:g')"
 	perf trace -e $evts touch $file 2>&1 | \
 	grep -E " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch/[0-9]+ open(at)?\((dfd: +CWD, +)?filename: +\"?${file}\"?, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
 }
-- 
2.47.0.rc1.288.g06298d1525-goog

