Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D179E360EC7;
	Tue,  2 Jun 2026 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412278; cv=none; b=Ay0cMY0/Iu0QU2dijm41nx4WBzAJDerYWIJMZrJ9QcigLlGsoLkcs/Pereq4hx82pzrQv57y1fYs4x2pQGj2Mf1ks6ihpQ7MKc2QWFycUDuUzM/dJKLLYcQG/ynNdsTc/9qKT3Uy0FAkMGeO15GPNxz3UcHcMT2/BB0YGo8STx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412278; c=relaxed/simple;
	bh=vvAHYn1CzxqUSRrcLxh052MjySYP25gUrVIa6i4MTH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvSkMLxeZmthaj0iK7PuVRngHFYueht6zbtArqOOXUhS63mAF/FXTaYnWUrVZj6cprK1QgwfoaulWbFRjofkYgrFjD9H0C+BuiuLDUU/tUKQ/XD/QDUcez5DAxgisi1YLp4EK43xc0Ch921E7xyCVg2a5xP2DnWCHpaF/WT9trw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FHydV7Pu; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FHydV7Pu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780412277; x=1811948277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vvAHYn1CzxqUSRrcLxh052MjySYP25gUrVIa6i4MTH8=;
  b=FHydV7Pu/lZzAsDpT09fdksIDPbtmpIcBe+bTojKjr7HzsqY/RRWh/Hb
   TQaYJx0WhNS6JhijycULf2rdv22uxZT4jRUp0T0jh/QVOcgKZAznmwSoi
   zcMDqWl3XuLhs0cAQoFLWtNM45wfGBmhY9rwkSNdfZxGVuh/RTPBJ33PC
   ZToC+Gmm/BijWgJ6WvcQINE8oYT1gbzVO7UZtjPRGbnls+yEHGH3rMk/w
   qHx9oE4qqKmBk1dVDIXQMMjA+0qSSO0t++u+w4AmICGB9dct9Eac4e1+o
   xInTHOyHMaCqt2GLiqoa79nfQaxLjxw3+k+KlrrJ3dWlZp3BxxlAn+PUc
   g==;
X-CSE-ConnectionGUID: qWoFzrSQRTmdmcvIBSK43w==
X-CSE-MsgGUID: wVNiCM7/SNOqqDPuYh0BFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="103859980"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="103859980"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 07:57:54 -0700
X-CSE-ConnectionGUID: Jy/m9/DIQFOh2OsjJ1frww==
X-CSE-MsgGUID: cEDaIlJaRYSG6gF2L7Ghkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="243095619"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 07:57:54 -0700
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
Subject: [PATCH V3 1/7] perf/x86/intel/uncore: Fix discovery unit lookup for multi-die systems
Date: Tue,  2 Jun 2026 07:49:02 -0700
Message-ID: <20260602144908.263680-2-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602144908.263680-1-zide.chen@intel.com>
References: <20260602144908.263680-1-zide.chen@intel.com>
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
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
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

