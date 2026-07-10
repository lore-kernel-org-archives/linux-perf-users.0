Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A713B14BF;
	Fri, 10 Jul 2026 06:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783666660; cv=none; b=WksySRdX02wiVN5MRyUvpl7e6GgpElnmpYex3GN9gTWbjMZQ6rNnEZQdnPNqsnqpXqY84rWirf48AYo69GQTThRuUBYUA+d7DT0V5a8PlYeC22/dyh28szLMPKKjG8GUlC6KhTAPaMn/pG3hXwnFWy+W8QDfcZWeOfUCFu031gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783666660; c=relaxed/simple;
	bh=bEpghCxtBfzbP9JP5pjN4vrrZvyfhYirS4rUH3OCbns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tgIIsVCtUdfEhdB4If/7QgG8EBKBcvVw0cm0OJAJZtmmH3fcrRsOcIaYSSuZId1wUpVHUXZrvWO8YOJqIbesoKHHxA1kCGCkAIKqEyDniCJBuhWxlB6pvvd1GOXXh4JuYzTxiX9qhNZJBbbewJSpiDnI33MprGvW4e0AoSqZ9i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PZ11SFF2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PZ11SFF2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783666660; x=1815202660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bEpghCxtBfzbP9JP5pjN4vrrZvyfhYirS4rUH3OCbns=;
  b=PZ11SFF23PPr6LnsJljwJZqco44xBimkb0JjIUeVH4dSjkmgUGqVDv0I
   eyc+KR/v8DucjnzXLj0DZKX8zI0Zgn0VJg8M/kpngVOjHSUq2mOnfAPxD
   jhenlbYceGsXAPszelFDQtBrkAvG8Wl+f44ZXDE5uOWJjGo5mvoVoZQWo
   Z0kS23wQamxz2VhBzwqWV1/WgVPtIGzuDDmsHqKWIsXG66DlJRBcd/03P
   s6ng5xTfB9YBGSx/5ZM1CnzjCSM0BNnOm2KWK4cdBd5uqUus24fx1Ey7c
   l5X4WLbCeQmApnM+rmaP/8mhEUzk5TnbRwUGLWy1VDkzPopm26NGRaG1Y
   w==;
X-CSE-ConnectionGUID: WUwOO83+TFajAKEGIv6qbQ==
X-CSE-MsgGUID: MD89Y2lfR+2ggcyP5dNJGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84554197"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84554197"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 23:57:39 -0700
X-CSE-ConnectionGUID: /jk/pzBhSyC+4dGtTGGLXg==
X-CSE-MsgGUID: hciXs8HFS1Kpofs24n1HXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="252159168"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 09 Jul 2026 23:57:35 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 2/7] perf/x86: Free hybrid state on PMU init failure
Date: Fri, 10 Jul 2026 14:51:23 +0800
Message-Id: <20260710065128.1799838-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710065128.1799838-1-dapeng1.mi@linux.intel.com>
References: <20260710065128.1799838-1-dapeng1.mi@linux.intel.com>
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

