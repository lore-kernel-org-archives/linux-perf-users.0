Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3421B3822A8
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573285; cv=none; b=PARecpA0SyLgPs7wm6WPEJc40l3rIG6BN8pzps3Z3GKisIFov8Dh3EAjilg7ByIF/YNQQRn3rEfqsvyZtvhqFwSY3SHkD091IX/lDPRWCzjknRJasNRHGnR9KetSDuvD7mZhExS+lw+W7Iygt7/ytIEjTdroPHI2NS6iNZ0bHV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573285; c=relaxed/simple;
	bh=+m67fhKQcnMHZtzQqE9cCyp9n3Q8wVYEuFBL3/r/VqU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=R4uj7DW8GEO8jx0JqRB7VvhSzlz9X07wMBW0H3lmYezkpGo9WSLJMs+zBvxpBgl4OmTkY1+TOao4Y8pj2DJXp3FVm1er7ymF+i0Ca+fdBjLbyV0YOjQgpV0Gvn+asKZPsrkMH7Gt3PfFrysN7Fl7MqQVoqQ8EF7wTYxG+8bRcSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qWh4D19d; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qWh4D19d"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304f23c55b2so4982336eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781573283; x=1782178083; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a5Vy0qwWUHw2I6yu3pLjy7gg/wcMWMPiIDRvgkzuW0o=;
        b=qWh4D19d/1eKZnj0F6c94xDRjLHN417ErOuJftWZ8IQnB7+A5t4eMyJ/Z46FM5ZKZZ
         B4VmQZtL+kK34gCeagqzUdBUiignZ7Dsi7lVbGyPsyiZDJpmJUHZXoy09E+ypTDMSX2a
         1ke/NKNHxs1Qgzk4RsE3U0DtiXm6OsLrakn8Oa+s2wcs90i5xNsoIJlU8hmuqDFxf/Zb
         8p/3x0VMwmWQlbyIaRo2mz+MmGf14VpIbKUdX788CBEsCiZV31uPG4S4wzIl/T77AOkr
         TNe6vmAM++NmoJLkR/GSkqhBPp82C30WCaxlco/2WJ78u4hjCgEz4zurYE6k+lSkdL88
         AQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781573283; x=1782178083;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5Vy0qwWUHw2I6yu3pLjy7gg/wcMWMPiIDRvgkzuW0o=;
        b=LgSpgmDGsppa/+af1Uz4XAddcWlW8JO/2PNSBh8H0ptvKpvpM8IjV5IIhdK2KVbxKI
         +XR1O7GAu5STb5EQSuVsJRUv/UXzE5rvfpISb2KqguQp/xGkuRl26OMK8gjthWm1HVDI
         3haMjKaYA87onxE6mj332FZIqBHjVPirOpMayCDLeBJGE3hJnqa5PLkVsK75pypbSzRF
         pr6jfaSGO10TzByG1C/Fy0t64gK0/BaSBskQ7jYsAIaqUulOHsF5owngOBTmKqgvrZMN
         RfjUrX2JrFg0ahbRA5mOnlPekpMXnBNDYwI1P4DjKVdwVafTFeu0SQgD5RhwzlLx+sXD
         tZLA==
X-Forwarded-Encrypted: i=1; AFNElJ8IffXLZRGIp4cni0L9eh5MmaXHWXwZ0PD7HXjKguNdYiL6dpOHKYsQQr091+a+DSAotjFuyA2b5cEVk0ot2L6m@vger.kernel.org
X-Gm-Message-State: AOJu0YwYBItS4FGAP9fl8LdnEtqc8g/KMof8MDM4o8mANSRjrhNaLe6P
	Hk+GerGmkP3pT305dDm6c4kz5Kda7wIZC/Cxbhxuk1CtNtOPfnEK0pgUwUvvpSkMiZffgCspVGn
	L6T2UPDX8sA==
X-Received: from dycmh8.prod.google.com ([2002:a05:693c:2588:b0:30b:a993:39a7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7312:b0:303:f2dc:8ab4
 with SMTP id 5a478bee46e88-30ba5b22866mr910563eec.2.1781573282897; Mon, 15
 Jun 2026 18:28:02 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:27:39 -0700
In-Reply-To: <20260616012744.4049193-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616012744.4049193-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616012744.4049193-8-irogers@google.com>
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

