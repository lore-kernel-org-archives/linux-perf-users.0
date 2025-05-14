Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1EF2749F1;
	Wed, 14 May 2025 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235687; cv=none; b=A6dwk5WSE2ftSE9E1kZY7wlHQ6+u71+c5asqLzqyobbRoNjMDnJAqyPkoAV3prH+OU5IAxVoBlQxT904F3rQpfrl5a9W25q89U0joTpXUFfWLOJVI9PcFu+U9QSqSI0wfapuK0H+zZunwU1sQDtmC2kUjJ9fSkPFUZEtIxyvVSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235687; c=relaxed/simple;
	bh=0hRB1IvQlzGriWaTL732AEH9Fmh4KKnhaup08Q0Jp/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BRwih52cce0q5dSr0Q+IpznmmaCXxMLigAsSAdhhnU5uGOZwnpUULMinsr/3Ebx4lwNiB6TgVi9YT0IGizyYJplmri7bN7/LsXIpGI3ac9WJUIthwpKqD5wEjiuGe2yiddiO136tcckB9Q4Pcg8AMr+FshK8FSIjytPyFHI9E1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L4KNQBKD; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L4KNQBKD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747235686; x=1778771686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0hRB1IvQlzGriWaTL732AEH9Fmh4KKnhaup08Q0Jp/4=;
  b=L4KNQBKDlXrM8wvYhKpFmv7GOCCxTzhBCo28I5z5RxVA+4bZz+0qr3am
   NLjbIpe8Fbd+VGWxqx7Nb+c74oDUFSizz8Pcto5wghblVxax+Uvfarlin
   1V87syDJI0/9fEcpHn07M9C96eSoGSLH+oHlW+f/CxpdxWlQ66rAM+MH5
   zOMyeQoIaawhyR+YjIspcKGp26ukMpkoHutMZ75/HMynnf9708oQkletw
   o8solHDhmQo34WPcUuV53vxRLM3cTCQtyZuNdGRo5lQDs/fHcXf7hwBpZ
   yBms+T5wJSAZIsMz5q8INrf0UxSLlZ5MVgtZSnj5P+xJvM0l6C47SVH2G
   w==;
X-CSE-ConnectionGUID: rXFmLqM6Sjm7Zj30fWl68g==
X-CSE-MsgGUID: J/I3yQiuRVKndNd6kN6bkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49072719"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="49072719"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 08:14:43 -0700
X-CSE-ConnectionGUID: ZwAYKfp0R7mD55WQIr3nOA==
X-CSE-MsgGUID: UlfTyqo8Qkitcobp/Y9ixA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="142939161"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa005.fm.intel.com with ESMTP; 14 May 2025 08:14:43 -0700
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
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH V2 03/15] perf/x86/amd: Remove driver-specific throttle support
Date: Wed, 14 May 2025 08:13:49 -0700
Message-Id: <20250514151401.2547932-4-kan.liang@linux.intel.com>
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

Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Sandipan Das <sandipan.das@amd.com>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
---

Changes since V1:
- Add Reviewed-by from Ravi

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

