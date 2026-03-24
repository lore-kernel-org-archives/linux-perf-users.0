Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2589E3B4EA1;
	Tue, 24 Mar 2026 21:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389500; cv=none; b=lCs8FcTbGJDgyIxLA7yvZo+hjS1ciwvu7tlJQRmcV+COvhLlBwuryukCXYG1my1cjDzwGhPgXOtHmisbI57EbdulhR319RT9BArT5F/pj/dgcVy/35vwU67vet2SlKXQeoDrWrBz7d62BNNDK1znauqk4yO6yhMKEqQvZjS+IQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389500; c=relaxed/simple;
	bh=PEcRC/UN3Bk2IIlmGLL8vBRQJIRM8YHyfTK/NMXO9pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tpge8Hh88xDkk2RrxA3NsIXc6rstiRb3qy4j5/Qdhysnyi/bZs0gh60UVEkLPWlf2xt8k1VIBbgSIxl5s5gbBvcjPLO78nmBb/ICIOJA+eNJCvXK4hCAJCiHLVeu9PED7wZle08v4XtweH47WHPBKvz+3FbovvaJ1rGQo8vbsMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cduuzK3Z; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cduuzK3Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774389499; x=1805925499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PEcRC/UN3Bk2IIlmGLL8vBRQJIRM8YHyfTK/NMXO9pA=;
  b=cduuzK3ZfXqRL+/wbiUtqqsV61cO+db4v7OBwOll05wVfJ1fJdXhYmBf
   7hbt2csvk1lyJKopJqgfw7C9vtStqVpeB5YojTH9cH2Cw4AjFp4JUlO0y
   /rJsOA2+tfcjtjaEex0bUfapA/UPqb06dookuyO4QkuTXLv64akIpDidB
   Lf7mNcUeiRXkxcr8ts9t2tjduMWadR7inHMJTZTa3yLpYfjIUIYbBHKi+
   MFnW2HOuTFnpCESvs7kFZiotLNLIK89uHRQy28dM78MKbfkx6ORlRS3ri
   hDuajG/94+uzXurGoedTN7DmhZ4fN71YpU1AxLo4wE6GkaDHNIZ9a56x4
   Q==;
X-CSE-ConnectionGUID: Enruixm6Smacnq0XFOEP/g==
X-CSE-MsgGUID: C61hNEUVSP+bkMD4NbNFdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="100866107"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="100866107"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 14:58:18 -0700
X-CSE-ConnectionGUID: tC4P844NS0Sjf93mYbdBCg==
X-CSE-MsgGUID: FqzVm1KIQcGIhjSgSgfGUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="224496728"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 14:58:18 -0700
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
	Steve Wahl <steve.wahl@hpe.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH V5 3/4] perf/x86/intel/uncore: Fix die ID init and look up bugs
Date: Tue, 24 Mar 2026 14:49:31 -0700
Message-ID: <20260324214932.10068-4-zide.chen@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324214932.10068-1-zide.chen@intel.com>
References: <20260324214932.10068-1-zide.chen@intel.com>
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

V5:
- Remove unused variable die_id (Dapeng).
---
 arch/x86/events/intel/uncore.c       |  1 +
 arch/x86/events/intel/uncore_snbep.c | 17 ++++++++---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 786bd51a0d89..e9cc1ba921c5 100644
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
index 9b51883fd6fd..5ef205a70559 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1413,7 +1413,7 @@ static int topology_gidnid_map(int nodeid, u32 gidnid)
 static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool reverse)
 {
 	struct pci_dev *ubox_dev = NULL;
-	int i, bus, nodeid, segment, die_id;
+	int i, bus, nodeid, segment;
 	struct pci2phy_map *map;
 	int err = 0;
 	u32 config = 0;
@@ -1458,14 +1458,8 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
 				break;
 			}
 
-			map->pbus_to_dieid[bus] = die_id = uncore_device_to_die(ubox_dev);
-
+			map->pbus_to_dieid[bus] = uncore_device_to_die(ubox_dev);
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
2.53.0

