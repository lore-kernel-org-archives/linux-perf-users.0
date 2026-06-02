Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE2E35B63D;
	Tue,  2 Jun 2026 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412278; cv=none; b=k3b0yWNfiSaS4QbwRIpLNGtfncmCGCj5+iXzSHNiwb9nkxS5DHHrReNwIc+u22/sSb0PVqSz9UFYhf4YERGwdZH9IjRIGz15aSQOL99MjcZhJQKTM0uyryNKJQjtUP4Z243MajP8b7ybL9ybUBYe+TwtpIMNpLX11ZEVBFf4rPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412278; c=relaxed/simple;
	bh=2VwL4oWvGYVtwIgoopPHo97ixJoz6AA5Bsp73Zk6DOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujkyZFabSTaJ4xHGjXFsLfHQvOiL2fg365DkzN9mKTKwXAqUNDQVAGpEM3hX5bXFuoiwCNDiZDyxrRjGCF3p7qn4xQYt/9IY+KlfN9nI30MI9huesvE+2fyzsrCsbUJE3s9/WyQhi+cSAzs5S0lwMGw3uF30B3ZsbgaUvyNbtKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aePaidTQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aePaidTQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780412277; x=1811948277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2VwL4oWvGYVtwIgoopPHo97ixJoz6AA5Bsp73Zk6DOU=;
  b=aePaidTQGniBKiDfaug/RK1McXO1D2af43jZdNhRTGthe3I/VLk6hfOE
   MVv15zK5aiq+StG8JGblIKD5JEDHRrMwzY46xvO4x8ePV/7514GE7KmUL
   59XgT2trJeLX1H9VJYhIms0qQvJpdk0LTY2hR8ICv4reMiadg6zHivGHr
   dbbdBXwIM78YOSr/uAzi6UHRju9TBoeytE9qAuYstQ6eDxZ0Be7rYdebM
   +VUFRA9pLNGJcKw24+Sj5yKA0fGhx3xO+kDiefFLXz9e185xqduyg8Db/
   0vh4LJ4h/aA/3PHoib7yPIqXZTY4bmKrDjHIxnc0C+M6J3/nvG/W4Jz8n
   g==;
X-CSE-ConnectionGUID: EpZmwzU4RXGGX+8hIh1GWg==
X-CSE-MsgGUID: hQAes3SZQbSfIaV3lGNUDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="103859991"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="103859991"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 07:57:55 -0700
X-CSE-ConnectionGUID: W9JLQx9PRf+84Pgx0DxYTg==
X-CSE-MsgGUID: UciWMnHvTWmx70k9qbKnxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="243095625"
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
Subject: [PATCH V3 3/7] perf/x86/intel/uncore: Fix PCI device refcount leak in UPI discovery
Date: Tue,  2 Jun 2026 07:49:04 -0700
Message-ID: <20260602144908.263680-4-zide.chen@intel.com>
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
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
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

