Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A5B33A033;
	Tue, 24 Mar 2026 00:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313157; cv=none; b=Jsu0BmMZm+Ni2mGvwe4+QANTt4E0rl0K6OeogTl4uElxnCKGb9fsIw0r7u430JgmWehdESKXZmD+N4DgRWj5qD6rsKgiq5plsWgkxrkgDNtFICJ0RILe7c1eMy5MDmFQ6g6RWz8s8VcGwYYEF20h20ywi+afygJlqE1vXcYkq8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313157; c=relaxed/simple;
	bh=ucyDrz+YIvqZS8qQMRZNMN6O3iLyvvXdEPYmMh/DcuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F1RYrPTWdgEs01EjdtdGTwBsr8fqjdmdAajwwQD2reKsZqUB4BkXi+mMddISCo8OSzVwydRj0xLrCHeR2p0ZbjeEhWAu6RBHdbmk+9vjf9aT54T4Wbi7BxbUaY9yD0d9Osu/mwFYg8ddOcC9+ErmmRk5O0/Wh1gHqMjsWoWv7TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CsNnSPfX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CsNnSPfX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774313156; x=1805849156;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ucyDrz+YIvqZS8qQMRZNMN6O3iLyvvXdEPYmMh/DcuE=;
  b=CsNnSPfXCSUItxho7MXjdp9jBniyS84Ch1S9o3NkYvA833QkOxEzSKB4
   xao7DsUyVduv3uk8iAR/8hRQeLsNq0Xc/1JOq8V8olA7PYyPMEwMbxw6q
   PWt6TpwoiAb6hz1Gf/QgJcCa5J8Ynn2onsiCA74lmG/2ajP9tmYOAq00t
   0EF/1XCZ4ro6q1ZhM+MhGmbQi5ys0XMd3nn49lYfX3yRe8usQDHLCrtX7
   VwnckFg+Jv1ipGYY1fvEbAB+/vCgDoY4NwH21y/M+FDicTOs+ZGFpY87R
   5NfOnAi1ZT+uMx+TOyppRCSFK3J36eiJaoQTcCYbD/XQvdZUE14LmmS3j
   A==;
X-CSE-ConnectionGUID: 8P8lAEMgQJ6+NQ/GHCIlbg==
X-CSE-MsgGUID: h1FsJzo6Q+GEomTTsGcFDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86396932"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86396932"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 17:45:56 -0700
X-CSE-ConnectionGUID: NU8Cgf+dSLGYuYeb1NXdHQ==
X-CSE-MsgGUID: dFxChUNjRWuqC8LEfI37sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="221322564"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 23 Mar 2026 17:45:51 -0700
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
Subject: [Patch v7 01/24] perf/x86: Move hybrid PMU initialization before x86_pmu_starting_cpu()
Date: Tue, 24 Mar 2026 08:40:55 +0800
Message-Id: <20260324004118.3772171-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324004118.3772171-1-dapeng1.mi@linux.intel.com>
References: <20260324004118.3772171-1-dapeng1.mi@linux.intel.com>
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

V7: new patch.

 arch/x86/events/core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 03ce1bc7ef2e..67883cf1d675 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2189,8 +2189,20 @@ static int __init init_hw_perf_events(void)
 
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
@@ -2237,7 +2249,6 @@ static int __init init_hw_perf_events(void)
 		for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
 			hybrid_pmu = &x86_pmu.hybrid_pmu[i];
 
-			hybrid_pmu->pmu = pmu;
 			hybrid_pmu->pmu.type = -1;
 			hybrid_pmu->pmu.attr_update = x86_pmu.attr_update;
 			hybrid_pmu->pmu.capabilities |= PERF_PMU_CAP_EXTENDED_HW_TYPE;
-- 
2.34.1

