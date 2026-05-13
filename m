Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FE337BE80
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778683761; cv=none; b=XAIrIDVBJMU/8Omml7GTvf4amOrKnnvtWwBQK0l5m2lyhuOd7w5lJiS3wDPY60GBVNNgUGDatMGcAI1ge/YQt5onytLbZInJB3bNMGQXNqnlCBho892ru8PeQNdIF2NIYsPUBQNmePY/k8uDdAjR918IEX+rIfk3wS2ngdnMDzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778683761; c=relaxed/simple;
	bh=uM79fTK9rQUDd6t1+NNHCHSFU9/oSTkdHuxped1zuwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u3wfKv+QdLL82h1wOpm0MoM9gOrmM2FhjmA+yR2TRT4TOavqpzsxlrC/+hBBi+CQSxlmQ2dIuwm4SNA1pEslxGbLUmI7udTWFwIVXTzeGRVhgsGTi6hDqkvRFX+kSYYkbb7xAhyRKDyWpJVFmxCNDKcTONVeKSITOWe8xSubT0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XXmCtINF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XXmCtINF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778683759; x=1810219759;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uM79fTK9rQUDd6t1+NNHCHSFU9/oSTkdHuxped1zuwU=;
  b=XXmCtINF8UfaSkiaYJTtmXpEC3LKXJ4lWxXNB5C2BqWIrSBr472qfd40
   p0Ch5KjfJi8mZyH3YTL4D/4Bg3k+MXyhksv+Sp8Py0chTxcB/wpWbutdY
   fSg2+xv6zHXMf57syg55gp3bB2y/Hw2kQ1OxZosxGIzsd49GAzZGlJu97
   QjS66nmpwfjlOPRbwWkYHKqHt9YBQlIhshNiDEBb6HwjtmzBa7wBOmXbx
   m0bIKTjATPZPXLG9NcuMify6GaqkbGJsVmy3IBSFBS4xYT4qfBn6oP7t3
   gQ3IzozVIQKsJURBBeqVYQZ9y7QLBieJGsDovfuA/CFR8+oKE8KFEPU7Y
   g==;
X-CSE-ConnectionGUID: UpLq1kseQ5+QYYhhotZ0Yw==
X-CSE-MsgGUID: t2wbYYvyTZmncPZMQV+k0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="67142668"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="67142668"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 07:49:17 -0700
X-CSE-ConnectionGUID: IA7JHdMUQomE1HrvacRvXg==
X-CSE-MsgGUID: SMMGV/jXT1C8YNfnba4zSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="237249500"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 07:49:16 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2] perf stat: Make metric only column line up with header
Date: Wed, 13 May 2026 07:49:06 -0700
Message-ID: <20260513144906.557896-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since some time the metric-only output columns are messed up and do not
line up with the header, which makes it hard to read. I haven't bisected
it, but presumably it was broken for some time.

There were multiple problems:
- The dummy pm invocation at the beginning did print a bogus field
- The column computation in pm did not agree with the header length
- The color escape strings from highlighting confuse printf's field
  length computation

Fix all those. I simplified the column width computation significantly,
ignoring EVNAME_LEN, MGROUP_LEN, config->unit_width which don't
seem to be useful in the metric only context. It now only uses
the actual unit width as well as config->metric_only_len. The result
is more code removed than added.

Before:

% perf stat --topdown -a -I 1000
+           time %  tma_backend_bound %  tma_frontend_bound %  tma_bad_speculation      %  tma_retiring
     1.000190386                                         45.5                   40.0                     5.3                     9.2
     2.005185654                                         45.3                   40.1                     5.6                     9.0
     3.009193207                                         45.4                   39.9                     5.6                     9.1

After:

% perf stat --topdown -a -I 1000
+          time %  tma_backend_bound %  tma_frontend_bound %  tma_bad_speculation      %  tma_retiring
     1.000810024                 46.3                 39.7                   5.3                 8.7
     2.004800656                 45.8                 39.8                   5.4                 8.9
     3.008804783                 46.0                 39.6                   5.4                 9.0

Signed-off-by: Andi Kleen <ak@linux.intel.com>

---

v2: Add missing headers removed by git because they started with #
Remove unrelated hunk.
---
 tools/perf/util/stat-display.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 993f4c4b8f44..2b69d238858c 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -580,16 +580,13 @@ static void print_metricgroup_header_std(struct perf_stat_config *config,
 					 const char *metricgroup_name)
 {
 	struct outstate *os = ctx;
-	int n;
 
 	if (!metricgroup_name) {
 		__new_line_std(config, os);
 		return;
 	}
 
-	n = fprintf(config->output, " %*s", EVNAME_LEN, metricgroup_name);
-
-	fprintf(config->output, "%*s", MGROUP_LEN + config->unit_width + 2 - n, "");
+	fprintf(config->output, " %*s", config->metric_only_len, metricgroup_name);
 }
 
 static void print_metric_only(struct perf_stat_config *config,
@@ -599,19 +596,20 @@ static void print_metric_only(struct perf_stat_config *config,
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
 	char str[1024];
-	unsigned mlen = config->metric_only_len;
+	unsigned mlen;
 	const char *color = metric_threshold_classify__color(thresh);
+	int olen;
 
-	if (!unit)
-		unit = "";
-	if (mlen < strlen(unit))
-		mlen = strlen(unit) + 1;
+	if (!unit) {
+		os->first = false;
+		return;
+	}
 
-	if (color)
-		mlen += strlen(color) + sizeof(PERF_COLOR_RESET) - 1;
+	mlen = max_t(unsigned, strlen(unit), config->metric_only_len);
 
+	olen = snprintf(str, sizeof(str), fmt ?: "", val);
 	color_snprintf(str, sizeof(str), color ?: "", fmt ?: "", val);
-	fprintf(out, "%*s ", mlen, str);
+	fprintf(out, "%*s%s", max_t(int, mlen - olen, 1), "", str);
 	os->first = false;
 }
 
-- 
2.54.0

