Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA7833ADAC;
	Mon, 14 Sep 2026 22:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426024; cv=none; b=dF+T6jmYZIksYhflsrNo5TNIWXP0r3Jf2S28w9s9XgwV96t/xCYBHjOmXa9OA6t1UZ6d69YM+EuYMUrZP99zZV1FnjpT1Y1NeaP0zPnghU0hTQ3BUMHuAYnFYKYGpBbkRk5KXbTDaZTHs/0Viwup6XTB6v+VAJfpyHLpQYSSkGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426024; c=relaxed/simple;
	bh=pOePqkBJLrfv2TXiH/IEvGpnSf3jUCHa0XcWppuJxAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAAz6QXK+0sA6rqdEKwcEQ17K1ELs/VfWF/xYOprZrppWT50XClKewOEA5FXVXRJZ0VkfC/2KaHvsFe+ms3nBNYStQYMT1yXNa8vpRajXPnfpM3+WnkiQBQwqYqAVClG/KmgDde3rbt6p2hCMs4zlQYyQKzZa4wEhIvqx4+9bSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OiZx5MCR; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OiZx5MCR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789426022; x=1820962022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pOePqkBJLrfv2TXiH/IEvGpnSf3jUCHa0XcWppuJxAU=;
  b=OiZx5MCRAPzbbfSbQloyFX5Wv98kTRE9dkLAaQOK6DlT3LvDxw+LwtM4
   gzDHbsyjcHWtUn7cnclwSyoU8tpwiz8+oWFe9mxeOucG/fFgqLrapFYDz
   hZ8Ai+V/i319Z/vyam8T8VdCjK/khND14ZgLCm0lMVE+XY3gtBrmPAL5P
   gmfuhQ3HzCp/Tdlu/zthVg1QFMezGjO2jXDlmBdcZMdVyS7Flm5Pp6N6j
   9lRbJtaCxH4AM4TZxxvuRNCZLTXx12xWs3LxeoeWYad7UrFoX3AuiWzfh
   dwudZXMtLuj1KkoyAEAoRls9MazpQsTP9fglAfXZHnO8vmYVC3x6lHisd
   Q==;
X-CSE-ConnectionGUID: zJBWiMYfSR2lM0nC5vVvCQ==
X-CSE-MsgGUID: fWGGZ5UJQGi5brEKJbGDHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93483211"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93483211"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 15:47:01 -0700
X-CSE-ConnectionGUID: 2G3ExIDnRx6rQuGp4/oXCw==
X-CSE-MsgGUID: +y7sMF3GSSmnW2YUz/9IaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="268480091"
Received: from khuang2-desk.gar.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.223.56])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 15:47:00 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH v9 1/6] perf mem: Fix size tracking for mem_lvl's in perf_script__meminfo_scnprintf()
Date: Mon, 14 Sep 2026 17:46:45 -0500
Message-ID: <20260914224650.52982-2-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914224650.52982-1-thomas.falcon@intel.com>
References: <20260914224650.52982-1-thomas.falcon@intel.com>
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
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
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

