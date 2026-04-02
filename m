Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA69C3EE1F5;
	Thu,  2 Apr 2026 16:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145902; cv=none; b=Nn19xiEaXPAOQ/rRYQNvLPw5hNm7zoH6Yp8C6KCb8rkwmpEBMXwMtzZsj8iRY+ZI9d16TNKE7Pr2l+Vpssr5B26KsJlfg4DEBKzYs7bolHfzqaYXo95HTlBdDefiYxO8uosxXE8eZDRjevQsgVkc0jBExAJ/w/nkxYVhJsdG7mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145902; c=relaxed/simple;
	bh=cFOemXhrlUon3eAqkNPXtTCtvcxUhmX49WiyclHmTrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TA/q9hIxhN74xQMxE8QXsp5J6ymLMzkVEbdsh8keYU+LGQXXb2L0qyhxWjtF9RsrxZZecIb5DTUS8M+pwnYks1yfykIZ3gWe2icM5MAb+mXsvAjBuwXH/AEp8Wi+zdQZJL+1+NVj/ToLeBJYG1fw1k9XZ74WG1SGQ3CtWAjW2tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=oVYyo3J1; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oVYyo3J1"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F4C419F6;
	Thu,  2 Apr 2026 09:04:54 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCFD13F915;
	Thu,  2 Apr 2026 09:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775145900; bh=cFOemXhrlUon3eAqkNPXtTCtvcxUhmX49WiyclHmTrU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oVYyo3J1LjpSGFYQKh5Uxc16zYV42+Kf7ZWQbYWWTPz9m+XgFEQFi8ai4B2nA6lPw
	 5amuHINojP6BZrFUXCu4SH7P6AE0BrbfhCO14XM9NMZM65PkiwIXjwelFWVZ/Sjwqa
	 e9RLW83ezlmNjM5Myk/NOrKHJ2YjZ3NoiLkRJMVA=
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 02 Apr 2026 17:04:49 +0100
Subject: [PATCH v2 3/3] perf metricgroup: Refine error logs
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-perf_fix_metrics_group-v2-3-1f9427a5d763@arm.com>
References: <20260402-perf_fix_metrics_group-v2-0-1f9427a5d763@arm.com>
In-Reply-To: <20260402-perf_fix_metrics_group-v2-0-1f9427a5d763@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775145893; l=2552;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=cFOemXhrlUon3eAqkNPXtTCtvcxUhmX49WiyclHmTrU=;
 b=UrGthdPokFrckDpD28hi0bxnCXqPTkpYtkXbcTdrnqWKU+a0HJc9DecNAhtR0kb8rIL5TYr62
 lBcrz9zRV1kDgk86kbuB5gzxVVXEHWLtIHadvZh2JmVA9jcb0IlJqS1
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Return -ENOENT when no metric/group matches, and directly use the return
value from expr__find_ids(), so -EINVAL is reserved for parse failures.

Print separate logs to make it clear.

Before:

  perf stat -C 5 -vvv
  Using CPUID 0x00000000410fd490
  metric expr 100 * (STALL_SLOT_BACKEND / (CPU_CYCLES * #slots) - BR_MIS_PRED * 3 / CPU_CYCLES) for backend_bound
  parsing metric: 100 * (STALL_SLOT_BACKEND / (CPU_CYCLES * #slots) - BR_MIS_PRED * 3 / CPU_CYCLES)
  Failure to read '#slots'
  literal: #slots = nan
  syntax error
  Cannot find metric or group `Default'

After:

  perf stat -C 5 -vvv
  Using CPUID 0x00000000410fd490
  metric expr 100 * (STALL_SLOT_BACKEND / (CPU_CYCLES * #slots) - BR_MIS_PRED * 3 / CPU_CYCLES) for backend_bound
  parsing metric: 100 * (STALL_SLOT_BACKEND / (CPU_CYCLES * #slots) - BR_MIS_PRED * 3 / CPU_CYCLES)
  Failure to read '#slots'
  literal: #slots = nan
  syntax error
  Fail to parse metric or group `Default'

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/metricgroup.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index f7d53b4e46f45cb01181a462cb5bb5ca5a3b1a9c..4db9578efd811cf91d192cc13fb757cf5aab21f7 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -914,10 +914,9 @@ static int __add_metric(struct list_head *metric_list,
 		expr = metric_no_threshold ? pm->metric_name : pm->metric_threshold;
 		visited_node.name = "__threshold__";
 	}
-	if (expr__find_ids(expr, NULL, root_metric->pctx) < 0) {
-		/* Broken metric. */
-		ret = -EINVAL;
-	}
+
+	ret = expr__find_ids(expr, NULL, root_metric->pctx);
+
 	if (!ret) {
 		/* Resolve referenced metrics. */
 		struct perf_pmu *pmu;
@@ -1101,7 +1100,7 @@ static int metricgroup__add_metric(const char *pmu, const char *metric_name, con
 	 */
 	ret = metricgroup__for_each_metric(table, metricgroup__add_metric_callback, &data);
 	if (!ret && !data.has_match)
-		ret = -EINVAL;
+		ret = -ENOENT;
 
 	/*
 	 * add to metric_list so that they can be released
@@ -1152,6 +1151,8 @@ static int metricgroup__add_metric_list(const char *pmu, const char *list,
 					      user_requested_cpu_list,
 					      system_wide, metric_list, table);
 		if (ret == -EINVAL)
+			pr_err("Fail to parse metric or group `%s'\n", metric_name);
+		else if (ret == -ENOENT)
 			pr_err("Cannot find metric or group `%s'\n", metric_name);
 
 		if (ret)

-- 
2.34.1

