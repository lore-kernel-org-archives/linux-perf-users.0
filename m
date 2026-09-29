Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ACB3A0B24
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 02:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790648378; cv=none; b=mqUyAgjV3rnxhWCW3Vf6EBxss8H8xQB9Qdk5PUYmeQpv+qVfNJe/SQlHJioXjJzIXV/2j3toW1hl7XjVdgzxBZsdRUGwlP0ZcCuScqSJfo+Q6YngspEx2V5uTsjZOygYmcuIW7qqwn+BP30W3Q7L5rlVmFxKj4Jyb7KsZgkaLY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790648378; c=relaxed/simple;
	bh=9dnCnm0obUdo2EqOcPv85Krg2CWY6/1fPUxNbupSKAU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IkJipgBNFox+oHNT902KuQ6/EQ7r9OR0jHK1acezTnUBAKJE8eJCAULISnk4LR71aerCuRvPjDllHsD3wo/3jL6v/nWOKdtDLj1h36P74t7cg4yQBWHI65ZwIAtXwnStaaozA/EXBqPC6rRRHOA1P47H+EjZaooPTc/2071fozA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pDr8uA7C; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pDr8uA7C"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3437d0cc8c7so1221784eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 19:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790648376; x=1791253176; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dnibIJ+lZBQ1CeVh0g9DN0YYOUBh+70fdfgpvSaop2o=;
        b=pDr8uA7CYldxX8JfPT/Pnrdr+UHFxa/w48DFu7x20Fng8bA8j5px5fxQg0LRghZuJ7
         35sb1IYIjBA1AZg5QlarCYzCcNThti39Sy8twfiIpX9gv634a4lykxHbnbZTjV2Q6+kF
         mSVQl1DEJK5Y4Ks2YaiSfTxSjrfPejMi4QSc4jQldww7OqzUVlOXOiCaW41WZloZHPWB
         b/k+K2E1P+8cV6Ka4+uHZMt3voYdIl5sERj1d5mHPn5Lua9sjK0LvT6AKwIOy0IeS/mp
         im4H0soyBLpCDptWhkfB1/4h0t5o/Lbj9l/xO9ukLsWGUh9ydgOYDZ/p7IKOGtasupGS
         h1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790648376; x=1791253176;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dnibIJ+lZBQ1CeVh0g9DN0YYOUBh+70fdfgpvSaop2o=;
        b=rBWoli/nu+orrYnMHfzYlVDVirPQXWc7SOYudR4L4tRE6oeWro7MlEA7JYIPeMV7s2
         0CLLXVSNYoOAbw/aHE1wx3WZSKISYfvRVp2CzRauDIK58WAlgQVntc9F/8Qmfv72BBXs
         O/rNbNmmIqnT36m4T/QWaawfyr2GsEz/bb3hy5cmRa9KQ5yZsz/PdYc+cCyRKqa9a95/
         sq1qLBB5hFEz2KKdDfoaBuGbT/pvFLCEbXKFwzEd70p6MnRmoWkuLT4/zWu0DXmlQB9p
         8ioQzrwbqAuAHxiXHdjpesGqgvyUeWWOjbLanr5tBVwoY2J0vs9A/M7a3Hdtagv9g1+P
         nAUg==
X-Forwarded-Encrypted: i=1; AKwUvBxsLiMnjW0Ortl84vcMg3bNj8MZqoZRlZC3Y3woSHT1qm7PwviRqyxWxwhY5aFHUYEcn0cH3j9v3IKqHdCbccIA@vger.kernel.org
X-Gm-Message-State: AFuF++mdxcp1kTUS+8xNBtVpryigOhEPYPrJADkbuT3ikiBLGQbSeqQx
	kvoYuhNs2yof0az7zMoM0/CbUI5l8lt6h/aDIJVfJrJ/3bdC0M2/cY1Pbd5FYQJN/vN0LwgDp1s
	BafszFvCA6Q==
X-Received: from dlbuj9.prod.google.com ([2002:a05:7022:3d89:b0:144:c124:514e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:907:b0:144:fb71:dbd5
 with SMTP id a92af1059eb24-146cf02c021mr13868321c88.21.1790648375026; Mon, 28
 Sep 2026 19:19:35 -0700 (PDT)
Date: Mon, 28 Sep 2026 19:19:07 -0700
In-Reply-To: <20260929021913.56010-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929021913.56010-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929021913.56010-4-irogers@google.com>
Subject: [PATCH v1 3/9] perf python stat-cpi: Fix live mode signal races and
 test flakiness
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In test_stat_cpi_python.sh, 'perf test -w noploop &' defaults to a
1-second duration and can exit under heavy parallel load before
'perf stat -p' and 'perf script stat-cpi' finish starting up. In
addition, the fixed 'sleep 0.5' before sending SIGINT can fire before
Python finishes importing the perf module, opening the live evlist, and
flushing the first interval.

In stat-cpi.py, register SIGINT and SIGTERM handlers before calling
_open_live_evlist() and pass flush=True when printing live output so
redirected stdout is flushed immediately after each interval.

In test_stat_cpi_python.sh, run 'perf test -w noploop 60 &' so the
target workload stays alive until killed, and poll the output file for
'cpi' (up to 5 seconds) before sending SIGINT.

Fixes: 4425182d426b ("perf python: Port stat-cpi to perf module")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/stat-cpi.py                 | 19 ++++++++++---------
 .../perf/tests/shell/test_stat_cpi_python.sh  | 12 +++++++++---
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/tools/perf/python/stat-cpi.py b/tools/perf/python/stat-cpi.py
index 0b7d76876a6c..da92cf560067 100755
--- a/tools/perf/python/stat-cpi.py
+++ b/tools/perf/python/stat-cpi.py
@@ -106,7 +106,8 @@ class StatCpiAnalyzer:
             if ins != 0:
                 cpi = cyc / float(ins)
             t_sec = timestamp / 1000000000.0
-            print(f"{t_sec:15f}: cpu {cpu}, thread {thread} -> cpi {cpi:f} ({cyc:.0f}/{ins:.0f})")
+            print(f"{t_sec:15f}: cpu {cpu}, thread {thread} -> cpi {cpi:f} ({cyc:.0f}/{ins:.0f})",
+                  flush=True)
 
     def read_counters(self, evlist: Any) -> None:
         """Read counters live."""
@@ -173,19 +174,19 @@ class StatCpiAnalyzer:
 
     def run_live(self) -> None:
         """Read counters live."""
-        try:
-            evlist = self._open_live_evlist()
-        except OSError as e:
-            print(f"Failed to open events: {e}", file=sys.stderr)
-            sys.exit(1)
-
         def handle_signal(_signum: int, _frame: Any) -> None:
             raise KeyboardInterrupt
 
         signal.signal(signal.SIGINT, signal.default_int_handler)
         signal.signal(signal.SIGTERM, handle_signal)
 
-        print("Live mode started. Press Ctrl+C to stop.")
+        try:
+            evlist = self._open_live_evlist()
+        except OSError as e:
+            print(f"Failed to open events: {e}", file=sys.stderr)
+            sys.exit(1)
+
+        print("Live mode started. Press Ctrl+C to stop.", flush=True)
         try:
             while True:
                 time.sleep(self.args.interval)
@@ -195,7 +196,7 @@ class StatCpiAnalyzer:
                 self.data.clear()
                 self.recorded_pairs.clear()
         except KeyboardInterrupt:
-            print("\nStopped.")
+            print("\nStopped.", flush=True)
         finally:
             evlist.close()
 
diff --git a/tools/perf/tests/shell/test_stat_cpi_python.sh b/tools/perf/tests/shell/test_stat_cpi_python.sh
index fe7562307634..6cb376c92e2f 100755
--- a/tools/perf/tests/shell/test_stat_cpi_python.sh
+++ b/tools/perf/tests/shell/test_stat_cpi_python.sh
@@ -50,7 +50,7 @@ test_live_mode() {
 		echo "perf stat failed (permissions?), skipping live mode test."
 		return 0
 	fi
-	perf test -w noploop &
+	perf test -w noploop 60 &
 	workload_pid=$!
 	if ! perf stat -e cycles,instructions -p "$workload_pid" -- sleep 0.05 2>/dev/null && \
 	   ! perf stat -e cycles:u,instructions:u -p "$workload_pid" -- sleep 0.05 2>/dev/null; then
@@ -61,10 +61,16 @@ test_live_mode() {
 	fi
 	ran=1
 
-	# Run live mode for 1 interval in the background, give it a tiny sleep, then interrupt
+	# Run live mode in the background, wait until at least one interval is
+	# printed, then interrupt.
 	perf script stat-cpi -I 0.1 -p "$workload_pid" > "${temp_out}" &
 	pid=$!
-	sleep 0.5
+	for _ in $(seq 1 50); do
+		if grep -q "cpi" "${temp_out}"; then
+			break
+		fi
+		sleep 0.1
+	done
 	kill -INT "$pid" 2>/dev/null || true
 	set +e
 	wait "$pid"
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

