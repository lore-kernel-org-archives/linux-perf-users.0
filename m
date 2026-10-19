Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7234844725D;
	Mon, 19 Oct 2026 07:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792394203; cv=none; b=r1S9C+bkAUuW9r3fDRxwo5AHIYDWuZrQivN84qSw/XK3s6q6v0Uwffo41ItXVQlRQDBnRob+Lx+AyCDBbsFam8g6+IriFV3vraokU1iubHDpnWowDaSZGO0yvFNiqWaXg9T5IzFXwAyi+hAHRT1UM0eIhojyVHCR5197IGYd59U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792394203; c=relaxed/simple;
	bh=GjL0iO8AX8BpJxKRoFAVkDuzbdSOrmGP2Ya51fOw2Y4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ImpUB21Pe7UCskmJxQ46FBgn6NdksUSXsEBZpD3EvjhMBCu6CEH7K90P8+hNH02FEQIWSOMNtEDHl6wY48OnG5lkSgTvJGmvHTSwDvne/xowi0LgRqJ7w+8QORD2AyjrQ8AApXtUyfT3wd6skcSSncu5/CFnHQj0+uO/O0lqKEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LfhbjHfP; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LfhbjHfP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792394201; x=1823930201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GjL0iO8AX8BpJxKRoFAVkDuzbdSOrmGP2Ya51fOw2Y4=;
  b=LfhbjHfPJF+nGJewbbnjdAMYs7Mb+oofP1eHYfXRKKOKSnNMOPmqyGAr
   cn7+A7bdq/sHiPuKdQ0VZ9ToTpxiGigHGCoAJdrJmRh2bsYKjhFxx5smI
   xsbTGtiXoDjUK9sVWsljBCrxWzzhQ6WrD1v+xNGW5LjFkoP5DYCBF0+9+
   S2/kf9pW5rzOHF5EzppX4RLoxDltCfrwU1S5eWvR0qkxIcrTxq2Y3eEgA
   yWszJNKJi3fEbcT28ndDcHvugj233zbsQwc29KLQAQs/oZi5LA2ymg0/H
   He5+iZU4jDWmUQaywzDNkA26YxM4V05rYmBBCogj2/K2/q4MTKsmz1FPB
   A==;
X-CSE-ConnectionGUID: tz/cELbKTQavE+SP0i79dQ==
X-CSE-MsgGUID: aNE7+xadSS27nFjWD1Ogig==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1085697"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1085697"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 00:16:40 -0700
X-CSE-ConnectionGUID: jqWK7fxTRB+VIa0rgtOZNg==
X-CSE-MsgGUID: i+PSbc07TWimza0yFRRX5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2807233"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 19 Oct 2026 00:16:36 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v3 1/4] perf/x86: Clamp x86_pmu.lbr_nr to MAX_LBR_ENTRIES
Date: Mon, 19 Oct 2026 15:08:33 +0800
Message-Id: <20261019070836.2972403-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019070836.2972403-1-dapeng1.mi@linux.intel.com>
References: <20261019070836.2972403-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure x86_pmu.lbr_nr never exceeds MAX_LBR_ENTRIES to avoid
out-of-bounds access when handling the cached LBR stack.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 4df792b139e0..82f6b66db7e2 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2645,6 +2645,8 @@ static int __init init_hw_perf_events(void)
 	if (!x86_pmu.config_mask)
 		x86_pmu.config_mask = X86_RAW_EVENT_MASK;
 
+	x86_pmu.lbr_nr = min(x86_pmu.lbr_nr, MAX_LBR_ENTRIES);
+
 	perf_events_lapic_init();
 	register_nmi_handler(NMI_LOCAL, perf_event_nmi_handler, 0, "PMI");
 
-- 
2.34.1

