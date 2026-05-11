Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445B6296BC8;
	Mon, 11 May 2026 23:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778541246; cv=none; b=LFYoNuKQ025x+2lSU8YJSLYDEB6NCnbTtm/dF6eR+/8oKYEIqpbWwfvHtHT3ke1nziE9Q7H466Bln5WmCxK3xIHFKMldAQV//kUDxR49lL7pSSEyhL0d8c7YvT+9V9/r36y3OQHhIY+Pd5dTt3plklQsUWb6rQ7FnK28VWAaBmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778541246; c=relaxed/simple;
	bh=n7+O1RCClXHKc2/eusHqs6xhHkY2KP1D2tykz33mHH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sIGav8Tcmwdu6xBuNPoQt0l5aL6kMSdlxmVqAzJ+cVpf09JsusE1EbCPstNU3Enq9iBZBCi/J5dPQk9FjeeA3YgOTe9O30p2LHZhHT94ue/KCRru6bDLNXPHlIVjvQ4es+fUSSJN+p3VpSsrXHDyawsktkhUVXCiQziI1crVUvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LACnp7JT; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LACnp7JT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778541245; x=1810077245;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n7+O1RCClXHKc2/eusHqs6xhHkY2KP1D2tykz33mHH4=;
  b=LACnp7JTj8FDMQjwPFpu0hnbcSv/wM2ZzcGtfb1po9sV6lC44fqPFJ+j
   eE5tYbLoAdZibb/gXcldnaqBEiyeHGHDCx0RLSAuejTUU1I8t8Aw7MsOO
   Li/4SkMMUrjkmSS28ngMQqwiDcbo64bkgCtQKxm6oKRFA8daV5tj+PuBP
   SMbLzSlvfeJOuSCgJw1dLDQ5Tna9uq+SPkuI5Ndve88bMceAp7MyMEmYL
   cLo+OCqsbJn2kT+On4kUipLkhBsH0NVNlawRT24uV5Deqzn51QO07mwLV
   b1YVKLzo6v7gnKUh19vYL3Se8SL0wnJjET9KZOZ2ymDKP5/fmuqgNfi/c
   g==;
X-CSE-ConnectionGUID: wZ4aSnH2TmOgk3IYV/WNvg==
X-CSE-MsgGUID: v+9t1Yv/Swa77vqAUwdXUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83058090"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="83058090"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 16:14:04 -0700
X-CSE-ConnectionGUID: WI7U2fW6TaK1Be/h/HQx3Q==
X-CSE-MsgGUID: eH93+NYdQWKSiUoHX2hZSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="267944452"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 16:14:05 -0700
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
Subject: [PATCH 0/6] perf/x86/intel/uncore: Bug fixes and cleanups
Date: Mon, 11 May 2026 16:05:21 -0700
Message-ID: <20260511230527.26096-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series includes bug fixes and cleanups for the Intel uncore PMU
driver.

- Patch 1 fixes a theoretical bug in discovery unit lookup on multi-die
  systems.
- Patch 2 fixes a PCI device refcount leak in UPI topology discovery.
- Patch 3 works around a hardware issue on Raptor Cove CPUs.
- Patches 4-6 implement a global MSR init callback for GNR/GRR/SRF/CWF
  uncore.

Zide Chen (6):
  perf/x86/intel/uncore: Fix discovery unit lookup for multi-die systems
  perf/x86/intel/uncore: Fix PCI device refcount leak in UPI discovery
  perf/x86/intel/uncore: Defer ADL global PMON enable to enable_box()
  perf/x86/intel/uncore: Move die_to_cpu() to uncore.c
  perf/x86/intel/uncore: Fix uncore_die_to_cpu() for offline dies
  perf/x86/intel/uncore: Implement global init callback for GNR uncore

 arch/x86/events/intel/uncore.c           | 33 ++++++++++++++++++++++-
 arch/x86/events/intel/uncore.h           |  3 ++-
 arch/x86/events/intel/uncore_discovery.c |  4 +--
 arch/x86/events/intel/uncore_snb.c       |  7 -----
 arch/x86/events/intel/uncore_snbep.c     | 34 +++++++-----------------
 5 files changed, 46 insertions(+), 35 deletions(-)

-- 
2.54.0

