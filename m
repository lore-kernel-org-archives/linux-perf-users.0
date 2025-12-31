Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFA030AAD0;
	Wed, 31 Dec 2025 22:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767221383; cv=none; b=huS+4AuaqCVJX1vWSWO619T2049YSRvSdEkpwQAtuZ4JcDKwUJ0ys09Kir/5GsrCJGZi3gT085WCGCOVFNbdBkDX4xev21fBavoZc62NyS5580T3vkxAmV2kBPBXp2EPhxKhVtkE4GKdgxNUnZiV2hivI+BpXGt3LgHRpBCMcNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767221383; c=relaxed/simple;
	bh=KJF1vRQDE8zP+o1i8Ro1cmoCPzm4HkDZnytK7qXe1eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0xCrUkTa9SPn8193GUdvF6GO81Gd5VF0E3XSzm2rnKouQ7D+2cA3vw3OgFCYyW7+2GhTu8xXdaoS+yU3BpDvQXYWQLdD2WGg2bYBbxKExdRXJIuftOh+EzKS+ODW3KYguxR4C8fxswFuSiDcLQ5Dqna1eqG29VsF0/u3GE65KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eci/jZjS; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eci/jZjS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767221382; x=1798757382;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KJF1vRQDE8zP+o1i8Ro1cmoCPzm4HkDZnytK7qXe1eo=;
  b=eci/jZjSAB0BrRB1JhaRjR6UTLKIEb5HcFblVe0/MV/xp8cpxMrtW3qN
   FpGGdcxmUvpKZKoa/xEWQQn0xP3ZozVhfPw0TcA+AGgCLkUvZuJolKG2U
   H1m9ShwOEe6T8P9T1tZp/lexx0H6MOT/WRx6L8kACzAKKODg3zxOukXEM
   oHsJFA3e9gd96PPdCTFgyfMAlIGWGnfbYEpFOKb0KXRVEWg91lJpcb56i
   ndqQrt0o3XOz35DciYk4T/zVULnYOeJvTt6jvE7JLtpRSBX+W2T54ZUdq
   9vK51iO3L3LOuBcqleCAVcvHkBM5EG0nRPGZ/k1W9H/lu8aRQI73A6OYv
   A==;
X-CSE-ConnectionGUID: sCrhpDNNRiSsq1jUOt1R3Q==
X-CSE-MsgGUID: CxlX50w1Sz+rEDe/IeOFlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11658"; a="68816613"
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="68816613"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 14:49:40 -0800
X-CSE-ConnectionGUID: B2SNRGcJTuy7CmFrNOMjwQ==
X-CSE-MsgGUID: NhxRp2JgRXSbj68C3i8LfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="232611010"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 14:49:40 -0800
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
Subject: [PATCH V2 03/13] perf/x86/intel/uncore: Remove has_generic_discovery_table()
Date: Wed, 31 Dec 2025 14:42:20 -0800
Message-ID: <20251231224233.113839-4-zide.chen@intel.com>
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

In the !x86_match_cpu() fallback path, has_generic_discovery_table()
is removed because it does not handle multiple PCI devices.  Instead,
use PCI_ANY_ID in generic_uncore_init[] to probe all PCI devices.

For MSR portals, only probe MSR 0x201e to keep the fallback simple, as
this path is best-effort only.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2: Separate patch from [PATCH V1 1/7]
- Move has_generic_discovery_table() related code to its own patch for
  easier review.

 arch/x86/events/intel/uncore.c           |  3 ++
 arch/x86/events/intel/uncore_discovery.c | 42 +++++-------------------
 2 files changed, 12 insertions(+), 33 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 844030ef87c4..2a1c6dce8a35 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1835,6 +1835,9 @@ static const struct uncore_plat_init generic_uncore_init __initconst = {
 	.cpu_init = intel_uncore_generic_uncore_cpu_init,
 	.pci_init = intel_uncore_generic_uncore_pci_init,
 	.mmio_init = intel_uncore_generic_uncore_mmio_init,
+	.domain[0].base_is_pci = true,
+	.domain[0].discovery_base = PCI_ANY_ID,
+	.domain[1].discovery_base = UNCORE_DISCOVERY_MSR,
 };
 
 static const struct x86_cpu_id intel_uncore_match[] __initconst = {
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 3bcbf974d3a8..6f409e0b4722 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -12,24 +12,6 @@
 static struct rb_root discovery_tables = RB_ROOT;
 static int num_discovered_types[UNCORE_ACCESS_MAX];
 
-static bool has_generic_discovery_table(void)
-{
-	struct pci_dev *dev;
-	int dvsec;
-
-	dev = pci_get_device(PCI_VENDOR_ID_INTEL, UNCORE_DISCOVERY_TABLE_DEVICE, NULL);
-	if (!dev)
-		return false;
-
-	/* A discovery table device has the unique capability ID. */
-	dvsec = pci_find_next_ext_capability(dev, 0, UNCORE_EXT_CAP_ID_DISCOVERY);
-	pci_dev_put(dev);
-	if (dvsec)
-		return true;
-
-	return false;
-}
-
 static int logical_die_id;
 
 static int get_device_die_id(struct pci_dev *dev)
@@ -358,12 +340,7 @@ static bool uncore_discovery_pci(struct uncore_discovery_domain *domain)
 	struct pci_dev *dev = NULL;
 	bool parsed = false;
 
-	if (domain->discovery_base)
-		device = domain->discovery_base;
-	else if (has_generic_discovery_table())
-		device = UNCORE_DISCOVERY_TABLE_DEVICE;
-	else
-		device = PCI_ANY_ID;
+	device = domain->discovery_base;
 
 	/*
 	 * Start a new search and iterates through the list of
@@ -406,7 +383,7 @@ static bool uncore_discovery_msr(struct uncore_discovery_domain *domain)
 {
 	unsigned long *die_mask;
 	bool parsed = false;
-	int cpu, die, msr;
+	int cpu, die;
 	u64 base;
 
 	die_mask = kcalloc(BITS_TO_LONGS(uncore_max_dies()),
@@ -414,16 +391,13 @@ static bool uncore_discovery_msr(struct uncore_discovery_domain *domain)
 	if (!die_mask)
 		return false;
 
-	msr = domain->discovery_base ?
-	      domain->discovery_base : UNCORE_DISCOVERY_MSR;
-
 	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		die = topology_logical_die_id(cpu);
 		if (__test_and_set_bit(die, die_mask))
 			continue;
 
-		if (rdmsrq_safe_on_cpu(cpu, msr, &base))
+		if (rdmsrq_safe_on_cpu(cpu, domain->discovery_base, &base))
 			continue;
 
 		if (!base)
@@ -446,10 +420,12 @@ bool uncore_discovery(struct uncore_plat_init *init)
 
 	for (i = 0; i < UNCORE_DISCOVERY_DOMAINS; i++) {
 		domain = &init->domain[i];
-		if (!domain->base_is_pci)
-			ret |= uncore_discovery_msr(domain);
-		else
-			ret |= uncore_discovery_pci(domain);
+		if (domain->discovery_base) {
+			if (!domain->base_is_pci)
+				ret |= uncore_discovery_msr(domain);
+			else
+				ret |= uncore_discovery_pci(domain);
+		}
 	}
 
 	return ret;
-- 
2.52.0

