Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3211106
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Oct 2023 01:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cBYbzdab"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674D6D9;
	Fri, 13 Oct 2023 18:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697248397; x=1728784397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0uLpjWx1obqDK1PkrFKF6z86fEJ2mxGKnUvYp67G2KQ=;
  b=cBYbzdabwgUGZeCCbX8As0Js7tT08Rvk5qfDFvKN386QFBwgY1CGkXos
   S1Su2q1QO9OdpgN7zZcQNU7HqBRhlIY88cO01Zr9ZIQfsYD7QZxe37lhn
   B+hvS0L9+XdchAhtccq6AMBpGkTZA0UEJr8lbX3l5AmYlzwnHctrkziWO
   P1e5+fjyB+UyYG6timbLyqL3DOdnfYC64tH2l3aLKKuhz+3AarwJ87yVS
   PXOyTKwOoxztNiws262SqrdsB1Hw7uMzofQ6XVH6gnOgHADBL1jzbJgdO
   A1m9CW3rypjtgV+WKUUXgOAMm53IySmL8KbYe36gqKmKahCUfijIOMfnt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="389154771"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="389154771"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 18:52:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="731565699"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="731565699"
Received: from b49691a75598.jf.intel.com ([10.54.34.22])
  by orsmga006.jf.intel.com with ESMTP; 13 Oct 2023 18:52:20 -0700
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Yang Jihong <yangjihong1@huawei.com>
Subject: [RFC PATCH v2 14/17] perf stat: Handle NMI in hardware-grouping
Date: Fri, 13 Oct 2023 18:51:59 -0700
Message-Id: <20231014015202.1175377-15-weilin.wang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231014015202.1175377-1-weilin.wang@intel.com>
References: <20231014015202.1175377-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Weilin Wang <weilin.wang@intel.com>

Add an easy nmi watchdog support in grouping. When nmi watchdog is enabled,
we reduce the total num of events could be assigned to one group by 1. A
more efficient solution will be added in later.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 100c9d948..7da91cbd3 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1852,6 +1852,10 @@ static int insert_new_group(struct list_head *head,
 			   size_t fixed_size)
 {
 	INIT_LIST_HEAD(&new_group->event_head);
+	if (sysctl__nmi_watchdog_enabled()) {
+		pr_debug("NMI watchdog is enabled\n");
+		size -= 1;
+	}
 	fill_counter_bitmap(new_group->gp_counters, 0, size);
 	fill_counter_bitmap(new_group->fixed_counters, 0, fixed_size);
 	new_group->taken_alone = false;
-- 
2.39.3

