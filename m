Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0AB21507F;
	Mon,  7 Jul 2025 20:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751919527; cv=none; b=TgmsNihrkG6PrpEMvHsahUlu3udfWBh+bDKWK2LAaR2xUTYOrgV8RmmxhWU1EFhUIuARayf3vo9I5XEi/6XDUaD/IOjrcB01W6NXnJjRUChsAUDVvPK44UvpDcgxsC6X0iIhB+BFW/OThwMxWgCJq+lvxvi1nTouYhVKIBjYF+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751919527; c=relaxed/simple;
	bh=Tn6v3UPbVoyPyh7UO946RFT7Ewk6J0+oBiv59RBuMqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=seXz8qXDaaM57EDM1qqouKuUSXt8Rf1+G3izNAX3iofb4s/hhf8/j382WDVXYbeVe9pSYNEY2X7OrdKa21n2CPnp0sIvt+oDoPjeba7X5jkLZ+PrGv1r6dlaahLtF3crjuNbVy8O+zjKdV2wt7F5OUI6UOwr3YroqTM4l7lV5JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DZb6B9xj; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DZb6B9xj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751919525; x=1783455525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tn6v3UPbVoyPyh7UO946RFT7Ewk6J0+oBiv59RBuMqM=;
  b=DZb6B9xjo8a6a3vUGZu+pTHVWzRriEDqivt9qdq3Pjrk8/873Z5du/AS
   V/0LSQUF2uDzmpKbe3L8Ta6T9OcVrYCfQkjdNcLmttHoa1lT29ulfHSbN
   uoptmISt6cnED85a0bHXWhW4XZFJtqZfNBO1aL/Gu6dbJHvsYtz2QQUC3
   3jct156dnjRWHD7ngDJ8rURGFvmuk8jK+25MnSrZ30P1kQ9ta8bRy+vAv
   ghIWp57STDqRxsHAuiE2uMY6iadqNy0GZbzgxULk0GWifI4YiiFcBuqXd
   sInM5NYUgGwkSaBh47AVnJ5xWqu9S0AgoADOJyRo8UQ6Sn/JTTVzArTK1
   A==;
X-CSE-ConnectionGUID: 6RmxwCpbTliIrk/Xf+1Riw==
X-CSE-MsgGUID: nJbdArKxSjanxFu8zBh91w==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53362311"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="53362311"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 13:18:44 -0700
X-CSE-ConnectionGUID: UnWDz/KEQjeEIkRKKGPRIQ==
X-CSE-MsgGUID: OBCcFeLwQUWZHXHn7fN0LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="159343671"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa003.fm.intel.com with ESMTP; 07 Jul 2025 13:18:44 -0700
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
Subject: [PATCH V4 1/4] perf/x86/intel/uncore: Support MSR portal for discovery tables
Date: Mon,  7 Jul 2025 13:17:47 -0700
Message-Id: <20250707201750.616527-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250707201750.616527-1-kan.liang@linux.intel.com>
References: <20250707201750.616527-1-kan.liang@linux.intel.com>
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

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
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
+	die_mask = kcalloc(BITS_TO_LONGS(uncore_max_dies()),
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

