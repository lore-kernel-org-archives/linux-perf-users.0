Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA79A28640E;
	Tue,  6 May 2025 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550099; cv=none; b=MAfNqVjYjfal37yZXbesbhYJtCdNAsZMztw5bLXazpPOx49z4DhFpE7GJT2GfM7KOW7/uQoUEhlu4bESbrzDvHr0us8xIMsQsAjSbCqq8U8Bel4rM/TDD0C99bXqcbKs4Hyd+27N21cZhN59Bpkl8naC6+t7ocQ9xBNXHG1iJyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550099; c=relaxed/simple;
	bh=niFjfiqBff3Sw+QM/hZYvrfOZbyI/nWGDj/epacEVR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t9T0rAjSK+GFtbFlN+AsskTjWH4Yo6dgdUa2CjUW7GWQRH9ZeTM+kb9TFkA5fIlc1tE2XQTMkzYLJuLvZu84ZXOhkcW9mvDjuInyWDU2JPtSbmseHbAPcHaBEg1PGMxvwO7WC1NO90VjRbbf1oD/U9vCKL0RvJzyfT8Xm4riXEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MBh/46W4; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MBh/46W4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746550098; x=1778086098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=niFjfiqBff3Sw+QM/hZYvrfOZbyI/nWGDj/epacEVR0=;
  b=MBh/46W40ufo7Ahxis0ISlbg5ytV0DdCmyXm8uJTJhEAImetJ1OPdXJ3
   aN8i0uvi+/TqHbGa0W5Dp7WCCwfqSmxJ4Ofo0P9dp8NneIEHdGm2a2+Ly
   57uPlhFQ0yUAtddtFZnm2b1ELaIn0yBZ1JDghu58eZO97p/tdjAX7B8zg
   bTVtT/azTdQaaA5rAbIARdzhoiDgGn4LfogIL2TEwdxgGwarAFmpl9KUx
   Z+q6eDdDAnxaZzRLD2NjbQ0Z8NDoCXSdTfyb5VB5znBMcYn+Toy7c8D/f
   6Swx5EM1mVkybqLkexsRFTJine0JBX4kb/cNlnmdyRwI9AR2F2OtHtUbX
   Q==;
X-CSE-ConnectionGUID: Nt55YKsuSnCcPT8/p2yA2Q==
X-CSE-MsgGUID: fOBcvfSoQyOqcp3wJQJWtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="59595282"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="59595282"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 09:48:17 -0700
X-CSE-ConnectionGUID: py3ST6METdqMUXLjGrdM7A==
X-CSE-MsgGUID: qXGlWkaVTKOJ+TzHrw9P6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="135674871"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa007.fm.intel.com with ESMTP; 06 May 2025 09:48:16 -0700
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
	Rob Herring <robh@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [RFC PATCH 07/15] perf/arm: Remove driver-specific throttle support
Date: Tue,  6 May 2025 09:47:32 -0700
Message-Id: <20250506164740.1317237-8-kan.liang@linux.intel.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring (Arm) <robh@kernel.org>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Will Deacon <will@kernel.org>
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

