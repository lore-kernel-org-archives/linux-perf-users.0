Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474FD3CF58;
	Tue,  6 Aug 2024 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959828; cv=none; b=F8nJlU/Rqd9q4oFdxL8hlgrZ2hxZ5xL8SAgwfW0QXaxopMr2b+7yOlKLaI+bNO+5wPtdo3ICTbNtwA1iUEVwPTfWxeH4GjLjy6YVxcvnjL7pOMKR+AFZrRnbxR3W3pezIq9J4pdcvdqe+ZdjtsJQwUXFM9vHrwGeHvKoJhnD0wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959828; c=relaxed/simple;
	bh=XV9oO1VsQp+MSv2Py01Sm9xIIkQ3cEXow5zO+iPUsrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L/CfOcnuQQDrqBDdhpoGCNKak+x8OwRWAGlGwxyukZoGjg2a7tcAu2P54Ue7b76IhFXK9eE/ldgCSUU8ljb9CqqKGx/gHQPP2xjM3li/FWRzWqqHZVTFRk62aKLELTmtnosZaruF+u5/nMZH29cVCpGHOTlKcvxjw4TERIdWRHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Evf75KLr; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Evf75KLr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722959827; x=1754495827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XV9oO1VsQp+MSv2Py01Sm9xIIkQ3cEXow5zO+iPUsrs=;
  b=Evf75KLr4fqtKGESsycyI+qSsM5h36xhiJHu87ksV07ZBu1qIZ8LjUor
   1+vS8Lesd5EtjSyiX4cDjuyAGVUaVDIT4MuY128NR3oP5vs4HI6zlU0Ez
   hb3mv4gyC9XAHHf1EgUoRLGuXQrwdjMuzz4Hwo74x+YlXBjkOh/q+li9p
   q5yUmPMR6olQzGhXEbZZyebsXzSnm1q+rUC9/iPAo6TKcpMTIlOX1DYH8
   E8VBTeldIT0c22HZvBXIcbsMF8BxaB98BFstvATSEbYX9YBrNlf66zUzH
   /pbsozCt9HH7b606FXhFlOAE7nVo1WIX7+I5kABFK08v/cxUJxb2gSllx
   w==;
X-CSE-ConnectionGUID: re2StaCcR4ypvYyHrhslxg==
X-CSE-MsgGUID: z0ob98ciQmm9x2ho0xY8tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="43514098"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="43514098"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 08:55:51 -0700
X-CSE-ConnectionGUID: WQtCCycpS62r1T2KSkjJ+g==
X-CSE-MsgGUID: YaiFC+W+SlGKDaqa3HleVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="56631163"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.94.248.17])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 08:55:46 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V11 03/10] perf/x86/intel: Do not enable large PEBS for events with aux actions or aux sampling
Date: Tue,  6 Aug 2024 18:55:07 +0300
Message-Id: <20240806155514.17900-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806155514.17900-1-adrian.hunter@intel.com>
References: <20240806155514.17900-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Events with aux actions or aux sampling expect the PMI to coincide with the
event, which does not happen for large PEBS, so do not enable large PEBS in
that case.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---

Changes in V11:
	Remove definition of has_aux_action() because it has
	already been added as an inline function.


 arch/x86/events/intel/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0c9c2706d4ec..3d3b841112b3 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3962,8 +3962,8 @@ static int intel_pmu_hw_config(struct perf_event *event)
 
 		if (!(event->attr.freq || (event->attr.wakeup_events && !event->attr.watermark))) {
 			event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
-			if (!(event->attr.sample_type &
-			      ~intel_pmu_large_pebs_flags(event))) {
+			if (!(event->attr.sample_type & ~intel_pmu_large_pebs_flags(event)) &&
+			    !has_aux_action(event)) {
 				event->hw.flags |= PERF_X86_EVENT_LARGE_PEBS;
 				event->attach_state |= PERF_ATTACH_SCHED_CB;
 			}
-- 
2.34.1

