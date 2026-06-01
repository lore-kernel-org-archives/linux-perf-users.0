Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FC63DD528;
	Mon,  1 Jun 2026 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333810; cv=none; b=q4k+7y5d2WbriEXO9xKm2hajg9G57QALj/5x8cr9AgRF+hk3TSb4R7LJctskIF6dYB01itib2OHDL8BiV4JzHF+HGwa0Tkih30CbR3c/NRZmahwIf5G5/1lUszxaRF0PR9LeMRHAoQNZ0WMjf6ouGsThGvZOpFMoWQcEFw02/5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333810; c=relaxed/simple;
	bh=aRxbBdrokAmj0l1nPsLdbi++7CyvIhaqoY8XGRoKsDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qr+zYSu2BcF35wtXeP5YV5JqGAzWlOUmtlAzkGTd06BSO1+w0T1v7D7z7T2FoiA4DrWmTmajYKIyuGVhie7Tdr16GumBJc1gNC2rfmzlava+LmzCTjiilUPCXJrXemzXra/nWmX08BaHrHsRRJv8dv/C4zw61+whiO/Sil86s5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NOgBuO66; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NOgBuO66"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780333810; x=1811869810;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aRxbBdrokAmj0l1nPsLdbi++7CyvIhaqoY8XGRoKsDw=;
  b=NOgBuO66HTv2MZVRIswTFiaY02Ol5hFmWGtAjn7+C/DoP/DK31N69wHm
   kbgTyjEh3do4l/4TdhLfYrW1P8ym3FLIa8ot3C3+g8z653C7pF1tqxA2L
   TV1LhGpC1otqLujvZWCSnXS6JugPLKhOIg/iOzefBzwqbPqS/iSt/kNN/
   Nt/PnOEXcgXRPcPlOMKLv7ZnWvqFDHrurfqTJ+zuE3cpR2+YzTogDUmql
   uewYAE/jeNabgwm6HL6EOZNUCQAgo9jJxdsLBdisj9Eor8nC7DAU5VthA
   1keTMHPPnbJD7DptWAx6HsBb+wDz81pNK9HCWq8Z0iOS0LOGYUjWgaxZc
   Q==;
X-CSE-ConnectionGUID: R/hD+jTYRGqZT8NoIMezUQ==
X-CSE-MsgGUID: 5FQn37iKSWG7IRBFy4XNsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="98516991"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="98516991"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 10:10:07 -0700
X-CSE-ConnectionGUID: LaOD6rjiS8KsahFTIhe1kQ==
X-CSE-MsgGUID: CemSBNsNQPKwrScd0iXIwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="242585007"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 10:10:05 -0700
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
Subject: [PATCH V2 4/8] perf/x86/intel/uncore: Keep PCI PMUs working when MMIO/MSR setup fails
Date: Mon,  1 Jun 2026 10:01:10 -0700
Message-ID: <20260601170114.173359-5-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601170114.173359-1-zide.chen@intel.com>
References: <20260601170114.173359-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uncore_event_cpu_online() returns -ENOMEM early when both the MSR and
MMIO box allocations fail.  This also aborts PCI uncore setup, even
though PCI PMUs are independent of the MSR/MMIO paths.

Remove the early return so PCI uncore setup always runs regardless
of whether MSR or MMIO box allocation succeeds.

Fixes: 3da04b8a00dd ("perf/x86/intel/uncore: Support MMIO type uncore blocks")
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/uncore.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index d759888476c3..6df44f69cc5b 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1633,8 +1633,6 @@ static int uncore_event_cpu_online(unsigned int cpu)
 	die = topology_logical_die_id(cpu);
 	msr_ret = uncore_box_ref(uncore_msr_uncores, die, cpu);
 	mmio_ret = uncore_box_ref(uncore_mmio_uncores, die, cpu);
-	if (msr_ret && mmio_ret)
-		return -ENOMEM;
 
 	/*
 	 * Check if there is an online cpu in the package
-- 
2.54.0

