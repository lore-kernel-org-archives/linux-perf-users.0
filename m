Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78033ADBA1;
	Tue,  2 Jun 2026 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412280; cv=none; b=Rb/DmujDH3Wty7VIQlaqD1rkgy8mHvDFAu7ENo1SKWrFyUyULrPXHPmR79xt3e8RZdAeoH7dbGoM9+s93K2ndKsJeH6gSJNqoB7S9uyk0Z9n3Tnmea8nn+UobNptzsUGNJn0CCqrQhVjN0Yg83bfbr0xxIiMyzS56OYUQKWCznU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412280; c=relaxed/simple;
	bh=t8sLVpDPiIPpyReJJrwUTutLLJUtDGmVsRFhv/+FSRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJwEOFA1le7NBq88OwgG6lUSpKF6Wxt+XfPM8ltp/tc/fLEYHaQZTQ1dRvRxLL9tJewdLhZsINHV2iGeXQKbyGdwDAC6C5y2wkOmrlFtxDbP0NqzRDFqtYALjJw5NK5aZ/NQdfZH2PMJBYGsaLturTfnjGjwZhmXMZjPNLxOPdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d1zSujA4; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d1zSujA4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780412279; x=1811948279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t8sLVpDPiIPpyReJJrwUTutLLJUtDGmVsRFhv/+FSRw=;
  b=d1zSujA4fqXJ89a/qyM8Ks3KTJEGs/09+HxMK2JDLxuU5XPIDfp0EQet
   DjodRs1XdFKmHO3i6JKMCYXTXRnfmR2BapQTin0wy4ecSAYEEt91yqLat
   QXeJoU3au0JJCNOvr5XjltpjR/JbGepNIIuFOfLB2sBU2r3+QqzNDWAw0
   2jI3oWr422L5B1uspcrqFwCbzfm1LVGsiYRtQWB20igpP5yRl5PrG5+nf
   Jor3amO+uRXENnmdgqXSKOuCiQsgffgKB05VTDwggUprXKbpLwOOEBB84
   kQ70+9JMnMGmmcaQq11osrAEN5FP1Kc2iq1U6t/ehu2hXADP7rST5P7RR
   w==;
X-CSE-ConnectionGUID: 25IXK1j7ThWjJnmtWk1ROw==
X-CSE-MsgGUID: nqD/PM8aSjy+/hE2TKalcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="103860013"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="103860013"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 07:57:55 -0700
X-CSE-ConnectionGUID: 0fICFr3uT7WBLmha37HWIg==
X-CSE-MsgGUID: M7q5P1/zR3etKZAFtVQ0cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="243095636"
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
Subject: [PATCH V3 7/7] perf/x86/intel/uncore: Implement global init callback for GNR uncore
Date: Tue,  2 Jun 2026 07:49:08 -0700
Message-ID: <20260602144908.263680-8-zide.chen@intel.com>
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

On Sierra Forest and Clearwater Forest, the FRZ_ALL bit in the global
control register defaults to 0 at boot, but UBOX PMON units do not
work until the global control register is explicitly written with 0
to trigger hardware initialization properly.

Implement the generic uncore_msr_global_init() callback and add it to
gnr_uncore_init[], which is shared by GNR, GRR, SRF, and CWF.

Fixes: 632c4bf6d007 ("perf/x86/intel/uncore: Support Granite Rapids")
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v3:
- Guard uncore_discovery_pci() with cpus_read_lock() to fix a
  theoretical race where CPUs could go offline between
  uncore_die_to_cpu() and wrmsrq_on_cpu(). (Sashiko)
- Add Fixes tag. (Dapeng)
v2:
- Propagate return value of wrmsrq_on_cpu() to global_init().
---
 arch/x86/events/intel/uncore.c           | 13 ++++++++++++-
 arch/x86/events/intel/uncore.h           |  2 +-
 arch/x86/events/intel/uncore_discovery.c |  9 +++++----
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 4b3a1fa5b41b..7857959c6e82 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1716,7 +1716,7 @@ static int __init uncore_mmio_init(void)
 	return ret;
 }
 
-static int uncore_mmio_global_init(u64 ctl)
+static int uncore_mmio_global_init(int die, u64 ctl)
 {
 	void __iomem *io_addr;
 
@@ -1731,6 +1731,16 @@ static int uncore_mmio_global_init(u64 ctl)
 	return 0;
 }
 
+static int uncore_msr_global_init(int die, u64 msr)
+{
+	int cpu = uncore_die_to_cpu(die);
+
+	if (cpu == -1)
+		return -ENODEV;
+
+	return wrmsrq_on_cpu(cpu, msr, 0);
+}
+
 static const struct uncore_plat_init nhm_uncore_init __initconst = {
 	.cpu_init = nhm_uncore_cpu_init,
 };
@@ -1871,6 +1881,7 @@ static const struct uncore_plat_init gnr_uncore_init __initconst = {
 	.domain[0].base_is_pci = true,
 	.domain[0].discovery_base = UNCORE_DISCOVERY_TABLE_DEVICE,
 	.domain[0].units_ignore = gnr_uncore_units_ignore,
+	.domain[0].global_init = uncore_msr_global_init,
 };
 
 static const struct uncore_plat_init dmr_uncore_init __initconst = {
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 94c68e3417b6..c2e5ccb1d72c 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -53,7 +53,7 @@ struct uncore_discovery_domain {
 	/* MSR address or PCI device used as the discovery base */
 	u32	discovery_base;
 	bool	base_is_pci;
-	int	(*global_init)(u64 ctl);
+	int	(*global_init)(int die, u64 ctl);
 
 	/* The units in the discovery table should be ignored. */
 	int	*units_ignore;
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index af7e80fee81f..e50776222256 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -287,7 +287,7 @@ static int __parse_discovery_table(struct uncore_discovery_domain *domain,
 	if (!io_addr)
 		return -ENOMEM;
 
-	if (domain->global_init && domain->global_init(global.ctl)) {
+	if (domain->global_init && domain->global_init(die, global.ctl)) {
 		ret = -ENODEV;
 		goto out;
 	}
@@ -399,7 +399,6 @@ static bool uncore_discovery_msr(struct uncore_discovery_domain *domain)
 	if (!die_mask)
 		return false;
 
-	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		die = topology_logical_die_id(cpu);
 		if (__test_and_set_bit(die, die_mask))
@@ -414,8 +413,6 @@ static bool uncore_discovery_msr(struct uncore_discovery_domain *domain)
 		__parse_discovery_table(domain, base, die, &parsed);
 	}
 
-	cpus_read_unlock();
-
 	kfree(die_mask);
 	return parsed;
 }
@@ -429,10 +426,14 @@ bool uncore_discovery(struct uncore_plat_init *init)
 	for (i = 0; i < UNCORE_DISCOVERY_DOMAINS; i++) {
 		domain = &init->domain[i];
 		if (domain->discovery_base) {
+			cpus_read_lock();
+
 			if (!domain->base_is_pci)
 				ret |= uncore_discovery_msr(domain);
 			else
 				ret |= uncore_discovery_pci(domain);
+
+			cpus_read_unlock();
 		}
 	}
 
-- 
2.54.0

