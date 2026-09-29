Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB056385D8A
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 02:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790648382; cv=none; b=r3UQBDIJ1lrIBRdgZGDFN/kfEGkL0MEVrnnTnSckJZfdZRrJYeVg4QjWNQjK9ajzYrutDKxl0Uny3rzsd6sWZiCUcJZ4B2JYMyBof4LmNWWtB9kcFc33f+5tGRsXAJjvRe2c8YSL7+QG4I3E57UefxQfZ4afkHM00tbjoBHkewA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790648382; c=relaxed/simple;
	bh=MpATh6DLU98HScpCbcjE6wdxFQKiVZzWiibe6PodilY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P5z4o0kR9a+WooOlLekKRi27thzNsNCssbxynrlhiRkiY9LxbH6zZctmBpG77+eX4C/mjPF0p4j7Si3KbzGmIoX+fmcEsU9jm737dFSSiaKOINahfgMTpiWlzKX07ZipTwUSBLwv/6z9RidE57QpPovn+JXuojKTqA43ppqhBMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=veg8JJrh; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="veg8JJrh"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-139b62317d0so1634506c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 19:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790648380; x=1791253180; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uYp7K70TA5ymSa0NZecpwuKiUmoP6HQAUKW4+jlj9sg=;
        b=veg8JJrhjXgkMgDql4rhW/79OuzPrrXbPF3XcLO1KwJTTybunGYh8Ek31/2vREdk9U
         kIXRzBq2nWu9+wGR1TtRves2UOYR1BGKxwDgUkJaKzS4blCJ6zJVXs/5u9LaJbI5jS3K
         iGGbva1gfbmZlLWSvV4Aj0KJtpqjuapxEoPssTO5W+3r6FtfIBpDGGE1HlAjt7W8M5OY
         zzhllm3i7fk8zDJVF9UasBwpHPE0WrimjCsc3YA3WhD9bJjq1rtJKViUU/8KJhpJH73k
         FahcsBmwzH7/usbt8Ww1EbBqmSKUJQcn3doKk2uTaRat3F1PGOMhRug3VahmS65J+paq
         eFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790648380; x=1791253180;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uYp7K70TA5ymSa0NZecpwuKiUmoP6HQAUKW4+jlj9sg=;
        b=ELvUCLcL8KssH8B5/iSPqPl/rc/jfJ6iekwfWkNzPN+ae/06sa35pEpPNdxWgAVapX
         yoxQOORpVrJS4ZMnW33xOZHa71Cf1frr7kksUFXILh88BCzEz46utyBKO+QKw+awEKnR
         jdncjzXe2rfiazP7kE6q90b4i6+09fHmPEL0yeN05PTul0avxKJ0r5HPP+TRob1jJH9/
         xDnhvzPY4nganBhcmuENk3sMjPtfoHUs7mlC/LfIj0ENWiJCRIjcL3h2f4NWgJS+ZrIT
         EWR1D1sdq7aiUCPWuFozJuS2PzkQnWUhzu6hY66V5Qio0QlO7Ug7UvFJ5f+zz9u5z6El
         UREA==
X-Forwarded-Encrypted: i=1; AKwUvBw0n0UonGnq+SHdsJR8LFK4pW8GOimjA4fPgawSu9WltZQDoLPDAn/pUie1b2bazNdix6gX3dAY2MFOyNciM369@vger.kernel.org
X-Gm-Message-State: AFuF++mkwYTEKoy4/nAMNYyijD2WnaR4bPbsyrV442jPENKlfWkd+v7k
	jUJT+WD2jo5l4z+HqmxKG2woUdK82PWz7sRxmNNd/9fIkZ4/3p6I58ajiVwxl9qOy3HxcB1eh2j
	KB4pXhILwXQ==
X-Received: from dlbsv14.prod.google.com ([2002:a05:7022:3a0e:b0:144:fbc3:1059])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:21db:b0:149:f2b3:ef78
 with SMTP id a92af1059eb24-149f2b3f52dmr5684415c88.32.1790648379319; Mon, 28
 Sep 2026 19:19:39 -0700 (PDT)
Date: Mon, 28 Sep 2026 19:19:09 -0700
In-Reply-To: <20260929021913.56010-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929021913.56010-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929021913.56010-6-irogers@google.com>
Subject: [PATCH v1 5/9] perf test: Deflake failed-syscalls Python shell tests
 under load
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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
 .../shell/test_failed_syscalls_python.sh      | 44 +++++++-----
 2 files changed, 67 insertions(+), 45 deletions(-)

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
index 861c2ba71c0a..88a42e3de4f3 100755
--- a/tools/perf/tests/shell/test_failed_syscalls_python.sh
+++ b/tools/perf/tests/shell/test_failed_syscalls_python.sh
@@ -41,8 +41,10 @@ temp_out=$(mktemp /tmp/perf.out.XXXXXX)
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
@@ -52,28 +54,38 @@ else
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

