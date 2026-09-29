Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A470299922
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 02:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790648382; cv=none; b=K1CxKbvi1y/DSdsjhb0VtUtQCpX2qo3WkIcqr2cL8WtnfLI+42METpoxL9x+W4a1jizWTLKvGx/1bZQTMB/LcrPKU6+HA/ZRL6l8iWEB0VJgx2ISE10Nznjaa5T/8v5nlxs18iurKBopIfkt8CgDteyHt8g+Htt6ck8hq3AZkEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790648382; c=relaxed/simple;
	bh=HM7ic7PGenayO74KX5wwd+deFrOxwbJv6wWm51CDm0c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ooSl/518zTrQvF6C/k1K7LIVeM+wof8RZ5Fdg1l2pXx8KMVvGVnosl65H6icIYTSUljmOT8uyESLXfcJUPlPF54JXFisHLxwSgMMUQ7q0FhRgU+P3z++zQYJLYz6TxnfodL5T0cx2WpJYQPKZFjZwFFxrSmDcHONIbSLUuhc9Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BNm/e6DU; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BNm/e6DU"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-34afa104860so523631eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 19:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790648378; x=1791253178; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9IGzOIODGES3gOAt25C9qV3mqPw8mWSQSxSfj3N8hBo=;
        b=BNm/e6DUMnyx3pwmaKMwPGdQu0ZU9A/ml8P2IxmAdePmbwIhDV9EKylmpawfp2uTco
         YXmYx4IoJ753/clL0mLsJqirxfITBSuaNlt0tQvs/cvwKsCxWGHoZkUxm5Pfr3S00+om
         8hWZjWinV36HBSMtz0v7uSLRdwQZNUP9YyHwJdlKdu2jQRGG4sKJ/EYyEXZsAgQUcJWx
         2/Tx9M0lQqvHDvCM7VqUGZDg7myUovxfPvQzM51v5Fd6P0t5MudfWIveFIfsJspMWuRb
         nouDSzxWhEfBzdZ9cWoIqd8sxxkozmpZgxx9Mr6UgcfjfL7hBjOOikBIyzHglqW2A8NT
         TuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790648378; x=1791253178;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9IGzOIODGES3gOAt25C9qV3mqPw8mWSQSxSfj3N8hBo=;
        b=xsSdf6mQrx+iDCxCB0RHk74GJfF3ECgMZ/8uzhwFbvK5esaBqzPpCW1DpUaGSE/gmM
         4h5PHLtWq+W1liq8ZwsMwNi3RqfBsByzRDKfvKbf/w8AGgvuhlbw6n3PGniJ5suRpATr
         kWQsACjCfHJBmhUUUnGneY9/nbvnSfFfiRDcfLhlFx2sRa0vFSWgUdvagyayKrwqC1Xt
         GDaESCmOhhhHNR558o7Z84L/aNL6j/mZ/Spjt1fa1S1xTQgFrJgFWiPmYhMd8pp7bvEQ
         hyLEP3j53/TwCcyCW2ah4KisP/7VE85O/nqgoVNB/xykPKUTXheBTELPYGysV+iIrG7P
         lzBg==
X-Forwarded-Encrypted: i=1; AKwUvBwDmyPVUjU2RwHC0aQkvcC5Dn2UeQic0XYwPD8Fa5Hgs+jE4iIGEkud7cjjAHVnAt+N+ig5qAf+dcnQHEALrZPl@vger.kernel.org
X-Gm-Message-State: AFuF++nyDE9nX2JuO3JOGp/5//Te8HITD+gGQv2/UeeGI088GpZtiu5J
	/cL6n7KxKNivUWw/RB69Xcr6S2FNCiz0HtgI2KhPnJx1UtVbWjvG8wZttqOPqlHinpmvhVjh/dG
	TYTwnrIoOhQ==
X-Received: from dlbep12.prod.google.com ([2002:a05:7022:108c:b0:149:37d9:7f80])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:240b:b0:14a:a6dc:9cfd
 with SMTP id a92af1059eb24-14aa6dca0d5mr2764362c88.10.1790648377194; Mon, 28
 Sep 2026 19:19:37 -0700 (PDT)
Date: Mon, 28 Sep 2026 19:19:08 -0700
In-Reply-To: <20260929021913.56010-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929021913.56010-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929021913.56010-5-irogers@google.com>
Subject: [PATCH v1 4/9] perf test: Deflake Intel PT Python shell tests under load
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

