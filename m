Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BC3386573;
	Thu, 17 Sep 2026 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610429; cv=none; b=X2zV8TGIQSQI2bat3l6N/jO39271PFqgAfx7qvSilouYUEUeRoXNXxp0JRTE9rRqR0ufW5KSFssRwYN73Hmt5hh08UFKndmdXOGwa5K5H8unzZxEsDyxcR2pO16TaYzw0LogfhpM+yl71VkoV2Axxb7Yuttqwi2+Sa3Jr9531BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610429; c=relaxed/simple;
	bh=pTkUEQUbH+Mu7DL/YQCqqSGoRheWPzGidztJ8gqm13A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h0b5QjTE25v7Di5P7ATuqHyCkEZ8LbeMcPfQgRe7U4RU6V+CmyHrOKPtv69yfiNgrbRdqU1YvxZNgQrw2heZCA60h4jAAmSgjCKdooYzLOGFeqP5c7iMFebr1TMtae/nFxiomb4VYTMKLVrt20oq0ryswDJvscoTEVT0U04KG1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lVIdVVY9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lVIdVVY9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789610428; x=1821146428;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pTkUEQUbH+Mu7DL/YQCqqSGoRheWPzGidztJ8gqm13A=;
  b=lVIdVVY9Edo1vBBGeCxeAyRWy+VWq+jRlRzxNnm+tl54I2BLfmBzFlon
   OhQ88pOCNOtZEpnIBfxAsUwx2VbzDFlB3/To6ScIF3LZdJ93yIdOJlLDY
   HHAa22pc/+XIQ3nGfd9Z5D5Xg8sPkht/6TJAT8uQJ/ucKIovdTLTQhjuK
   wLjkr2aY/rc19qU19mkwnNA9GG3xU5fvPdmhJMYy2Zc28XWv7+4tjaxEE
   LuHoQjUWGkIn9vKK5RBXsr3m4yG5JF5hw4eIgbGWUM42/9VUggk+mnav6
   pbBs3h2R17DA/lHWTo3+7bTwFGQsIs4QVI2OoiP5MBWuo7AE6YuTUjg1o
   w==;
X-CSE-ConnectionGUID: cKmH9OsbTvKZysdd8wHZBg==
X-CSE-MsgGUID: 7kve1Q9lRGeyeRzV+huAvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107498670"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="107498670"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 19:00:28 -0700
X-CSE-ConnectionGUID: +aNKls42Q9mU0oaE+et8OA==
X-CSE-MsgGUID: cnl0fZgPTCGjdNmmMjX+Gg==
X-ExtLoop1: 1
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa003.fm.intel.com with ESMTP; 16 Sep 2026 19:00:24 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 12/12] perf/x86/intel: Rename NVL offcore_rsp attribute to offmodule_rsp
Date: Thu, 17 Sep 2026 09:52:34 +0800
Message-Id: <20260917015234.981153-13-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
References: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NVL introduces Offmodule Response events in place of the legacy
Offcore Response events, but it still exposes the inherited
offcore_rsp PMU attribute for programming the corresponding MSR data.

Rename the NVL PMU attribute to offmodule_rsp so the sysfs interface
matches the underlying event name and avoids user confusion.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 963d391af2ee..7b7e1e1c90af 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -7549,6 +7549,7 @@ static struct attribute *adl_hybrid_tsx_attrs[] = {
 FORMAT_ATTR_HYBRID(in_tx,       hybrid_big);
 FORMAT_ATTR_HYBRID(in_tx_cp,    hybrid_big);
 FORMAT_ATTR_HYBRID(offcore_rsp, hybrid_big_small_tiny);
+FORMAT_ATTR_HYBRID(offmodule_rsp, hybrid_big_small_tiny);
 FORMAT_ATTR_HYBRID(ldlat,       hybrid_big_small_tiny);
 FORMAT_ATTR_HYBRID(frontend,    hybrid_big);
 
@@ -7587,6 +7588,23 @@ static struct attribute *mtl_hybrid_extra_attr[] = {
 	NULL
 };
 
+static struct attribute *nvl_hybrid_extra_attr_rtm[] = {
+	ADL_HYBRID_RTM_FORMAT_ATTR,
+	FORMAT_HYBRID_PTR(offmodule_rsp),
+	FORMAT_HYBRID_PTR(ldlat),
+	FORMAT_HYBRID_PTR(frontend),
+	FORMAT_HYBRID_PTR(snoop_rsp),
+	NULL
+};
+
+static struct attribute *nvl_hybrid_extra_attr[] = {
+	FORMAT_HYBRID_PTR(offmodule_rsp),
+	FORMAT_HYBRID_PTR(ldlat),
+	FORMAT_HYBRID_PTR(frontend),
+	FORMAT_HYBRID_PTR(snoop_rsp),
+	NULL
+};
+
 static bool is_attr_for_this_pmu(struct kobject *kobj, struct attribute *attr)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -8861,7 +8879,7 @@ __init int intel_pmu_init(void)
 		mem_attr = mtl_hybrid_mem_attrs;
 		tsx_attr = adl_hybrid_tsx_attrs;
 		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
-			mtl_hybrid_extra_attr_rtm : mtl_hybrid_extra_attr;
+			nvl_hybrid_extra_attr_rtm : nvl_hybrid_extra_attr;
 
 		/* Initialize big core specific PerfMon capabilities.*/
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
-- 
2.34.1

