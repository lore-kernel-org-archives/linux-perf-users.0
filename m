Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940155;
	b=ceFqJZFwbc6MbzvJhzHsnJKo0JKhLl20K48b3cXIuuZKs4XFd3+GxX4312s5mGzuakjO
	 s6chajoDDicQ8NBoI19S6HosL02Jjullt79Yn/0Bnz6lP+lKjCsw1Ec5kHBMl4zl3iwTP
	 Osgfdh2RYvJK0pCN35bRVbXriIXDC58my7azkWiCGaLILz0yjCgQxovedUh8VdRZBr5QG
	 jx9l1Y4AZ8BR7YZpUGCJU2/RsF6OATEJyH6tWUO0Z0zenJ/LUwvn6VgsiW8JVBiNYaobl
	 o/qcc3bh1diUmV+cd+m6UWcxpEYKQwLZEc+sldSx9NWvET/dVxuV5fqegA/4nSzB70A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940155;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=taJtOGUMeiimV9wFe4AQrYsuvv75Pc5faUl+H/TilkI=;
	b=vNUKAhM6zM1UXT/Ml5V3nyP6tJTv2AUPmUCfePRLwYwl7+kZ9E+yF9SQLrN+iV8cLGnB
	 YuT3ku46V8L8ztQ/Yr01DXO8YFEyx5xZq77VghzfbFZZyhuEriNKDqhMAQlnvksjLkJVg
	 5G27Zfdj1T2dO8DnwepzU6ErvK5hRkt8XJlYPFynrfZ2oiKdSZiFIrrpbatt3ZGmik2Zu
	 RS3TlrC/OXBYMN5bbxX7hITPS+nwypKYNndIDI7vMw+T/uCUramgo8ii8b5qtSkDyyfEj
	 YWq3/gpgvhmT42scfUDDUW/pwcLG1P2YU8HP9h961kFECgXdvpdYNcPlEb4cFHuV1jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F0WVUMw5;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C06606A31B;
	Fri,  6 Nov 2026 04:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8C06606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F0WVUMw5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793940155; x=1825476155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TiOVDnEH50imV1Sr3EH4VGEy/pGz3iluGdUCzzy5yiE=;
  b=F0WVUMw50oJf3/DBVcxVxZXQFmwO1F0uN0RjqBiTlBmpuGqdoASI9nAe
   Bl8ndgb6cxxY72WIkm0S5RRSTHtUZYnwYD7fRLHmLm5lGy0lm4qLzUsae
   uz2Gpb7LUJ3WWInPTM/O9LHkAamkcH2jdnKHVre4EpBnAAO33JIZx5e0H
   TROVv0ESs8aIInZVPnBgXX7u0qkewzo9lhlOHAwMFtGejVNrEPRmb/dST
   cDzFeP51ynkovHKCyWcJH3cEpxOOY5rLV0mFxla5g/gkrz7/QL44Mdirb
   3uT6IE/QQTg5YQHW/bCkZDCfVKU6nfmGuGC++I5ANWrwhIlqhnEZzfjDy
   A==;
X-CSE-ConnectionGUID: vmo9FWPZTWSk4gOvGQwhOQ==
X-CSE-MsgGUID: ZmR7sx1tQ8SsLfnnHZgxkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2780906"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2780906"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 20:41:45 -0800
X-CSE-ConnectionGUID: d1KUa6ruSpCntXcRQHXhhg==
X-CSE-MsgGUID: Qu2Sp1/lRK2u+YsaTfPvbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7222994"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2026 20:41:40 -0800
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v6 14/20] perf/x86/amd: Refresh LBR stack in PMI only when LBR users are active
Date: Fri,  6 Nov 2026 12:32:51 +0800
Message-Id: <20261106043257.842864-15-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
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

Refreshing the LBR stack in the PMI handler is unnecessary when no LBR
users are active. This adds avoidable overhead and hurts performance.

Limit the LBR stack refresh to the PMI path only when LBR users are
present.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Cc: "Sandipan Das <sandipan.das@amd.com>"
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/amd/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 160102a46b18..f0425e369837 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -988,7 +988,8 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 
 	/* Read branch records */
 	if (x86_pmu.lbr_nr) {
-		amd_pmu_lbr_read();
+		if (cpuc->lbr_users > 0)
+			amd_pmu_lbr_read();
 		status &= ~GLOBAL_STATUS_LBRS_FROZEN;
 	}
 
-- 
2.34.1

