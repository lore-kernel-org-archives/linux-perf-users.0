Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E42326AFC;
	Sat, 20 Jul 2024 06:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721456476; cv=none; b=vF6HqxWU38I2ljljln+hIFNCcVo5WyKQmuJ3DrrulnhcZLyra9kxNSN2xJDC7E7EOOygwpFzOWdHnh4JUJ2L+dNALo3AnmJR/E8V5DnnJ+O7MI8RLwyC9GXXBCw5o3JrxHIOV2+2sQEfSt6idDw+S6oEwq4Jo+FqIxwttglrBhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721456476; c=relaxed/simple;
	bh=OR8q2r2JaA31znJ8tT75E0C1yIaYLORuJJbkkU5GQOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHU3tZzS+ORCpik4O0+ogfyPrmsYJsJV02qrqbvYzEm1HAwNfQuGzKdBwB9oAgg5LADAOd+mWhTKRLdtZKafThN2Sbzgw9T2cyMx6x7B4eMaiu6UmDcJuQ7dYd3MRzQAySGvzWye37AaLobEM5zBh3JugXBOpgI6a7eMCatZIyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IjdKzI/1; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IjdKzI/1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721456474; x=1752992474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OR8q2r2JaA31znJ8tT75E0C1yIaYLORuJJbkkU5GQOA=;
  b=IjdKzI/1J8F5b2sGhh0x+m2lJH1Kn/KrBuirgZ/NmJef4EgziF0P+ovC
   ayFXNDzhDFmIgolBMS80drXlTc/WLgd8hBqV7hyLWy741IZCFPb1bPU2Z
   Jwna3HFnB0LqNmWNFFERq3mcsMKn3eAjo30eCzS+oU27xftnakyPBbHCe
   5MIJNZHBijVRfuWYh3gm2Ch5tyCgvqsYdL4Tv3vk61uX+yiz1gj6RBoe7
   q1W7fpJdnhaXLddSx+RTgtApOlqgi4XDU061kL2X4xyRDAO9cF8O79K0l
   4dx7wPV0XPPD0Ew/6ousGObPGHDRqP/32C80YH4f8qJ/PhyY5co+wJnrc
   A==;
X-CSE-ConnectionGUID: 1XnRhHh0TRyY8LP68nzJZQ==
X-CSE-MsgGUID: YbjhvvixQk6PHJ5Vs81kFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="12630499"
X-IronPort-AV: E=Sophos;i="6.09,222,1716274800"; 
   d="scan'208";a="12630499"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 23:21:13 -0700
X-CSE-ConnectionGUID: IJ2aU1/ZRFSzbOCONbep+w==
X-CSE-MsgGUID: 0nJkZrsaTiSwW2Ebp7LanQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,222,1716274800"; 
   d="scan'208";a="51403596"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa010.fm.intel.com with ESMTP; 19 Jul 2024 23:21:12 -0700
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
Subject: [RFC PATCH v18 6/8] perf stat: Add command line option for enabling tpebs recording
Date: Sat, 20 Jul 2024 02:20:59 -0400
Message-ID: <20240720062102.444578-7-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240720062102.444578-1-weilin.wang@intel.com>
References: <20240720062102.444578-1-weilin.wang@intel.com>
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

