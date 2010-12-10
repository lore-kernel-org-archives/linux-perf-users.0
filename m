From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 1/2] perf-probe: do use the kernel image path given by 'k' option
Date: Fri, 10 Dec 2010 14:06:03 +0100
Message-ID: <m3hbelydz8.fsf_-_@gmail.com>
References: <m2pqtb9ekn.fsf@gmail.com>
	<20101209153548.GA11820@ghostprotocols.net> <m2k4jiewhi.fsf@gmail.com>
	<4D019E3F.4040902@hitachi.com> <m3pqtaxdv8.fsf@gmail.com>
	<4D01E453.3000208@hitachi.com> <m3lj3xye9a.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64338 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756292Ab0LJNGI (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 10 Dec 2010 08:06:08 -0500
Received: by wyb28 with SMTP id 28so3419267wyb.19
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Dec 2010 05:06:07 -0800 (PST)
In-Reply-To: <m3lj3xye9a.fsf@gmail.com> (Franck Bui-Huu's message of "Fri, 10
	Dec 2010 14:00:01 +0100")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Francis Moreau <francis.moro@gmail.com>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, linux-perf-users@vger.kernel.org, 2nddept-manager@sdl.hitachi.co.jp

From: Franck Bui-Huu <fbuihuu@gmail.com>

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 tools/perf/builtin-probe.c    |    5 +++++
 tools/perf/util/probe-event.c |   15 ++++++++++++---
 tools/perf/util/symbol.c      |    4 ++--
 tools/perf/util/symbol.h      |    2 ++
 4 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 2e000c0..add163c 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -249,6 +249,11 @@ int cmd_probe(int argc, const char **argv, const char *prefix __used)
 	     !params.show_lines))
 		usage_with_options(probe_usage, options);
 
+	/*
+	 * Only consider the user's kernel image path if given.
+	 */
+	symbol_conf.try_vmlinux_path = (symbol_conf.vmlinux_name == NULL);
+
 	if (params.list_events) {
 		if (params.mod_events) {
 			pr_err("  Error: Don't use --list with --add/--del.\n");
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 694f04b..99f9933 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -114,6 +114,8 @@ static struct symbol *__find_kernel_function_by_name(const char *name,
 const char *kernel_get_module_path(const char *module)
 {
 	struct dso *dso;
+	struct map *map;
+	const char *vmlinux_name;
 
 	if (module) {
 		list_for_each_entry(dso, &machine.kernel_dsos, node) {
@@ -123,10 +125,17 @@ const char *kernel_get_module_path(const char *module)
 		}
 		pr_debug("Failed to find module %s.\n", module);
 		return NULL;
+	}
+
+	map = machine.vmlinux_maps[MAP__FUNCTION];
+	dso = map->dso;
+
+	vmlinux_name = symbol_conf.vmlinux_name;
+	if (vmlinux_name) {
+		if (dso__load_vmlinux(dso, map, vmlinux_name, NULL) <= 0)
+			return NULL;
 	} else {
-		dso = machine.vmlinux_maps[MAP__FUNCTION]->dso;
-		if (dso__load_vmlinux_path(dso,
-			 machine.vmlinux_maps[MAP__FUNCTION], NULL) < 0) {
+		if (dso__load_vmlinux_path(dso, map, NULL) < 0) {
 			pr_debug("Failed to load kernel map.\n");
 			return NULL;
 		}
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a3a0c43..4e42e0d 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1780,8 +1780,8 @@ out_failure:
 	return -1;
 }
 
-static int dso__load_vmlinux(struct dso *self, struct map *map,
-			     const char *vmlinux, symbol_filter_t filter)
+int dso__load_vmlinux(struct dso *self, struct map *map,
+		      const char *vmlinux, symbol_filter_t filter)
 {
 	int err = -1, fd;
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 038f220..6c6eafd 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -166,6 +166,8 @@ void dso__sort_by_name(struct dso *self, enum map_type type);
 struct dso *__dsos__findnew(struct list_head *head, const char *name);
 
 int dso__load(struct dso *self, struct map *map, symbol_filter_t filter);
+int dso__load_vmlinux(struct dso *self, struct map *map,
+		      const char *vmlinux, symbol_filter_t filter);
 int dso__load_vmlinux_path(struct dso *self, struct map *map,
 			   symbol_filter_t filter);
 int dso__load_kallsyms(struct dso *self, const char *filename, struct map *map,
-- 
1.7.3.2
