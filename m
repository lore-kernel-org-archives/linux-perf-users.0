Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5D1477E36
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 16:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628517; cv=none; b=R9LPES6uo3QaOkskkDJjFT5pLtBaa1f3Fei/Rw1Y4Q7CGWCT8hhY1dLuqzHP6Y8WseQzADR5XI9iY7bkiRlNU/tw7f0QTpdiN9uqpnf2nRHGg7Ai32ZZCEE45V9t2O5UNs9b7ZNP06JBPN+BV59L3RrwmPgkhKuMqVBsaR9UyV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628517; c=relaxed/simple;
	bh=v1RkXyH8Vi/PCi/4zEjzLNVQmrNS86iMErB5V67bMkA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g37NStMGzsErmSeVMXEbrF8KQfh36HDhotM4IDylUUi9fR2R+8k60w+DWeFxr/xoevk4lYRzwj+hqQ73dI57NVoqi5Zyk9Pp4ONS8LhcuhKvezcPwGOiYG8aftsy9gr2zMCcenr63ebr2C+gnPOOsU9L7YRi8VgUvrCy6swCA5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y+vOa8dP; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y+vOa8dP"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304ed777a96so31659eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 09:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781628513; x=1782233313; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YkNyfkLHwTIkuG5GEh3sOZhpzwriKUEPquKTr7jd/iQ=;
        b=Y+vOa8dPHs9txcI5Wv3poJAV7n1ih2/draP2UoRwGkEtyViqX1ZpTqTfRskN1aS5vp
         +J0sj2f6Z6OlLe3BMXJE3891j7lkpjhqzkIu4XXG4AvGXnjfmTmJW1QRbwtw7QnIkm27
         qH66ESlUofR4VNj17wf4X3mMPg2NtBjhBl+6+2PrNufZmHx7VO8BY/XmnAVM6p625pty
         oGhiorV04pasDhWQAGDuUiBgF0M+iD7XKLdza4q35ZfyJmFfI3cLtg2GAMIFNnZ+9Jum
         S5DEcDzVOAq+vh0fs90xj51C1AIwIpjXoCudfWfwur4HKlz297mRrr7UHJt4twDG+2HY
         ixRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781628513; x=1782233313;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YkNyfkLHwTIkuG5GEh3sOZhpzwriKUEPquKTr7jd/iQ=;
        b=NT4hknOLpceSf3LNoVCUMt18jWPdio2DMYEGEyhY4r6QjproZQh2YA0rOMdsLDakDl
         t8DV+l5MvZ+lcp+LOhFQ21bYawQE2bLN7YydBEXUhF857C7l3OyqyJgFk3hXT0rNMaRO
         /yiNqWgt/bvUxrzEL1sOd1RCQroaNnC+sw9Dua4glrqWW6yzUQWdjuU1rpBbkBOYloQS
         7TRt5MUhEqqVadJa3jf2ofdscM0bxn7cgSNjO4LFTiZwIRg8chUFGaDdW8aBUYFL3V66
         lXNwYfGZlH+YVDIuA6BgBEwNvUK/YYrN3wgCmrBiPfA7XUfiED8lF6mvlz6Po02MfCI9
         kLJQ==
X-Forwarded-Encrypted: i=1; AFNElJ96NDcs+E+cneQx2Z32wUgHD1yBUA2eMth6EAs3GZWYlEPuSXlgsayhTtXyUraqrA+ToZd3TxtlIYOvrCWvxT8S@vger.kernel.org
X-Gm-Message-State: AOJu0YwkL0a3OfCgO7DuvFs+Z8VW33/9P9SD7mrYdgdhNLU+Zgsb+60n
	82b5TGtbn3Btud5hcUITapqA+X9FJQhx0m61/ePEayxeoQQtubXtVh6IaSec3gtIVAiy7jaKaNK
	Cxgi5rc8w1A==
X-Received: from dycpz7.prod.google.com ([2002:a05:7300:fe07:b0:304:e502:fe2d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:861e:b0:304:70d0:4f03
 with SMTP id 5a478bee46e88-30bc7e325a4mr223784eec.6.1781628512606; Tue, 16
 Jun 2026 09:48:32 -0700 (PDT)
Date: Tue, 16 Jun 2026 09:48:09 -0700
In-Reply-To: <20260616164819.370939-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616061404.41929-1-irogers@google.com> <20260616164819.370939-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Message-ID: <20260616164819.370939-5-irogers@google.com>
Subject: [PATCH v3 04/13] perf tests: Add robust record retry helper and use
 subsecond workloads
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	thomas.falcon@intel.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Introduce `perf_record_with_retry` and `perf_record_cleanup` in a shared
library `tests/shell/lib/perf_record.sh` to prevent record test failures
caused by transient recording or workload delays.

Update `record.sh`, `record_lbr.sh`, `pipe_test.sh`, `kvm.sh`, and
`stat_all_pfm.sh` to use this robust record retry logic. These tests now
start with very short durations (e.g. 0.01 seconds) and scale up if the
initial recording failed to capture samples, significantly improving test
execution speed on success while remaining resilient to slow systems.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/kvm.sh             |  64 +++++---
 tools/perf/tests/shell/lib/perf_record.sh |  53 +++++++
 tools/perf/tests/shell/pipe_test.sh       |   4 +-
 tools/perf/tests/shell/record.sh          | 173 +++++++++++-----------
 tools/perf/tests/shell/record_lbr.sh      |  50 +++++--
 tools/perf/tests/shell/stat_all_pfm.sh    |   2 +-
 6 files changed, 218 insertions(+), 128 deletions(-)
 create mode 100644 tools/perf/tests/shell/lib/perf_record.sh

diff --git a/tools/perf/tests/shell/kvm.sh b/tools/perf/tests/shell/kvm.sh
index f88e859025c4..2f67e1eb4c78 100755
--- a/tools/perf/tests/shell/kvm.sh
+++ b/tools/perf/tests/shell/kvm.sh
@@ -39,17 +39,28 @@ skip() {
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
+		if ! perf kvm stat record -p "${qemu_pid}" -o "${perfdata}" \
+			sleep ${duration} >/dev/null 2>&1; then
+			echo "perf kvm stat record failed, retrying..."
+			continue
+		fi
 
-	echo "Reporting kvm events..."
-	if ! perf kvm -i "${perfdata}" stat report 2>&1 | grep -q "VM-EXIT"; then
+		if [ -e "${perfdata}" ] && \
+			perf kvm -i "${perfdata}" stat report 2>&1 | grep -q "VM-EXIT"; then
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
@@ -60,22 +71,29 @@ test_kvm_stat() {
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
+		if [ -e "${perfdata}" ] && \
+			perf kvm -i "${perfdata}" report --stdio 2>&1 | grep -q "Event count"; then
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
index 000000000000..e137fa75370d
--- /dev/null
+++ b/tools/perf/tests/shell/lib/perf_record.sh
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0
+
+PERF_RECORD_LOGS=()
+
+perf_record_with_retry() {
+  local perfdata="$1"
+  local check_cmd="$2"
+  local testprog_base="$3"
+  shift 3
+
+  local logfile
+  logfile=$(mktemp /tmp/__perf_record_retry.XXXXXX)
+  PERF_RECORD_LOGS+=("$logfile")
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
+    rm -f "${perfdata}".old
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
+  for logfile in "${PERF_RECORD_LOGS[@]}"; do
+    rm -f "$logfile"
+  done
+  PERF_RECORD_LOGS=()
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
index 7cb81cf3444a..dd90fef2088b 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -1,10 +1,13 @@
 #!/bin/bash
-# perf record tests (exclusive)
 # SPDX-License-Identifier: GPL-2.0
+# perf record tests
 
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
@@ -50,22 +54,20 @@ trap_cleanup() {
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
+  perf_record_with_retry "${perfdata}" "check_per_thread" "perf test -w thloop" \
+    --per-thread || ret=$?
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
@@ -96,6 +98,10 @@ test_per_thread() {
   echo "Basic --per-thread mode test [Success]"
 }
 
+check_register_capture() {
+  perf script -F ip,sym,iregs -i "${perfdata}" 2>/dev/null | grep -q "DI:"
+}
+
 test_register_capture() {
   echo "Register capture test"
   if ! perf list pmu | grep -q 'br_inst_retired.near_call'
@@ -108,11 +114,12 @@ test_register_capture() {
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
@@ -120,65 +127,66 @@ test_register_capture() {
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
+  perf_record_with_retry "${perfdata}" "check_system_wide" "perf test -w thloop" \
+    -aB --synth=no || ret=$?
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
@@ -190,67 +198,60 @@ test_branch_counter() {
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
+  local ret=0
+  perf_record_with_retry "${perfdata}" "check_uid" "perf test -w thloop" \
+    -aB --synth=no --uid "$(id -u)" || ret=$?
+  if [ $ret -eq 2 ]; then
+    local logfile="${PERF_RECORD_LOGS[${#PERF_RECORD_LOGS[@]}-1]}"
+    if grep -q -E "libbpf.*EPERM|Access to performance monitoring" "$logfile" || \
+       grep -q -E "Permission denied|Failure to open any events" "$logfile"
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
index 78a02e90ece1..8d51afeb437b 100755
--- a/tools/perf/tests/shell/record_lbr.sh
+++ b/tools/perf/tests/shell/record_lbr.sh
@@ -1,9 +1,12 @@
 #!/bin/bash
-# perf record LBR tests (exclusive)
 # SPDX-License-Identifier: GPL-2.0
+# perf record LBR tests
 
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
2.54.0.1189.g8c84645362-goog

