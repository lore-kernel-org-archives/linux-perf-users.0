Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283FB38FB9;
	Mon,  8 Jul 2024 07:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424448; cv=none; b=Sbi+DxcT/wSMcpD71M/epao/iILTCSrWM4KeR7XkE8Cg8302+21R4/E0l9kmF0L3LqSgJCzxyZA9h8Hvo6BHUmJFEAOB5iPrbHUH/vYsbgQ7HyjCJw7ZEwiTzEdgI2x+H3E9R5VwEU4Xyloa7opqPOMK0tYzSmY3OJaJUQpFDV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424448; c=relaxed/simple;
	bh=1/nKuFBsRafZNDLvHVCKhdjLHZPBaKZQdBcN+bO4gTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mfilMhj+drRzAiWe6FnK6D5BhItocIqL5y+0UMD3KOnvQ0CkLmijgyc9W08uiFVOTyv1jt2ltlUgDc5pvwP77Mn6P6lgcHttOrm6ZVFRhlzYqxqSHNTEEaqcaBaRNpivCo1xST18tpIjtwAACTn4jvQWqRbvjvHhD0CZCkQg4EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=erP7AawP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="erP7AawP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720424447; x=1751960447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1/nKuFBsRafZNDLvHVCKhdjLHZPBaKZQdBcN+bO4gTo=;
  b=erP7AawP2R/jQpMgLv/jDwWK8nnLd5pNHi72//AscVboDl3mHn32cIah
   UWeQrq/+DzAgveeAPF7Gt40yNGxqKVXsuKAAM24Vv7f/scZ7c6p9Ox/+X
   4X89yLMbrpHPUV0H0aGy2uPztKAglLpG/PRjlUGwGIKjOOrcpywu+Q1rg
   0N1/YpPUgGDH+AQOaXOwdjnQtn/RNyWdWNgj69XPU9dW3cT7AdlmVmk8g
   oyC97PvMZJAKvT8W1DjBhYt5ztd1AZW/NXSTsCcGyQCZ5HqfR/u7nP+Z4
   ADZJj2FWkufstcdReUJXOBpIFlmhxUf5cDTZjq8L+ItLrO6KER6EwYAN7
   w==;
X-CSE-ConnectionGUID: X+z4WbFoSCqzJXRAqXOAfA==
X-CSE-MsgGUID: wV4mq54ZSIehNOJToqFy8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="17819235"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="17819235"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 00:40:47 -0700
X-CSE-ConnectionGUID: VN7GshEBTwOVaGiG2Be6sg==
X-CSE-MsgGUID: heyKpxtLTemxBWRk16Xw/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="51774134"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa003.fm.intel.com with ESMTP; 08 Jul 2024 00:40:44 -0700
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
Subject: [Patch v2 3/5] perf x86/topdown: Don't move topdown metrics events when sorting events
Date: Mon,  8 Jul 2024 14:42:02 +0000
Message-Id: <20240708144204.839486-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240708144204.839486-1-dapeng1.mi@linux.intel.com>
References: <20240708144204.839486-1-dapeng1.mi@linux.intel.com>
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

Thus delete the code that moving topdown metrics events to fix the
issue.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/arch/x86/util/evlist.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index 332e8907f43e..6046981d61cf 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -82,11 +82,6 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
 			return -1;
 		if (arch_is_topdown_slots(rhs))
 			return 1;
-		/* Followed by topdown events. */
-		if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
-			return -1;
-		if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs))
-			return 1;
 	}
 
 	/* Default ordering by insertion index. */
-- 
2.40.1

