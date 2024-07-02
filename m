Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6934D60BBE;
	Tue,  2 Jul 2024 06:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719902383; cv=none; b=VqFfkry2W3pcQz6jcSlEqDFdTTOA5SqiYcohz3ys6hORx1LfHSr/aOxz+j87BqWgfWuqzJ3SJa72AMsYb0mA3ATgfPdbNUqTjQj3Vsch/wflS22twe+YFa/XwHMKgrBohOgqFrrOM/THhoPL4Td1SJWHkxzejbrWRQA/W40GbAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719902383; c=relaxed/simple;
	bh=yS6+toy5gDTjIQbeVctj+axI5oUwmnO5GhkB03VeDZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fdVU1e1eZhVBTb9ZFxKOkAbLkw6x/sLigIwzAv382EioZy/cudfVWB58dxTZ6FkmGt4ZDwoHlQjrCghpsr4QND9NJoEU8Ajt6dXbi0uw2opQlS1AW2kluon0KUDiQguAfagbIM/FgEdZmJI3toX8rUkZRWWYfcozs0Z7b39LRZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oIjAB7W6; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oIjAB7W6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719902383; x=1751438383;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yS6+toy5gDTjIQbeVctj+axI5oUwmnO5GhkB03VeDZ0=;
  b=oIjAB7W6+ydK9iQTvTPRNbjM1o4+LH4XDBp1TKL+g22ssvek4PmaL4yU
   LB2wpkA/RNr9GDt0HR8wFNEV8CGpMyd5H0uNkcPylNRzzKjid2TOzhkOj
   nrUQQIX+FpciYxnZoudYUslGlvWLjezcrKuZqHnYKycNs/zBzLNI9wsE3
   IR1oHj3hKHrsXMsPYhT2m/f+SQ4ZUsRCTm400PrYMPYbUoQw5G/h+ejSK
   JlxrOZuoRL8hNiqr4AAAOnDz5nABo90hAzcyCDCV5YmonNMmLpaEkEz7w
   Zs42+IJ/RiP4AxOJqUPuHQ3T79C3k63es0uDY4jWkQqSD2Em1g2sE601Q
   Q==;
X-CSE-ConnectionGUID: z4vfzI7wRbKIavAWhwwTfQ==
X-CSE-MsgGUID: d3YiEFkEQkyfMcYSBVBkcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="20868273"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="20868273"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 23:39:41 -0700
X-CSE-ConnectionGUID: 8Pwl+vYTTnKPiPDhAHgykA==
X-CSE-MsgGUID: 7Gd7uE/ESgOeuonmI7jdaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="45926326"
Received: from unknown (HELO dell-3650.sh.intel.com) ([10.239.159.147])
  by orviesa009.jf.intel.com with ESMTP; 01 Jul 2024 23:39:37 -0700
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
	Yanfei Xu <yanfei.xu@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 0/4] Bug fixes on topdown metrics group leader selection
Date: Wed,  3 Jul 2024 06:40:33 +0800
Message-Id: <20240702224037.343958-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

when counting/sampling topdown slots and metrics events, the following
issues are found.

a. incorrect sampling leader selection if group only contains topdown
slots event without topdown metrics event, such as

perf record -e '{slots,branches}:S' -c 10000 -vv sleep 1

In this case, the slots event should be sampled as leader but the
branches event is sampled in fact like the verbose output shows.

perf_event_attr:
  type                             4 (cpu)
  size                             168
  config                           0x400 (slots)
  sample_type                      IP|TID|TIME|READ|CPU|IDENTIFIER
  read_format                      ID|GROUP|LOST
  disabled                         1
  sample_id_all                    1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
------------------------------------------------------------
perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  size                             168
  config                           0x4 (PERF_COUNT_HW_BRANCH_INSTRUCTIONS)
  { sample_period, sample_freq }   10000
  sample_type                      IP|TID|TIME|READ|CPU|IDENTIFIER
  read_format                      ID|GROUP|LOST
  sample_id_all                    1
  exclude_guest                    1

b. Fail to run the perf command

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

Perf tool tries to regroup the events and move topdown-retiring event
closely after slots event and leads to topdown-retiring event is select
to sample. This is incorrect.

c. unnecessary events regroup for the group which only has slots event
but without topdown metrics events, such as

perf stat -e "{instructions,slots}" -C 0 sleep 1
WARNING: events were regrouped to match PMUs

 Performance counter stats for 'CPU(s) 0':

        27,581,148      slots
         8,390,827      instructions

       1.045546595 seconds time elapsed

Obviously, this events regroup is unnecessary.

The patches 1-3 separately fixes the above 3 issues in order and the
patch 4/4 adds a new perf test to verify the leader sampling.


Dapeng Mi (4):
  perf topdown: Correct leader selection with sample_read enabled
  perf parse-events: Don't move topdown metrics events when sorting
    events
  perf parse-events: Don't move slots event when no topdwon metrics
    event
  perf tests: Add leader sampling test in record tests

 tools/perf/arch/x86/util/evlist.c  | 11 ++++------
 tools/perf/arch/x86/util/topdown.c | 16 ++++++++++++--
 tools/perf/tests/shell/record.sh   | 28 ++++++++++++++++++++++++
 tools/perf/util/evlist.h           |  7 +++++-
 tools/perf/util/parse-events.c     | 35 ++++++++++++++++++------------
 5 files changed, 73 insertions(+), 24 deletions(-)


base-commit: 73e931504f8e0d42978bfcda37b323dbbd1afc08
-- 
2.40.1

