Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C1BEEBB;
	Tue, 13 Jan 2026 21:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768338253; cv=none; b=EayjSnOtiObxPegi5d5TnIIzH3nBYBhgl3L/DMXrbo3QCSugMJPKyzR/M0+LNsgCKzB5FU9umO9DwwVETYPP3Pqn5pbci8Hp/dlCwELMdyFYTRf7pD0BoxXKabcmMIdtUyTeHAi9CO4yZWt0rIs2ZiHHm3BQJ575AHWX5pcCvJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768338253; c=relaxed/simple;
	bh=dZk9trfhqJ8LQQkKrectq5u9JDyx4WVIP38qxjNaMyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PL9NgIJ3gmYCBKyW+YhKyo9gqAZErDcPdAyoNA92t3q6B9cbENnUmI4Sj7BXUz54ru2GKXtO0MKCjxePR0IZ4o3GIJuu8c66OUTtQliVcvPS9Nu5tDrfoPDIVx8tRCHJqW3RHD8cqHosTEUl0StDeo5kPx50CM1Y3QcAH6C/59M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dv0iF2KC; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dv0iF2KC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768338251; x=1799874251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dZk9trfhqJ8LQQkKrectq5u9JDyx4WVIP38qxjNaMyU=;
  b=dv0iF2KCLCuOTvcwdkVOCPlyKARMGBhXQ7RiVKnESWGWutR4oV6uG1DC
   fnFCaQlo6uwrt4tXF74SjBgxoQNGftwuXoK74SNMGBXJn9RhkNB0sZKin
   qXrCpbxurQYEmXYHK53IbCJ4ew/OVR9gwvHT6ETgQoxz0zkdybAPuZkwm
   IoreJPuW0yGY1qx56gfrhUN+gq6GC4/sQJc678n++04h8I4mbavtPPq0T
   yy5KjxFBag/ire0Njf8SM/gHk3xj1pDAU/dm8cFkIMpLTHgvR8wc3GiSF
   FrdbxASfUPWyUval02fyxDANj0pfrdy2X0kJwO0tFjAi4spHskXCx7wuR
   g==;
X-CSE-ConnectionGUID: 4yxF/6VPSC+gUEZb3ucFIg==
X-CSE-MsgGUID: 2Q8Qd493QJe74DJkkZm74g==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69715176"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69715176"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 13:04:08 -0800
X-CSE-ConnectionGUID: LmADyn3qQaWEn2to5eZBHw==
X-CSE-MsgGUID: Z11PieH8Qpy0uNOMVhjdhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="242015182"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 13:04:03 -0800
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
	Zide Chen <zide.chen@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Steve Wahl <steve.wahl@hpe.com>
Subject: [PATCH V2 2/2] perf/x86/intel/uncore: Fix die ID init and look up bugs
Date: Tue, 13 Jan 2026 12:56:50 -0800
Message-ID: <20260113205650.5201-2-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113205650.5201-1-zide.chen@intel.com>
References: <20260113205650.5201-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In snbep_pci2phy_map_init(), in the nr_node_ids > 8 path,
uncore_device_to_die() may return -1 when all CPUs associated
with the UBOX device are offline.

Remove the WARN_ON_ONCE(die_id == -1) check for two reasons:

- The current code breaks out of the loop. This is incorrect because
  pci_get_device() does not guarantee iteration in domain or bus order,
  so additional UBOX devices may be skipped during the scan.

- Returning -EINVAL is incorrect, since marking offline buses with
  die_id == -1 is expected and should not be treated as an error.

Separately, when NUMA is disabled on a NUMA-capable platform,
pcibus_to_node() returns NUMA_NO_NODE, causing uncore_device_to_die()
to return -1 for all PCI devices.  As a result,
spr_update_device_location(), used on Intel SPR and EMR, ignores the
corresponding PMON units and does not add them to the RB tree.

Fix this by using uncore_pcibus_to_dieid(), which retrieves topology
from the UBOX GIDNIDMAP register and works regardless of whether NUMA
is enabled in Linux.  This requires snbep_pci2phy_map_init() to be
added in spr_uncore_pci_init().

Keep uncore_device_to_die() only for the nr_node_ids > 8 case, where
NUMA is expected to be enabled.

Fixes: 9a7832ce3d92 ("perf/x86/intel/uncore: With > 8 nodes, get pci bus die id from NUMA info")
Fixes: 65248a9a9ee1 ("perf/x86/uncore: Add a quirk for UPI on SPR")
Tested-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2:
- Fix the commit message to note that spr_update_device_location() is
  used by EMR, not GNR.
- Rewrite the commit message for clarity.
- Add a Tested-by tag.

 arch/x86/events/intel/uncore.c       |  1 +
 arch/x86/events/intel/uncore_snbep.c | 13 ++++++-------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index c126a29ab729..c721042be629 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -67,6 +67,7 @@ int uncore_die_to_segment(int die)
 	return bus ? pci_domain_nr(bus) : -EINVAL;
 }
 
+/* Note: This API can only be used when NUMA information is available. */
 int uncore_device_to_die(struct pci_dev *dev)
 {
 	int node = pcibus_to_node(dev->bus);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 7ca0429c4004..52dec34d18c4 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1459,13 +1459,7 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
 			}
 
 			map->pbus_to_dieid[bus] = die_id = uncore_device_to_die(ubox_dev);
-
 			raw_spin_unlock(&pci2phy_map_lock);
-
-			if (WARN_ON_ONCE(die_id == -1)) {
-				err = -EINVAL;
-				break;
-			}
 		}
 	}
 
@@ -6420,7 +6414,7 @@ static void spr_update_device_location(int type_id)
 
 	while ((dev = pci_get_device(PCI_VENDOR_ID_INTEL, device, dev)) != NULL) {
 
-		die = uncore_device_to_die(dev);
+		die = uncore_pcibus_to_dieid(dev->bus);
 		if (die < 0)
 			continue;
 
@@ -6444,6 +6438,11 @@ static void spr_update_device_location(int type_id)
 
 int spr_uncore_pci_init(void)
 {
+	int ret = snbep_pci2phy_map_init(0x3250, SKX_CPUNODEID, SKX_GIDNIDMAP, true);
+
+	if (ret)
+		return ret;
+
 	/*
 	 * The discovery table of UPI on some SPR variant is broken,
 	 * which impacts the detection of both UPI and M3UPI uncore PMON.
-- 
2.52.0

