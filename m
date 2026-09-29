Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E60946EF9E
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 06:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665132; cv=none; b=Xs9BYCVKeJgan+5Z428VMGUof55dKtYrD+bvdMrKzQSnQ7pFofStWhAc5adveuTogy4gfTm7hTe2WCgKhe1hp+EWR+BdrAlEZH1oGa5J7iUQwNit00I56r6IM9xenfv5gz3RmMSXNbsibLg4XwMAoz7LN7z+gGliLQQXBB6MSEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665132; c=relaxed/simple;
	bh=p7uYPdoR9kudDdm4/sicZyzpoCARfMYWmtEXFg75M78=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LfHIA2amz1cmAesm/W5MZV7i1vI7GR5q9xStElBe6Fse5xptUiBUrTryLXVJC+BHd1fagE1WjbJXaNbj2mIaYk2wzDWE6AFL3Jv7E6W4CljOLe7k96s7B3R7bq1aECri2iyclAUSX7P/sie4MLHfxu2gF1pK/3yGaM5W6fRkLT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jRmVbIHd; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jRmVbIHd"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1383723dfddso2621038c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 23:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790665130; x=1791269930; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LQWkl/J5X1DzD2k6HWizg1Qj1TqRIGVpe24c782LeFc=;
        b=jRmVbIHdZUXbEcl5iFdBtAJbdTrnXhuuSMEP/jxDIMIpg+SRfu0fnAwxRfJnkcMcth
         vpzuEF675VERZwzwkaOwpqDYg/TFtUFmjr7qyDwP7AuyEiAXaNiOmO8BtkjKOz28U5dX
         sjGPzfVu5HN1zJI/XshjPJ7jOML6TrZfD3rCtKrYh0DikYsqfiCndIzRLjnBCaOrl6yR
         uloP33+aUiuagZpMFa8Kw8PX1WfPehBMudphlbn5Nsk/6PPTz9htF6UHwnX1LH6NubJY
         MHRkEclLwi60UcZYmy2ZGPRs/ERxxo29FDHcTDb0/qRYmaz/ANs4eb/ohUljJ9OkkUZJ
         zLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790665130; x=1791269930;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LQWkl/J5X1DzD2k6HWizg1Qj1TqRIGVpe24c782LeFc=;
        b=yvxout3Jl2oX2mKHOHrL1GgynOKwdmnmYnhdMhy/icY/Ky8Wg9WB1EYvlm03cquqlf
         1pYg9ldokLZxOqQBe0o1BDPk8nsX9Wq0QknYIwVuApDzuXQa0e0a9UeNCIhX8A4llsSO
         DHnYeeT4jz1XfRGUMfvxsQQLeQ0qkRKncUl6h+VoHtVAgZsnpYYlL1hL0/qxA5iOr5SO
         0hz+EucJkukJ2BsIghh2684GRQYkgIeERdH9qp6EXWqDTwzZK/J5Pz0scS2J4XHVAEKV
         XPsUz/KOi+9aDkZzyKO0D/MbRanPaltSLkkZHjPMLsi4AQyzU1vDIts58FucGR9o7A64
         bfwA==
X-Forwarded-Encrypted: i=1; AKwUvBys9vY09ieIvnak+bNr/d6IAkr7gjctHzqBUEc5Apsm+0QmPz/z90+Yjj/txOyWAp/yPhAqXSnHTJ3Esf//GOyg@vger.kernel.org
X-Gm-Message-State: AFuF++kWVHLRUjrSAwqfHKeRY9D2sdvCd86x9shEWcQ4qHh2kr8pZ+s7
	VesPmMa+CfKGNFP1H3OgRKHKvRziEHEMHwKDjEIey6uiHuFNhCfctg69zF3/zlmmURyI3K5t5xk
	s1YhtBKjKDQ==
X-Received: from dlbsw8.prod.google.com ([2002:a05:7022:3a88:b0:144:c32a:6a84])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea8e:b0:14a:8df8:56c5
 with SMTP id a92af1059eb24-14a8df85d22mr3299311c88.26.1790665129725; Mon, 28
 Sep 2026 23:58:49 -0700 (PDT)
Date: Mon, 28 Sep 2026 23:58:33 -0700
In-Reply-To: <20260929065839.407062-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929062937.374137-1-irogers@google.com> <20260929065839.407062-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929065839.407062-4-irogers@google.com>
Subject: [PATCH v3 3/9] perf python stat-cpi: Fix live mode signal races and
 test flakiness
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
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
 tools/perf/python/stat-cpi.py                 | 32 +++++++++++++------
 .../perf/tests/shell/test_stat_cpi_python.sh  | 12 +++++--
 2 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/tools/perf/python/stat-cpi.py b/tools/perf/python/stat-cpi.py
index 0b7d76876a6c..b4ec87b07938 100755
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
@@ -151,6 +152,7 @@ class StatCpiAnalyzer:
 
         last_err: Optional[OSError] = None
         for events, tmap in candidates:
+            evlist = None
             try:
                 evlist = perf.parse_events(events, None, tmap)
                 for evsel in evlist:
@@ -161,32 +163,41 @@ class StatCpiAnalyzer:
                 evlist.enable()
                 return evlist
             except PermissionError as e:
+                if evlist is not None:
+                    evlist.close()
                 last_err = e
             except OSError as e:
+                if evlist is not None:
+                    evlist.close()
                 if e.errno == 13:
                     last_err = e
                 else:
                     raise
+            except BaseException:
+                if evlist is not None:
+                    evlist.close()
+                raise
         if last_err is not None:
             raise last_err
         raise RuntimeError("Failed to open events")
 
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
+        evlist = None
         try:
+            try:
+                evlist = self._open_live_evlist()
+            except OSError as e:
+                print(f"Failed to open events: {e}", file=sys.stderr)
+                sys.exit(1)
+
+            print("Live mode started. Press Ctrl+C to stop.", flush=True)
             while True:
                 time.sleep(self.args.interval)
                 timestamp = time.time_ns()
@@ -195,9 +206,10 @@ class StatCpiAnalyzer:
                 self.data.clear()
                 self.recorded_pairs.clear()
         except KeyboardInterrupt:
-            print("\nStopped.")
+            print("\nStopped.", flush=True)
         finally:
-            evlist.close()
+            if evlist is not None:
+                evlist.close()
 
 def main() -> None:
     """Main function."""
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

