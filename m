Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D4F1804A;
	Thu,  3 Jul 2025 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751561820; cv=none; b=Lg2DbvBHh4APXxwK1pf9HZnC2TuV+90QtcjUmgJUBRKS2J6mq1cMceNdcRNJxvKh0yQCsjvitlGuS8iJDpiqsc6aQBtoJv8Pc+PTpjecbhNaCUcy/gWnGR3cGosOm4LUgc6uYNoJZ4gJFZ2W6EpAoXzfUP7yeBLzTjWH62Ik8Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751561820; c=relaxed/simple;
	bh=uBcn1BpOS8GFy7hLHtWB4E5Wau2mNkdI54PtiyFcWU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rbW1wIR5Y5NiCRpFP2Q9OtUE4/ugwgwnSwL+SMMjJpBtoAcZMGxmajDlQouad0R/v+PwHBabfmkVRF1qO4cArOvAJXGAgc0L6uw+zl9jALePOEfh64qeLqOoZ1ozHRJXNvhty3DtgALgtaLCTzmyvUMWB/NJtDTjDwTvyxrr2g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NGkIbJ7g; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGkIbJ7g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751561818; x=1783097818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uBcn1BpOS8GFy7hLHtWB4E5Wau2mNkdI54PtiyFcWU4=;
  b=NGkIbJ7gR5Kk3yXz1Yvn5A/i/i1PwQJIkvzirXmdWi+LGCW9/Y5nyRBE
   XLgyPeKNLxFgrNPg+AG3QDgWlm1Z4DNOpR+9SCzXHCkIIHZ/qItRiDHqh
   84J39k19bOuFfzTvFmnRSQ2wkeBVqfujXWkDmN0Na19r8VpPIKDk4oefd
   io9etbt8nic8l23w+N0aPXZZxsZTgGaFAA+QDxSFtJ05wgIR1KBtU6x7B
   0jhP/9x5YSDFmoefnIPHFv9IjckTc9blGDUcDzQzAUEfF+FS4jv2HgTU+
   lrU0CoOD5ObvOKTRIxI+Tz/YmXP8jCboBHDYGlgKHO+S00E1VENvrs9LU
   g==;
X-CSE-ConnectionGUID: JFH6qw+LReWwY/TyJlEeGQ==
X-CSE-MsgGUID: 8eIU9ZdvRtqMv0oxoc49+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53992508"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="53992508"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 09:56:54 -0700
X-CSE-ConnectionGUID: UvBUMJKeQnuZ8kkh5wiU5w==
X-CSE-MsgGUID: D5CDvX58SlG6dej/dxK7KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="154554261"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa007.jf.intel.com with ESMTP; 03 Jul 2025 09:56:53 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: dapeng1.mi@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 1/4] perf/x86/intel/uncore: Support MSR portal for discovery tables
Date: Thu,  3 Jul 2025 09:56:11 -0700
Message-Id: <20250703165614.606446-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250703165614.606446-1-kan.liang@linux.intel.com>
References: <20250703165614.606446-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Starting from the Panther Lake, the discovery table mechanism is also
supported in client platforms. The difference is that the portal of the
global discovery table is retrieved from an MSR.

The layout of discovery tables are the same as the server platforms.
Factor out __parse_discovery_table() to parse discover tables.

The uncore PMON is Die scope. Need to parse the discovery tables for
each die.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_discovery.c | 87 ++++++++++++++++++------
 arch/x86/events/intel/uncore_discovery.h |  3 +
 2 files changed, 70 insertions(+), 20 deletions(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 571e44b49691..8680f66c3e34 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -273,32 +273,15 @@ uncore_ignore_unit(struct uncore_unit_discovery *unit, int *ignore)
 	return false;
 }
 
-static int parse_discovery_table(struct pci_dev *dev, int die,
-				 u32 bar_offset, bool *parsed,
-				 int *ignore)
+static int __parse_discovery_table(resource_size_t addr, int die,
+				   bool *parsed, int *ignore)
 {
 	struct uncore_global_discovery global;
 	struct uncore_unit_discovery unit;
 	void __iomem *io_addr;
-	resource_size_t addr;
 	unsigned long size;
-	u32 val;
 	int i;
 
-	pci_read_config_dword(dev, bar_offset, &val);
-
-	if (val & ~PCI_BASE_ADDRESS_MEM_MASK & ~PCI_BASE_ADDRESS_MEM_TYPE_64)
-		return -EINVAL;
-
-	addr = (resource_size_t)(val & PCI_BASE_ADDRESS_MEM_MASK);
-#ifdef CONFIG_PHYS_ADDR_T_64BIT
-	if ((val & PCI_BASE_ADDRESS_MEM_TYPE_MASK) == PCI_BASE_ADDRESS_MEM_TYPE_64) {
-		u32 val2;
-
-		pci_read_config_dword(dev, bar_offset + 4, &val2);
-		addr |= ((resource_size_t)val2) << 32;
-	}
-#endif
 	size = UNCORE_DISCOVERY_GLOBAL_MAP_SIZE;
 	io_addr = ioremap(addr, size);
 	if (!io_addr)
@@ -341,7 +324,32 @@ static int parse_discovery_table(struct pci_dev *dev, int die,
 	return 0;
 }
 
-bool intel_uncore_has_discovery_tables(int *ignore)
+static int parse_discovery_table(struct pci_dev *dev, int die,
+				 u32 bar_offset, bool *parsed,
+				 int *ignore)
+{
+	resource_size_t addr;
+	u32 val;
+
+	pci_read_config_dword(dev, bar_offset, &val);
+
+	if (val & ~PCI_BASE_ADDRESS_MEM_MASK & ~PCI_BASE_ADDRESS_MEM_TYPE_64)
+		return -EINVAL;
+
+	addr = (resource_size_t)(val & PCI_BASE_ADDRESS_MEM_MASK);
+#ifdef CONFIG_PHYS_ADDR_T_64BIT
+	if ((val & PCI_BASE_ADDRESS_MEM_TYPE_MASK) == PCI_BASE_ADDRESS_MEM_TYPE_64) {
+		u32 val2;
+
+		pci_read_config_dword(dev, bar_offset + 4, &val2);
+		addr |= ((resource_size_t)val2) << 32;
+	}
+#endif
+
+	return __parse_discovery_table(addr, die, parsed, ignore);
+}
+
+static bool intel_uncore_has_discovery_tables_pci(int *ignore)
 {
 	u32 device, val, entry_id, bar_offset;
 	int die, dvsec = 0, ret = true;
@@ -390,6 +398,45 @@ bool intel_uncore_has_discovery_tables(int *ignore)
 	return ret;
 }
 
+static bool intel_uncore_has_discovery_tables_msr(int *ignore)
+{
+	unsigned long *die_mask;
+	bool parsed = false;
+	int cpu, die;
+	u64 base;
+
+	die_mask = kcalloc(BITS_TO_LONGS(__uncore_max_dies),
+			   sizeof(unsigned long), GFP_KERNEL);
+	if (!die_mask)
+		return false;
+
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		die = topology_logical_die_id(cpu);
+		if (__test_and_set_bit(die, die_mask))
+			continue;
+
+		if (rdmsrq_safe_on_cpu(cpu, UNCORE_DISCOVERY_MSR, &base))
+			continue;
+
+		if (!base)
+			continue;
+
+		__parse_discovery_table(base, die, &parsed, ignore);
+	}
+
+	cpus_read_unlock();
+
+	kfree(die_mask);
+	return parsed;
+}
+
+bool intel_uncore_has_discovery_tables(int *ignore)
+{
+	return intel_uncore_has_discovery_tables_msr(ignore) ||
+	       intel_uncore_has_discovery_tables_pci(ignore);
+}
+
 void intel_uncore_clear_discovery_tables(void)
 {
 	struct intel_uncore_discovery_type *type, *next;
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 0e94aa7db8e7..690f737e6837 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -1,5 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 
+/* Store the full address of the global discovery table */
+#define UNCORE_DISCOVERY_MSR			0x201e
+
 /* Generic device ID of a discovery table device */
 #define UNCORE_DISCOVERY_TABLE_DEVICE		0x09a7
 /* Capability ID for a discovery table device */
-- 
2.38.1

