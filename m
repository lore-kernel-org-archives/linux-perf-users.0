Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D1E186D
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Nov 2023 06:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F7D98;
	Tue, 31 Oct 2023 23:48:00 -0700 (PDT)
Received: from kwepemm000003.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SKyCB5ntszPnly;
	Wed,  1 Nov 2023 14:43:50 +0800 (CST)
Received: from ubuntu2204.huawei.com (10.67.174.22) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 1 Nov 2023 14:47:56 +0800
From: Yang Jihong <yangjihong1@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
	<adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <yangjihong1@huawei.com>
Subject: [PATCH v2] perf debug: List available options when no variable is specified
Date: Wed, 1 Nov 2023 06:45:43 +0000
Message-ID: <20231101064543.1481957-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.22]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000003.china.huawei.com (7.193.23.66)
X-CFilter-Loop: Reflected

Minor help message improvement for `perf --debug`

Before:

  # perf --debug
  No variable specified for --debug.

   Usage: perf [--version] [--help] [OPTIONS] COMMAND [ARGS]

After:

  # perf --debug
  No variable specified for --debug, available options: verbose,ordered-events,stderr,data-convert,perf-event-open

   Usage: perf [--version] [--help] [OPTIONS] COMMAND [ARGS]

Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---

Changes since v1:
 - Provide helper to iterate debug_opts and print name instead of adding a new variable.

 tools/perf/perf.c       |  6 +++++-
 tools/perf/util/debug.c | 13 +++++++++++++
 tools/perf/util/debug.h |  1 +
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index d3fc8090413c..f29c3ef818a3 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -279,7 +279,11 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			exit(0);
 		} else if (!strcmp(cmd, "--debug")) {
 			if (*argc < 2) {
-				fprintf(stderr, "No variable specified for --debug.\n");
+				fprintf(stderr,
+					"No variable specified for --debug, available options: ");
+				perf_debug_fprint_options(stderr);
+				fprintf(stderr, "\n");
+
 				usage(perf_usage_string);
 			}
 			if (perf_debug_option((*argv)[1]))
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 88378c4c5dd9..a014e6198d41 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -246,6 +246,19 @@ int perf_debug_option(const char *str)
 	return 0;
 }
 
+void perf_debug_fprint_options(FILE *file)
+{
+	struct sublevel_option *opt = debug_opts;
+
+	if (!file)
+		return;
+
+	while (opt->name) {
+		fprintf(file, "%s%s", opt == debug_opts ? "" : ",", opt->name);
+		opt++;
+	}
+}
+
 int perf_quiet_option(void)
 {
 	struct sublevel_option *opt = &debug_opts[0];
diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
index f99468a7f681..17294834cdb4 100644
--- a/tools/perf/util/debug.h
+++ b/tools/perf/util/debug.h
@@ -77,6 +77,7 @@ int eprintf_time(int level, int var, u64 t, const char *fmt, ...) __printf(4, 5)
 int veprintf(int level, int var, const char *fmt, va_list args);
 
 int perf_debug_option(const char *str);
+void perf_debug_fprint_options(FILE *file);
 void debug_set_file(FILE *file);
 void debug_set_display_time(bool set);
 void perf_debug_setup(void);
-- 
2.34.1

