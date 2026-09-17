Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC2A30EF89;
	Thu, 17 Sep 2026 02:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610407; cv=none; b=CwkIwRG545ktMdMhbjqe6runW8BHrGXthbanpqeVlRLZP+XFptKR1nF8fVwYc1zDw8wsn0WJ0045ZdH7l/WRXmdgfjfduALespAcMI7RGyelNhcQBhEBJaNueENJpZspPT/MKkVjXqojAu93qet9WDRFn9TCQnGSg9Q/uDEpXeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610407; c=relaxed/simple;
	bh=GiRYzqelFvZjf3NOI++/w/qBAEsbZLya5YyF3mmqENs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WD9GXtSPPs75dEVmHTNLxgoeHPD08p03cGE9vUpaflbTTf8NG45IaP14Ct/v72jKb4eHNf+uZVYC2EO5E7gy4iGZR5ni6TKkvu4kuLxxO20lUC/OM8hp0uE5/uqC9NmAYxBPxvGlkk6g3GJC7+hn7FJP9U4k4qvkxpTssxmwHWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hvAXQJZ9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hvAXQJZ9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789610406; x=1821146406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GiRYzqelFvZjf3NOI++/w/qBAEsbZLya5YyF3mmqENs=;
  b=hvAXQJZ93w465oIlxkMSsEoqtCwQO+LDIPYH8fy3OefvXuQoR6OwRXIR
   ez1Wftm/mBo6oK8E9BPzr1s38ifexJnR6E9WCiHc22RACNtOdDbZZil1Y
   GxjkuErfwVDpOSeBM2sx0QuVqkxGiU7KbUfgsdSiFw+/L7M7mFZJL8GZc
   iDwmmrH8zBQS4e5GUvuSbJ7MOKp1r25wukwwlOl9ovD4wCU98So7HXLzl
   qnUCgxZIxV4yMtr2TK4QBrMv7f4gMydyYPiqdU0UaJmM4DyobuMWgHJtQ
   2NPlsSfj6P4yYFjasOcmOmdGAQ5k7ZLoaSbf55R7ny/jnleOwMssbQt02
   A==;
X-CSE-ConnectionGUID: nBMHYqjfQ4uE8EI1PvSwgw==
X-CSE-MsgGUID: r8i6dlGLRM6yuzVrY3GLdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107498595"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="107498595"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 19:00:06 -0700
X-CSE-ConnectionGUID: yldd3ZiETBi5kf4PUWilwA==
X-CSE-MsgGUID: qaCD5VV0RM+5ijIEsIwuDQ==
X-ExtLoop1: 1
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa003.fm.intel.com with ESMTP; 16 Sep 2026 19:00:02 -0700
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
Subject: [PATCH 08/12] perf/x86/intel: Delete dead NVL PEBS data-source init call
Date: Thu, 17 Sep 2026 09:52:30 +0800
Message-Id: <20260917015234.981153-9-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
References: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nova Lake now uses the OMR data-source table for PEBS data-source
decoding and no longer depends on the legacy static pebs_data_source[]
mapping.

Remove the dead intel_pmu_pebs_data_source_lnl() initialization call
for NVL.

Fixes: c847a208f43b ("perf/x86/intel: Add core PMU support for Novalake")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4bde7362d7b2..e6efd2a2ada6 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -8843,8 +8843,6 @@ __init int intel_pmu_init(void)
 		/* Initialize Atom core specific PerfMon capabilities.*/
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
 		intel_pmu_init_arw(&pmu->pmu);
-
-		intel_pmu_pebs_data_source_lnl();
 		break;
 
 	default:
-- 
2.34.1

