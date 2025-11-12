Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65103237A4F;
	Wed, 12 Nov 2025 06:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762929509; cv=none; b=DaqfOFSHkI5aDoofv+hB2cyQ063NR8e18QHR7ZhlZnmMumZC8DVHeneWy57HMDRAJcr3quyWOMDyKrzWb3Nmj94BnlvcbVgc3GvcQaYIAp3NXlQ6BHVHr75SdDGpUD9t9Ou4MISlica9XAhEpvfgFUb8WyJGcyK/dRm2Lwqf8tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762929509; c=relaxed/simple;
	bh=UWK4MvxcJ9V9gvPyJfgUko5Hc8Kib14+n5ys0xoap9U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q0rRIaJZv4hCbn/5WRc9rl0YYHYRUGQvQ4AKykgxxSua/P4/800SdD+ZT6Nlg73gip3+T0uVQbesV2ED9EmRvfUsrD0yaW5Vk/w3Acl7wo1sd18tU1Ba4BD6CTYrdYq8xFrpy9o0CEp/20H+89rosfhZclRha2UOlWatTeIITNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RLW3qxRe; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RLW3qxRe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762929507; x=1794465507;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UWK4MvxcJ9V9gvPyJfgUko5Hc8Kib14+n5ys0xoap9U=;
  b=RLW3qxRebOb/Y6gCURNFsvEL0Uh6Ql/WcTBKKedwa+klVJR7ID0SNm9S
   DO4lXka31xDNp4wYeVdHgLzSJaDtqg8q3p8TegVrXLNh00P4f+/t31pNq
   kb0QWTvMJgYWOCD7QwoM+5gFD5p3U2L5yzySOhiR45Zi0iSX1CANMWHCu
   MM5rbQaX609Nu0iUgT0ksRf0MaVtTBj0eU5DIF2kdxhSlAY3Jv4Y0EDob
   NyEnJUesMSXTUsiEKYcdruM3Zb1R2ugNwc67RMyS3LTHl4GMaQkYr/eXU
   r9NJuUSByl2DcehZWsxC1Z5DqYplf1xQdHan5nfh/3KiFAd7QCo4zleO0
   w==;
X-CSE-ConnectionGUID: 5jDPiF7iRXaPgYz1UK0YlA==
X-CSE-MsgGUID: 6adNsMS4T8mZbG3InIp4Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="75602067"
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="75602067"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 22:38:26 -0800
X-CSE-ConnectionGUID: QMvEo/tXQGiD9quo1YjeGw==
X-CSE-MsgGUID: tuNjSZzbQQC9RW4zDtF6/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="189571577"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 11 Nov 2025 22:38:22 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
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
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] perf/x86/intel: Fix the building warning for i386 arch
Date: Wed, 12 Nov 2025 14:35:43 +0800
Message-Id: <20251112063543.3914136-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The warnings below are seen for building i386 arch image.

arch/x86/events/intel/ds.c: In function 'intel_pmu_drain_arch_pebs':
arch/x86/events/intel/ds.c:2983:24: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
 2983 |         top = (void *)((u64)cpuc->pebs_vaddr +
      |                        ^
arch/x86/events/intel/ds.c:2983:15: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
 2983 |         top = (void *)((u64)cpuc->pebs_vaddr +
      |               ^
cc1: all warnings being treated as errors

change "u64" to "unsigned long" to fix the building error.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20251112154200.4d3671f9@canb.auug.org.au/
Fixes: d21954c8a0ff ("perf/x86/intel: Process arch-PEBS records or record fragments")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index c93bf971d97b..f695de9f7049 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2979,7 +2979,7 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 	}
 
 	base = cpuc->pebs_vaddr;
-	top = (void *)((u64)cpuc->pebs_vaddr +
+	top = (void *)((unsigned long)cpuc->pebs_vaddr +
 		       (index.wr << ARCH_PEBS_INDEX_WR_SHIFT));
 
 	index.wr = 0;

base-commit: 2093d8cf80fa5552d1025a78a8f3a10bf3b6466e
prerequisite-patch-id: a15bcd62a8dcd219d17489eef88b66ea5488a2a0
-- 
2.34.1

