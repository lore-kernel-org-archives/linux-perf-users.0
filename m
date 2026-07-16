Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE753B6359
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186666; cv=none; b=HqjayLphR44DQF7k914oIv0+R7+TeSnGRzn1DpHuhpC4onjXaOz3VXEsx4plLYnK+8FT0/u6g2oVssr+O8Rayj/hjU8csqxtwyeGifLG4mphEd3rVjzEkqPK0diBYz6+FCDx1lZAm+Ju5aGFlLwMzyw6rXpbYdx3bwckjHjkVfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186666; c=relaxed/simple;
	bh=JD7D0uyY6+HVpgkUn2ULCmJ0S/Lo09N36ouKOZTMKXo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EPtaIO4vsBU138qFxAU0lAPgjDTZGq+7G+CZlH7DZsCuv/gwQCKqhZg6llOymT08JDqMzcTsfiPTkTQm0nDZZrEyeMFOrUzTRkSCBkEY5cCb5Lyo3TBPnAhg7XHlzBJap5NSjZ2HFqUD5Z/mKwmRq0jiobxzeIdVe2vNriwswwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UDFjyWhO; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UDFjyWhO"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c9151bf6ce7so7081951a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 00:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784186653; x=1784791453; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=twMSVjb93UZntKTS9G8AuzRoX1EFDBeYb4NYND+AkFM=;
        b=UDFjyWhOgiEfNvpQxZZLYSjLzkJnZx3KUUlqzMajMJ8Wfx8qEclpPN+Ui6WzZA9e9c
         Ath2i+3oqjR6RdwdV+Ti3knE+uWQtDvi9q/Ec23HJIefm4ihnT8yoizwOdvIx6OLSyht
         xgcmvnMCWcTDsuPbNGDndSpnOgStUoouyoR2KHLWrpicNDiWTFHEzdIO1pbdAUu25cDx
         0434a/N1kKDQCnGgtwR63Ft2IDXfBvxBmnoyoloa0XQ0vl+3DoPdv78s5jfh/HHLrTyp
         gxyhnJJMYB5JUDvWk64kubkZqfNSuAyBGb7DyetdhQ7mIiAjNy+gLfcMyR+XPSXxO+4q
         TWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784186653; x=1784791453;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=twMSVjb93UZntKTS9G8AuzRoX1EFDBeYb4NYND+AkFM=;
        b=k/bHFm6Rg0E4RrYqdVyU6fVzKi0aJ14ISpFvV1uxaF2oZSYF5sSlFqIvUB870mbjFZ
         4SVi+XS2ChXTeJPel9R/Z13NU7K6CylCCZJsYdrFlWKZh9OfTpCDRLsRVbp8kxxbc203
         i6/fmyMGcV2QOFY5upByXoOo5G+8qrw2Z1Ct/i8WjHZv17+9NUUADouv34REyE1QU69E
         Uu2iDCmz1HL7nAsDq5ECRimxg/ZdmEMM5QpDjlnGH8LVXDinKHSZ0OFm4vAy68vxAMjS
         2K4OW1hP4XcTpzEmzw5hQVp8j/r62ZkkcKdIfFHqpqFDQovXcsUfZQf8qnmC2EHJVPOF
         tPOw==
X-Forwarded-Encrypted: i=1; AHgh+Rq5+E8svw/AU5AQRvtfBtKuDgj6IL56M1IRi0z3XU7FHlwwu6fTmkgcNLxIdel13cDb4KXPbtRgpTBq9LIlQdYJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ9A2q42Q/RRCJ2cLQdhLQ5EKj+6OzOYP/eyKxpRjY5oGnnuGt
	k66/D1KWAOuSGRqjk12EGRisPL3Rv5FyDJN0DdRA+yILl93zBqpHacb9Zf9mvI7wMmvn1V3XK7A
	pASjBHJDnRA==
X-Received: from dykf24.prod.google.com ([2002:a05:7300:6918:b0:30f:1818:9ce5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c6cb:b0:3c0:9c19:6586
 with SMTP id adf61e73a8af0-3c3576486ecmr10732600637.64.1784186652855; Thu, 16
 Jul 2026 00:24:12 -0700 (PDT)
Date: Thu, 16 Jul 2026 00:23:51 -0700
In-Reply-To: <20260716072351.560311-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710053628.1861645-1-irogers@google.com> <20260716072351.560311-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716072351.560311-10-irogers@google.com>
Subject: [PATCH v6 10/10] perf annotate: Be robust to annotating without a thread
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jistone@redhat.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tianyou.li@intel.com
Content-Type: text/plain; charset="UTF-8"

If a thread isn't given to map_symbol__get_arch try harder to determine
the arch for disassembly. Do this by using fallback paths such as
reading the e_machine from a map's dso. At the same time, ensure some
other uses of map_symbol thread don't assume it is non-NULL to avoid
segfaults, and handle Capstone disassembly gracefully. Since
map_symbol__get_arch supports both map_symbol and thread fallbacks,
completely remove the now redundant and fragile thread__get_arch()
function and migrate all remaining callers.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/annotate.c |  2 +-
 tools/perf/ui/browsers/hists.c    | 18 ++++++------
 tools/perf/util/annotate.c        | 48 ++++++++++++++++++++++---------
 tools/perf/util/annotate.h        |  3 +-
 tools/perf/util/capstone.c        | 42 +++++++++++++++++++++------
 5 files changed, 81 insertions(+), 32 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index d25761a8d25e..e47a46775089 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -1201,7 +1201,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 				ui__warning("Annotation has no source code.");
 		}
 	} else {
-		err = thread__get_arch(ms->thread, &browser.arch);
+		err = map_symbol__get_arch(ms, &browser.arch);
 		if (err) {
 			annotate_browser__symbol_annotate_error(&browser, err);
 			return -1;
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 570d1c07ca23..7df408bde7a5 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2580,7 +2580,7 @@ add_annotate_type_opt(struct popup_action *act, char **optstr,
 static int
 do_zoom_thread(struct hist_browser *browser, struct popup_action *act)
 {
-	struct thread *thread = act->thread;
+	struct thread *thread = act->ms.thread;
 
 	if ((!hists__has(browser->hists, thread) &&
 	     !hists__has(browser->hists, comm)) || thread == NULL)
@@ -2742,8 +2742,8 @@ do_run_script(struct hist_browser *browser,
 	int n = 0;
 
 	len = 100;
-	if (act->thread)
-		len += strlen(thread__comm_str(act->thread));
+	if (act->ms.thread)
+		len += strlen(thread__comm_str(act->ms.thread));
 	else if (act->ms.sym)
 		len += strlen(act->ms.sym->name);
 	script_opt = malloc(len);
@@ -2751,9 +2751,9 @@ do_run_script(struct hist_browser *browser,
 		return -1;
 
 	script_opt[0] = 0;
-	if (act->thread) {
+	if (act->ms.thread) {
 		n = scnprintf(script_opt, len, " -c %s ",
-			  thread__comm_str(act->thread));
+			  thread__comm_str(act->ms.thread));
 	} else if (act->ms.sym) {
 		n = scnprintf(script_opt, len, " -S %s ",
 			  act->ms.sym->name);
@@ -3021,7 +3021,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 	struct branch_info *bi = NULL;
 #define MAX_OPTIONS  32
 	char *options[MAX_OPTIONS];
-	struct popup_action actions[MAX_OPTIONS];
+	struct popup_action actions[MAX_OPTIONS], hotkey_act;
 	int nr_options = 0;
 	int key = -1;
 	char buf[128];
@@ -3347,8 +3347,10 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 				 */
 				do_zoom_dso(browser, actions);
 			} else if (top == &browser->hists->thread_filter) {
-				actions->thread = thread;
-				do_zoom_thread(browser, actions);
+				memset(&hotkey_act, 0, sizeof(hotkey_act));
+				hotkey_act.ms.thread = thread__get(thread);
+				do_zoom_thread(browser, &hotkey_act);
+				map_symbol__exit(&hotkey_act.ms);
 			} else if (top == &browser->hists->socket_filter) {
 				do_zoom_socket(browser, actions);
 			}
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 53b2a224b21d..af4e8afcf82b 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -982,24 +982,40 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel)
 	annotation__calc_percent(notes, evsel, symbol__size(sym));
 }
 
-int thread__get_arch(struct thread *thread, const struct arch **parch)
+
+
+int map_symbol__get_arch(struct map_symbol *ms, const struct arch **parch)
 {
 	const struct arch *arch;
-	struct machine *machine;
-	uint32_t e_flags;
-	uint16_t e_machine;
+	struct machine *machine = NULL;
+	struct map *map = ms->map;
+	struct dso *dso = map ? map__dso(map) : NULL;
+	uint32_t e_flags = 0;
+	uint16_t e_machine = EM_NONE;
 
-	if (!thread) {
-		*parch = NULL;
-		return -1;
+	const char *cpuid = NULL;
+
+	if (ms->thread) {
+		machine = maps__machine(thread__maps(ms->thread));
+		e_machine = thread__e_machine(ms->thread, machine, &e_flags);
+		if (machine && machine->env)
+			cpuid = machine->env->cpuid;
+	} else if (dso) {
+		struct maps *kmaps = map ? map__kmaps(map) : NULL;
+		struct machine *kmap_machine = kmaps ? maps__machine(kmaps) : NULL;
+
+		e_machine = dso__e_machine(dso, kmap_machine, &e_flags);
+		if (kmap_machine && kmap_machine->env)
+			cpuid = kmap_machine->env->cpuid;
 	}
 
-	machine = maps__machine(thread__maps(thread));
-	e_machine = thread__e_machine(thread, machine, &e_flags);
-	arch = arch__find(e_machine, e_flags, machine->env ? machine->env->cpuid : NULL);
+	if (e_machine == EM_NONE)
+		e_machine = thread__e_machine(NULL, NULL, &e_flags);
+
+	arch = arch__find(e_machine, e_flags, cpuid);
 	if (arch == NULL) {
 		pr_err("%s: unsupported arch %d\n", __func__, e_machine);
-		return errno;
+		return errno ? errno : -ENOTSUP;
 	}
 	if (parch)
 		*parch = arch;
@@ -1018,7 +1034,7 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 	const struct arch *arch = NULL;
 	int err, nr;
 
-	err = thread__get_arch(ms->thread, &arch);
+	err = map_symbol__get_arch(ms, &arch);
 	if (err)
 		return err;
 
@@ -1251,6 +1267,11 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel)
 		evsel_name = buf;
 	}
 
+	if (map_symbol__get_arch(ms, &apd.arch)) {
+		free(filename);
+		return -ENOTSUP;
+	}
+
 	graph_dotted_len = printf(" %-*.*s|	Source code & Disassembly of %s for %s (%" PRIu64 " samples, "
 				  "percent: %s)\n",
 				  width, width, symbol_conf.show_total_period ? "Period" :
@@ -1266,7 +1287,6 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel)
 
 	apd.addr_fmt_width = annotated_source__addr_fmt_width(&notes->src->source,
 							      notes->src->start);
-	thread__get_arch(ms->thread, &apd.arch);
 	apd.dbg = dso__debuginfo(dso);
 
 	list_for_each_entry(pos, &notes->src->source, node) {
@@ -1371,7 +1391,7 @@ static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp,
 	struct annotation_line *al;
 
 	if (annotate_opts.code_with_type) {
-		thread__get_arch(apd->he->ms.thread, &apd->arch);
+		map_symbol__get_arch(&apd->he->ms, &apd->arch);
 		apd->dbg = dso__debuginfo(map__dso(apd->he->ms.map));
 	}
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 1aa6df7d1618..fa08d09b80f7 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -584,5 +584,6 @@ int annotation_br_cntr_entry(char **str, int br_cntr_nr, u64 *br_cntr,
 			     int num_aggr, struct evsel *evsel);
 int annotation_br_cntr_abbr_list(char **str, struct evsel *evsel, bool header);
 
-int thread__get_arch(struct thread *thread, const struct arch **parch);
+
+int map_symbol__get_arch(struct map_symbol *ms, const struct arch **parch);
 #endif	/* __PERF_ANNOTATE_H */
diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index 9bba78ee0c5a..758ce837b373 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -385,7 +385,7 @@ int symbol__disassemble_capstone(const char *filename, struct symbol *sym,
 	char disasm_buf[512];
 	struct disasm_line *dl;
 	bool disassembler_style = false;
-	uint16_t e_machine;
+	uint16_t e_machine = EM_NONE;
 	bool is_big_endian = false;
 
 	if (args->options->objdump_path)
@@ -416,9 +416,22 @@ int symbol__disassemble_capstone(const char *filename, struct symbol *sym,
 	    !strcmp(args->options->disassembler_style, "att"))
 		disassembler_style = true;
 
-	e_machine = thread__e_machine_endian(args->ms->thread,
-					     /*machine=*/NULL,
-					     /*e_flags=*/NULL, &is_big_endian);
+	if (args->ms->thread) {
+		e_machine = thread__e_machine_endian(args->ms->thread,
+						     /*machine=*/NULL,
+						     /*e_flags=*/NULL, &is_big_endian);
+	} else if (dso) {
+		struct maps *kmaps = map ? map__kmaps(map) : NULL;
+		struct machine *kmap_machine = kmaps ? maps__machine(kmaps) : NULL;
+
+		e_machine = dso__e_machine_endian(dso, kmap_machine, /*e_flags=*/NULL,
+						  &is_big_endian);
+	}
+	if (!e_machine || e_machine == EM_NONE) {
+		e_machine = thread__e_machine_endian(NULL,
+						     /*machine=*/NULL,
+						     /*e_flags=*/NULL, &is_big_endian);
+	}
 	if (capstone_init(e_machine, &handle, is_64bit, is_big_endian, disassembler_style) < 0)
 		goto err;
 
@@ -511,7 +524,7 @@ int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
 	struct disasm_line *dl;
 	u32 *line;
 	bool disassembler_style = false;
-	uint16_t e_machine;
+	uint16_t e_machine = EM_NONE;
 	bool is_big_endian = false;
 
 	if (args->options->objdump_path)
@@ -531,9 +544,22 @@ int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
 	    !strcmp(args->options->disassembler_style, "att"))
 		disassembler_style = true;
 
-	e_machine = thread__e_machine_endian(args->ms->thread,
-					     /*machine=*/NULL,
-					     /*e_flags=*/NULL, &is_big_endian);
+	if (args->ms->thread) {
+		e_machine = thread__e_machine_endian(args->ms->thread,
+						     /*machine=*/NULL,
+						     /*e_flags=*/NULL, &is_big_endian);
+	} else if (dso) {
+		struct maps *kmaps = map ? map__kmaps(map) : NULL;
+		struct machine *kmap_machine = kmaps ? maps__machine(kmaps) : NULL;
+
+		e_machine = dso__e_machine_endian(dso, kmap_machine, /*e_flags=*/NULL,
+						  &is_big_endian);
+	}
+	if (!e_machine || e_machine == EM_NONE) {
+		e_machine = thread__e_machine_endian(NULL,
+						     /*machine=*/NULL,
+						     /*e_flags=*/NULL, &is_big_endian);
+	}
 	if (capstone_init(e_machine, &handle, is_64bit, is_big_endian, disassembler_style) < 0)
 		goto err;
 
-- 
2.55.0.141.g00534a21ce-goog

