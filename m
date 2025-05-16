Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B24C27D770;
	Fri, 16 May 2025 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420164; cv=none; b=jHVB2i514LSnhqlngh0KWT5hK76HPwyUvhOQUcD3lkDSB4VJ0vmK7KyE0iS/hLdBj4Q0vA868kvQwVQ9fUWqlrmOAN0s6BtRpKlh8A8oBeG1KU8OoRARj5mre61EafZnPBxDyQjlvnmSLm6iXMD3VlLbkv+/vKjeOSQlxM51ek4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420164; c=relaxed/simple;
	bh=mmZ9nbgB5fwwHNOO/FW7dHFDnAhM6aTO/E4japeEfI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TFcT1pLJidHBHTTfIcTrqRsnx4K/FYUoVX0NDNxTvnwyApVW7Ok/vPKTSnultNhSi9y7ylG7ppNKeOp+jgfhByKivZLREz67z7pFNgYgvHj8BzKsHT2wCKCQSiAykdgapY0awlc3ccDutrQVEto8UvEu9D5Wlt2kngK6kLGAesc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dxVSa2KK; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dxVSa2KK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747420163; x=1778956163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mmZ9nbgB5fwwHNOO/FW7dHFDnAhM6aTO/E4japeEfI4=;
  b=dxVSa2KKRHLH/LEDryGwMsgbwfb2Jfo+WfcPkVloiqw2F2mSfEuFK/W7
   rQEnUVGS85P45pyagL3MOulRI27/mJWsiLokHXq6twsJR2Zqf0l8Eqe/h
   1yTObTGFDbbmfB/T6jlgE5l15Mawuo/+WxvoX4OAv5XbkyOMi4zgy2WSq
   dOCZVcCBwudZdNzZ/s1JXaO8jvScbzWtEs2W/01Cf6+YMJQzm9g2xmv6P
   YwzhVbwOTq52ImgIlstDM5vxcbysu0n2gNFZ/CBgzTaU5X3Uh1QBIo351
   9xMnRb2/7bGqFZWUFI8z01ZbQ0MnKwZfSNFUK+G2gyu9Jsp6W8LFqR69z
   w==;
X-CSE-ConnectionGUID: EEl7ojkJRwmmUnm162SzVw==
X-CSE-MsgGUID: ShBs62X/SOaQCV2e21y8bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49328816"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="49328816"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 11:29:21 -0700
X-CSE-ConnectionGUID: vslG2EC7SwWo9ImaBWdTQw==
X-CSE-MsgGUID: uPzGL08mTTWhWlT6wVgjWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="169802603"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa001.fm.intel.com with ESMTP; 16 May 2025 11:29:21 -0700
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
	leo.yan@arm.com,
	Kan Liang <kan.liang@linux.intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH V3 04/16] perf/x86/amd: Remove driver-specific throttle support
Date: Fri, 16 May 2025 11:28:41 -0700
Message-Id: <20250516182853.2610284-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250516182853.2610284-1-kan.liang@linux.intel.com>
References: <20250516182853.2610284-1-kan.liang@linux.intel.com>
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

Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Sandipan Das <sandipan.das@amd.com>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/core.c | 3 +--
 arch/x86/events/amd/ibs.c  | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 30d6ceb4c8ad..5e64283b9bf2 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1003,8 +1003,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 
 		perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
 
-		if (perf_event_overflow(event, &data, regs))
-			x86_pmu_stop(event, 0);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	/*
diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 0252b7ea8bca..4bbbca02aeb1 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1373,9 +1373,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		hwc->sample_period = perf_ibs->min_period;
 
 out:
-	if (throttle) {
-		perf_ibs_stop(event, 0);
-	} else {
+	if (!throttle) {
 		if (perf_ibs == &perf_ibs_op) {
 			if (ibs_caps & IBS_CAPS_OPCNTEXT) {
 				new_config = period & IBS_OP_MAX_CNT_EXT_MASK;
-- 
2.38.1

