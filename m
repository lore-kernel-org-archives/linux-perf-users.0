Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05B23D34B9;
	Fri,  3 Apr 2026 17:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775237395; cv=none; b=nqDeFqaOgyomL5FYA/dRHelE7u6k2+GyJGwTubroiCvBuP4cOC+g/7fa0sRwaKsd0i4rlsmO6lhABbw6YKix5S8tgK+Tb6xatgz++hjyI1Qp1+LgdqaeSkEssqsxFxQshIey774Ww94TkSa2H6iVKTs1RqqqhgLtdaxAKJ/Ugew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775237395; c=relaxed/simple;
	bh=VPGV6tQASjrs8ZRo0svRSe1KwjRS42I4kc4FGiFsgcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tiS+ir6WN5UL+/vgwzHcBheJ5SuEJkXd0scxJupzn6bbXTnpttOCC+rweT39GWEZEVj2Lm6w1nPF7tQuilqba9AeIrYotNcLB4ImGOHjG04x69TdAgl4J3WAdhrHn6zEFJYPmhh152Inskha0YoxignfhQ9cLDd4LvrIen4V8XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j2vsArz6; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j2vsArz6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775237394; x=1806773394;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VPGV6tQASjrs8ZRo0svRSe1KwjRS42I4kc4FGiFsgcE=;
  b=j2vsArz6zQXMOUSzucWzmOU2aTxipIAfnmBneu++KzyTCwtDBklgGNjC
   JIM5xHv2kej/mdh4k4c3IlXlsVJEC0DULEbyXSXELljgKkG+o59/zKoqf
   5Hngidqfek8uqOfYT0Z6j0vW4XUcJIb8HLTHD/ETv/kB2tQhPnZ7Z1NIw
   yo7TozXxiAkLHOd78AM1Pk9SndIAP1oEYuMBagm0YgbOY36SobXuOXEie
   Q6Wa1BrShpb20vnUqTnW1ccpKfU/OLkiRZmjkCbfto4uFz8dRM5edxXdp
   oKUHn3pZIlDolSDvDzKzg17olAruX+jaFSPkkJuVwNPMUla6R1nKCV5zc
   A==;
X-CSE-ConnectionGUID: jaVztr79Qgq1eb+348IjSw==
X-CSE-MsgGUID: CqDN1c26ShaUcIlA0z4ckg==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="93693318"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="93693318"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 10:29:52 -0700
X-CSE-ConnectionGUID: +bHt8SI/TnWghy6jtbvMBg==
X-CSE-MsgGUID: CWOblxqHRi67f52I0MK2lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="250525262"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 10:29:51 -0700
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
Subject: [PATCH V7 3/4] perf/x86/intel/uncore: Do not treat -1 die_id as error during UBOX scan
Date: Fri,  3 Apr 2026 10:21:45 -0700
Message-ID: <20260403172146.158172-4-zide.chen@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403172146.158172-1-zide.chen@intel.com>
References: <20260403172146.158172-1-zide.chen@intel.com>
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
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
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
index 0a1d08136cc1..742f8cb2eac5 100644
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

