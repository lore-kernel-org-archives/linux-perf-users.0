Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AA21DA23;
	Wed, 14 Aug 2024 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723645150; cv=none; b=rBwpnMDZfgHymYYamm33bEQcRoy44vXcfiq4Yzcmys7NQvJECPYb+UKXL6ZofLgtFrFVF5O93lB9l9W+Z+DsE6Xnz13OqVsOqZKGAJZSOeRQXZUTeEl1qoRDb+V4UNpEDYsbQLLdbV4hzhibvKDzN00Zq8375wijJjWM6CH4rJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723645150; c=relaxed/simple;
	bh=KLWhg4RqA1SsmyXxqaPqAgr+km/LksJpewskWtyLpW8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=esJqWVhRbo6Vj1ZnFnea4M5YHHO+CZvC2z5ektWJbs8LY5QnhldD/z5k0Na/p2EXYnbBja5MD45TU+ELFF9EEnYTRCVGSbQfZmRLzr+OQI0lPccJinog0Yr91cZkO7rybkogCwk6R9bvtEMNysD25BWKu6QJJLYf8ehCWB5YiA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jvvCFrf7; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jvvCFrf7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723645149; x=1755181149;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KLWhg4RqA1SsmyXxqaPqAgr+km/LksJpewskWtyLpW8=;
  b=jvvCFrf7lr7NnL1g5iRBDnR2Lo2ebFXbiHP248+wd+OJXWTFXEHywYIp
   znjSuVBDe4/tU1SEN85AP8uSB4c+Pcnp738Kwg3ClB8S5EslsXhGKdQ4Q
   BRsqTrHjc/xqdghAUcO0dX5fYeWOTreayQbESJOkZpRU9l26yzv4jVZ4c
   OGSQf1SVJHaMRvxyAERMnlSOT/PlVuvBzJNIqH71lMU6nvaL9AB1ekoX0
   Ob1fYCDmhxtDSjJsATmJpawZeZZJV+pglzsFm3QoTk/k+UYw8jmiKtjoP
   DmY7KUHuYWTYJ8Px+t8x1Wmid4xEik+opTCYG5dUeb4qhIelSduQk49jT
   A==;
X-CSE-ConnectionGUID: GAZ4CBnERySjXSSHsb5OXA==
X-CSE-MsgGUID: noFpwn56RbuVqtVL+s88Fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="22035155"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="22035155"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 07:19:05 -0700
X-CSE-ConnectionGUID: JkmnlpadSUiI8x7Y24+zxQ==
X-CSE-MsgGUID: 1DG9wg5XSuS2xXg4EC1mGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="63914459"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa005.jf.intel.com with ESMTP; 14 Aug 2024 07:19:05 -0700
From: kan.liang@linux.intel.com
To: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	peterz@infradead.org,
	mingo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf report: Support --total-cycles --group in the tui mode
Date: Wed, 14 Aug 2024 07:19:42 -0700
Message-Id: <20240814141942.2513194-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

With the --total-cycles, the --group is only supported in the stdio
mode, but not supported in the tui mode. The output is inconsistent
with different modes.

if symbol_conf.event_group is applied, always output the event group
information together in tui mode as well.

$perf record -e "{cycles,instructions}",cache-misses -b sleep 1
$perf report --total-cycles --group --tui

Before the patch,

Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles                         [Pro
          6.45%            2.0K        0.57%         667    [dl-cacheinfo.h:164 -> dl
          5.62%            1.7K        0.74%         871            [dl-cache.c:230 -
          5.21%            1.6K        1.37%        1.6K          [setup-vdso.h:37 ->
          4.92%            1.5K        0.09%         109            [dl-cache.c:367 -

Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles                         [Pro
          5.62%            1.7K        2.76%         871            [dl-cache.c:230 -
          4.92%            1.5K        0.35%         109            [dl-cache.c:367 -
          1.12%             346        0.55%         173
          0.87%             270        0.43%         135                    [rtld.c:5
          0.64%             197        0.03%           8      [dl-tunables.c:305 -> d
          0.60%             185        0.01%           3      [dl-tunables.c:305 -> d

Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles                         [Pro
          5.90%            1.8K        1.28%        1.8K                  [strtod.c:8
          5.70%            1.8K        1.24%        1.8K            [strtod_l.c:681 -
          5.68%            1.8K        1.24%        1.8K            [strtod_l.c:508 -
          5.48%            1.7K        1.19%        1.7K          [strtod_l.c:1175 ->
          5.21%            1.6K        1.13%        1.6K          [setup-vdso.h:37 ->

With the patch,

Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles                         [Pro
          6.45%            2.0K        0.57%         667    [dl-cacheinfo.h:164 -> dl
          5.62%            1.7K        0.74%         871            [dl-cache.c:230 -
          5.21%            1.6K        1.37%        1.6K          [setup-vdso.h:37 ->
          4.92%            1.5K        0.09%         109            [dl-cache.c:367 -

Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles                         [Pro
          5.90%            1.8K        1.28%        1.8K                  [strtod.c:8
          5.70%            1.8K        1.24%        1.8K            [strtod_l.c:681 -
          5.68%            1.8K        1.24%        1.8K            [strtod_l.c:508 -
          5.48%            1.7K        1.19%        1.7K          [strtod_l.c:1175 ->
          5.21%            1.6K        1.13%        1.6K          [setup-vdso.h:37 ->

Fixes: 7fa46cbf20d3 ("perf report: Sort by sampled cycles percent per block for tui")
Closes: https://lore.kernel.org/lkml/ZrupfUSZwem-hCZm@x1/
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-report.c    |  6 +++++-
 tools/perf/ui/browsers/hists.c | 12 ++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 1643113616f4..574342fb7269 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -541,7 +541,11 @@ static int evlist__tui_block_hists_browse(struct evlist *evlist, struct report *
 	int i = 0, ret;
 
 	evlist__for_each_entry(evlist, pos) {
-		ret = report__browse_block_hists(&rep->block_reports[i++].hist,
+		i++;
+		if (symbol_conf.event_group && !evsel__is_group_leader(pos))
+			continue;
+
+		ret = report__browse_block_hists(&rep->block_reports[i - 1].hist,
 						 rep->min_percent, pos,
 						 &rep->session->header.env);
 		if (ret != 0)
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 49ba82bf3391..22af1a6e29d6 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3665,11 +3665,19 @@ single_entry: {
 static int block_hists_browser__title(struct hist_browser *browser, char *bf,
 				      size_t size)
 {
-	struct hists *hists = evsel__hists(browser->block_evsel);
-	const char *evname = evsel__name(browser->block_evsel);
+	struct evsel *evsel = browser->block_evsel;
+	struct hists *hists = evsel__hists(evsel);
 	unsigned long nr_samples = hists->stats.nr_samples;
+	const char *evname;
+	char buf[512];
 	int ret;
 
+	if (evsel__is_group_event(evsel)) {
+		evsel__group_desc(evsel, buf, sizeof(buf));
+		evname = buf;
+	} else
+		evname = evsel__name(evsel);
+
 	ret = scnprintf(bf, size, "# Samples: %lu", nr_samples);
 	if (evname)
 		scnprintf(bf + ret, size -  ret, " of event '%s'", evname);
-- 
2.38.1

