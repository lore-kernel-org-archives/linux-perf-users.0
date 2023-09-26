Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702571C08
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 04:30:03 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDDDE9;
	Mon, 25 Sep 2023 21:30:00 -0700 (PDT)
Received: from kwepemd200002.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rvmtl5tMbzrT3Y;
	Tue, 26 Sep 2023 12:27:43 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd200002.china.huawei.com (7.221.188.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.23; Tue, 26 Sep 2023 12:29:56 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <changbin.du@gmail.com>, Changbin Du
	<changbin.du@huawei.com>
Subject: [PATCH v5 2/5] perf: util: support string type option for perf_parse_sublevel_options
Date: Tue, 26 Sep 2023 12:29:35 +0800
Message-ID: <20230926042938.509234-3-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230926042938.509234-1-changbin.du@huawei.com>
References: <20230926042938.509234-1-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200002.china.huawei.com (7.221.188.186)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add string type option to get non-int value.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/util/parse-sublevel-options.c | 12 +++++++++---
 tools/perf/util/parse-sublevel-options.h |  7 +++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-sublevel-options.c b/tools/perf/util/parse-sublevel-options.c
index a841d17ffd57..d08a1ccc9616 100644
--- a/tools/perf/util/parse-sublevel-options.c
+++ b/tools/perf/util/parse-sublevel-options.c
@@ -34,10 +34,16 @@ static int parse_one_sublevel_option(const char *str,
 		return -1;
 	}
 
-	if (vstr)
-		v = atoi(vstr);
+	if (vstr) {
+		/* The value of option either is a integer or string. */
+		if (opt->value_ptr) {
+			v = atoi(vstr);
+			*opt->value_ptr = v;
+		} else {
+			*opt->str_ptr = strdup(vstr);
+		}
+	}
 
-	*opt->value_ptr = v;
 	free(s);
 	return 0;
 }
diff --git a/tools/perf/util/parse-sublevel-options.h b/tools/perf/util/parse-sublevel-options.h
index 578b18ef03bb..d536ebe43b58 100644
--- a/tools/perf/util/parse-sublevel-options.h
+++ b/tools/perf/util/parse-sublevel-options.h
@@ -3,7 +3,14 @@
 
 struct sublevel_option {
 	const char *name;
+
+	/*
+	 * Only one of below can be non-null. So we simply support
+	 * two types: integer and string. For string, the caller is
+	 * responsible for freeing allocated memory after use.
+	 */
 	int *value_ptr;
+	char **str_ptr;
 };
 
 int perf_parse_sublevel_options(const char *str, struct sublevel_option *opts);
-- 
2.25.1

