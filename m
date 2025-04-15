Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B9D28F51D;
	Tue, 15 Apr 2025 08:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705460; cv=none; b=mpG/rWo4g7gqKWBsZXBI/PzfsY7UKT8KA+azog0/+TgHNETPQXIU21HK31wkQJoPM+l/5YAV0RSWYRqtVd1t3bYdxkgjpxRApWqiz1B6Ve3efbQpPsvqERrgRtEPoVynti/+TPEUyRc0eYdRgK4O5iNofyvnZ1PfetBvkX5ZDs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705460; c=relaxed/simple;
	bh=pXEsotqy8uhbzC/O4SHOUDlCwAx6teTSf5d4hUKUcB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fECHINLKpzmBv8kNJwCny+h4VWfvEEVlNcKMiXzyZ2VZRdmEvHto9+H4YRokQ17HJU0edJ08plHMobTZ7fPubLC9IB4oC4WygO6S5HZFHTAgrw6s8N5EjinsH4PLyqTc3hFMfjwn1705/Ci+QFzcI52n3fCLU0e8TbC41T4NVIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n7yLk847; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n7yLk847"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744705459; x=1776241459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pXEsotqy8uhbzC/O4SHOUDlCwAx6teTSf5d4hUKUcB0=;
  b=n7yLk847GyzscDDHQdqhKpAs426dDJY+KWTYzx1MzR5KOFUikASvQHgW
   xlELdujsoOm46Lkrcow1ggyC9rgecxcphXgKV+Fw9HVQS7oLTg+rTSPUo
   eRATKMenpb4KCzMxt/rV2yRDg5TPKozD02lPa/QTMBs8qVKI2AcoB3CCY
   O0k7kj2kl/IQTIFSZ1/Yo3x8uZgQq8G+DF8BksllQu4E0mm1D2nd6OPyb
   g96wHaoqQhYJzEHrER0Uc3GFokCiJhioWRVJp0pT3w7WxbrxXM4Q8Wj+9
   k3rPfXME/bWT9jZS2OlLQw8N4Q4FFTBim7M7L51oZEU2m4gTEgfOaS9na
   w==;
X-CSE-ConnectionGUID: SWPR31fMRC2cY0SXx0/kDA==
X-CSE-MsgGUID: yBBhqYqBQKeLzqTtNWz3MA==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46115852"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208,223";a="46115852"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:23:17 -0700
X-CSE-ConnectionGUID: aeDkbdirSUWiQxcBXtXX8w==
X-CSE-MsgGUID: CSiOCL3qToyLnK2rNpPsJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208,223";a="130055435"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa007.fm.intel.com with ESMTP; 15 Apr 2025 01:23:13 -0700
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
Subject: [Patch v3 02/22] perf/x86/intel: Add PMU support for Clearwater Forest
Date: Tue, 15 Apr 2025 11:44:08 +0000
Message-Id: <20250415114428.341182-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From PMU's perspective, Clearwater Forest is similar to the previous
generation Sierra Forest.

The key differences are the ARCH PEBS feature and the new added 3 fixed
counters for topdown L1 metrics events.

The ARCH PEBS is supported in the following patches. This patch provides
support for basic perfmon features and 3 new added fixed counters.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f107dd826c11..adc0187a81a0 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2224,6 +2224,18 @@ static struct extra_reg intel_cmt_extra_regs[] __read_mostly = {
 	EVENT_EXTRA_END
 };
 
+EVENT_ATTR_STR(topdown-fe-bound,       td_fe_bound_skt,        "event=0x9c,umask=0x01");
+EVENT_ATTR_STR(topdown-retiring,       td_retiring_skt,        "event=0xc2,umask=0x02");
+EVENT_ATTR_STR(topdown-be-bound,       td_be_bound_skt,        "event=0xa4,umask=0x02");
+
+static struct attribute *skt_events_attrs[] = {
+	EVENT_PTR(td_fe_bound_skt),
+	EVENT_PTR(td_retiring_skt),
+	EVENT_PTR(td_bad_spec_cmt),
+	EVENT_PTR(td_be_bound_skt),
+	NULL,
+};
+
 #define KNL_OT_L2_HITE		BIT_ULL(19) /* Other Tile L2 Hit */
 #define KNL_OT_L2_HITF		BIT_ULL(20) /* Other Tile L2 Hit */
 #define KNL_MCDRAM_LOCAL	BIT_ULL(21)
@@ -7142,6 +7154,18 @@ __init int intel_pmu_init(void)
 		name = "crestmont";
 		break;
 
+	case INTEL_ATOM_DARKMONT_X:
+		intel_pmu_init_skt(NULL);
+		intel_pmu_pebs_data_source_cmt();
+		x86_pmu.pebs_latency_data = cmt_latency_data;
+		x86_pmu.get_event_constraints = cmt_get_event_constraints;
+		td_attr = skt_events_attrs;
+		mem_attr = grt_mem_attrs;
+		extra_attr = cmt_format_attr;
+		pr_cont("Darkmont events, ");
+		name = "darkmont";
+		break;
+
 	case INTEL_WESTMERE:
 	case INTEL_WESTMERE_EP:
 	case INTEL_WESTMERE_EX:
-- 
2.40.1

