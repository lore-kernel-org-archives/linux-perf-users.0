Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1458613C9CF;
	Fri, 28 Jun 2024 06:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719557512; cv=none; b=bfzXDfYkggdpK/lARhMdYNE2HwkP5aicPfdUhF0pqSwceyVAKeWX5o7/JostUlJJLCkD2rW9LBQlaeBKeblAj1Ok9qWVZHbfAIFku71MwH1TT3skE0jGgjPWOWfNqRzfUprb3qLm8LrFU3HV3I5ZqJRntHZr3AxpJuOWQTTD6Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719557512; c=relaxed/simple;
	bh=c+UKVFhB6ulvXkirzdRM40HZQlz9VyxBX6vSZHqaga8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JdCv9IDQfY4lXYCgAMuy5zsperKUWOZLPKEIqSJkwt7Hh5KJbQ+fGZWbxLCn9pt5/BCFG8xe3biuG89oSZwjnW+QwAwI0vWvAl6uewjCL+G8CMfkf0z6udLU+gXvRh1J/mypccbK85efewgJYONnkMtGjXAsqgpRyeI1TeCn3aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A5UD1EmR; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A5UD1EmR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719557512; x=1751093512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c+UKVFhB6ulvXkirzdRM40HZQlz9VyxBX6vSZHqaga8=;
  b=A5UD1EmREPCgK9yGyyFFkwFXpf4GyLQcsW5xlaxFLosLhCU3HuB/Wlm1
   xoGEwXHyxDWrqcRvDuP6W+bHdabbhT2CsvPwX4w4MQMFQaktYUyKb1QPm
   tKJl/u+Nj6gXRfpoppyedUougE9tJLMpRKZnn9nQLVTz9ZdJ00q9qRMar
   WIXfOALOEcnAsS1Kydqu4GzDSnzCdv2CYg0/pFgJjW/TVaZidid0+MDZm
   eYd+OcwQk9UemVNmbPdEJ8p9XVqU1AfZikuzGSaYEA6Tudk2tzvSfsRpd
   3S1kT3vysydK78f60lRSfL1Rm/O8Va12WzyC6lTHAAuuBWCo30wnF/OMD
   w==;
X-CSE-ConnectionGUID: rJNhksObSHKtgewu1Irymg==
X-CSE-MsgGUID: j4n32SBrR7WR/X8h0pbzvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16857145"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="16857145"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 23:51:51 -0700
X-CSE-ConnectionGUID: uh/DaPHNQ9GRGLwue7jyFg==
X-CSE-MsgGUID: kxQh0WldR5S6CeOUP48oog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="75386688"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.246.49.253])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 23:51:45 -0700
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
Subject: [PATCH V8 03/12] perf/x86/intel: Do not enable large PEBS for events with aux actions or aux sampling
Date: Fri, 28 Jun 2024 09:51:02 +0300
Message-Id: <20240628065111.59718-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628065111.59718-1-adrian.hunter@intel.com>
References: <20240628065111.59718-1-adrian.hunter@intel.com>
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
index 0e835dc134a5..7bc3762af271 100644
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

