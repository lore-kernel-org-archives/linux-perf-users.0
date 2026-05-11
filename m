Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB1C362143;
	Mon, 11 May 2026 23:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778541250; cv=none; b=OEGWh+2pMtD/tQJq1mjxFsAK/tTVw2BnPnU9J+X8245mLT61yulewKi8Pl9HWeLKm719ZT5dlDQkPnn8dmRLx8VLjYrA6JHKTSyPh2o8Y1S81Y0AjcQ9Ztv5XIeJBrMBOtxW5HUakO14uwxFtD70HJhut34QKW3DeK0zxUHGiWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778541250; c=relaxed/simple;
	bh=4H9iY6p4klO+8V5I9C0fpg1tx5s/nV+3FfjItpbFmsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPKqGj/iv4zl1Qb1N0Mm7eyE+4upfjS8HvgjrVuRWI7S013HHRE8V1weDckMZJlZvTaHTYaymqxfnQr8MRL8JY7QxSK0H66xE/feOvHDtm4pGgu45Uc1dSLk6kWQms7hyKRM5YldyP3UKX64UeyxzL5oMQdxbPsFZyiXlxdZz/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NDhtwD6+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NDhtwD6+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778541248; x=1810077248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4H9iY6p4klO+8V5I9C0fpg1tx5s/nV+3FfjItpbFmsw=;
  b=NDhtwD6+/KO09cov8R7OrmOZUNUzWa7Hc+VUG98x60LdK9r0lfn+bln0
   g50+Rn3vC6RzZogiOj/yXnAbC4Hf3TSrTeR0sfuSErcnPfchZDuScjH3y
   jUgNCmUF0oxjt/zatbXia/ZTQl0BewoPBPRzAnSlwv+iVy3954grbAFUD
   UDwZcMZUf+9sYw+fCGvcXXObIxmglooeaWQHrs4NNM/QebIKnWnsWUUf6
   j5X1cbA0/yTCavHhVF8UgxT84jAq9Qp/mC6zNyrDFC4XhxWM77Gg2iTs7
   E1hJ8AfR8DsdGgk6Q5rdUUOMoqU7IUiHIw4oGf29afBGiFwMtlgMf0/iP
   Q==;
X-CSE-ConnectionGUID: uvVJI8ekTMChxM0Bq+WlaQ==
X-CSE-MsgGUID: 9nMHTpPMQPe/5K3IBrnsFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83058106"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="83058106"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 16:14:06 -0700
X-CSE-ConnectionGUID: VJar7tStT6WGxFF5TZnsCA==
X-CSE-MsgGUID: vlLwzpaUSrqmWqXtUw4jwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="267944459"
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
Subject: [PATCH 2/6] perf/x86/intel/uncore: Fix PCI device refcount leak in UPI discovery
Date: Mon, 11 May 2026 16:05:23 -0700
Message-ID: <20260511230527.26096-3-zide.chen@intel.com>
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

