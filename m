Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8784C378806
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573153; cv=none; b=ASBDsA8hC8GWBgPyodDSEKLgqTTTJQar/hfINMml/OhWobnM3xCbsPzLMUj/Z0Lc1n7iuIXhi/NwuY81CMxs/euKglImZfqmgKeQrKr7STBcjuXYLRl7ouHkJPJJgmx1V0Bd5NimY1h+l60z++skefv98J3OsAQE63eoZNxkGbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573153; c=relaxed/simple;
	bh=Xl/Z23Ywp7doqIRABOZcKj/6xeZj1hOnZyU4+ckoqQM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=jH1qIEgCFqgv2SZR4C9YhG4kvk6wDz0tcDl4uAvewcPO9uGBELgp7pnVhUX0FFGy3C4HzgxA0gHC2VprElomLnbUG97xeI0ArdY4cWjtSYPdLdUWjaYNVJfuIpMge+9Cip89zp+Q2kJHCSfg5CJjHhix4aXcYNCDAO6D8oM0yK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pzSUtkry; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pzSUtkry"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304e7fc90b1so4526945eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781573152; x=1782177952; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LKTxltXDjiPQ1t4wRosfkoNKM6z5rj9TW2X9tI16Pak=;
        b=pzSUtkryI9tyMh13Dla+vxgMulfDAoP6HlgilacVV6b6SqQU7EGELKuk+DQ1pAQ6Wv
         QSIXRUprd97JGWpYJMwKbbAYgPAgiwXpI10A0ePePrK9mZvpggbhhGdavV310sHDXVv9
         mi4Np0ZPSlWx3s5guF2rXfJHKCV5R+cYzI+4h5NEuwSs/mjmI3mOffNwDsjBQ/ouEept
         C7Spf9prIu8Jlz4C2K5pyMgsmS9kACVBWnOsGEiZCSLNDMGOXy35tVBtl8BSyHFzrdMS
         BF+C4gQfjk3FYfPME5+j2HiW5HFrTIA12e/ugvtr78Ehl1DxWZ7d+62ekiM2AIXq5yxR
         BMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781573152; x=1782177952;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LKTxltXDjiPQ1t4wRosfkoNKM6z5rj9TW2X9tI16Pak=;
        b=jvYTsHfBQh3Ak+NCsbMxsMEjfF47xLiG+C/brhen1oIkAfNG759+lzmkvy4SljEpif
         6QqVBfEYSm/O/U4jKE5DjILThhRDUA2YleB8XTBZ5pdNSdu7fmyuk9bnQO+DPk/Vnsfd
         BmZGruWi03HgAXjpIvU6G2WEp/xjVgo88vfS2Q+x48pUHCu3vdFkrQSlWrzAlqahQ5hg
         kyIsIguzSBZkTrsCuZmovS9RGC4DW5Fh+jiFEx6KxVGKwXkv6/xvVbOp+qc7xzoq9PxR
         JPmuywp4Q13Z6wvWzxJkZASQ0ttIgswzyb+rA7j25Kflar0yo3we9EGZ5C228yjn+A49
         pf5A==
X-Forwarded-Encrypted: i=1; AFNElJ8Hi+86SJp7IyRVJzMn3KpJaR99SGATHua8N7v4R5WzwaWkLhQUhaYL3ApPw0Q4oiz/BfFigpoxKdYQ4nw6RqoT@vger.kernel.org
X-Gm-Message-State: AOJu0YxrOxbhU2rxYcwHFnwIvtegIp+3tws3enU+pZcAa1jWDabiPg/+
	hen7rrY2KHvG/0PuiaZb0jquufyp764ClioxAhlGK5fgn4ktv/3pwJUevk3HHK1+1J71j2EK0no
	VNnUIHubA4g==
X-Received: from dybff23.prod.google.com ([2002:a05:7300:bf17:b0:2ee:de47:cde3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:4355:b0:2ed:e14:42e9
 with SMTP id 5a478bee46e88-30940357f24mr8449584eec.34.1781573151221; Mon, 15
 Jun 2026 18:25:51 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:25:16 -0700
In-Reply-To: <20260616012521.4045202-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616012521.4045202-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616012521.4045202-8-irogers@google.com>
Subject: [PATCH v1 07/12] perf tests: Fix flakiness in trace record and replay test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Leo Yan <leo.yan@arm.com>, Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The `perf trace record and replay` test fails intermittently on slow or
virtualized hosts because the default recording workload (`sleep 1`) occasionally
completes without scheduling the target `nanosleep` or `clock_nanosleep` system
calls inside the recorded sample window, resulting in the error:
`Failed: cannot find *nanosleep syscall`.

Generalize the `perf_record_with_retry` helper in `tests/shell/lib/perf_record.sh`
to support a custom record command prefix via the `PERF_RECORD_CMD` environment
variable (defaulting to "perf record").

Update `trace_record_replay.sh` to use this robust retry loop running with
`PERF_RECORD_CMD="perf trace record"` and a base workload of `sleep`. The test
will automatically retry with scaled sleep durations (from 0.01s up to 2.0s)
until the required `nanosleep` event is successfully captured.

Fixes: 15bcfb96d0dd ("perf test: Add trace record and replay test")
Signed-off-by: Ian Rogers <irogers@google.com>
TAG=agy
CONV=7e7ee33a-e940-4a8a-8e64-878da6a68b59
---
 tools/perf/tests/shell/lib/perf_record.sh     |  7 ++++++-
 tools/perf/tests/shell/trace_record_replay.sh | 18 ++++++++++++++----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/shell/lib/perf_record.sh b/tools/perf/tests/shell/lib/perf_record.sh
index c5de25244770..5c7feb294ebb 100644
--- a/tools/perf/tests/shell/lib/perf_record.sh
+++ b/tools/perf/tests/shell/lib/perf_record.sh
@@ -21,9 +21,14 @@ perf_record_with_retry() {
   local duration
   local first_run=true
   local ret=1
+  local cmd_prefix="perf record"
+  if [ -n "${PERF_RECORD_CMD}" ]; then
+    cmd_prefix="${PERF_RECORD_CMD}"
+  fi
+
   for duration in 0.01 0.1 0.3 1.0 2.0; do
     rm -f "${perfdata}" "${perfdata}".old
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
2.54.0.1136.gdb2ca164c4-goog

