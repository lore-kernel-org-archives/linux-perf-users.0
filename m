Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512EB423161;
	Wed, 27 May 2026 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779895238; cv=none; b=Pu2nlu/l8fVSGw4CeipWg8qGy1Bx94v34iq3cblc75WEmnc/VydLLp/3UQcdrpoGcWf0mKohmyL+antHbqhG+dG5jz4ZQnPNuKCl6X+kfCkFYOw3AQa7o2mHyCTD73Lx3Jyl5h3DUqxb9WyOeUcMLEzGPhI79qhZi9tgSAOWsIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779895238; c=relaxed/simple;
	bh=0MGgZsEcZWUPCVucsCaHJcvq2qbVXBiKYaWja+vf5WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdIAfjdtgKkImhH9aB23UFCdk8em4hwZQNc9E0KgT+7j1TGuSEVsVtBLx49Y8s5uC8NuLoRKdxiPrQjiKphT+epN8rPzTDv4m2v9z+379WLGu8QhHOTr1F0e6w0o60ePQN+CTuK08BY2q8UrmllFDM3TO8EnB5JZzfGK8kl+ewU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jM0GCeHG; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jM0GCeHG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779895236; x=1811431236;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0MGgZsEcZWUPCVucsCaHJcvq2qbVXBiKYaWja+vf5WE=;
  b=jM0GCeHGOcNEMEqHvyLCnNsBUj+N6kIvBd6Ao+u6v2mIpwIr+x/iNPWx
   uv+tgMjpRk2+rjXthadaKWrtBjLUwQhPvLVrOZQ5M9rGrfWv6jjaaswmf
   5FvOX2VylFywgdD9tawaLqE5nQCLAbwCzkZK7LLa6sILaEyXzv55RAtsM
   4GEyiw7V6l/Jv9Vu9ANuTKD7jdSG3/Bc3fzl/CQPXZBMvwd0bPd+YqDE1
   nld2/4yo0ERF2O9duwC6+NhM+LZoeTAWACR+a3D54ggPv9TCOGa4cnf1N
   pFM0+xad35uR8ZYfydK9X7lh17P5nUZHISRK+GKFf1lmbokfBLjbCl1uF
   A==;
X-CSE-ConnectionGUID: 0j2p/UcvRSWG1OxwIwqyFA==
X-CSE-MsgGUID: yFASoOtmQCO+CXVkd44sHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="98149335"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="98149335"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 08:20:32 -0700
X-CSE-ConnectionGUID: axOojIv9SH6S7RzR1VRQXQ==
X-CSE-MsgGUID: A73AD5ZZTfakH63RM6EPhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="241231408"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 08:20:32 -0700
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
Subject: [PATCH V2 7/7] perf/x86/intel/uncore: Implement global init callback for GNR uncore
Date: Wed, 27 May 2026 08:11:54 -0700
Message-ID: <20260527151154.130505-7-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527151154.130505-1-zide.chen@intel.com>
References: <20260527151154.130505-1-zide.chen@intel.com>
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

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2:
- Propagate return value of wrmsrq_on_cpu() to global_init().
---
 arch/x86/events/intel/uncore.c           | 13 ++++++++++++-
 arch/x86/events/intel/uncore.h           |  2 +-
 arch/x86/events/intel/uncore_discovery.c |  2 +-
 3 files changed, 14 insertions(+), 3 deletions(-)

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
index af2217b44a81..e36613d934b1 100644
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
-- 
2.54.0

