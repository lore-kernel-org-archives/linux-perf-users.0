Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC4E3B3898;
	Mon, 13 Jul 2026 08:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931613; cv=none; b=SpFs2m9+rrXzlxXrwTH+7S2uBQN80Zj4VFuuJvR2Sx7K/XH1vPWghe4h8mmn3/dTgq8G4P0UkFcHDav+uKRAM3Ew+J+76+Lnj7TTncv/dEFMrQkYq/d/zNhLFeyJELToLhYsL0VpwaYZ+HlGbWZ0K0aAyQ6W1NyBagN9cxac8Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931613; c=relaxed/simple;
	bh=NOpvoV0D7XtZqO7wwvw/+SVas2ypaGFktFrbrTvP9OY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XmwA7dyrna0GD+2SykALd265lf23dQHHxZYZXeWUviusuLO0QQPfKBfwCkDk+SRvmzSlDEgG9SY7VkD9nYke2baZesaV9VKe9MU7PadxphVakZE1yv+ZMZO7fpiq6VRG1qE7mRgEzissGjw5dF85u8cM1tKO3V1PVlhCkjCItp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TZWND6SA; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TZWND6SA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783931609; x=1815467609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NOpvoV0D7XtZqO7wwvw/+SVas2ypaGFktFrbrTvP9OY=;
  b=TZWND6SAahE+dEjXFh54cYoq6KBGkHOJxsHEs9ukmOxG+mnq4r4mYhuX
   LI5MCUZ+3WyKQuXOVuI5T1sj4y97Kq6al6JsGdNzHGfC0MLQ3W5UwLgUT
   UHc436LTB9rJQH+RlK/sBt0M9kgrcPlaEXEgJzk7+fn79pk6NOh9UyB9k
   RHv72MLjeSKOwMpNhdCBgIdeHk46VCW+7m167csyzFo/+3hjmn1VETTUi
   V7hBeAf0cOmC3wAO8q654tIWBacdcaMUiq5DSVdrEKqSvbkT/7fA3iW/Q
   QWo/1ewBXGeC8gXiPJ/8CJth3+HVxNvSTrFW7vD15VczsjGPI1jKC8GM8
   w==;
X-CSE-ConnectionGUID: ajxz9tUwTwKlwGSz2YJySQ==
X-CSE-MsgGUID: shjNBuxhTQuEgE40fsj9xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84390075"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84390075"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 01:33:27 -0700
X-CSE-ConnectionGUID: 8K+XRWDIR6m6QlzCSRXC/A==
X-CSE-MsgGUID: ZhlxIsP9Q/Sptb5JUZba1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255560741"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa007.jf.intel.com with ESMTP; 13 Jul 2026 01:33:23 -0700
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
Subject: [Patch v2 1/7] perf/x86: Unregister PMI handler on PMU init failure
Date: Mon, 13 Jul 2026 16:27:28 +0800
Message-Id: <20260713082734.3162099-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713082734.3162099-1-dapeng1.mi@linux.intel.com>
References: <20260713082734.3162099-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix an NMI handler leak in init_hw_perf_events(). When PMU
initialization fails after register_nmi_handler(), the error path
exits without calling unregister_nmi_handler(), leaving a stale
NMI_LOCAL "PMI" handler registered. Add the missing call before
clearing x86_pmu state.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index af0b67ffb43d..872d07a5fa80 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2219,7 +2219,7 @@ static int __init init_hw_perf_events(void)
 	err = cpuhp_setup_state(CPUHP_PERF_X86_PREPARE, "perf/x86:prepare",
 				x86_pmu_prepare_cpu, x86_pmu_dead_cpu);
 	if (err)
-		return err;
+		goto pmi_unregister;
 
 	err = cpuhp_setup_state(CPUHP_AP_PERF_X86_STARTING,
 				"perf/x86:starting", x86_pmu_starting_cpu,
@@ -2273,6 +2273,8 @@ static int __init init_hw_perf_events(void)
 	cpuhp_remove_state(CPUHP_AP_PERF_X86_STARTING);
 out:
 	cpuhp_remove_state(CPUHP_PERF_X86_PREPARE);
+pmi_unregister:
+	unregister_nmi_handler(NMI_LOCAL, "PMI");
 out_bad_pmu:
 	memset(&x86_pmu, 0, sizeof(x86_pmu));
 	return err;
-- 
2.34.1

