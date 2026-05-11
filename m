Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350C336A356;
	Mon, 11 May 2026 23:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778541250; cv=none; b=m+F6XeISU0ltosG03AHbNzT+IKe3DuEMd/3W1+9clMY5Atf359U8MUzQwiOptxEBNVODy6lLZ+HikZfVrqyHpTtiFJI/qJCVBpT0yY5fC1mImsSQeUKeFvbixG0GGcz5Y++zRnLEKbzS8x5LNlT30EvyX0OsM21gOwD8cd+bYww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778541250; c=relaxed/simple;
	bh=5xsbsDWlZ6I8HZ4kEjVCQW8NW3N0yezwk9AzTyuzZs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jISK4kYHsOBdCpHllkzkZDfpYkJkGlb8ypsJRHlJDF1VWKplI/m4Gxmam+WuY/w91W74xzPMhYWu10sH3mPUc2BdzBHffFDgmJAlD+361xH4UtSz5eLCPM23Hw+odeg+UmS0+MMm4ImOqKWBV06saBj+uSMCZF3Oz+V/2SEX1Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ss1JTVHR; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ss1JTVHR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778541249; x=1810077249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5xsbsDWlZ6I8HZ4kEjVCQW8NW3N0yezwk9AzTyuzZs4=;
  b=Ss1JTVHRgZwffEb9YzNXg1jkjFeeL9U3igysWD770rUskAz2M7garpuh
   wShLYR17iCPzE1FF6/prL+j5WWRJaLRnXJlx917UZcGZKKR1okWVzcZR9
   kyv/25s+ZgkhHJLII73QKWFWrh09ZajoDHyhXQL+3EYRmqL7Q01z5g0iz
   Ab2okwlQ2p8EEQYmo32bKX+xaA8rIAZeYzjyIZHuZP8PJ7xfCVsEdKWQ5
   gbZ3aRkDZhs5iqX9kp8/YL7Lyd8Nv5xlewGbI+HAT4dI3LQGi0XerYXx6
   Jn4Fzy4C9klWwl7zn0m3YX95+LPHqLebcI6Bb0iJBqElepLWzOu6cryQ9
   g==;
X-CSE-ConnectionGUID: TLWKMW+JRK+BkKveusCsZQ==
X-CSE-MsgGUID: jXqVaXHrQbabFk45gXjpxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83058127"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="83058127"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 16:14:06 -0700
X-CSE-ConnectionGUID: 3Hrp0N2qTGWdCGw9REqKJA==
X-CSE-MsgGUID: TgpL50mkRF2gu0qc5oEKsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="267944471"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 16:14:06 -0700
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
Subject: [PATCH 6/6] perf/x86/intel/uncore: Implement global init callback for GNR uncore
Date: Mon, 11 May 2026 16:05:27 -0700
Message-ID: <20260511230527.26096-7-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511230527.26096-1-zide.chen@intel.com>
References: <20260511230527.26096-1-zide.chen@intel.com>
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
 arch/x86/events/intel/uncore.c           | 14 +++++++++++++-
 arch/x86/events/intel/uncore.h           |  2 +-
 arch/x86/events/intel/uncore_discovery.c |  2 +-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 19056514b081..a7780c5cd419 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1716,7 +1716,7 @@ static int __init uncore_mmio_init(void)
 	return ret;
 }
 
-static int uncore_mmio_global_init(u64 ctl)
+static int uncore_mmio_global_init(int die, u64 ctl)
 {
 	void __iomem *io_addr;
 
@@ -1731,6 +1731,17 @@ static int uncore_mmio_global_init(u64 ctl)
 	return 0;
 }
 
+static int uncore_msr_global_init(int die, u64 msr)
+{
+	int cpu = uncore_die_to_cpu(die);
+
+	if (cpu == -1)
+		return -ENODEV;
+
+	wrmsrq_on_cpu(cpu, msr, 0);
+	return 0;
+}
+
 static const struct uncore_plat_init nhm_uncore_init __initconst = {
 	.cpu_init = nhm_uncore_cpu_init,
 };
@@ -1871,6 +1882,7 @@ static const struct uncore_plat_init gnr_uncore_init __initconst = {
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
index 1d22d7c00ee0..49183d607a34 100644
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

