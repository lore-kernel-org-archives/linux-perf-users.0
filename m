Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2F53CBE65;
	Fri,  3 Apr 2026 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775237394; cv=none; b=NiOGYQyXKRdwqri3AgZjEl+/LeB27YWF2eaC8IeQh5aqLtyG55Ok2rSn7YD9ALetw/PJfI2+fYQwfQ7xCWNKPPxkBZnqNfRTH/k6s7NeubGAZhiIE7IezAu6JyBHg7LW28SvxaXSFDpbeOVvSEazGBTBugcJ25WGgdE7mv30ba8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775237394; c=relaxed/simple;
	bh=xAnQSlM5aNzQ53On1UiWFjjJ0H7oYLmKMXghursHwR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6D4dm9S/lu3ywNVhjnU4rBp/nIwTuUjoEn3m5HdxvjOywSWy3OjcnNtq2ff75G3NbZZerPtDsEQfc2XTN1KdUSstk3IxXe4NFSFCnPMbkh9c2I/TXLSDdiqNH/RiZuwmvMPJaBg2ElgYrlGQemqXa72TvNpr9SAkL3OuVWQi0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HyluBsR3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HyluBsR3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775237393; x=1806773393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xAnQSlM5aNzQ53On1UiWFjjJ0H7oYLmKMXghursHwR4=;
  b=HyluBsR3K4YdNsiWLrWKyjGO0PHDduXHCa7dDM1/dl6j1mSIbOp8xqyR
   GnBMYaY8dLh2GcNyREP2mAr7s0VJYmyYpMCSpyEbZSqj9xCA8ONfpsiOB
   O/zzw+9oXV7RKtsV4Ewe0uP54xRn+sHLUoHStFhA9P5HXWkUtACbvJPNo
   fEgSp8xUvs5ec/rC6e4kWMdItXHPMN7Txkq6K/6GBpEkP43KC5SHnwhNK
   3hKxM5j5q+bUrbZro7AIWvyQsZcQBriRkm8PoBKKPDtFrsVgKnj4iwn9+
   NjbAUxtiKBmwHODxLfWmKdiCME/X0QV3lNp/qLQxXVYTKUpqa1/9ZjaGi
   A==;
X-CSE-ConnectionGUID: 7+mv5JecQ+iZxL8kIQ/RCA==
X-CSE-MsgGUID: cFR12VgcQRmgyIoEW8zEzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="93693311"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="93693311"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 10:29:52 -0700
X-CSE-ConnectionGUID: 3W8YJOvXSPqO3Tg0Z6FPDQ==
X-CSE-MsgGUID: wkWOBysYReys/mZCeXuL0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="250525259"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 10:29:51 -0700
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
Subject: [PATCH V7 2/4] perf/x86/intel/uncore: Skip discovery table for offline dies
Date: Fri,  3 Apr 2026 10:21:44 -0700
Message-ID: <20260403172146.158172-3-zide.chen@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403172146.158172-1-zide.chen@intel.com>
References: <20260403172146.158172-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This warning can be triggered if NUMA is disabled and the system
boots with fewer CPUs than the number of CPUs in die 0.

WARNING: CPU: 9 PID: 7257 at uncore.c:1146 uncore_pci_pmu_register+0x136/0x160 [intel_uncore]

Currently, the discovery table continues to be parsed even if all CPUs
in the associated die are offline.  This can lead to an array overflow
at "pmu->boxes[die] = box" in uncore_pci_pmu_register(), which may
trigger the warning above or cause other issues.

However, the Intel uncore driver assumes all die IDs are consecutive
and does not support gaps in the die ID space.

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

v6:
- Change WARNING line from 1157 to 1146 to reflect the new rebased code.
- Add changelog to clarify that it doesn't support die ID gaps.
---
 arch/x86/events/intel/uncore_discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 427939be2fb4..583cbd06b9b8 100644
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

