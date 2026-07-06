Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8973A872C;
	Mon,  6 Jul 2026 02:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783305650; cv=none; b=uRcUwbW496VwXS1zzk0idI29DzYQkIhD7ydmYw58Dh5qttXOGG9hVZArj5pv8jnjvJLmutWpaZ92QFTYy/TyOIfnNXcLX5vEO+HQxQZPJW7PBzLbgrjwflTdE53+66Bq80IuklvytFfrrQZ9cv7qex2Mc8gyWGmMzpuX25+Z73E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783305650; c=relaxed/simple;
	bh=pxJzxFGmovWLPUDuWUNj9KZYnkLCj1OxBc/huuuNsV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ohnEcSZqy2DQFijR3LFycYRkH0Dpq3ZWQD2XA4rWe2tMyfREgr4qsBDT8TTo0mSU/W9fiIiQHdDyPswSDwUq6siVZLlaYYWjoxAF4PPAua8/ju3oQQ6Fnit+Ku+YCpcrSmJIjvuAgjo3Tn1fnJHH2gWOrcGvEMHlv6EeSp6Y7HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XiZfiHvN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XiZfiHvN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783305649; x=1814841649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pxJzxFGmovWLPUDuWUNj9KZYnkLCj1OxBc/huuuNsV4=;
  b=XiZfiHvNrXrgkqJ7ZoJjq0OqKKLZRkD5rhlp3G6HH29UD8bFwO+RS1Yi
   xVFInQPSabUWE2RtV2Ciqu50dB5tyzPMNkTPolIOWULnZ5dIBNRRPVTwC
   FE2mVvyr0ipzhh9z+V7dxrzzxF80H8iLyPjxxfm+RAxwuSK6z7vuBh78h
   c/YopoAbBcYvgj809eZkaSeLGX7CNLARZdB24nogOxY4c3MJdJYB0DeJX
   Ghewhpn1VxEn2B+59BO3oPewZQuJf/BSTZ5SdPan5ybaEh/nouna4YTwt
   /SSlwAuor/1gPtNDAJmkw8o2eLyFodCHxFeHtT0WrNR10PduOcE0znPyv
   Q==;
X-CSE-ConnectionGUID: phrD7l+UQSio3xZsOLHYIg==
X-CSE-MsgGUID: 2U6WIyRVRK6XaUey5TKssw==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="87614027"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="87614027"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 19:40:49 -0700
X-CSE-ConnectionGUID: ryr4t7TLSDmcfKxpYOhrvA==
X-CSE-MsgGUID: wo+jchQVQFSnLLQUl6DtlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="253716687"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa007.jf.intel.com with ESMTP; 05 Jul 2026 19:40:45 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v9 01/10] perf dwarf-regs: Fix DWARF register index bounds check
Date: Mon,  6 Jul 2026 10:34:35 +0800
Message-Id: <20260706023444.3067660-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706023444.3067660-1-dapeng1.mi@linux.intel.com>
References: <20260706023444.3067660-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tighten bounds validation in __get_dwarf_regnum_for_perf_regnum_xxx()
helpers by changing perf_regnum > ARRAY_SIZE() to
perf_regnum >= ARRAY_SIZE().

This fixes an off-by-one condition where perf_regnum == ARRAY_SIZE()
could pass validation and cause out-of-bounds access for
dwarf_xxx_regnums[].

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/util/dwarf-regs-arch/dwarf-regs-csky.c    | 2 +-
 tools/perf/util/dwarf-regs-arch/dwarf-regs-powerpc.c | 2 +-
 tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c    | 2 +-
 tools/perf/util/dwarf-regs-arch/dwarf-regs-x86.c     | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-csky.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-csky.c
index cb44b774f8d9..7f976aa3cfa2 100644
--- a/tools/perf/util/dwarf-regs-arch/dwarf-regs-csky.c
+++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-csky.c
@@ -118,7 +118,7 @@ int __get_dwarf_regnum_for_perf_regnum_csky(int perf_regnum, unsigned int flags)
 	if (flags & EF_CSKY_ABIV2)
 		idx++;
 
-	if (perf_regnum <  0 || perf_regnum > (int)ARRAY_SIZE(dwarf_csky_regnums) ||
+	if (perf_regnum < 0 || perf_regnum >= (int)ARRAY_SIZE(dwarf_csky_regnums) ||
 	    dwarf_csky_regnums[perf_regnum][idx] == 0)
 		return -ENOENT;
 
diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-powerpc.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-powerpc.c
index 51892a09725b..98e7f2b2791c 100644
--- a/tools/perf/util/dwarf-regs-arch/dwarf-regs-powerpc.c
+++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-powerpc.c
@@ -128,7 +128,7 @@ int __get_dwarf_regnum_for_perf_regnum_powerpc(int perf_regnum)
 	if (perf_regnum == 0)
 		return 0;
 
-	if (perf_regnum <  0 || perf_regnum > (int)ARRAY_SIZE(dwarf_powerpc_regnums) ||
+	if (perf_regnum < 0 || perf_regnum >= (int)ARRAY_SIZE(dwarf_powerpc_regnums) ||
 	    dwarf_powerpc_regnums[perf_regnum] == 0)
 		return -ENOENT;
 
diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c
index 310a37451bdc..9cef846ef9c0 100644
--- a/tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c
+++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c
@@ -45,7 +45,7 @@ int __get_dwarf_regnum_for_perf_regnum_s390(int perf_regnum)
 	if (perf_regnum == 0)
 		return 0;
 
-	if (perf_regnum <  0 || perf_regnum > (int)ARRAY_SIZE(dwarf_s390_regnums) ||
+	if (perf_regnum < 0 || perf_regnum >= (int)ARRAY_SIZE(dwarf_s390_regnums) ||
 	    dwarf_s390_regnums[perf_regnum] == 0)
 		return -ENOENT;
 
diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-x86.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-x86.c
index cadef120aeb4..c2a70e03b1a9 100644
--- a/tools/perf/util/dwarf-regs-arch/dwarf-regs-x86.c
+++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-x86.c
@@ -197,7 +197,7 @@ int __get_dwarf_regnum_for_perf_regnum_i386(int perf_regnum)
 	if (perf_regnum == 0)
 		return 0;
 
-	if (perf_regnum <  0 || perf_regnum > (int)ARRAY_SIZE(dwarf_i386_regnums) ||
+	if (perf_regnum < 0 || perf_regnum >= (int)ARRAY_SIZE(dwarf_i386_regnums) ||
 	    dwarf_i386_regnums[perf_regnum] == 0)
 		return -ENOENT;
 
@@ -252,7 +252,7 @@ int __get_dwarf_regnum_for_perf_regnum_x86_64(int perf_regnum)
 	if (perf_regnum == 0)
 		return 0;
 
-	if (perf_regnum <  0 || perf_regnum > (int)ARRAY_SIZE(dwarf_x86_64_regnums) ||
+	if (perf_regnum < 0 || perf_regnum >= (int)ARRAY_SIZE(dwarf_x86_64_regnums) ||
 	    dwarf_x86_64_regnums[perf_regnum] == 0)
 		return -ENOENT;
 
-- 
2.34.1

