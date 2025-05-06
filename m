Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C3D2874F1;
	Tue,  6 May 2025 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550103; cv=none; b=byCOsRqsBSPSpN2LT9554v0PawO9fbRzmD1l3HhswaX3LgjvW1eB2uuqtajWaXR4feV+u17Qe9Fdx4r/LoGCjBfw6qLfLJFROl9kTwBGqS93cSCd//KMrMkcB4XulVavFxZzMqKuCLJM32lqGWqzjOKKjqNRUHuZuCJjE2iSCtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550103; c=relaxed/simple;
	bh=e6ZGtoFS3wb4lZcFgyi/mMNsez4qDnJTe8sAQRVY/KA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F6zS4g1TEOqbJEHylkzBlMV3NUYsQ381rw/q1wJnDxnRwcQh4Ueu9X45CaJ4NDQODYmtqQsCjUVngR6z0Gmu0s0kune39Br6PqrSFEVpb0i9+oRS7MSuT+HiIoBITW0+UaiulOLVm9LYPHg08Z7kLN26kWJCQ57+5DlhPz5PIj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZFlJ7WgG; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZFlJ7WgG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746550102; x=1778086102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e6ZGtoFS3wb4lZcFgyi/mMNsez4qDnJTe8sAQRVY/KA=;
  b=ZFlJ7WgGWVAIIj90eBNmB8p/nUYCwifdrfbPWeSA/VhnwZ+mHTPLACOG
   lXXXXSwRaA/DWDNilE90icdh6zLG7NJlE0yWDC3H3E4D/RPlP9RncnLC5
   edho5UcTOuTSHk8rrl65OfTFeaoeGxgNcDwXnfC4eKXCPupX8ktuG696m
   Z+ayMifFV12wMZXXCeO4cquKqbDdkEbd1BY4M7Nr9/uvpH2TLsxPgh2RE
   +gHzGeXZ2pXwWj0G0L1HhIPG0wpCTloIxUb9xlnyAF3fj0sCWAHJBfG81
   GUpSsWmiOvNu7Kl/6lYrK99oY9N6hJGU9VusI3oYCbQroEn6ok2LiFuKJ
   w==;
X-CSE-ConnectionGUID: is+xYLB4TXi89NwDHIhhPQ==
X-CSE-MsgGUID: Gxyb8V/xTC+RIeZYv5jfXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="59595323"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="59595323"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 09:48:21 -0700
X-CSE-ConnectionGUID: gY61lUd7QIayNdAhRfPncw==
X-CSE-MsgGUID: tYrTELXYQ0yDCZtkqHR44Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="135674893"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa007.fm.intel.com with ESMTP; 06 May 2025 09:48:20 -0700
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
	Bibo Mao <maobibo@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [RFC PATCH 12/15] loongarch/perf: Remove driver-specific throttle support
Date: Tue,  6 May 2025 09:47:37 -0700
Message-Id: <20250506164740.1317237-13-kan.liang@linux.intel.com>
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
Cc: Bibo Mao <maobibo@loongson.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/perf_event.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/perf_event.c b/arch/loongarch/kernel/perf_event.c
index f86a4b838dd7..8ad098703488 100644
--- a/arch/loongarch/kernel/perf_event.c
+++ b/arch/loongarch/kernel/perf_event.c
@@ -479,8 +479,7 @@ static void handle_associated_event(struct cpu_hw_events *cpuc, int idx,
 	if (!loongarch_pmu_event_set_period(event, hwc, idx))
 		return;
 
-	if (perf_event_overflow(event, data, regs))
-		loongarch_pmu_disable_event(idx);
+	perf_event_overflow(event, data, regs);
 }
 
 static irqreturn_t pmu_handle_irq(int irq, void *dev)
-- 
2.38.1

