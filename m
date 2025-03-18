Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8BA2066C1;
	Tue, 18 Mar 2025 22:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742337666; cv=none; b=i6koYLvJhR8QW2W+PNyPh64mauuiZHn4wZENgR92PbQNrmhsPVR+uz68A7UNmgJmNYEZ7xG1VIGTtlzA/qe1/6ggiYO/PPpZbvWZ2Rpv++PhphP7mAMGiiJOT3pAXh0UVYlF6wVk/aFOKbBSmG4A7uSvuX4iR729pdcZRbIFlv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742337666; c=relaxed/simple;
	bh=yCtyfPWgqRdbPqfCSlLONwkMbI6EjvPro8Ijg+HbG4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ti2L4+Pdpk+lccb/l+NdxmhnN3UVwUcnpB2oR/EZ/4JEakyyhQ4E+TE7RHlRZhnugt0bHCg01kWGPrdTLnGiWV8eu6qBarAcfBpPupACv0TQaIfRow2jT05P+gcxAsF23iUIXvUu9ADvWKo1cEDCf06pPXZhKymvK9GdCl7rKYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dTnhLn4m; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dTnhLn4m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742337663; x=1773873663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yCtyfPWgqRdbPqfCSlLONwkMbI6EjvPro8Ijg+HbG4E=;
  b=dTnhLn4m/4BMZjp8dqj7P8lUVYZfx/KncnxcEsE8BW+SCSorQCxFouf2
   N+qt6TM0G+p6/DjIrX5wKPGvOQGWCWC7tSiEr3OMVLZxe5RdzbfR1cI41
   db8ZXCmUbf7HzLh7m41LmLvApAdPpJA6C26QOLPFYpfTq9CgtgjCalEnE
   N0xNfKznwy74PrOknYryj8njI5WsKQXCT2Z0kzC+itzW+p+3n8oJOUdAq
   ED3n4BS4QEhx3GbWetYKKTlbdhgz/qHbEtKjzWzYbA90YAaquNGDKOYIJ
   PZk5lLOyJHl2foRHSNMlOfWnvHGTir70yVCxzTsvG8A+veriGvZj1sd7n
   g==;
X-CSE-ConnectionGUID: 2YGdC1yYQ/mJYjU4XfR79g==
X-CSE-MsgGUID: qMeHGkT6S4qepFi9bhFtZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="68860953"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="68860953"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 15:41:00 -0700
X-CSE-ConnectionGUID: nbiYaVlMQKSB6so+6qRD9Q==
X-CSE-MsgGUID: smfkKwr2RJerk9YKg55QKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="127069855"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa005.fm.intel.com with ESMTP; 18 Mar 2025 15:41:00 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Zhang Rui <rui.zhang@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] perf/x86: Simplify Intel PMU initialization
Date: Tue, 18 Mar 2025 22:38:27 +0000
Message-ID: <20250318223828.2945651-2-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318223828.2945651-1-sohil.mehta@intel.com>
References: <20250318223828.2945651-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Architectural Perfmon was introduced on the Family 6 "Core" processors
starting with Yonah. Processors before Yonah need their own customized
PMU initialization.

p6_pmu_init() is expected to provide that initialization for early
Family 6 processors. But, currently, it could get called for any Family
6 processor if the architectural perfmon feature is disabled on that
processor. To simplify, restrict the P6 PMU initialization to early
Family 6 processors that do not have architectural perfmon support and
truly need the special handling.

As a result, the "unsupported" console print becomes practically
unreachable because all the released P6 processors are covered by the
switch cases. Move the console print to a common location where it can
cover all modern processors (including Family >15) that may not have
architectural perfmon support enumerated.

Also, use this opportunity to get rid of the unnecessary switch cases in
P6 initialization. Only the Pentium Pro processor needs a quirk, and the
rest of the processors do not need any special handling. The gaps in the
case numbers are only due to no processor with those model numbers being
released.

Use decimal numbers to represent Intel Family numbers. Also, convert one
of the last few Intel x86_model comparisons to a VFM-based one.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
v4: Move the default case outside of the switch.
    Pickup the Reviewed-by tag from Kan Liang.

v3: Restrict calling p6_pmu_init() to only when needed.
    Move the console print to a common location.

v2: No change.
---
 arch/x86/events/intel/core.c | 14 ++++++++++----
 arch/x86/events/intel/p6.c   | 26 +++-----------------------
 2 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 40a62bf6ef0a..49a1155e6cb9 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6541,15 +6541,21 @@ __init int intel_pmu_init(void)
 	char *name;
 	struct x86_hybrid_pmu *pmu;
 
+	/* Architectural Perfmon was introduced starting with Core "Yonah" */
 	if (!cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
 		switch (boot_cpu_data.x86) {
-		case 0x6:
-			return p6_pmu_init();
-		case 0xb:
+		case  6:
+			if (boot_cpu_data.x86_vfm < INTEL_CORE_YONAH)
+				return p6_pmu_init();
+			break;
+		case 11:
 			return knc_pmu_init();
-		case 0xf:
+		case 15:
 			return p4_pmu_init();
 		}
+
+		pr_cont("unsupported CPU family %d model %d ",
+			boot_cpu_data.x86, boot_cpu_data.x86_model);
 		return -ENODEV;
 	}
 
diff --git a/arch/x86/events/intel/p6.c b/arch/x86/events/intel/p6.c
index a6cffb4f4ef5..65b45e9d7016 100644
--- a/arch/x86/events/intel/p6.c
+++ b/arch/x86/events/intel/p6.c
@@ -2,6 +2,8 @@
 #include <linux/perf_event.h>
 #include <linux/types.h>
 
+#include <asm/cpu_device_id.h>
+
 #include "../perf_event.h"
 
 /*
@@ -248,30 +250,8 @@ __init int p6_pmu_init(void)
 {
 	x86_pmu = p6_pmu;
 
-	switch (boot_cpu_data.x86_model) {
-	case  1: /* Pentium Pro */
+	if (boot_cpu_data.x86_vfm == INTEL_PENTIUM_PRO)
 		x86_add_quirk(p6_pmu_rdpmc_quirk);
-		break;
-
-	case  3: /* Pentium II - Klamath */
-	case  5: /* Pentium II - Deschutes */
-	case  6: /* Pentium II - Mendocino */
-		break;
-
-	case  7: /* Pentium III - Katmai */
-	case  8: /* Pentium III - Coppermine */
-	case 10: /* Pentium III Xeon */
-	case 11: /* Pentium III - Tualatin */
-		break;
-
-	case  9: /* Pentium M - Banias */
-	case 13: /* Pentium M - Dothan */
-		break;
-
-	default:
-		pr_cont("unsupported p6 CPU model %d ", boot_cpu_data.x86_model);
-		return -ENODEV;
-	}
 
 	memcpy(hw_cache_event_ids, p6_hw_cache_event_ids,
 		sizeof(hw_cache_event_ids));
-- 
2.43.0

