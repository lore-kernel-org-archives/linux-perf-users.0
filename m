From: Taeung Song <treeze.taeung@gmail.com>
Subject: [PATCH 2/2] perf tools: Add a option 'remove' to perf-config and features which get or set a config variable.
Date: Thu,  9 Apr 2015 23:26:31 +0900
Message-ID: <1428589591-22838-2-git-send-email-treeze.taeung@gmail.com>
References: <1428589591-22838-1-git-send-email-treeze.taeung@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428589591-22838-1-git-send-email-treeze.taeung@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, jolsa@redhat.com, namhyung@kernel.org, linux-perf-users@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>
List-Id: linux-perf-users.vger.kernel.org

This patch consists of adding functions
which get, set or remove a specific config variable.
For the syntax examples,

    perf config [options] [section.subkey[=value]]

    display all perf config with default values
    # perf config
    or
    # perf config -a | --all

    display a specific key(section.subkey) and value
    # perf config report.queue

    set a specific key and value
    # perf config report.queue=100M

    remove a specific key
    # perf config -r | --remove report.queue

Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
---
 tools/perf/Documentation/perf-config.txt |   8 ++
 tools/perf/builtin-config.c              | 223 ++++++++++++++++++++++++++++++-
 tools/perf/util/cache.h                  |  17 +++
 tools/perf/util/config.c                 |  35 ++++-
 4 files changed, 277 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index b251702..7354b18 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -8,7 +8,11 @@ perf-config - Get and set variables in configuration file.
 SYNOPSIS
 --------
 [verse]
+'perf config' section.subkey[=value]
+or
 'perf config' -a | --all
+or
+'perf config' -r | --remove section.subkey
 
 DESCRIPTION
 -----------
@@ -21,6 +25,10 @@ OPTIONS
 --all::
 	Show all variables with key and value into each sections.
 
+-r::
+--remove::
+	Remove a specific variable.
+
 CONFIGURATION FILE
 ------------------
 
diff --git a/tools/perf/builtin-config.c b/tools/perf/builtin-config.c
index 32f8ae6..20ae4a2 100644
--- a/tools/perf/builtin-config.c
+++ b/tools/perf/builtin-config.c
@@ -15,15 +15,24 @@
 
 static struct {
 	bool all_action;
+	bool get_action;
+	bool set_action;
+	bool remove_action;
 } params;
 
+LIST_HEAD(sections);
+static char *given_section_name;
+static char *given_subkey;
+static char *given_value;
+
 static const char * const config_usage[] = {
-	"perf config [options]",
+	"perf config [options] [section.subkey[=value]]",
 	NULL
 };
 static const struct option config_options[] = {
 	OPT_GROUP("Action"),
 	OPT_BOOLEAN('a', "all", &params.all_action, "print all configurations"),
+	OPT_BOOLEAN('r', "remove", &params.remove_action, "remove a variable: section.subkey"),
 	OPT_END()
 };
 
@@ -35,6 +44,72 @@ static void check_argc(int argc, int limit)
 	usage_with_options(config_usage, config_options);
 }
 
+static struct config_section *find_config_section(const char *section_name)
+{
+	struct config_section *section_node;
+	list_for_each_entry(section_node, &sections, list)
+		if (!strcmp(section_node->name, section_name))
+			return section_node;
+
+	return NULL;
+}
+
+static struct config_element *find_config_element(const char *subkey
+						  , struct config_section *section_node)
+{
+	struct config_element *element_node;
+
+	list_for_each_entry(element_node, &section_node->element_head, list)
+		if (!strcmp(element_node->subkey, subkey))
+			return element_node;
+
+	return NULL;
+}
+
+static struct config_section *init_config_section(const char *section_name)
+{
+	struct config_section *section_node;
+	LIST_HEAD(element_head);
+
+	section_node = zalloc(sizeof(*section_node));
+	if (!section_node)
+		return NULL;
+
+	INIT_LIST_HEAD(&section_node->element_head);
+	list_splice(&element_head, &section_node->element_head);
+	section_node->name = strdup(section_name);
+	if (!section_node->name) {
+		pr_err("%s: strdup failed\n", __func__);
+		return NULL;
+	}
+
+	return section_node;
+}
+
+static int add_config_element(struct list_head *head
+			      , const char *subkey, const char *value)
+{
+	struct config_element *element_node;
+	element_node = zalloc(sizeof(*element_node));
+	element_node->subkey = strdup(subkey);
+	if (!element_node->subkey) {
+		pr_err("%s: strdup failed\n", __func__);
+		return -1;
+	}
+	if (value) {
+		element_node->value = strdup(value);
+		if (!element_node->value) {
+			pr_err("%s: strdup failed\n", __func__);
+			return -1;
+		}
+	} else
+		element_node->value = NULL;
+
+	list_add_tail(&element_node->list, head);
+
+	return 0;
+}
+
 static int show_config(const char *key, const char *value,
 			   void *cb __maybe_unused)
 {
@@ -46,22 +121,164 @@ static int show_config(const char *key, const char *value,
 	return 0;
 }
 
+static int show_spec_config(struct config_section *section_node
+			    , struct config_element *element_node)
+{
+	char key[BUFSIZ];
+
+	if (section_node && element_node) {
+		sprintf(key, "%s.%s", section_node->name, element_node->subkey);
+		show_config(key, element_node->value, NULL);
+	}
+
+	return 0;
+}
+
+static int set_config(struct config_section *section_node, struct config_element *element_node)
+{
+	if (!given_value) {
+		/* value == NULL means remove the variable */
+		if (section_node && element_node)
+			element_node->value = NULL;
+		else /* do nothing */
+			return 0;
+	} else {
+		/* if there isn't existent section, add a new section */
+		if (!section_node) {
+			section_node = init_config_section(given_section_name);
+			if (!section_node)
+				return -1;
+			list_add_tail(&section_node->list, &sections);
+		}
+		/* if nothing to replace, add a new element which contains key-value pair. */
+		if (!element_node)
+			add_config_element(&section_node->element_head, given_subkey, given_value);
+		else
+			element_node->value = given_value;
+	}
+
+	perf_configset_write_in_full();
+
+	return 0;
+}
+
+static int collect_config(const char *var, const char *value
+			  , void *cb __maybe_unused)
+{
+	struct config_section *section_node;
+	char *section_name, *subkey;
+	char *key = strdup(var);
+
+	if (!key) {
+		pr_err("%s: strdup failed\n", __func__);
+		return -1;
+	}
+	section_name = strsep(&key, ".");
+	subkey = strsep(&key, ".");
+	section_node = find_config_section(section_name);
+	if (!section_node) {
+		/* Add a new section */
+		section_node = init_config_section(section_name);
+		if (!section_node)
+			return -1;
+		list_add_tail(&section_node->list, &sections);
+	}
+
+	add_config_element(&section_node->element_head, subkey, value);
+
+	return 0;
+}
+
+static int perf_configset_with_option(configset_fn_t fn, const char *var)
+{
+	struct config_section *section_node = NULL;
+	struct config_element *element_node = NULL;
+	char *key = strdup(var);
+	const char *last_dot = strrchr(key, '.');
+	/*
+	 * Since "key" actually contains the section name and the real
+	 * key name separated by a dot, we have to know where the dot is.
+	 */
+	if (last_dot == NULL || last_dot == key) {
+		pr_err("The config variable does not contain a section: %s", key);
+		return -1;
+	}
+	if (!last_dot[1]) {
+		pr_err("The config varible does not contain variable name: %s", key);
+		return -1;
+	}
+
+	given_value = strrchr(key, '=');
+	if (given_value == NULL || given_value == key)
+		given_value = NULL;
+	else {
+		if (!given_value[1]) {
+			pr_err("The config variable does not contain a value: %s", key);
+			return -1;
+		} else
+			given_value++;
+	}
+	given_section_name = strsep(&key, ".");
+	given_subkey = strsep(&key, ".");
+	if (strsep(&key, ".") != NULL)
+		return -1;
+	if (given_value)
+		given_subkey = strsep(&given_subkey, "=");
+
+	perf_config(collect_config, NULL);
+
+	section_node = find_config_section(given_section_name);
+
+	if (section_node != NULL)
+		element_node = find_config_element(given_subkey, section_node);
+
+	fn(section_node, element_node);
+
+	return 0;
+}
+
 int cmd_config(int argc, const char **argv, const char *prefix __maybe_unused)
 {
 	int ret = 0;
+	int origin_argc = argc - 1;
+	char *value;
+	bool is_option;
 
 	argc = parse_options(argc, argv, config_options, config_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
-	if (argc > 0) {
+	if (origin_argc > argc)
+		is_option = true;
+	else
+		is_option = false;
+
+	if (!is_option && argc > 0) {
 		if (strcmp(argv[0], "-") == 0) {
 			pr_warning("  Error: '-' is not supported.\n");
 			usage_with_options(config_usage, config_options);
 		}
+
+		switch (argc) {
+		case 1:
+			value = strrchr(argv[0], '=');
+			if (value == NULL || value == argv[0])
+				params.get_action = true;
+			else
+				params.set_action = true;
+			break;
+		default:
+			usage_with_options(config_usage, config_options);
+		}
 	}
 
-	if (argc == 0 || params.all_action) {
+	if ((!is_option && argc == 0) || params.all_action) {
 		check_argc(argc, 0);
 		ret = perf_config(show_config, NULL);
+	} else if (params.get_action) {
+		check_argc(argc, 1);
+		ret = perf_configset_with_option(show_spec_config, argv[0]);
+	} else if (params.set_action || params.remove_action) {
+		check_argc(argc, 1);
+		ret = perf_configset_with_option(set_config, argv[0]);
 	}
 
 	return ret;
diff --git a/tools/perf/util/cache.h b/tools/perf/util/cache.h
index fbcca21..17b271f 100644
--- a/tools/perf/util/cache.h
+++ b/tools/perf/util/cache.h
@@ -1,6 +1,7 @@
 #ifndef __PERF_CACHE_H
 #define __PERF_CACHE_H
 
+#include <linux/list.h>
 #include <stdbool.h>
 #include "util.h"
 #include "strbuf.h"
@@ -19,6 +20,22 @@
 #define PERF_DEBUGFS_ENVIRONMENT "PERF_DEBUGFS_DIR"
 #define PERF_TRACEFS_ENVIRONMENT "PERF_TRACEFS_DIR"
 
+struct config_element {
+	char *subkey;
+	char *value;
+	struct list_head list;
+};
+
+struct config_section {
+	char *name;
+	struct list_head element_head;
+	struct list_head list;
+};
+
+extern struct list_head sections;
+
+typedef int (*configset_fn_t)(struct config_section *, struct config_element *);
+extern int perf_configset_write_in_full(void);
 typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int perf_default_config(const char *, const char *, void *);
 extern int perf_config(config_fn_t fn, void *);
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index e18f653..ffcbe96 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -21,7 +21,7 @@
 char buildid_dir[MAXPATHLEN]; /* root dir for buildid, binary cache */
 
 static FILE *config_file;
-static const char *config_file_name;
+static char *config_file_name;
 static int config_linenr;
 static int config_file_eof;
 
@@ -420,12 +420,11 @@ static int perf_config_from_file(config_fn_t fn, const char *filename, void *dat
 	ret = -1;
 	if (f) {
 		config_file = f;
-		config_file_name = filename;
+		config_file_name = strdup(filename);
 		config_linenr = 1;
 		config_file_eof = 0;
 		ret = perf_parse_file(fn, data);
 		fclose(f);
-		config_file_name = NULL;
 	}
 	return ret;
 }
@@ -502,6 +501,36 @@ out:
 	return ret;
 }
 
+int perf_configset_write_in_full(void)
+{
+	struct config_section *section_node;
+	struct config_element *element_node;
+	char section[BUFSIZ];
+	char key_value_pair[BUFSIZ];
+	const char *first_line = "# this file is auto-generated.\n";
+	FILE *f = fopen(config_file_name, "w");
+
+	if (!f)
+		return -1;
+
+	fwrite(first_line, strlen(first_line), 1, f);
+	/* overwrite configvariables */
+	list_for_each_entry(section_node, &sections, list) {
+		sprintf(section, "[%s]\n", section_node->name);
+		fwrite(section, strlen(section), 1, f);
+		list_for_each_entry(element_node, &section_node->element_head, list) {
+			if (element_node->value) {
+				sprintf(key_value_pair, "\t%s = %s\n"
+					, element_node->subkey, element_node->value);
+				fwrite(key_value_pair, strlen(key_value_pair), 1, f);
+			}
+		}
+	}
+	fclose(f);
+
+	return 0;
+}
+
 /*
  * Call this to report error for your variable that should not
  * get a boolean value (i.e. "[my] var" means "true").
-- 
1.9.1
