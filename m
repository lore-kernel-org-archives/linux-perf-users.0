Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E8F13B2BB;
	Wed,  5 Jun 2024 05:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717564937; cv=none; b=NAdduNZ9td9zGfosUqnEtGe6DJsNqYE0KHphXGBv/dskAo59Siz6eYVD7M3O0gUXSE9UGLCxZstqYTHuhTsqGgcLQb4ypDGjoEkvxcaFv82L7dPMpAOVK4y844UbKfMZy5vh/heAqXpKXKHf+YF5khooJYZIIPhVhdpRDzQIE68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717564937; c=relaxed/simple;
	bh=UCGKuZQPqUYovBV4zAebHzVcYf9Q0CqK3HoAwpv/3Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tw56IMAEo9sqwGx5v+7dAtge02VidktBZAq2qRxucH16+ujEA2RrkC2wvfOOn9CqBve47SoBSdgKSUkKeYLvObeGXgXZ3LRSlqIP62k0DOigBL3VTVffmUdshaNf14QXFylPdH0/Vz555Eb/lzk61/W0PCAxtYI5PifEvhpSZ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QVdSz6DX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QVdSz6DX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717564936; x=1749100936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UCGKuZQPqUYovBV4zAebHzVcYf9Q0CqK3HoAwpv/3Ck=;
  b=QVdSz6DXaoS/UodeqFcTM5nF7giL8V/tm4tW8Beq1+Db3svuXKukisHH
   oNvg4O1ECIp6crMJJ/WCrNPbs2RKFO1R1DtnK/R0LADJlcCJ7D/5F6fot
   8MwdsvhpDHPCLS99JGOtnGyCIMHjssMObkOsnrRNHQj8gMovAVvh35WcF
   Xh9FC2qqDcxSTYmHcpgSJv2+N1GEFFSzeR3SuMwVL6c4NWGCQ5XS06r9w
   sdWlEgzEotwwPsKUizF7udk5d7kHMWuvup2F6SJ8agTrdamonj5SR17Ej
   tPFfCUNzlQyULROiMqkgYCfC6YHZ1w7vSeP0l3C61GbdhleD4P1sHpN7x
   A==;
X-CSE-ConnectionGUID: YHNMbOelQ+O47kNSFzbkTA==
X-CSE-MsgGUID: iFv8LTP6T0WrncVM6jVT1Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25258815"
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="25258815"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 22:22:12 -0700
X-CSE-ConnectionGUID: 6/l9Au/nTuGh46o+T0eNqA==
X-CSE-MsgGUID: 6aeXj9/ISs20Q6NMkuf7dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="37525757"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa009.jf.intel.com with ESMTP; 04 Jun 2024 22:22:12 -0700
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
Subject: [RFC PATCH v11 6/8] perf stat: Add command line option for enabling tpebs recording
Date: Wed,  5 Jun 2024 01:21:47 -0400
Message-ID: <20240605052200.4143205-7-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605052200.4143205-1-weilin.wang@intel.com>
References: <20240605052200.4143205-1-weilin.wang@intel.com>
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

Exampe with --enable-tpebs-recording:

perf stat -M tma_dtlb_store -a --enable-tpebs-recording sleep 1

[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.000 MB - ]

 Performance counter stats for 'system wide':

       181,047,168      cpu_core/TOPDOWN.SLOTS/          #      0.6 %  tma_dtlb_store
         3,195,608      cpu_core/topdown-retiring/
        40,156,649      cpu_core/topdown-mem-bound/
         3,550,925      cpu_core/topdown-bad-spec/
       117,571,818      cpu_core/topdown-fe-bound/
        57,118,087      cpu_core/topdown-be-bound/
            69,179      cpu_core/EXE_ACTIVITY.BOUND_ON_STORES/
             4,582      cpu_core/MEM_INST_RETIRED.STLB_HIT_STORES/
        30,183,104      cpu_core/CPU_CLK_UNHALTED.DISTRIBUTED/
        30,556,790      cpu_core/CPU_CLK_UNHALTED.THREAD/
           168,486      cpu_core/DTLB_STORE_MISSES.WALK_ACTIVE/
                 0      MEM_INST_RETIRED.STLB_HIT_STORES:R

       1.003105924 seconds time elapsed

Exampe without --enable-tpebs-recording:

perf stat -M tma_dtlb_store -a sleep 1

 Performance counter stats for 'system wide':

       181,047,168      cpu_core/TOPDOWN.SLOTS/          #      0.6 %  tma_dtlb_store
         3,195,608      cpu_core/topdown-retiring/
        40,156,649      cpu_core/topdown-mem-bound/
         3,550,925      cpu_core/topdown-bad-spec/
       117,571,818      cpu_core/topdown-fe-bound/
        57,118,087      cpu_core/topdown-be-bound/
            69,179      cpu_core/EXE_ACTIVITY.BOUND_ON_STORES/
             4,582      cpu_core/MEM_INST_RETIRED.STLB_HIT_STORES/
        30,183,104      cpu_core/CPU_CLK_UNHALTED.DISTRIBUTED/
        30,556,790      cpu_core/CPU_CLK_UNHALTED.THREAD/
           168,486      cpu_core/DTLB_STORE_MISSES.WALK_ACTIVE/
                 0      MEM_INST_RETIRED.STLB_HIT_STORES:R

       1.003105924 seconds time elapsed

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/builtin-stat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b09cb2c6e9c2..4530e4caa417 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1237,6 +1237,8 @@ static struct option stat_options[] = {
 		       "disable adding events for the metric threshold calculation"),
 	OPT_BOOLEAN(0, "topdown", &topdown_run,
 			"measure top-down statistics"),
+	OPT_BOOLEAN(0, "enable-tpebs-recording", &tpebs_recording,
+			"enable recording for tpebs when retire_latency required"),
 	OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
 			"Set the metrics level for the top-down statistics (0: max level)"),
 	OPT_BOOLEAN(0, "smi-cost", &smi_cost,
-- 
2.43.0

