Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E773A16A4;
	Mon, 30 Mar 2026 21:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774906369; cv=none; b=OwtR09f/assbSEmqOzzl/ZcYdf9J1VX4rIILDIGjPm7nA32Mv5uwxV4ndub3/e9KVVzqG47g+KXzrqby6MM1t0vjk2O/NtpWoKviqJZRnOAmaKGiMrXvh872xtIz/uehsK1+8sGMr0Pg25yXQEXPegRaOh7lKxsbrsMSonSGcL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774906369; c=relaxed/simple;
	bh=nyVCv6Qd3ctMvB+dWJMek14UFATpGnq0s8PZvZfgp/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gjmArn2gxfqvzgGa/yrFcKdQj3SKVA4IRszUEbjbYitBc7v6tGnZ6gvvUrebJBhTdcga4pGARgxkiIjPudLsaiRIGAGwoZSepkI1oSe+tdNCoFV1++K5qndnkmX/pPVG3GCZQoJakHiBHyvtBWXzIWma/KpEYjWGuuHt1ZDG9W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mj8LzXdI; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mj8LzXdI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774906369; x=1806442369;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nyVCv6Qd3ctMvB+dWJMek14UFATpGnq0s8PZvZfgp/I=;
  b=mj8LzXdIUsQgB/+BWaL+8GGg4TlD3dD1KTf4cKsX1tBBhOAQA8l5aFax
   3cl2N1g7ueI9ZeXpyr6H+o7QGBB/zV+/jGOa7udT3NQJN8a0nR6t8Obm0
   bDTGml/pBU4qW1lf+RwWQL1Qg1BSmCivkqiDJTeK4xIA/GaTwGUqXFxjW
   n5gBOwiSMJd+Aaen50JiOtsCGTakYmbsiFAKLLYChUlrSbmH+N8RKiAnk
   TwN1EpaDHKB/B6ih8NXFM9wJKc6sUGmL1TOrKERNF9uyEhcEdU0wHBpQV
   uPqadOV444NSJqmXda/TkxJJFjZ2eydxjlqGB+Ol5RGm6aEbSYwZf071B
   g==;
X-CSE-ConnectionGUID: mvS7izLMRbi1aHDYuXDUaA==
X-CSE-MsgGUID: 75TWQKDyS+ODReTJ+C5m4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="101366798"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="101366798"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 14:32:47 -0700
X-CSE-ConnectionGUID: bSiJF5XmTcG2JuD52mLl0w==
X-CSE-MsgGUID: T47TLTpmQiels8Veqss1mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="227779506"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 14:32:47 -0700
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
Subject: [PATCH V6 0/5] Miscellaneous Intel uncore patches
Date: Mon, 30 Mar 2026 14:24:39 -0700
Message-ID: <20260330212444.117325-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is mainly a RESEND of the patch set below, with patch v5 3/4
split into two patches.

I grouped these patches together for the convenience of the maintainers
and bumped the whole series to V6.

Changes since v5:
- Split patch v5 3/4 into two patches for clearer scope.
- Patch 2/5: Add changelog to clarify that it doesn't support die ID gaps.
- Patch 3/5: Change title and changelog to reflect the reduced scope.
- Patch 4/5: New patch. Remove redundant snbep_pci2phy_map_init() calls.

Changes since v4:
- Remove unused die_id variable from patch 3.

V5:
https://lore.kernel.org/lkml/20260324214932.10068-1-zide.chen@intel.com/

v4:
https://lore.kernel.org/lkml/20260313174050.171704-1-zide.chen@intel.com/

Previous versions:
https://lore.kernel.org/lkml/cda9ab9b-4581-409f-a9bb-0e8a67ad3530@web.de/T/
https://lore.kernel.org/lkml/20260116031113.45098-1-zide.chen@intel.com/
https://lore.kernel.org/lkml/20260206231203.11760-1-zide.chen@intel.com/

Zide Chen (5):
  perf/x86/intel/uncore: Fix iounmap() leak on global_init failure
  perf/x86/intel/uncore: Skip discovery table for offline dies
  perf/x86/intel/uncore: Do not treat -1 die_id as error during UBOX
    scan
  perf/x86/intel/uncore: Fix PMON enumeration with NUMA disabled
  perf/x86/intel/uncore: Remove extra double quote mark

 arch/x86/events/intel/uncore.c           |  1 +
 arch/x86/events/intel/uncore_discovery.c | 17 +++--
 arch/x86/events/intel/uncore_snbep.c     | 83 +++++++++++-------------
 3 files changed, 49 insertions(+), 52 deletions(-)
-- 
2.53.0

