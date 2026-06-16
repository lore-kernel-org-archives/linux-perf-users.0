Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C54F37C90E
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573280; cv=none; b=ST+/8vq18m4AvMDQBxvRLdrQgtdgfQd2kB/JmEOQndacW6jWzywO/oN00inkFU/BlqABqT+K0VwCdB2DCBRAUDcGdW6XCYQz9aNZ1qNFLI8IOt159ISsVzVvd4q8SezoyNrf+1kZUsWjvIvf/Yg/8mSaY7Nv1Kx7UJGbFxRz7Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573280; c=relaxed/simple;
	bh=XcN+yl9o9wUK47YzIl0Dq/Q7Su0ogAF+EWtd/BVhvBg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=XtlDYn3x4Q22NVa+zbR6iDaodI6J6c44hgRHvCmS/lc6nlAElGFOvQZGVPpbkifqVER9WSxrXI/pGl0jUpURied2TqLsnDMc3xijAzsZOavigNMV7Ixtdnh7FFbf4Xxncli91gbWjMMZvDGex4mzoqEx/VQCnfRV94RKF/J/+aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G1uNhJgL; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G1uNhJgL"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304f1820babso6037370eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781573277; x=1782178077; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4zxVbTeOnm6KFTIPRllsAmeRwi0sPNTZGv5a6PFb3Ss=;
        b=G1uNhJgL1rPAynXF7j4i+1Ju27PHaL3FxXnmwFfEoboLR4G+u2Ca9vHyrbvC1Kw370
         0V74h5hALggNyfsoyHD48T7gVt1Q5DTo/f2uSZfnapKyM5tEFT7EcFjXD7pcoGv0/kzW
         +qCtbKpJQqX+mrD6K+0C5wIW8cMkBdy4faErkeZpZvPaRdcx+Z4CXRCK8wnBo4HOiDw3
         hsw2fawT7VJ0dRYYS28ISeFxJAfkPv5U2oi70lHIHkZMb2t7V5hHDCHxkWvLKnlJnNFH
         X1J9RZxp4+pZ7Ed0yNQOlv2QGBn3/hfpl4+9TIgOmnoRcflLcmd8TXGEs8/OpcQylZDg
         BAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781573277; x=1782178077;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4zxVbTeOnm6KFTIPRllsAmeRwi0sPNTZGv5a6PFb3Ss=;
        b=kWsztKk6ucw/NMcBmJwnUZFGUfJIRpVVtMjL1sMugiYMvqGvWwGpbtTMLcAz/bpfMM
         8o62ZOXj5O9i3k+AInYEqPjkqXaWK5pRJiibcHLtIvUwDCP3RiYD6Dp7HA5iTYz0ayLS
         dKbnsfZtNIrHcJxa0vgxWswoDc2uj+XWfa0m6ZL9siWYVHkMqVeNOA9JxVYyXvpSqRyz
         BL0jHhfjeXBXhBydhDwK0qHU0w5BsjGV2Qa9NDsaRb/GBwBex9KS+hKfBLlerF+l3qPI
         /92rI8cRKZZJw9FNHwIZUc1A2ULiYQAhjPrTnT39UkUBUVMd23U0gs9NBYGhLe+VWuyk
         uDAA==
X-Forwarded-Encrypted: i=1; AFNElJ/W7HhYGpZUIOq1QCBaB3eaK2TJ4MUx8YEsxi0iwQ9eF2Gv3QTeNCrcl1veNHQL4xPnwiOrVmnA67JTL8uAS3qf@vger.kernel.org
X-Gm-Message-State: AOJu0YzwAfujaFrE45a2CwDAQBOOtY0p9YpjzENdqzGR7cLAFD7ynZEG
	7CmnRXAfpwc9BslTFT6mzWZTUqRyPRvaIh2KFZ0p9v/I25UNrQFrL/S6YuPljjY3Zm+AFfwuXeV
	rBhrXscHsrA==
X-Received: from dybmj45.prod.google.com ([2002:a05:7301:e2d:b0:304:e5db:c51d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:1893:b0:307:d4e7:b177
 with SMTP id 5a478bee46e88-30ba5f126b9mr950644eec.16.1781573276271; Mon, 15
 Jun 2026 18:27:56 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:27:36 -0700
In-Reply-To: <20260616012744.4049193-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616012744.4049193-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616012744.4049193-5-irogers@google.com>
Subject: [PATCH v1 04/12] perf tests: Add robust record retry helper and use
 subsecond workloads
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Leo Yan <leo.yan@arm.com>, Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce `perf_record_with_retry` and `perf_record_cleanup` in a shared
library `tests/shell/lib/perf_record.sh` to prevent record test failures
caused by transient recording or workload delays.

Update `record.sh`, `record_lbr.sh`, `pipe_test.sh`, `kvm.sh`, and
`stat_all_pfm.sh` to use this robust record retry logic. These tests now
start with very short durations (e.g. 0.01 seconds) and scale up if the
initial recording failed to capture samples, significantly improving test
execution speed on success while remaining resilient to slow systems.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/kvm.sh             |  61 +++++---
 tools/perf/tests/shell/lib/perf_record.sh |  47 ++++++
 tools/perf/tests/shell/pipe_test.sh       |   4 +-
 tools/perf/tests/shell/record.sh          | 172 +++++++++++-----------
 tools/perf/tests/shell/record_lbr.sh      |  50 +++++--
 tools/perf/tests/shell/stat_all_pfm.sh    |   2 +-
 6 files changed, 208 insertions(+), 128 deletions(-)
 create mode 100644 tools/perf/tests/shell/lib/perf_record.sh

diff --git a/tools/perf/tests/shell/kvm.sh b/tools/perf/tests/shell/kvm.sh
index f88e859025c4..255250ddba5c 100755
--- a/tools/perf/tests/shell/kvm.sh
+++ b/tools/perf/tests/shell/kvm.sh
@@ -39,17 +39,26 @@ skip() {
 test_kvm_stat() {
 	echo "Testing perf kvm stat"
 
-	echo "Recording kvm events for pid ${qemu_pid}..."
-	if ! perf kvm stat record -p "${qemu_pid}" -o "${perfdata}" sleep 1; then
-		echo "Failed to record kvm events"
-		err=1
-		return
-	fi
+	local duration
+	local success=false
+	for duration in 1 2 4 8; do
+		echo "Recording kvm events for pid ${qemu_pid} (duration ${duration}s)..."
+		rm -f "${perfdata}" "${perfdata}".old
+		if ! perf kvm stat record -p "${qemu_pid}" -o "${perfdata}" sleep ${duration} >/dev/null 2>&1; then
+			echo "perf kvm stat record failed, retrying..."
+			continue
+		fi
 
-	echo "Reporting kvm events..."
-	if ! perf kvm -i "${perfdata}" stat report 2>&1 | grep -q "VM-EXIT"; then
+		if [ -e "${perfdata}" ] && perf kvm -i "${perfdata}" stat report 2>&1 | grep -q "VM-EXIT"; then
+			success=true
+			break
+		fi
+		echo "No VM-EXIT events found, retrying..."
+	done
+
+	if [ "$success" = false ]; then
 		echo "Failed to find VM-EXIT in report"
-		perf kvm -i "${perfdata}" stat report 2>&1
+		perf kvm -i "${perfdata}" stat report 2>&1 || true
 		err=1
 		return
 	fi
@@ -60,22 +69,28 @@ test_kvm_stat() {
 test_kvm_record_report() {
 	echo "Testing perf kvm record/report"
 
-	echo "Recording kvm profile for pid ${qemu_pid}..."
-	# Use --host to avoid needing guest symbols/mounts for this simple test
-	# We just want to verify the command runs and produces data
-	# We run in background and kill it because 'perf kvm record' appends options
-	# after the command, which breaks 'sleep' (e.g. it gets '-e cycles').
-	perf kvm --host record -p "${qemu_pid}" -o "${perfdata}" &
-	rec_pid=$!
-	sleep 1
-	kill -INT "${rec_pid}"
-	wait "${rec_pid}" || true
+	local duration
+	local success=false
+	for duration in 1 2 4 8; do
+		echo "Recording kvm profile for pid ${qemu_pid} (duration ${duration}s)..."
+		rm -f "${perfdata}" "${perfdata}".old
+
+		perf kvm --host record -p "${qemu_pid}" -o "${perfdata}" &
+		local rec_pid=$!
+		sleep ${duration}
+		kill -INT "${rec_pid}"
+		wait "${rec_pid}" || true
+
+		if [ -e "${perfdata}" ] && perf kvm -i "${perfdata}" report --stdio 2>&1 | grep -q "Event count"; then
+			success=true
+			break
+		fi
+		echo "No samples or report failed, retrying..."
+	done
 
-	echo "Reporting kvm profile..."
-	# Check for some standard output from report
-	if ! perf kvm -i "${perfdata}" report --stdio 2>&1 | grep -q "Event count"; then
+	if [ "$success" = false ]; then
 		echo "Failed to report kvm profile"
-		perf kvm -i "${perfdata}" report --stdio 2>&1
+		perf kvm -i "${perfdata}" report --stdio 2>&1 || true
 		err=1
 		return
 	fi
diff --git a/tools/perf/tests/shell/lib/perf_record.sh b/tools/perf/tests/shell/lib/perf_record.sh
new file mode 100644
index 000000000000..c5de25244770
--- /dev/null
+++ b/tools/perf/tests/shell/lib/perf_record.sh
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0
+
+perf_record_with_retry() {
+  local perfdata="$1"
+  local check_cmd="$2"
+  local testprog_base="$3"
+  shift 3
+
+  local logfile
+  logfile="/tmp/__perf_record_retry.$(id -u).$BASHPID.log"
+
+  # Save the e flag state and disable it
+  local save_e
+  if [[ $- == *e* ]]; then
+    save_e="set -e"
+  else
+    save_e="set +e"
+  fi
+  set +e
+
+  local duration
+  local first_run=true
+  local ret=1
+  for duration in 0.01 0.1 0.3 1.0 2.0; do
+    rm -f "${perfdata}" "${perfdata}".old
+    perf record "$@" -o "${perfdata}" ${testprog_base} ${duration} > "$logfile" 2>&1
+    local record_exit=$?
+
+    if [ "$first_run" = true ] && [ $record_exit -ne 0 ]; then
+      ret=2
+      break
+    fi
+    first_run=false
+
+    if [ -e "${perfdata}" ] && eval "${check_cmd}"; then
+      ret=0
+      break
+    fi
+  done
+
+  eval "$save_e"
+  return $ret
+}
+
+perf_record_cleanup() {
+  rm -f /tmp/__perf_record_retry.$(id -u).$BASHPID.log
+}
diff --git a/tools/perf/tests/shell/pipe_test.sh b/tools/perf/tests/shell/pipe_test.sh
index e459aa99a951..ce68d850c983 100755
--- a/tools/perf/tests/shell/pipe_test.sh
+++ b/tools/perf/tests/shell/pipe_test.sh
@@ -12,8 +12,8 @@ skip_test_missing_symbol ${sym}
 
 data=$(mktemp /tmp/perf.data.XXXXXX)
 data2=$(mktemp /tmp/perf.data2.XXXXXX)
-prog="perf test -w noploop"
-[ "$(uname -m)" = "s390x" ] && prog="$prog 3"
+prog="perf test -w noploop 0.1"
+[ "$(uname -m)" = "s390x" ] && prog="perf test -w noploop 3"
 err=0
 
 set -e
diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 7cb81cf3444a..382e7ee02eb8 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -1,10 +1,13 @@
 #!/bin/bash
-# perf record tests (exclusive)
+# perf record tests
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
 
 shelldir=$(dirname "$0")
+. "${shelldir}"/lib/perf_record.sh
+
+
 # shellcheck source=lib/waiting.sh
 . "${shelldir}"/lib/waiting.sh
 
@@ -39,6 +42,7 @@ cleanup() {
   rm -f "${perfdata}"
   rm -f "${perfdata}".old
   rm -f "${script_output}"
+  perf_record_cleanup
 
   trap - EXIT TERM INT
 }
@@ -50,22 +54,19 @@ trap_cleanup() {
 }
 trap trap_cleanup EXIT TERM INT
 
+check_per_thread() {
+  perf report -i "${perfdata}" -q | grep -q "${testsym}"
+}
+
 test_per_thread() {
   echo "Basic --per-thread mode test"
-  if ! perf record -o /dev/null --quiet ${testprog} 2> /dev/null
-  then
+  local ret=0
+  perf_record_with_retry "${perfdata}" "check_per_thread" "perf test -w thloop" --per-thread || ret=$?
+  if [ $ret -eq 2 ]; then
     echo "Per-thread record [Skipped event not supported]"
     return
-  fi
-  if ! perf record --per-thread -o "${perfdata}" ${testprog} 2> /dev/null
-  then
-    echo "Per-thread record [Failed record]"
-    err=1
-    return
-  fi
-  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
-  then
-    echo "Per-thread record [Failed missing output]"
+  elif [ $ret -eq 1 ]; then
+    echo "Per-thread record [Failed record or missing output]"
     err=1
     return
   fi
@@ -96,6 +97,10 @@ test_per_thread() {
   echo "Basic --per-thread mode test [Success]"
 }
 
+check_register_capture() {
+  perf script -F ip,sym,iregs -i "${perfdata}" 2>/dev/null | grep -q "DI:"
+}
+
 test_register_capture() {
   echo "Register capture test"
   if ! perf list pmu | grep -q 'br_inst_retired.near_call'
@@ -108,11 +113,12 @@ test_register_capture() {
     echo "Register capture test [Skipped missing registers]"
     return
   fi
-  if ! perf record -o - --intr-regs=di,r8,dx,cx -e br_inst_retired.near_call \
-    -c 1000 --per-thread ${testprog} 2> /dev/null \
-    | perf script -F ip,sym,iregs -i - 2> /dev/null \
-    | grep -q "DI:"
-  then
+
+  local ret=0
+  perf_record_with_retry "${perfdata}" "check_register_capture" "perf test -w thloop" \
+    --intr-regs=di,r8,dx,cx -e br_inst_retired.near_call -c 1000 --per-thread || ret=$?
+
+  if [ $ret -ne 0 ]; then
     echo "Register capture test [Failed missing output]"
     err=1
     return
@@ -120,65 +126,65 @@ test_register_capture() {
   echo "Register capture test [Success]"
 }
 
+check_system_wide() {
+  perf report -i "${perfdata}" -q | grep -q "${testsym}"
+}
+
 test_system_wide() {
   echo "Basic --system-wide mode test"
-  if ! perf record -aB --synth=no -o "${perfdata}" ${testprog} 2> /dev/null
-  then
+  local ret=0
+  perf_record_with_retry "${perfdata}" "check_system_wide" "perf test -w thloop" -aB --synth=no || ret=$?
+  if [ $ret -eq 2 ]; then
     echo "System-wide record [Skipped not supported]"
     return
-  fi
-  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
-  then
+  elif [ $ret -eq 1 ]; then
     echo "System-wide record [Failed missing output]"
     err=1
     return
   fi
-  if ! perf record -aB --synth=no -e cpu-clock,cs --threads=cpu \
-    -o "${perfdata}" ${testprog} 2> /dev/null
-  then
-    echo "System-wide record [Failed record --threads option]"
-    err=1
-    return
-  fi
-  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
-  then
-    echo "System-wide record [Failed --threads missing output]"
+
+  ret=0
+  perf_record_with_retry "${perfdata}" "check_system_wide" "perf test -w thloop" \
+    -aB --synth=no -e cpu-clock,cs --threads=cpu || ret=$?
+  if [ $ret -ne 0 ]; then
+    echo "System-wide record [Failed record --threads option or missing output]"
     err=1
     return
   fi
   echo "Basic --system-wide mode test [Success]"
 }
 
+check_workload() {
+  perf report -i "${perfdata}" -q | grep -q "${testsym}"
+}
+
 test_workload() {
   echo "Basic target workload test"
-  if ! perf record -o "${perfdata}" ${testprog} 2> /dev/null
-  then
-    echo "Workload record [Failed record]"
+  local ret=0
+  perf_record_with_retry "${perfdata}" "check_workload" "perf test -w thloop" || ret=$?
+  if [ $ret -ne 0 ]; then
+    echo "Workload record [Failed record or missing output]"
     err=1
     return
   fi
-  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
-  then
-    echo "Workload record [Failed missing output]"
-    err=1
-    return
-  fi
-  if ! perf record -e cpu-clock,cs --threads=package \
-    -o "${perfdata}" ${testprog} 2> /dev/null
-  then
-    echo "Workload record [Failed record --threads option]"
-    err=1
-    return
-  fi
-  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
-  then
-    echo "Workload record [Failed --threads missing output]"
+
+  ret=0
+  perf_record_with_retry "${perfdata}" "check_workload" "perf test -w thloop" \
+    -e cpu-clock,cs --threads=package || ret=$?
+  if [ $ret -ne 0 ]; then
+    echo "Workload record [Failed record --threads option or missing output]"
     err=1
     return
   fi
   echo "Basic target workload test [Success]"
 }
 
+check_branch_counter() {
+  perf report -i "${perfdata}" -D -q 2>/dev/null | grep -q "$br_cntr_output" && \
+  perf script -i "${perfdata}" -F +brstackinsn,+brcntr 2>/dev/null | \
+    grep -q "$br_cntr_script_output"
+}
+
 test_branch_counter() {
   echo "Branch counter test"
   # Check if the branch counter feature is supported
@@ -190,67 +196,61 @@ test_branch_counter() {
       return
     fi
   done
-  if ! perf record -o "${perfdata}" -e "{branches:p,instructions}" -j any,counter ${testprog} 2> /dev/null
-  then
-    echo "Branch counter record test [Failed record]"
-    err=1
-    return
-  fi
-  if ! perf report -i "${perfdata}" -D -q | grep -q "$br_cntr_output"
-  then
-    echo "Branch counter report test [Failed missing output]"
-    err=1
-    return
-  fi
-  if ! perf script -i "${perfdata}" -F +brstackinsn,+brcntr | grep -q "$br_cntr_script_output"
-  then
-    echo " Branch counter script test [Failed missing output]"
+  local ret=0
+  perf_record_with_retry "${perfdata}" "check_branch_counter" "perf test -w thloop" \
+    -e "{branches:p,instructions}" -j any,counter || ret=$?
+  if [ $ret -ne 0 ]; then
+    echo "Branch counter test [Failed record or missing output]"
     err=1
     return
   fi
   echo "Branch counter test [Success]"
 }
 
+check_cgroup() {
+  perf report -i "${perfdata}" -D 2>/dev/null | grep -q "CGROUP" && \
+  perf script -i "${perfdata}" -F cgroup 2>/dev/null | grep -q -v "unknown"
+}
+
 test_cgroup() {
   echo "Cgroup sampling test"
-  if ! perf record -aB --synth=cgroup --all-cgroups -o "${perfdata}" ${testprog} 2> /dev/null
-  then
+  local ret=0
+  perf_record_with_retry "${perfdata}" "check_cgroup" "perf test -w thloop" \
+    -aB --synth=cgroup --all-cgroups || ret=$?
+  if [ $ret -eq 2 ]; then
     echo "Cgroup sampling [Skipped not supported]"
     return
-  fi
-  if ! perf report -i "${perfdata}" -D | grep -q "CGROUP"
-  then
+  elif [ $ret -eq 1 ]; then
     echo "Cgroup sampling [Failed missing output]"
     err=1
     return
   fi
-  if ! perf script -i "${perfdata}" -F cgroup | grep -q -v "unknown"
-  then
-    echo "Cgroup sampling [Failed cannot resolve cgroup names]"
-    err=1
-    return
-  fi
   echo "Cgroup sampling test [Success]"
 }
 
+check_uid() {
+  perf report -i "${perfdata}" -q | grep -q "${testsym}"
+}
+
 test_uid() {
   echo "Uid sampling test"
-  if ! perf record -aB --synth=no --uid "$(id -u)" -o "${perfdata}" ${testprog} \
-    > "${script_output}" 2>&1
-  then
-    if grep -q "libbpf.*EPERM" "${script_output}"
+  local logfile
+  logfile="/tmp/__perf_record_retry.$(id -u).$BASHPID.log"
+  local ret=0
+  perf_record_with_retry "${perfdata}" "check_uid" "perf test -w thloop" \
+    -aB --synth=no --uid "$(id -u)" || ret=$?
+  if [ $ret -eq 2 ]; then
+    if grep -q -E "libbpf.*EPERM|Access to performance monitoring|Permission denied|Failure to open any events" \
+      "$logfile"
     then
       echo "Uid sampling [Skipped permissions]"
       return
     else
       echo "Uid sampling [Failed to record]"
       err=1
-      # cat "${script_output}"
       return
     fi
-  fi
-  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
-  then
+  elif [ $ret -eq 1 ]; then
     echo "Uid sampling [Failed missing output]"
     err=1
     return
diff --git a/tools/perf/tests/shell/record_lbr.sh b/tools/perf/tests/shell/record_lbr.sh
index 78a02e90ece1..78899a54589c 100755
--- a/tools/perf/tests/shell/record_lbr.sh
+++ b/tools/perf/tests/shell/record_lbr.sh
@@ -1,9 +1,12 @@
 #!/bin/bash
-# perf record LBR tests (exclusive)
+# perf record LBR tests
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
 
+shelldir=$(dirname "$0")
+. "${shelldir}"/lib/perf_record.sh
+
 ParanoidAndNotRoot() {
   [ "$(id -u)" != 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid)" -gt $1 ]
 }
@@ -22,6 +25,7 @@ cleanup() {
   rm -rf "${perfdata}"
   rm -rf "${perfdata}".old
   rm -rf "${perfdata}".txt
+  perf_record_cleanup
 
   trap - EXIT TERM INT
 }
@@ -34,22 +38,28 @@ trap_cleanup() {
 trap trap_cleanup EXIT TERM INT
 
 
+check_lbr_callgraph() {
+  perf report --stitch-lbr -i "${perfdata}" > "${perfdata}".txt 2>&1
+}
+
 lbr_callgraph_test() {
   test="LBR callgraph"
 
   echo "$test"
-  if ! perf record -e cycles --call-graph lbr -o "${perfdata}" perf test -w thloop
-  then
+  set +e
+  perf_record_with_retry "${perfdata}" "check_lbr_callgraph" "perf test -w thloop" \
+    -e cycles --call-graph lbr
+  local ret=$?
+  set -e
+
+  if [ $ret -eq 2 ]; then
     echo "$test [Failed support missing]"
     if [ $err -eq 0 ]
     then
       err=2
     fi
     return
-  fi
-
-  if ! perf report --stitch-lbr -i "${perfdata}" > "${perfdata}".txt
-  then
+  elif [ $ret -eq 1 ]; then
     cat "${perfdata}".txt
     echo "$test [Failed in perf report]"
     err=1
@@ -59,6 +69,12 @@ lbr_callgraph_test() {
   echo "$test [Success]"
 }
 
+check_lbr_samples() {
+  local out
+  out=$(perf report -D -i "${perfdata}" 2> /dev/null | grep -A1 'PERF_RECORD_SAMPLE')
+  [ "$(echo "$out" | grep -c 'PERF_RECORD_SAMPLE' || true)" -gt 0 ]
+}
+
 lbr_test() {
   local branch_flags=$1
   local test="LBR $2 test"
@@ -70,25 +86,27 @@ lbr_test() {
   local r
 
   echo "$test"
-  if ! perf record -e cycles $branch_flags -o "${perfdata}" perf test -w thloop
-  then
+  set +e
+  perf_record_with_retry "${perfdata}" "check_lbr_samples" "perf test -w thloop" \
+    -e cycles $branch_flags
+  local ret=$?
+  set -e
+
+  if [ $ret -eq 2 ]; then
     echo "$test [Failed support missing]"
-    perf record -e cycles $branch_flags -o "${perfdata}" perf test -w thloop || true
     if [ $err -eq 0 ]
     then
       err=2
     fi
     return
-  fi
-
-  out=$(perf report -D -i "${perfdata}" 2> /dev/null | grep -A1 'PERF_RECORD_SAMPLE')
-  sam_nr=$(echo "$out" | grep -c 'PERF_RECORD_SAMPLE' || true)
-  if [ $sam_nr -eq 0 ]
-  then
+  elif [ $ret -eq 1 ]; then
     echo "$test [Failed no samples captured]"
     err=1
     return
   fi
+
+  out=$(perf report -D -i "${perfdata}" 2> /dev/null | grep -A1 'PERF_RECORD_SAMPLE')
+  sam_nr=$(echo "$out" | grep -c 'PERF_RECORD_SAMPLE' || true)
   echo "$test: $sam_nr samples"
 
   bs_nr=$(echo "$out" | grep -c 'branch stack: nr:' || true)
diff --git a/tools/perf/tests/shell/stat_all_pfm.sh b/tools/perf/tests/shell/stat_all_pfm.sh
index c08c186af2c4..ec262c6b1674 100755
--- a/tools/perf/tests/shell/stat_all_pfm.sh
+++ b/tools/perf/tests/shell/stat_all_pfm.sh
@@ -32,7 +32,7 @@ do
   then
     # We failed to see the event and it is supported. Possibly the workload was
     # too small so retry with something longer.
-    result=$(perf stat --pfm-events "$p" perf bench internals synthesize 2>&1)
+    result=$(perf stat --pfm-events "$p" perf test -w noploop 0.1 2>&1)
     x=$?
     if test "$x" -ne "0"
     then
-- 
2.54.0.1136.gdb2ca164c4-goog

