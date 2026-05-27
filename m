Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FAC42983F;
	Wed, 27 May 2026 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779895236; cv=none; b=NWaBm9i6HrNs0udvGcYbsFcHmD77+3AvBj+A/SJ5tasrB4fFfOG9Y8N6TDimuoVeQ+VgBthrC/nbzeD3k2/vqFYN++HnIQh7nu394YIDVBbyOodCEsuHIQegWVyA9DeR3ZPjwNSfZ4dq6WsSZ4Zx9Tu/EMHvtEzvGVvT/8Oy+3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779895236; c=relaxed/simple;
	bh=5mNvcymwY7WtOovsSfJviMgNVlP/OBDTe7MINr9Qjpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHVQcR6rsv4L26+PV7sar0kHhst/LBLYwVacNzi+ZgO4Nu+UOBVja158KxQd3orrj4KcMrF8Y278EM/tI1pMA83hm8fDin/uyg6S5RpbkUBJ9e2uQocaywyxwcAQLJkVyk5nxmeNQjeLP7PGXrOs9AcyeNw5NhXcnTsCjZdyRyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=StxjfBOk; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="StxjfBOk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779895235; x=1811431235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5mNvcymwY7WtOovsSfJviMgNVlP/OBDTe7MINr9Qjpg=;
  b=StxjfBOk+eQenOl3eZE+Bk97fs0cjwJ8lLeOVCGeeMJjHifOuokIAbf0
   7USIC5bfzEK5Dfd6biJ9ds5updqAJLkJGxR/tqJR5D52FOzaPDosBLauW
   CK7jvgqLoOZWChgJWZmALTdI005eUoTIs3xSxvDX1RnZKnhVHcv+GnA8v
   ne5p4ShVtg3PCxlresmYmhcKtwrEVs90MwsxFn9+CkgnLUPuKfn4oQ2ma
   zPDdDfdqWKAT63U60xrdjKglcvyMTZGbGp6CMthbESNE8dBOV5aiH2qDK
   IGt6njqhfMHNTXDJ6AqTvpI8s1J/Hu3BOxRfkBnZWpMcBpsnvW9tMbr/7
   Q==;
X-CSE-ConnectionGUID: bbGBM/P3TZODENDG9wEJ2g==
X-CSE-MsgGUID: X8+FkoX/Sk+LAaaigNDRcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="98149330"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="98149330"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 08:20:31 -0700
X-CSE-ConnectionGUID: 7HVlCkJKRVGOCInUZKVO7w==
X-CSE-MsgGUID: Q7QNGVCRQZWLOHHN1wlNNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="241231406"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 08:20:31 -0700
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
Subject: [PATCH V2 6/7] perf/x86/intel/uncore: Fix uncore_die_to_cpu() for offline dies
Date: Wed, 27 May 2026 08:11:53 -0700
Message-ID: <20260527151154.130505-6-zide.chen@intel.com>
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

If the die is offline when uncore_die_to_cpu() is called, it silently
returns 0, which is misleading.  Return -1 in this case to indicate
that all CPUs on the die are offline and the caller can take care of
it accordingly.

Opportunistically, replace -EPERM with -ENODEV, as -ENODEV is
the appropriate error when no CPUs are online across all dies.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/uncore.c       | 2 +-
 arch/x86/events/intel/uncore_snbep.c | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 22256ded2d67..4b3a1fa5b41b 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -91,7 +91,7 @@ int uncore_device_to_die(struct pci_dev *dev)
  */
 int uncore_die_to_cpu(int die)
 {
-	int res = 0, cpu;
+	int res = -1, cpu;
 
 	for_each_online_cpu(cpu) {
 		if (topology_logical_die_id(cpu) == die) {
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 772b78237424..334dc384b5b9 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3772,12 +3772,17 @@ static void pmu_free_topology(struct intel_uncore_type *type)
 static int skx_pmu_get_topology(struct intel_uncore_type *type,
 				 int (*topology_cb)(struct intel_uncore_type*, int, int, u64))
 {
-	int die, ret = -EPERM;
+	int die, ret = -ENODEV;
 	u64 cpu_bus_msr;
+	int cpu;
 
 	cpus_read_lock();
 	for (die = 0; die < uncore_max_dies(); die++) {
-		ret = skx_msr_cpu_bus_read(uncore_die_to_cpu(die), &cpu_bus_msr);
+		cpu = uncore_die_to_cpu(die);
+		if (cpu == -1)
+			continue;
+
+		ret = skx_msr_cpu_bus_read(cpu, &cpu_bus_msr);
 		if (ret)
 			break;
 
-- 
2.54.0

