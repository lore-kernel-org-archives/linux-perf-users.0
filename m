From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/32] tools lib traceevent: Use asprintf when possible
Date: Wed, 17 Jan 2018 13:12:04 -0300
Message-ID: <20180117161222.15611-15-acme@kernel.org>
References: <20180117161222.15611-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117161222.15611-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Federico Vaga <federico.vaga@vaga.pv.it>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Federico Vaga <federico.vaga@vaga.pv.it>

It makes the code clearer and less error prone.

clearer:
- less code
- the code is now using the same format to create strings dynamically

less error prone:
- no magic number +2 +9 +5 to compute the size
- no copy&paste of the strings to compute the size and to concatenate

The function `asprintf` is not POSIX standard but the program
was already using it. Later it can be decided to use only POSIX
functions, then we can easly replace all the `asprintf(3)` with a local
implementation of that function.

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Federico Vaga <federico.vaga@vaga.pv.it>
Link: http://lkml.kernel.org/r/20170802221558.9684-2-federico.vaga@vaga.pv.it
Link: http://lkml.kernel.org/r/20180112004822.686281649@goodmis.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-plugin.c | 24 +++++++++---------------
 tools/lib/traceevent/parse-filter.c | 11 ++++-------
 2 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/tools/lib/traceevent/event-plugin.c b/tools/lib/traceevent/event-plugin.c
index a16756ae3526..d542cb60ca1a 100644
--- a/tools/lib/traceevent/event-plugin.c
+++ b/tools/lib/traceevent/event-plugin.c
@@ -120,12 +120,12 @@ char **traceevent_plugin_list_options(void)
 		for (op = reg->options; op->name; op++) {
 			char *alias = op->plugin_alias ? op->plugin_alias : op->file;
 			char **temp = list;
+			int ret;
 
-			name = malloc(strlen(op->name) + strlen(alias) + 2);
-			if (!name)
+			ret = asprintf(&name, "%s:%s", alias, op->name);
+			if (ret < 0)
 				goto err;
 
-			sprintf(name, "%s:%s", alias, op->name);
 			list = realloc(list, count + 2);
 			if (!list) {
 				list = temp;
@@ -290,17 +290,14 @@ load_plugin(struct pevent *pevent, const char *path,
 	const char *alias;
 	char *plugin;
 	void *handle;
+	int ret;
 
-	plugin = malloc(strlen(path) + strlen(file) + 2);
-	if (!plugin) {
+	ret = asprintf(&plugin, "%s/%s", path, file);
+	if (ret < 0) {
 		warning("could not allocate plugin memory\n");
 		return;
 	}
 
-	strcpy(plugin, path);
-	strcat(plugin, "/");
-	strcat(plugin, file);
-
 	handle = dlopen(plugin, RTLD_NOW | RTLD_GLOBAL);
 	if (!handle) {
 		warning("could not load plugin '%s'\n%s\n",
@@ -391,6 +388,7 @@ load_plugins(struct pevent *pevent, const char *suffix,
 	char *home;
 	char *path;
 	char *envdir;
+	int ret;
 
 	if (pevent->flags & PEVENT_DISABLE_PLUGINS)
 		return;
@@ -421,16 +419,12 @@ load_plugins(struct pevent *pevent, const char *suffix,
 	if (!home)
 		return;
 
-	path = malloc(strlen(home) + strlen(LOCAL_PLUGIN_DIR) + 2);
-	if (!path) {
+	ret = asprintf(&path, "%s/%s", home, LOCAL_PLUGIN_DIR);
+	if (ret < 0) {
 		warning("could not allocate plugin memory\n");
 		return;
 	}
 
-	strcpy(path, home);
-	strcat(path, "/");
-	strcat(path, LOCAL_PLUGIN_DIR);
-
 	load_plugins_dir(pevent, suffix, path, load_plugin, data);
 
 	free(path);
diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
index 315df0a70265..2410afdcbcfe 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -287,12 +287,10 @@ find_event(struct pevent *pevent, struct event_list **events,
 		sys_name = NULL;
 	}
 
-	reg = malloc(strlen(event_name) + 3);
-	if (reg == NULL)
+	ret = asprintf(&reg, "^%s$", event_name);
+	if (ret < 0)
 		return PEVENT_ERRNO__MEM_ALLOC_FAILED;
 
-	sprintf(reg, "^%s$", event_name);
-
 	ret = regcomp(&ereg, reg, REG_ICASE|REG_NOSUB);
 	free(reg);
 
@@ -300,13 +298,12 @@ find_event(struct pevent *pevent, struct event_list **events,
 		return PEVENT_ERRNO__INVALID_EVENT_NAME;
 
 	if (sys_name) {
-		reg = malloc(strlen(sys_name) + 3);
-		if (reg == NULL) {
+		ret = asprintf(&reg, "^%s$", sys_name);
+		if (ret < 0) {
 			regfree(&ereg);
 			return PEVENT_ERRNO__MEM_ALLOC_FAILED;
 		}
 
-		sprintf(reg, "^%s$", sys_name);
 		ret = regcomp(&sreg, reg, REG_ICASE|REG_NOSUB);
 		free(reg);
 		if (ret) {
-- 
2.14.3
