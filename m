Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179891B0103;
	Tue, 22 Oct 2024 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612850; cv=none; b=u1pq/ktWJAA9PLWYaBJLc8scza6HqXS/GMFXOgGnRD13/KWidq8gINaa3HuauaurYymhjuTSwqCo2ngEdoehNVhvyrVP/OxZM6DNz4cqHgqMllwG9GZT/ud9JfSGNc+UhLSH5u4oT68AqLudrmj6p0xvdvCroD5tEKossoPGZJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612850; c=relaxed/simple;
	bh=E+8Aa9jyAI9q9zAoy3PHOZCEhyfbGlYPdlZudFdxdfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FB2fp8lY7IRZLBvGkrv/+1ws0MXFMwU1WvVJRUv0KaMrRVnQZZobyWczjMozfzowQdevFywzumT2AY32/EBnJJiA7fdB5HAMasHTUQkQL5uE/Eihyg5v2O636Dg1wvW7qfyVmK9TcLRMiLQm5+83G0mMaYURncHXgVuRVCHxNMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bBmnZ47t; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bBmnZ47t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729612849; x=1761148849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E+8Aa9jyAI9q9zAoy3PHOZCEhyfbGlYPdlZudFdxdfg=;
  b=bBmnZ47tsT9Va/o32Y2hWHASVJ5fOuBPFeWzOiyjTHBf3v49N/YMpLnG
   vks8xYaqqGJQBu1fd7MJ0HHyNHGuqP/a8VUonCVyKSaNoLarzn6jcVgaq
   8dn8RdW1UjEFbGG4crqgm0yOl6qcu2R2PPhwu/Ms+N07GmikiWZRX5hKV
   V4ywtONOVM9zUk57Pe88qqTkG1oNZcn7AN4/BkndgPz1u9LCGbGq1j8es
   rtdn0G8M072r+fmYxOOBDIFMH1CeMIDBQ3Yx4ZZ3qidjvzlS2Nt33INHr
   XYJwbk6BFhOz4mpiv1ULrREDW8qt/kx8F5PTFxCGKvHgl0Rm7ezjtrv+G
   g==;
X-CSE-ConnectionGUID: vn0Q5kIFRC+/03uv9DZc+Q==
X-CSE-MsgGUID: lNcHdKttQAedRvsLeklsRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="29271078"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="29271078"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 09:00:48 -0700
X-CSE-ConnectionGUID: XoTMTwC8T42T0qY3NZQvpQ==
X-CSE-MsgGUID: Dh9UCfcNREqJ58L/+TuJ2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="79858761"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.ger.corp.intel.com) ([10.246.16.81])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 09:00:40 -0700
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
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	H Peter Anvin <hpa@zytor.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V14 08/11] perf tools: Add missing_features for aux_start_paused, aux_pause, aux_resume
Date: Tue, 22 Oct 2024 18:59:14 +0300
Message-ID: <20241022155920.17511-9-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022155920.17511-1-adrian.hunter@intel.com>
References: <20241022155920.17511-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Display "feature is not supported" error message if aux_start_paused,
aux_pause or aux_resume result in a perf_event_open() error.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Ian Rogers <irogers@google.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---


Changes in V13:
	Add error message also in EOPNOTSUPP case (Leo)


 tools/perf/util/evsel.c | 12 ++++++++++++
 tools/perf/util/evsel.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 95593b55d9a7..88b31a005ac6 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2102,6 +2102,12 @@ bool evsel__detect_missing_features(struct evsel *evsel)
 		perf_missing_features.inherit_sample_read = true;
 		pr_debug2("Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit, falling back to no-inherit.\n");
 		return true;
+	} else if (!perf_missing_features.aux_pause_resume &&
+	    (evsel->core.attr.aux_pause || evsel->core.attr.aux_resume ||
+	     evsel->core.attr.aux_start_paused)) {
+		perf_missing_features.aux_pause_resume = true;
+		pr_debug2_peo("Kernel has no aux_pause/aux_resume support, bailing out\n");
+		return false;
 	} else if (!perf_missing_features.branch_counters &&
 	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS)) {
 		perf_missing_features.branch_counters = true;
@@ -3279,6 +3285,10 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			return scnprintf(msg, size,
 	"%s: PMU Hardware doesn't support 'aux_output' feature",
 					 evsel__name(evsel));
+		if (evsel->core.attr.aux_action)
+			return scnprintf(msg, size,
+	"%s: PMU Hardware doesn't support 'aux_action' feature",
+					evsel__name(evsel));
 		if (evsel->core.attr.sample_period != 0)
 			return scnprintf(msg, size,
 	"%s: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'",
@@ -3309,6 +3319,8 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			return scnprintf(msg, size, "clockid feature not supported.");
 		if (perf_missing_features.clockid_wrong)
 			return scnprintf(msg, size, "wrong clockid (%d).", clockid);
+		if (perf_missing_features.aux_pause_resume)
+			return scnprintf(msg, size, "The 'aux_pause / aux_resume' feature is not supported, update the kernel.");
 		if (perf_missing_features.aux_output)
 			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
 		if (!target__has_cpu(target))
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 9fcaf417b277..87135012217d 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -205,6 +205,7 @@ struct perf_missing_features {
 	bool weight_struct;
 	bool read_lost;
 	bool branch_counters;
+	bool aux_pause_resume;
 	bool inherit_sample_read;
 };
 
-- 
2.43.0

