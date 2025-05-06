Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009122857C6;
	Tue,  6 May 2025 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550097; cv=none; b=gMgDl3V+Vye0UU6CnTr+t5NNBk6uCuRFfjFRtiuUqcxs/sVvl1vFTFB8d6eeEAcLfxZ/N0XG3RbzxUg+b5RbRl/3f+MsBzvp4NVfsSm/YvoAE4vW65crS5y59DBZfksqMEdQJxwT7GYOCThfW2ylHmW4/MtNo5/kGrOoIGqmEgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550097; c=relaxed/simple;
	bh=VV8txqq1/dac9dNKChyvYqISNo6GE9wkTCjkP9SqIFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tvAU83cjl1vI9b8jJi4IL4eDt17gc/RUMVUGb/JnxcSRuwUrE+9uLusSMdbiqNIIuvIIGrOdD7SpUzMTczuRQKAY5ePott7GJbQgBo0WNqhGL1sJJ3L+IacVXf/c0LUi2+Hi5UjWCtiR1kYu9ji/C1+9vh6al3JFvdq4ViNkM5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D+HUk/X9; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D+HUk/X9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746550096; x=1778086096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VV8txqq1/dac9dNKChyvYqISNo6GE9wkTCjkP9SqIFc=;
  b=D+HUk/X9Lx+PmXbObv7MLTix2AB10K9nvekV6pXG3lYfTDOlIiM6FcCb
   Hp47ZPu8C8GO73Du3Ij3oB5c++OsT0/Bb8VxPfCNGFQYLgK+XunpRCkon
   KfSaOO5v/cAaL3QAPyo97uMbZ8E8k8A5yWTrHRzHckrll7nvTGJbaL8mE
   EV+FgFIjhgeQYHsF0dlPiluQ17YyCUr5kG2Ap/SyLyA9sgRHE4MqHvcRx
   PD5pr4s1se9oOpzPlZ8QZH9k4z5icpX2KQrytqo+8gutOPU4+CoeqpUWS
   AjZXt2+YIJyClBoTa6DqcQvXl3+C5EjbruTus44gLn3oXb2eA8PurrVns
   A==;
X-CSE-ConnectionGUID: eA0iz0mzRFyrv05iSu2I2g==
X-CSE-MsgGUID: 4pdA+pByTnqscNDxcxzCNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="59595262"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="59595262"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 09:48:15 -0700
X-CSE-ConnectionGUID: 9atE7ECQSVeYRU1cJ5Vacg==
X-CSE-MsgGUID: JD9/R/cATQO8HgvGmKztKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="135674862"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa007.fm.intel.com with ESMTP; 06 May 2025 09:48:15 -0700
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
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [RFC PATCH 05/15] powerpc/perf: Remove driver-specific throttle support
Date: Tue,  6 May 2025 09:47:30 -0700
Message-Id: <20250506164740.1317237-6-kan.liang@linux.intel.com>
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
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
---
 arch/powerpc/perf/core-book3s.c  | 6 ++----
 arch/powerpc/perf/core-fsl-emb.c | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 42ff4d167acc..8b0081441f85 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2344,12 +2344,10 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 			ppmu->get_mem_weight(&data.weight.full, event->attr.sample_type);
 			data.sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
 		}
-		if (perf_event_overflow(event, &data, regs))
-			power_pmu_stop(event, 0);
+		perf_event_overflow(event, &data, regs);
 	} else if (period) {
 		/* Account for interrupt in case of invalid SIAR */
-		if (perf_event_account_interrupt(event))
-			power_pmu_stop(event, 0);
+		perf_event_account_interrupt(event);
 	}
 }
 
diff --git a/arch/powerpc/perf/core-fsl-emb.c b/arch/powerpc/perf/core-fsl-emb.c
index d2ffcc7021c5..7120ab20cbfe 100644
--- a/arch/powerpc/perf/core-fsl-emb.c
+++ b/arch/powerpc/perf/core-fsl-emb.c
@@ -635,8 +635,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 
 		perf_sample_data_init(&data, 0, last_period);
 
-		if (perf_event_overflow(event, &data, regs))
-			fsl_emb_pmu_stop(event, 0);
+		perf_event_overflow(event, &data, regs);
 	}
 }
 
-- 
2.38.1

