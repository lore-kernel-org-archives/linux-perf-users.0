Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BBF28641F;
	Tue,  6 May 2025 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550099; cv=none; b=s7iQzCMHtHIpV4s3qeZ3ZjSsqUpjrySxFiWIyUlcB6kE8rYvwnMOcME4UsdXDgh6e3FL8kfF+bmsy3tFDzC4dTGMKY2ekBfBX+nypjVn4q69LwhZspDK2XN8dno2tk5fFc3T0QhHjnDBdDs10X9BPdd5dpD3Ph9ogwtt+qCdrsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550099; c=relaxed/simple;
	bh=jtzi1Dswis+7E8s5xuD4Q5RcegCZpv4/8lL3qUWjHa0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kPWI0HXUaHwLN/O7fsuQmDWxq0nll3HryGC8pWSFd0QsVRVuLPu7szF6dydZkukfOPJE92ZNJutkgaPRqnZI17Y3zdEBxYMNWDrPytH775nuB90V0Y5xX5YeK3h/EwuM1/obiNwwGDYU0C1ltR1x4PoDSkiBoiDXpMUsykBQA4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bW/0+qy+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bW/0+qy+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746550098; x=1778086098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jtzi1Dswis+7E8s5xuD4Q5RcegCZpv4/8lL3qUWjHa0=;
  b=bW/0+qy+TtCEMGFvFGSK48ku+ca2oYJWafYMAb3XKFSjGa3gBXnE6r+s
   xoAXJrOZr/iU6wjbteY6k1ksspq13Q6zE/FLEqp9ECuQmXN/L8lcKz90c
   hdxPYROqas/7Orfphxh8GeP+cidPcxsAtv2Y0GRcyS8eritrdGkLhJTe+
   s66kgCpxUNwOAmHrJuIplLYjaGwQ+ieVGTaOPmlgMBBg0chtacV9Sapxq
   jurFA8qjo1cE6Fk1IWAPM1/ZKgGyliXrumcOzsxue2brluktMIvFIocZL
   DAxz5mgh+5tLfj8D6/JChcLystF6bYi/KPT7piuvosHGTSHsZqXNa5auQ
   A==;
X-CSE-ConnectionGUID: 13Go7aH4SuOk15RksTsESA==
X-CSE-MsgGUID: qt9ZVx5IQIucORf3sUKPDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="59595291"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="59595291"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 09:48:17 -0700
X-CSE-ConnectionGUID: 0NTosvbcRUu9FW/MC+fc9Q==
X-CSE-MsgGUID: TehkUsDYTma9onAXHpI8Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="135674877"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa007.fm.intel.com with ESMTP; 06 May 2025 09:48:17 -0700
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
	Oliver Upton <oliver.upton@linux.dev>
Subject: [RFC PATCH 08/15] perf/apple_m1: Remove driver-specific throttle support
Date: Tue,  6 May 2025 09:47:33 -0700
Message-Id: <20250506164740.1317237-9-kan.liang@linux.intel.com>
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
Cc: Oliver Upton <oliver.upton@linux.dev>
---
 drivers/perf/apple_m1_cpu_pmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index df9a28ba69dc..81b6f1a62349 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -474,8 +474,7 @@ static irqreturn_t m1_pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		if (!armpmu_event_set_period(event))
 			continue;
 
-		if (perf_event_overflow(event, &data, regs))
-			m1_pmu_disable_event(event);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	cpu_pmu->start(cpu_pmu);
-- 
2.38.1

