Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F582FDC35;
	Tue, 13 Jan 2026 21:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768338255; cv=none; b=daSvoZPOY6Cgq+XG2kBs54zszAZT4qMDGXkkLJpc8yQOBBBs/j4s5TabwDSEenOY9H6RTsv1SCCmTL+ynwkFaAdSFKLa3OcAhAGkuPGctsWUyC8Rz7hssYeS6FowC4MshnqpUMIDdTI0++7/v2jqkc/5sDA1grUADBMcfesdvgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768338255; c=relaxed/simple;
	bh=Vdd5MtZoev3W/PQhlxfg2nl3vOBD2tpy/CCKjvCu8uY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ng8209zYuqDH7P/9jv+IQtPZbSNEsOHgf+YddTldY1rKvNXJ31Y0yQKAU7hLjoCnpJRJgvuDKfJUf6fL3QzdgyBKomqGRDvTob8e3KL6qn6yYPpsqXAcbw73gMSVNP4bDFlZYG2gSw0GR6l96xoCXMsMAPmcu20O5uSv7zUuHTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CmJqvnWB; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CmJqvnWB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768338253; x=1799874253;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Vdd5MtZoev3W/PQhlxfg2nl3vOBD2tpy/CCKjvCu8uY=;
  b=CmJqvnWBAzCOVfKE8M/x7nIanphy7uu/pQLrnyw7QLYjrY+WkeeoE8Id
   Lcv08tzTjbPlQfLqZOGtUBcIbgKzRudilcFozusfG9Sxvczsu+kaUQOJB
   KfCPNcZVHioV0Say5Tao7I49X8KRjTA/r1EMfIXFXGZcVPNLG3g734G/J
   ItgdBAN4eNA8J0T985LIfQKE75BYpN1zjPYu5o33l2rr52cExvgia8Uy3
   QCd/oNuSe64ir/ooW02IzdFBbnzLI285VK5/QUiTV8VdcVOxfjZxd/pcR
   +4OY85UidcFtPo1+QdOM9h9gmIBdtEEI1g3xF6qcgkkHFNVE4/uzm/Fuv
   w==;
X-CSE-ConnectionGUID: rTmdyxCbRBOO6d4D8ZcFHw==
X-CSE-MsgGUID: Vcsc3E+CS7GGH13hM6hXHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69715183"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69715183"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 13:04:08 -0800
X-CSE-ConnectionGUID: fxeUT5iLTRGzP2x7MxD0YA==
X-CSE-MsgGUID: 8qUm1FLMTkm3UAjwkp0G7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="242015180"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 13:04:03 -0800
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
Subject: [PATCH V2 1/2] perf/x86/intel/uncore: Skip discovery table for offline dies
Date: Tue, 13 Jan 2026 12:56:49 -0800
Message-ID: <20260113205650.5201-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
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
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2:
- Add the Tested-by tag
- Rebase onto perf/core (base commit: a491c02c2770)

 arch/x86/events/intel/uncore.c           | 4 ++++
 arch/x86/events/intel/uncore_discovery.c | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 4684649109d9..c126a29ab729 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1368,6 +1368,10 @@ static void uncore_pci_pmus_register(void)
 
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
index b46575254dbe..0e414cecb6f2 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -366,7 +366,7 @@ static bool uncore_discovery_pci(struct uncore_discovery_domain *domain)
 				     (val & UNCORE_DISCOVERY_DVSEC2_BIR_MASK) * UNCORE_DISCOVERY_BIR_STEP;
 
 			die = get_device_die_id(dev);
-			if (die < 0)
+			if ((die < 0) || (die >= uncore_max_dies()))
 				continue;
 
 			parse_discovery_table(domain, dev, die, bar_offset, &parsed);
-- 
2.52.0

