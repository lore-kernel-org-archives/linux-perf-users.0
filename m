Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E934528003E;
	Tue, 20 May 2025 18:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747765038; cv=none; b=LG8x1wvwLQ0aG1rmnv02ugPNeNrMuLYjbJTp0l8fWYfsN7cymMPjmU2lrbq1SO1IZ6AnKgDH1T0V1wymoUwmEOuii57MFFKX9yiC+GntfB/iFB2kN6Oe4YCJjmspwJOTHctQ7YA1iYU5UIbpBfUVhOrcPWAWAvWFa12bDkl400k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747765038; c=relaxed/simple;
	bh=mmZ9nbgB5fwwHNOO/FW7dHFDnAhM6aTO/E4japeEfI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yt3PjVK9e9CxDnHze2gh4LdePGqbZPKMwn4bJ76MHhHxAo8j60j+tU7ad3M1Va0gU6LRk3PMKsMyKavqmeO/dha+9p8RZ8ePko0HqREuSnDqW2U+BWB0fN0mlFxh/OueRbatTG6tXuLAlPe2RUQv8qTMXIyeZDS4GaWfCjR6u1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dLtymv18; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dLtymv18"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747765037; x=1779301037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mmZ9nbgB5fwwHNOO/FW7dHFDnAhM6aTO/E4japeEfI4=;
  b=dLtymv18BqxJ4R9+h1VXcb3EWPTnzJtpFwT3RFFvGJBlwuYpVPeyawQ0
   Uw+OTyeDcyqQs0lQU8xOdmAvVxqYd6V3wcsWV3CUw5MZnj0NvsevwKDHI
   pZQ6ZCa4iPOP/qaYV2Q3OfCvSjxskMEoLlZzdfvz2RBD9fk1FRN3FlzIP
   bSFRDgzviaHsfxQG0pUK5A7CN5t9yeoQgFowRpTWXwWhMjChKHlTUq0rU
   xyqZLghl8H2LkNZ9zBv45ib59ZYPi/7oX/gX3xYOfOrliAkbCu0cfeH7S
   hBFmgUPfc+5IXS63tmcPUnrHha+Wgs/irf3YPNZ+ISfNyUATPWKmPAHfb
   w==;
X-CSE-ConnectionGUID: ZGM9q/0XRW6xsqTR7V/sPQ==
X-CSE-MsgGUID: YYH6FZlESUq3YMi1FIzU4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49847970"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49847970"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 11:17:13 -0700
X-CSE-ConnectionGUID: bbBrjheYTJOJj2VjtmhjiA==
X-CSE-MsgGUID: YFkfR31YStOTiwISYwwrQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144514707"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 20 May 2025 11:17:12 -0700
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
Subject: [PATCH V4 04/16] perf/x86/amd: Remove driver-specific throttle support
Date: Tue, 20 May 2025 11:16:32 -0700
Message-Id: <20250520181644.2673067-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250520181644.2673067-1-kan.liang@linux.intel.com>
References: <20250520181644.2673067-1-kan.liang@linux.intel.com>
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

