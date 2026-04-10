Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4961381B1F;
	Fri, 10 Apr 2026 11:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775819640; cv=none; b=MWCYGdLjAAQtcXAN0b7bOpQdnIwn2MVspYlfwAx85eWcYmjQ92XeZMgu77M0otzL4X9+78tyls6eGunJpObMci+JKgeMLG6AS5NTsoW4XUWCrazmSFUPzKiaOPcE2/o16akXPIUFvRFc9iYr4+Sj/k8ErlmKkFusZvJ+YIuOAJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775819640; c=relaxed/simple;
	bh=B+QUl8qbju/pBIN9DhfQZaX2lFn1Cba5hp5XcfdQF78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gNrQOy1tzN7mNIUH5yUkcgH7QCGENTLrvGVRuSua+a5YM9L3XaqCn1GynNwZTJataRYl7+Fq0H/Jic5PMjdqS5AlsKhnqiT+UCL/SM+Bo0vhJ6RL3xa3TGDYCGY4f9ELtec5+xWngfoj94HcNFtZMy2cqiqk7rRd32tSxE2M9Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Z7poZqBM; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Z7poZqBM"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 798552682;
	Fri, 10 Apr 2026 04:13:52 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 469F23FAF5;
	Fri, 10 Apr 2026 04:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775819638; bh=B+QUl8qbju/pBIN9DhfQZaX2lFn1Cba5hp5XcfdQF78=;
	h=From:Date:Subject:To:Cc:From;
	b=Z7poZqBMfML/LpZ4MhPR7y6beSuicz4X6RZAgrFIPfE7ZsXEHQyxI4xMaKFqfZ3xG
	 jYnrW+01+Qtkf8XBDuaw9JAW52h/AVARG0wWaAZmuJJY1UuGgK/c+DAuzjQh6dUP8/
	 DhUzAZtK7ExRByZIpqomUdPEKx2o1CXwGEf8XwgI=
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 10 Apr 2026 12:13:44 +0100
Subject: [PATCH v2] perf pmu: Skip test on Arm64 when #slots is zero
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-perf_fix_pmu_metrics_test-v2-1-61826ab3ca8b@arm.com>
X-B4-Tracking: v=1; b=H4sIAGfb2GkC/42NQQ6CMBREr0K6tqatlFZX3sOQBtqP/EWBtJVoC
 He3YOJWl28yb2YhEQJCJJdiIQFmjDgOGcShILZvhjtQdJmJYKJiJdN0gtCZDp9m8g/jIQW00SS
 IiaqTLR04q6WWJPtTgNzbt2915h5jGsNrv5r5lv6zOnPKKVNKyBaYOCt3bYI/2tFvFx+fs18+1
 410mnWKt9XXr9d1fQPyUzK5AAEAAA==
X-Change-ID: 20260408-perf_fix_pmu_metrics_test-73c4dedc8585
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775819636; l=3369;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=B+QUl8qbju/pBIN9DhfQZaX2lFn1Cba5hp5XcfdQF78=;
 b=h/38BGz6cWSQmrFLDRR3BPs8rZk2fjacEBag+Yn9bXwsayvmKCQ0PhFGh8lBgilMmPaqmPmUO
 M7uxnqPYYDsDUNoerLNQUR1aUXzL650eSiefUVfhVC+Yt7Mc9SFkZIw
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Some Arm64 PMUs expose 'caps/slots' as 0 when the slot count is not
implemented, tool_pmu__read_event() currently returns false for this,
so metrics that reference #slots are reported as syntax error.

Since the commit 3a61fd866ef9 ("perf expr: Return -EINVAL for syntax
error in expr__find_ids()"), these syntax errors are populated as
failures and make the PMU metric test fail:

    9.3: Parsing of PMU event table metrics:
    --- start ---
    ...

    Found metric 'backend_bound'
    metric expr 100 * (stall_slot_backend / (#slots * cpu_cycles)) for backend_bound
    parsing metric: 100 * (stall_slot_backend / (#slots * cpu_cycles))
    Failure to read '#slots'
    literal: #slots = nan
    syntax error
    Fail to parse metric or group `backend_bound'

    ...
    ---- end(-1) ----
    9.3: Parsing of PMU event table metrics    : FAILED!

This commit introduces a new function is_expected_broken_metric() to
identify broken metrics, and treats metrics containing "#slots" as
expected broken when #slots == 0 on Arm64 platforms.

Fixes: 3a61fd866ef9 ("perf expr: Return -EINVAL for syntax error in expr__find_ids()")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Changes in v2:
- Checked pm->metric_expr instead of pm->metric_name and removed the
  negation before strstr() suggested by sashiko.
- Link to v1: https://lore.kernel.org/r/20260410-perf_fix_pmu_metrics_test-v1-1-18a5d80f71b6@arm.com
---
 tools/perf/tests/pmu-events.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index a997168621688007c85495e2d9f6f459c2471516..b1609a7e1d8c9427e6bf9500380e8aac6167c7fa 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -15,6 +15,7 @@
 #include "util/expr.h"
 #include "util/hashmap.h"
 #include "util/parse-events.h"
+#include "util/tool_pmu.h"
 #include "metricgroup.h"
 #include "stat.h"
 
@@ -817,6 +818,26 @@ struct metric {
 	struct metric_ref metric_ref;
 };
 
+static bool is_expected_broken_metric(const struct pmu_metric *pm)
+{
+	if (!strcmp(pm->metric_name, "M1") || !strcmp(pm->metric_name, "M2") ||
+	    !strcmp(pm->metric_name, "M3"))
+		return true;
+
+#if defined(__aarch64__)
+	/*
+	 * Arm64 platforms may return "#slots == 0", which is treated as a
+	 * syntax error by the parser. Don't test these metrics when running
+	 * on such platforms.
+	 */
+	if (strstr(pm->metric_expr, "#slots") &&
+	    !tool_pmu__cpu_slots_per_cycle())
+		return true;
+#endif
+
+	return false;
+}
+
 static int test__parsing_callback(const struct pmu_metric *pm,
 				  const struct pmu_metrics_table *table,
 				  void *data)
@@ -852,8 +873,7 @@ static int test__parsing_callback(const struct pmu_metric *pm,
 
 	err = metricgroup__parse_groups_test(evlist, table, pm->metric_name);
 	if (err) {
-		if (!strcmp(pm->metric_name, "M1") || !strcmp(pm->metric_name, "M2") ||
-		    !strcmp(pm->metric_name, "M3")) {
+		if (is_expected_broken_metric(pm)) {
 			(*failures)--;
 			pr_debug("Expected broken metric %s skipping\n", pm->metric_name);
 			err = 0;

---
base-commit: 4cf1f549bbcdfea9c20df52994bb342677472dcd
change-id: 20260408-perf_fix_pmu_metrics_test-73c4dedc8585

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

