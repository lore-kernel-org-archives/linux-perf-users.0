Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE2D471279
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 06:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665136; cv=none; b=OC6IphQzwf659n/YGeQF25ctmIipN8TzAsEjuhTXtKn8dbxYuGhS2qIuXgBl4TTk9jELmD05/5A4Potgj5IbvFUjNvjGJw+FhkAGYXrgqQUZS3Nq6Ls4Z5mp8pCPmjAuTR9MFebTY0g0WqV6OqrB+i4eohXDpRBueWRbGITB2AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665136; c=relaxed/simple;
	bh=Z/89xeGOiIJYcTL9BPZOjhUHxsxXHo9lblxBd/M+gtY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RNlkZMox902yv9Al+mMl9mf9gDLMnh1o8Qkn3hx7pCqJXtysXoKSbomzMRKaopzdi2wq6OFRtombjJXHMitizH7g58FxCpRPzKOU1yniN0InBNn0Gz6cqHY6PSn6yb23jmxc6zreR/vqv7WzRzE2iRy4/73Wi+Ih3jqxxHq7DpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=peDXhf0N; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="peDXhf0N"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-142f4306744so1112042c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 23:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790665134; x=1791269934; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zLwL3S/cEYRYcHBy5orOfZQiTZiLu9om4LDFHXe5lF8=;
        b=peDXhf0N9dLuehOHxpcNINUOy5oyD0n7A/8M6pgqoWhs8Yi5burJfIKNHiJW+5T0lM
         SDglO8OFRI2yRwkqwq+Qbom1gH77kbqSRAV6C5hB/P4aVjzMbiWBCdFFU2nxHHTEUN9n
         ohaG7Uao2R/4xdtfChuZXLn7vEEJ9TzDRbnZBK+pK7OPABqey3wJ2vTOIQPxhNQDhLOw
         +Gd5t4cN8w24gJu/p0z8SDCVd3gqj0Y0iwhtAKl9qqPAYp9vnPqpPzCuok4Vj98j5w8w
         vQYPA3v3FoAC6a4EOBWT42DlQHKBkDzpslXxa9Xea0F6f3J1zEuOUTVa9mrn1EJ28tYE
         CYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790665134; x=1791269934;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zLwL3S/cEYRYcHBy5orOfZQiTZiLu9om4LDFHXe5lF8=;
        b=VYClseXZ8FIp0s8ONTs7vpwKSC3iSdae01GnkexqYdSEac07a7aUu9adxCqYfHz7JR
         UT2x+t0GKGVHJTJ0jZiz6dK0JOUD1dXExBwFP0aLVH8Yg1yJejt6nLpQ5qaXqe8Tto2N
         CNhsUkkFFmCFMKgdTngPe09yAhOI5K2Avbrjoz9n1jw87E1aAfdwa23rt582sg4BbzR4
         sAaouWbFu8hYPkKZCC65pM0uBvpcQF6wFJ2OUjfCpYywBoTRd2LP/tR5BAwEPM8d1TYH
         WrcRABD0zQjm+ODDRtqZKJjOrLyJGZs50EEaj1iEqmKR8oQ2nBT0NZmo1e3+mPiYXwY8
         1gRA==
X-Forwarded-Encrypted: i=1; AKwUvBzq4hRs2vyshyJLXtwpJhIdfTICbAgO7LfjfMCCdv4ofNH301UZeJ9BsCCyXYHNVdF0VmcrbT8/XYtdgseTEeVj@vger.kernel.org
X-Gm-Message-State: AFuF++mIneTflwwUhmSgvWPUzkyva3miExcVS+gHmmC2NqSRVIBSjNNG
	TsiTimRRi8qFWSvuN7+OmK/Q8zUqEmXPQrn8KOR8zYTwlzgGvzVp1lsr1ZW80ltqAwHdmft0qu5
	XwuGh82YFJg==
X-Received: from dlaf24.prod.google.com ([2002:a05:701b:2418:b0:144:c737:6f14])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3a8b:b0:149:49c:22b
 with SMTP id a92af1059eb24-149049c04bcmr10667473c88.1.1790665133386; Mon, 28
 Sep 2026 23:58:53 -0700 (PDT)
Date: Mon, 28 Sep 2026 23:58:35 -0700
In-Reply-To: <20260929065839.407062-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929062937.374137-1-irogers@google.com> <20260929065839.407062-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929065839.407062-6-irogers@google.com>
Subject: [PATCH v3 5/9] perf test: Deflake failed-syscalls Python shell tests
 under load
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When running 'perf test' in parallel under heavy system load, a one-shot
'perf record -e ... -- ls /does_not_exist' without '-B -N --no-bpf-event'
can exit in under 300 microseconds before 'ls's PERF_RECORD_COMM and
ENOENT sys_exit events are captured, while also contending on ~/.debug
build-id caching and BPF event synthesis.

Pass '-B -N --no-bpf-event' to 'perf record', sleep 0.05s in a subshell
after 'ls' so its events are flushed before the parent subshell exits,
and wrap the record and check steps in a bounded retry loop (up to 5
attempts).

Fixes: b76c43d09b06 ("perf python: Port failed-syscalls-by-pid to perf module")
Fixes: 4e3fe6987cba ("perf python: Port failed-syscalls from Perl to perf module")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../test_failed_syscalls_by_pid_python.sh     | 68 +++++++++++--------
 .../shell/test_failed_syscalls_python.sh      | 54 +++++++++------
 2 files changed, 71 insertions(+), 51 deletions(-)

diff --git a/tools/perf/tests/shell/test_failed_syscalls_by_pid_python.sh b/tools/perf/tests/shell/test_failed_syscalls_by_pid_python.sh
index 215372d4e1c5..070a7ef6b8ad 100755
--- a/tools/perf/tests/shell/test_failed_syscalls_by_pid_python.sh
+++ b/tools/perf/tests/shell/test_failed_syscalls_by_pid_python.sh
@@ -41,8 +41,10 @@ test_file_mode() {
 	echo "Testing failed-syscalls-by-pid.py..."
 
 	# Check if syscalls:sys_exit is supported/readable
-	if ! perf record -e syscalls:sys_exit -o /dev/null -- true >/dev/null 2>&1; then
-		if ! perf record -e raw_syscalls:sys_exit -o /dev/null -- true >/dev/null 2>&1; then
+	if ! perf record -B -N --no-bpf-event -e syscalls:sys_exit \
+		-o /dev/null -- true >/dev/null 2>&1; then
+		if ! perf record -B -N --no-bpf-event -e raw_syscalls:sys_exit \
+			-o /dev/null -- true >/dev/null 2>&1; then
 			echo "Skipping test, no syscalls:sys_exit or raw_syscalls:sys_exit event"
 			exit 2
 		else
@@ -52,41 +54,49 @@ test_file_mode() {
 		EVENT="syscalls:sys_exit"
 	fi
 
-	# Generate some events by running a command that should fail at least some syscall
-	# (e.g. failing stat on non-existent file).
-	# Using '|| true' because 'perf record' returns the exit code of 'ls',
-	# which fails with ENOENT
-	perf record -e "${EVENT}" -o "${temp_data}" -- ls /does_not_exist >/dev/null 2>&1 || true
+	# Generate some events by running a command that fails a syscall
+	# (e.g. failing stat on non-existent file), sleeping briefly in the
+	# subshell so ls's PERF_RECORD_COMM and sys_exit events are flushed.
+	passed=0
+	for _ in 1 2 3 4 5; do
+		rm -f "${temp_data}" "${temp_out}" "${temp_out}.comm" "${temp_out}.pid"
+		perf record -B -N --no-bpf-event -e "${EVENT}" -o "${temp_data}" \
+			-- sh -c "ls /does_not_exist 2>/dev/null; sleep 0.05 || true" \
+			>/dev/null 2>&1 || true
+		if [ ! -s "${temp_data}" ]; then
+			continue
+		fi
+
+		if perf script failed-syscalls-by-pid -i "${temp_data}" > "${temp_out}" && \
+		   grep -n -q "err = ENOENT" "${temp_out}" && \
+		   perf script failed-syscalls-by-pid -i "${temp_data}" \
+			"ls" > "${temp_out}.comm" && \
+		   grep -q "err = ENOENT" "${temp_out}.comm"; then
+			ls_pid=$(sed -n 's/^ls \[\([0-9][0-9]*\)\].*/\1/p' \
+				"${temp_out}.comm" | head -n 1)
+			if [ -n "${ls_pid}" ] && \
+			   perf script failed-syscalls-by-pid -i "${temp_data}" \
+				"${ls_pid}" > "${temp_out}.pid" && \
+			   grep -q "err = ENOENT" "${temp_out}.pid"; then
+				passed=1
+				break
+			fi
+		fi
+	done
+
 	if [ ! -s "${temp_data}" ]; then
 		echo "Skipping test, perf record failed to create data"
 		exit 2
 	fi
 
-	# Run the script and check output
-	if ! perf script failed-syscalls-by-pid -i "${temp_data}" > "${temp_out}"; then
+	if [ "$passed" -eq 0 ]; then
 		echo "failed-syscalls-by-pid test failed."
-		err=1
-	elif ! grep -n -q "err = ENOENT" "${temp_out}"; then
-		echo "Failed to find expected failed syscalls"
-		cat "${temp_out}"
-		err=1
-	elif ! perf script failed-syscalls-by-pid -i "${temp_data}" "ls" > "${temp_out}.comm" || \
-	     ! grep -q "err = ENOENT" "${temp_out}.comm"; then
-		echo "failed-syscalls-by-pid comm filter test failed."
-		cat "${temp_out}.comm"
+		cat "${temp_out}" 2>/dev/null || true
+		cat "${temp_out}.comm" 2>/dev/null || true
+		cat "${temp_out}.pid" 2>/dev/null || true
 		err=1
 	else
-		ls_pid=$(sed -n 's/^ls \[\([0-9][0-9]*\)\].*/\1/p' "${temp_out}.comm" | head -n 1)
-		if [ -z "${ls_pid}" ] || \
-		   ! perf script failed-syscalls-by-pid -i "${temp_data}" \
-			"${ls_pid}" > "${temp_out}.pid" || \
-		   ! grep -q "err = ENOENT" "${temp_out}.pid"; then
-			echo "failed-syscalls-by-pid PID filter test failed."
-			cat "${temp_out}.pid" 2>/dev/null || true
-			err=1
-		else
-			echo "failed-syscalls-by-pid test passed."
-		fi
+		echo "failed-syscalls-by-pid test passed."
 	fi
 	rm -f "${temp_out}" "${temp_out}.comm" "${temp_out}.pid"
 }
diff --git a/tools/perf/tests/shell/test_failed_syscalls_python.sh b/tools/perf/tests/shell/test_failed_syscalls_python.sh
index 861c2ba71c0a..9aaf05883c50 100755
--- a/tools/perf/tests/shell/test_failed_syscalls_python.sh
+++ b/tools/perf/tests/shell/test_failed_syscalls_python.sh
@@ -27,22 +27,22 @@ if [ ! -f "$script_path" ]; then
 fi
 
 err=0
-temp_data=""
-temp_out=""
+temp_dir=$(mktemp -d /tmp/perf-failed-syscalls-XXXXXX)
+temp_data="${temp_dir}/perf.data"
+temp_out="${temp_dir}/perf.out"
 
 cleanup() {
-	rm -f "${temp_data}" "${temp_out}"
+	rm -rf "${temp_dir}"
 }
 trap 'cleanup' EXIT TERM INT
 
-temp_data=$(mktemp /tmp/perf.data.XXXXXX)
-temp_out=$(mktemp /tmp/perf.out.XXXXXX)
-
 echo "Testing failed-syscalls.py..."
 
 # Check if sys_exit event can be recorded
-if ! perf record -e raw_syscalls:sys_exit -o /dev/null -- true >/dev/null 2>&1; then
-	if ! perf record -e syscalls:sys_exit -o /dev/null -- true >/dev/null 2>&1; then
+if ! perf record -B -N --no-bpf-event -e raw_syscalls:sys_exit \
+	-o /dev/null -- true >/dev/null 2>&1; then
+	if ! perf record -B -N --no-bpf-event -e syscalls:sys_exit \
+		-o /dev/null -- true >/dev/null 2>&1; then
 		echo "Skipping test, no permission or support for sys_exit event"
 		exit 2
 	else
@@ -52,28 +52,38 @@ else
 	EVENT="raw_syscalls:sys_exit"
 fi
 
-# Run perf record with a command that fails a syscall (ls non-existent file).
-# ls exits with non-zero, so perf record returns non-zero exit code of the workload.
-perf record -e "${EVENT}" -o "${temp_data}" \
-	-- ls /nonexistent_file_for_test >/dev/null 2>&1 || true
+# Run perf record with a command that fails a syscall (ls non-existent file),
+# sleeping briefly in the subshell so ls's PERF_RECORD_COMM and sys_exit events are flushed.
+passed=0
+for _ in 1 2 3 4 5; do
+	rm -f "${temp_data}" "${temp_out}"
+	perf record -B -N --no-bpf-event -e "${EVENT}" -o "${temp_data}" \
+		-- sh -c "ls /nonexistent_file_for_test 2>/dev/null; sleep 0.05 || true" \
+		>/dev/null 2>&1 || true
+
+	if [ ! -s "${temp_data}" ]; then
+		continue
+	fi
+
+	# Check that the script executes
+	if perf script failed-syscalls -i "${temp_data}" > "${temp_out}" && \
+	   grep -q "failed syscalls by comm" "${temp_out}" && \
+	   grep -Eq '^ls[[:space:]]+[0-9]+' "${temp_out}"; then
+		passed=1
+		break
+	fi
+done
 
 if [ ! -s "${temp_data}" ]; then
 	echo "Skipping test, perf record failed to create data"
 	exit 2
 fi
 
-# Check that the script executes
-if ! perf script failed-syscalls -i "${temp_data}" > "${temp_out}"; then
-	echo "failed-syscalls.py test failed"
+if [ "$passed" -eq 0 ]; then
+	echo "Failed to find the metrics table header or expected error"
 	err=1
 else
-	if ! grep -q "failed syscalls by comm" "${temp_out}" || \
-		! grep -Eq '^ls[[:space:]]+[0-9]+' "${temp_out}"; then
-		echo "Failed to find the metrics table header or expected error"
-		err=1
-	else
-		echo "failed-syscalls test passed."
-	fi
+	echo "failed-syscalls test passed."
 fi
 rm -f "${temp_out}"
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

