Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4563E3167;
	Tue,  2 Jun 2026 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412281; cv=none; b=QUkm0ZSz0Akgq7MAGuvKAtBH3FuWSf8cxHc2hBPWtAPii7QSGIorgSgVVB2mbc+olv7kBt62rhUpx5vJC1K6p7CITts4lHreJj3YuskiJqgTjTt5+6SSO/nYi80IXuO2zCdMU/TXDGZJO9bXxCjTbz896HMZ1LFOJDjuTW8ho/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412281; c=relaxed/simple;
	bh=ZnxSh/9ZGh2K8pWuK32o2Emd20cX219PI4gfuom+5k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBWcf/xsQanysI/YX2sCmnOEMrDXX6HE1di43i24DTPmu+YDg3axn+UuDxvO6H7OxPLu3LdBb2HqAnrYPdYUXNN1xvCygwav6rcq8fynE7WXsWVC5+E3EqxyEjtyuNMY/apZfF53kNJz+xQNpe6LVr2F+Hn9kWuNpQDdQzrHLlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EzRJZwmt; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EzRJZwmt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780412280; x=1811948280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZnxSh/9ZGh2K8pWuK32o2Emd20cX219PI4gfuom+5k0=;
  b=EzRJZwmtyJLCbzWWA7fhsQZdjrOA3fKRLNOq9B5ukc0GCEnIWeihWY1B
   NnaU0DW5S89v3WflQvdlXagWourrvdXsJF2rG6leuORj/qqzdu28mxUk1
   b2gXIRSQ2YIUZy8ZkxC0PpdYe2+PwLFRo86spGtMyOPypViTTbmu4MNbW
   96iOHfQpiICLiuUjXwG6dD3ycByOhYLSgJwnY4n15WgaGpjBc3LWRywWU
   KHKx3RbpMgdqU/jQHbrK818249XxlyfcRywZ25YgPobA/WSidPgLnSAws
   z2X6vzQInhmtlcPHur0hjEs8YYSQskgN8EFF5Yd2n5Nv3+SZXZEdwV8c2
   g==;
X-CSE-ConnectionGUID: Kyeyz85UToqp2XsX8eCylQ==
X-CSE-MsgGUID: pdel5ZsJQxeoNsCNuiVrDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="103860008"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="103860008"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 07:57:55 -0700
X-CSE-ConnectionGUID: 93eGh5yHQAOAZBksmJbSFg==
X-CSE-MsgGUID: d/8yvD2hQamVwwoifV5qYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="243095634"
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
Subject: [PATCH V3 6/7] perf/x86/intel/uncore: Fix uncore_die_to_cpu() for offline dies
Date: Tue,  2 Jun 2026 07:49:07 -0700
Message-ID: <20260602144908.263680-7-zide.chen@intel.com>
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

If the die is offline when uncore_die_to_cpu() is called, it silently
returns 0, which is misleading.  Return -1 in this case to indicate
that all CPUs on the die are offline and the caller can take care of
it accordingly.

Opportunistically, replace -EPERM with -ENODEV, as -ENODEV is
the appropriate error when no CPUs are online across all dies.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
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

