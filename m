Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8764B43230F
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 06:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663395; cv=none; b=MWk9yQz5LCU2R4nx2DzMIrKdJjduqEpv1rXCLM7ohwl8MQQ7luKEfnylVeTa469jrEBEddZZQFn/koh0SWuugg3XuJJTSMFVcFalHsbIKaDSeOEtb/73cYS/147nVTLiEkr82El0mBQ9Wl5nRWvGt6w6mqmohM6l9JnfC/sg/zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663395; c=relaxed/simple;
	bh=HM7ic7PGenayO74KX5wwd+deFrOxwbJv6wWm51CDm0c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tWKq5U0MlJiqd+dXxglFUi5yJL79HxWckzJhMytCFICoAJnP9u6lxOn3LB4gOzVKP3KkcWys1TAgPs3ELbejVoKMnv8fr7mNL83B223ZqqQoJfhSA2lpGBdlPhBKrph+H7j0k5V5ECTFSIjtPr0rpGUkw01orMeTTvyQp6IV8ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QOPj7TsF; arc=none smtp.client-ip=74.125.82.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QOPj7TsF"
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-144d4ba280aso79582c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 23:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790663393; x=1791268193; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9IGzOIODGES3gOAt25C9qV3mqPw8mWSQSxSfj3N8hBo=;
        b=QOPj7TsFKRaxMHKqv0d7WppnjNI5czMZOzw8LNGnPlcU3T/loPbW3KzxtoWPCAeT53
         VvC8udxcooNsdfI1OJiad5y9/RTEN2w3NxFyrWc2dsx+8fZAKGH4e/pNgaPXVonF00Yj
         GtZKtIhA6nTqDo+0CNNf7H2Ez3oxMaAjaJ/xQ1iVvOnudkXK3z3CaqJHq2gclenyVPvb
         Btdf9dPkYjn4fA0c+Ene04GsDN1TBeEsnsqR40U0OJzQNwh90OTxikNxqFeAmR4sLTFL
         ngGQUrgcmI91gHqKjsf5lbd/waWj/cfQBpRCOnc6f2tt7JbNTC5fErUMDWUeqobBSUtC
         UvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790663393; x=1791268193;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9IGzOIODGES3gOAt25C9qV3mqPw8mWSQSxSfj3N8hBo=;
        b=IJWbMlBa73BwpgxlezISQLinblRirPzEtPi09sC5vCPvCW86ik1kVlTbHdzSEgjkiw
         +0J0kb367qT2vW6GuJd9DUOE2GnkM58VmkuWKJSFp6/3kRsFMa7INtyl7GLhVyFbBSze
         umus6JkwmfN1SgUdAII4haqo8W/2wgVcGyhtRjfoz7jFdbzx0oQeNPTM8iBg2qjpYUES
         vz5OYNoa0d4e8gXBWT946NmbTJGp7XgDf8/fM/kPcA0HYHZy3H9sMCr8b0aslN5NmXnl
         J+TKhzDKnO5sSuOVHuVlW5Td3dY+6gC6cqnQnSYXaXkkE3dK+7qhtmHCNwBc6r8Xgs74
         xDdw==
X-Forwarded-Encrypted: i=1; AKwUvBy1gpWouki6FJ1x3Ew7xK2wGDaMTAviQp6VjX1uH1omJFDh6kULyc93S2dfwWQWE7UEiyucNI80pexUdViWvChf@vger.kernel.org
X-Gm-Message-State: AFuF++mFZKT0Wd5FHSQVY4c3dkkPSRx4G8bdSdvu0lH/hGTusEKup0FJ
	pXjvsC/OHK7/eFPkmh5hdiYwHEAeFPhhd+wRhaj2jteCiXlN1ubd2WsABREeH+XbhukvFNCAGtI
	3TS5R7I0kRw==
X-Received: from dybb26.prod.google.com ([2002:a05:693c:609a:b0:343:520f:7a80])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1219:b0:143:1bb1:3305
 with SMTP id a92af1059eb24-14b2ea054f6mr1783309c88.22.1790663392067; Mon, 28
 Sep 2026 23:29:52 -0700 (PDT)
Date: Mon, 28 Sep 2026 23:29:32 -0700
In-Reply-To: <20260929062937.374137-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929021913.56010-1-irogers@google.com> <20260929062937.374137-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929062937.374137-5-irogers@google.com>
Subject: [PATCH v2 4/9] perf test: Deflake Intel PT Python shell tests under load
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

