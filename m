Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AE734E754
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 07:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769067107; cv=none; b=V47ukABx5bJVFqLjofUKvAriGNjR1jT+jNxwSSAKoCbufCBP+cpnc0K0JqfQuKA0b8HgD+HR7ehLLiv48z5UdiuTfnvrMeDQOC4gOuxGm1x1yyp2Bnp/NuIX+/HCLxJbg6LNo50ICcrNj5olpQqZhFz55w1PkaQJs9vDnL2kzUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769067107; c=relaxed/simple;
	bh=g07mjdPPiRfUbpif4I7O+jPiAdpwj1ojeHWcOHwHmJ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=V4IyAQx+zcnGPyD4UYYYVOgFJjOYeS9pqsw462TCHrbtXTYr4tMsZdmwgIo7ViVTYFgpSDNK5x1SINGOzLYAMLvmNgrqzTZArnw+HMsi85J2wdvdyxlC2JXyKjhW0nTZM22iMZSAsupWJPk2oLd/5t2czZv2NYDNnbpNSNzXoyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xGUJv975; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xGUJv975"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1233b91de6bso1403734c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 23:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769067094; x=1769671894; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7SyQiS0lnXgAvEhozlNZ8ceN/SCct+/3Su0Yxs9eoEA=;
        b=xGUJv975qe1pESzwD6ZJ5olyGwM9PxvudWqIPDlUtdU/8ZPiFsq6ku+WIYf0MLEnDM
         cOFXjpQhoTgk11tu9FffB7DVzrRXwtI43Df449FU9VnBTViXgJUrreCHIiaBiJhJggPe
         ImyHEQj59YEVTJRopX6GlnKCM2Q6HmFozB+PRh4A0k9S5dtpi7lHybBlSgNBn2n2aPJr
         gMxJFz9Gp8S8nsfCOPJ0EfbLrJQIPl4qdJ/5qVlFWxlHDtVaFQVGq365scQCEWxkkMSG
         ylzJYZRR1aZBAM2TEjOmLgJ4TjtFPCbIBMPZCg7YGPR0VmMDXP5Sw6ShqyuX4FcVbcrG
         RFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769067094; x=1769671894;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7SyQiS0lnXgAvEhozlNZ8ceN/SCct+/3Su0Yxs9eoEA=;
        b=s9LBGnOYIjdkqiY3DkuXkPm/D/UBNrC3z3l62CJOXvmcwpe2PKxeQGu4QMkOXMWNqs
         IzBkipvXX5WTd71e+RZgSvSYpKfUxH4US0QXgySG+L1Q0ydek3Ues1R1aXgsjc9X7En3
         2QqfiOW7guELjmzHr4+mrzdr2gLhcW3Ep2CibjqV/ZvQDLEQSbUEL4w4C5ftaodvP0Sg
         MRrQvwF6vnwOxuD2LZdm5Kz5mg08fXgymhkEawpox3GymcS7+c4I5VNAbtDAYQP3H+R9
         /JzolRVDuZpYTBWDtxLRkw/1sZTRpQCNJYS9rxy+I5pGLsUEXjNrSWego47H9qrFJNjC
         WfqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxitY+DYdN8jb96WJiY0+TsQ3e8J8Sfpx/dYsICsQy5lBqOnI8hbCR8sD2rXGnd1mGfB8CkLmnS7rkmOYBL1VK@vger.kernel.org
X-Gm-Message-State: AOJu0YxZfHzesRBJ/Kx39T17g5+s/lHrgi2gLsMb732YI0Q2keNR/j4m
	MtLIUJPOt0pqu+rkbf4CdHET2hj8wMz9UBmCACYAgooLU351JpyY7/hUyBAbQlvqsoY5lKatIIe
	MZYTuaDOKHA==
X-Received: from dlbcm22.prod.google.com ([2002:a05:7022:6896:b0:11e:60ad:95af])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4584:b0:11b:c2fd:3960
 with SMTP id a92af1059eb24-1244b35fd1amr12854378c88.28.1769067093485; Wed, 21
 Jan 2026 23:31:33 -0800 (PST)
Date: Wed, 21 Jan 2026 23:31:18 -0800
In-Reply-To: <20260122073127.375139-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260122073127.375139-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122073127.375139-3-irogers@google.com>
Subject: [PATCH v1 02/11] perf annotate: Fix args leak of map_symbol
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Zecheng Li <zecheng@google.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Suchit Karunakaran <suchitkarunakaran@gmail.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

map_symbol__exit needs calling on an annotate_args.ms, however, rather
than introduce proper reference count handling to symbol__annotate
just switch to passing the map_symbol pointer parameter around, making
the puts the caller's responsibility.

Signed-off-by: Ian Rogers <irogers@google.com>
Fixes: 56e144fe9826 ("perf mem_info: Add and use map_symbol__exit and addr_map_symbol__exit")
---
 tools/perf/util/annotate.c |  2 +-
 tools/perf/util/capstone.c | 14 +++++++-------
 tools/perf/util/disasm.c   | 32 +++++++++++++++++---------------
 tools/perf/util/disasm.h   |  2 +-
 tools/perf/util/llvm.c     |  6 +++---
 5 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index cc7764455faf..791d60f97c23 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1031,7 +1031,7 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 		return 0;
 
 	args.arch = arch;
-	args.ms = *ms;
+	args.ms = ms;
 
 	if (notes->src == NULL) {
 		notes->src = annotated_source__new();
diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index be5fd44b1f9d..2c7feab61b7b 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -143,7 +143,7 @@ static void print_capstone_detail(cs_insn *insn, char *buf, size_t len,
 				  struct annotate_args *args, u64 addr)
 {
 	int i;
-	struct map *map = args->ms.map;
+	struct map *map = args->ms->map;
 	struct symbol *sym;
 
 	/* TODO: support more architectures */
@@ -222,7 +222,7 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 {
 #ifdef HAVE_LIBCAPSTONE_SUPPORT
 	struct annotation *notes = symbol__annotation(sym);
-	struct map *map = args->ms.map;
+	struct map *map = args->ms->map;
 	struct dso *dso = map__dso(map);
 	u64 start = map__rip_2objdump(map, sym->start);
 	u64 offset;
@@ -256,7 +256,7 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 	args->line = disasm_buf;
 	args->line_nr = 0;
 	args->fileloc = NULL;
-	args->ms.sym = sym;
+	args->ms->sym = sym;
 
 	dl = disasm_line__new(args);
 	if (dl == NULL)
@@ -268,7 +268,7 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 	    !strcmp(args->options->disassembler_style, "att"))
 		disassembler_style = true;
 
-	if (capstone_init(maps__machine(args->ms.maps), &handle, is_64bit, disassembler_style) < 0)
+	if (capstone_init(maps__machine(args->ms->maps), &handle, is_64bit, disassembler_style) < 0)
 		goto err;
 
 	needs_cs_close = true;
@@ -345,7 +345,7 @@ int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
 {
 #ifdef HAVE_LIBCAPSTONE_SUPPORT
 	struct annotation *notes = symbol__annotation(sym);
-	struct map *map = args->ms.map;
+	struct map *map = args->ms->map;
 	struct dso *dso = map__dso(map);
 	struct nscookie nsc;
 	u64 start = map__rip_2objdump(map, sym->start);
@@ -382,7 +382,7 @@ int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
 	    !strcmp(args->options->disassembler_style, "att"))
 		disassembler_style = true;
 
-	if (capstone_init(maps__machine(args->ms.maps), &handle, is_64bit, disassembler_style) < 0)
+	if (capstone_init(maps__machine(args->ms->maps), &handle, is_64bit, disassembler_style) < 0)
 		goto err;
 
 	needs_cs_close = true;
@@ -408,7 +408,7 @@ int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
 	args->line = disasm_buf;
 	args->line_nr = 0;
 	args->fileloc = NULL;
-	args->ms.sym = sym;
+	args->ms->sym = sym;
 
 	dl = disasm_line__new(args);
 	if (dl == NULL)
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 50b9433f3f8e..96c78b01e17a 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -269,9 +269,7 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 {
 	char *endptr, *tok, *name;
 	struct map *map = ms->map;
-	struct addr_map_symbol target = {
-		.ms = { .map = map, },
-	};
+	struct addr_map_symbol target;
 
 	ops->target.addr = strtoull(ops->raw, &endptr, 16);
 
@@ -296,12 +294,16 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	if (ops->target.name == NULL)
 		return -1;
 find_target:
-	target.addr = map__objdump_2mem(map, ops->target.addr);
+	target = (struct addr_map_symbol) {
+		.ms = { .map = map__get(map), },
+		.addr = map__objdump_2mem(map, ops->target.addr),
+	};
 
 	if (maps__find_ams(ms->maps, &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
+	addr_map_symbol__exit(&target);
 	return 0;
 
 indirect_call:
@@ -366,7 +368,7 @@ static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	struct map *map = ms->map;
 	struct symbol *sym = ms->sym;
 	struct addr_map_symbol target = {
-		.ms = { .map = map, },
+		.ms = { .map = map__get(map), },
 	};
 	const char *c = strchr(ops->raw, ',');
 	u64 start, end;
@@ -440,7 +442,7 @@ static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	} else {
 		ops->target.offset_avail = false;
 	}
-
+	addr_map_symbol__exit(&target);
 	return 0;
 }
 
@@ -1046,7 +1048,7 @@ static size_t disasm_line_size(int nr)
 struct disasm_line *disasm_line__new(struct annotate_args *args)
 {
 	struct disasm_line *dl = NULL;
-	struct annotation *notes = symbol__annotation(args->ms.sym);
+	struct annotation *notes = symbol__annotation(args->ms->sym);
 	int nr = notes->src->nr_events;
 
 	dl = zalloc(disasm_line_size(nr));
@@ -1064,7 +1066,7 @@ struct disasm_line *disasm_line__new(struct annotate_args *args)
 		} else if (disasm_line__parse(dl->al.line, &dl->ins.name, &dl->ops.raw) < 0)
 			goto out_free_line;
 
-		disasm_line__init_ins(dl, args->arch, &args->ms);
+		disasm_line__init_ins(dl, args->arch, args->ms);
 	}
 
 	return dl;
@@ -1119,7 +1121,7 @@ static int symbol__parse_objdump_line(struct symbol *sym,
 				      struct annotate_args *args,
 				      char *parsed_line, int *line_nr, char **fileloc)
 {
-	struct map *map = args->ms.map;
+	struct map *map = args->ms->map;
 	struct annotation *notes = symbol__annotation(sym);
 	struct disasm_line *dl;
 	char *tmp;
@@ -1151,7 +1153,7 @@ static int symbol__parse_objdump_line(struct symbol *sym,
 	args->line    = parsed_line;
 	args->line_nr = *line_nr;
 	args->fileloc = *fileloc;
-	args->ms.sym  = sym;
+	args->ms->sym  = sym;
 
 	dl = disasm_line__new(args);
 	(*line_nr)++;
@@ -1172,7 +1174,7 @@ static int symbol__parse_objdump_line(struct symbol *sym,
 			.ms = { .map = map, },
 		};
 
-		if (!maps__find_ams(args->ms.maps, &target) &&
+		if (!maps__find_ams(args->ms->maps, &target) &&
 		    target.ms.sym->start == target.al_addr)
 			dl->ops.target.sym = target.ms.sym;
 	}
@@ -1338,7 +1340,7 @@ static int symbol__disassemble_raw(char *filename, struct symbol *sym,
 					struct annotate_args *args)
 {
 	struct annotation *notes = symbol__annotation(sym);
-	struct map *map = args->ms.map;
+	struct map *map = args->ms->map;
 	struct dso *dso = map__dso(map);
 	u64 start = map__rip_2objdump(map, sym->start);
 	u64 end = map__rip_2objdump(map, sym->end);
@@ -1375,7 +1377,7 @@ static int symbol__disassemble_raw(char *filename, struct symbol *sym,
 	args->line = disasm_buf;
 	args->line_nr = 0;
 	args->fileloc = NULL;
-	args->ms.sym = sym;
+	args->ms->sym = sym;
 
 	dl = disasm_line__new(args);
 	if (dl == NULL)
@@ -1501,7 +1503,7 @@ static int symbol__disassemble_objdump(const char *filename, struct symbol *sym,
 				       struct annotate_args *args)
 {
 	struct annotation_options *opts = &annotate_opts;
-	struct map *map = args->ms.map;
+	struct map *map = args->ms->map;
 	struct dso *dso = map__dso(map);
 	char *command;
 	FILE *file;
@@ -1644,7 +1646,7 @@ static int symbol__disassemble_objdump(const char *filename, struct symbol *sym,
 int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 {
 	struct annotation_options *options = args->options;
-	struct map *map = args->ms.map;
+	struct map *map = args->ms->map;
 	struct dso *dso = map__dso(map);
 	char symfs_filename[PATH_MAX];
 	bool delete_extract = false;
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index d2cb555e4a3b..a3ea9d676281 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -97,7 +97,7 @@ struct ins_ops {
 
 struct annotate_args {
 	struct arch		  *arch;
-	struct map_symbol	  ms;
+	struct map_symbol	  *ms;
 	struct annotation_options *options;
 	s64			  offset;
 	char			  *line;
diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
index 2ebf1f5f65bf..4ada9a10bd93 100644
--- a/tools/perf/util/llvm.c
+++ b/tools/perf/util/llvm.c
@@ -118,7 +118,7 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 {
 #ifdef HAVE_LIBLLVM_SUPPORT
 	struct annotation *notes = symbol__annotation(sym);
-	struct map *map = args->ms.map;
+	struct map *map = args->ms->map;
 	struct dso *dso = map__dso(map);
 	u64 start = map__rip_2objdump(map, sym->start);
 	/* Malloc-ed buffer containing instructions read from disk. */
@@ -184,7 +184,7 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 	args->line = disasm_buf;
 	args->line_nr = 0;
 	args->fileloc = NULL;
-	args->ms.sym = sym;
+	args->ms->sym = sym;
 
 	dl = disasm_line__new(args);
 	if (dl == NULL)
@@ -242,7 +242,7 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 					 &line_storage_len);
 		args->line_nr = 0;
 		args->fileloc = NULL;
-		args->ms.sym = sym;
+		args->ms->sym = sym;
 
 		llvm_addr2line(filename, pc, &args->fileloc,
 			       (unsigned int *)&args->line_nr, false, NULL);
-- 
2.52.0.457.g6b5491de43-goog

