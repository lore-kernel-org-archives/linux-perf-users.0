Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E43361666;
	Mon, 11 May 2026 23:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778541249; cv=none; b=V6vI+GUKcuEPPvdQWscqOB4vYdwBmOROy8JVGrhxoBktPoaEii9q11blEpAcfV8gpQtxP5zLMd9ffg24svLRp19zLZtHZo/jkmdU7ZHaGJ52DDS3rA7A2kt94NjYAtieHDExarV03/lbT1a7eNIsl/QhrZ0JnnYYG7TernVpSYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778541249; c=relaxed/simple;
	bh=3YV9pWT6asdFxPtJrrdjyfIqtS68Lcr5T0xnqC6tVcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/6IessGqwrjy9FIR3hME4nmwf1/4zqNOCJRpQ6BGjy/Rrw6+kerwojKW3GsOGepxcBSwJgJGWl1M3SdSR9cMS7MP3fIqEqe0FpYZ7Pd///JLkM4RJwbEMvNoTE0Xfh0kK98PXuJqMOGORszBTaD14bO49Xen9XXaQyH2vtenFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jVn5vUK2; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jVn5vUK2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778541248; x=1810077248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3YV9pWT6asdFxPtJrrdjyfIqtS68Lcr5T0xnqC6tVcY=;
  b=jVn5vUK2zDONSOx3otDtgK5Ht+ckXkRZweYD4++U6JM0eqqpYZb1GLr/
   ti0cfNcTpMeoNWFk80nc8XOWm0fSt8kdsGK6lDEp5ZgGrFZ1FWHzxXShK
   y/ntKSowQJWy111mNI1Fdjzf34mg2DLIdX2rRj/dxKUkyp+YOohGGJRI4
   bawS4NiHWaX/sdPZa0b/Q/q47whuY/zmViborTO77z87RVcQtck4eIN9l
   bBq/VYEy9e/mZfE20dS8snMCRlMe6dBlvLtyFleN6rnT0lpShdSE8hyDR
   KJLR/z3D81V/NuSqUfcvqTYfsnPoxfipyP5gtdikqSLH6///rOw4uUYIr
   Q==;
X-CSE-ConnectionGUID: Kwwamb6hTdyMOMgPS7BgZQ==
X-CSE-MsgGUID: vAXud9rsQHSZeUYMSpHLag==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83058115"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="83058115"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 16:14:06 -0700
X-CSE-ConnectionGUID: lOv5iiMxTQ2cSy++dfIevw==
X-CSE-MsgGUID: LwJGZv64ScGyzVsptQWSfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="267944465"
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
Subject: [PATCH 4/6] perf/x86/intel/uncore: Move die_to_cpu() to uncore.c
Date: Mon, 11 May 2026 16:05:25 -0700
Message-ID: <20260511230527.26096-5-zide.chen@intel.com>
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

Move die_to_cpu() into uncore.c so it can be reused by the MSR
initialization path, preparing for the introduction of an MSR global
initialization callback.

Add the uncore_ prefix for consistency with other uncore APIs.

No functional change intended.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/uncore.c       | 19 +++++++++++++++++++
 arch/x86/events/intel/uncore.h       |  1 +
 arch/x86/events/intel/uncore_snbep.c | 21 +--------------------
 3 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index e9cc1ba921c5..2bbe4cc1df3e 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -83,6 +83,25 @@ int uncore_device_to_die(struct pci_dev *dev)
 	return -1;
 }
 
+int uncore_die_to_cpu(int die)
+{
+	int res = 0, cpu;
+
+	/*
+	 * Using cpus_read_lock() to ensure cpu is not going down between
+	 * looking at cpu_online_mask.
+	 */
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		if (topology_logical_die_id(cpu) == die) {
+			res = cpu;
+			break;
+		}
+	}
+	cpus_read_unlock();
+	return res;
+}
+
 static void uncore_free_pcibus_map(void)
 {
 	struct pci2phy_map *map, *tmp;
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index c35918c01afa..94c68e3417b6 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -235,6 +235,7 @@ struct pci2phy_map *__find_pci2phy_map(int segment);
 int uncore_pcibus_to_dieid(struct pci_bus *bus);
 int uncore_die_to_segment(int die);
 int uncore_device_to_die(struct pci_dev *dev);
+int uncore_die_to_cpu(int die);
 
 ssize_t uncore_event_show(struct device *dev,
 			  struct device_attribute *attr, char *buf);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index c9ce206fcbb6..30c6a9306c54 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3704,25 +3704,6 @@ static int skx_msr_cpu_bus_read(int cpu, u64 *topology)
 	return 0;
 }
 
-static int die_to_cpu(int die)
-{
-	int res = 0, cpu, current_die;
-	/*
-	 * Using cpus_read_lock() to ensure cpu is not going down between
-	 * looking at cpu_online_mask.
-	 */
-	cpus_read_lock();
-	for_each_online_cpu(cpu) {
-		current_die = topology_logical_die_id(cpu);
-		if (current_die == die) {
-			res = cpu;
-			break;
-		}
-	}
-	cpus_read_unlock();
-	return res;
-}
-
 enum {
 	IIO_TOPOLOGY_TYPE,
 	UPI_TOPOLOGY_TYPE,
@@ -3795,7 +3776,7 @@ static int skx_pmu_get_topology(struct intel_uncore_type *type,
 	u64 cpu_bus_msr;
 
 	for (die = 0; die < uncore_max_dies(); die++) {
-		ret = skx_msr_cpu_bus_read(die_to_cpu(die), &cpu_bus_msr);
+		ret = skx_msr_cpu_bus_read(uncore_die_to_cpu(die), &cpu_bus_msr);
 		if (ret)
 			break;
 
-- 
2.54.0

