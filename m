Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCA3419FD4;
	Tue, 21 Jul 2026 06:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615542; cv=none; b=Pjgv56c0ohHQlrKAZh062p7zzS4oxV1ed7HeoAySk6TuVFwJcXv7qw3KfnpEvgIeSJWfqxEtGGRE+mCwAuNNKFlZD59kYvv3dIYiH+JO8gmTrYIMALs01mLVvuOPtx+oaO/3C7mNjxyo3bMgtsFnx10vLETXVflKuYHEbvPQimY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615542; c=relaxed/simple;
	bh=0lNT5yftw18dwlrvi6a8udt0a8PlwqGLOszwsYa/RJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FIedStFG3Q4M+fgD14siANYYtSl1kQ2nBaI94ygLQCGw5nRPHG7bzXoJlSOxpcb0Jc4lE1SrnH+bRdBwb4Yw+3qnXfs+FPkEdusqftjJpnoul5LTuiyQyG+Oah06J4l326W1F6hhwbRWQ38dbKr2M068BrRMWWyZzV9/dJiR6jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DLJ7SiJe; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DLJ7SiJe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784615541; x=1816151541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0lNT5yftw18dwlrvi6a8udt0a8PlwqGLOszwsYa/RJs=;
  b=DLJ7SiJePezV4fldTHmrwE2ObA9/ZtV01NKVVhGAcpXk0WK5Gvu/z2cM
   CERBAyoy+aX1ru4wybFyLlIc3CpdOWw51XrGcPTdG0kiT8AFR7SQWR2hW
   SX+deuSFp8D14CCFIsd1bI96/5rLCEZIo4cGVrNNvITHnRPgbuambY6Hd
   6LA4YNcgeprfLtR/1qBEtrGG3YoejI8dMTZF8hbXLFUkVcg5GyPgrJutj
   z+L5wsoN1bxKbhjekE9TtsQ+cvRh8fxGzFkTw4TLdWdl9w6p7ZppQkWu7
   IWjebp7O3fPxt5UvwpQoskwlpoqWUpU9NZsMN8ABkPaUNTb35UlqTxV7A
   w==;
X-CSE-ConnectionGUID: 7zaPV/cMQKGQ0QNtsQd6lw==
X-CSE-MsgGUID: t1ppfp3/QrOPKNOwczdIew==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="72740273"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="72740273"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 23:32:21 -0700
X-CSE-ConnectionGUID: 1AVDdOQcTfS7z3fh8DQSNw==
X-CSE-MsgGUID: P5DIj1ZUSAe1vae0mFQyYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="259655710"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jul 2026 23:32:16 -0700
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
Subject: [Patch v10 02/23] perf/x86/intel: Enable large PEBS sampling for XMMs
Date: Tue, 21 Jul 2026 14:24:45 +0800
Message-Id: <20260721062506.3745816-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721062506.3745816-1-dapeng1.mi@linux.intel.com>
References: <20260721062506.3745816-1-dapeng1.mi@linux.intel.com>
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
index 726b39b9bba9..ee62b24d3fdf 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4723,7 +4723,8 @@ static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
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

