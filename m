Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE54A3563C7;
	Wed, 29 Oct 2025 10:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733475; cv=none; b=d/QOheh8ljTxUZmVkJXtmlG3W7LpUWkQLB14F7Wv8FPAFzqLCM76CtEF/yHbxp2yJ0Pv3Lmdm5oZ1gg28114yLzYgzP8QyjI0zCAacEUtMcra6l3IiYfs83owpwScRMXVirjW30va/XqcRum49P+CokSWFmtEjtXXbGYvhv0wvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733475; c=relaxed/simple;
	bh=fypXV+RT+IE5ge/LUHhQaTkgcv75JX94HM2lko8sqP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZieKZc3tuAmFh8RksXvzjxbyV3pbGVExIoJS8qyNktGN8PRap+yVthaP1OOBsVApB2kTX/GPkOw2Vrk0vfDZb1WPCKW2X+AIeU5X6QzEOXlg0yXdciJ/0Ab4a+2lWAAB6YuizFYYXwhX8zCrlOIFUZKNdlyUGUzU3RKzPn44IOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=btxPUHAn; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="btxPUHAn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761733474; x=1793269474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fypXV+RT+IE5ge/LUHhQaTkgcv75JX94HM2lko8sqP0=;
  b=btxPUHAn5dRFDXsVsaVVCVCz40XBg9d6BWhn8Lh+h3zLpsDmBm/S4zX5
   EyrnJtb7Wtdo7VvG1OXivRT8bRJRH8lmvoRcr2Z6KcyvqHZJuMo2ikFMU
   89wVs5jv3YXhr46mrgOIyTRAj7FMHgh2sZBjjR9G7Bf0Hjqnyf1esIYP/
   402bD/FDbedQvrgIt/aGVLdHI1wxQg8K7pZLI/9jrDnF3DnApiEnbZweF
   P1mSWeOU+7ZMe/ceqiJ6eX5YX0T25lQ0RceDUQukcYb6M1b9NqEVQBURe
   bLxmKD2By5tH5rLrQ4lzARoHzXXwCKUELuEyZAed3hWftDYjpgPmPEmww
   Q==;
X-CSE-ConnectionGUID: 7bJxYgbxRsu0bSCo2mD8kg==
X-CSE-MsgGUID: okp/aR+XRNuuMJIq0MSzIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11596"; a="63885962"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="63885962"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 03:24:33 -0700
X-CSE-ConnectionGUID: 98A+4xsHSNOR5yvM7sx6Aw==
X-CSE-MsgGUID: khXG2NKxRc6qOnZjgxMTeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="185963357"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 29 Oct 2025 03:24:30 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v9 04/12] perf/x86/intel: Correct large PEBS flag check
Date: Wed, 29 Oct 2025 18:21:28 +0800
Message-Id: <20251029102136.61364-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029102136.61364-1-dapeng1.mi@linux.intel.com>
References: <20251029102136.61364-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

current large PEBS flag check only checks if sample_regs_user contains
unsupported GPRs but doesn't check if sample_regs_intr contains
unsupported GPRs.

Of course, currently PEBS HW supports to sample all perf supported GPRs,
the missed check doesn't cause real issue. But it won't be true any more
after the subsequent patches support to sample SSP register. SSP
sampling is not supported by adaptive PEBS HW and it would be supported
until arch-PEBS HW. So correct this issue.

Fixes: a47ba4d77e12 ("perf/x86: Enable free running PEBS for REGS_USER/INTR")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 46a000eb0bb3..c88bcd5d2bc4 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4029,7 +4029,9 @@ static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
 	if (!event->attr.exclude_kernel)
 		flags &= ~PERF_SAMPLE_REGS_USER;
 	if (event->attr.sample_regs_user & ~PEBS_GP_REGS)
-		flags &= ~(PERF_SAMPLE_REGS_USER | PERF_SAMPLE_REGS_INTR);
+		flags &= ~PERF_SAMPLE_REGS_USER;
+	if (event->attr.sample_regs_intr & ~PEBS_GP_REGS)
+		flags &= ~PERF_SAMPLE_REGS_INTR;
 	return flags;
 }
 
-- 
2.34.1

