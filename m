Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277093B38A6;
	Tue, 24 Mar 2026 21:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389499; cv=none; b=BFDBGqVJTu7ybj3wllUqka7N/vex/3K8oQgbBHnnZb8+PtUkMvRJthJVVUSRC4Sa/mjSfty7ZroE6KRXj5TBLdCqWaEL/jki6KwZSz992HHnf0AV70vVAVUIn1ja2P6uxT1AQZrJmBlRsFjOIe1sTcfCDxj32cn73lJYqF9Ze6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389499; c=relaxed/simple;
	bh=IXUGl2dTfL09HwjzNjdo0xANLqNl/wnyERF646N8iJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AlYTAh5Xq3TJehIGiSTzK0rfInEmJ4tGQr+zVPK9lFgBGpSs35ZBUGiS9LrmufOXsIrtBrmBIyg0R7UWKFjpuzJ6569i5d7ntxDKfM3DkSp651lYguWbBHD8w38BfJ1Lo16X9O17n9QxZDKfHkSxl79ldyHmmKJndHsmF5A1fWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I2vL+AeL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I2vL+AeL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774389498; x=1805925498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IXUGl2dTfL09HwjzNjdo0xANLqNl/wnyERF646N8iJQ=;
  b=I2vL+AeLwB/U0avzgBfLEu8c+s9F0HZNtCfi3M632Llvm+bCs1+XXu5o
   j/LEKqg3dZmW1yHgoXatr302FQZV5jH2I8bp52ooXvyRv7I1iDrCLERJT
   1B2Invxvv9fcVM/TqZa4SPf7jcHIMa9HowZO2TESppm5UqmYkrMtYDW0H
   IQY1lkXu0IPO9xEqpfwozU+5MBmVaCeqokla9pv0v4X9I7mAmCHoSjMEy
   bFJEPS1tcGVbR4wvggWatSClKGnkp1TC7moJ2DN3gACuaoCXXbLdo38rf
   SzuwamwMHC+XRjqVRN/MBVJ1EkBWl3NDUF39y4gGVA0nxwVrszpFN+UuG
   A==;
X-CSE-ConnectionGUID: tllfiEW8QlypdYSwby8S3Q==
X-CSE-MsgGUID: VYWPfvHqT6yZDnTk5vVCtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="100866099"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="100866099"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 14:58:18 -0700
X-CSE-ConnectionGUID: LrrFlbA2TtGTWG/mhc++Aw==
X-CSE-MsgGUID: hhJJf0NITDSZu2t1ol/h0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="224496725"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 14:58:18 -0700
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
Subject: [PATCH V5 2/4] perf/x86/intel/uncore: Skip discovery table for offline dies
Date: Tue, 24 Mar 2026 14:49:30 -0700
Message-ID: <20260324214932.10068-3-zide.chen@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324214932.10068-1-zide.chen@intel.com>
References: <20260324214932.10068-1-zide.chen@intel.com>
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

