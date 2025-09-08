Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C021C3C18;
	Mon,  8 Sep 2025 06:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757312304; cv=none; b=Ol7jEGXlP2/KskISn6h1uzTZL48Rareec31UhD0aqmqYu7y6mUA/Zxi2xP30xLMBTH2b6MNmoiyGgOL7CLt3cj56AlgL513QlmtTNjpcRdTSoyNsGKECg2dw1+HPm85/lp8tUcCosVQA9JEI2GqvQ6VKTk+UV4uAdjk9KLiY2NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757312304; c=relaxed/simple;
	bh=7Rn2AAo4+7/NCGYV/alHHPn9bqJoD2b8fTIdLRU68xE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IgEeYtRfTKI6sgBL9+EDw99QEX2mMdeN8kFTuyiuC4iibOwBbmoA1JkMEJMmJ0Sruyc7wuv1JFpgGSx8ZM0dUO3gaadCMkTsOvM9hNvPKe91HSaDKF2i2Euy67vqU5JH1auxjoLHUDVcx+iSR4BNv/eg1MoDmDh+jVABqCprjsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SdtlYgc5; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SdtlYgc5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757312303; x=1788848303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Rn2AAo4+7/NCGYV/alHHPn9bqJoD2b8fTIdLRU68xE=;
  b=SdtlYgc5FM/2ArOejaGBXhm6vnWNNxyAGIuc07SAWHtSGoUb43vucGBU
   cngl8Ds5frSRO6JZQGGyOVWBY/jR3KYXU/dkIub5DVMSYpozfJhm0yynB
   ZRlDqpOLH84pWlYOPCZd2fH7Y7SOIA1QkavEIfF6kpi3Ml0fY6e+mnP2E
   ySd8VvQDfuxnc/umfuBX1aL0NDq9XWPrEWPKXClGYwnMKGGtJ290jBehg
   ucyloa3zvss9ZR3W3JBTCgvZxg6V++/btwHVwpvUlMUf/Fae0vwAJlfji
   oYy0wyyRBGDuRIjSMwYOLTXnOdnsvmtxzy8wrhxW/cEzThpmgiN4mBWDM
   g==;
X-CSE-ConnectionGUID: 9YI2EZI9QCGUTYOuE2g0oQ==
X-CSE-MsgGUID: WFD83iheT5CL1lHSLYiISA==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="77177796"
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; 
   d="scan'208";a="77177796"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 23:18:22 -0700
X-CSE-ConnectionGUID: QN+CKx1rTmu329xaUGf7bg==
X-CSE-MsgGUID: txDYaetbQGCzODzlUvC/8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; 
   d="scan'208";a="172271721"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa009.jf.intel.com with ESMTP; 07 Sep 2025 23:18:18 -0700
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
	dongsheng <dongsheng.x.zhang@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 2/2] perf/x86/intel/uncore: Add uncore PMU support for Wildcat Lake
Date: Mon,  8 Sep 2025 14:16:39 +0800
Message-Id: <20250908061639.938105-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908061639.938105-1-dapeng1.mi@linux.intel.com>
References: <20250908061639.938105-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: dongsheng <dongsheng.x.zhang@intel.com>

WildcatLake (WCL) is a variant of PantherLake (PTL) and shares the same
uncore PMU features with PTL. Therefore, directly reuse Pantherlake's
uncore PMU enabling code for WildcatLake.

Signed-off-by: dongsheng <dongsheng.x.zhang@intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index a762f7f5b161..d6c945cc5d07 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1895,6 +1895,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&mtl_uncore_init),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&lnl_uncore_init),
 	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,	&ptl_uncore_init),
+	X86_MATCH_VFM(INTEL_WILDCATLAKE_L,	&ptl_uncore_init),
 	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,	&gnr_uncore_init),
-- 
2.34.1

