Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3DC50EC1A;
	Fri,  4 Sep 2026 18:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788546156; cv=none; b=iYuaCIXFW3KsUsItvIXU2/oH8fFffScaINIW1A1MzQbdi+Q56gV6LDPlWbWyokCaskxEiwAykdBt7X0nKNh/if3x3mJgoq9Zcg6xFcOjPU1l7l++TwyhY4AV9R9mqSWeFrLDotXIRLb9FxrfAvs54jp02VCmOVaSaiRtpQasZnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788546156; c=relaxed/simple;
	bh=H0u7RM1ZdKMd3nJOGlv6eJtSxmhCEGO7VXWPl54zTWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ia+N3fC7mQRxepzLcueMDybNvLnquDQgkfMW5GD4u4XaxkeGfn02ReuV97xvUdwoSItvEcGse8VkHWjp5qCiyb9reeC31iSxE/Hv4JfA6vh/1/uwF6iWwPwd6mBaOoADJBsqhZ+oPNzyYih/odPR6QZQhwP7Pg3/vcmv5SpKjoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZrQTNIKj; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZrQTNIKj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788546155; x=1820082155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H0u7RM1ZdKMd3nJOGlv6eJtSxmhCEGO7VXWPl54zTWg=;
  b=ZrQTNIKjaH1zfZ2ttWWPJgHkfYwTZWlsfU8J8N3a9N9ggeGB7Qz4+sPO
   IimwGxt2uGwplGIZxWeTPH2vzsIcZY6/EKMcB+k3OJRP+QD5njSyXtuI8
   pSOff2PTnaOqTIvSVYuqhuUgKoS2bxmow/FuYRn4h8hhz/Yegch524Hoa
   p2kSTkFudL4ZwhzaNKv4UdOWHH5nlev2MNfTfP0GpQymAfhRpYNYXWnxN
   0/HOdkMY7EcREFKiXHKiRP1fFnsYRpmTIuymrgEJe+WfnlpCM6k5KTeLp
   tDKxUI397ytWBtlbFTraXFgTkuZvwuz6yqqOKLNN0OsXUWSIZeoEhi6CA
   w==;
X-CSE-ConnectionGUID: zGwv7rR0QQeIhmJdKBS/IQ==
X-CSE-MsgGUID: BHcIwrY/T3qfMzjUGMVE6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="99386525"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="99386525"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 11:22:25 -0700
X-CSE-ConnectionGUID: RcXwi3yxTNSJeN8tQYEyUg==
X-CSE-MsgGUID: 4PMH1S6uST2YMzWUKqeVnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="269581376"
Received: from vbelgaum-ubuntu.fm.intel.com ([10.1.39.16])
  by orviesa008.jf.intel.com with ESMTP; 04 Sep 2026 11:22:25 -0700
From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Vinay Belgaumkar <vinay.belgaumkar@intel.com>
Subject: [PATCH 2/2] perf: Add checks to prevent null ptr access
Date: Fri,  4 Sep 2026 11:16:25 -0700
Message-Id: <20260904181625.1394082-2-vinay.belgaumkar@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260904181625.1394082-1-vinay.belgaumkar@intel.com>
References: <20260904181625.1394082-1-vinay.belgaumkar@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko recommended some additional checks to prevent null pointer
access. Check for revoked states inside perf_event_read_local(), as
the pmu event may have already been freed at this point. Add a null
check inside __perf_event_read_cpu() as well before accessing the pmu
ptr.

Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
---
 kernel/events/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7777e82aad5e..059f82f0cadd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4788,14 +4788,19 @@ static inline const struct cpumask *perf_scope_cpu_topology_cpumask(unsigned int
 
 static int __perf_event_read_cpu(struct perf_event *event, int event_cpu)
 {
+	struct pmu *pmu = READ_ONCE(event->pmu);
 	int local_cpu = smp_processor_id();
 	u16 local_pkg, event_pkg;
 
 	if ((unsigned)event_cpu >= nr_cpu_ids)
 		return event_cpu;
 
+	if (!pmu)
+		return -ENODEV;
+
 	if (event->group_caps & PERF_EV_CAP_READ_SCOPE) {
-		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(event->pmu->scope, event_cpu);
+		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(pmu->scope,
+										event_cpu);
 
 		if (cpumask && cpumask_test_cpu(local_cpu, cpumask))
 			return local_cpu;
@@ -4917,6 +4922,11 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 		goto out;
 	}
 
+	if (READ_ONCE(event->state) <= PERF_EVENT_STATE_REVOKED) {
+		ret = -ENODEV;
+		goto out;
+	}
+
 	/*
 	 * Get the event CPU numbers, and adjust them to local if the event is
 	 * a per-package event that can be read locally
-- 
2.38.1

