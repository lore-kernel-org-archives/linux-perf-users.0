Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923BA211484;
	Thu, 26 Jun 2025 03:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750909376; cv=none; b=Hbpmt5puiY31hfvDIAbU2FmhEqKITLCXS69mqGJzUdHO4Q6rSIX3QeRxRqquOs9gMEP57XkuI5sPS+4Exh81w/uStaeaLQKE4EtWN2+DojlVq/kv+zs8S2iUG1HMdxU7/t7BSqq7AUIHB3TXA36pDwKfLndsiu2x6j5pYfRKZwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750909376; c=relaxed/simple;
	bh=YEs45um8p0o2itFyLXOdaGto9fyRxO/S7GlBG43wn8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqY6PqVfMY3WgWSBw68HVaZjdKKMOxftSqBeHxenLfmYj6QJqcboqo2qLjBN8SDP9yQBmbkl8aLV12ueT79Y3oIwiNe7Ln76KyASuN9ARfhGAa3dij9kxLDnU84V1/ipng0GzpK2sCdJWL2pRnQceUUQy8ZWeACA9tYYi7j9ykc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RZgD9vxS; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RZgD9vxS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750909374; x=1782445374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YEs45um8p0o2itFyLXOdaGto9fyRxO/S7GlBG43wn8M=;
  b=RZgD9vxSh/EpFVd1iSwtC8wTDvTJlTVK/+aMVW/t079lJMYYAquXe1zT
   erxq+EmR+gUmulvuMa5kN6Q3HJqlE2H6RU4UONdj+TURRGzI5MgW0OLUr
   bUUhojCKKGdilRtrgTCK/a9G3Fah/3zcTxeJ8FOzWkuANpH5ArBQATo9Z
   Xiwd9f/m9EtNPAM24ydG+J0kH+gWxeCGBq3oO/1CSdIMO35pgareHoiuf
   6Pxl/OGrf8DO4gf6u5ZKBrgwakU38VPix3flcGLY6hI0tJ52rrpgoiZj/
   y2l0x7oBZX3o/Wg/bDdGuVizBPBVyyl/ZmUNjYLs8TEYOKNY4xKVABsop
   Q==;
X-CSE-ConnectionGUID: H3i4G8adQsibFjP9Ko2/Pg==
X-CSE-MsgGUID: 0OwuzSSuQ2ieBOCY6iNUAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="55820644"
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="55820644"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 20:42:54 -0700
X-CSE-ConnectionGUID: kXKi7mW3TAyFtsM/hdJ82w==
X-CSE-MsgGUID: CsnvJ/GuRxSKVbCFJjxA+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="157894956"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa004.fm.intel.com with ESMTP; 25 Jun 2025 20:42:51 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v5 02/10] perf/x86/intel: Correct large PEBS flag check
Date: Mon, 23 Jun 2025 22:35:37 +0000
Message-ID: <20250623223546.112465-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623223546.112465-1-dapeng1.mi@linux.intel.com>
References: <20250623223546.112465-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

current large PEBS flag check only checks if sample_regs_user contains
unsupported GPRs but doesn't check if sample_regs_intr contains
unsupported GPRs.

Of course, currently PEBS HW supports to sample all perf supported GPRs,
the missed check doesn't cause real issue. But it won't be true any more
after the subsequent patches support to sample SSP register. SSP
sampling is not supported by adaptive PEBS HW and it would be supported
until arch-PEBS HW. So correct this issue.

Fixes: a47ba4d77e12 ("perf/x86: Enable free running PEBS for REGS_USER/INTR")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index df51c284cae4..9f957cf459bf 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4032,7 +4032,9 @@ static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
 	if (!event->attr.exclude_kernel)
 		flags &= ~PERF_SAMPLE_REGS_USER;
 	if (event->attr.sample_regs_user & ~PEBS_GP_REGS)
-		flags &= ~(PERF_SAMPLE_REGS_USER | PERF_SAMPLE_REGS_INTR);
+		flags &= ~PERF_SAMPLE_REGS_USER;
+	if (event->attr.sample_regs_intr & ~PEBS_GP_REGS)
+		flags &= ~PERF_SAMPLE_REGS_INTR;
 	return flags;
 }
 
-- 
2.43.0

