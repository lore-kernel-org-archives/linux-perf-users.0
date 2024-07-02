Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583401ABC32;
	Tue,  2 Jul 2024 22:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719958091; cv=none; b=M4T3QeiEK3Nmyb/Tqs/P02E3I+s6CgDbzK8H9pmMtTHDn71ZT8MN2tTxiCNR89Uj0VQmchIQALndRPBS53IiqAgqC7XbbkXsXUNaKBHdBYrgcxlNh8jvq/s9Knlavn7nUdHrGyj+1GEFGe5mya74a/hzVZjJloALaunfcO4BZL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719958091; c=relaxed/simple;
	bh=OR8q2r2JaA31znJ8tT75E0C1yIaYLORuJJbkkU5GQOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Um1AAwpdygVvoeqtKhAV3rofEaVbIwxW5bYJo35Zu61lDWvzu3N8sduElGvcTxf5po6pJ7W1Nv6KLd/t/XLNRTsYTD0zBX+J+rerZu+SKUZMXTtZSS9MR3FikTlbkBWJz/dr2xObowhCkrZSzZCI11iPPH6wOBSpAVBhlvXYE9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fhzJArZx; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fhzJArZx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719958090; x=1751494090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OR8q2r2JaA31znJ8tT75E0C1yIaYLORuJJbkkU5GQOA=;
  b=fhzJArZxhM1uVYtBWeDdIguJhiTyigA45wRTpUVyMiIaqtxFOYfE2u63
   HLRi+BlV51aouRVOGDMYg3Nb16Z9fOkAeh7mIsFRjpRnISzg0LMqzj/Xx
   tTYBXa4ayrq5/ICUZM4DIwnWX91fzhWISTut4ENTD7GZ3d/eds1up5bh2
   bL0WiTaWdPSrD9TDgU7h9KEUGzg9bbr3ywlynxe+INlh2Ahw4W0OR2xZI
   B686ggg2/mVL8LNS06FmxHjuVI2CVbekJGsWpJgf8S6Di3JHMafW+4SbT
   CDd51lT7KHJReZ8UZi5GOtpYGrQR+SA8eZl6SJu1Fjj9LyTBQ2ltQIjuo
   A==;
X-CSE-ConnectionGUID: XOoYRC3YQH69hqzT2Ncvnw==
X-CSE-MsgGUID: HxE0XW8/QJepW8/exSMTkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17296921"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="17296921"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 15:08:05 -0700
X-CSE-ConnectionGUID: u6WyrxykRCqneBlw3J2vWg==
X-CSE-MsgGUID: w/HGLqS9SFqe1lbMyY38qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="50888208"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa003.jf.intel.com with ESMTP; 02 Jul 2024 15:08:04 -0700
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v15 6/8] perf stat: Add command line option for enabling tpebs recording
Date: Tue,  2 Jul 2024 18:07:53 -0400
Message-ID: <20240702220757.262825-7-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702220757.262825-1-weilin.wang@intel.com>
References: <20240702220757.262825-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

With this command line option, tpebs recording is turned off in perf stat on
default. It will only be turned on when this option is given in perf stat
command.

Exampe with --record-tpebs:

perf stat -M tma_split_loads -C1-4 --record-tpebs sleep 1

[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.044 MB - ]

 Performance counter stats for 'CPU(s) 1-4':

    53,259,156,071      cpu_core/TOPDOWN.SLOTS/          #      1.6 %  tma_split_loads          (50.00%)
    15,867,565,250      cpu_core/topdown-retiring/                                              (50.00%)
    15,655,580,731      cpu_core/topdown-mem-bound/                                             (50.00%)
    11,738,022,218      cpu_core/topdown-bad-spec/                                              (50.00%)
     6,151,265,424      cpu_core/topdown-fe-bound/                                              (50.00%)
    20,445,917,581      cpu_core/topdown-be-bound/                                              (50.00%)
     6,925,098,013      cpu_core/L1D_PEND_MISS.PENDING/                                         (50.00%)
     3,838,653,421      cpu_core/MEMORY_ACTIVITY.STALLS_L1D_MISS/                                        (50.00%)
     4,797,059,783      cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS/                                        (50.00%)
    11,931,916,714      cpu_core/CPU_CLK_UNHALTED.THREAD/                                        (50.00%)
       102,576,164      cpu_core/MEM_LOAD_COMPLETED.L1_MISS_ANY/                                        (50.00%)
        64,071,854      cpu_core/MEM_INST_RETIRED.SPLIT_LOADS/                                        (50.00%)
                 3      cpu_core/MEM_INST_RETIRED.SPLIT_LOADS/R

       1.003049679 seconds time elapsed

Exampe without --record-tpebs:

perf stat -M tma_contested_accesses -C1 sleep 1

 Performance counter stats for 'CPU(s) 1':

        50,203,891      cpu_core/TOPDOWN.SLOTS/          #      0.0 %  tma_contested_accesses   (63.60%)
        10,040,777      cpu_core/topdown-retiring/                                              (63.60%)
         6,890,729      cpu_core/topdown-mem-bound/                                             (63.60%)
         2,756,463      cpu_core/topdown-bad-spec/                                              (63.60%)
        10,828,288      cpu_core/topdown-fe-bound/                                              (63.60%)
        28,350,432      cpu_core/topdown-be-bound/                                              (63.60%)
                98      cpu_core/OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM/                                        (63.70%)
           577,520      cpu_core/MEMORY_ACTIVITY.STALLS_L2_MISS/                                        (54.62%)
           313,339      cpu_core/MEMORY_ACTIVITY.STALLS_L3_MISS/                                        (54.62%)
            14,155      cpu_core/MEM_LOAD_RETIRED.L1_MISS/                                        (45.54%)
                 0      cpu_core/OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD/                                        (36.30%)
         8,468,077      cpu_core/CPU_CLK_UNHALTED.THREAD/                                        (45.38%)
               198      cpu_core/MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS/                                        (45.38%)
             8,324      cpu_core/MEM_LOAD_RETIRED.FB_HIT/                                        (45.38%)
     3,388,031,520      TSC
        23,226,785      cpu_core/CPU_CLK_UNHALTED.REF_TSC/                                        (54.46%)
                80      cpu_core/MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD/                                        (54.46%)
                 0      cpu_core/MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD/R
                 0      cpu_core/MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS/R
     1,006,816,667 ns   duration_time

       1.002537737 seconds time elapsed

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/Documentation/perf-stat.txt | 8 ++++++++
 tools/perf/builtin-stat.c              | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 29756a87ab6f..2bc063672486 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -498,6 +498,14 @@ To interpret the results it is usually needed to know on which
 CPUs the workload runs on. If needed the CPUs can be forced using
 taskset.
 
+--record-tpebs::
+Enable automatic sampling on Intel TPEBS retire_latency events (event with :R
+modifier). Without this option, perf would not capture dynamic retire_latency
+at runtime. Currently, a zero value is assigned to the retire_latency event when
+this option is not set. The TPEBS hardware feature starts from Intel Granite
+Rapids microarchitecture. This option only exists in X86_64 and is meaningful on
+Intel platforms with TPEBS feature.
+
 --td-level::
 Print the top-down statistics that equal the input level. It allows
 users to print the interested top-down metrics level instead of the
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 68125bd75b37..935386a02e78 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2475,6 +2475,10 @@ int cmd_stat(int argc, const char **argv)
 			"disable adding events for the metric threshold calculation"),
 		OPT_BOOLEAN(0, "topdown", &topdown_run,
 			"measure top-down statistics"),
+#ifdef HAVE_ARCH_X86_64_SUPPORT
+		OPT_BOOLEAN(0, "record-tpebs", &tpebs_recording,
+			"enable recording for tpebs when retire_latency required"),
+#endif
 		OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
 			"Set the metrics level for the top-down statistics (0: max level)"),
 		OPT_BOOLEAN(0, "smi-cost", &smi_cost,
-- 
2.43.0

