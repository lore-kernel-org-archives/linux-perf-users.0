Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B69431354D;
	Wed, 15 Oct 2025 06:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760510786; cv=none; b=fEvDsxdOIvvby1XoXKqS7BhC8qC41BvCkwnGBZA8ztc2YAiyRZ82w6MhjpuAaGQ5MrQ9lxGEBC4w3GwfYXOvMDlBiaC5yAGjN4hGMuzPxXTFZtxlnMR/C+VX7dli8TRQbtQ/av5qymjTODMGK5KrQr/ae7LfRsxjgaQpeaWpwvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760510786; c=relaxed/simple;
	bh=fypXV+RT+IE5ge/LUHhQaTkgcv75JX94HM2lko8sqP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TILO2/6mGHG10gCzR/3qU+foOd8zf+1OJzTEPRNpUKGXUzUx4t9b/rC5wU0rJYxV+tnjoGCUYbgsgbe8nozY0V9Exxnc+/MI23jT2jW9jPOu5Y8Pq9ULn5Xyh7ItqAsPMbTQ16xspXCyPjpNb9irKNKRaVdQ/y3QD3dIiMWE3G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ezhf8Uji; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ezhf8Uji"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760510785; x=1792046785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fypXV+RT+IE5ge/LUHhQaTkgcv75JX94HM2lko8sqP0=;
  b=Ezhf8UjixhWGwRkkdfjQyy3z6ha3Y/pD3ekRkqRdJB7ZS5050ProBkFE
   JUfiIQzRY25Qb1EvhZg3j6htLstJ3xltG+KUxfnnwxL+DdJcyq8rKbihr
   pxldLju4DdT69QPDOKokfxspMSNwYfvPPgMVmDV/TrFotP1jK0cTvN2Aj
   +IiF2SYfXieFZly3T1XtGDFBSgWlcAXRoLogjG2/BTIidyQAC0u8TTihg
   bVb4QGyz17+GsoAq8yI4uHs/xp+8LIs8n0ImQdX55SlUDa261Z+t/lISd
   HYV1h2tNITJosfvioZqxJPZFqxbEN7YiwkRAAmsr0frDKjCGo77KePD2p
   g==;
X-CSE-ConnectionGUID: v9e/84olTIytbBQQx6g7qw==
X-CSE-MsgGUID: KXi33fTsRBCQEwdM6QPcUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="50242471"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="50242471"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 23:46:25 -0700
X-CSE-ConnectionGUID: OH5ccqoQS4i+MK3tD7cCVQ==
X-CSE-MsgGUID: Cf9vRFAARi2TyQrENVwYoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="182029912"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa006.fm.intel.com with ESMTP; 14 Oct 2025 23:46:21 -0700
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v8 04/12] perf/x86/intel: Correct large PEBS flag check
Date: Wed, 15 Oct 2025 14:44:14 +0800
Message-Id: <20251015064422.47437-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251015064422.47437-1-dapeng1.mi@linux.intel.com>
References: <20251015064422.47437-1-dapeng1.mi@linux.intel.com>
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

