Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD2628688F;
	Wed, 14 May 2025 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235691; cv=none; b=R5LE5q+kPRHU2mchYM2sBZSdf5oDZMopmznMPAi7zIO7Ckdkz+fUDEZdfVPoz1I4hfONu7D9UcnbRltunKnBkEEZ2xMPpF/u1LH73hbBYDjDuA4fER3dbxi9ahplInAwKetwCPnSGHU603XYuhWoQIGO9mcZ3QXBZGeI5v8RZRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235691; c=relaxed/simple;
	bh=niFjfiqBff3Sw+QM/hZYvrfOZbyI/nWGDj/epacEVR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DXbwFP6PuNFEbiJzts+wnj8QFeiLUdLkde8/mN2B7PijqL1pXY49BoAndVFtbBmN/Q4/uTR/HFP/IXHpY/lwLVVmCIW5ojPQrFj5aHa9OZWeLdImyKg9lE50dFWJm2SyZWUEmYO/aoNGPQcIT1rB8Lp82ccVZ/jNK769Bjobl+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BVrkGIdp; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BVrkGIdp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747235689; x=1778771689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=niFjfiqBff3Sw+QM/hZYvrfOZbyI/nWGDj/epacEVR0=;
  b=BVrkGIdp2kf7ftXj4bXVEwphKYPKSc/FWzJdKGAJPa8uj3hdVi+M+F0u
   AvnBFyB/TU8lXsR0VwtjvyTWs42jUc4yH5sIXGWFg6EgcA4YSAvROUndd
   DZfpRUfEpmChCPtbUXHLfkmJkJDdrRbySNKQ7Isz2tum3UkuTtgzjl+51
   0kVWPilOlD7cx1C285PyBjLDkp9Bwe0Y6wYyqO3sPuLL/T9tGPnwCdOBl
   yUzjsPwWFhOuYTiuZpCFox3pLGf+W6filbX/PYfcIRfLZHy/SsIPXeXAp
   fOj+EdRB9VxjbL5vPeBTaOrILAoc89d5yyOTCApvvsr8BerMLYgcoDfwp
   w==;
X-CSE-ConnectionGUID: D7Sk/VggRpGR0k5aULcvUg==
X-CSE-MsgGUID: Exf7cxoDR8WuaL5CIGgdzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49072751"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="49072751"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 08:14:45 -0700
X-CSE-ConnectionGUID: CCeHvT/ISKOJzJVwLYE/VA==
X-CSE-MsgGUID: 1mvC+ajESP6F4gL4x1sOLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="142939170"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa005.fm.intel.com with ESMTP; 14 May 2025 08:14:45 -0700
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
Subject: [PATCH V2 07/15] perf/arm: Remove driver-specific throttle support
Date: Wed, 14 May 2025 08:13:53 -0700
Message-Id: <20250514151401.2547932-8-kan.liang@linux.intel.com>
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

