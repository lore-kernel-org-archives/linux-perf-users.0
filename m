Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC5C331EDA;
	Fri, 17 Jul 2026 02:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784253945; cv=none; b=hLnpqiOipIZoExnPB/lCkVXPfUrOB0+YB6xjDvTy4Y12UKN8TgVWV+Ey/iLLcXuhr52LktxMSedPPq6zfQTTkO1Fs2xmMpCW1uCd2YQq1mZY2Grl7yMZkN1W+/odQ3aeivtpBteChDOeJvB+WVomAPj1ZrU1yDNXZZgRcGBUEz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784253945; c=relaxed/simple;
	bh=qjvtMCb2GkiOYLLPFMLPERHeA7OneW9Ey6hkcxCafnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/iiOPxlQG4DGbFSjBRnXLouDkK9P8mU2jqwd64VYDWBAsenJR8IsOWh33xx/z+2F3merTyI70RyQiaDyCoQYXnoiFD5Rbm2Pr+Vr9BRqHARlo30A6xn0uPrlwl/UVX9M6jinoYj768r7PjkMrL8OGmdbmb+WEUU5qJDizhfOvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bq+xuqBB; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bq+xuqBB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784253943; x=1815789943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qjvtMCb2GkiOYLLPFMLPERHeA7OneW9Ey6hkcxCafnk=;
  b=Bq+xuqBBFrkc0H3ObzvNGFT3vhWhB302TL8/HA4qXRzJxyyCcKABecQS
   vEgwHPMQ/55Mc/Cqrqle6ku8/GXBPUJ9hAPsOsNf1A1UQzqx6vv0o7FZC
   2a/7ASbPDLksjqTPbX5a2aSCiO3agtfntUGbLvjka87o3xtDYLGSQv9Hx
   rhv13H4gUPRLRAA0gPWzVyAiPsQ6EFOYZqWZnj0wMBoeQYa7vHQcsVtYg
   kRfGmP8Ni+4V02smayqjBFSeo/sK7n8gJG9dcfF3z7jVkRgePC7dc8BUb
   vT0bZbxbyEreImPbZJNO2HWM2qNlqO4+VtZF2mTT5UH5u+CADT/OTBKMO
   A==;
X-CSE-ConnectionGUID: xEZri94CTTSE/JVfJY0sAw==
X-CSE-MsgGUID: UeGmLLJOR4qSdnrQtbZBaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="107720004"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="107720004"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 19:05:41 -0700
X-CSE-ConnectionGUID: jJqBcsiiTL+0IHAEmFiuFg==
X-CSE-MsgGUID: E1ydT2RxSWmExfyHvugHbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="279952770"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa002.fm.intel.com with ESMTP; 16 Jul 2026 19:05:36 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: namhyung@kernel.org,
	acme@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	tianyou.li@intel.com,
	wangyang.guo@intel.com,
	dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiebin Sun <jiebin.sun@intel.com>
Subject: [PATCH v3 03/14] perf c2c: add function view type definitions and helpers
Date: Fri, 17 Jul 2026 10:05:19 +0800
Message-ID: <20260717020530.1645123-4-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260717020530.1645123-1-jiebin.sun@intel.com>
References: <20260710084247.3576706-1-jiebin.sun@intel.com>
 <20260717020530.1645123-1-jiebin.sun@intel.com>
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
index c50c8ca825c1..1ef5d08e81c3 100644
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

