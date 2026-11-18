Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972210;
	b=D+dKqyBy1HfwDpJklrf7GbWVr2Chx/xE54V5PDY/2hKjEPK1mqLHtnyqtwJkoB0zq6JU
	 m/BekqevXvR5VM1DctSbity7TXkKxZ1MLbahgWLI8Ng6CM8KoyaGT/hi0CITdVdbYYxL4
	 QUMhJPuF0Mq6OytC5bDXiBDgbiq1C2B6Mg61eaQMnvsThFvSrR5zq6gYxRJ6re3O/YpWr
	 5UbLzQRg+LRFLjT3RYMSVUzaKzOquRoSt4SfmMIt/6JZR/jATfwrd/rbg1HVMgxFMXhxO
	 lxup0FA9ZJlhySId7RV60zQhEBgPEXvXLeRqjYM7z4LXWIm4j5SQS960bb1LUaGy8Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972210;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SFZI8DMJr6ICKqt/QHsab30TQ8uvnKCHxHfkAhfGgPQ=;
	b=VPpPaXFMA53cz9QD6Llzm31P/rOaP0Ud58FQBgBkie1HFIJ+qUfsN5au/CrAbpREzHi4
	 tXQ9JlNT3iwjSOYXnxSsoP/9JBc7xFGGSZD7hhmxmp/KcdhGlJ/k0gADAAiJRLKpbxVRA
	 RRbaa9MdlAsfRuGf0grbNRAtOKVav96Uo9LgUbk4/MDAlGKjT6udKePzawQX8DQCt202N
	 NABQLW0LeQ3HEa3/9mHfvaYhjECxw8eseM2sAshFGQ75ch9+CCh17JUnC2xnMfVUxAbFd
	 J4omOSl3Khc8dcn75t1z6P5LLYAX0UKYsN1zGP7SunggBj+HUE/aSSgoHhGpYWFYKjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WnBtuEMh;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE4E606A325;
	Wed, 18 Nov 2026 03:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FE4E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WnBtuEMh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794972211; x=1826508211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hLC8ZGkwaTfu6ZnXT5i21CGE3UrgbMZUHhQ0ocJXqYo=;
  b=WnBtuEMhfWKNvWfkrkvxFp7ZjUXPCFHIn5er88fXUPg3ubA1/r7esnaZ
   DrzmBoONgY30lBSUT48IAgtZlVuvatzASCpXRh9KBsIlrKqjLbYsruPlm
   v75t9Fw0hmbDLZNMW9KePGPZV2r8s8uL94dsDxwIZUeby1s+YyoS1aI4m
   YPzOJ7Xvx5E+OGLBrVEXR9+09eEgiaUD1SVGADWKxkI9Iy9+oTQ2rzGqL
   lB05+htbyz5WrICXaxaVUmg9/RzmpXT9MKnxnU0/zzJ5dy8btXER2Qa2z
   sKHd1oqzPDwn8YNud2dxmm+gOxxWxrrb6WHMmiVrFO1E5l2CIqWL75b4a
   A==;
X-CSE-ConnectionGUID: Y5Y/+eatQhqxi/JqTIqNug==
X-CSE-MsgGUID: fE7dYICPS7C6MDrcgmwnxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3629835"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3629835"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 19:23:04 -0800
X-CSE-ConnectionGUID: HBm8/BWhTz6fDv0/EJ47Iw==
X-CSE-MsgGUID: ART678GsQqytKS48i19hdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9894138"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa004.jf.intel.com with ESMTP; 17 Nov 2026 19:22:59 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v7 03/24] perf/x86/amd/lbr: Limit branch snapshots to valid entries
Date: Wed, 18 Nov 2026 11:14:32 +0800
Message-Id: <20261118031453.1353625-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sandipan Das <sandipan.das@amd.com>

The branch snapshot callback used by bpf_get_branch_snapshot() copies
up to x86_pmu.lbr_nr entries from cpuc->lbr_entries[], even when the
last LBR read kept fewer branches. The entries past lbr_stack.nr are
invalid, but they end up reaching BPF programs.

Limit copying to lbr_stack.nr entries and also reset lbr_stack.nr when
amd_pmu_lbr_read() skips reading the registers, so that a stale count
is never reused.

Fixes: a4d18112e531 ("perf/x86/amd: Support capturing LBR from software events")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-163130@kernel.org/
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/amd/core.c | 2 +-
 arch/x86/events/amd/lbr.c  | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 49b6b8fce566..bf631f60757c 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -944,7 +944,7 @@ static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, u
 	cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	amd_pmu_lbr_read();
-	cnt = min(cnt, x86_pmu.lbr_nr);
+	cnt = min(cnt, cpuc->lbr_stack.nr);
 	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
 
 	amd_pmu_v2_enable_all(0);
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index a55646fcb846..6c93b8042c73 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -168,8 +168,10 @@ void amd_pmu_lbr_read(void)
 	struct branch_entry entry;
 	int out = 0, idx, i;
 
-	if (!cpuc->lbr_users)
+	if (!cpuc->lbr_users) {
+		cpuc->lbr_stack.nr = 0;
 		return;
+	}
 
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
 		entry.from.full	= amd_pmu_lbr_get_from(i);
-- 
2.34.1

