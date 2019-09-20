From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/31] perf auxtrace: Add missing 'struct perf_sample' forward declaration
Date: Fri, 20 Sep 2019 11:25:32 -0300
Message-ID: <20190920142542.12047-22-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Its needed, was being obtained indirectly, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-c3k1il7sm28old4e22nwlm7l@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 37e70dc01436..1ed902a24a39 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -24,6 +24,7 @@ struct perf_session;
 struct evlist;
 struct perf_tool;
 struct perf_mmap;
+struct perf_sample;
 struct option;
 struct record_opts;
 struct perf_record_auxtrace_info;
-- 
2.21.0
