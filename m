Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6953C3B2FCC;
	Fri, 29 May 2026 08:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041766; cv=none; b=o2RAdDJo3Z78beoFNYRsqmgQMqnbtEa6tSCqM1FFNjjpaN0ukK221I3fy0ADdh25noqNBmAeGyZuZxVItN7Sgn1AXplLxVldA+K0kIu5wapgaaB17EPHIyUK9mL61xdACHywQd2Klk47ch4zho0WMMayqcB9VxjxRhB1lEaws2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041766; c=relaxed/simple;
	bh=TIF/tDrphO4XesqSFb2wFeEBW6WzJ61eKEnZ1mB2XCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ie2faJ99TFQY0KMU4R5MeeVCxpzYENoYFfNF5GN7f5GdUTlUyv4AnuYzInWINt/z27gExITmkBOVXT3Ys/IFGOxkVDSHuHz8Fjx1zHHrSKD3m5XRzo4J3134lPoSvxCtnnPDkrvanhKz8etm1rGqgP2Xk831xFc12QBEhAzMd34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EeVeRgoT; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EeVeRgoT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780041765; x=1811577765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TIF/tDrphO4XesqSFb2wFeEBW6WzJ61eKEnZ1mB2XCM=;
  b=EeVeRgoTyM1CZuhU+ZnTSPvExExAuQSoGQ3+DjvH4sw4HqAkO01iblEn
   cwRSpLyQFkzOO4AcW7PKeLW585rovwHODGiHJik9lkbop52eGeddIa8Ed
   A/0W6LPYyfJFtvYEw31QCnBXEl0nwQ+SLMZsK7eipXZdesTnJodxSwgax
   CSiZlB94n7sJYssslBu2Gukvl99mgYJYGHepL63Z0bSGAdNv4BLPqvaFu
   NOtqXcqBLzherW+YWcy+j1ie/85bM3vvQQdk+cUuEigpVAShals+6P24O
   RgAj09W1k7S5C2/YKWZ6DAVhdyJgGgWc2rfI7vAfQwg8kzvYgS4BFvM1P
   w==;
X-CSE-ConnectionGUID: 74wx8onWRVGWiQL2sc13NA==
X-CSE-MsgGUID: ZdIJXXmtTrmvMgaCgYxpkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="106341854"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="106341854"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:02:45 -0700
X-CSE-ConnectionGUID: XfJvjuLnT4ubnud0IOl41g==
X-CSE-MsgGUID: jazoUWIfSsmTBtYY9DBteg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="246801953"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa003.jf.intel.com with ESMTP; 29 May 2026 01:02:40 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v8 02/23] perf/x86: Move hybrid PMU initialization before x86_pmu_starting_cpu()
Date: Fri, 29 May 2026 15:56:24 +0800
Message-Id: <20260529075645.580362-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
References: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current approach initializes hybrid PMU structures immediately before
registering them. This is risky as it can lead to key fields, such as
'capabilities', being inadvertently overwritten.

Although no issues have arisen so far, this method is not ideal. It makes
the PMU structure fields susceptible to being overwritten, especially with
future changes that might initialize fields like 'capabilities' within
init_hybrid_pmu() called by x86_pmu_starting_cpu().

To mitigate this potential problem, move the default hybrid structure
initialization before calling x86_pmu_starting_cpu().

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 4b9e105309c6..17e122e27e0b 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2195,8 +2195,20 @@ static int __init init_hw_perf_events(void)
 
 	pmu.attr_update = x86_pmu.attr_update;
 
-	if (!is_hybrid())
+	if (!is_hybrid()) {
 		x86_pmu_show_pmu_cap(NULL);
+	} else {
+		int i;
+
+		/*
+		 * Init default ops.
+		 * Must be called before registering x86_pmu_starting_cpu(),
+		 * otherwise some key PMU fields, e.g., capabilities
+		 * initialized in x86_pmu_starting_cpu(), would be overwritten.
+		 */
+		for (i = 0; i < x86_pmu.num_hybrid_pmus; i++)
+			x86_pmu.hybrid_pmu[i].pmu = pmu;
+	}
 
 	if (!x86_pmu.read)
 		x86_pmu.read = _x86_pmu_read;
@@ -2243,7 +2255,6 @@ static int __init init_hw_perf_events(void)
 		for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
 			hybrid_pmu = &x86_pmu.hybrid_pmu[i];
 
-			hybrid_pmu->pmu = pmu;
 			hybrid_pmu->pmu.type = -1;
 			hybrid_pmu->pmu.attr_update = x86_pmu.attr_update;
 			hybrid_pmu->pmu.capabilities |= PERF_PMU_CAP_EXTENDED_HW_TYPE;
-- 
2.34.1

