From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 31/44] perf annotate: Add --percent-type option
Date: Thu,  9 Aug 2018 11:58:09 -0300
Message-ID: <20180809145822.21391-32-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add --percent-type option to set annotation percent type from following
choices:

  global-period, local-period, global-hits, local-hits

Examples:

  $ perf annotate --percent-type period-local --stdio | head -1
   Percent         |      Source code ... es, percent: local period)
  $ perf annotate --percent-type hits-local --stdio | head -1
   Percent         |      Source code ... es, percent: local hits)
  $ perf annotate --percent-type hits-global --stdio | head -1
   Percent         |      Source code ... es, percent: global hits)
  $ perf annotate --percent-type period-global --stdio | head -1
   Percent         |      Source code ... es, percent: global period)

The local/global keywords set if the percentage is computed in the scope
of the function (local) or the whole data (global).

The period/hits keywords set the base the percentage is computed on -
the samples period or the number of samples (hits).

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-20-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-annotate.txt |  9 ++++++
 tools/perf/builtin-annotate.c              |  4 +++
 tools/perf/util/annotate.c                 | 52 ++++++++++++++++++++++++++++++
 tools/perf/util/annotate.h                 |  2 ++
 4 files changed, 67 insertions(+)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index 749cc6055dac..e8c972f89357 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -118,6 +118,15 @@ OPTIONS
 --group::
 	Show event group information together
 
+--percent-type::
+	Set annotation percent type from following choices:
+	  global-period, local-period, global-hits, local-hits
+
+	The local/global keywords set if the percentage is computed
+	in the scope of the function (local) or the whole data (global).
+	The period/hits keywords set the base the percentage is computed
+	on - the samples period or the number of samples (hits).
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-report[1]
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 8180319285af..830481b8db26 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -542,6 +542,10 @@ int cmd_annotate(int argc, const char **argv)
 	OPT_CALLBACK_DEFAULT(0, "stdio-color", NULL, "mode",
 			     "'always' (default), 'never' or 'auto' only applicable to --stdio mode",
 			     stdio__config_color, "always"),
+	OPT_CALLBACK(0, "percent-type", &annotate.opts, "local-period",
+		     "Set percent type local/global-period/hits",
+		     annotate_parse_percent_type),
+
 	OPT_END()
 	};
 	int ret;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 6316fa96d984..e4268b948e0e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2799,3 +2799,55 @@ void annotation_config__init(void)
 	annotation__default_options.show_total_period = symbol_conf.show_total_period;
 	annotation__default_options.show_nr_samples   = symbol_conf.show_nr_samples;
 }
+
+static unsigned int parse_percent_type(char *str1, char *str2)
+{
+	unsigned int type = (unsigned int) -1;
+
+	if (!strcmp("period", str1)) {
+		if (!strcmp("local", str2))
+			type = PERCENT_PERIOD_LOCAL;
+		else if (!strcmp("global", str2))
+			type = PERCENT_PERIOD_GLOBAL;
+	}
+
+	if (!strcmp("hits", str1)) {
+		if (!strcmp("local", str2))
+			type = PERCENT_HITS_LOCAL;
+		else if (!strcmp("global", str2))
+			type = PERCENT_HITS_GLOBAL;
+	}
+
+	return type;
+}
+
+int annotate_parse_percent_type(const struct option *opt, const char *_str,
+				int unset __maybe_unused)
+{
+	struct annotation_options *opts = opt->value;
+	unsigned int type;
+	char *str1, *str2;
+	int err = -1;
+
+	str1 = strdup(_str);
+	if (!str1)
+		return -ENOMEM;
+
+	str2 = strchr(str1, '-');
+	if (!str2)
+		goto out;
+
+	*str2++ = 0;
+
+	type = parse_percent_type(str1, str2);
+	if (type == (unsigned int) -1)
+		type = parse_percent_type(str2, str1);
+	if (type != (unsigned int) -1) {
+		opts->percent_type = type;
+		err = 0;
+	}
+
+out:
+	free(str1);
+	return err;
+}
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 760a6678edff..005a5fe8a8c6 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -397,4 +397,6 @@ static inline int symbol__tui_annotate(struct symbol *sym __maybe_unused,
 
 void annotation_config__init(void);
 
+int annotate_parse_percent_type(const struct option *opt, const char *_str,
+				int unset);
 #endif	/* __PERF_ANNOTATE_H */
-- 
2.14.4
