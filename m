Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B293840626E;
	Wed, 27 May 2026 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779895235; cv=none; b=DYcKyhzh4l2o/K3dg9f2uh20IMuCBhWjh5btUlyx4ArDwmYHwa1/G9V1Lx23qeJ82Cu2TnHf4U5TqSHE/qbMu2hZscRlzfFyCojTfh+aFfBZE+csH5My8LmEXJPD47Wri0kVPQWqeZCqbpG3Q1i7+OOPU+JqlrgFTJHFoHrZFA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779895235; c=relaxed/simple;
	bh=4H9iY6p4klO+8V5I9C0fpg1tx5s/nV+3FfjItpbFmsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mXT8bPWjy5vqiGyLh3UkXUs5zavo2yPBCXjFyKFqxIzMfqYHljT91UWoQbYy0Z/hhEDz1swt+U5C6VH7hskijwP0+tmIh4IwQQJaW+4BJ6twu2feg0do2YK7DLDvQpnr6rkHWWb2h9z0VMBglD1xqc1opfxGmOqILK18uYv8jGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SmAfTE8/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SmAfTE8/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779895233; x=1811431233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4H9iY6p4klO+8V5I9C0fpg1tx5s/nV+3FfjItpbFmsw=;
  b=SmAfTE8/ZI1oKGgEUVCyZFjrRwX1G0cjZ+OsbeXEwl2ipM6Ps1Q7wXdp
   OTqnGKAEHwjFPglTFIqYHM3E1+fM+Ln7aPZjP14Z8YhfYU9BSXgefC0/5
   x3/KF4IqIWRL6QlUohY/m4p0tXPn9OfnAZ3qd4yeuv3clqu1eiABdR8gG
   Cmtpu5TlKm4epKcn5hDlGmQZD3pv+gkuYv5r3mevX7wYA/Ezl68QC5ni9
   V0Yvu4TSJk1ZiHcDHfj5Y+CryWLMwqA7D8hfuUwT/04sXfVlGu/rPUPkS
   ZhR1QiR2y2n+D4UGumw8X59wFyUh71+csAUKZixGgHOooO6QgFLCbhoKi
   Q==;
X-CSE-ConnectionGUID: brighQ2lT1aUK32hXw3yGA==
X-CSE-MsgGUID: iengQqebTHabxVpO/g+8yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="98149314"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="98149314"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 08:20:31 -0700
X-CSE-ConnectionGUID: qlh1sUL9SN6kJSCaXhYdRA==
X-CSE-MsgGUID: U4ZbW5nsSuCrdMa4J4KRWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="241231397"
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
Subject: [PATCH V2 3/7] perf/x86/intel/uncore: Fix PCI device refcount leak in UPI discovery
Date: Wed, 27 May 2026 08:11:50 -0700
Message-ID: <20260527151154.130505-3-zide.chen@intel.com>
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

pci_get_domain_bus_and_slot() increments the reference count of the
returned PCI device and therefore requires a matching pci_dev_put().

In skx_upi_topology_cb() and discover_upi_topology(), the lookup is
performed inside a loop, but pci_dev_put() is only called once after
the loop. As a result, references from all previous iterations are
leaked.

Move pci_dev_put(dev) into the if (dev) block immediately after
upi_fill_topology() returns.

Opportunistically, fix uninitialized variable in skx_upi_topology_cb().

Fixes: 4cfce57fa42d ("perf/x86/intel/uncore: Enable UPI topology discovery for Skylake Server")
Fixes: f680b6e6062e ("perf/x86/intel/uncore: Enable UPI topology discovery for Icelake Server")
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 215d33e260ed..c9ce206fcbb6 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4261,7 +4261,7 @@ static int upi_fill_topology(struct pci_dev *dev, struct intel_uncore_topology *
 static int skx_upi_topology_cb(struct intel_uncore_type *type, int segment,
 				int die, u64 cpu_bus_msr)
 {
-	int idx, ret;
+	int idx, ret = 0;
 	struct intel_uncore_topology *upi;
 	unsigned int devfn;
 	struct pci_dev *dev = NULL;
@@ -4274,12 +4274,12 @@ static int skx_upi_topology_cb(struct intel_uncore_type *type, int segment,
 		dev = pci_get_domain_bus_and_slot(segment, bus, devfn);
 		if (dev) {
 			ret = upi_fill_topology(dev, upi, idx);
+			pci_dev_put(dev);
 			if (ret)
 				break;
 		}
 	}
 
-	pci_dev_put(dev);
 	return ret;
 }
 
@@ -5499,6 +5499,7 @@ static int discover_upi_topology(struct intel_uncore_type *type, int ubox_did, i
 							  devfn);
 			if (dev) {
 				ret = upi_fill_topology(dev, upi, idx);
+				pci_dev_put(dev);
 				if (ret)
 					goto err;
 			}
@@ -5506,7 +5507,6 @@ static int discover_upi_topology(struct intel_uncore_type *type, int ubox_did, i
 	}
 err:
 	pci_dev_put(ubox);
-	pci_dev_put(dev);
 	return ret;
 }
 
-- 
2.54.0

