Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8585115DBAE;
	Fri, 12 Jul 2024 10:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779701; cv=none; b=D/rYNJs4+8z+Z9Ks5+10+4blARHTLTqKUDBP4UJGe5uNNugn+aut0I60PRjYkrAQhkBj8T/cxTuZf1icSb2MwKSfjN/XqUS6HvtMt986UCzZ++i272yY/u6Y5dC/W/J8LZSHsxdGaLfkk8wDNNELPPyN5D8EoqT1oD3Xciomayw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779701; c=relaxed/simple;
	bh=Uz0dc8OHpJq+3744NgpGZ8C1cdwbf4ISl3iutvlILY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fXkpSiOJFwRf1zJqIO+g2Cnvda2xapdvM5KKIPUxnxQO3Asrsba1c7DCkacjyatBVmeA5tyGdZTBMrdlphs83km62hHFJDY7tU/Urs78E4W74uWRt4skjBkNlXaXooQxXXBSQcJONwdIe7W/XFW2saG8MyKORcyZGcq3hdzMXN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YslZeF50; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YslZeF50"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720779700; x=1752315700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Uz0dc8OHpJq+3744NgpGZ8C1cdwbf4ISl3iutvlILY4=;
  b=YslZeF50QR3mH1iK3CEbmvM2R2WYOAlQ/T7UPB8LZ/h/vhxCnG1W+tRw
   4h4Q7HNZMBx1CZLLqAP2kP4F01AdUAsgkyxH/k7TNOEf2IQP95pNf6mCo
   4HzfWsZD0WXMROTrNptwuCM4LKvwUcIPXjNP7wfh0TUEpD9POJV8VK2CN
   yUyshboLHQv968t4EtQxrzstLEHKNuRsyf2pSccG1dqy0hyvMr7BP0uPE
   4pCrGtNzj5gHh6ZME8Vzu4SM1+vkyNMbltPe+u6PgYOXEgNpwsrEw3t6H
   SiCuOd3mug/STliSyjSHA2blgt9M7LF1uOKGw+Vfk1M72AV0U4NzR0IUr
   A==;
X-CSE-ConnectionGUID: gIXWwszzS6WGC+lmpTknvA==
X-CSE-MsgGUID: a4dNiiWXSSy8UqEZDg5T/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="35756774"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="35756774"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 03:21:39 -0700
X-CSE-ConnectionGUID: BHy734BdRu2iVS2DbdgEkQ==
X-CSE-MsgGUID: v1kXtj0ATsOlX8ms3FXOPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="79576235"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa002.jf.intel.com with ESMTP; 12 Jul 2024 03:21:36 -0700
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
Subject: [Patch v3 3/5] perf x86/topdown: Don't move topdown metric events in group
Date: Fri, 12 Jul 2024 17:03:37 +0000
Message-Id: <20240712170339.185824-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240712170339.185824-1-dapeng1.mi@linux.intel.com>
References: <20240712170339.185824-1-dapeng1.mi@linux.intel.com>
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
The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (topdown-retiring).

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
 tools/perf/arch/x86/util/evlist.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index 332e8907f43e..6ae044f21843 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -85,7 +85,12 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
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

