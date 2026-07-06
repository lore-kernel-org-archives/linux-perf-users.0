Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEE318C2C;
	Mon,  6 Jul 2026 02:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303279; cv=none; b=k6EvtABANHZNypShpQLHNKpjznmJ5+LOHMSVDePXXZnTi3KQpOSNZeTNJXMzLSul+bcX7iT6BA4rhVEpKQN425U0RiD1VwVy/7ybbZfLYsgGBaSGQRDQS0NaSVZLitS4ec1tkmoeh/RrIk0VJYfyn3YXWfUY5H9YB0h3ArbOqA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303279; c=relaxed/simple;
	bh=PouriDd2R+9GHVRAXolu480b+hK8mb60frw2bjK3EXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mnkccFe7UYADRlCU5wpcWf7KUDZOlvEU6wcg6HnN87DPoUt7kXORyCEItjgebl16qZXyjMv+KWS2Lg2M9B+WAjKSM33IqBE4EEPPbfSVe8lsUsBD8TJQ20GdRaaw+bvQ2Zl0nVj6UGets5fvU0WORwkordIOyH7x0lvDzeoiNGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lax2AWZT; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lax2AWZT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783303279; x=1814839279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PouriDd2R+9GHVRAXolu480b+hK8mb60frw2bjK3EXE=;
  b=lax2AWZTJKyNoZWo47p0u9xMDoIoDsEj0bffgqiZCcLHc9WXKVAwNjAx
   qT3Ht2RGazsCQnwE0VI4trftNQXDULIJ+OJExboprd8mtg33onqDU/eEL
   qXcT1uWVH/8UDiAwAXEuGk/XKleQ+gf+8gSmCVx5Sq2ZwMLM73wvcu0wI
   wijqYEtipcgNA1PezH5PmRiSl5KRsTcA7l4Af31u6+0hq94li3Ivnixbd
   BZqGskPf2UgmNgd7z7g8fj3TGyLPOJmPWrIezha9uj0Kiklnps+LI7rx8
   PZ01EBAbwzu/C7vU7Cvitlg/f3dixwRBfwSabDGIAiIdJQQ4JYKpJf5bc
   A==;
X-CSE-ConnectionGUID: tGcogGL2TZaptFh43A9dbQ==
X-CSE-MsgGUID: 2UMv7dYTTB6UaeJcu23DAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83911553"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="83911553"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 19:01:19 -0700
X-CSE-ConnectionGUID: Gf0B8cJQQs24a8t/02qOCA==
X-CSE-MsgGUID: tKc6/uH6SK22lLk4AG5IBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="247191260"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 05 Jul 2026 19:01:13 -0700
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
Subject: [Patch v9 02/24] perf/x86: Move hybrid PMU initialization before x86_pmu_starting_cpu()
Date: Mon,  6 Jul 2026 09:54:17 +0800
Message-Id: <20260706015439.3040804-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
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
index 872d07a5fa80..0888d3b0923e 100644
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

