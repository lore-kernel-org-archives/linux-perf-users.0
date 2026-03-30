Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A68B396B76;
	Mon, 30 Mar 2026 21:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774906388; cv=none; b=njpD9ha1xLL+hesDhmMSzAT4/X1MlMk9EKZP+79b/F3m0BlvRV/fiWLMVP/lrD25FXM2M+flFEMmGYd1NrdENV6p+BN/WPK0Ao/EGGA88gM7VgsCjECesMT9wn05sJuM6eknWwNP+GhWvuoaQ7kwlwOzXjagQCrxUt2/9zJdZHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774906388; c=relaxed/simple;
	bh=IXUGl2dTfL09HwjzNjdo0xANLqNl/wnyERF646N8iJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nd4N47QWiytET03O+kgttj8astUVwp0j14t+mc4Cz4SlAYWaQQmbAUguvJ3MAgcyyM86qIQqOv848+g4e4ahl8bSTNH6kZNWITVgoe5LnKj2OpK//1sTnIXh4PixFiYKMRWkYHzG+yzWsb/kBww4SO0o0B67W2aRy3R+u0/ET0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V3BMTO3/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V3BMTO3/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774906387; x=1806442387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IXUGl2dTfL09HwjzNjdo0xANLqNl/wnyERF646N8iJQ=;
  b=V3BMTO3/c7cCzwvA9IDJdljXSv/dz/KAHsW83RR38f33qjlR6rl8O/Rr
   Zf73TU989cnkPyCI6JEqa/iqekx/cw4ph1uPoAI77NH4vqwhfrOtOstyS
   JWfv72Y8H4wpoyk1VISrEIJcxAqpBYkDY/TEfqGfz1c5EHQAcvFV+vwse
   upgAKDau+Snu/47oII24QOJWI5QvzbytdQwxuxVSKIJsVQ0FLoikdNUfp
   y3lfjXM6LkxxA6JMopqMzcjNit5QyRRPCBhWVu8aToFaJK73yrUq00O0Z
   8HNEv3dnceJoLjMxddOFT0ndfUeVHFOE0kLyq7xmRukg/mDIA8jAsjRTx
   A==;
X-CSE-ConnectionGUID: VdOmnxIyT++QeRiQ9x2//w==
X-CSE-MsgGUID: y3va6W1ZRES78TnBQ0dTfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="101366818"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="101366818"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 14:33:06 -0700
X-CSE-ConnectionGUID: yHsqiAgQSRa04deqVCCgaQ==
X-CSE-MsgGUID: s6Bi1KSoRTu5f3zUUfUIog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="227779537"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 14:33:06 -0700
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
Subject: [PATCH V6 2/5] perf/x86/intel/uncore: Skip discovery table for offline dies
Date: Mon, 30 Mar 2026 14:24:41 -0700
Message-ID: <20260330212444.117325-3-zide.chen@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330212444.117325-1-zide.chen@intel.com>
References: <20260330212444.117325-1-zide.chen@intel.com>
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

