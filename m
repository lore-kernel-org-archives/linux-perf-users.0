Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5E038E8A1;
	Tue, 12 May 2026 23:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778629182; cv=none; b=E4dT4ci/3JgKkvIy1pVf26mEX1ssXhcRlZc3sSn7sBZuQXUfNEYqZA4nCflZ9suwkNmevHjLxFUd5ZgWe5o3C8h6kCTWrgfIaOX/mGUEv9VO/mPhsaJwW713p5mJhwaaVjjj47vy1aH+UYWjl1M6mgGmS2kVqporLDwcsihZ1hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778629182; c=relaxed/simple;
	bh=/92AWP1MsFNKC4mHffxDlhoo+l3qbYMP/EZiVKkborw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n35d3rHPAbcJZxDbYZPqJKAKnwxGRX9gXNvDbOtcOmYNUw3NCyYPPpjnroClFQopeTMSWpcfOqioAcl1132tqFkaGqjKMcUdE0PSgYtqLuoW0VOzy+dC49h+TYvFkRwt2Grhy6Ak8OJY895jFR5vCVhS5DUd8pHMV7uBzHsKGUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nS6oXThs; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nS6oXThs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778629181; x=1810165181;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/92AWP1MsFNKC4mHffxDlhoo+l3qbYMP/EZiVKkborw=;
  b=nS6oXThsqnEP7z9H4ogkbw0O/HN/iWckVR91k16u6MmFc1EIJIHLxpuP
   D+vWIFMxk0MfbOHFHPHVsdRwZmy+t22QOcJpzajmaN39l2MZQjvAsYl2U
   BlsCG4uuavv2YB3aSCgr4qaiAZRT2V5o/NhXt+z9ZO8TfuCEkrDVCz2xG
   y4heK/sdasKZX1gMLI7Yp32PdMrGCWOeCOW258KghIPqg6KYotwL9/d3k
   WuZvT+UNHbYU2Sphrb+m20oePuZRjx1YquLcTfjUTUbEf8EoqLaPzXHi8
   BzEEV63hXDqrj/ZRNwk2wzXenZBj+aWsVFJTFU2C2FU8+/X1549vrW8vW
   A==;
X-CSE-ConnectionGUID: aw3g0XhdRZ6P6zvxiuu6Vw==
X-CSE-MsgGUID: V5KBSThkSgaxmCS3n3/+bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="105008883"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="105008883"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 16:39:36 -0700
X-CSE-ConnectionGUID: GjgMUQwPS0WW3viSPlxQjQ==
X-CSE-MsgGUID: 8Hoje+ZgTk2TjGwyZ4xzbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="242271291"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 16:39:37 -0700
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
Subject: [PATCH 3/7] perf/x86/intel/uncore: Keep PCI PMUs working when MMIO/MSR setup fails
Date: Tue, 12 May 2026 16:30:44 -0700
Message-ID: <20260512233048.9577-4-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512233048.9577-1-zide.chen@intel.com>
References: <20260512233048.9577-1-zide.chen@intel.com>
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
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/uncore.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 012a7e081014..8d5170788af2 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1632,8 +1632,6 @@ static int uncore_event_cpu_online(unsigned int cpu)
 	die = topology_logical_die_id(cpu);
 	msr_ret = uncore_box_ref(uncore_msr_uncores, die, cpu);
 	mmio_ret = uncore_box_ref(uncore_mmio_uncores, die, cpu);
-	if (msr_ret && mmio_ret)
-		return -ENOMEM;
 
 	/*
 	 * Check if there is an online cpu in the package
-- 
2.54.0

