Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FAE30F8A
	for <linux-perf-users@vger.kernel.org>; Thu, 28 Sep 2023 07:30:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB24395;
	Thu, 28 Sep 2023 00:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695886205; x=1727422205;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LldhkKAdq6Uhrl+Pp3Hvrn4yVWHOe1C4Lda2TarY/cI=;
  b=DhQZiUxxLxWc14x9ydjlEOf4iQPzPIKQ7ie33vlGynjWYFXnV2wi9Vns
   Kv0Ocy+CbEL60KhqB7nSc6z+2zKwWGWOKUBYawE227gRx1AmzL9KdVabw
   Xv8G4o4j3VjC1ZfnBLO9bfFhVcNDXbFvJoJo/Uhj2YIepPj6Q5uwyzvXt
   gwioUUxXtPNF7ed12dK5Y9T+IGXInQHB3rnmMGWLAn4vPJqb8iGmT7Nr8
   VKSy9XjXjlwgQiwh/q/64MCv8p0lEfONncsHEwwuj4f4ZsXJMJ5I5V852
   3dUe8CiJZgCut/JxqJT+7sZDyP8Dojbh8+Eu8uuhki7+My4q/RuudLIKe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="362246118"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="362246118"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 00:30:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="996463465"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="996463465"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.53.62])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 00:30:03 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf intel-pt: Fix async branch flags
Date: Thu, 28 Sep 2023 10:29:53 +0300
Message-Id: <20230928072953.19369-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ensure PERF_IP_FLAG_ASYNC is set always for asynchronous branches (i.e.
interrupts etc).

Fixes: 90e457f7be08 ("perf tools: Add Intel PT support")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index dbf0bc71a63b..f38893e0b036 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1512,9 +1512,11 @@ static void intel_pt_sample_flags(struct intel_pt_queue *ptq)
 	} else if (ptq->state->flags & INTEL_PT_ASYNC) {
 		if (!ptq->state->to_ip)
 			ptq->flags = PERF_IP_FLAG_BRANCH |
+				     PERF_IP_FLAG_ASYNC |
 				     PERF_IP_FLAG_TRACE_END;
 		else if (ptq->state->from_nr && !ptq->state->to_nr)
 			ptq->flags = PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL |
+				     PERF_IP_FLAG_ASYNC |
 				     PERF_IP_FLAG_VMEXIT;
 		else
 			ptq->flags = PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL |
-- 
2.34.1

