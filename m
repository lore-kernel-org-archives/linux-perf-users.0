Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED90F47A0B2
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628521; cv=none; b=R1f2TJfvM5BochysOWBBw9s37bfxhWlAaN8j8a7Wryo7AT5DePCCOG3NdZMzG5tF4iRDwNFmPY/7MrHuT0VMmQy1bpp163vz7Vywx5xv9Bbqf5ypngVZMcvtyOZCWEJJpF5jlVkhrFLzpP7IPY5UHvVvGHL7wzkXq+ovlSAO+b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628521; c=relaxed/simple;
	bh=B6eOW9slbp0SvmphhK09RwPFVo/eVRx11oUnhtzUl7Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P5MtSmnjhTIMUV///yCce3GKZ0wNRDKl8Vu2OtnXTzyeQE7Y/lKL7mba5oOuN7qHUzwkR+zjFvFzWhPEpzNPVtv4zt26bFP7BvvPVIs8vjBL+IqUBW1w4nSNXQC7Hgy70tjvtrfFs2w2d+fjrfwansmbz/30PPF/lsjcYE6b+Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BZuUT99E; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BZuUT99E"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-308004a2c49so2946037eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 09:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781628519; x=1782233319; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yt+vvSs6hhNswGT6yyjrsAwHjzTJ6vjlaYg/hJd5CQw=;
        b=BZuUT99EymS1F1Avoac1ibxvnOclqWleeFDlVUQTn9KBM0p039qaRTsQqeoYYMkIab
         HDpgMWbmYFapN26RMBDehGl6SB50/dSvR1sLU0sMZ+sCdv5xJZFeXq881HQlYvThLdwt
         jBM1XCmfCQODeqPV01Db184TiHXKWq7K42taiNiSK3bgb8A+LpchmclZ0rO/uQDo9iQU
         EByQ2WHc/ugMZDonGqW10B45BV6kTK3pAyAAZ5sv7plpu1E9lqTm5/pvfqKV7qbUgRsO
         lkh5IUA8twhzrrtDC+LSyCD+kXdI1zvQY5Pc8xMySdfq1LmB+zAp8ZUmUhK2xvrh7l1m
         lwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781628519; x=1782233319;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yt+vvSs6hhNswGT6yyjrsAwHjzTJ6vjlaYg/hJd5CQw=;
        b=RqGIOrYYIsuMFahCQThs0mhCzCCWOdwwyqcxOBnjBeENQXQeIezbEunJUxPgBfnHJu
         MnpdWsoRmovepbdVU77vsOLEvUvdfXcJvLlkNySwciecy1VrRdfiyrqiql34ZdS8iGy3
         6yKy5qBC5HLKaQmHfYl4PK2p0e6e0AVp8BtV2H+/kMjV0rGIR52DITC5LlYub5pk6PMK
         jIS5r1Jz5o78A21fX4GcuYpeTmiSfsh9Cw8JHHbAAsBNIeBF443O5m483F2w0T8uV2jl
         K058OxXVSpUnDq1ZdP/vufSHM9Alto/IituftxfVbs+KNlN2Ptnz8AuF0fgkc2Apuhn2
         5bvA==
X-Forwarded-Encrypted: i=1; AFNElJ9DMWqIK+WcdgEwfmr3PkYD8xfc66Y5MCa8tXmX8cutgpIOtfVruCq8o1ozfp2dzIl14nqIFKqBLGeLNiankwZ+@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6+Xlwo5bPMbwGcKB/Xk9iNTCzFkcMEhfTwT/hLfeHY37a7+uG
	8vjLDLcYaTwwKW4TsxqdqPNQweg3FIeE4UnJJQ6M4YNj0K1PhwjuYCHY4NsCHyqfcKJWFbEP9Zs
	/iA8A+C67zw==
X-Received: from dycsb13.prod.google.com ([2002:a05:693c:300d:b0:2ee:2c3a:8aaf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2211:b0:30a:e52f:9bcf
 with SMTP id 5a478bee46e88-30bc9ab2f4bmr88213eec.10.1781628518873; Tue, 16
 Jun 2026 09:48:38 -0700 (PDT)
Date: Tue, 16 Jun 2026 09:48:12 -0700
In-Reply-To: <20260616164819.370939-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616061404.41929-1-irogers@google.com> <20260616164819.370939-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Message-ID: <20260616164819.370939-8-irogers@google.com>
Subject: [PATCH v3 07/13] perf tests: Fix flakiness in trace record and replay test
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	thomas.falcon@intel.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The `perf trace record and replay` test fails intermittently on slow or
virtualized hosts because the default recording workload (`sleep 1`)
occasionally completes without scheduling the target `nanosleep` or
`clock_nanosleep` system calls inside the recorded sample window,
resulting in the error: `Failed: cannot find *nanosleep syscall`.

Generalize the `perf_record_with_retry` helper in
`tests/shell/lib/perf_record.sh` to support a custom record command prefix
via the `PERF_RECORD_CMD` environment variable (defaulting to "perf
record").

Update `trace_record_replay.sh` to use this robust retry loop running with
`PERF_RECORD_CMD="perf trace record"` and a base workload of `sleep`. The
test will automatically retry with scaled sleep durations (from 0.01s up
to 2.0s) until the required `nanosleep` event is successfully captured.

Fixes: 15bcfb96d0dd ("perf test: Add trace record and replay test")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/lib/perf_record.sh     |  7 ++++++-
 tools/perf/tests/shell/trace_record_replay.sh | 18 ++++++++++++++----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/shell/lib/perf_record.sh b/tools/perf/tests/shell/lib/perf_record.sh
index e137fa75370d..2b9e11b66dc7 100644
--- a/tools/perf/tests/shell/lib/perf_record.sh
+++ b/tools/perf/tests/shell/lib/perf_record.sh
@@ -24,9 +24,14 @@ perf_record_with_retry() {
   local duration
   local first_run=true
   local ret=1
+  local cmd_prefix="perf record"
+  if [ -n "${PERF_RECORD_CMD}" ]; then
+    cmd_prefix="${PERF_RECORD_CMD}"
+  fi
+
   for duration in 0.01 0.1 0.3 1.0 2.0; do
     rm -f "${perfdata}".old
-    perf record "$@" -o "${perfdata}" ${testprog_base} ${duration} > "$logfile" 2>&1
+    ${cmd_prefix} "$@" -o "${perfdata}" ${testprog_base} ${duration} > "$logfile" 2>&1
     local record_exit=$?
 
     if [ "$first_run" = true ] && [ $record_exit -ne 0 ]; then
diff --git a/tools/perf/tests/shell/trace_record_replay.sh b/tools/perf/tests/shell/trace_record_replay.sh
index 88d30a03dcec..f27e32b18697 100755
--- a/tools/perf/tests/shell/trace_record_replay.sh
+++ b/tools/perf/tests/shell/trace_record_replay.sh
@@ -6,16 +6,26 @@
 
 # shellcheck source=lib/probe.sh
 . "$(dirname $0)"/lib/probe.sh
+# shellcheck source=lib/perf_record.sh
+. "$(dirname $0)"/lib/perf_record.sh
 
 skip_if_no_perf_trace || exit 2
 [ "$(id -u)" = 0 ] || exit 2
 
 file=$(mktemp /tmp/temporary_file.XXXXX)
 
-perf trace record -o ${file} sleep 1 || exit 1
-if ! perf trace -i ${file} 2>&1 | grep nanosleep; then
+check_nanosleep() {
+  perf trace -i "${file}" 2>&1 | grep -q nanosleep
+}
+
+PERF_RECORD_CMD="perf trace record" perf_record_with_retry "${file}" "check_nanosleep" "sleep"
+err=$?
+
+perf_record_cleanup
+rm -f ${file}
+
+if [ $err -ne 0 ]; then
 	echo "Failed: cannot find *nanosleep syscall"
 	exit 1
 fi
-
-rm -f ${file}
+exit 0
-- 
2.54.0.1189.g8c84645362-goog

