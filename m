Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904F94CCDD7;
	Mon, 31 Aug 2026 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788209197; cv=none; b=qwgSnQLM2s9t5jioNbXc2CbK8LgbR/GKTdjLcH/PYgHcKUl+lW51nLyO8Icn1syvmBZjtaC9zLtZ+RWSPxPo42LWZ+AsP+OU0A4THuoWm1WdlmE35iskW/HazHtq6m0qnyTA64Gct+8KuAGbKS7Sd7Pg3xivlcNRwRQAT1my1B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788209197; c=relaxed/simple;
	bh=mLejFowYm2X6VHgkPdi17Jgt/N1ot0OaV91zeWDUK4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vE9p0R2GbtvcVOydK4Np1h55y4FUswu+0oykHMVikqh3zkFOj/SBak7cJPph1LUW3NSWSRCNVvLfb5SzN4aBoeFKqRwUGbeznFJavNXRyW1h+CSDz2oNZazv7yhAGXSfdSJlWiiJjoY4fY3DDGEvDNcI+xEaBCe9bd7YBVibTGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G45Zrmwt; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G45Zrmwt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788209196; x=1819745196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mLejFowYm2X6VHgkPdi17Jgt/N1ot0OaV91zeWDUK4M=;
  b=G45ZrmwtfR9E7tOMOsyjEmahanRGlME7kbT7J+ZT9HONbMCKf+AbJiIq
   yY3s8zG2hptAcXR+nQ4TFrZS/t8S5OT5POEwf/U8Rbg5intbnrVmG3mnB
   b/An74topuDDS5/P60dl30xNF1jWBKmR3WJ1EGlRXraXWEK0m5BZitC1M
   FdT+d8u64nXO9A62isvzwhItB6FnITuhx2Z4xBU3XpEpHFj8HjpHiwEPi
   DyRK5DHwOnF5zigutyQg/3GnTTAAO6lq9SGxnVdzaygIhN7Y3JUSLKog8
   fK/PTJKQYnUpHI9RllLXm4vdc0MT0p1s7lN1YoyamvJzA4kuCsmCufVBQ
   g==;
X-CSE-ConnectionGUID: 42ICh6BJRgynuHXLKN+FGg==
X-CSE-MsgGUID: oWp8YFcWRPyprrOAQWv+jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="106147273"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="106147273"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 13:46:33 -0700
X-CSE-ConnectionGUID: YD4ck0oCTAKKFK6y8PLk1A==
X-CSE-MsgGUID: uqkEGwWfTRudOSJW9ERjRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="268345988"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.124.220.28])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 13:46:32 -0700
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
Subject: [PATCH v6 1/6] perf mem: Fix size tracking for mem_lvl's in perf_script__meminfo_scnprintf()
Date: Mon, 31 Aug 2026 15:46:08 -0500
Message-ID: <20260831204613.2793526-2-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831204613.2793526-1-thomas.falcon@intel.com>
References: <20260831204613.2793526-1-thomas.falcon@intel.com>
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
2.43.0

