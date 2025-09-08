Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29573747F;
	Mon,  8 Sep 2025 06:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757312302; cv=none; b=ALY1UCv5NwCYYzm/78YywKaBAUtIOMAO00XtjGxYpWntITL8amaZyKsq2bxWsFRCmbYnRHzepNvi5+jf420F0iltM7EQSBXXI2GQwtwLF2BCnTVD/H454l2FcXMpWhxpQzR2CHLykk2//mnRkd3WdlLNigSO+qf8EiPf73O7Kyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757312302; c=relaxed/simple;
	bh=XDYMBaDlWZSeboI9kKisb+d9M1zPU5JHD77ryGo56MI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mmYoMgKrWYeeQkOoz46SFsfJQWv/xY+ZVbrre/v8G7a8/eU7PyRsb0wdij1JmfIvbgJEp1PJ2dufl+tyn9IWau546H8eHYW82N2RxP1nkg6YW7oNniZRvEAmJ3e0KTcRmOPNDpu2E8n47LtmfWk7LeRrknkZE4krzUTnR0CCHIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aPkRZ90H; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aPkRZ90H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757312301; x=1788848301;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XDYMBaDlWZSeboI9kKisb+d9M1zPU5JHD77ryGo56MI=;
  b=aPkRZ90H7rupMRdS0xXTUhoXwyF9Hwpf5FqjRnp0dig3gZdlLrK/nchg
   emunLRyMhbh4kj3nAwC6LUNj8QwsTo1j2HBCgWyT7GBFwi6lyCnEteBwE
   iO7enlQXZs6CgjZjpdLY0MfMbONjhCpnTDCUEuthFf7pXHljIXnqcFOl1
   VDYXnwiWXCgY31fWBQlkKfIgjkaz3B8kkzbgW/7mvP2LI8XpfSC4HWKwF
   wdecQ2mlpRnRpaJcpzjpbgp60evRDpi3kJUue46NI0q0hSbhGCzl5+byC
   uMKw+8JATafHYgH8ubsg4J/F+DVWfCzrl7IUnQax/HSM4ivaRQOZZeIk0
   Q==;
X-CSE-ConnectionGUID: Rp8FW7OlTsG5CJPxjcSSnA==
X-CSE-MsgGUID: cme/1y4FSH+Bnyn/ItoC5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="77177790"
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; 
   d="scan'208";a="77177790"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 23:18:19 -0700
X-CSE-ConnectionGUID: 7s65hKabR7mUf/IcWrtQfg==
X-CSE-MsgGUID: jCyqwAe7RMq9gcRTQvniQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; 
   d="scan'208";a="172271715"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa009.jf.intel.com with ESMTP; 07 Sep 2025 23:18:15 -0700
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
Subject: [PATCH 1/2] perf/x86/intel: Add PMU support for WildcatLake
Date: Mon,  8 Sep 2025 14:16:38 +0800
Message-Id: <20250908061639.938105-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

WildcatLake is a variant of PantherLake and shares same PMU features,
so directly reuse Pantherlake's code to enable PMU features for
WildcatLake.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 28f5468a6ea3..fe65be0b9d9c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -7596,6 +7596,7 @@ __init int intel_pmu_init(void)
 		break;
 
 	case INTEL_PANTHERLAKE_L:
+	case INTEL_WILDCATLAKE_L:
 		pr_cont("Pantherlake Hybrid events, ");
 		name = "pantherlake_hybrid";
 		goto lnl_common;

base-commit: 16ed389227651330879e17bd83d43bd234006722
-- 
2.34.1

