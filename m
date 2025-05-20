Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1687B2820CC;
	Tue, 20 May 2025 18:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747765040; cv=none; b=PdFthlu3m5O6u5sIXpvRvdcP9L/6GMk3F0bfjWECVOlcf/tjCOmwQOvEljLDF+kPsfU+QEbzfXpHLOv1uAjpWE7tnBcy0uDjnvALMbhB90q77r8QGCwWBTrNuseiTQTb0eIujayl8K5vSUDLqKZ6PAS733KCC7c3S1A7OS1Xvts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747765040; c=relaxed/simple;
	bh=h551J25h8XFy68PU1OOtFou2mqDGDS+8kG2qd49H3XQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JvMlZLDeTPlZNz8V/FhM4qL+asn+krL7Won7TznWKRDMpXWTVcQ4l+MNzykrwLxnN/AGSLcEZZ1sKBz/IWQtG+cbiQfCYZnn5CkQE3we0A0oB7Bjqimw5jyHYJbYBU7YGZVXWLn4TVwml4LsZmEqbm/4R7ROhLYt4ciMZA+H/Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D25Xv37e; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D25Xv37e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747765039; x=1779301039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h551J25h8XFy68PU1OOtFou2mqDGDS+8kG2qd49H3XQ=;
  b=D25Xv37e5kUsF1oLte5lazkzas7WYR3PimDRC22Xw/7cMVQ5dYxj2qew
   Z7D/vREuQwMZs0rqQuQQP9V+J1hpU+5vSSvhTyHOA1Zx7ioRm/dfsqNMV
   aHAVEBPPNF2Ao7r4TBVc1n+v46RopISCntYnmwW9CAxzBU3RjF1JoJUM6
   swWPC2dHhuac6mia160y1c95JOJbd/bFh8nOLPrYCphNloj6al28gn615
   yh3AKeslIaG1YrEvPIuKb/l5Mx4d3p2kj48kYv2Pzbb9VYgDd2CJvA3aV
   PJ464e7slOIRF5UHYQt9RWnV0/9Zs+jG11cTbog1laDN5HF/o6YZbzRzC
   A==;
X-CSE-ConnectionGUID: 3e+qtiHvQNiSth1zJWTEJQ==
X-CSE-MsgGUID: n0meFTSIT7OsKtECc7pcXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49848003"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49848003"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 11:17:13 -0700
X-CSE-ConnectionGUID: 55eNsgydRpqO2EHr3QlfWw==
X-CSE-MsgGUID: lNNNpJUhTU2cdjOXb2jVXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144514714"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 20 May 2025 11:17:13 -0700
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
	Rob Herring <robh@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH V4 08/16] perf/arm: Remove driver-specific throttle support
Date: Tue, 20 May 2025 11:16:36 -0700
Message-Id: <20250520181644.2673067-9-kan.liang@linux.intel.com>
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

Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring (Arm) <robh@kernel.org>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Leo Yan <leo.yan@arm.com>
---
 drivers/perf/arm_pmuv3.c      | 3 +--
 drivers/perf/arm_v6_pmu.c     | 3 +--
 drivers/perf/arm_v7_pmu.c     | 3 +--
 drivers/perf/arm_xscale_pmu.c | 6 ++----
 4 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index e506d59654e7..3db9f4ed17e8 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -887,8 +887,7 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		 * an irq_work which will be taken care of in the handling of
 		 * IPI_IRQ_WORK.
 		 */
-		if (perf_event_overflow(event, &data, regs))
-			cpu_pmu->disable(event);
+		perf_event_overflow(event, &data, regs);
 	}
 	armv8pmu_start(cpu_pmu);
 
diff --git a/drivers/perf/arm_v6_pmu.c b/drivers/perf/arm_v6_pmu.c
index b09615bb2bb2..7cb12c8e06c7 100644
--- a/drivers/perf/arm_v6_pmu.c
+++ b/drivers/perf/arm_v6_pmu.c
@@ -276,8 +276,7 @@ armv6pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		if (!armpmu_event_set_period(event))
 			continue;
 
-		if (perf_event_overflow(event, &data, regs))
-			cpu_pmu->disable(event);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	/*
diff --git a/drivers/perf/arm_v7_pmu.c b/drivers/perf/arm_v7_pmu.c
index 17831e1920bd..a1e438101114 100644
--- a/drivers/perf/arm_v7_pmu.c
+++ b/drivers/perf/arm_v7_pmu.c
@@ -930,8 +930,7 @@ static irqreturn_t armv7pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		if (!armpmu_event_set_period(event))
 			continue;
 
-		if (perf_event_overflow(event, &data, regs))
-			cpu_pmu->disable(event);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	/*
diff --git a/drivers/perf/arm_xscale_pmu.c b/drivers/perf/arm_xscale_pmu.c
index 638fea9b1263..c2ac41dd9e19 100644
--- a/drivers/perf/arm_xscale_pmu.c
+++ b/drivers/perf/arm_xscale_pmu.c
@@ -186,8 +186,7 @@ xscale1pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		if (!armpmu_event_set_period(event))
 			continue;
 
-		if (perf_event_overflow(event, &data, regs))
-			cpu_pmu->disable(event);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	irq_work_run();
@@ -519,8 +518,7 @@ xscale2pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		if (!armpmu_event_set_period(event))
 			continue;
 
-		if (perf_event_overflow(event, &data, regs))
-			cpu_pmu->disable(event);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	irq_work_run();
-- 
2.38.1

