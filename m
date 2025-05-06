Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D902853F7;
	Tue,  6 May 2025 16:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550095; cv=none; b=oO6GeCl2XLMIOSG5dZ0zaFsziWcRW0otYsOAxznmjQhEQR/LdSRy39rMmYfZORen8PisNUHh+oTJDjBsGhqQCjoDk4CPu5TVUJ51CMHyngQoA5DdNGp2+RqQugLJkx7v+06NbROEvLEE03RlaO/2ui1IDrxkRIqCNG0WVNdTmMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550095; c=relaxed/simple;
	bh=RMEehrWYnmEORlN8I5Spw4Yog1jSoilWyq1ppX1bKEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ke8SVwQ9c8y9lPuPhXvmLyHoH8gx2W0Xzqecm4Pg6DmGtc3zqP9Pd2mTWh2jSe2BJ3wknjSYk263YENsh0mi8pdwvhI5wtKI5xIrl+BNGVSMXcCnleS5jcRYzNILLm1SRltUO74nUiBCtSA8/b4LsydBdf4sTEIlbvr+ddMVHUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lv+DAO+O; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lv+DAO+O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746550094; x=1778086094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RMEehrWYnmEORlN8I5Spw4Yog1jSoilWyq1ppX1bKEc=;
  b=Lv+DAO+OCoFn45r4VUnPpYy8Xy6T3RZkPXRncj0l7pu0IT5nprNuBAN4
   lK2PY/SdVxCJs7uZnkWTid5hU8XplOmHRFsWsH5lSCPz5kM8zCJRUtKUY
   pJsM0x/zAiJn4KzdUnG2nSoHDzetMngal8cnWpDBXCPE4W8MjA6iQpK9V
   3SSwHrOeg8q3SCVl51qexuU+5DqgJIA7zIxIsiypQ5ou8bqiTo0f/cL+d
   gdapDYaz0vPbaxRsTkyp28eAMyLEy3eF3U7QqkR6jLXHpg2yD4+sT1k+6
   adNdBe7GG3gYmeS6e3SqfPKmQYRLV3i6SR2dI+ci9hy114RPapi55KTF4
   A==;
X-CSE-ConnectionGUID: k4qxrZsXSwOQaPd85FVpeQ==
X-CSE-MsgGUID: y2Fy/EhsQ3qshUBqyEqRFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="59595238"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="59595238"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 09:48:13 -0700
X-CSE-ConnectionGUID: BT+lBUeSQzumpL83ImWCeQ==
X-CSE-MsgGUID: ul4nINe+TZ6rCAqW1RSGxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="135674849"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa007.fm.intel.com with ESMTP; 06 May 2025 09:48:12 -0700
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
	Sandipan Das <sandipan.das@amd.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [RFC PATCH 03/15] perf/x86/amd: Remove driver-specific throttle support
Date: Tue,  6 May 2025 09:47:28 -0700
Message-Id: <20250506164740.1317237-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250506164740.1317237-1-kan.liang@linux.intel.com>
References: <20250506164740.1317237-1-kan.liang@linux.intel.com>
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

