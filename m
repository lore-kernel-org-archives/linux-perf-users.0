Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451C41C3F0C;
	Mon,  6 Jul 2026 02:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303284; cv=none; b=kV0x2m83EYhsfyUrCHTevvAJqH+Hyj3Kby278PjhLwIt5UlXAds8zgJuwVsAOui6PTQOPmangzmUxxl/6xl9bZxRYizBiG0yt2dkicN6o34waFwXbv8jcfWiZSzIKNlV+sgBng6IjDv74fFkUvGda27j6V6yQ/YS1qzwNbAGn0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303284; c=relaxed/simple;
	bh=/HXla07VMsgbfTQWIJetcxO8YdT1pvQHqbI/XkWkcZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ter/rSOX8upJzfzJb2BSNdU/mNn6SljiO8sQ/HOxiCotbAIbxEnK5ETMF77i9dGygieP+P3MYG5r6756vgp2d/dO0i4+Mwjc46Zm5KPdeTrTSL4mmeyI1nXwSarvMLQwXWywV575bIvrIIyJOF9zKEscYa/lAcJm8O6/GgaZwt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XbEFDONb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XbEFDONb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783303284; x=1814839284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/HXla07VMsgbfTQWIJetcxO8YdT1pvQHqbI/XkWkcZQ=;
  b=XbEFDONbH6Vdvr4oBZEGwijj/2qCKUFn7HrbXulwIL849OnZpXwdEUjn
   aK99ATS0AcmG6nGmB9dfnPMlY04oPf27QYPJcKESmgbfOjiDqLwzI75Fm
   MApf09ofTKjMbCj9W7CuSll3d9R7+6pU6sg/jH8HgIvr+ymVK/rbQ0vj9
   cZv1Wvg8uWPTP8flVKL8FRcDkw137bbpQ9iy6fD4yCGPcJLxKngrbdstJ
   RU97dnuRznt/q89eEeVNWaqli/iyp7EvbQ5zUykScacZKQNWdw9ur6Tjf
   aaZAUyUXX2iYCKK5HojSPus6Aj0nhp3nC3eFk1W39s/1PpUEnzjaBMmD5
   g==;
X-CSE-ConnectionGUID: /2EaDRkJTl2FKQL9tEbCNA==
X-CSE-MsgGUID: 7MB7quPURRqCyTnNhcKifQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83911571"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="83911571"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 19:01:23 -0700
X-CSE-ConnectionGUID: 16NZN20JT02UVB/OJfwgFQ==
X-CSE-MsgGUID: EXmdO7QxSOO5aJwj1dBGqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="247191268"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 05 Jul 2026 19:01:18 -0700
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
Subject: [Patch v9 03/24] perf/x86/intel: Enable large PEBS sampling for XMMs
Date: Mon,  6 Jul 2026 09:54:18 +0800
Message-Id: <20260706015439.3040804-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
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
index b8a6382dbb82..2e658b4bc83a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4701,7 +4701,8 @@ static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
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

