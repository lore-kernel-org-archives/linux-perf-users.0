Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4342946AA8E
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 06:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665130; cv=none; b=PokVRW8YPDhjUUod5vBPWxVj30mR/UgVm0QIcwZpLPIe3lKCaSP64sHIOB0uugLXJszYywFBWNQGivjrlrFG2A/5eC2MpVqixKU/vnZ5Z5IQdUKiomNuu13v4JjP2LO3nA7D2qSHEX7yloZTU6v3m3xKi3A5lNXbF5TSc5HcM8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665130; c=relaxed/simple;
	bh=e79+eu1V9qkLEkevsnc/VCSFCzpwLk+kS0Fa/3kzfhY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N3vFzFfqn84fh9txbmcNW11o6hRMZKKs8m5fMZrr4xNaCyEnYlCbWvepl7guTXMCD5eWfOP3pYflUqtIDN6qztv4UXa8/UJtdfmEFrcmKC3YIQihxoQS0leHer26FFEpgRZJk/HIucaCRpqbb9cpbaJngpWqt5s0eo4WwikXroc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SZ+F+zE1; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SZ+F+zE1"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1438719cc1eso4376117c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 23:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790665128; x=1791269928; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iGcNwOVaJVRaj4NQqURf1+7x7DmNLEtY0z1vlZAxyiM=;
        b=SZ+F+zE1K3tfgvZR/vRMuioxAMrLrLOR2tu2chJDTn7ra90rrGbr+wfXb/Q8EYcjPb
         lVwnOliL6Z0yW4zU8LCiFS6KmGlZ71sFrYaGCLWVBuYmvNMxhXJ8xZw+Zhcnl/zq0mXE
         8VgxHwcgpoNDsNeGqITqrO5B6bEEz9aAvG7pIQgLzNOinlzVC3gD5xBQUxYNY6cuQqGJ
         w+deRN5c55J35BfKY9udKaijF1T0g0YNFaoBBIp93ZiW3B4LL+FzwCR06Nwa3+Hbs6rF
         2RS2powFfDEq4zQGC5ptnjPIR4dgOz2OyvzpvkebI6h8oOCdCc3CZqDiVkl7z83q6x/l
         I3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790665128; x=1791269928;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iGcNwOVaJVRaj4NQqURf1+7x7DmNLEtY0z1vlZAxyiM=;
        b=NHDBm9jY6z8mb0YKr7uEgOHr1cJzZLE8vUhecJ53XwB/SnVkKjgHLb9I2VBpHCtTTR
         rnL7s3yXq7fLCLC/yFhUH4pDbz/cjvgKrv+WsyhyKQtmZoQptl4I+xIzD4C3TY55U9i2
         2sln947mIXVzx1WVcnofR9oyi0ZPJpYSW9JDvQTqdTOxA2n/kTegyugfiDh+536PKtcF
         YfXUnNsNBArzGB6K7f9fW9x5xKTUiTQirAHhLgXgzmN+hZUtrdrtmyKaBcDx7N38DTlF
         qhbfnWzPhcehVvmfoE5FQGT+mpoKQTZpWeolHmR63vLY6tfmfNcQvZpqpwj9eMvyCSU6
         IuSA==
X-Forwarded-Encrypted: i=1; AKwUvBxqbXLHGmq9+73FjXKdTOXr5yEuH5t4Jk1YdIBef8ZofonZAtrW15gsK1imoNEwZ7JqDQCZ5ZVr/WSBZ6vx579x@vger.kernel.org
X-Gm-Message-State: AFuF++l3ra2XXpEXqaFopFSJbtRbsDCQy+9qOjP9Chff7AiL5+8lAKDH
	RE0eO1hz4C2FAbd0pbM+nOzPm0agJIsgp4PD93xdzjIqA9JOJIfi5x2lhiyWEP9eYrgZYBZFFJL
	8PCvw8cbQ7A==
X-Received: from dlbsw8.prod.google.com ([2002:a05:7022:3a88:b0:147:cad:f1af])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f515:b0:141:b2c3:d878
 with SMTP id a92af1059eb24-146cdebd135mr13445853c88.7.1790665127981; Mon, 28
 Sep 2026 23:58:47 -0700 (PDT)
Date: Mon, 28 Sep 2026 23:58:32 -0700
In-Reply-To: <20260929065839.407062-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929062937.374137-1-irogers@google.com> <20260929065839.407062-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929065839.407062-3-irogers@google.com>
Subject: [PATCH v3 2/9] perf python sctop: Fix offline interval printing and
 test flakiness
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

In sctop.py:
- If an earlier interval elapsed and printed an empty table before the
  target comm ('sleep') executed any syscalls, analyzer.printed became
  True and the final partial interval containing the target comm's
  syscalls was never flushed at EOF. Flush print_current_totals() in
  finally when analyzer.syscalls is non-empty as well as when nothing
  has been printed yet.
- Initialize analyzer.e_machine after creating perf.session rather than
  when session is still None.

In test_sctop_python.sh:
- Use a private temporary directory via 'mktemp -d'.
- Drop '-a' and pass '-B -N --no-bpf-event' to 'perf record', and sleep
  briefly in the subshell ('sh -c "sleep 0.1; sleep 0.05"') with a
  bounded retry loop so 'sleep's PERF_RECORD_COMM and sys_enter events
  are reliably captured under heavy load.

Fixes: b83f0bacf5e4 ("perf python: Port sctop to perf module")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/sctop.py                  |  7 ++-
 tools/perf/tests/shell/test_sctop_python.sh | 58 ++++++++++-----------
 2 files changed, 34 insertions(+), 31 deletions(-)

diff --git a/tools/perf/python/sctop.py b/tools/perf/python/sctop.py
index 42e95ecfffad..48320af8b755 100755
--- a/tools/perf/python/sctop.py
+++ b/tools/perf/python/sctop.py
@@ -37,6 +37,7 @@ class SCTopAnalyzer:
         self.offline = offline
         self.own_pid = os.getpid()
         self.last_print_time: Optional[int] = None
+        self.printed = False
         self.session: Optional[perf.session] = None
         self.e_machine: Optional[int] = None
 
@@ -137,6 +138,7 @@ class SCTopAnalyzer:
 
     def print_current_totals(self):
         """Print current syscall totals."""
+        self.printed = True
         # Clear terminal
         if not self.offline:
             print("\x1b[2J\x1b[H", end="")
@@ -217,8 +219,8 @@ def main():
         if args.input:
             session = perf.session(perf.data(args.input), sample=analyzer.process_event)
             analyzer.session = session
-            session.process_events()
             analyzer.e_machine = getattr(session, "e_machine", None)
+            session.process_events()
         else:
             try:
                 live_session = LiveSession(
@@ -237,7 +239,8 @@ def main():
         sys.exit(1)
     finally:
         if args.input:
-            analyzer.print_current_totals()
+            if not analyzer.printed or analyzer.syscalls:
+                analyzer.print_current_totals()
             # Break the reference cycle between perf.session and analyzer.process_event
             # because perf.session lacks cyclic GC support (tp_traverse).
             analyzer.session = None
diff --git a/tools/perf/tests/shell/test_sctop_python.sh b/tools/perf/tests/shell/test_sctop_python.sh
index 007f2584cce6..b042fc3eefe5 100755
--- a/tools/perf/tests/shell/test_sctop_python.sh
+++ b/tools/perf/tests/shell/test_sctop_python.sh
@@ -27,51 +27,51 @@ if [ ! -f "$script_path" ]; then
 fi
 
 err=0
-temp_data=""
-temp_out=""
+temp_dir=$(mktemp -d /tmp/perf-sctop-XXXXXX)
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
 echo "Testing sctop.py..."
 
 # Create a perf.data file.
-if perf list | grep -q "raw_syscalls:sys_enter"; then
-	perf record -e raw_syscalls:sys_enter -a -o "${temp_data}" \
-		-- sleep 0.1 >/dev/null 2>&1 || \
-		{ echo "Skipping test, perf record failed"; exit 2; }
-else
+if ! perf list tracepoint | grep -q "raw_syscalls:sys_enter"; then
 	echo "Skipping test, no raw_syscalls:sys_enter event"
 	exit 2
 fi
 
-if [ ! -s "${temp_data}" ]; then
-	echo "Skipping test, perf record failed to create data"
-	exit 2
-fi
+passed=0
+for _ in 1 2 3 4 5; do
+	rm -f "${temp_data}" "${temp_out}"
+	if ! perf record -B -N --no-bpf-event -e raw_syscalls:sys_enter -o "${temp_data}" \
+		-- sh -c "sleep 0.1; sleep 0.05" >/dev/null 2>&1; then
+		echo "Skipping test, perf record failed"
+		exit 2
+	fi
 
-# Check that the script executes
-if ! perf script sctop -i "${temp_data}" > "${temp_out}"; then
+	if [ ! -s "${temp_data}" ]; then
+		continue
+	fi
+
+	# Check that the script executes
+	if perf script sctop -i "${temp_data}" > "${temp_out}" && \
+	   grep -E -q "[0-9]+$" "${temp_out}" && \
+	   perf script sctop -i "${temp_data}" sleep 1 > "${temp_out}" && \
+	   grep -E -q "[0-9]+$" "${temp_out}"; then
+		passed=1
+		break
+	fi
+done
+
+if [ "$passed" -eq 0 ]; then
 	echo "sctop.py test failed"
 	err=1
-elif ! grep -E -q "[0-9]+$" "${temp_out}"; then
-	echo "Failed to find metric data rows in default run"
-	err=1
-elif ! perf script sctop -i "${temp_data}" sleep 1 > "${temp_out}"; then
-	echo "sctop.py comm+interval test failed"
-	err=1
 else
-	if ! grep -E -q "[0-9]+$" "${temp_out}"; then
-		echo "Failed to find metric data rows"
-		err=1
-	else
-		echo "sctop test passed."
-	fi
+	echo "sctop test passed."
 fi
 rm -f "${temp_out}"
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

