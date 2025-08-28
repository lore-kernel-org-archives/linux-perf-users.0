Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C98822E406;
	Thu, 28 Aug 2025 01:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756344972; cv=none; b=YX7c7WJvwNsbhqwg7+rpK8ZjNOCUZEoOCMWdxbRCDzzjld+Gix+VOcKlNyaBP3kFceBqBZRBchmxRRKPiAsAbHVEd7yDfhqeD72dRtAzj4+dCXZA3w0t443TUL45znRI17/wVYVDVl+3MpGUzSLAGWBnGd/vY2d5pSmOkB3wZ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756344972; c=relaxed/simple;
	bh=fypXV+RT+IE5ge/LUHhQaTkgcv75JX94HM2lko8sqP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dpD52SkeLCcBfOJEbZUwwqg4S0BTUpdko4SRCzzGZ1PCPaxq/ktlD0DR8ktYJnjzouBCG6Hl7j1c3cH2HQKF954EeInqG2k8e03sp7t0sMDSP6pk5ZvcQjDA/iH7LsnhmtU4kDFEHtpU0bGuqCdqZkIouMbTivHohSymR5Isb0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BKH8mxMy; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BKH8mxMy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756344970; x=1787880970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fypXV+RT+IE5ge/LUHhQaTkgcv75JX94HM2lko8sqP0=;
  b=BKH8mxMy0EnNiGgliD89vUZzgsMRWdI5IOIzLMDcqDC+w6lz0CNTq8go
   rYjhCKGInHXeul4NjC4qeF4WE10CAwc8uP+Yd+6+AYFIQxAcP2TzQoRGg
   4l01NLqAfRN+qQxo+RuqsGIeaHx/vbL+/EMnRdSBkz+unrUOHEQsjr5JZ
   s/i5gJ3dRwVpADivJUB6k/a1U83P871epmNHPGMETkNEL2AvbHv4Jj8Dp
   AyJcDtWHBVOj3j/RnxoQ4MrHiKeObVj4HceitcaShdUz9wcbClDwd47Bm
   3Q46cJICIQSPIieZwtgBZTdm1jWLBy9hRnKjEun8tRy2RQFVycUbmk4Zf
   w==;
X-CSE-ConnectionGUID: RMywc9+gTg6ooBymXYzKHw==
X-CSE-MsgGUID: kndwOxjURxm92E7bFpY2DQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="61240844"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="61240844"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 18:36:06 -0700
X-CSE-ConnectionGUID: SB8BGbtvTluiWK62SNtGyw==
X-CSE-MsgGUID: nuQx6MlmTWaisPzfVwaUFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170372509"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa008.fm.intel.com with ESMTP; 27 Aug 2025 18:36:03 -0700
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
Subject: [Patch v7 04/12] perf/x86/intel: Correct large PEBS flag check
Date: Thu, 28 Aug 2025 09:34:27 +0800
Message-Id: <20250828013435.1528459-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828013435.1528459-1-dapeng1.mi@linux.intel.com>
References: <20250828013435.1528459-1-dapeng1.mi@linux.intel.com>
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

