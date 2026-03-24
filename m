Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657FF2F5485;
	Tue, 24 Mar 2026 00:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313166; cv=none; b=oN/q3rma7pTNQw4FjVzZdrqYaAHSXWhKH6URpRASzlHtVzwIKeipqavcAB98mmW4Q5BZFVpjveehJJX10AxSqP/XZYkQBPo1Vw7Rpcvr+yWxnF5R/3ZYze9GNvqThDXikuHbtLLTfyTWW2FXfA/+kimpQIwtOl/sSfOcpcF+CBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313166; c=relaxed/simple;
	bh=shyme+Ceqr9QBtXLxUZr4ZksB/qjm5QkTlR85zNhOig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EQUDHzJB6mOAlZXmZlvPZiaMGjw1tS0//hAOUjwC43ornX7pcCLKcNzp1GEU6Fu+0wDa+9PO/DbFBzf2k1rsWyav4xua9KVeHm+MPf1HO1v+jSg+v0C/Wad8gTOy8IgpVPbEiw8AnLcJu+ImRpYx8/RCkUOpRf3F+kfOyt47Qpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=adjkDANZ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="adjkDANZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774313165; x=1805849165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=shyme+Ceqr9QBtXLxUZr4ZksB/qjm5QkTlR85zNhOig=;
  b=adjkDANZrcP2WZM5kfEXGR4fFwnO+qoOJvU1h91gPTYfDq1qZShS12Ui
   73qsbhK280CWRgqRP8PrsknzTa33FYi2EECjqiSgphDfQCDrqHjVE+gM0
   J8uTSA0YowFJWqIjQncP5GX68S+x4iVG5Afd1XdFvlz9ipQ+U8ySex18L
   3HKaEbbcwwpM0Wia6+bEQFyTRfUN7t7HLwCh+/eWqWD+ZvMyaeSczDYTG
   LhUpneHGnnpdTQ3mEnhf3OksSsv+NWA6LuDdFyR1a0z9vWUJLmGeamA1S
   Ln0Zn6Yi4jKUPevrIWTfuXXyDx+zsZK2QvNxRe30194zqO/thFjsPCadB
   g==;
X-CSE-ConnectionGUID: NvCHcy47QcmXA6bfY5D2kQ==
X-CSE-MsgGUID: JJjV710dSuC66+Bo1Z+uKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86396973"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86396973"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 17:46:05 -0700
X-CSE-ConnectionGUID: npP+7K6hQYeDwDdBZ6Xj6w==
X-CSE-MsgGUID: YVQuJWRsTJu8Xu2nDuD+jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="221322596"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 23 Mar 2026 17:46:01 -0700
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
Subject: [Patch v7 03/24] perf/x86/intel: Enable large PEBS sampling for XMMs
Date: Tue, 24 Mar 2026 08:40:57 +0800
Message-Id: <20260324004118.3772171-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324004118.3772171-1-dapeng1.mi@linux.intel.com>
References: <20260324004118.3772171-1-dapeng1.mi@linux.intel.com>
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
index 4768236c054b..5a2b1503b6a5 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4423,7 +4423,8 @@ static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
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

