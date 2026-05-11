Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB338363C75;
	Mon, 11 May 2026 23:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778541250; cv=none; b=ZxqQnBcoRPgovl1qUqmeZvfMW3oip3BhTAiUS+QK46gyjzeGdLTbr6HP+m4o6l3JRvKL6hW3JFVKdrC7xY9W7WnIBK66S2MLFekbMWg1X1wJT38Fr8iy0eCNyr5YoWm12s2m91M+rtseeNxZvBdaMdVGPsAa/Qo/nLB2Yb9tgsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778541250; c=relaxed/simple;
	bh=5hdUA15pe9AEEcSV8J+fCzVj+CyYv9dP59tNauQEx1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=scRG3jR8MU6jM8AEMhCfvIqICzzm3GUHmdzgGcE5lfs3cnJVy6Gk+PXyGCQmRaPOta66GtGkB8J5wrwteZZ/w3GxiY8cohUdGbtn80Eib19K+Eh9V5C5/+mvVBOAhJG/B9IqcbNu0oscQCJpIZPQZFkhyqyDU0u6KT4mSETwXr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bi76/KDm; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bi76/KDm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778541248; x=1810077248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5hdUA15pe9AEEcSV8J+fCzVj+CyYv9dP59tNauQEx1Y=;
  b=Bi76/KDmDBu+Q7Zqd+Ng0qa+oUfGNCdGC68UOShRveLQwB2SXS4VSNoM
   u2NaMmu1LxOaY2ovr6UEx4Dyp5pOEUyEWx4CYgEMxM971TfrHNModwvXZ
   6ZAO0q5O7sVWVykrHGxk6yzfzcnxWz8A8Hgij+9FZ6gd2R/eFjKM3zxHf
   7fmiV7s9LXmgfPZnA2lUreIuCGcBwhf91EqR3nH4zGwJAvwSTYqHZYRZj
   unG8t7ftlxlyawvxnzpCH8SpsUKJ6ibYobD7cay4M6YBZfx+hByoojDs7
   uwd8rXumKSKlorkNWg0Uc84ugjnozFBgVZuGZX3wB14Fr3neZ5ztb8SBg
   A==;
X-CSE-ConnectionGUID: B6Hs0ra+R9+S+kQAt68Qeg==
X-CSE-MsgGUID: B7loGFF7T/qGNvu1VyI5OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83058123"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="83058123"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 16:14:06 -0700
X-CSE-ConnectionGUID: eMQ0kMprTTaVLjopNlyEOw==
X-CSE-MsgGUID: DuB6Oyo7QVOlxHVM+RTYrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="267944468"
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
Subject: [PATCH 5/6] perf/x86/intel/uncore: Fix uncore_die_to_cpu() for offline dies
Date: Mon, 11 May 2026 16:05:26 -0700
Message-ID: <20260511230527.26096-6-zide.chen@intel.com>
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
index 2bbe4cc1df3e..19056514b081 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -85,7 +85,7 @@ int uncore_device_to_die(struct pci_dev *dev)
 
 int uncore_die_to_cpu(int die)
 {
-	int res = 0, cpu;
+	int res = -1, cpu;
 
 	/*
 	 * Using cpus_read_lock() to ensure cpu is not going down between
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 30c6a9306c54..251c7bdbe30b 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3772,11 +3772,16 @@ static void pmu_free_topology(struct intel_uncore_type *type)
 static int skx_pmu_get_topology(struct intel_uncore_type *type,
 				 int (*topology_cb)(struct intel_uncore_type*, int, int, u64))
 {
-	int die, ret = -EPERM;
+	int die, ret = -ENODEV;
 	u64 cpu_bus_msr;
+	int cpu;
 
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

