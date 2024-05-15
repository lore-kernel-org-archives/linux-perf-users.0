Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A786E3839C;
	Wed, 15 May 2024 05:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715751895; cv=none; b=u3dd2X42g7kqVPdjZJbjRauFY/R0ZxAyIukn1BZc/0c/O/8jsQw9ybdIL7Jum/RCx/a0W1f1J7EKxka46015apVxf9/6trHX1z5bulNlH6XnbD6G0rP4Ld47PZh9Y2tOkObaS1Uhw/NB9SuqmBa8b+TZf/CtIsrKpXtpXogcQjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715751895; c=relaxed/simple;
	bh=k03uHL02yJNFBSXmc8VPdCv9Pz2G1voZfKzU6/p+8vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXmDbMacw85zKd0X8+GcPJH9oETSfwlH93iI6WVC8jP0/E39M0uwAlfAg0h7TVdMtyqoQnnX7kz2arFID8LxCWAkXR/Axa20wXxYha4qMupJsi3e4iHfVj8cWsqkqlW0UqO3lqJL1QaFOXkQFIXR7tlyH3x+zGlYvXm/+H3bsGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WMNIxJw8; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WMNIxJw8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715751893; x=1747287893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k03uHL02yJNFBSXmc8VPdCv9Pz2G1voZfKzU6/p+8vk=;
  b=WMNIxJw8Pu80ZSHyRVfHc2sYR+RmVtgH6Qp3Fb+laAEksG/RoMUWavvT
   eAQ/+6SlrDWfRgQkZk90kHqjqENTvuM6H6nKu2Vss7cEXeV5nMq91OING
   VIssx/3nJ6WcfYzTd5RuuVe6dfefHu1vE4rKxQUh3s18yYOYFL5jzdIVK
   E1PEXEw8Pole3EvbM4VGKUC9cNHL8YPoLQxyShxCc0oZyilhRcWHZQfya
   q9PYZ+hT7ptk+YhalmJogQW0LxLuhSmuBRxgmKDQz0Gv5NQHSxBvam0xj
   GrCQji5v5PesRUJQfgeW7b8q83YzhAgcqVvfBMhs/dVFYZqjHSJ13xH5a
   w==;
X-CSE-ConnectionGUID: PV3j9YwCQrWZJUWgwySMlA==
X-CSE-MsgGUID: oEj0tg6fQIS7lCPA8UpikQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="29298035"
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="29298035"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 22:44:51 -0700
X-CSE-ConnectionGUID: 0CuZXGj1Q7KzsH84CYoZng==
X-CSE-MsgGUID: epQTg4+BSk61yYNEOzONTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="35469209"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa003.fm.intel.com with ESMTP; 14 May 2024 22:44:50 -0700
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v8 4/7] perf stat: Add retire latency values into the expr_parse_ctx to prepare for final metric calculation
Date: Wed, 15 May 2024 01:44:26 -0400
Message-ID: <20240515054443.2824147-5-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240515054443.2824147-1-weilin.wang@intel.com>
References: <20240515054443.2824147-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

Retire latency values of events are used in metric formulas. This update adds
code to process data from perf record for required retire latency values.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 3466aa952442..b97d23bfeac1 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -15,6 +15,7 @@
 #include <linux/zalloc.h>
 #include "iostat.h"
 #include "util/hashmap.h"
+#include "util/intel-tpebs.h"
 
 struct stats walltime_nsecs_stats;
 struct rusage_stats ru_stats;
@@ -355,6 +356,20 @@ static void print_nsecs(struct perf_stat_config *config,
 		print_metric(config, ctxp, NULL, NULL, "CPUs utilized", 0);
 }
 
+static int prepare_retire_lat(struct expr_parse_ctx *pctx,
+			     struct list_head *retire_lats)
+{
+	int ret = 0;
+	struct tpebs_retire_lat *t;
+
+	list_for_each_entry(t, retire_lats, nd) {
+		ret = expr__add_id_val(pctx, strdup(t->tpebs_name), t->val);
+		if (ret < 0)
+			return ret;
+	}
+	return ret;
+}
+
 static int prepare_metric(const struct metric_expr *mexp,
 			  const struct evsel *evsel,
 			  struct expr_parse_ctx *pctx,
@@ -369,6 +384,9 @@ static int prepare_metric(const struct metric_expr *mexp,
 		double val;
 		int source_count = 0;
 
+		if (metric_events[i]->retire_lat)
+			continue;
+
 		if (evsel__is_tool(metric_events[i])) {
 			struct stats *stats;
 			double scale;
@@ -486,6 +504,11 @@ static void generic_metric(struct perf_stat_config *config,
 		pctx->sctx.user_requested_cpu_list = strdup(config->user_requested_cpu_list);
 	pctx->sctx.runtime = runtime;
 	pctx->sctx.system_wide = config->system_wide;
+	i = prepare_retire_lat(pctx, &config->tpebs_results);
+	if (i < 0) {
+		expr__ctx_free(pctx);
+		return;
+	}
 	i = prepare_metric(mexp, evsel, pctx, aggr_idx);
 	if (i < 0) {
 		expr__ctx_free(pctx);
-- 
2.43.0

