Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881D12DCF4C;
	Mon, 11 Aug 2025 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902892; cv=none; b=Jc9JNMCUDkld3xxI+M0pocHRwWn4YHvyUmN8S1t9idKbPNDfklU59XKXZFL5voXLEzXzTTcweoUV5WcCf+pgAicIwY4nq66MfE40djWIV3ml1ZoRMyjEqufHMaQqrSxCcFQRdCfIGNGk2MHDqCZGz/OhoNHptmvg+SOMQqPNF24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902892; c=relaxed/simple;
	bh=AIVkug2vJfK1kkjVROGHj3pbwPQGLM2oRGiF3Almj/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T2cScH3nkTAoBIrBjiSBoGS6JhGHwSXFWUHZCyatljn6Vt/IvfNlqWe/4qbezs3OaCVLvEDrEdWbtxEeC5UYnFTpV+N8jGx+AMBX0Uzs2queKt/5wYxcq3EqEqGZoY9yDXXIuHYJ5mgROrACe/D1FB38JL19/+LG+pVf5Rv4tPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=njdxcJmU; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="njdxcJmU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754902891; x=1786438891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AIVkug2vJfK1kkjVROGHj3pbwPQGLM2oRGiF3Almj/Q=;
  b=njdxcJmU0TaaIhqo9JltyLHDxzzUR5rHhMPcxGNi+wCHOtjboYWtXRCc
   wxlySzO1PKds/EYAo2Fvqd99ZniQU3+m1HV2usvM7big3r7k06hamERtV
   kL3JwOEJy9KDgASWNauSI9GrVwLkKxsOSZX4ZqUUpUuWfCvDehNNCoqlC
   By/Z7aRRwcM6S9De4ojyQon9EMP3PQ0R5eHAjZQjt8BVzoicHK+291STh
   8zl9OdDSxNA2dPaFJ9dcZACqoBOZqN3WxGgW6vbiahSAvKEJIiydWMZXg
   qBRxJKOqxc+ZuTfxnyj/0xNI28YyZCZDKWa+dSQPYya/GRovF9WWy6D/x
   A==;
X-CSE-ConnectionGUID: YAobInAwRSi3U3Thfv+zAg==
X-CSE-MsgGUID: n4F0ZcuYRQeD4Eblrhlgkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57107309"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57107309"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 02:01:31 -0700
X-CSE-ConnectionGUID: /Ea2sNIaRlqX7Ggk9NV8Ig==
X-CSE-MsgGUID: ZhRWKeYETvWcr/ksBAgUlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="166219821"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 11 Aug 2025 02:01:28 -0700
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
Subject: [Patch v2 1/6] perf/x86/intel: Use early_initcall() to hook bts_init()
Date: Mon, 11 Aug 2025 17:00:29 +0800
Message-Id: <20250811090034.51249-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811090034.51249-1-dapeng1.mi@linux.intel.com>
References: <20250811090034.51249-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the commit 'd971342d38bf ("perf/x86/intel: Decouple BTS
 initialization from PEBS initialization")' is introduced, x86_pmu.bts
would initialized in bts_init() which is hooked by arch_initcall().

Whereas init_hw_perf_events() is hooked by early_initcall(). Once the
core PMU is initialized, nmi watchdog initialization is called
immediately before bts_init() is called. It leads to the BTS buffer is
not really initialized since bts_init() is not called and x86_pmu.bts is
still false at that time. Worse, BTS buffer would never be initialized
then unless all core PMU events are freed and reserve_ds_buffers()
is called again.

Thus aligning with init_hw_perf_events(), use early_initcall() to hook
bts_init() to ensure x86_pmu.bts is initialized before nmi watchdog
initialization.

Fixes: d971342d38bf ("perf/x86/intel: Decouple BTS initialization from PEBS initialization")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/bts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 61da6b8a3d51..cbac54cb3a9e 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -643,4 +643,4 @@ static __init int bts_init(void)
 
 	return perf_pmu_register(&bts_pmu, "intel_bts", -1);
 }
-arch_initcall(bts_init);
+early_initcall(bts_init);
-- 
2.34.1

