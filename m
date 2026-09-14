Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1E42E7396;
	Mon, 14 Sep 2026 01:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789350464; cv=none; b=bEZWUvLgSQqkGoDtwKOmq/2c3eEhT/C9Zasn4eAvINBnPY6u9nhWD/walvv3BCilco0Qz2LEV8HDXX6fmWD9vim8a0FIp4hUXgz3E7B3V1LuwrDKlkowGy8MM68vEyeq3pX3diGuLtniG9bDhsOVyP1l6YrMSBZwI86unSwpegU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789350464; c=relaxed/simple;
	bh=pxJzxFGmovWLPUDuWUNj9KZYnkLCj1OxBc/huuuNsV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E37W/Gyq3/WEpm0+ca9veYHeXGNKcgqJLhS0dGaRsr3rMmafMGb5Z760aBi0Ea0XZMTSootloPM3uMhsvY2GF4dGPh9CP/U/1gkA3FSoF5myTF4QUFL2F1sWS9t2WYjv1BkG9ESgUQkT1yEVwrt7mZpsx3G4b/XVuRm6oXQ5kMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=USWZnZbs; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="USWZnZbs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789350462; x=1820886462;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pxJzxFGmovWLPUDuWUNj9KZYnkLCj1OxBc/huuuNsV4=;
  b=USWZnZbspViz1l+3PSa24zVlix11Def6CRMJLp572yzqu0nFNQfiDAiV
   JJsXXZC3ZmLhJlSiGdMbEw+jM3s1Kvps5f87iGfndV/DRdXcZk+kizg56
   EDPfXDA+0dunKsgwVzqijfNJVBevo3L2TlTt0hc6nJiFWKb1aiqbqKq9g
   Pt5wpDHPX2TTJFi1VjKa/l2LS8pzt78h9YcAGpj30pAkF2g9R2uv1RA/7
   xkO2F0w3DlPmj/XPD4mGKQUsmFdm8D6MztsSq55TPxADvkAviIx9726Yb
   4dEegg756mkVy9pYAl60yK9ByyD2J/CEAEcSA7sqqpYrzVuhO8s22Leyi
   A==;
X-CSE-ConnectionGUID: mxNAPk0TReeS0SNay+MGjQ==
X-CSE-MsgGUID: ufqe9Jj4TJ6itDRq7fMUIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="93530599"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="93530599"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 18:47:39 -0700
X-CSE-ConnectionGUID: 0pdkMLfaRoih3Gp+j6Jvqg==
X-CSE-MsgGUID: LhH+G2tcRX6hZ6KNfCFD3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="276664150"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa005.jf.intel.com with ESMTP; 13 Sep 2026 18:47:37 -0700
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
Subject: [Patch v11 01/10] perf dwarf-regs: Fix DWARF register index bounds check
Date: Mon, 14 Sep 2026 09:40:40 +0800
Message-Id: <20260914014049.2061519-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
References: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
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

