Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139FD3B2FF6;
	Mon, 13 Jul 2026 08:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931616; cv=none; b=PJ8BMjEt+0yJaQW6tKvheX3tF0Qw4DjBtyqoV74S+1cC/nbXXeyJtHrbu1Fk6MCpxM3kz9tXDEp5Sciy1kh2zEVgsyRNbkSFiq9kf1lWJo7gXHLtpmlHrS+x2PqnvFgRtBhiutCWxDXD19SDG6dMe56JEtcbukoaMRkTZOG0N7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931616; c=relaxed/simple;
	bh=bEpghCxtBfzbP9JP5pjN4vrrZvyfhYirS4rUH3OCbns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SpI8DHtVUu/xM2FgvCfh9c9ehx3yVonUVzyyaYQc+WFuvilIAPJXF79QgO4JrOUEm+nHWX4oPLelXjMeXa0TSzBBy/68kZbiYMOwpc6uS/Gxg9iZCdx5hf2YV74B00otd1vIafJ3MEfO9Kx07H0Rb+aky4OMk4GbkCOzjtRjIG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ntm+Yoff; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ntm+Yoff"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783931613; x=1815467613;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bEpghCxtBfzbP9JP5pjN4vrrZvyfhYirS4rUH3OCbns=;
  b=ntm+YoffUSykuBcGRzmRTWepMyEV2ktdeThQ3tlK3mexdAdOVsTsrijG
   XwP6nlIXph92lkgzpALaoO/zhAiXBOubaNnS8uriP20fdCrREft+s3Nkl
   bQexm6FjXZI41MRahMFFNSOQr8fg2tr3nU4i6EBGTARkK9Ey+zXtZaEQD
   b1Z81Lj9RB5xjzHbpGexQuKZ5/LaRe/cktw1eaQ1eE/OwRwlIYWtq29hQ
   60dmjQT6oDy5KNmC3AY3Rh9Slj0uYb4M6jijjW+FF2eKW+m3yx0Z1QMnp
   o/DubgSUSA7t1QMdz4o8pi/jD7hiWQOY7xM6ZkTRPRfYUacWqcE/4DZU1
   Q==;
X-CSE-ConnectionGUID: 2WZDuXpxRUG2SQ6mCSzOLQ==
X-CSE-MsgGUID: wiuzzuIyT8K2htFLScLWiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84390080"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84390080"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 01:33:30 -0700
X-CSE-ConnectionGUID: sNJxQKD+RzGiSstIbMqFCQ==
X-CSE-MsgGUID: JjI9YlrFQ2yIewQULhVSig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255560752"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa007.jf.intel.com with ESMTP; 13 Jul 2026 01:33:26 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v2 2/7] perf/x86: Free hybrid state on PMU init failure
Date: Mon, 13 Jul 2026 16:27:29 +0800
Message-Id: <20260713082734.3162099-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713082734.3162099-1-dapeng1.mi@linux.intel.com>
References: <20260713082734.3162099-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If PMU initialization fails, for example in check_hw_exists(), hybrid
state can be left partially initialized: x86_pmu.hybrid_pmu is not freed
and perf_is_hybrid remains set. This can leak memory and leave stale
hybrid state reachable after a failed init path.

Add x86_pmu_free_hybrid() and use it on PMU init failure paths so all
hybrid-related state is consistently reset.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 872d07a5fa80..6c63b27e11e6 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2130,6 +2130,17 @@ void x86_pmu_show_pmu_cap(struct pmu *pmu)
 	pr_info("... global_ctrl mask:          %016llx\n", hybrid(pmu, intel_ctrl));
 }
 
+static void x86_pmu_free_hybrid(void)
+{
+	if (!x86_pmu.hybrid_pmu)
+		return;
+
+	static_branch_disable(&perf_is_hybrid);
+	kfree(x86_pmu.hybrid_pmu);
+	x86_pmu.hybrid_pmu = NULL;
+	x86_pmu.num_hybrid_pmus = 0;
+}
+
 static int __init init_hw_perf_events(void)
 {
 	struct x86_pmu_quirk *quirk;
@@ -2258,9 +2269,6 @@ static int __init init_hw_perf_events(void)
 			for (j = 0; j < i; j++)
 				perf_pmu_unregister(&x86_pmu.hybrid_pmu[j].pmu);
 			pr_warn("Failed to register hybrid PMUs\n");
-			kfree(x86_pmu.hybrid_pmu);
-			x86_pmu.hybrid_pmu = NULL;
-			x86_pmu.num_hybrid_pmus = 0;
 			goto out2;
 		}
 	}
@@ -2276,6 +2284,7 @@ static int __init init_hw_perf_events(void)
 pmi_unregister:
 	unregister_nmi_handler(NMI_LOCAL, "PMI");
 out_bad_pmu:
+	x86_pmu_free_hybrid();
 	memset(&x86_pmu, 0, sizeof(x86_pmu));
 	return err;
 }
-- 
2.34.1

