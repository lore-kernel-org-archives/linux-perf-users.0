Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A827030F80C;
	Wed, 31 Dec 2025 22:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767221385; cv=none; b=lBkdDA/uhhuwD858v8t2ET3nu3XHWckzd2MbOJkTZmSHADfou686sbVz6QvaaQ5QB8Erub9HSk3/MHvzt4Ry0PYs/GtqnWZcZAAZYQek50CyZ+hRrmZXj2E4u9XX8kbcUHB+IuRAA0WtK2kCN0dLRyId+GfYD4FqQI+1bw6Pi5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767221385; c=relaxed/simple;
	bh=jJCMxMQLLv+BZaZAsbpgVqlYGqgbhe3Qe0ioM2aG2Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWhyMXz24R+5iH7Z4yrLZUO9DaE8YXmr/UpN2zHiME0o4xnFZtHFgk5urwD4IqZBNRtWWyUjEwoB8hvsHUz4qIp6tyV7mW9Msx5tfDG5nfumBY+D3ghVW2M0Eue9ytoanQHFiS2/MJ4lOT1WU6/FKB3b3efgPf5xXxu784G0NBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WWEgaoD3; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WWEgaoD3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767221384; x=1798757384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jJCMxMQLLv+BZaZAsbpgVqlYGqgbhe3Qe0ioM2aG2Ww=;
  b=WWEgaoD3LRwiTjSI07pgQxYA6UfHWBdreiZtUR1lfTZJZWMRZGIuDSjB
   LqEbum7WL5LYzWaV0+caFLRoEwSm+QqC6OxTHnURMcmBx8jlB87cenr4w
   fevsBhL4LE5o1n3eq+RzbUXX2CCn6T9/k0jGAKbr8jmK0wyB0M9Lbf9X8
   gQY5t8s7lRScBJZQ9Ba09cwZAmfKtj2k9flX1UXMMyPNiaBS5+9nxf3KP
   K3rvlKYv0nyzbgFdkKxx/RHXN8Hyev8KMzrSp5hltZ1qk1JJ9q5VmEm5f
   3hAc3+Aljkv/T4QU8KKGo1T5dEw7N2vjD4p+6MCuvLIXHJ4x6UjKj/nO+
   w==;
X-CSE-ConnectionGUID: kJ6p4xB5R7eAe/8VhRTlrA==
X-CSE-MsgGUID: cqeepYqyTMCum0Oqe9phfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11658"; a="68816629"
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="68816629"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 14:49:41 -0800
X-CSE-ConnectionGUID: KvW9KyX2RRylRnmqhJ/lQg==
X-CSE-MsgGUID: gZVMNUD+SmiYe/cIt+HZ/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="232611019"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 14:49:41 -0800
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
	Falcon Thomas <thomas.falcon@intel.com>
Subject: [PATCH V2 06/13] perf/x86/intel/uncore: Add domain global init callback
Date: Wed, 31 Dec 2025 14:42:23 -0800
Message-ID: <20251231224233.113839-7-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251231224233.113839-1-zide.chen@intel.com>
References: <20251231224233.113839-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the Intel uncore self-describing mechanism, the Global Control
Register freeze_all bit is SoC-wide and propagates to all uncore PMUs.

On Diamond Rapids, this bit is set at power-on, unlike some prior
platforms.  Add a global_init callback to unfreeze all PMON units.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2: New patch

 arch/x86/events/intel/uncore.c           | 16 ++++++++++++++++
 arch/x86/events/intel/uncore.h           |  2 ++
 arch/x86/events/intel/uncore_discovery.c |  3 +++
 3 files changed, 21 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 1565c0418fb1..080b6870a88d 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1697,6 +1697,21 @@ static int __init uncore_mmio_init(void)
 	return ret;
 }
 
+static int uncore_mmio_global_init(u64 ctl)
+{
+	void __iomem *io_addr;
+
+	io_addr = ioremap(ctl, sizeof(ctl));
+	if (!io_addr)
+		return -ENOMEM;
+
+	/* Clear bit 0, all other bits are reserved */
+	writel(0, io_addr);
+
+	iounmap(io_addr);
+	return 0;
+}
+
 static const struct uncore_plat_init nhm_uncore_init __initconst = {
 	.cpu_init = nhm_uncore_cpu_init,
 };
@@ -1839,6 +1854,7 @@ static const struct uncore_plat_init dmr_uncore_init __initconst = {
 	.domain[0].units_ignore = dmr_uncore_imh_units_ignore,
 	.domain[1].discovery_base = CBB_UNCORE_DISCOVERY_MSR,
 	.domain[1].units_ignore = dmr_uncore_cbb_units_ignore,
+	.domain[1].global_init = uncore_mmio_global_init,
 };
 
 static const struct uncore_plat_init generic_uncore_init __initconst = {
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 83d01a9cefc0..55e3aebf4b5e 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -51,6 +51,8 @@ struct uncore_discovery_domain {
 	/* MSR address or PCI device used as the discovery base */
 	u32	discovery_base;
 	bool	base_is_pci;
+	int	(*global_init)(u64 ctl);
+
 	/* The units in the discovery table should be ignored. */
 	int	*units_ignore;
 };
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 6f409e0b4722..3a5a3876b74c 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -286,6 +286,9 @@ static int __parse_discovery_table(struct uncore_discovery_domain *domain,
 	if (!io_addr)
 		return -ENOMEM;
 
+	if (domain->global_init && domain->global_init(global.ctl))
+		return -ENODEV;
+
 	/* Parsing Unit Discovery State */
 	for (i = 0; i < global.max_units; i++) {
 		memcpy_fromio(&unit, io_addr + (i + 1) * (global.stride * 8),
-- 
2.52.0

