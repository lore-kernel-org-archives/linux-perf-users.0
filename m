Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDF412B82
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jul 2024 01:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720055874; cv=none; b=Cu4HiWyZAf5H5KatddPnLoA1IJOr2gGuOZFHmOzi9gevwVeMT01fZe7Ogm6VZ8NL61Jgr4l8irgaJHleG+Pc8ooZ/BX9SZVht6pI9rpIeKdmjjyEAvUpHfom+ZBBi5ZPdUmK9HZRcpQid1Zd9k1nJ6ZUVavLB6fFmwcxd7qz3js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720055874; c=relaxed/simple;
	bh=RuXS6kX5E/iB6dgT/TAlQuY/RbLqmrw49mG9pfhmCXo=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=rgn26e0HiVTLHl1OFtzwbnyuFNETvnBP9Hj3ks6Wxbcsx8gCts8eKVtrs5fiHGBQkSizK6aA0tHtz1yE8EF5lvN7La1GOKtgyOkOAMDQU75R9GRllnyQ4ym4v7nKjH1Q0Oq3VcwdZx3/eM0cc8HrcCXDhDxd786zDFNfx1gGnrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZyYIAdNy; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZyYIAdNy"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-650f5b28822so2283327b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jul 2024 18:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720055872; x=1720660672; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8mf5XeO+A2Esfoq50QT65AcDhkS51kHOGNVMAqQKgIE=;
        b=ZyYIAdNyGY8YY+6c8QBODCYu9dbtjfoEmsA69nLeXKimZUv5w7YjFezygAL60YvS6u
         zi+lkswdZpw2VNJPGGCWuAMrxVXTyYzY7h8pebHB9Xe9GISnh4U9GUG1VkPb/YNHfwz2
         oGKPoqP2fTUy6uiMaI7Ifx8BtvbpHgTvmTXWUaciUGAaDZfvyL33pxQdZAG80hGQ734J
         2Mt97prEDOJNsXR1zB6mfLpyZTmpc80ngJmPe9u3zqmSIl1uNKGZdMpg+0spIhAYBr2A
         6DZEGObGS8ZZ0EA86oFCXI15YYcarvsprkIZ+UJJ7piOUMzx75S+Fv1nhtQbC1hou7Zm
         tnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720055872; x=1720660672;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8mf5XeO+A2Esfoq50QT65AcDhkS51kHOGNVMAqQKgIE=;
        b=ms6TLOLtgzDdRR5pXhkTfW9YD49riOL32F0G5H/DuIlpu5x6/Me59h7BiRgCfVT0Xd
         KgCUtMWgSz1BEIU4q3tHCJXfw4EWZK7BEou49y6WFQHdRYPa/1qjCV52o6dL3KwqWmx/
         zZOmhrRUKmo6t3UHq8MzmEn4e4nn6JRWnQyikTs6rhyIOvrjr+yDZPLO8TlZDJu8HHtT
         pi7FVClN87bqCWp6h4bbA6v7CzFSDrI7EWX/wLoggnVrrarPFXNd64ngLDuiNZTEcQP4
         iBT+TCaDeOvNODGxEtS3WZTFiOgeTjVczDD8pzaqLKdUi6QB8tM4Jw7tyIYlmwgw9nZJ
         BMyA==
X-Forwarded-Encrypted: i=1; AJvYcCUZNTFG3wmhNYIGWjW0R5I/ZSquMqQzLdpvgIV/BqkEJiiECUyKI2VJQVPHuvFWztqSQoOQd0wSzTf6Bvjco09igG3moCYCmEJtEF/R26mZWg==
X-Gm-Message-State: AOJu0YzoR9xVLHMLQA3/juCPNJ+t2Q9H9IqHcCaMmdjP5cmNAMK83h54
	edFysWjXduEOOXX4lh1jLC9zTzObN5IgSNr9ZPJD21dI7Se7wcuosxNKlVZK9UGm4wIdImkQRfq
	WMgYNXQ==
X-Google-Smtp-Source: AGHT+IFdK3nZy/TML3YPagnpeyIdjnlPw/Q5fijq7y23M4KwwwBd1r5qLsIuxhkorLuSNHFouJvNVyI29ECX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7d6:684a:630e:e89f])
 (user=irogers job=sendgmr) by 2002:a0d:e8c7:0:b0:62c:67f4:4f5 with SMTP id
 00721157ae682-652d813854amr26867b3.9.1720055872072; Wed, 03 Jul 2024 18:17:52
 -0700 (PDT)
Date: Wed,  3 Jul 2024 18:17:45 -0700
Message-Id: <20240704011745.1021288-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v1] perf dso: Fix address sanitizer build
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Yunseong Kim <yskelg@gmail.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Various files had been missed from having accessor functions added for
the sake of dso reference count checking. Add the function calls and
missing dso accessor functions.

Fixes: ee756ef7491e ("perf dso: Add reference count checking and accessor functions")
Signed-off-by: Ian Rogers <irogers@google.com>

---
Part of this fix was previously sent in unmerged change:
https://lore.kernel.org/lkml/20240629045350.285243-4-irogers@google.com/
---
 .../arch/powerpc/util/skip-callchain-idx.c     |  8 ++++----
 tools/perf/ui/gtk/annotate.c                   |  5 +++--
 tools/perf/util/cs-etm.c                       | 10 +++++-----
 tools/perf/util/disasm.c                       | 10 +++++-----
 tools/perf/util/dso.h                          | 10 ++++++++++
 tools/perf/util/srcline.c                      | 12 ++++++------
 tools/perf/util/symbol.c                       | 15 ++++++++-------
 tools/perf/util/unwind-libdw.c                 | 12 ++++++------
 tools/perf/util/unwind-libunwind-local.c       | 18 +++++++++---------
 9 files changed, 56 insertions(+), 44 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
index 5f3edb3004d8..356786432fd3 100644
--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -159,9 +159,9 @@ static int check_return_addr(struct dso *dso, u64 map_start, Dwarf_Addr pc)
 	Dwarf_Addr	start = pc;
 	Dwarf_Addr	end = pc;
 	bool		signalp;
-	const char	*exec_file = dso->long_name;
+	const char	*exec_file = dso__long_name(dso);
 
-	dwfl = dso->dwfl;
+	dwfl = RC_CHK_ACCESS(dso)->dwfl;
 
 	if (!dwfl) {
 		dwfl = dwfl_begin(&offline_callbacks);
@@ -183,7 +183,7 @@ static int check_return_addr(struct dso *dso, u64 map_start, Dwarf_Addr pc)
 			dwfl_end(dwfl);
 			goto out;
 		}
-		dso->dwfl = dwfl;
+		RC_CHK_ACCESS(dso)->dwfl = dwfl;
 	}
 
 	mod = dwfl_addrmodule(dwfl, pc);
@@ -267,7 +267,7 @@ int arch_skip_callchain_idx(struct thread *thread, struct ip_callchain *chain)
 	rc = check_return_addr(dso, map__start(al.map), ip);
 
 	pr_debug("[DSO %s, sym %s, ip 0x%" PRIx64 "] rc %d\n",
-				dso->long_name, al.sym->name, ip, rc);
+		dso__long_name(dso), al.sym->name, ip, rc);
 
 	if (rc == 0) {
 		/*
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index 93ce3d47e47e..6da24aa039eb 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -180,13 +180,14 @@ static int symbol__gtk_annotate(struct map_symbol *ms, struct evsel *evsel,
 	GtkWidget *tab_label;
 	int err;
 
-	if (dso->annotate_warned)
+	if (dso__annotate_warned(dso))
 		return -1;
 
 	err = symbol__annotate(ms, evsel, NULL);
 	if (err) {
 		char msg[BUFSIZ];
-		dso->annotate_warned = true;
+
+		dso__set_annotate_warned(dso);
 		symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
 		ui__error("Couldn't annotate %s: %s\n", sym->name, msg);
 		return -1;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 32818bd7cd17..5e9fbcfad7d4 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1013,7 +1013,7 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
 	if (!dso)
 		goto out;
 
-	if (dso->data.status == DSO_DATA_STATUS_ERROR &&
+	if (dso__data(dso)->status == DSO_DATA_STATUS_ERROR &&
 	    dso__data_status_seen(dso, DSO_DATA_STATUS_SEEN_ITRACE))
 		goto out;
 
@@ -1027,11 +1027,11 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
 	if (len <= 0) {
 		ui__warning_once("CS ETM Trace: Missing DSO. Use 'perf archive' or debuginfod to export data from the traced system.\n"
 				 "              Enable CONFIG_PROC_KCORE or use option '-k /path/to/vmlinux' for kernel symbols.\n");
-		if (!dso->auxtrace_warned) {
+		if (!dso__auxtrace_warned(dso)) {
 			pr_err("CS ETM Trace: Debug data not found for address %#"PRIx64" in %s\n",
-				    address,
-				    dso->long_name ? dso->long_name : "Unknown");
-			dso->auxtrace_warned = true;
+				address,
+				dso__long_name(dso) ? dso__long_name(dso) : "Unknown");
+			dso__set_auxtrace_warned(dso);
 		}
 		goto out;
 	}
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 72aec8f61b94..e10558b79504 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1199,7 +1199,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 	int ret;
 	FILE *s;
 
-	if (dso->binary_type != DSO_BINARY_TYPE__BPF_PROG_INFO)
+	if (dso__binary_type(dso) != DSO_BINARY_TYPE__BPF_PROG_INFO)
 		return SYMBOL_ANNOTATE_ERRNO__BPF_INVALID_FILE;
 
 	pr_debug("%s: handling sym %s addr %" PRIx64 " len %" PRIx64 "\n", __func__,
@@ -1226,14 +1226,14 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 	info.arch = bfd_get_arch(bfdf);
 	info.mach = bfd_get_mach(bfdf);
 
-	info_node = perf_env__find_bpf_prog_info(dso->bpf_prog.env,
-						 dso->bpf_prog.id);
+	info_node = perf_env__find_bpf_prog_info(dso__bpf_prog(dso)->env,
+						 dso__bpf_prog(dso)->id);
 	if (!info_node) {
 		ret = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
 		goto out;
 	}
 	info_linear = info_node->info_linear;
-	sub_id = dso->bpf_prog.sub_id;
+	sub_id = dso__bpf_prog(dso)->sub_id;
 
 	info.buffer = (void *)(uintptr_t)(info_linear->info.jited_prog_insns);
 	info.buffer_length = info_linear->info.jited_prog_len;
@@ -1244,7 +1244,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 	if (info_linear->info.btf_id) {
 		struct btf_node *node;
 
-		node = perf_env__find_btf(dso->bpf_prog.env,
+		node = perf_env__find_btf(dso__bpf_prog(dso)->env,
 					  info_linear->info.btf_id);
 		if (node)
 			btf = btf__new((__u8 *)(node->data),
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index d72f3b8c37f6..878c1f441868 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -280,6 +280,16 @@ static inline void dso__set_annotate_warned(struct dso *dso)
 	RC_CHK_ACCESS(dso)->annotate_warned = 1;
 }
 
+static inline bool dso__auxtrace_warned(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->auxtrace_warned;
+}
+
+static inline void dso__set_auxtrace_warned(struct dso *dso)
+{
+	RC_CHK_ACCESS(dso)->auxtrace_warned = 1;
+}
+
 static inline struct auxtrace_cache *dso__auxtrace_cache(struct dso *dso)
 {
 	return RC_CHK_ACCESS(dso)->auxtrace_cache;
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 51eb78993fe2..760742fd4a7d 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -288,7 +288,7 @@ static int inline_list__append_dso_a2l(struct dso *dso,
 				       struct inline_node *node,
 				       struct symbol *sym)
 {
-	struct a2l_data *a2l = dso->a2l;
+	struct a2l_data *a2l = dso__a2l(dso);
 	struct symbol *inline_sym = new_inline_sym(dso, sym, a2l->funcname);
 	char *srcline = NULL;
 
@@ -304,11 +304,11 @@ static int addr2line(const char *dso_name, u64 addr,
 		     struct symbol *sym)
 {
 	int ret = 0;
-	struct a2l_data *a2l = dso->a2l;
+	struct a2l_data *a2l = dso__a2l(dso);
 
 	if (!a2l) {
-		dso->a2l = addr2line_init(dso_name);
-		a2l = dso->a2l;
+		a2l = addr2line_init(dso_name);
+		dso__set_a2l(dso, a2l);
 	}
 
 	if (a2l == NULL) {
@@ -360,14 +360,14 @@ static int addr2line(const char *dso_name, u64 addr,
 
 void dso__free_a2l(struct dso *dso)
 {
-	struct a2l_data *a2l = dso->a2l;
+	struct a2l_data *a2l = dso__a2l(dso);
 
 	if (!a2l)
 		return;
 
 	addr2line_cleanup(a2l);
 
-	dso->a2l = NULL;
+	dso__set_a2l(dso, NULL);
 }
 
 #else /* HAVE_LIBBFD_SUPPORT */
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 478e922ce676..19eb623e0826 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1607,7 +1607,7 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
 
 	if (!bfd_check_format(abfd, bfd_object)) {
 		pr_debug2("%s: cannot read %s bfd file.\n", __func__,
-			  dso->long_name);
+			  dso__long_name(dso));
 		goto out_close;
 	}
 
@@ -1640,12 +1640,13 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
 		}
 		if (i < symbols_count) {
 			/* PE symbols can only have 4 bytes, so use .text high bits */
-			dso->text_offset = section->vma - (u32)section->vma;
-			dso->text_offset += (u32)bfd_asymbol_value(symbols[i]);
-			dso->text_end = (section->vma - dso->text_offset) + section->size;
+			u64 text_offset = (section->vma - (u32)section->vma)
+				+ (u32)bfd_asymbol_value(symbols[i]);
+			dso__set_text_offset(dso, text_offset);
+			dso__set_text_end(dso, (section->vma - text_offset) + section->size);
 		} else {
-			dso->text_offset = section->vma - section->filepos;
-			dso->text_end = section->filepos + section->size;
+			dso__set_text_offset(dso, section->vma - section->filepos);
+			dso__set_text_end(dso, section->filepos + section->size);
 		}
 	}
 
@@ -1671,7 +1672,7 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
 		else
 			len = section->size - sym->value;
 
-		start = bfd_asymbol_value(sym) - dso->text_offset;
+		start = bfd_asymbol_value(sym) - dso__text_offset(dso);
 		symbol = symbol__new(start, len, bfd2elf_binding(sym), STT_FUNC,
 				     bfd_asymbol_name(sym));
 		if (!symbol)
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index b38d322734b4..bde216e630d2 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -29,8 +29,8 @@ static int __find_debuginfo(Dwfl_Module *mod __maybe_unused, void **userdata,
 	const struct dso *dso = *userdata;
 
 	assert(dso);
-	if (dso->symsrc_filename && strcmp (file_name, dso->symsrc_filename))
-		*debuginfo_file_name = strdup(dso->symsrc_filename);
+	if (dso__symsrc_filename(dso) && strcmp(file_name, dso__symsrc_filename(dso)))
+		*debuginfo_file_name = strdup(dso__symsrc_filename(dso));
 	return -1;
 }
 
@@ -66,7 +66,7 @@ static int __report_module(struct addr_location *al, u64 ip,
 	 * a different code in another DSO.  So just use the map->start
 	 * directly to pick the correct one.
 	 */
-	if (!strncmp(dso->long_name, "/tmp/jitted-", 12))
+	if (!strncmp(dso__long_name(dso), "/tmp/jitted-", 12))
 		base = map__start(al->map);
 	else
 		base = map__start(al->map) - map__pgoff(al->map);
@@ -83,15 +83,15 @@ static int __report_module(struct addr_location *al, u64 ip,
 	if (!mod) {
 		char filename[PATH_MAX];
 
-		__symbol__join_symfs(filename, sizeof(filename), dso->long_name);
-		mod = dwfl_report_elf(ui->dwfl, dso->short_name, filename, -1,
+		__symbol__join_symfs(filename, sizeof(filename), dso__long_name(dso));
+		mod = dwfl_report_elf(ui->dwfl, dso__short_name(dso), filename, -1,
 				      base, false);
 	}
 	if (!mod) {
 		char filename[PATH_MAX];
 
 		if (dso__build_id_filename(dso, filename, sizeof(filename), false))
-			mod = dwfl_report_elf(ui->dwfl, dso->short_name, filename, -1,
+			mod = dwfl_report_elf(ui->dwfl, dso__short_name(dso), filename, -1,
 					      base, false);
 	}
 
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index a424eae6d308..f6a6f6a91030 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -363,7 +363,7 @@ static int read_unwind_spec_debug_frame(struct dso *dso,
 					struct machine *machine, u64 *offset)
 {
 	int fd;
-	u64 ofs = dso->data.debug_frame_offset;
+	u64 ofs = dso__data(dso)->debug_frame_offset;
 
 	/* debug_frame can reside in:
 	 *  - dso
@@ -379,7 +379,7 @@ static int read_unwind_spec_debug_frame(struct dso *dso,
 		}
 
 		if (ofs <= 0) {
-			fd = open(dso->symsrc_filename, O_RDONLY);
+			fd = open(dso__symsrc_filename(dso), O_RDONLY);
 			if (fd >= 0) {
 				ofs = elf_section_offset(fd, ".debug_frame");
 				close(fd);
@@ -407,21 +407,21 @@ static int read_unwind_spec_debug_frame(struct dso *dso,
 				}
 			}
 			if (ofs > 0) {
-				if (dso->symsrc_filename != NULL) {
+				if (dso__symsrc_filename(dso) != NULL) {
 					pr_warning(
 						"%s: overwrite symsrc(%s,%s)\n",
 							__func__,
-							dso->symsrc_filename,
+							dso__symsrc_filename(dso),
 							debuglink);
-					zfree(&dso->symsrc_filename);
+					zfree(&dso__symsrc_filename(dso));
 				}
-				dso->symsrc_filename = debuglink;
+				dso__set_symsrc_filename(dso, debuglink);
 			} else {
 				free(debuglink);
 			}
 		}
 
-		dso->data.debug_frame_offset = ofs;
+		dso__data(dso)->debug_frame_offset = ofs;
 	}
 
 	*offset = ofs;
@@ -486,7 +486,7 @@ find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
 	if (ret < 0 &&
 	    !read_unwind_spec_debug_frame(dso, ui->machine, &segbase)) {
 		int fd = dso__data_get_fd(dso, ui->machine);
-		int is_exec = elf_is_exec(fd, dso->name);
+		int is_exec = elf_is_exec(fd, dso__name(dso));
 		u64 start = map__start(map);
 		unw_word_t base = is_exec ? 0 : start;
 		const char *symfile;
@@ -494,7 +494,7 @@ find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
 		if (fd >= 0)
 			dso__data_put_fd(dso);
 
-		symfile = dso->symsrc_filename ?: dso->name;
+		symfile = dso__symsrc_filename(dso) ?: dso__name(dso);
 
 		memset(&di, 0, sizeof(di));
 		if (dwarf_find_debug_frame(0, &di, ip, base, symfile, start, map__end(map)))
-- 
2.45.2.803.g4e1b14247a-goog

