From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/44] perf config: Write a config file just once
Date: Fri, 22 Sep 2017 11:41:55 -0300
Message-ID: <20170922144220.9411-20-acme@kernel.org>
References: <20170922144220.9411-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170922144220.9411-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Taeung Song <treeze.taeung@gmail.com>

Currently set_config() can be repeatedly called for each input config on
the below case:

  $ perf config kmem.default=slab report.children=false ...

But it's a waste, so only once write a config file gathering all given
config key=value pairs.

Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/1504754331-9776-1-git-send-email-treeze.taeung@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-config.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-config.c b/tools/perf/builtin-config.c
index a1d82e33282c..b89417d9305e 100644
--- a/tools/perf/builtin-config.c
+++ b/tools/perf/builtin-config.c
@@ -34,8 +34,7 @@ static struct option config_options[] = {
 	OPT_END()
 };
 
-static int set_config(struct perf_config_set *set, const char *file_name,
-		      const char *var, const char *value)
+static int set_config(struct perf_config_set *set, const char *file_name)
 {
 	struct perf_config_section *section = NULL;
 	struct perf_config_item *item = NULL;
@@ -49,7 +48,6 @@ static int set_config(struct perf_config_set *set, const char *file_name,
 	if (!fp)
 		return -1;
 
-	perf_config_set__collect(set, file_name, var, value);
 	fprintf(fp, "%s\n", first_line);
 
 	/* overwrite configvariables */
@@ -161,6 +159,7 @@ int cmd_config(int argc, const char **argv)
 	struct perf_config_set *set;
 	char *user_config = mkpath("%s/.perfconfig", getenv("HOME"));
 	const char *config_filename;
+	bool changed = false;
 
 	argc = parse_options(argc, argv, config_options, config_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
@@ -231,15 +230,26 @@ int cmd_config(int argc, const char **argv)
 					goto out_err;
 				}
 			} else {
-				if (set_config(set, config_filename, var, value) < 0) {
-					pr_err("Failed to set '%s=%s' on %s\n",
-					       var, value, config_filename);
+				if (perf_config_set__collect(set, config_filename,
+							     var, value) < 0) {
+					pr_err("Failed to add '%s=%s'\n",
+					       var, value);
 					free(arg);
 					goto out_err;
 				}
+				changed = true;
 			}
 			free(arg);
 		}
+
+		if (!changed)
+			break;
+
+		if (set_config(set, config_filename) < 0) {
+			pr_err("Failed to set the configs on %s\n",
+			       config_filename);
+			goto out_err;
+		}
 	}
 
 	ret = 0;
-- 
2.13.5
