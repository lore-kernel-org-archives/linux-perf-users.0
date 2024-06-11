Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8948172BDC;
	Tue, 11 Jun 2024 05:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718083450; cv=none; b=k9U02idBte1p60XgOjtTEheaQySOEZ3GPgjTHSV+NlmGlnB53vvul6Lc/Yjp1Vs4T58BD+28Ilz7rv/RcSZqREMNPJ/5PVTOyek5SU1+ArKgSyunBb0U564SUvc2z6jcdZEF5z63s+zmvsxRsr1xFVtFKmccpnci9ACpaJQ482c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718083450; c=relaxed/simple;
	bh=HRn/4DVNp/OjRLwESom8GPhdl0qYzIfarqPR4+g46dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jabYntTzK9M48cT/Sg1sI7Vus1+S2902QaiXANgcXccf0/CLRn07GC6+DjkBVOh+dBx4pAqWS5fesRJUvLj7Jxu8fl2XmAdHplCHOhbxV0SUzFXBT5Gpd1lklh6lxwxsHbfvwCuGJBHv7PlkLszsJ3aieIFbJIlCw4nsMddLEOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B8mYH/vi; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B8mYH/vi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718083449; x=1749619449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HRn/4DVNp/OjRLwESom8GPhdl0qYzIfarqPR4+g46dg=;
  b=B8mYH/vi9MXdPA/h3/ntN68er/TVZFah+LEG8R7gS6SAYfEJ+lZGtRmc
   Gi69uveq7QQHBQEk5a6HJD78IJM4o6yYwTAqdLRHFK3xm/Np2tBBB+04V
   UapJOIaonPnQE9HJKlU6roItTb5H43cPTtAHtULiu9TnaHgnDGjJjzKzT
   bI2QGvdGDVcD/A8G9Nvk+d7Q969LoEWFVvYLyv50qNkhqQsjzcfX8VofL
   eYtF0FTA/yK1VvHKR5/XH76mbpLB61KVkZhvFzBG+fZlOFgNBelSkljhb
   VsqM0AkkTXq9604htBYrR5nzY2EkbkUITUH4JKzfaVhmrFBpirn3dK9el
   g==;
X-CSE-ConnectionGUID: HUwag/72TW6j+fIjM4zzvw==
X-CSE-MsgGUID: 11UZbcvvQsqevc/q+bZt4Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14651148"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="14651148"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 22:24:04 -0700
X-CSE-ConnectionGUID: +LINPzHYSfKBKwrt1wZmvw==
X-CSE-MsgGUID: RaGIBUlSRf2mlAQI5rquBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="44441207"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa004.jf.intel.com with ESMTP; 10 Jun 2024 22:24:04 -0700
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
Subject: [RFC PATCH v12 6/8] perf stat: Add command line option for enabling tpebs recording
Date: Tue, 11 Jun 2024 01:23:25 -0400
Message-ID: <20240611052331.85715-7-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611052331.85715-1-weilin.wang@intel.com>
References: <20240611052331.85715-1-weilin.wang@intel.com>
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
index 14be132f7b6f..055139e44763 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1235,6 +1235,8 @@ static struct option stat_options[] = {
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

