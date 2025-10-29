Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3B331987A;
	Wed, 29 Oct 2025 22:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761776041; cv=none; b=KzxC0pgtchyv5Hs6VGhwWqnAFlIeRyjql9l/XVsqg0na9tpOu2/i9rTUnUj6AzrRW2Srh4XNyZvbSi+TecuWZ3UlXj/8YTU5HHjAiNUc8NksJhyKZJdGk4LLbLxuL9DFwixIn6t2J2/xFQfasRkdiBNsxPL4CyG8z4XaSH7ml20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761776041; c=relaxed/simple;
	bh=Cv0azkwJ4pA29hWXKaLwdIW9eyRw63/Rpod0S7ohj34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gnU5WRztkDRX0gA7kQ7rSHP0RZoYVkfvs7XiJ4lumFwb5ZY7vyxzv2S1vtGQNyC6FMGFl3niGaH7pFq5Mu//1t98mHqlVHJRsWDtUJg3BJ1V07ZSwlxsHgOD7bqTwLeKRG8+d/E/mCOtbQA2DHMJwXRZi17RM6zY+rXYZqsyEIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DYunwdAF; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DYunwdAF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761776040; x=1793312040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cv0azkwJ4pA29hWXKaLwdIW9eyRw63/Rpod0S7ohj34=;
  b=DYunwdAF+KNWGy8DlwpRUPTAqm5IM2jGCPlGQpYeuSwaxOhqFDojIBpP
   z6I9OYMX8n52uJvFMDyCstAUz/Jky+pyK9l485oJEzzzirrP5quqO4KRc
   pNz+PhbfjVszfmqz9Zf9Bf5uZ8kg2cGMA+rJdh5VyQuPfniMq/2exiVMc
   +MiokPMImXjBm7WsxQrodeCLuc1S6kVtnxDqa5Dz8MjbbxhWArOChoayD
   hhJV9KuJDVVk6l7kD9u2L+viPyjKp6BjWcT9lSOzC3ru3seXRGB2zk2iZ
   sIDDlTUqE8Iq9mbyy10T2nEILde2zjQmBwptddI90amRkBDHRntT1MECo
   Q==;
X-CSE-ConnectionGUID: Cm1/+vFHQ+muW5xXaZaYjQ==
X-CSE-MsgGUID: iVDmHWZRQ3mkO4TeJzVijg==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="66526650"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="66526650"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 15:13:58 -0700
X-CSE-ConnectionGUID: 4gV4Kmv7Tg+EWNFyxzNQbA==
X-CSE-MsgGUID: iUUomV48QgKw2/WNspxFqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="190104780"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 15:13:58 -0700
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
Subject: [PATCH 2/2] perf/x86/intel/uncore: Fix die ID init and look up bugs
Date: Wed, 29 Oct 2025 15:07:11 -0700
Message-ID: <20251029220711.57909-2-zide.chen@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251029220711.57909-1-zide.chen@intel.com>
References: <20251029220711.57909-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In snbep_pci2phy_map_init(), if there are more than 8 nodes,
uncore_device_to_die(ubox_dev) may return -1 if all CPUs
associated with the UBOX device are offline.  This is not an error
and we still need to populate map->pbus_to_dieid[].

If NUMA is disabled on a NUMA-capable platform, pcibus_to_node()
returns NUMA_NO_NODE and uncore_device_to_die() returns -1.  As a
result, in spr_update_device_location(), which is used on Intel SPR,
GNR etc., the PMON units are ignored and not added to the RB tree.

Use uncore_pcibus_to_dieid() instead, which retrieves topology
information from the GIDNIDMAP register of the UBOX device.

Fixes: 9a7832ce3d92 ("perf/x86/intel/uncore: With > 8 nodes, get pci bus die id from NUMA info")
Fixes: 65248a9a9ee1 ("perf/x86/uncore: Add a quirk for UPI on SPR")
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/uncore.c       |  1 +
 arch/x86/events/intel/uncore_snbep.c | 13 ++++++-------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 5c3aeea5c78d..84d6e481f18f 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -77,6 +77,7 @@ int uncore_die_to_segment(int die)
 	return bus ? pci_domain_nr(bus) : -EINVAL;
 }
 
+/* Note: This API can only be used when NUMA information is available. */
 int uncore_device_to_die(struct pci_dev *dev)
 {
 	int node = pcibus_to_node(dev->bus);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index ad4d11762ecf..e68467f617f9 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1471,13 +1471,7 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
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
 
@@ -6530,7 +6524,7 @@ static void spr_update_device_location(int type_id)
 
 	while ((dev = pci_get_device(PCI_VENDOR_ID_INTEL, device, dev)) != NULL) {
 
-		die = uncore_device_to_die(dev);
+		die = uncore_pcibus_to_dieid(dev->bus);
 		if (die < 0)
 			continue;
 
@@ -6554,6 +6548,11 @@ static void spr_update_device_location(int type_id)
 
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
2.51.1

