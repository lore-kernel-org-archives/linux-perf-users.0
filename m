Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4BA27F18F;
	Fri, 16 May 2025 18:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420166; cv=none; b=m1ymSxSKWBqafen9XEhzICARLEUVxMGe1gXfA2BNeyuVREUZ9ZFyLzi85hripIwwWd7vYQA9TGv2rigxv3ms+cBg6tIaLUgA7LLz0egbiewcrrnew0Lxj5m4orFaMHG4+xTuH0RafcqcaOw81PEySP/i1Au6/SD4G3xfAOyC1+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420166; c=relaxed/simple;
	bh=eftPXZUtS7TWj+fyRnjgJB01av2QQsqnM0j4qbjXMQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ICFMLOmkkceNw4frSRHpRpScR2fugnXet/uoB+gKbvQgxEvXpmZtYdFNZDGyMBnAC7RbLg4Wyasu1y4fv2Cni9soNBVQ0sUrvfVD/i/eeanh+foSeaSZ/kyj6fTRvl3Dh9p7XH2p6PrBAMhOj5nvBtFSkIgptIODSIgUefeO5k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sahfkd0H; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sahfkd0H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747420164; x=1778956164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eftPXZUtS7TWj+fyRnjgJB01av2QQsqnM0j4qbjXMQk=;
  b=Sahfkd0HHiA2sFks7AOwLsyEfeLJp9heVmc27soUhp6xFds7rsDLLybH
   SA7u2o3SsGnFzOhJgnM2ShASXjEquThRoECOfaQUiVh6v1WkenpxswuVZ
   wwVWmuSTBsIov6zISr1DkUlGcw934zVWi2Z+bnEcQEY8yIxEtJicpSjV1
   Ef2sPW5Nw9nPmN3+1FK16WGIjHLFXvYsosS7OrGstqVHRe2I8faqIYzal
   Tdj5EcYjlC1uGLq+RhlXiT8MYDlEpzkhI0237MVwP/HMO6bumqO0+aU6M
   tq8IOSPdz8YJTaKDpn09ZCG/TcMa8P3yMmVJis+8IULN3R/ZRlpoSxkA4
   g==;
X-CSE-ConnectionGUID: Qz4eYZWuQFSBZVd2piz2kA==
X-CSE-MsgGUID: aRZvGTAuSYiMyuvYppffAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49328825"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="49328825"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 11:29:21 -0700
X-CSE-ConnectionGUID: pssoVBvOROmS2NGrVCVxXA==
X-CSE-MsgGUID: aYFUfRG1S4+jxhI3msdw0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="169802607"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa001.fm.intel.com with ESMTP; 16 May 2025 11:29:21 -0700
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
	silviazhao <silviazhao-oc@zhaoxin.com>,
	CodyYao-oc <CodyYao-oc@zhaoxin.com>
Subject: [PATCH V3 05/16] perf/x86/zhaoxin: Remove driver-specific throttle support
Date: Fri, 16 May 2025 11:28:42 -0700
Message-Id: <20250516182853.2610284-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250516182853.2610284-1-kan.liang@linux.intel.com>
References: <20250516182853.2610284-1-kan.liang@linux.intel.com>
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
Cc: silviazhao <silviazhao-oc@zhaoxin.com>
Cc: CodyYao-oc <CodyYao-oc@zhaoxin.com>
---
 arch/x86/events/zhaoxin/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
index 2fd9b0cf9a5e..49a5944fac63 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -397,8 +397,7 @@ static int zhaoxin_pmu_handle_irq(struct pt_regs *regs)
 		if (!x86_perf_event_set_period(event))
 			continue;
 
-		if (perf_event_overflow(event, &data, regs))
-			x86_pmu_stop(event, 0);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	/*
-- 
2.38.1

