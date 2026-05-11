Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAFD302767;
	Mon, 11 May 2026 23:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778541247; cv=none; b=O/7di1G1n2eKYXPbxkiJvyavi/Rh85W+oBAAr6pCteqPqq5Q/5uYjgf5ZkJYAD5DAibniGIhyc95zACnmR6kUTWVjYwxHoHW0i4eUDJ6q5xe93TInDHT4a9wdS31z1dKNWisxrOBRhRNryqWkUqpi5zjbQ47Q9dq0I3H7v1z4No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778541247; c=relaxed/simple;
	bh=S+iZ04i2tTNKAa7ATmDVdt3q8+QcE4iPJ4/MjeyQosQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ex5p+8UyNfOpWtTAm4t6eHphh4hzsqKjinS1VK1QX5xLEdLvmh6WHEVpg6jo6rDvpE6AJ+cILp6YBFw8Rrbl94U/N4Q/jqBlXU6XPPObgSqE6F6YMN5aOhro0X0dJf+9gOAMwvJRh9JM3NO3/9XgSiOW+b5SSgQwrbGRFOrL+60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zt1fNLlW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zt1fNLlW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778541246; x=1810077246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S+iZ04i2tTNKAa7ATmDVdt3q8+QcE4iPJ4/MjeyQosQ=;
  b=Zt1fNLlW/bUNhf3mjSUvOGOHTxAvHiNXK5ybMasQEUdR3TN8Nl5mYfCK
   sDnDSbU3tc1AgBdBhI4Aa6tI5TeumCysqttvjdFWh2Rw+PNjsj/mtpzbm
   PvE9kT4aidxngLmlLJJ4PqSYnX6pcO6+m6D6MTlzKmTHd6b9NyFeFp9NJ
   hufeNyYHugPu1jeUuDDlTebqiwZZSL8BLauq5fkxJutQWH0W1mZDodU9R
   DSv/MrbxiTVSaItEnk0p1a2vsfVCz3cjFxk1eYLnUv/G/Lujwchsha5bZ
   NVtn+XbUaTAKe7o5hwpBkMpzZzciXqGZ2+bwSXEUt0QMcEoq60Jz3mD8Y
   g==;
X-CSE-ConnectionGUID: vvw6abVMT7iNr5RKSR/rCg==
X-CSE-MsgGUID: 0TIFn1CyQJa8rHDUKF/FvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83058099"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="83058099"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 16:14:06 -0700
X-CSE-ConnectionGUID: P/JUhvM5S+etAUpxUZtoqA==
X-CSE-MsgGUID: 9SRLTIrtSBahQN+ioSOB7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="267944456"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 16:14:06 -0700
From: Zide Chen <zide.chen@intel.com>
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Zide Chen <zide.chen@intel.com>
Subject: [PATCH 1/6] perf/x86/intel/uncore: Fix discovery unit lookup for multi-die systems
Date: Mon, 11 May 2026 16:05:22 -0700
Message-ID: <20260511230527.26096-2-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511230527.26096-1-zide.chen@intel.com>
References: <20260511230527.26096-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In uncore_find_add_unit(), PMON units with the same unit ID may be
added to the uncore discovery RB tree for different dies.  These units
are distinguished by node->die.

However, intel_generic_uncore_box_ctl() uses fixes die ID -1 when
looking up the discovery unit, which may retrieve the wrong node on
multi-die systems.

Use box->dieid instead so the correct discovery unit is selected.

No functional issue has been observed so far because currently supported
platforms happen to use the same unit control register for such units.

Fixes: b1d9ea2e1ca4 ("perf/x86/uncore: Apply the unit control RB tree to MSR uncore units")
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/uncore_discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 583cbd06b9b8..1d22d7c00ee0 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -481,7 +481,7 @@ static u64 intel_generic_uncore_box_ctl(struct intel_uncore_box *box)
 	struct intel_uncore_discovery_unit *unit;
 
 	unit = intel_uncore_find_discovery_unit(box->pmu->type->boxes,
-						-1, box->pmu->pmu_idx);
+						box->dieid, box->pmu->pmu_idx);
 	if (WARN_ON_ONCE(!unit))
 		return 0;
 
-- 
2.54.0

