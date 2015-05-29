From: Taeung Song <treeze.taeung@gmail.com>
Subject: [PATCH v2 4/4] perf tools: Add a option 'remove' to perf-config.
Date: Fri, 29 May 2015 14:42:48 +0900
Message-ID: <1432878168-11278-4-git-send-email-treeze.taeung@gmail.com>
References: <1432878168-11278-1-git-send-email-treeze.taeung@gmail.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33461 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbbE2FnT (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 29 May 2015 01:43:19 -0400
In-Reply-To: <1432878168-11278-1-git-send-email-treeze.taeung@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, jolsa@redhat.com, namhyung@kernel.org, linux-perf-users@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>

A option 'remove' is to remove specific config variables.
For the syntax examples,

    # perf config -r | --remove [section.name ...]

Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
---
 tools/perf/Documentation/perf-config.txt |  6 ++++++
 tools/perf/builtin-config.c              | 25 ++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index e33e481..a543e1b 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -13,6 +13,8 @@ or
 'perf config' -l | --list
 or
 'perf config' -a | --list-all
+or
+'perf config' -r | --remove [section.name ...]
 
 DESCRIPTION
 -----------
@@ -29,6 +31,10 @@ OPTIONS
 --list-all::
 	Show current and all possible config variables with default values.
 
+-r::
+--remove::
+	Remove specific config variables.
+
 CONFIGURATION FILE
 ------------------
 
diff --git a/tools/perf/builtin-config.c b/tools/perf/builtin-config.c
index cf7d61d..b7afe6e 100644
--- a/tools/perf/builtin-config.c
+++ b/tools/perf/builtin-config.c
@@ -22,12 +22,14 @@ static const char * const config_usage[] = {
 
 #define ACTION_LIST (1<<0)
 #define ACTION_LIST_ALL (1<<1)
+#define ACTION_REMOVE (1<<2)
 
 static const struct option config_options[] = {
 	OPT_GROUP("Action"),
 	OPT_BIT('l', "list", &actions, "show current config variables", ACTION_LIST),
 	OPT_BIT('a', "list-all", &actions,
 		"show current and all possible config variables with default values", ACTION_LIST_ALL),
+	OPT_BIT('r', "remove", &actions, "remove specific variables: [section.name ...]", ACTION_REMOVE),
 	OPT_END()
 };
 
@@ -471,7 +473,15 @@ static int set_config(const char *section_name, const char *name, char *value)
 	struct config_element *element_node = NULL;
 
 	find_config(&section_node, &element_node, section_name, name);
-	if (value != NULL) {
+	if (!value) {
+		/* value == NULL means remove the variable */
+		if (section_node && element_node) {
+			if (!element_node->value)
+				free(element_node->value);
+			element_node->value = NULL;
+		} else
+			pr_err("Error: Failed to find the variable.\n");
+	} else {
 		value = normalize_value(section_name, name, value);
 
 		/* if there isn't existent section, add a new section */
@@ -490,6 +500,7 @@ static int set_config(const char *section_name, const char *name, char *value)
 			element_node->value = value;
 		}
 	}
+
 	return perf_configset_write_in_full();
 }
 
@@ -633,6 +644,18 @@ int cmd_config(int argc, const char **argv, const char *prefix __maybe_unused)
 		else
 			goto out_err;
 		goto out;
+	case ACTION_REMOVE:
+		for (i = 0; argv[i]; i++) {
+			if (value == NULL)
+				ret = perf_configset_with_option(set_config, argv[i], NULL);
+			else {
+				pr_err("invalid key: %s\n", argv[i]);
+				return -1;
+			}
+			if (ret < 0)
+				goto out;
+		}
+		goto out;
 	default:
 		if (!has_option && argc == 0) {
 			ret = perf_config(show_config, NULL);
-- 
1.9.1
