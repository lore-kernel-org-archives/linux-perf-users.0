Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F511667CA;
	Wed, 29 May 2024 06:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716965021; cv=none; b=mI4FP/YRmYLQqW+OjbWrbzyjGX59LraqREf0v6zDxS0EreFIvT7h4yZzd18eyVxctLaFqsyYDVdNYDIpSvECYMrGVsRBL3+tG1tIm5lCzHR+7YOtvT72a/w5NWNHKQN5XaDqIQgde4SIHREjJX9aeTeZmslfLikz2sK2v9OBqm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716965021; c=relaxed/simple;
	bh=UCGKuZQPqUYovBV4zAebHzVcYf9Q0CqK3HoAwpv/3Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSJATi6e70B0bLAK/Tul3ojyzSX2kgXby0zp6nLQ4m8mDevLhy7GZQYKKg1mTGT+iepOZjnmwe2HkXmg9rkDHyQFaH2EiQFDFcOKCsQXyxi4gGf1qT84ExA/KIowXzNFWW8yBIrj9BhKkH+0QQhn7fZS1uQthMQivGbG/n5GSdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FFNSI4ca; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FFNSI4ca"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716965020; x=1748501020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UCGKuZQPqUYovBV4zAebHzVcYf9Q0CqK3HoAwpv/3Ck=;
  b=FFNSI4ca2LEqUReky/0D1xG3NkdUluIMPZb/8xrnheSxlSGAHnFzhZBM
   Mp6TbI/67IewzztLRGhTvlij/ae20KvFKFNhigkWMcVz8ZTgHJnmIBwsH
   H0fsOeP//sXU4RP4+vmsE/lhp/m+YLiHmxoxkTnG6J0WCBS9BbYpzWp0g
   4XFUwP3yFEI33NB+7S5fiTKdcv1Hm5VyMI5r7jYAaRc5yWFOLsfGT03yA
   ZFdRfAgdFVtmH36Ld60i+Fgo2VyCLUV49rIJmbAtdspWsfwvboPgs5Tly
   p/PlS/s6QIDk+V5J7x85PgLhMxMxqXU9CGIV3O16s3r8lkCWz2BD9iXBG
   Q==;
X-CSE-ConnectionGUID: 3uq8ePYER1yNJwZvyJGwRA==
X-CSE-MsgGUID: Dc1uo4O7TICKRBeaqUpjXg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="16298007"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="16298007"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 23:43:37 -0700
X-CSE-ConnectionGUID: fIkZ9uf5T/qtoqT4lC6j0g==
X-CSE-MsgGUID: UcEEoWoHQ1eEJbZdv45lRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="39759321"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa005.fm.intel.com with ESMTP; 28 May 2024 23:43:36 -0700
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
Subject: [RFC PATCH v10 6/8] perf stat: Add command line option for enabling tpebs recording
Date: Wed, 29 May 2024 02:43:22 -0400
Message-ID: <20240529064327.4080674-7-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240529064327.4080674-1-weilin.wang@intel.com>
References: <20240529064327.4080674-1-weilin.wang@intel.com>
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

