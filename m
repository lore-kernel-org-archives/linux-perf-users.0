Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72D3283FC9;
	Wed, 14 May 2025 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235688; cv=none; b=fprWCPioFW+J/S9tfcv/hkdn3G2Edd5rn2baCv7Vdp30v8THp8W5y0it2w/Hl3BAfPjKltg15k6lERX6o7OTP/GMwzeZMOrLZ5L/wgOi+mmmpZu7eKVhdUJvamO0R3CEFDtDoGxf3XGa/Eldndneqwu+nKHTtTO75riNIk4yvpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235688; c=relaxed/simple;
	bh=s+EyXjLUXo0M2dfj157AL5fvrY36sWvSBJ2tuImTWtk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SJWTGx6LqQuo19rqFBPzrkTw9z8LAYl2FoiBf7BgnFeiP/Rtk49NNNJ16xPJWASWfyQGYmALDaEfUNUwN4ffV0refsu8ZbKh1x1kSLpdxGmwMiWFuxf7++XpAQHPILL4R0MsDjcfpGgqeb7aSvj4ATRK9LkhtC5vNSEIGf2sxNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JmPHSa8p; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JmPHSa8p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747235687; x=1778771687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s+EyXjLUXo0M2dfj157AL5fvrY36sWvSBJ2tuImTWtk=;
  b=JmPHSa8pifUF7nqjUVenaAhZbECb5yUgXM4F2s1q8CiNMTk0Tk2c1CgN
   m2K4PkxHwGINIRqx0hfjoKN1nfZq2xqc6etfzyjUTggAMpH2o/6FzgpvM
   dDXlZ7QpYOKKeb1rzywQiQDCYF694rWOVYooPxgXfGDXDHEYdX4Qq68nA
   DcxM9zdavFtOp4TtYRhosk2kTd/DM9sQWCiDSvzzQACSH5m7T51R+Ibem
   nKMMFIiZq8YjddTaGlRz/4H+mTOFAarQpH5UCdvLeLTh+Zi+HXyOVVO+o
   q90b30rZIdhvkgI0eF8jOZ7gTcUFOyj0XP0OGOzqumQeYIVNbK67ek25f
   Q==;
X-CSE-ConnectionGUID: iGuQkVsjSAWt8VMi6JC2yg==
X-CSE-MsgGUID: VcrJcAKuSp6GtcG0Eea4kA==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49072735"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="49072735"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 08:14:44 -0700
X-CSE-ConnectionGUID: CIB9tTiBQxeDfYbnRRxmEw==
X-CSE-MsgGUID: X62WA9/KTryQTVKPFxrNVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="142939165"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa005.fm.intel.com with ESMTP; 14 May 2025 08:14:44 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	irogers@google.com,
	mark.rutland@arm.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: eranian@google.com,
	ctshao@google.com,
	tmricht@linux.ibm.com,
	Kan Liang <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V2 05/15] powerpc/perf: Remove driver-specific throttle support
Date: Wed, 14 May 2025 08:13:51 -0700
Message-Id: <20250514151401.2547932-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250514151401.2547932-1-kan.liang@linux.intel.com>
References: <20250514151401.2547932-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The throttle support has been added in the generic code. Remove
the driver-specific throttle support.

Besides the throttle, perf_event_overflow may return true because of
event_limit. It already does an inatomic event disable. The pmu->stop
is not required either.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/perf/core-book3s.c  | 6 ++----
 arch/powerpc/perf/core-fsl-emb.c | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 42ff4d167acc..8b0081441f85 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2344,12 +2344,10 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 			ppmu->get_mem_weight(&data.weight.full, event->attr.sample_type);
 			data.sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
 		}
-		if (perf_event_overflow(event, &data, regs))
-			power_pmu_stop(event, 0);
+		perf_event_overflow(event, &data, regs);
 	} else if (period) {
 		/* Account for interrupt in case of invalid SIAR */
-		if (perf_event_account_interrupt(event))
-			power_pmu_stop(event, 0);
+		perf_event_account_interrupt(event);
 	}
 }
 
diff --git a/arch/powerpc/perf/core-fsl-emb.c b/arch/powerpc/perf/core-fsl-emb.c
index d2ffcc7021c5..7120ab20cbfe 100644
--- a/arch/powerpc/perf/core-fsl-emb.c
+++ b/arch/powerpc/perf/core-fsl-emb.c
@@ -635,8 +635,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 
 		perf_sample_data_init(&data, 0, last_period);
 
-		if (perf_event_overflow(event, &data, regs))
-			fsl_emb_pmu_stop(event, 0);
+		perf_event_overflow(event, &data, regs);
 	}
 }
 
-- 
2.38.1

