Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DA37E
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Oct 2023 01:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aoh5PiuJ"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8CB1AB;
	Fri, 13 Oct 2023 18:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697248361; x=1728784361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gaGdzh8ex8r2NhcHlw9ObYcqe0ntMpFyi4DBKEczGrI=;
  b=Aoh5PiuJD4zjpYWrmY/Vpv/dGCSg7AxixUFgu/h0OyAu/R8JE9CVPI/1
   eABJlafvyJqPncI1Gfcgz7VrgEJ3OnCzY529IgABT3bg/lh2PkVB0aW5f
   UYUHQWYbeDie29wfr/kFJfxuJLxHH1kmZsoATBLMNglZiVEYlXDfL9//+
   Suow9kDXU9dxcEfLOso9MpA3NYd4UvOjBfXDdWKbmusbgeBMzm3hgrVb9
   2ykyjgIww2KE/h/MzoyWQ5RzVSXR5znAYXxp0PWYTmpQvSV1jfNisEYGC
   GpOu6EPlQAGD9KbkFRa1yltquZz6043vPYbtHP0im6tI9UzeRxFm+RrfH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="389154743"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="389154743"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 18:52:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="731565689"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="731565689"
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
Subject: [RFC PATCH v2 11/17] perf stat: Add function to handle special events in hardware-grouping
Date: Fri, 13 Oct 2023 18:51:56 -0700
Message-Id: <20231014015202.1175377-12-weilin.wang@intel.com>
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

There are some special events like topdown events and TSC that are not
decribed in pmu-event JSON files. Add support to handle this type of
events. This should be considered as a temporary solution because including
these events in JSON files would be a better solution.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 25 +++++++++++++++++++++++--
 tools/perf/util/metricgroup.h | 15 +++++++++++++++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index dccd16a58..fd92e9283 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -2023,6 +2023,15 @@ static int create_grouping(struct list_head *pmu_info_list,
 	return ret;
 };
 
+static bool is_special_event(const char *id)
+{
+	for (int i = 0; i < SPECIAL_EVENT_MAX; i++) {
+		if (!strncmp(id, special_event_names[i], strlen(special_event_names[i])))
+			return true;
+	}
+	return false;
+}
+
 /**
  * hw_aware_build_grouping - Build event groupings by reading counter
  * requirement of the events and counter available on the system from
@@ -2047,7 +2056,17 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
 	hashmap__for_each_entry(ctx->ids, cur, bkt) {
 		const char *id = cur->pkey;
 
-		pr_debug("found event %s\n", id);
+		if (is_special_event(id)) {
+			struct metricgroup__event_info *event;
+
+			event = event_info__new(id, "default_core", "0",
+						/*free_counter=*/true);
+			if (!event)
+				goto err_out;
+
+			list_add(&event->nd, &event_info_list);
+			continue;
+		}
 		ret = get_metricgroup_events(id, etable, &event_info_list);
 		if (ret)
 			goto err_out;
@@ -2519,8 +2538,10 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 		ret = hw_aware_parse_groups(perf_evlist, pmu, str,
 			    metric_no_threshold, user_requested_cpu_list, system_wide,
 			    /*fake_pmu=*/NULL, metric_events, table);
-		if (!ret)
+		if (!ret) {
+			pr_info("Hardware aware grouping completed\n");
 			return 0;
+		}
 	}
 
 	return parse_groups(perf_evlist, pmu, str, metric_no_group, metric_no_merge,
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 51596e4b4..37fdf8c5b 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -79,6 +79,21 @@ struct metric_expr {
 #define TRANSFER_FIRST_BYTE(pos) (7 - pos)
 #define TRANSFER_SEC_BYTE(pos) (23 - pos)
 
+/* Special events that are not described in pmu-event JSON files.
+ * topdown-* and TSC use dedicated registers, set as free
+ * counter for grouping purpose
+ */
+enum special_events {
+	TOPDOWN	= 0,
+	TSC	= 1,
+	SPECIAL_EVENT_MAX,
+};
+
+static const char *const special_event_names[SPECIAL_EVENT_MAX] = {
+	"topdown-",
+	"TSC",
+};
+
 /**
  * An event used in a metric. This info is for metric grouping.
  */
-- 
2.39.3

