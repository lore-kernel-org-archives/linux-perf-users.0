Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4A02DF154;
	Wed, 29 Oct 2025 22:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761776039; cv=none; b=nwm7bAkYFane274rZOG0LnLL5Eac8oaupZNjx/P/GxVhrf0FdHPDty0xRXFy0/L704UNKqMs9TfmyOMy1yQ1MOdiDOt8MI/4got11Pm8wmFx7AkR1FUgwIvSNhRFwFrYZBNlhSkMlOUmRBu07LGcVcnK5cP6vMgu+CTPn2B8Jg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761776039; c=relaxed/simple;
	bh=VoWm2qOtQGTj3Rn1r17zeK9IewX/0g9x38l1SVnoSnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XbiVucIyCcEGNgBgOr0E/PIFdpUe0Y77+nCM/bQvju3vkknIkL9HAGFhhd9Vzf7Z6c6Zy+haXczGxPvd8eboGV3FD3dxredCeamD2fDaRwCLTKaNhv+7dfRx4uCeeYCSfnyWjdg8v//bcQzhsOZJQbf+dzjvHtnEPFRUricLP9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G43GWqNZ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G43GWqNZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761776038; x=1793312038;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VoWm2qOtQGTj3Rn1r17zeK9IewX/0g9x38l1SVnoSnw=;
  b=G43GWqNZC0zRe4nLy3eCkJJmPTkcP21VFg4fooi1AA4leu7KDdcMuU5e
   RHQrFVLLrur7HLXnzxrZvVfWrLfV60SedmcMUHlzMek2DoWrbA7Fr5iiY
   IezH66PNz88mNU/oumLywdz5inlkzPy2wZmTyMWl2W3dWNa8xTCAPFTnf
   SM4OHRUgh2M2J/dG8pUl+VheLwDdcW19uXYHlpnn1tPeGol0xN7iSdcbI
   Jgj2w4GE66uI2hSx9KAK+5Kz++8l0L5jbHHj7hwDbNdFJ3Cv0jFgxoP7e
   GpwiW8w+41TDrAxmeKSJKXdcWK82WCzwirIncdV746GIvsIW+wEWuWMVa
   w==;
X-CSE-ConnectionGUID: Ka/jheQKSYyBoZ9iLyJVOg==
X-CSE-MsgGUID: WXvlwTMqQnWn60DKoO734Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="66526649"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="66526649"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 15:13:58 -0700
X-CSE-ConnectionGUID: TuR2KMVbRMyUyW3KgXoCXA==
X-CSE-MsgGUID: EWWdFPceRiqpzsxqJTOWjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="190104774"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 15:13:57 -0700
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
	Xudong Hao <xudong.hao@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Steve Wahl <steve.wahl@hpe.com>
Subject: [PATCH 1/2] perf/x86/intel/uncore: Skip discovery table for offline dies
Date: Wed, 29 Oct 2025 15:07:10 -0700
Message-ID: <20251029220711.57909-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.51.1
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
in the associated die are offline. This can lead to an array overflow
at "pmu->boxes[die] = box" in uncore_pci_pmu_register(), which may
trigger the warning above or cause other issues.

Reported-by: Steve Wahl <steve.wahl@hpe.com>
Fixes: edae1f06c2cd ("perf/x86/intel/uncore: Parse uncore discovery tables")
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/uncore.c           | 4 ++++
 arch/x86/events/intel/uncore_discovery.c | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index ee586eb714ec..5c3aeea5c78d 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1380,6 +1380,10 @@ static void uncore_pci_pmus_register(void)
 
 		for (node = rb_first(type->boxes); node; node = rb_next(node)) {
 			unit = rb_entry(node, struct intel_uncore_discovery_unit, node);
+
+			if (WARN_ON(unit->die >= uncore_max_dies()))
+				continue;
+
 			pdev = pci_get_domain_bus_and_slot(UNCORE_DISCOVERY_PCI_DOMAIN(unit->addr),
 							   UNCORE_DISCOVERY_PCI_BUS(unit->addr),
 							   UNCORE_DISCOVERY_PCI_DEVFN(unit->addr));
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 1bf6e4288577..d6aee12139f1 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -388,7 +388,7 @@ static bool intel_uncore_has_discovery_tables_pci(int *ignore)
 				     (val & UNCORE_DISCOVERY_DVSEC2_BIR_MASK) * UNCORE_DISCOVERY_BIR_STEP;
 
 			die = get_device_die_id(dev);
-			if (die < 0)
+			if ((die < 0) || (die >= uncore_max_dies()))
 				continue;
 
 			parse_discovery_table(dev, die, bar_offset, &parsed, ignore);
-- 
2.51.1

