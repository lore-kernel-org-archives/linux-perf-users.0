Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB273CFF78;
	Fri, 13 Mar 2026 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773424243; cv=none; b=efXqqT632Yb6pekM7bYGTbXCKA3pyTwTtwAsVSw5MsT8Zl2248IB9yuN5BWrDYf+2Odc3vuQn3HqFx2e0EedvpFVZadXH8IkwdHwiTXwsi0O1Jr2JUsRBAC9yM+EbumLHHz26ZkF36T8ZSjIvy7uXQo3WuKrQhSQD7DjVMpaSQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773424243; c=relaxed/simple;
	bh=IXUGl2dTfL09HwjzNjdo0xANLqNl/wnyERF646N8iJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJNQhP+qlMos4JYgt+Hb1GMH3olRuOSuYUCXDXKFrPcYf1u1+38OgW1i3c10o44s0TnfBcIfNJxDg7qA6sC738pjJtUZlkLcjHQrN3UoVBlzuXkKaAv0ap02tntSOjid/7Lc0oWwkYVtVlPY6qCU+AZLqngeZ3rsfKf0+TO0Jh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G3UY7Obv; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G3UY7Obv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773424242; x=1804960242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IXUGl2dTfL09HwjzNjdo0xANLqNl/wnyERF646N8iJQ=;
  b=G3UY7Obv+b4S0EtGxhryO3Hh/A7whM/2/aVEw3u+2hRoBGsZRdAWRceu
   Jq841PW/rOdnbIH9OOPVu8ibCTUDULvxlBp12vEan3CGW5x8Nf+jLLxoD
   ykFCggTuyfDxxG3NsQm3dB6lskoZMfmofW8ahQarE/URcmmZIBkM29Zq9
   nxasEzBbqUiBO+XXPjnmO82CzLpS5z7Hhox0H2eLRsnsaT1DsAm0wiDpS
   9UFneZeufghfBdxDMgcJAtgP8zUFOMKyg1FeTMZLYkmzpVmMpJihE2vvR
   AWGFcETJO4fek23C7X5pEAFP3E5Tyb265SH3E95UhQ8tuS9IMJZehIWwe
   Q==;
X-CSE-ConnectionGUID: UuY/sN5XTwmK8vgPr3lMmA==
X-CSE-MsgGUID: 9dq1jraGTJS1jjFim2xS6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74508732"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74508732"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 10:50:42 -0700
X-CSE-ConnectionGUID: oFpO+hBJRN2prk2FDJ4HTA==
X-CSE-MsgGUID: FpnO9I9DSgK4WdU0BYr44g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="259128551"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 10:50:42 -0700
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
	Zide Chen <zide.chen@intel.com>,
	Steve Wahl <steve.wahl@hpe.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH V4 2/4] perf/x86/intel/uncore: Skip discovery table for offline dies
Date: Fri, 13 Mar 2026 10:40:48 -0700
Message-ID: <20260313174050.171704-3-zide.chen@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313174050.171704-1-zide.chen@intel.com>
References: <20260313174050.171704-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This warning can be triggered if NUMA is disabled and the system
boots with fewer CPUs than the number of CPUs in die 0.

WARNING: CPU: 9 PID: 7257 at uncore.c:1157 uncore_pci_pmu_register+0x136/0x160 [intel_uncore]

Currently, the discovery table continues to be parsed even if all CPUs
in the associated die are offline.  This can lead to an array overflow
at "pmu->boxes[die] = box" in uncore_pci_pmu_register(), which may
trigger the warning above or cause other issues.

Reported-by: Steve Wahl <steve.wahl@hpe.com>
Tested-by: Steve Wahl <steve.wahl@hpe.com>
Fixes: edae1f06c2cd ("perf/x86/intel/uncore: Parse uncore discovery tables")
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2:
- Add the Tested-by tag
- Rebase onto perf/core (base commit: a491c02c2770)

V3:
- Remove the overly cautious WARN_ON()

V4:
- Add Reviewed-by tag.
---
 arch/x86/events/intel/uncore_discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 6a4e892cd525..749db3649f8f 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -371,7 +371,7 @@ static bool uncore_discovery_pci(struct uncore_discovery_domain *domain)
 				     (val & UNCORE_DISCOVERY_DVSEC2_BIR_MASK) * UNCORE_DISCOVERY_BIR_STEP;
 
 			die = get_device_die_id(dev);
-			if (die < 0)
+			if ((die < 0) || (die >= uncore_max_dies()))
 				continue;
 
 			parse_discovery_table(domain, dev, die, bar_offset, &parsed);
-- 
2.53.0

