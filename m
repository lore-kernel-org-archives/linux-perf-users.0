Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CD07D06E;
	Fri, 31 May 2024 05:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717135103; cv=none; b=Ra5Ov4kXXTwXhJfbVCzMl7/KDq84gDSeATYOq+VuLbwE6S71T2EcdD2nW8egZMGHd3IoqD5rE/V6d3d2djUrk9YhqXiAufGsnj1B6ABDVpUVTWU5SrabV2I2Pd90CoELV+hnz22CMI0c9FgJsjxJFFNPbtzkDZk69w2advWZLqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717135103; c=relaxed/simple;
	bh=+hq3P0AGBGCKyL0Jx2ImBjyEI0MYBUh9fT5KNpqUMVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F8yqX+0YQQQ8J0agSlmewqJPzpFs/zxQAioh///LoVX27pqcp3+paxoBj/cA64t4U3YXSWCNHdMtKYe+21pt/+IMkhZcRHSHVCK1U+4THfZM4I8rb2TMgOJmSW3UShcVePQtmzJsNDf78tMP5ljmdvJw/kNYtFAXk6L8VI+4U1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z/SODS54; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z/SODS54"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717135102; x=1748671102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+hq3P0AGBGCKyL0Jx2ImBjyEI0MYBUh9fT5KNpqUMVE=;
  b=Z/SODS5421F7Aj98wAV73ZVfHvv5kGlsawM55/MQ8IWtlM3qXl4Ljao6
   vkcdzfctf0qnfDtVFaa7lMU+9K91i/ALfuDq7CH7QkUY652ESsx37Obmn
   D+9P2YX10HQbwOO/EREuV4R9rCNf+BvaodWQj8uV/pC1b2phKm+YLqU9+
   6BeKbL+jwh8HWJ3WHvIHuy2qEnrzN4XcgHVgiQj20DHO4sSu6pG0cbWER
   xS1h2JxYqkb3HyXV6xUuCdJ+183ioHvsWXNuSxGNfZCKrBG53N7J/7rJc
   IC7+QcKP2ZV70Vhk06Azmg2DNWBlD652/j5UDleOXMgFcZyN0vFmzBmkQ
   A==;
X-CSE-ConnectionGUID: Oj9uxnfVQHCaO7hEDwPVCA==
X-CSE-MsgGUID: El1s5jIITLiw8sLWBoZ7Mg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="25068146"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="25068146"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 22:58:07 -0700
X-CSE-ConnectionGUID: HpAEITS6Q+eAz+LgRHOezQ==
X-CSE-MsgGUID: 26SdUhHATC6C79VVubQv/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="40510868"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.246.41.28])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 22:58:03 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V7 03/12] perf/x86/intel: Do not enable large PEBS for events with aux actions or aux sampling
Date: Fri, 31 May 2024 08:57:22 +0300
Message-Id: <20240531055731.12541-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531055731.12541-1-adrian.hunter@intel.com>
References: <20240531055731.12541-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Events with aux actions or aux sampling expect the PMI to coincide with the
event, which does not happen for large PEBS, so do not enable large PEBS in
that case.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/events/intel/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 38c1b1f1deaa..3de40cb823c9 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3886,6 +3886,12 @@ static inline bool intel_pmu_has_cap(struct perf_event *event, int idx)
 	return test_bit(idx, (unsigned long *)&intel_cap->capabilities);
 }
 
+static inline bool has_aux_action(struct perf_event *event)
+{
+	return event->attr.aux_pause || event->attr.aux_resume ||
+	       event->attr.aux_sample_size;
+}
+
 static int intel_pmu_hw_config(struct perf_event *event)
 {
 	int ret = x86_pmu_hw_config(event);
@@ -3903,8 +3909,8 @@ static int intel_pmu_hw_config(struct perf_event *event)
 
 		if (!(event->attr.freq || (event->attr.wakeup_events && !event->attr.watermark))) {
 			event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
-			if (!(event->attr.sample_type &
-			      ~intel_pmu_large_pebs_flags(event))) {
+			if (!(event->attr.sample_type & ~intel_pmu_large_pebs_flags(event)) &&
+			    !has_aux_action(event)) {
 				event->hw.flags |= PERF_X86_EVENT_LARGE_PEBS;
 				event->attach_state |= PERF_ATTACH_SCHED_CB;
 			}
-- 
2.34.1

