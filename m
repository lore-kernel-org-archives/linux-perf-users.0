Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216E72882C7;
	Tue,  6 May 2025 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550105; cv=none; b=erMQR43RHnEMpodyXOsSmB9vnhn8fXODSZzZxC3bni8S7DinQ/0f5q0Bsz8rY8L50zou02RZZtn/0L3Npe2YBwCQqHxyP/7zTFF60KU+g9NJsK2JiRAXUnX5gDLt16tEHICWB2l7CXFunDpLJzMXVpFeO6U3h9+ej8L9E9/ZZek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550105; c=relaxed/simple;
	bh=JiwvHEAYw1T9QTlO99VilV21kD4dORO/tZIjOkKmDDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J3Ml1kZOX8fbJl7BVktEMaopNf8cBVRDGgyZyVHvyfQknhyyHYGISVFttcgIVJ1HjwF4q49X8e7dI5Dug5UNRRyBLCRNCv2Uf99Iqo/arN8E2W6c1yptfcM9vJm9mbdpWUdV5rrQ/RuSZNeWY1+GWDPbzl5I3WJ1+kO4XbzluU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RS/RhSox; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RS/RhSox"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746550104; x=1778086104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JiwvHEAYw1T9QTlO99VilV21kD4dORO/tZIjOkKmDDQ=;
  b=RS/RhSoxZREfEVH7cUixDkgKqLbEBAgivTDTvSwSQ2ARnHxnD5HBt+Y9
   Tr6p/vVXwD5MaxoMiRfIorWBGCD2LZQtDBG/1GKUDGkfhcojniFd4sRMb
   dcPdMyFg/6S16YLfk/H7gEPyP8d75cM5Ho58mdOsabS0zncYCps2/ulWF
   1UjvMOx4QmWoQBufO+O02TTgFHRgGNcnQOHfp/IiiLhmdq/pclQfjj23Q
   nWlgM+UuESR/oGmn2uYAKLnwS+pLVW3hvbgKfFu0/+bpJ64WlT6HjIdw/
   9KFkCQb6Lxpa+X8Mat/hIRFPFAkiYrEAI+50rh5LMS6ZYWFeneGSYfgZ7
   w==;
X-CSE-ConnectionGUID: SO49iDrxTEyakXWkNbem6A==
X-CSE-MsgGUID: g21pdYN0S9eYc2z5u3+xzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="59595349"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="59595349"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 09:48:23 -0700
X-CSE-ConnectionGUID: PTJ6Lt5rQda926yXGjd9SQ==
X-CSE-MsgGUID: WFzlB+Z+ROWlvkmzdTUuRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="135674908"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa007.fm.intel.com with ESMTP; 06 May 2025 09:48:23 -0700
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
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [RFC PATCH 15/15] mips/perf: Remove driver-specific throttle support
Date: Tue,  6 May 2025 09:47:40 -0700
Message-Id: <20250506164740.1317237-16-kan.liang@linux.intel.com>
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
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/kernel/perf_event_mipsxx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index c4d6b09136b1..196a070349b0 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -791,8 +791,7 @@ static void handle_associated_event(struct cpu_hw_events *cpuc,
 	if (!mipspmu_event_set_period(event, hwc, idx))
 		return;
 
-	if (perf_event_overflow(event, data, regs))
-		mipsxx_pmu_disable_event(idx);
+	perf_event_overflow(event, data, regs);
 }
 
 
-- 
2.38.1

