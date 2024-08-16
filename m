Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095618289E;
	Fri, 16 Aug 2024 06:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723790751; cv=none; b=aseNt/bOXrs4xgqPPmWhyEBSnCAu8jvv8B+eU4agh8FHTZ5+uMRNd7BgBEdOgj4GpgdL02EdVM0xM+8sgzIvkIXd6RaWubxpbwUXpq2jPJz2GzppwVT+YE0HhkcjOa/uOx3QGpjuMSqAbxVVI7UJsOTU6rEqivf4hcIj9IATyY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723790751; c=relaxed/simple;
	bh=co+r/S4tHY9XhzKEcE2Gsywi4LBChhsgb5rJOjHPSe8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gTH6luNyH0Piqsjly5cMneUqHhEkxQJvLon7fZ5R1FliW4FczH2+pwN8NjW0S9bx64c+dWwOrEfo+HQZo7QEwb9bhhrrPtDGqmAa32Z1Q8GllUvXKPMT6ujvVROduFxWPjceExnZ0mVA67a7s81if3tTFkZbY+Ps4oeJ7tPhfBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NEhXG8/K; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NEhXG8/K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723790750; x=1755326750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=co+r/S4tHY9XhzKEcE2Gsywi4LBChhsgb5rJOjHPSe8=;
  b=NEhXG8/KUPihy3XbwROa2h2HKRiK4PQaqJLQF0NV/nxtczzFWzWKOtky
   AyF6Tj5T84ZTPF5MHP1hWV9ca0t9ulLakLPaZt0HchrsBqhWpREMPbkiU
   Si+V+stniRh04f3RleUQ7U5SLOVGDUN+BVKnVsIwKCy1cY/+YlhfLTrzx
   2HHUePqWT91laQ9cL/OC7G+3HdY/tyFit4n86nQ0K1UXqi7XtiR1AKInJ
   K/oVj9sTxCHrBA8Fm7Xt6bdvMDeYCYivDhvPxeOs38BekrZ81wlfB8gTN
   UIQnMbaiP7WESIcsvBSdpLnuHCKv0TzxOFf4ci8ZU9YSxGpZLirgZfzJd
   A==;
X-CSE-ConnectionGUID: XM9wUaAWSgSEijPTZjTX/g==
X-CSE-MsgGUID: INwE2Ee3RIiN5Lqz8yZ/aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="39530757"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="39530757"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 23:45:49 -0700
X-CSE-ConnectionGUID: GxxgxZB7QVm8s8WQ4+/zzQ==
X-CSE-MsgGUID: OaI3UZdqQZ6TnF8YlvoOjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="60150026"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa007.jf.intel.com with ESMTP; 15 Aug 2024 23:45:46 -0700
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
Subject: [Patch v4 3/6] perf x86/topdown: Don't move topdown metric events in group
Date: Fri, 16 Aug 2024 12:29:35 +0000
Message-Id: <20240816122938.32228-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816122938.32228-1-dapeng1.mi@linux.intel.com>
References: <20240816122938.32228-1-dapeng1.mi@linux.intel.com>
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

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/arch/x86/util/evlist.c | 62 ++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index 332e8907f43e..b8a38c0ca36d 100644
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

