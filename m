Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E402D38AC99
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 05:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783661816; cv=none; b=tJB6D9fMaAXjwj2CwxGPS3i/zZG6IHc0iET+yN6b/Y+yr3pq4UpQCN7jhb7fWs/W4l+ZXBT2cN8hdFxFZe1YbHxWOsU63Hg65nwZ/ZBsac8dfC42CjtU4jNMQC5ektV1+roDPFZlx915WUYXHxl4Qtbey0xY9httIjwWxQywMVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783661816; c=relaxed/simple;
	bh=XEca37zWOeFHE56tcJA4SLJ+FusttqnQWwtuGFvOx1M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QRASfbbxdtZQThOl0u/TR3Iubf+V6ttJGqO2Gv9eXxlv+XQDOA3wBIkaw1bpj0TSJi1kOw1aJ+vxrJa098iOOeuloilUAqJkLOXpB2J7ki8DlHpGMyQVYEpIaDKCjkDSW2jsOHIRmWwfNs2WRmDnsSKW0QOKVDKsPu5Z/NBA6rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T3V+cOb6; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T3V+cOb6"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c856470fe9fso518687a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 22:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783661812; x=1784266612; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C+Vx9GukDJ0QRJz+WUCiuPQ0tRu6uCtSttgbxuRRMgg=;
        b=T3V+cOb6/3JygnYr5KCpxLLFllwGyY26Q5t1FSbOmUqincGDJBsTDVT0BNjyhj7SfZ
         vaZZ35nLrwL6o9XIysYObCUf545q5IN0AMKLuuFx37wjYPdU8WgZHmGdth7W7bcWLt25
         Mc+aSN/e5/q8UcbXerNTGsRYnPC/n7VjY/fPWlye0q90GHD3KFV4ruraX+VbN8+/+BQJ
         eaQBzg+tpjcHi+k+UCY8Y3IIla+/ePi2njvW5ps8reiTW/sGWOFrlqyYq7WR5VNiWVsk
         6vCzmQS/WrZbjGbT+8FoWXR/SnXn3o2xCaiWfahTjKzo+SrjMRaE3G8LMlk7nhrhJdIL
         keHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783661812; x=1784266612;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C+Vx9GukDJ0QRJz+WUCiuPQ0tRu6uCtSttgbxuRRMgg=;
        b=anrA+PSPuXQjwToehNG29jfCoJlS1Xsx9FbKdq9ZFH2DEPCGmEuGpApLtr6MKtK0Dj
         MUTwGhND3jDhimbQWZITR9gZqCH3i7crLcWscxEcqB1CiHuqLoq90JEfPd79FzU9HpnL
         /Yb2sU/TsjsdoP/3ZWQ/Wb5C4YgRj+U3jdakAtPFzf6iq4N5yuCkQxU5jXAcRH+GSM4/
         q5RFsmEGLyGtMr4THEN0g9FmFDtgpkaHoVxFfTocjlclujpUBmrq+RZH9ee4Wqp62QVl
         0DKZVYevkZqkYN8kvzP287liZHqzqXuWgzMleI/KP9lBy3BFC3Pfl1ro52kuwOLhghlb
         WY6Q==
X-Forwarded-Encrypted: i=1; AHgh+RrineWw4yXvhA63W5gRcARDlMSkinbPm6hTqocQBgGA2QkNLAokqLLOp+5MGSLY9+rB/3ptJGMkd+I1hTU/fKl8@vger.kernel.org
X-Gm-Message-State: AOJu0Yyus/TiB6J2SKuyUPC1kkH92OUlYlH7EV7i4vxCkZjaUIGtTf1j
	BP/v/KGeFW2iaDk97ZV1jrEZ0el4qoLT1y5eGVc62gpChel0ZEjJYuXgIkXyBJ5BSeoEPmMxB53
	0sp3RJ46E+A==
X-Received: from dly1-n1.prod.google.com ([2002:a05:701b:2041:10b0:139:af25:feea])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:481:b0:3bf:e66f:266a
 with SMTP id adf61e73a8af0-3c0bd237737mr11883086637.59.1783661812045; Thu, 09
 Jul 2026 22:36:52 -0700 (PDT)
Date: Thu,  9 Jul 2026 22:36:28 -0700
In-Reply-To: <20260710053628.1861645-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710024952.1668911-1-irogers@google.com> <20260710053628.1861645-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710053628.1861645-10-irogers@google.com>
Subject: [PATCH v5 10/10] perf annotate: Be robust to annotating without a thread
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, jistone@redhat.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tianyou.li@intel.com
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
 tools/perf/ui/browsers/hists.c    | 18 +++++++-------
 tools/perf/util/annotate.c        | 40 ++++++++++++++++++++-----------
 tools/perf/util/annotate.h        |  3 ++-
 tools/perf/util/capstone.c        | 36 +++++++++++++++++++++-------
 5 files changed, 67 insertions(+), 32 deletions(-)

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
index 53b2a224b21d..63fb09b68a12 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -982,24 +982,32 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel)
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
+	if (ms->thread) {
+		machine = maps__machine(thread__maps(ms->thread));
+		e_machine = thread__e_machine(ms->thread, machine, &e_flags);
+	} else if (dso) {
+		e_machine = dso__e_machine(dso, /*machine=*/NULL, &e_flags);
 	}
 
-	machine = maps__machine(thread__maps(thread));
-	e_machine = thread__e_machine(thread, machine, &e_flags);
-	arch = arch__find(e_machine, e_flags, machine->env ? machine->env->cpuid : NULL);
+	if (e_machine == EM_NONE)
+		e_machine = thread__e_machine(NULL, NULL, &e_flags);
+
+	arch = arch__find(e_machine, e_flags,
+			  machine && machine->env ? machine->env->cpuid : NULL);
 	if (arch == NULL) {
 		pr_err("%s: unsupported arch %d\n", __func__, e_machine);
-		return errno;
+		return errno ? errno : -ENOTSUP;
 	}
 	if (parch)
 		*parch = arch;
@@ -1018,7 +1026,7 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 	const struct arch *arch = NULL;
 	int err, nr;
 
-	err = thread__get_arch(ms->thread, &arch);
+	err = map_symbol__get_arch(ms, &arch);
 	if (err)
 		return err;
 
@@ -1251,6 +1259,11 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel)
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
@@ -1266,7 +1279,6 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel)
 
 	apd.addr_fmt_width = annotated_source__addr_fmt_width(&notes->src->source,
 							      notes->src->start);
-	thread__get_arch(ms->thread, &apd.arch);
 	apd.dbg = dso__debuginfo(dso);
 
 	list_for_each_entry(pos, &notes->src->source, node) {
@@ -1371,7 +1383,7 @@ static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp,
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
index 5ad537fea436..bbb68d66466f 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -380,7 +380,7 @@ int symbol__disassemble_capstone(const char *filename, struct symbol *sym,
 	char disasm_buf[512];
 	struct disasm_line *dl;
 	bool disassembler_style = false;
-	uint16_t e_machine;
+	uint16_t e_machine = EM_NONE;
 	bool is_big_endian = false;
 
 	if (args->options->objdump_path)
@@ -411,9 +411,19 @@ int symbol__disassemble_capstone(const char *filename, struct symbol *sym,
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
+		e_machine = dso__e_machine_endian(dso, /*machine=*/NULL, /*e_flags=*/NULL,
+						  &is_big_endian);
+	}
+	if (!e_machine || e_machine == EM_NONE) {
+		e_machine = thread__e_machine_endian(NULL,
+						     /*machine=*/NULL,
+						     /*e_flags=*/NULL, &is_big_endian);
+	}
 	if (capstone_init(e_machine, &handle, is_64bit, is_big_endian, disassembler_style) < 0)
 		goto err;
 
@@ -506,7 +516,7 @@ int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
 	struct disasm_line *dl;
 	u32 *line;
 	bool disassembler_style = false;
-	uint16_t e_machine;
+	uint16_t e_machine = EM_NONE;
 	bool is_big_endian = false;
 
 	if (args->options->objdump_path)
@@ -526,9 +536,19 @@ int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
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
+		e_machine = dso__e_machine_endian(dso, /*machine=*/NULL, /*e_flags=*/NULL,
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
2.55.0.795.g602f6c329a-goog

