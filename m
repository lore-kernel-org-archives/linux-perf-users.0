From: Taeung Song <treeze.taeung@gmail.com>
Subject: [PATCH v2 3/4] perf tools: Add a option 'list-all' to perf-config.
Date: Fri, 29 May 2015 14:42:47 +0900
Message-ID: <1432878168-11278-3-git-send-email-treeze.taeung@gmail.com>
References: <1432878168-11278-1-git-send-email-treeze.taeung@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432878168-11278-1-git-send-email-treeze.taeung@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, jolsa@redhat.com, namhyung@kernel.org, linux-perf-users@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>
List-Id: linux-perf-users.vger.kernel.org

A option 'list-all' is to display both current config variables and
all possible config variables with default values.
The syntax examples are like below

    perf config [options]

    display all perf config with default values.
    # perf config -a | --list-all

Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
---
 tools/perf/Documentation/perf-config.txt |  6 ++++
 tools/perf/builtin-config.c              | 48 ++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index f3dae23..e33e481 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -11,6 +11,8 @@ SYNOPSIS
 'perf config' [section.name[=value] ...]
 or
 'perf config' -l | --list
+or
+'perf config' -a | --list-all
 
 DESCRIPTION
 -----------
@@ -23,6 +25,10 @@ OPTIONS
 --list::
 	Show current config variables with key and value into each sections.
 
+-a::
+--list-all::
+	Show current and all possible config variables with default values.
+
 CONFIGURATION FILE
 ------------------
 
diff --git a/tools/perf/builtin-config.c b/tools/perf/builtin-config.c
index 175b125..cf7d61d 100644
--- a/tools/perf/builtin-config.c
+++ b/tools/perf/builtin-config.c
@@ -21,10 +21,13 @@ static const char * const config_usage[] = {
 };
 
 #define ACTION_LIST (1<<0)
+#define ACTION_LIST_ALL (1<<1)
 
 static const struct option config_options[] = {
 	OPT_GROUP("Action"),
 	OPT_BIT('l', "list", &actions, "show current config variables", ACTION_LIST),
+	OPT_BIT('a', "list-all", &actions,
+		"show current and all possible config variables with default values", ACTION_LIST_ALL),
 	OPT_END()
 };
 
@@ -516,6 +519,45 @@ static int collect_current_config(const char *var, const char *value,
 			   normalize_value(section_name, name, value));
 }
 
+static int show_all_config(void)
+{
+	int i;
+	bool has_config;
+	struct config_section *section_node;
+	struct config_element *element_node;
+
+	for (i = 0; default_configsets[i].section_name != NULL; i++) {
+		find_config(&section_node, &element_node,
+			    default_configsets[i].section_name, default_configsets[i].name);
+
+		if (!element_node)
+			printf("%s.%s=%s\n", default_configsets[i].section_name,
+			       default_configsets[i].name, default_configsets[i].value);
+		else
+			printf("%s.%s=%s\n", section_node->name,
+			       element_node->name, element_node->value);
+	}
+
+	/* Print config variables the default configsets haven't */
+	list_for_each_entry(section_node, &sections, list) {
+		list_for_each_entry(element_node, &section_node->element_head, list) {
+			has_config = false;
+			for (i = 0; default_configsets[i].section_name != NULL; i++) {
+				if (!strcmp(default_configsets[i].section_name, section_node->name)
+				    && !strcmp(default_configsets[i].name, element_node->name)) {
+					has_config = true;
+					break;
+				}
+			}
+			if (!has_config)
+				printf("%s.%s=%s\n", section_node->name,
+				       element_node->name, element_node->value);
+		}
+	}
+
+	return 0;
+}
+
 static int perf_configset_with_option(configset_fn_t fn, const char *var, char *value)
 {
 	char *section_name;
@@ -585,6 +627,12 @@ int cmd_config(int argc, const char **argv, const char *prefix __maybe_unused)
 		else
 			goto out_err;
 		goto out;
+	case ACTION_LIST_ALL:
+		if (argc == 0)
+			ret = show_all_config();
+		else
+			goto out_err;
+		goto out;
 	default:
 		if (!has_option && argc == 0) {
 			ret = perf_config(show_config, NULL);
-- 
1.9.1
