Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B135A2F7F0E;
	Fri, 26 Jun 2026 07:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782457407; cv=none; b=WkGoUztaGxWvhlUfzCIyD08HCKRqj1qMDmV9m01Gs0jk2Qf5ecv+o17pCneMHvwbniVYSNJHUVcnzawYVY2IxYn23MezNL52d7rjb/p86nlZO2zgboTHRSRdHMVGEiAPeb8qEX7PS+jyyslq0K6lQQFcE/Uy/yEKD7ArxcMHwMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782457407; c=relaxed/simple;
	bh=ACA+l2tFRTl838fEEpWhN9TkeLd2KYYm60b5EBAW6rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1oQB0ySsyeBfBb4pyWxW3eOVdyg5Y2a/20PXTJVJ1SFZIuGGTIa14WLN1V36690pGReSTX0VkeD8E5e+8YyAp76zE4NxLfNk9YtddguJQecJ5VuA8gOYHucCnlH6xQY0f9Jc8EiL5fgretO6FWh/Ne+VZjtZrucay8QcsRBz6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AfdkiwU/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AfdkiwU/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782457407; x=1813993407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ACA+l2tFRTl838fEEpWhN9TkeLd2KYYm60b5EBAW6rk=;
  b=AfdkiwU/rMc071jhwpePf3vAFp29s1qDoYPyaN3IlDAw7DLXY9w9/jd9
   t0HixGu8F1zUa9qd9kTWseS1NmC6K5Ol96l66FvQzP1THqFzdT2NyIcFj
   q2svyGEZWQJwYTX70Xn4UCvuKM0KUF49/8QbZQhL7YcEHPbmq5EBLJ/iH
   tY2B8XVsywY9XujeY5DPTe76j4sy4V9I7x1zLAOsSiAxeCK7Nf7mr2pCU
   3IA1BbvYrjwzwygsLa9LFisE1JyifRTEXa+GjcImFi46avZbn+pB/Obfj
   Ayi9SwjDrHhKqOaxKAhnHBw3JER/881y2HUVA9BLLT8Eu6qE2czJ/IhCO
   w==;
X-CSE-ConnectionGUID: TthIAoUvRi2U/pniwvNnUg==
X-CSE-MsgGUID: D9PNE8A9SEWNWgQy6q3jxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="94397353"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="94397353"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 00:03:27 -0700
X-CSE-ConnectionGUID: kcdg17dxSXWSQVI795Efuw==
X-CSE-MsgGUID: FRo8I3RpRoeqz7VmdvAg1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="247893430"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa007.fm.intel.com with ESMTP; 26 Jun 2026 00:03:21 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Tianyou Li <tianyou.li@intel.com>,
	Wangyang Guo <wangyang.guo@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiebin Sun <jiebin.sun@intel.com>
Subject: [PATCH 03/14] perf c2c: add function view type definitions and helpers
Date: Fri, 26 Jun 2026 15:03:44 +0800
Message-ID: <20260626070355.1556721-4-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260626070355.1556721-1-jiebin.sun@intel.com>
References: <20260626070355.1556721-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the foundational type definitions and helper functions for the
function view browser:

- perf_c2c_ext: extended context holding function-grouped histograms
- c2c_function_browser: browser state wrapping hist_browser
- symbol_name_equal(): symbol comparison by name
- hist_entry__iaddr(): instruction address extraction helper
- c2c_hitm_count(): inline accessor for a c2c_stats HITM total

Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Falcon <thomas.falcon@intel.com>
Reviewed-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
---
 tools/perf/ui/browsers/c2c-function.c | 29 +++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browsers/c2c-function.c
index 040266288be3..dbc912a4a242 100644
--- a/tools/perf/ui/browsers/c2c-function.c
+++ b/tools/perf/ui/browsers/c2c-function.c
@@ -37,6 +37,35 @@
 #include "../../c2c.h"
 #include "hists.h"
 
+struct perf_c2c_ext {
+	struct c2c_hists	function_hists;
+	/* Cached across all level-1 entries; 0 means "not yet computed". */
+	u64			total_cycles;
+};
+
+static struct perf_c2c_ext c2c_ext __maybe_unused;
+
+struct c2c_function_browser {
+	struct hist_browser	hb;
+};
+
+static __maybe_unused inline u64 c2c_hitm_count(const struct c2c_stats *stats)
+{
+	return stats->tot_hitm;
+}
+
+static __maybe_unused inline bool symbol_name_equal(struct symbol *a, struct symbol *b)
+{
+	return a && b && arch__compare_symbol_names(a->name, b->name) == 0;
+}
+
+static __maybe_unused inline u64 hist_entry__iaddr(struct hist_entry *he)
+{
+	if (he->mem_info)
+		return mem_info__iaddr(he->mem_info)->addr;
+	return he->ip;
+}
+
 int perf_c2c__browse_function_view(struct hists *hists __maybe_unused)
 {
 	ui__warning("C2C function view is not implemented yet.\n");
-- 
2.52.0

