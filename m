From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 6/8] libsubcmd: Introduce OPT_CALLBACK_SET()
Date: Wed, 29 Apr 2020 10:11:04 -0300
Message-ID: <20200429131106.27974-7-acme@kernel.org>
References: <20200429131106.27974-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200429131106.27974-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <songliubraving@fb.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To register that an option was set, like with the upcoming 'perf record
--switch-output-option' one.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: http://lore.kernel.org/lkml/20200428121601.GB2245@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/subcmd/parse-options.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/subcmd/parse-options.h b/tools/lib/subcmd/parse-options.h
index af9def589863..d2414144eb8c 100644
--- a/tools/lib/subcmd/parse-options.h
+++ b/tools/lib/subcmd/parse-options.h
@@ -151,6 +151,8 @@ struct option {
 	{ .type = OPTION_CALLBACK, .short_name = (s), .long_name = (l), .value = (v), .argh = "time", .help = (h), .callback = parse_opt_approxidate_cb }
 #define OPT_CALLBACK(s, l, v, a, h, f) \
 	{ .type = OPTION_CALLBACK, .short_name = (s), .long_name = (l), .value = (v), .argh = (a), .help = (h), .callback = (f) }
+#define OPT_CALLBACK_SET(s, l, v, os, a, h, f) \
+	{ .type = OPTION_CALLBACK, .short_name = (s), .long_name = (l), .value = (v), .argh = (a), .help = (h), .callback = (f), .set = check_vtype(os, bool *)}
 #define OPT_CALLBACK_NOOPT(s, l, v, a, h, f) \
 	{ .type = OPTION_CALLBACK, .short_name = (s), .long_name = (l), .value = (v), .argh = (a), .help = (h), .callback = (f), .flags = PARSE_OPT_NOARG }
 #define OPT_CALLBACK_DEFAULT(s, l, v, a, h, f, d) \
-- 
2.21.1
