Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249205;
	b=Y6w3Df06lF9apo0MuiT5EM8JQvsINs2o8V640tcF4SXa/BZwQmwUkDBs5mIwLDN5Qsu1
	 4iT2EvwJOGdRYVfAV2O8U/npzS3y/d5BMGuqJFYj7ufJk+b1nOYa+UnIs6lr6zsnWAaH+
	 l+G2wNDBH/q+xPBF203+1Elrtw7AvFRJhB/du3G9+Hkch4ntrxj8Q00cwG4E3Npi/AAkM
	 T9efbw8mFirc8gXTxtBHsyWFXSQYgw9Di6HoNa1zbb869I4iiyrSW/A2FyYQWlVmDO95A
	 IMXb+ouKNVISLewDG1lX1IfCazGgf5qffacCS7RhAK7pUaLDrdzxAlxDyFAolo8m8Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249205;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lWnXNwWjgKTZgaCkVhm7jKm25oFAN5oQVOIv5Hk4ocA=;
	b=pjPYWDrxSsZo4SoJYQHxRUBfnHfoMMrE0BZ0GAvkA/ESWgE0V1quXJ6YfOgFQp6f4fXf
	 DVH6EqmirXz4jA+K/SzgXkoO9FFE6Vlej5lit2LMncEKyK9KUVx6e9tgvi4pQtYJHST3/
	 7TUwWinBN2Lh8rP5DhxGBqXHuBkATw8ykAF4kwFCtAi8J2IebtG2vC6FlqtKEIPvWCCAE
	 +PeD8Gu4CrIw3KBUSUbwyzbfKmorg+JHm5NAwdA71V9eMBx4Jx0a+RLrSLAvAS/KIlgG+
	 fqeGDFmJ8i49Ef/TVyBJR767cdUcYwdLXkJ2/1wpFNxzh8ZYPIJiwKxkbRTSe+zfBaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D8a3kLFT;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375E6606A323;
	Thu, 29 Oct 2026 04:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 375E6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D8a3kLFT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793249205; x=1824785205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=51CTjPbrbb2mUfqo4w8aGBzDC5oIv7V+zsHT0q3ECeE=;
  b=D8a3kLFT3BL7ZD7H3SQ0UEOWK5iE8QsjsJ1RtVimEqxx1LH72DZ2OnT4
   McA0yO7tk36vT4sbnYpPoizlDi8c3SMHjfvVuYa6fW5P6UUZTTijUuRbO
   PJFJtnwn3AntYViKXAjy3i56vVZuDwWpj1PTTYFb8TexZI9MKCopG1BsI
   v389CQSCtuog8PxB1df9ssCa8u0zfB1lj3zA76FOxgK9jLaPQtKiFYGmd
   JzhElSqtr0QXjAcvBnXrvYcXtnCRfaU9dyi2Rz0lWNdQVLPxklpeLfzLc
   kNFk6rhtvPLyYECx1wFuXnECvq648cy942ZHMc8pB352nRpuJV+l+MQHY
   A==;
X-CSE-ConnectionGUID: r/VohGtdSmKk/JaLQQmkrw==
X-CSE-MsgGUID: ycALcD9iRJqZg3pNuBWDmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1986242"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1986242"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 21:46:45 -0700
X-CSE-ConnectionGUID: a9QpiHERSQqBojSimU0shQ==
X-CSE-MsgGUID: 2oM5S0zDS/SzNKyw9euoqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5420273"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 28 Oct 2026 21:46:41 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v5 01/18] perf/x86: Disable LBR if x86_pmu.lbr_nr exceeds MAX_LBR_ENTRIES
Date: Thu, 29 Oct 2026 12:38:57 +0800
Message-Id: <20261029043914.1395147-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a sanity check for x86_pmu.lbr_nr. If the hardware reports more LBR
entries than MAX_LBR_ENTRIES, disable LBR to avoid out-of-bounds access
in the cached LBR stack handling path.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/amd/lbr.c    | 8 +++++++-
 arch/x86/events/intel/core.c | 7 +++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index a55646fcb846..96c5b5e56053 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -433,7 +433,13 @@ __init int amd_pmu_lbr_init(void)
 	ebx.full = cpuid_ebx(EXT_PERFMON_DEBUG_FEATURES);
 	x86_pmu.lbr_nr = ebx.split.lbr_v2_stack_sz;
 
-	pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
+	if (x86_pmu.lbr_nr > MAX_LBR_ENTRIES) {
+		pr_warn("LBR entries %d exceeds max %d, disable LBR.\n",
+			x86_pmu.lbr_nr, MAX_LBR_ENTRIES);
+		x86_pmu.lbr_nr = 0;
+	} else {
+		pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
+	}
 
 	return 0;
 }
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0a34d674df59..10c694db85ea 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -9023,6 +9023,13 @@ __init int intel_pmu_init(void)
 	 */
 	if (x86_pmu.lbr_tos && !check_msr(x86_pmu.lbr_tos, 0x3UL))
 		x86_pmu.lbr_nr = 0;
+
+	if (x86_pmu.lbr_nr > MAX_LBR_ENTRIES) {
+		pr_warn("LBR entries %d exceeds max %d, disable LBR.\n",
+			x86_pmu.lbr_nr, MAX_LBR_ENTRIES);
+		x86_pmu.lbr_nr = 0;
+	}
+
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
 		if (!(check_msr(x86_pmu.lbr_from + i, 0xffffUL) &&
 		      check_msr(x86_pmu.lbr_to + i, 0xffffUL)))
-- 
2.34.1

