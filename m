Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5382E145B1E;
	Tue,  2 Jul 2024 06:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719902388; cv=none; b=L78ubgXByIVEAB0PJrJRfSFlTEMQV26l3WmwoZlQZ7kZ2DbIfLBoVV+/sqLI+KzEChZIc9ej8mmTfBEjFAVc4M2Zymh7LyQcKAzgd16CGfWTrARHMopWVmVMdb3viKKd5oSHZRPbN2BySSgd+DgRmfRTDEZvIz03JiGL+AeDAfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719902388; c=relaxed/simple;
	bh=t0LwNIKeDKg9+7mSznLYzFb7X6hl3ZbDp13yFvLwpIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hr4pzPRDdlKpXMEuYv0rEkC/UKqB/QugmXXmm5pC4V5+2dXKeYNzy+BB8SCTXt2zERilHMHL6V+djxlPyPB9DbiPmTQyU5HdqRXY8YZB8m6jU+3TrHW3q1bRBlhsTo/k0mSRUCkdEh0o0K8IjryG/a5KCCFlUG8tFDnU/oGVYEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CHpAsaay; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CHpAsaay"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719902388; x=1751438388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t0LwNIKeDKg9+7mSznLYzFb7X6hl3ZbDp13yFvLwpIQ=;
  b=CHpAsaayuzui8ZhRgTYCFMLokOCmltK05VCn4RHyezOZZWKr7bPRPH4I
   yg9uCY98FzctrNt3/26ouH1dPT7qS/vCHU3PZqjs21bo77SLQ0/+Zxcrr
   TwDLuDrISAJ0yL4FOR6hFjkrlKUHJOs/YzKWJdscNBV8mP6iSYjPAfXDI
   ICzSugaHoDpxI4Q2aiJ5CjQAsjfEIgaX3mG5MJs8DUfv/JfDff0OHEFql
   TpTqZuheiLtXE8U7kdeVWvoY5cQmZQ6T6vHshB9WAugS6Jw0WQ2DDCTiP
   GF9qGM2CDhiG/3WsMI4AnBvWKg/mIesHo9cxeT2FNFFGCmy+YDDwD6xTh
   g==;
X-CSE-ConnectionGUID: oJhRqq+PQtaIV2lL5UCxtw==
X-CSE-MsgGUID: jA81FSGqSU63jVjLrtUV2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="20868300"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="20868300"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 23:39:47 -0700
X-CSE-ConnectionGUID: TvRkG8V8TDi5P/rAQPoZkw==
X-CSE-MsgGUID: ZKKufPS/TCq62QnL4eFXZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="45926358"
Received: from unknown (HELO dell-3650.sh.intel.com) ([10.239.159.147])
  by orviesa009.jf.intel.com with ESMTP; 01 Jul 2024 23:39:43 -0700
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
Subject: [PATCH 2/4] perf parse-events: Don't move topdown metrics events when sorting events
Date: Wed,  3 Jul 2024 06:40:35 +0800
Message-Id: <20240702224037.343958-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702224037.343958-1-dapeng1.mi@linux.intel.com>
References: <20240702224037.343958-1-dapeng1.mi@linux.intel.com>
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
index b1ce0c52d88d..7215c7c7b435 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -82,11 +82,6 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
 			return -1;
 		if (strcasestr(rhs->name, "slots") && !strcasestr(rhs->name, "uops_retired.slots"))
 			return 1;
-		/* Followed by topdown events. */
-		if (strcasestr(lhs->name, "topdown") && !strcasestr(rhs->name, "topdown"))
-			return -1;
-		if (!strcasestr(lhs->name, "topdown") && strcasestr(rhs->name, "topdown"))
-			return 1;
 	}
 
 	/* Default ordering by insertion index. */
-- 
2.40.1

