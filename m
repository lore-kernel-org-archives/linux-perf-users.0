Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41492E8DE8;
	Thu, 21 Aug 2025 03:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755748769; cv=none; b=VyWezlcuUjqfoBvYh6xHIu2s1SMJX9zLDNhjFi2rY9FSA4wOrDNnPOYrhNfQtbzvASX/QKmD7DIrcFvBQlJ+Zr8kgilWLHsJ5iCqHlQNa8VLD3snArS4Td3l7q8Z3HWe0I6CvYhC9e+XqHi1o2eW8W6X308FvBjAU8NeXDdBkEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755748769; c=relaxed/simple;
	bh=fypXV+RT+IE5ge/LUHhQaTkgcv75JX94HM2lko8sqP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kswVoLOsJYbikQrZ9aLBdN2Y95vC16jhXI2yC/YJh1C0pHtPgAPD8hi5xMJLAZsotcx/H8JTiy9/DRrW9hE2GyNu5Smpnodtki1tSMjuAoz8KC42NQlIZ+gO2DAAskXQ3tGnsNOYhUYw3Lx1ZmO7NuyPCAhU4U7erbq8oOA0HSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S67gSGTV; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S67gSGTV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755748768; x=1787284768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fypXV+RT+IE5ge/LUHhQaTkgcv75JX94HM2lko8sqP0=;
  b=S67gSGTVld9jpMtczFMrfdbWlmCokXLLtvxl8VWZqVcQIhSRRV5YH5Vd
   FSV4DVa9q1aHXlvYPuxTZLahjHqNDUBcWtXy0001A2xrSvbVgYl8FJ/ZF
   E+o4ck8xe/DZysCXkh7ED4ZJhoUO5hjpiuoGeBFHVgpnfrUL1haImfKis
   7QtGLR+cvtmgTFhwDNnw+ljXgxSVJztqm+bS0VbyqE6mVsV9Lov4ugGZB
   mV99U9AFvdu5XSv5NOngpZ8QXyuQMHqvb7yYZcHg39iSkaK/Pfk4UvqyS
   h63eHdao1vkT8vp2nBJB/DyprouWLHv99Fy3W+bfZlDe1RwP2VYgFaqoS
   Q==;
X-CSE-ConnectionGUID: gsyYWoXST7ycwu27cDXvAA==
X-CSE-MsgGUID: yRXRNm8zSKiXrnMOSvXwyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="68731954"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="68731954"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 20:59:28 -0700
X-CSE-ConnectionGUID: J5mwtVenS1KBMa3uDMeGqg==
X-CSE-MsgGUID: /eEgwgoxRo27pM/3Hpv48g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="168713022"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 20 Aug 2025 20:59:24 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v6 02/10] perf/x86/intel: Correct large PEBS flag check
Date: Thu, 21 Aug 2025 11:57:57 +0800
Message-Id: <20250821035805.159494-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821035805.159494-1-dapeng1.mi@linux.intel.com>
References: <20250821035805.159494-1-dapeng1.mi@linux.intel.com>
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

