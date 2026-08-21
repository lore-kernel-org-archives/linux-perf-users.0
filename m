Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A1D283142;
	Fri, 21 Aug 2026 00:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787271513; cv=none; b=dzYwUZv0PwjAc1/pVhXyLyJ/klLDWhh5Yc3iPA1JWIo20zdxx6ytm3Go3VpMhFFJ2QLkUEp2TuVtUiuP0s50qaP6ClJvQ0sjRBOn+w1+hkg0ML25jZ5HdaqMDEldg6R0KvJKX2N3vsA40xd7VOGf0kz53Bk6kRmbWvHrQ6OT4WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787271513; c=relaxed/simple;
	bh=VEiYJraJEmJrQtYggUUXx1NjjLl3SB9Im8C7zQV6qBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWAtmB28WiptG8d5D1h1B7IocaUZRoPEfMjIcc+dLWIKDNXsxcBOVK17wE5S6Yjc8KPQL1w6RRTKi4Om9MgoTowoz8Vm0KsGtkHAYOgf0QO+ba2OqfkxrZ1hqP+hvuwNgDuGsCzzSG0rZ8x6oKrt1JDDhsjsQZprI3encNRpbj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q2chjRBR; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q2chjRBR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787271511; x=1818807511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VEiYJraJEmJrQtYggUUXx1NjjLl3SB9Im8C7zQV6qBs=;
  b=Q2chjRBRKA8cDgl1xlmfeJno1mK1zjsBxa7bmkTtnLOW/hVsILjkXgSf
   LaXQmoz+YQdUrRugU3wZNYqHxVjI4GvyJGDYk4sSaYzOxbvnHldh6k+ur
   VsvBGZ7a8s+XstCFg9hXzekTgTVOQO6vXbwujp5VgUPFZO6dXgk4T7ij/
   YGlxJOajFvcCAKtSOu6GoOHDZLNb3zLNAYplaxAOnFwhtqMC0BBHjzDRy
   rK1loClCsZn6QdMmlKn/1SeZ7/INgP5JbU+0uBslrJB9FyInkzR6K0J/Y
   tI2My1/0m71lWC1yGMY8GRFWiI8qrmvq/ojcFH83aZo+tCJ6oL1KBNpw7
   w==;
X-CSE-ConnectionGUID: yb1NsbGmTlWmQbCMY/w86Q==
X-CSE-MsgGUID: plOO2VlLTDaPa2s19Qgbxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87839468"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="87839468"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 17:18:29 -0700
X-CSE-ConnectionGUID: pZNN/ESqTNOg2v/LZZnOyQ==
X-CSE-MsgGUID: ouQOOyvkREubrq2aHA9Njw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="261914967"
Received: from rodrigoa-mobl1.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.124.221.152])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 17:18:29 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v5 1/6] perf mem: Fix size tracking for mem_lvl's in perf_script__meminfo_scnprintf()
Date: Thu, 20 Aug 2026 19:18:14 -0500
Message-ID: <20260821001819.162277-2-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821001819.162277-1-thomas.falcon@intel.com>
References: <20260821001819.162277-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When printing memory info in perf script, the entire size of the
buffer is passed to perf_mem__lvl_scnprintf() instead of the remaining
size. Pass the remaining buffer size instead.

This issue was detected by sashiko during an internal code review.

Assisted-by: Sashiko:gemini-3.1-pro-preview
Fixes: fdefc3750e847 ("perf mem: Print memory operation type")
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/util/mem-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 0b49fce251fc..4e490f9cd348 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -610,7 +610,7 @@ int perf_script__meminfo_scnprintf(char *out, size_t sz, const struct mem_info *
 	i += scnprintf(out, sz, "|OP ");
 	i += perf_mem__op_scnprintf(out + i, sz - i, mem_info);
 	i += scnprintf(out + i, sz - i, "|LVL ");
-	i += perf_mem__lvl_scnprintf(out + i, sz, mem_info);
+	i += perf_mem__lvl_scnprintf(out + i, sz - i, mem_info);
 	i += scnprintf(out + i, sz - i, "|SNP ");
 	i += perf_mem__snp_scnprintf(out + i, sz - i, mem_info);
 	i += scnprintf(out + i, sz - i, "|TLB ");
-- 
2.55.0

