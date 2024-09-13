Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C30185B63;
	Fri, 13 Sep 2024 05:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726204881; cv=none; b=UM/sre4FpN5R0/polzfPO/q+qGcEUJz0TkTzoUF5tK9fuKNEVqTECsbvOH+pUsIzGMvVFwJJw2dwMdbOedePW58PqH3Efzn8/ssJ582Wb/B/9OLQFhsa9zY08CNupTEruCgBHTj3a/OJMLjVeJX+QH4bkul/i/4JsM1SUIAK5Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726204881; c=relaxed/simple;
	bh=2572e8cA8yYZXkLcO7kKy729URDqdzFhdFRm2F+ltfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WIPqZtYfm/W7fb27ZnL93iZS+80Akgnr9qfEkaO+Z9I21cC9k1jBsRXZ6EUL7cULNhtyXJjGXZC9rSYuD81DtBV4uIKhTBIz5s92ueILm+0HnjqT+La2wLBGuz+h4OIvoZOeiO+HerKzs4LoJc68lSG9l7BM8yGdKB2b5qY3o/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F+iaMqtd; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F+iaMqtd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726204880; x=1757740880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2572e8cA8yYZXkLcO7kKy729URDqdzFhdFRm2F+ltfg=;
  b=F+iaMqtd2VoTRvXtMppVDibnMlzr4psQI4mldGKOjuTGsdDD3TxvaNFI
   6lGb5ivwpZTewFKhGLAvacwCKwaBBLSPiegpVRiPrFeksXN+zqv+E7kRz
   IX3xlPxI/w1+W2EyPbXdNb0hdwgeuCUkRNE4zjkvVVjEOHMCQllBodOLx
   o5OQi/zF6tn78zY4qAH0jSvjTAqtuEkfkT+c6Ns6fmMJNeH1uqUw94vIg
   Gbem74LFRpPvRCmfkTHRFyzYn+tJIEqEXGIFicBSrOwUnyBIWvV+xJ4w0
   TCs6N7ZpZrspvy4ZfzLVwtI3hfk3AiNUPHyPC3kGF3YflRXe94tZv8FCZ
   w==;
X-CSE-ConnectionGUID: rUkF32NhSiaFN6rNqHB94w==
X-CSE-MsgGUID: x6zZv63tR4OE0UTf0213IQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24967779"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="24967779"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 22:21:19 -0700
X-CSE-ConnectionGUID: GtlSinzGR/CPGB4YAOHiXg==
X-CSE-MsgGUID: wyy9aAO9TGydqgoCjIZ4Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="67900617"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa009.fm.intel.com with ESMTP; 12 Sep 2024 22:21:16 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yongwei Ma <yongwei.ma@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v5 3/6] perf x86/topdown: Don't move topdown metric events in group
Date: Fri, 13 Sep 2024 08:47:09 +0000
Message-Id: <20240913084712.13861-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240913084712.13861-1-dapeng1.mi@linux.intel.com>
References: <20240913084712.13861-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

when running below perf command, we say error is reported.

perf record -e "{slots,instructions,topdown-retiring}:S" -vv -C0 sleep 1

------------------------------------------------------------
perf_event_attr:
  type                             4 (cpu)
  size                             168
  config                           0x400 (slots)
  sample_type                      IP|TID|TIME|READ|CPU|PERIOD|IDENTIFIER
  read_format                      ID|GROUP|LOST
  disabled                         1
  sample_id_all                    1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
------------------------------------------------------------
perf_event_attr:
  type                             4 (cpu)
  size                             168
  config                           0x8000 (topdown-retiring)
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|READ|CPU|PERIOD|IDENTIFIER
  read_format                      ID|GROUP|LOST
  freq                             1
  sample_id_all                    1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd 5  flags 0x8
sys_perf_event_open failed, error -22

Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument) for
event (topdown-retiring).

The reason of error is that the events are regrouped and
topdown-retiring event is moved to closely after the slots event and
topdown-retiring event needs to do the sampling, but Intel PMU driver
doesn't support to sample topdown metrics events.

For topdown metrics events, it just requires to be in a group which has
slots event as leader. It doesn't require topdown metrics event must be
closely after slots event. Thus it's a overkill to move topdown metrics
event closely after slots event in events regrouping and furtherly cause
the above issue.

Thus don't move topdown metrics events forward if they are already in a
group.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/arch/x86/util/evlist.c | 62 ++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index 79799865a62a..20b4f3c2afa3 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -75,6 +75,61 @@ int arch_evlist__add_default_attrs(struct evlist *evlist,
 
 int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
 {
+	/*
+	 * Currently the following topdown events sequence are supported to
+	 * move and regroup correctly.
+	 *
+	 * a. all events in a group
+	 *    perf stat -e "{instructions,topdown-retiring,slots}" -C0 sleep 1
+	 *    WARNING: events were regrouped to match PMUs
+	 *     Performance counter stats for 'CPU(s) 0':
+	 *          15,066,240     slots
+	 *          1,899,760      instructions
+	 *          2,126,998      topdown-retiring
+	 * b. all events not in a group
+	 *    perf stat -e "instructions,topdown-retiring,slots" -C0 sleep 1
+	 *    WARNING: events were regrouped to match PMUs
+	 *     Performance counter stats for 'CPU(s) 0':
+	 *          2,045,561      instructions
+	 *          17,108,370     slots
+	 *          2,281,116      topdown-retiring
+	 * c. slots event in a group but topdown metrics events outside the group
+	 *    perf stat -e "{instructions,slots},topdown-retiring" -C0 sleep 1
+	 *    WARNING: events were regrouped to match PMUs
+	 *     Performance counter stats for 'CPU(s) 0':
+	 *         20,323,878      slots
+	 *          2,634,884      instructions
+	 *          3,028,656      topdown-retiring
+	 * d. slots event and topdown metrics events in two groups
+	 *    perf stat -e "{instructions,slots},{topdown-retiring}" -C0 sleep 1
+	 *    WARNING: events were regrouped to match PMUs
+	 *     Performance counter stats for 'CPU(s) 0':
+	 *         26,319,024      slots
+	 *          2,427,791      instructions
+	 *          2,683,508      topdown-retiring
+	 *
+	 * If slots event and topdown metrics events are not in same group, the
+	 * topdown metrics events must be first event after the slots event group,
+	 * otherwise topdown metrics events can't be regrouped correctly, e.g.
+	 *
+	 * a. perf stat -e "{instructions,slots},cycles,topdown-retiring" -C0 sleep 1
+	 *    WARNING: events were regrouped to match PMUs
+	 *     Performance counter stats for 'CPU(s) 0':
+	 *         17,923,134      slots
+	 *          2,154,855      instructions
+	 *          3,015,058      cycles
+	 *    <not supported>      topdown-retiring
+	 *
+	 * if slots event and topdown metrics events are in two groups, the group which
+	 * has topdown metrics events must contain only the topdown metrics event,
+	 * otherwise topdown metrics event can't be regrouped correctly as well, e.g.
+	 *
+	 * a. perf stat -e "{instructions,slots},{topdown-retiring,cycles}" -C0 sleep 1
+	 *    WARNING: events were regrouped to match PMUs
+	 *    Error:
+	 *    The sys_perf_event_open() syscall returned with 22 (Invalid argument) for
+	 *    event (topdown-retiring)
+	 */
 	if (topdown_sys_has_perf_metrics() &&
 	    (arch_evsel__must_be_in_group(lhs) || arch_evsel__must_be_in_group(rhs))) {
 		/* Ensure the topdown slots comes first. */
@@ -85,7 +140,12 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
 		/* Followed by topdown events. */
 		if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
 			return -1;
-		if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs))
+		/*
+		 * Move topdown events forward only when topdown events
+		 * are not in same group with previous event.
+		 */
+		if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs) &&
+		    lhs->core.leader != rhs->core.leader)
 			return 1;
 	}
 
-- 
2.40.1

