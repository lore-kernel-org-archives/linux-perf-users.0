Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90EE4279F6;
	Wed, 27 May 2026 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779895236; cv=none; b=MuVozMqesAmWeWaGWph3+ORVplHyuXBcgF/lA1mihQEnDKs71ubYM+A0T8hhVvcAMgmuK5dszb75h0FR90ecZx+55WxOrOjFOYon9QEVmbyMRifisc4raMYz/JqWTEBkJHaLhUYsyvjXqUhxXIsEXzaMlWelgF2fR0R2si0eoic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779895236; c=relaxed/simple;
	bh=ElUvFtlm3JnLoB17y6kOah187E9KO4WBehmEBCT0sEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fa3ZPjHCIXtzErRjCu/3LsDIb/bFqWibLZor5KWpc1r/GijgYtpIlqymHxIdT+jhTS3ILwyyKHuWVKxsAP1KSLKdPzRDCJDzOn9UPWkKfCqTP8zg5jBXzEU9lZ9f+1mCxOijSUPOsGcMN1ecZVZ2phdiqzSiy73CNT2uEkAg7+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WuX1/uZY; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WuX1/uZY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779895235; x=1811431235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ElUvFtlm3JnLoB17y6kOah187E9KO4WBehmEBCT0sEE=;
  b=WuX1/uZYdGMIf7C6k6jcxBycHOHreDEjA9nczFvIqDxVvKvBm+6qD7VK
   +vKRjr05pZ8Jqv7KguO54hHxRZlB/CjBojxWKP2vkO54L4bkan+FagLuA
   UIjbP5bg8kuPYx7Nr2QxA2NfSlJR/Da2ANS4LyNeB8bY+SgGCC6jXmiNS
   4q42KCBKueKYEh/NydBRN6lmlkUJcD+r9hayS3OH3CzzI15QagoxcUr2o
   /2CVeqsbpZib84Iy7zGsk3aCEJZPO9z28gzGyY21/8cG1CBS/v7M2bru/
   /Oo7Y1cF2hrasgkHilQcmxxbq8HhaNzOyAZxwaLh2zOzsLm/Wtpi7LLYg
   g==;
X-CSE-ConnectionGUID: +R263cYOQ3W6dphr8xzQjw==
X-CSE-MsgGUID: OVPmeqaJTeyZPPqbqbP9Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="98149325"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="98149325"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 08:20:31 -0700
X-CSE-ConnectionGUID: 8ay3kd6uRdCI888YDAArZg==
X-CSE-MsgGUID: J/WzFWIoTHCD8mJYvXSXxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="241231403"
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
Subject: [PATCH V2 5/7] perf/x86/intel/uncore: Move die_to_cpu() to uncore.c
Date: Wed, 27 May 2026 08:11:52 -0700
Message-ID: <20260527151154.130505-5-zide.chen@intel.com>
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

Move die_to_cpu() into uncore.c so it can be reused by the MSR
initialization path, preparing for the introduction of an MSR global
initialization callback.

Move the cpus_read_{lock,unlock}() out of the API, in order to make
it possible to be called when the lock is being held.

Add the uncore_ prefix for consistency with other uncore APIs.

Signed-off-by: Zide Chen <zide.chen@intel.com>

V2:
- Move cpus_read_{lock,unlock}() out of uncore_die_to_cpu() and rely
  on callers to manage the lock. (Sashiko)
- Remove "No functional change intended" from the changelog.
---
 arch/x86/events/intel/uncore.c       | 19 +++++++++++++++++++
 arch/x86/events/intel/uncore.h       |  1 +
 arch/x86/events/intel/uncore_snbep.c | 23 +++--------------------
 3 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index e9cc1ba921c5..22256ded2d67 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -83,6 +83,25 @@ int uncore_device_to_die(struct pci_dev *dev)
 	return -1;
 }
 
+/*
+ * Using cpus_read_lock() to ensure cpu is not going down between
+ * looking at cpu_online_mask.
+ *
+ * The lock must be held by the caller.
+ */
+int uncore_die_to_cpu(int die)
+{
+	int res = 0, cpu;
+
+	for_each_online_cpu(cpu) {
+		if (topology_logical_die_id(cpu) == die) {
+			res = cpu;
+			break;
+		}
+	}
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
index c9ce206fcbb6..772b78237424 100644
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
@@ -3794,8 +3775,9 @@ static int skx_pmu_get_topology(struct intel_uncore_type *type,
 	int die, ret = -EPERM;
 	u64 cpu_bus_msr;
 
+	cpus_read_lock();
 	for (die = 0; die < uncore_max_dies(); die++) {
-		ret = skx_msr_cpu_bus_read(die_to_cpu(die), &cpu_bus_msr);
+		ret = skx_msr_cpu_bus_read(uncore_die_to_cpu(die), &cpu_bus_msr);
 		if (ret)
 			break;
 
@@ -3807,6 +3789,7 @@ static int skx_pmu_get_topology(struct intel_uncore_type *type,
 		if (ret)
 			break;
 	}
+	cpus_read_unlock();
 
 	return ret;
 }
-- 
2.54.0

