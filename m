Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA4B2882BF;
	Tue, 20 May 2025 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747765044; cv=none; b=cRWm8RJ2nGCN6vdSNDn2nwvMP5TEdqnwh3W7uEJ0CfbCY4ePJPNceMkextB71TARrWRIHYcqYwZuCA4IXWVfNe0xvUSduM5Vy5Cb8Wze771bUXF9EnO8QGdQpOlwPNoeIitwjXJkewJXmBubJJObh7Oljs0xJEKZvzuBMotJjE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747765044; c=relaxed/simple;
	bh=NOF3NytMVQIJq/xAjPCxlMah7ql+VhgMWECiQmo4kho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nnsZoNFov0WVFUmj5r0sAfK3oX/71MwMg7lCt675ULaaeweGAc8VkbPlX/ML7aEbWwTS8OPz3Y7gflbashZJK1n2jm0OlXdY3Ee+LcA7xmfekC7voa9rgXDinWove91ZkUyTe6hVaOf2NvzqrFdn5WzahpR0zpmwmzguVW7aV9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V+lbkm+6; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V+lbkm+6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747765043; x=1779301043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NOF3NytMVQIJq/xAjPCxlMah7ql+VhgMWECiQmo4kho=;
  b=V+lbkm+6w+k1Sbt0DTOW+RDvb3jzOI72dcUUfSdDZmTCwTvGRxlL/G2U
   ywEcgtIhb1pIe7ABINnjeXA6mdxAC0ph17B+SQ0rE2dAaKGSvKhnT7av0
   kUoQ8/6D02vfwPlkwtpb+tg1Cvm49qDrhuMsBNxoSVBU2UnriHNnaFFSw
   WVBkbzphLRZcmbx/gV444Os09lb/ipzzmmvYte9wuQS51y++LH5mFyz1E
   gtipWVRhXvANSAmUs0+O2Vce9jMImLRAstZzDfls5O3e1t/DEpabUXj9Q
   s4M3BhBjkQm89u15b1NBs3O8fAQxSeH4/jQR320OYWEdYoYFDLRugE1X2
   A==;
X-CSE-ConnectionGUID: m+2/8ZTaT8mk+RSH+lx8/g==
X-CSE-MsgGUID: 3e6ikdJnT9a9EKSduAkRwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49848048"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49848048"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 11:17:14 -0700
X-CSE-ConnectionGUID: 6qpFn7j3TNC6gp7qhJhruQ==
X-CSE-MsgGUID: b781uelYQK67hqjQQq3+xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144514723"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 20 May 2025 11:17:14 -0700
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
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH V4 15/16] xtensa/perf: Remove driver-specific throttle support
Date: Tue, 20 May 2025 11:16:43 -0700
Message-Id: <20250520181644.2673067-16-kan.liang@linux.intel.com>
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

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/perf_event.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/xtensa/kernel/perf_event.c b/arch/xtensa/kernel/perf_event.c
index 183618090d05..223f1d452310 100644
--- a/arch/xtensa/kernel/perf_event.c
+++ b/arch/xtensa/kernel/perf_event.c
@@ -388,8 +388,7 @@ irqreturn_t xtensa_pmu_irq_handler(int irq, void *dev_id)
 			struct pt_regs *regs = get_irq_regs();
 
 			perf_sample_data_init(&data, 0, last_period);
-			if (perf_event_overflow(event, &data, regs))
-				xtensa_pmu_stop(event, 0);
+			perf_event_overflow(event, &data, regs);
 		}
 
 		rc = IRQ_HANDLED;
-- 
2.38.1

