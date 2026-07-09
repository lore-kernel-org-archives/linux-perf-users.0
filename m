Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57D73E1D06;
	Thu,  9 Jul 2026 22:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783635482; cv=none; b=MT0lCqN4utSayoyjJDk/9r5wp5f++W8wrAdn6zS3mCOVWjk3Kefr3KFLkqd4DAe0QNcQnyH9N8Zhp/KcfFhrIDRLCL7B6wuigibnpc07E1D15/W6UQdQwTrZ44+3bDfyLxz91Yzky1abnpbrQJAOkwNAjPnRmgIMTomyog5GYvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783635482; c=relaxed/simple;
	bh=rgs0BhPD/zH6NItLzg40beegeczWhpwp0MrLM9lv6UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fc8cLovSVrroukGJEsoxXqvoPytPYPwJrlkTMApeVTNvaZMqTEu/fOE6bJa8/chElDWMAwQug3P5VrcVMJzqmEoRhYW5EFttTOM0N2O6zvf9pbGanrytMmm/FDhZTxpFb1C5kjd+PyH0LYkpHyZXUoOts3oLtCy9vZNDvpdJBoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H/uNsHiW; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H/uNsHiW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783635480; x=1815171480;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rgs0BhPD/zH6NItLzg40beegeczWhpwp0MrLM9lv6UY=;
  b=H/uNsHiWJnNEwachZdJZ0n8jX50Y5sC67ujid9ZH5dhdh6RDX1P8KoEs
   eqd4tpVuAlJPutjhajFAtEXg24tlE5ODKYetnZFy9OOUEjyxbqS7Wmz/g
   YPofLBlKQZRFYPGETz2pFvzZl5F5m/ewIhk6PJmconR8zMzkbNN7IlQBB
   gDM2jsACAIjj0nje0f13HP4NbW4grvaj0L8Pw6JyJkWwvr/uvLs45RS1M
   EfFeLmgTrrpJU21rVfyD7Vz31JB8mxtsKy9COR0mpd7VHQNyEj2bO9U6K
   jVPzX9xhVhPyxCH7xmsjEY7nwhi8mebcZHDsRZE92isr7L0LfwiSaWuEl
   A==;
X-CSE-ConnectionGUID: 6+vmEiO3Rj+wdle78FbnVg==
X-CSE-MsgGUID: pOEKdJy7QOSDpkAiC6cjZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88163403"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88163403"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:17:59 -0700
X-CSE-ConnectionGUID: 1mjrAdDnRG+OozZqMkJi0A==
X-CSE-MsgGUID: cG9MJ90DQ3m2T5Ge6A4q6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259620910"
Received: from khuang2-desk.gar.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.223.97])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:17:58 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 6/6] perf c2c: print memory region data with stdio output
Date: Thu,  9 Jul 2026 17:17:36 -0500
Message-ID: <20260709221736.33446-7-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709221736.33446-1-thomas.falcon@intel.com>
References: <20260709221736.33446-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Print memory range data in perf-c2c subcommand. Only available in stdio
mode currently. If memory ranges are not supported or present, print
nothing.

Assisted-by: Sashiko:gemini-3.1-pro-preview
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/builtin-c2c.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 57e822dbd2d4..3fb8afba25be 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2634,6 +2634,34 @@ static void print_c2c_info(FILE *out, struct perf_session *session)
 	fprintf(out, "  Cacheline data grouping           : %s\n", c2c.cl_sort);
 }
 
+
+static void print_memory_ranges_info(FILE *out, struct perf_session *session)
+{
+	struct perf_env *env = perf_session__env(session);
+	int nr_ranges = 0;
+
+	if (!perf_header__has_feat(&session->header, HEADER_MEMORY_RANGES))
+		return;
+	nr_ranges = env->nr_memory_ranges;
+	if (nr_ranges == 0) {
+		pr_debug("No memory ranges found, skipping\n");
+		return;
+	}
+
+	fprintf(out, "\n");
+	fprintf(out, "=================================================\n");
+	fprintf(out, "                  Memory Ranges                  \n");
+	fprintf(out, "=================================================\n");
+
+	for (int i = 0; i < nr_ranges; i++) {
+		struct memory_range *r = &env->memory_ranges[i];
+
+		fprintf(out, "Range %d: [0x%016" PRIx64 "-0x%016" PRIx64 "] Node %d, local region id %u, remote region id %u\n",
+			i, r->base, r->base + r->length - 1, r->node,
+			r->local_region_id, r->remote_region_id);
+	}
+}
+
 static void perf_c2c__hists_fprintf(FILE *out, struct perf_session *session)
 {
 	setup_pager();
@@ -2647,6 +2675,8 @@ static void perf_c2c__hists_fprintf(FILE *out, struct perf_session *session)
 	if (c2c.stats_only)
 		return;
 
+	print_memory_ranges_info(out, session);
+
 	fprintf(out, "\n");
 	fprintf(out, "=================================================\n");
 	fprintf(out, "           Shared Data Cache Line Table          \n");
-- 
2.43.0

