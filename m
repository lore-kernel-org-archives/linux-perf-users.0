Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E403A16A5;
	Mon, 30 Mar 2026 21:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774906389; cv=none; b=YCUbicUcoIBgUUdrzs9i5Kze37TYDJBa3exlq/6JeB6j39pHnqFDmv7w0pqB0wbqkFZgyXRjl/Gvk3K71qf34QLPrUgUfJw/MBrh2MDvD/+s2Iid455mQOimnLezYGV/ztE9rW0O+1/eRcbo4EnYmXRYG5e/9jVobbuK09Ce6oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774906389; c=relaxed/simple;
	bh=dj91uacxVecpa5voFWCqOyWoMImRkteyWSGRMf7pepo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmJqX2+bvTbSamZs/fBJRLRBOHT2JoJIxMSa8oA9iBMEVF5GX8Q0NjXZV4YyAyNGwz5V6jeph4JtlbNSYI4Qiw6N5Dej0IAz+7mF0qWYNjZmaCwuB9zN5NC8ciswu9Xj9ItsS7nGU24NwT9pAFk9mMJywuzA3eZHdK3x/EK3/z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K+kPGZS6; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K+kPGZS6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774906387; x=1806442387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dj91uacxVecpa5voFWCqOyWoMImRkteyWSGRMf7pepo=;
  b=K+kPGZS6HpqIu4XV4f/UcaVwz66iO1zHSyOqYodSUmVvy5FDUEloInHQ
   wPwHCbSzutgeNqRzcWZWk4g1Q/KM3mDqOP/3HkmWmntXD9Z2RgXSNxvGd
   Zl+OnDn8lFUX4wUN5MyENwBCBsw4J7auKkCHU6kgU8Mc8DBBAtA5rxsQ4
   U+0MO2yhT4ozmL/UsDIC9/b6gJDX7LSsa78VgWD13PujtzWq+C9RgndFI
   egT6uObiD0KrfKbhnKoq9DZ1yeskvqH1gNTll/zEiLuaC/Wv54ViiXcOq
   ahUT7lENKv9nUklZjWbooClXj4EpzjQiOGnpRNniaWNkgV4zxy57SwOZr
   Q==;
X-CSE-ConnectionGUID: 7QiLgV9oR+WrTEoqL2Sajw==
X-CSE-MsgGUID: hi60cEODTWmgct3PK2IlUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="101366825"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="101366825"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 14:33:07 -0700
X-CSE-ConnectionGUID: 2EL/tTtlSteUtPfvcsXlbg==
X-CSE-MsgGUID: BPBTC3oQTLeC+af8ddxfXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="227779540"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 14:33:06 -0700
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
Subject: [PATCH V6 3/5] perf/x86/intel/uncore: Do not treat -1 die_id as error during UBOX scan
Date: Mon, 30 Mar 2026 14:24:42 -0700
Message-ID: <20260330212444.117325-4-zide.chen@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330212444.117325-1-zide.chen@intel.com>
References: <20260330212444.117325-1-zide.chen@intel.com>
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

Fixes: 9a7832ce3d92 ("perf/x86/intel/uncore: With > 8 nodes, get pci bus die id from NUMA info")
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2:
- Fix the commit message to note that spr_update_device_location() is
  used by EMR, not GNR.
- Rewrite the commit message for clarity.
- Add a Tested-by tag.

V5:
- Removed unused die_id (Dapeng).

V6:
- Move the spr_update_device_location() change to a separate patch.
- Update the comit message and title to reflect the reduced scope of
  this patch.
- Remove Tested-by since the code has changed.
---
 arch/x86/events/intel/uncore_snbep.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 9b51883fd6fd..8ee06d4659bb 100644
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
@@ -1458,14 +1458,9 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
 				break;
 			}
 
-			map->pbus_to_dieid[bus] = die_id = uncore_device_to_die(ubox_dev);
+			map->pbus_to_dieid[bus] = uncore_device_to_die(ubox_dev);
 
 			raw_spin_unlock(&pci2phy_map_lock);
-
-			if (WARN_ON_ONCE(die_id == -1)) {
-				err = -EINVAL;
-				break;
-			}
 		}
 	}
 
-- 
2.53.0

