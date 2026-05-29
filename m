Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605603B4EBD;
	Fri, 29 May 2026 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041774; cv=none; b=fOBXQjMZ3X9m65TDgyJlceLYrsiRCcWuogLOx/+GGueYxgKj31kOZNAM6Hqttat0uLKl+ygU4XYnDdGUFWSNjCLqo25l4SWqck8JVwZNmX5mVxWg0JMNi8jq+x6FaOcaNCMwosGFpkvM2nzwzHJvRxVTsA7CN0U1xdJx5mcOu/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041774; c=relaxed/simple;
	bh=pbwTklKfyTOR62FXYb0qiVQZjglvINP5HCMkoD1yNlw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=beQbbqM/TYICPo8ZeTpp0fZifuA3BpWTcXULqWM6wZDCdeQTsdRpxLVQ5vH3O46GpQPNjf70z65m69GHy+oGXo+Qs3JFCHUcrDfGl0CpVDacLdglRAYU4b3Kr14XEbATbMEv5Ptau6BnKTHXRXsvfqPLaKWWbu5ZDzP0399eBA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ACZf2N3W; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ACZf2N3W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780041770; x=1811577770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pbwTklKfyTOR62FXYb0qiVQZjglvINP5HCMkoD1yNlw=;
  b=ACZf2N3W8neoS1WhYfxII1N2+Dds6J47IZrsDxhUoWwIOOY7lLOz8ivA
   YmsIRCxNjYwwU+LeLw+vXxkOxSEmTF8/UVnKJAOXzrMotXyPKSPET8fKh
   cXYi7ZSjNOjuRvh0uvs+6+eYK0eZb7HIaSjlivUltyae2fsnWcqdvUbkT
   +Vyvf5WBnXmgblY01sNdNXMKgSg76k5o7eNp4p/mQ7jZ5Me3GYd30GYdo
   UrfN1hB8t1B7KigWnAnreZy8KIH/OZ7Xgi0264qHNvaupdwEM7S1fGJpI
   /Rm5nSVud/NtS9JMlQwC510MinwhSKQsxD3HGXvcWSN1eIaoYQrszicoS
   w==;
X-CSE-ConnectionGUID: 2zf3IJQkRuGIXTEmAMa6Xg==
X-CSE-MsgGUID: GdWOO+DgS2uwnMLoupPwdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="106341863"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="106341863"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:02:50 -0700
X-CSE-ConnectionGUID: GyKS4eiRQUifg9YemFGWdg==
X-CSE-MsgGUID: /pBsLKSMQF6Qh9rX+HMOWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="246801966"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa003.jf.intel.com with ESMTP; 29 May 2026 01:02:45 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v8 03/23] perf/x86/intel: Enable large PEBS sampling for XMMs
Date: Fri, 29 May 2026 15:56:25 +0800
Message-Id: <20260529075645.580362-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
References: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modern PEBS hardware supports directly sampling XMM registers, then
large PEBS can be enabled for XMM registers just like other GPRs.

Reported-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 85c329bd52be..92cb9a716e83 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4702,7 +4702,8 @@ static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
 		flags &= ~PERF_SAMPLE_REGS_USER;
 	if (event->attr.sample_regs_user & ~PEBS_GP_REGS)
 		flags &= ~PERF_SAMPLE_REGS_USER;
-	if (event->attr.sample_regs_intr & ~PEBS_GP_REGS)
+	if (event->attr.sample_regs_intr &
+	    ~(PEBS_GP_REGS | PERF_REG_EXTENDED_MASK))
 		flags &= ~PERF_SAMPLE_REGS_INTR;
 	return flags;
 }
-- 
2.34.1

