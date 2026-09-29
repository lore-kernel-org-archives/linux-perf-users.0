Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40F7415B79
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 06:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665134; cv=none; b=jwIDAAMmY9DAj7RJA/T7aVNpl4TnyYlFO/uA5L2uMZ4sp54CnN9lTPMxidkhCacAB5x5iju7dvgNBuS1jm+n3WfNqpicuyfFwR3M08f9LZgJGG/Y/Ouj1+IbiudxPVDveH8Eq4Qu1WnjPMPbk24NfKLFSjMBrG7dPmcQgnhy65c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665134; c=relaxed/simple;
	bh=HM7ic7PGenayO74KX5wwd+deFrOxwbJv6wWm51CDm0c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CgCKlqhm68tJGDKtzap/B+6UwEuyPteqYtwQAluWwyjIbu/EZFtxRHXzR+UGbWfORF4PfEym39TNu7UeWkp1YW5BvE+szF/ilKFP4auKOLoYqXgNLBVGNUCSVnAHcepOnKBege9AvSeFvPZ9Y1NkWmnVxEIrJWalUJvCu+dknSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rYWvwh30; arc=none smtp.client-ip=74.125.82.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rYWvwh30"
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1493b09d6bbso970239c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 23:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790665132; x=1791269932; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9IGzOIODGES3gOAt25C9qV3mqPw8mWSQSxSfj3N8hBo=;
        b=rYWvwh30aZpe3B64RWLzapWGEMoQYtnXa2VrIo59+vI4FZJwUMZzD1vIt+mC9CKKZC
         HKEE5DPRFjE+X3nx7QIljx4cIoGBFHOQkd2UN0yhw71uYo1X6eFR9xsKQdDnSL/hCKBc
         6oJhG8PCFH0kh7E9plHssO4A1leSSDQhx5j1DMFwpWh4ofycbNB3kZGOpaSvr34c6J4U
         /10/Pr/dx2OWRHSQ7hhUQmuY57lpsqkv9+E6ykirrgyaHYLi4A15nHoMO4ADUb+l5Mo5
         haJpmYqA1LCkoJ1tmzI7to6SJYYqSHKP9tr97GuLzAboRi0HYWkxogWre1R+9YVmMqdK
         M6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790665132; x=1791269932;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9IGzOIODGES3gOAt25C9qV3mqPw8mWSQSxSfj3N8hBo=;
        b=vat/yV5zY9EsltOxpfsNXAGsfPPylEKK00NbGAmC69vW/FkEMSVTauuhsKttEGkRtg
         VN9wLWV5SGnsCgxNLrYqBEALMt+5VkWApZ+Vm40Q0EqUuGvFtqtYM9WWW/MdwdBRGisT
         +QnObYn6D47HI706oM8McnlbVPcjnsWUWI6vTWRq2WsyCqLypp6DGGBXp8Di/i5Tka2+
         vjXyzfFhNKVClJqtxS6ULuLocyrt1xCqgsnC/DHlKZg91pXo8xCMER1KRITChf6f4kqk
         V30bmH+VhvLp4tGvmSiy2SJ2I43finNaK7ewQB1htyIRhoht9TGjmsN6R3Z6ud3qQZUv
         dV9A==
X-Forwarded-Encrypted: i=1; AKwUvBxf4nmus31AoxkAZf4n/1iC2uQbNAo3JypnvjUhGhWwWlyvE5bnqB96zSg/m8lNCejHHbJa0BH32pVwA6jTQ9ZB@vger.kernel.org
X-Gm-Message-State: AFuF++k2D6zABPMFcW1f84TrOnMRZUDeIFGjxJjA0lScEbnlqohYlEhM
	rXdkf5L9YBeBdX1IhqrjUoHghQb4+SgZebFIYVbMjmEg28MBZHqHEV+WSU7Mdz3KjBcQPf5o8+U
	0zPShW+8y8w==
X-Received: from dlbsw8.prod.google.com ([2002:a05:7022:3a88:b0:146:40d5:dd6b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:28c:b0:139:bf81:637f
 with SMTP id a92af1059eb24-146ce775f18mr12854740c88.16.1790665131484; Mon, 28
 Sep 2026 23:58:51 -0700 (PDT)
Date: Mon, 28 Sep 2026 23:58:34 -0700
In-Reply-To: <20260929065839.407062-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929062937.374137-1-irogers@google.com> <20260929065839.407062-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929065839.407062-5-irogers@google.com>
Subject: [PATCH v3 4/9] perf test: Deflake Intel PT Python shell tests under load
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

In test_intel_pt_events_python.sh, test_export_to_sqlite_python.sh, and
test_export_to_postgresql_python.sh, 'sh -c "uname; true"' uses the
shell builtin 'true' and exits within microseconds of 'uname', sending
SIGCHLD to 'perf record' before the Intel PT AUX buffer is always
flushed under heavy parallel load (~5-10% drop rate).

Sleep 0.05s in the subshell after 'uname' ('sh -c "uname; sleep 0.05"')
so 'uname' completely exits and flushes its AUX trace before 'sh' exits,
and wrap the record and verification step in a bounded retry loop (up to
5 attempts). Also pass '-B -N --no-bpf-event' to 'perf record -g' in
test_export_to_sqlite_python.sh and test_export_to_postgresql_python.sh
to avoid build-id cache and BPF synthesis overhead.

Fixes: d4ce72e9e238 ("perf python: Port intel-pt-events and libxed to perf module")
Fixes: 62d350135e67 ("perf python: Port export-to-sqlite to perf module")
Fixes: b1f968c9656a ("perf python: Port export-to-postgresql to perf module")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../shell/test_export_to_postgresql_python.sh | 49 ++++++++++--------
 .../shell/test_export_to_sqlite_python.sh     | 50 +++++++++++--------
 .../shell/test_intel_pt_events_python.sh      | 43 +++++++++-------
 3 files changed, 79 insertions(+), 63 deletions(-)

diff --git a/tools/perf/tests/shell/test_export_to_postgresql_python.sh b/tools/perf/tests/shell/test_export_to_postgresql_python.sh
index 350813466700..835f48f002e9 100755
--- a/tools/perf/tests/shell/test_export_to_postgresql_python.sh
+++ b/tools/perf/tests/shell/test_export_to_postgresql_python.sh
@@ -61,9 +61,10 @@ test_file_mode() {
 	fi
 
 	# Generate events with callchains and context switches
-	if ! perf record -g --switch-events -o "${temp_data}" \
+	if ! perf record -B -N --no-bpf-event -g --switch-events -o "${temp_data}" \
 	     -- perf test -w noploop >/dev/null 2>&1 && \
-	   ! perf record -g -o "${temp_data}" -- perf test -w noploop >/dev/null 2>&1; then
+	   ! perf record -B -N --no-bpf-event -g -o "${temp_data}" \
+	     -- perf test -w noploop >/dev/null 2>&1; then
 		echo "Skipping test, perf record failed"
 		exit 2
 	fi
@@ -92,29 +93,33 @@ test_file_mode() {
 test_intel_pt() {
 	echo "Testing export-to-postgresql.py with intel_pt..."
 
-	psql -c "DROP DATABASE IF EXISTS ${temp_db}" postgres >/dev/null 2>&1 || true
-	rm -f "${temp_data}"
-	# Generate some intel_pt events; use a subshell that waits for uname
-	if ! perf record -B -N --no-bpf-event -e intel_pt//u -o "${temp_data}" \
-		-- sh -c "uname; true" >/dev/null 2>&1; then
-		echo "Skipping intel_pt test, intel_pt not available."
-		return 0
-	fi
+	# Generate some intel_pt events; sleep briefly after uname in the subshell
+	# so uname's AUX buffer is flushed before SIGCHLD stops perf record.
+	passed=0
+	for _ in 1 2 3 4 5; do
+		psql -c "DROP DATABASE IF EXISTS ${temp_db}" postgres >/dev/null 2>&1 || true
+		rm -f "${temp_data}"
+		if ! perf record -B -N --no-bpf-event -e intel_pt//u -o "${temp_data}" \
+			-- sh -c "uname; sleep 0.05" >/dev/null 2>&1; then
+			echo "Skipping intel_pt test, intel_pt not available."
+			return 0
+		fi
 
-	# Run the script with --itrace cr to synthesize call_returns
-	if ! perf script export-to-postgresql -i "${temp_data}" \
-		-o "${temp_db}" --itrace cr >/dev/null; then
-		echo "intel_pt file mode test failed."
-		err=1
-	else
-		# Check DB for calls
-		if ! psql -d "${temp_db}" -t -c 'SELECT COUNT(*) FROM calls WHERE id > 0;' | \
+		# Run the script with --itrace cr to synthesize call_returns
+		if perf script export-to-postgresql -i "${temp_data}" \
+			-o "${temp_db}" --itrace cr >/dev/null && \
+		   psql -d "${temp_db}" -t -c 'SELECT COUNT(*) FROM calls WHERE id > 0;' | \
 			grep -q '[1-9]'; then
-			echo "PostgreSQL intel_pt validation failed (no calls found)."
-			err=1
-		else
-			echo "intel_pt test passed (cr validated)."
+			passed=1
+			break
 		fi
+	done
+
+	if [ "$passed" -eq 0 ]; then
+		echo "PostgreSQL intel_pt validation failed (no calls found)."
+		err=1
+	else
+		echo "intel_pt test passed (cr validated)."
 	fi
 }
 
diff --git a/tools/perf/tests/shell/test_export_to_sqlite_python.sh b/tools/perf/tests/shell/test_export_to_sqlite_python.sh
index d3c5e22a0754..19ca7c539cf7 100755
--- a/tools/perf/tests/shell/test_export_to_sqlite_python.sh
+++ b/tools/perf/tests/shell/test_export_to_sqlite_python.sh
@@ -47,9 +47,10 @@ test_file_mode() {
 	echo "Testing export-to-sqlite.py..."
 
 	# Generate events with callchains and context switches if supported
-	if ! perf record -g --switch-events -o "${temp_data}" \
+	if ! perf record -B -N --no-bpf-event -g --switch-events -o "${temp_data}" \
 	     -- perf test -w noploop >/dev/null 2>&1 && \
-	   ! perf record -g -o "${temp_data}" -- perf test -w noploop >/dev/null 2>&1; then
+	   ! perf record -B -N --no-bpf-event -g -o "${temp_data}" \
+	     -- perf test -w noploop >/dev/null 2>&1; then
 		echo "Skipping test, perf record failed"
 		exit 2
 	fi
@@ -77,29 +78,34 @@ test_file_mode() {
 test_intel_pt() {
 	echo "Testing export-to-sqlite.py with intel_pt..."
 
-	rm -f "${temp_db}" "${temp_data}"
-	# Generate some intel_pt events; use a subshell that waits for uname
-	if ! perf record -B -N --no-bpf-event -e intel_pt//u -o "${temp_data}" \
-		-- sh -c "uname; true" >/dev/null 2>&1; then
-		echo "Skipping intel_pt test, intel_pt not available."
-		return 0
-	fi
+	query="import sqlite3; c = sqlite3.connect('${temp_db}'); "
+	query="${query}r = c.execute('SELECT COUNT(*) FROM calls').fetchone()[0]; "
+	query="${query}exit(1 if r == 0 else 0)"
+
+	# Generate some intel_pt events; sleep briefly after uname in the subshell
+	# so uname's AUX buffer is flushed before SIGCHLD stops perf record.
+	passed=0
+	for _ in 1 2 3 4 5; do
+		rm -f "${temp_db}" "${temp_data}"
+		if ! perf record -B -N --no-bpf-event -e intel_pt//u -o "${temp_data}" \
+			-- sh -c "uname; sleep 0.05" >/dev/null 2>&1; then
+			echo "Skipping intel_pt test, intel_pt not available."
+			return 0
+		fi
 
-	# Run the script with --itrace cr to synthesize call_returns
-	if ! perf script export-to-sqlite -i "${temp_data}" -o "${temp_db}" --itrace cr; then
-		echo "intel_pt file mode test failed."
+		# Run the script with --itrace cr to synthesize call_returns
+		if perf script export-to-sqlite -i "${temp_data}" -o "${temp_db}" --itrace cr && \
+		   "$PYTHON" -c "$query" >/dev/null 2>&1; then
+			passed=1
+			break
+		fi
+	done
+
+	if [ "$passed" -eq 0 ]; then
+		echo "SQLite intel_pt validation failed (no calls found)."
 		err=1
 	else
-		# Check DB for calls
-		query="import sqlite3; c = sqlite3.connect('${temp_db}'); "
-		query="${query}r = c.execute('SELECT COUNT(*) FROM calls').fetchone()[0]; "
-		query="${query}exit(1 if r == 0 else 0)"
-		if ! "$PYTHON" -c "$query" >/dev/null 2>&1; then
-			echo "SQLite intel_pt validation failed (no calls found)."
-			err=1
-		else
-			echo "intel_pt test passed (cr validated)."
-		fi
+		echo "intel_pt test passed (cr validated)."
 	fi
 }
 
diff --git a/tools/perf/tests/shell/test_intel_pt_events_python.sh b/tools/perf/tests/shell/test_intel_pt_events_python.sh
index b5c3173fa2db..9754b9125da1 100755
--- a/tools/perf/tests/shell/test_intel_pt_events_python.sh
+++ b/tools/perf/tests/shell/test_intel_pt_events_python.sh
@@ -30,7 +30,8 @@ cleanup() {
 	[ -n "${temp_dir}" ] && rm -rf "${temp_dir}"
 }
 
-trap 'cleanup' EXIT TERM INT
+trap 'cleanup' EXIT
+trap 'cleanup; exit 1' TERM INT
 
 temp_dir=$(mktemp -d /tmp/perf.ipt.XXXXXX)
 temp_data="${temp_dir}/perf.data"
@@ -39,27 +40,31 @@ temp_out="${temp_dir}/perf.out"
 test_intel_pt() {
 	echo "Testing intel-pt-events.py with intel_pt..."
 
-	rm -f "${temp_data}" "${temp_out}"
-	# Generate some intel_pt events; use a subshell that waits for uname so
-	# uname's AUX buffer is flushed before the parent workload exits.
-	if ! perf record -B -N --no-bpf-event -e intel_pt//u -o "${temp_data}" \
-		-- sh -c "uname; true" >/dev/null 2>&1; then
-		echo "Skipping intel_pt test, intel_pt not available."
-		exit 2
-	fi
+	# Generate some intel_pt events; sleep briefly after uname in the subshell
+	# so uname's AUX buffer is flushed before SIGCHLD stops perf record.
+	passed=0
+	for _ in 1 2 3 4 5; do
+		rm -f "${temp_data}" "${temp_out}"
+		if ! perf record -B -N --no-bpf-event -e intel_pt//u -o "${temp_data}" \
+			-- sh -c "uname; sleep 0.05" >/dev/null 2>&1; then
+			echo "Skipping intel_pt test, intel_pt not available."
+			exit 2
+		fi
 
-	# Run the script and check output
-	if ! perf script intel-pt-events -i "${temp_data}" > "${temp_out}"; then
-		echo "intel-pt-events.py test failed."
+		# Run the script and check output
+		if perf script intel-pt-events -i "${temp_data}" > "${temp_out}" && \
+		   grep -q "Intel PT Branch Trace" "${temp_out}" && \
+		   grep -q "uname" "${temp_out}"; then
+			passed=1
+			break
+		fi
+	done
+
+	if [ "$passed" -eq 0 ]; then
+		echo "Failed to find expected output: $(cat "${temp_out}" 2>/dev/null)"
 		err=1
 	else
-		if ! grep -q "Intel PT Branch Trace" "${temp_out}" || \
-		   ! grep -q "uname" "${temp_out}"; then
-			echo "Failed to find expected output: $(cat "${temp_out}")"
-			err=1
-		else
-			echo "intel-pt-events test passed."
-		fi
+		echo "intel-pt-events test passed."
 	fi
 	rm -f "${temp_out}"
 }
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

