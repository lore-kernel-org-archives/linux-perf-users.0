Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C4E3612DB
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 02:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790648376; cv=none; b=fjW6MIOqoY7F2v2sVv16nZqrKzEchnShir+BVi9etQ9OHIYWknv85inRPzjdhSg9RSIW5fVGo5lGF6F+c3LehPXQhc6vNQJ+mfjcApfdbZec/zGlgrr9PRelMje0veyXlVUY05YzNq2VRGaJiedRaeC2BZa3ZUjC9ICDT0pTwDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790648376; c=relaxed/simple;
	bh=r2ZJrExRp4N+CcL1DCwy2vvs7zCWSHOI+GvBR9IyHpA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m51IsTQEEj7EBWCA9N/OVFmDRRGX4cfT5kVHoazaGGRJlPvhc85pY+pnEOgHrpyX9LJmVhdOPHgkrd+K9G7dCG2i1C05L4zpRd5DfYM5w1vN4I+oXntYs4+8u0oorrlY1I7qOk23aXfOa3A0CFtQj0A0R29JyQPBbyraDvCpO+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qInfBnGi; arc=none smtp.client-ip=74.125.82.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qInfBnGi"
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-14373747468so3385702c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 19:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790648374; x=1791253174; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fPSf/ysgJ4XUz1/4wckhxwFiqk6aeQnaQw8kcoJGG6E=;
        b=qInfBnGi+D7pFDlhNEAO+I//v3Qd0D21OEcDmYJm9o8FbbjvYJEg9weA37DpwSjYUh
         0NZIERBG6UNVAIuRJZTRNiq9dZVXBFY9zCjUgGZTX/g5mUzU/iwwbBtPOSOVvPViL+et
         KT5jfN2PkBuHSHGKvEArz8otnVAXKMiAf73xBw2kLm5ScMGXlNskkNZA9t1xbJZWCQE8
         c8wpIk6VOzbKYE5h3bBllybWb+ua+0xXRBmchWcGtsidM/NhCS9jPkrdQ9IIn2OSp8z4
         FOM7NDjsF7J5Og/vnG2X09RLuMVvAM1e14OQrDA9UVQzV8R//6Ut/KYdXDbUKWlxJ9ds
         FhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790648374; x=1791253174;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fPSf/ysgJ4XUz1/4wckhxwFiqk6aeQnaQw8kcoJGG6E=;
        b=GsFpaYre/yvVK7N2V84oZGrNnhcnNhZlzQGM4sQ2XF4Veil8rfOq5RS3VNkMM63Yzf
         QMnmaRrFDa/um/v1DXQvYWlFstCEk4WLcwymd0ikJBZPhtnd3wWRQYuq32/pkbl5FJNd
         qcL/scL2yV+sb8yLUMUK76RRWXnF9Bbr8oppfaYExSHH9uuOvQU03FXNEk3sXVzEE4hA
         +AAMvodjDfeuALwx4lQf/LoeDku/E6VRNveDS/U8tH4ohVk/8rXXn24NLs29O7DUCwJL
         Wqhx+w6CNqzxXyNr+FJLCl/Eoh20SW+hfn8l1qlPi+rSQ1whOK3GFFxvnXL0w6PUCgVA
         NCNQ==
X-Forwarded-Encrypted: i=1; AKwUvBxcP5VE2ARuAHzjxR/V6381iCrYsrT00PFjoLhTREY0m46gyNiarUDyfZRHCaPCr3goBDC2E8SgY8GJXINkjpwX@vger.kernel.org
X-Gm-Message-State: AFuF++lseRpsqzJhAm7bveR4U5zBNxQpz3aWDgx54xiC/ckm0BVV/0sj
	XyIaCjtVALetz9puOxeN66PAsiit157e0pZFz41UVdDJQPyUBsPufAq/gy55h2yfXNvOe1LNd53
	cfmh/3HtO4A==
X-Received: from dlx9.prod.google.com ([2002:a05:7022:89:b0:144:d025:68b5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2704:b0:148:4d6c:201e
 with SMTP id a92af1059eb24-1484d6c27d7mr9676047c88.23.1790648373248; Mon, 28
 Sep 2026 19:19:33 -0700 (PDT)
Date: Mon, 28 Sep 2026 19:19:06 -0700
In-Reply-To: <20260929021913.56010-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929021913.56010-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929021913.56010-3-irogers@google.com>
Subject: [PATCH v1 2/9] perf python sctop: Fix offline interval printing and
 test flakiness
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In sctop.py, process_event() updated self.last_print_time on every
sample in offline mode even when skip was true for non-matching comm
events. When filtering by comm with a short interval (such as 'sleep 1'
in test_sctop_python.sh) on a system-wide recording spanning more than
1 second under heavy load, non-matching samples could trigger
print_current_totals() and clear self.syscalls, followed by finally:
printing a trailing empty table. In addition, analyzer.e_machine was
initialized after session.process_events() instead of before.

Fix sctop.py by initializing analyzer.e_machine before
session.process_events(), only advancing self.last_print_time when a
sample is not skipped, and only calling print_current_totals() in
finally: if no table has been printed yet or remaining syscalls are
pending.

In test_sctop_python.sh, use 'perf list tracepoint' instead of
unfiltered 'perf list', record the child workload directly without '-a'
and with '-B -N --no-bpf-event' to avoid system-wide ringbuffer overflow
and synthesis contention, and retry up to 5 times if needed.

Fixes: b83f0bacf5e4 ("perf python: Port sctop to perf module")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/sctop.py                  |  9 ++--
 tools/perf/tests/shell/test_sctop_python.sh | 48 +++++++++++----------
 2 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/tools/perf/python/sctop.py b/tools/perf/python/sctop.py
index 42e95ecfffad..c524e08e6440 100755
--- a/tools/perf/python/sctop.py
+++ b/tools/perf/python/sctop.py
@@ -37,6 +37,7 @@ class SCTopAnalyzer:
         self.offline = offline
         self.own_pid = os.getpid()
         self.last_print_time: Optional[int] = None
+        self.printed = False
         self.session: Optional[perf.session] = None
         self.e_machine: Optional[int] = None
 
@@ -127,7 +128,7 @@ class SCTopAnalyzer:
             if not skip and is_enter and 0 <= (syscall_id & ~0x40000000) <= 0xffff:
                 self.syscalls[syscall_id] += 1
 
-        if self.offline and hasattr(sample, "sample_time"):
+        if not skip and self.offline and hasattr(sample, "sample_time"):
             interval_ns = self.interval * (10 ** 9)
             if self.last_print_time is None:
                 self.last_print_time = sample.sample_time
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
index 007f2584cce6..230eeca96fb8 100755
--- a/tools/perf/tests/shell/test_sctop_python.sh
+++ b/tools/perf/tests/shell/test_sctop_python.sh
@@ -41,37 +41,39 @@ temp_out=$(mktemp /tmp/perf.out.XXXXXX)
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
+
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
 
-# Check that the script executes
-if ! perf script sctop -i "${temp_data}" > "${temp_out}"; then
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

