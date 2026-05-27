Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D1C37B016;
	Wed, 27 May 2026 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779895233; cv=none; b=VdrMwC9IlG4QmZHor2yG4mh1Sx9WrktSfRor48Acgn4eCgVlqgLqerWXCkKVdHW5nXE4H4wf1WB6R0TYGpA8/ZSIuCbqchgGWZQuHAfCLCPR2jPSKjNddV2PG4RPcC4+msrYtWVpRwHaBUvH21O6aLeHTnXQCVhK7ghu9Ay4npM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779895233; c=relaxed/simple;
	bh=APKN6YP/PSCz0hYKNhU4R9s89dm1ethWku0geaKhlU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ceWfPk4atLK9Xy0tCGmXQBqIuLDkLZUtiBlcI6CeJUyPnMjxXSAmFIQ3hcC4rYtcvkA4pdh5zvRHer2/VwooLpjFo3ll9uPtGoKy/dmgy5fU0EJxekZ4DvPs2LQvE0OV7Wzx25D1moKizlDg75LVVv/4y7Mx2AC6PC170UChl60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVHWxfUv; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVHWxfUv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779895232; x=1811431232;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=APKN6YP/PSCz0hYKNhU4R9s89dm1ethWku0geaKhlU4=;
  b=cVHWxfUvWIdpJRp1vKqqacYvGBuA0oMXrqpfIhZSV8ex2/CrUvPtLYHw
   kKk5ApKQDFXWC375CAf/CaC4/jz4onzEedM5c6F7QS+xKD2kWAY1NeBwE
   m0+/OI6iG8Ou8gk6dMaviyZvJcNTeVyMYwXWwV9iRU1IFsaDheNvbgRmM
   5UV+6sy7d7lC8QSUjIBeok90SzazihSjrs7AY8bDC3pgWHzJKIqtcc6gF
   BfCXSmuRiM0MH3fUjDXCIfy47ssqke+158zleKJpoGLdEyw5Br4ffdMHw
   pqRj41+U2nC1Hc3UBKZQs/paeKpUudoVXjm9zJFPoqA+eDblIKVyCJPmH
   Q==;
X-CSE-ConnectionGUID: YeCVZtfQTcS7D+2qqvjGgg==
X-CSE-MsgGUID: PhcQEhovRQq+ZF21FAZKcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="98149301"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="98149301"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 08:20:31 -0700
X-CSE-ConnectionGUID: 2xWfGRxeRSyH9yueCD21Kw==
X-CSE-MsgGUID: 7NGzyFy3TOycK2M/fv7STw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="241231391"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 08:20:31 -0700
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
Subject: [PATCH V2 1/7] perf/x86/intel/uncore: Fix discovery unit lookup for multi-die systems
Date: Wed, 27 May 2026 08:11:48 -0700
Message-ID: <20260527151154.130505-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In uncore_find_add_unit(), PMON units with the same unit ID may be
added to the uncore discovery RB-tree for different dies. These units
are distinguished by node->die.

However, intel_generic_uncore_box_ctl() uses a fixed die ID of -1 when
looking up the discovery unit, which may retrieve the wrong node on
multi-die systems.

Use box->dieid instead so the correct discovery unit is selected.

No functional issue has been observed so far because currently supported
platforms happen to use the same unit control register for such units.

Remove WARN_ON_ONCE() because with the above change a NULL unit can be
expected, e.g. when a CPU die is offline during uncore enumeration and
the unit is not added to the RB-tree. In this case,
intel_uncore_find_discovery_unit() returns NULL once the die becomes
online, and it is expected that the PMU box is not functional for that
die.

Fixes: b1d9ea2e1ca4 ("perf/x86/uncore: Apply the unit control RB tree to MSR uncore units")
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v2:
- Remove WARN_ON_ONCE().
---
 arch/x86/events/intel/uncore_discovery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 583cbd06b9b8..60e1200c4691 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -481,8 +481,8 @@ static u64 intel_generic_uncore_box_ctl(struct intel_uncore_box *box)
 	struct intel_uncore_discovery_unit *unit;
 
 	unit = intel_uncore_find_discovery_unit(box->pmu->type->boxes,
-						-1, box->pmu->pmu_idx);
-	if (WARN_ON_ONCE(!unit))
+						box->dieid, box->pmu->pmu_idx);
+	if (!unit)
 		return 0;
 
 	return unit->addr;
-- 
2.54.0

