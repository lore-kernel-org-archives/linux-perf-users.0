Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27EB392C4C
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 20:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135276; cv=none; b=qUMWqXCxQQsI8K8hVVYoeyJ4lqwidxy/bjOgz3s38UHZHWrAgPsQhmx5HGMvxrF4e87TUnnwHUdOiEFPQN69Cw/TX4sI9E7yVdtvsv3ODLbktBSU0TsJtP9LuNmr5NNKXLPUwBbTXaqlEiWSqCAw11MFuU5YemTb4MRzBJPhOOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135276; c=relaxed/simple;
	bh=FpUJiLkcnDUY6MDiOfrzffRQj9kMl4QOrpN2SDHOTGE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aIyM6n5sfLNm0tFYfunwTlHVZGvR02ij2Axqz39XCmCm6JQbDjcDBJuhd7bTQSPpovDwlu9DBg7hv9yiD4ZYztiiA7It7fG/H7s+zAGZ19GlvRJ5fBVH+f6D0gz76+IvT5Ls1wWr/AgjmGPiiPGM4dZd660Vz/rDL9J2mnHg//w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CV/FrISJ; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CV/FrISJ"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ef62078ee7so3778151eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 13:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779135274; x=1779740074; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wDGrYR09FiJUwVsBSs6pa3l2SWK4RVY/PO4SX5MlSuM=;
        b=CV/FrISJHx8WaK/f3sYjSxmJe2rHVS3vTttUP65gZEzRDAdtReOi5ZhdF7mmKH1WVB
         NASjbOG1SXG0qBpQ1F4v3djM8CHLOlNFsO3g4ZK0OCUZuARZDU0qS3GaXK+moz9hFbX9
         QmlqiN8aojyMAv2rG3FxJ2xyhKvdut0TklSOt5r0vfKlWuXRywI3ASn/QaAQMoy6TKPe
         Sp+6PPpSYaTvPx8gx6jdo8Cq/ELHDOkYr7NSqStLHMZQkfi3cfvGh9G2wxr8SuTEYUA/
         h72DLcgjnzs2AvP/m9H0661nheLpvCUWGQ1ZvuvH0/Vkf4wp6GlgEZp5piaKM2TMBE/p
         6B/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779135274; x=1779740074;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDGrYR09FiJUwVsBSs6pa3l2SWK4RVY/PO4SX5MlSuM=;
        b=J5gztC/NIGfEusKyZt2l6hts7f9osJRkT7VGwb6MrfqK1aPoiCQwq6P1Cm2aGtvzMx
         Evn+JJnMtoDNTXSvRgqxbKlm7gPvgq7rsJonC5epx6GLwe+dGtdXVYjgupnavvXAv+JD
         JwfdfZA93V5lBPl8zeXHb0Dp5Jsrl4TzWkUYLZWaFgYLKAySkisIryqEG5mlL/YCB3GG
         +bhZ54s52MivHg76kwHJcnoa6mnc3dPvUxHwn0sQb+PWd0jo8DNsshEryxEjgbQ/FUYf
         LpvHlDc4Aa321CVfFaQoHOZg9ziY4wMZoHIHNPygtXoTt1fCykA6aKFvctQgKH4f8bky
         MplQ==
X-Forwarded-Encrypted: i=1; AFNElJ93ZEMmJEXsBTzgml8MgJzqZ7dsVuY3RB76YvYRoAv1q1LwNkwWBDLn92BvDP+UR8igebvZDRmGk+io84IDKLd9@vger.kernel.org
X-Gm-Message-State: AOJu0YydJ2F9RklmWi0O9jCgY8uR1f8/noLITKLGf2YVtosF+sRMSCZK
	B0yS9++1FHahjCUhJIkQQsQQ74NQ1R0lfokGxgeDAQIdfPaegSeE2ivUxxICDH6tgNblpNi4fqL
	UK10/gw81wg==
X-Received: from dly10-n1.prod.google.com ([2002:a05:701b:204a:10b0:12d:b7d3:3e31])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6628:b0:128:d5bd:3572
 with SMTP id a92af1059eb24-1350484c6dbmr7524306c88.31.1779135273564; Mon, 18
 May 2026 13:14:33 -0700 (PDT)
Date: Mon, 18 May 2026 13:14:14 -0700
In-Reply-To: <20260518201419.2943132-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518183920.2894502-1-irogers@google.com> <20260518201419.2943132-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260518201419.2943132-3-irogers@google.com>
Subject: [PATCH v2 2/2] perf tests: Add test for stat delay option with duration_time
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, nigro.fra@gmail.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Add a new test case `test_stat_delay` to `stat.sh` to verify that
`duration_time` correctly excludes the delay period when using the
delay option (-D).

The test runs `perf stat -D 1000 -e duration_time sleep 2` and
verifies that `duration_time` is ~1s (excluding the 1s delay), not
~2s.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3-flash
---
 tools/perf/tests/shell/stat.sh | 48 ++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 4edb04039036..a9eadd57e164 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -483,6 +483,53 @@ test_stat_pid() {
   wait $pid 2>/dev/null || true
 }
 
+test_stat_delay() {
+  echo "stat -D test"
+  if ! env LC_ALL=C perf stat -D 1000 -e duration_time sleep 2 > "${stat_output}" 2>&1
+  then
+    echo "stat -D test [Failed - command failed]"
+    cat "${stat_output}"
+    err=1
+    return
+  fi
+
+  duration=$(grep "duration_time" "${stat_output}" | awk '{print $1}' | tr -d ',')
+  elapsed=$(grep "seconds time elapsed" "${stat_output}" | awk '{print $1}')
+
+  if [ -z "$duration" ] || [ -z "$elapsed" ]
+  then
+    echo "stat -D test [Failed - failed to find duration_time or time elapsed in output]"
+    cat "${stat_output}"
+    err=1
+    return
+  fi
+
+  # Compare duration (ns) and elapsed (s) using awk to handle float and allow tolerance.
+  if ! awk -v d="$duration" -v e="$elapsed" '
+    BEGIN {
+      diff = d - (e * 1e9);
+      if (diff < 0) diff = -diff;
+      # Allow 200ms tolerance (200,000,000 ns) for loaded CI machines.
+      if (diff > 200000000) {
+        printf "Fail: duration (%d ns) and elapsed (%f s) mismatch (diff %d ns)\n", d, e, diff;
+        exit 1;
+      }
+      # Lower bound check: must be at least 0.5s.
+      if (d < 500000000) {
+        printf "Fail: duration (%d ns) is abnormally small\n", d;
+        exit 1;
+      }
+      exit 0;
+    }'
+  then
+    echo "stat -D test [Failed - validation failed]"
+    cat "${stat_output}"
+    err=1
+    return
+  fi
+  echo "stat -D test [Success]"
+}
+
 test_default_stat
 test_null_stat
 test_offline_cpu_stat
@@ -498,6 +545,7 @@ test_stat_no_aggr
 test_stat_detailed
 test_stat_repeat
 test_stat_pid
+test_stat_delay
 
 cleanup
 exit $err
-- 
2.54.0.631.ge1b05301d1-goog

