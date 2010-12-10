From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: Re: perf-probe: issue with latest fedora kernel
Date: Fri, 10 Dec 2010 08:53:47 +0100
Message-ID: <m3pqtaxdv8.fsf@gmail.com>
References: <m2pqtb9ekn.fsf@gmail.com>
	<20101209153548.GA11820@ghostprotocols.net> <m2k4jiewhi.fsf@gmail.com>
	<4D019E3F.4040902@hitachi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46802 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136Ab0LJHxy (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 10 Dec 2010 02:53:54 -0500
Received: by wwa36 with SMTP id 36so3415579wwa.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Dec 2010 23:53:53 -0800 (PST)
In-Reply-To: <4D019E3F.4040902@hitachi.com> (Masami Hiramatsu's message of
	"Fri, 10 Dec 2010 12:27:59 +0900")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Francis Moreau <francis.moro@gmail.com>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, linux-perf-users@vger.kernel.org, 2nddept-manager@sdl.hitachi.co.jp

Hi,

Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com> writes:

> (2010/12/10 1:34), Francis Moreau wrote:

[...]

>> 
>> Well that still fail:
>> 
>> $ perf probe -k /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64.debug/vmlinux schedule cpu
>> Failed to find path of kernel moduleFailed to open debuginfo file.
>>   Error: Failed to add events. (-2)
>> 
>> but that's not really suprising if perf checks that the running kernel
>> build-id is the same as the one in:
>> /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64.debug/vmlinux
>> 
>> It really looks like something is broken in the F14 kernel-debuginfo
>> package.
>
> Hmm, curious. I'll check it after setting up Fedora 14.
> Thank you for reporting :-)

BTW, it seems to me that perf-probe(1) is ignoring the kernel path given
by '-k' switch.

Looking at kernel_get_module_path(), it only considers the standard
paths given by vmlinux_path[].

I would have seen this, no ?

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
index 694f04b..558545e 100644
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
@@ -123,14 +125,23 @@ const char *kernel_get_module_path(const char *module)
 		}
 		pr_debug("Failed to find module %s.\n", module);
 		return NULL;
-	} else {
-		dso = machine.vmlinux_maps[MAP__FUNCTION]->dso;
-		if (dso__load_vmlinux_path(dso,
-			 machine.vmlinux_maps[MAP__FUNCTION], NULL) < 0) {
-			pr_debug("Failed to load kernel map.\n");
-			return NULL;
-		}
 	}
+
+	map = machine.vmlinux_maps[MAP__FUNCTION];
+	dso = map->dso;
+
+	vmlinux_name = symbol_conf.vmlinux_name;
+	if (vmlinux_name) {
+		if (dso__load_vmlinux(dso, map, vmlinux_name, NULL) == 0)
+			goto found;
+		return NULL;
+	}
+
+	if (dso__load_vmlinux_path(dso, map, NULL) < 0) {
+		pr_debug("Failed to load kernel map.\n");
+		return NULL;
+	}
+
 found:
 	return dso->long_name;
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
		Franck
