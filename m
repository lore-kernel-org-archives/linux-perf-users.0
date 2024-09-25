Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DFA79E5;
	Wed, 25 Sep 2024 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727289423; cv=none; b=UQofGat6HfILcXun0h/t+38pUWmt0XXLHhPIT3FRnCZvNISAhVgQdiZqGUoEHDVzQrjgqJnmKhiiANZAHbeNlsYX01Jz9tO9Dg3jHVRkh+9p5a8Om91cu3X/7BgEweZUr2yN6iLe63QtNraqidBO9FXTpqeGSZISz0JY0DccSNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727289423; c=relaxed/simple;
	bh=3m9rh2T7dtVX+t2FJhSFMX72fNeXjE0kMdDHE+4eAvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oE6x9hGLzxXP4cNy/cGj5dV5J6vmnzdpe48+yjHi+R4kA+yurdgGaOjI5/eI45kGOEawFl2w68uLKQlpw0Vefst7ZpVC4rXk7muu6x5EU/83UWyC8Aq1SEM0TOYQD8aXal5bJfcLCcp+tHtmHOxzmQb6dp7cO+5xUxBG7rYD2/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oKwSzfEs; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oKwSzfEs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727289421; x=1758825421;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3m9rh2T7dtVX+t2FJhSFMX72fNeXjE0kMdDHE+4eAvY=;
  b=oKwSzfEsyWKffDjlgFHgOHz9KHKrBSNvexefiQ1y+yB2aBm9owGfFErY
   DRN7Ab3e9SUkM1kQWjrajfcg2G6N1vFpXSdvrJCu9B4eJNkYhcNDhoNYn
   ipjDWfXIoknaJv5UIjlpOEhntKP3el/CYdbsCTu21OVvdzQWXKaoee0e7
   xKXWHAdS1SGxOL422JZ/COyAhbb1OcQVunq74adKR5NVg5IhIbeRydfKg
   XvvOAAp3DkeoGxwZMYnNjHmCgf6mFpAVief+8mBIg6plE6XRhoFS2RYK9
   GX4Loqv31XH9YddrHScU3NdFLHZPd9rUe1eQSypQ/g3G7OYUh0TTf7smB
   g==;
X-CSE-ConnectionGUID: 7B2jhrmCSe2szvR5ZpRSrw==
X-CSE-MsgGUID: LjVn1p/CShOMHp/3oxRoYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="25833564"
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="25833564"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 11:37:00 -0700
X-CSE-ConnectionGUID: W8u3W9oVT1u1gKevnfqncQ==
X-CSE-MsgGUID: DDzss7AUQE2cYGOnpAHqug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="76664665"
Received: from tfalcon-desk.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.124.221.144])
  by orviesa003.jf.intel.com with ESMTP; 25 Sep 2024 11:36:59 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: [PATCH] perf mem: Fix printing PERF_MEM_LVLNUM_{L2_MHB|MSC}
Date: Wed, 25 Sep 2024 13:36:33 -0500
Message-ID: <20240925183633.49653-1-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 8ec9497d3ef34 ("tools/include: Sync uapi/linux/perf.h
with the kernel sources"), 'perf mem report' gives an incorrect memory
access string.
...
0.02%	1	3644	L5 hit	[.] 0x0000000000009b0e	mlc	[.] 0x00007fce43f59480
...

This occurs because, if no entry exists in mem_lvlnum, perf_mem__lvl_scnprintf
will default to 'L%d, lvl', which in this case for PERF_MEM_LVLNUM_L2_MHB is 0x05.
Add entries for PERF_MEM_LVLNUM_L2_MHB and PERF_MEM_LVLNUM_MSC to mem_lvlnum,
so that the correct strings are printed.
...
0.02%	1	3644	L2 MHB hit	[.] 0x0000000000009b0e	mlc	[.] 0x00007fce43f59480
...

Fixes: 8ec9497d3ef34 ("tools/include: Sync uapi/linux/perf.h with the kernel sources")
Suggested-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/mem-events.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 051feb93ed8d..c630aca5bd93 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -366,6 +366,8 @@ static const char * const mem_lvl[] = {
 };
 
 static const char * const mem_lvlnum[] = {
+	[PERF_MEM_LVLNUM_L2_MHB] = "L2 MHB",
+	[PERF_MEM_LVLNUM_MSC] = "Memory-side Cache",
 	[PERF_MEM_LVLNUM_UNC] = "Uncached",
 	[PERF_MEM_LVLNUM_CXL] = "CXL",
 	[PERF_MEM_LVLNUM_IO] = "I/O",
-- 
2.46.0

