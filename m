Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D231933C52F
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100871; cv=none; b=dzgULiqLM7XXddPfTM0MrHzQOYytDGwFlrTjAmZyMyLYCRWQ8SezGGfjjZt67+DCLfXpTcQFX+JnZBX12OjZiLjTeVVG5p7GrZlP07uSPLWP/a+J+Krb3KZJHi1ykD7ASuqjAjllaL1+HN5SXgEm+3XcOiOEeNeetF+n1/4gMsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100871; c=relaxed/simple;
	bh=ANN7VbZ/Xm6UtamlT5mlRTMZ4rnilmOIpmNJZRsm4WY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=pXGtSxLxiLuJ/IJ32gl+b8Pj4nyO1sNQ+KlvwwLx1vp2Nk7uYdLx+P0nSoawIBxqF6ruvuKJq1BBXyQqFz4bMMHuBoOwVRdMNwTCN8rdNF0tq8pDhFPxCqKg+/T9uc2vtURrrCb3A/fMymnsOhmKIuIKNCtiZF9ciLVO0tZVcb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1YBZAlsc; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1YBZAlsc"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b724ff60e6so982802eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 08:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769100858; x=1769705658; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LBuhE4G4GBsctT6JHyOVnLTy18pSFx2hMEt8LFslTxA=;
        b=1YBZAlscuJ3DAVNCTw1uf4si0zY4E2XTrOl+eGgYlp4E1P6rWmoHo22ibLlTJtgayJ
         T15JAGNBLCX4ZWOk07bdQ+RcXW1UtMbHTbO2kW+egY9sNZueN20VrRKmadxyRUqZ7geK
         c8KemOsWPK/maPHvBs4IuMCQKgg8sQY3aXxpKdP7nCe/myRm2nzrZa9FAed4FkpNyj0n
         UNxHLi4Kp0E1IBxIrqXCszT2KUZxII9zXFrE8IfTDT1yUdcKYqwS7KwihaL2BtCKUtQe
         /LwHh/3J+8LrHjIIKiQw/xSFST+gZGXqJQ/8Us+eu4nJcKSsTs6798DZKcsF9MyY715l
         ZzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769100858; x=1769705658;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LBuhE4G4GBsctT6JHyOVnLTy18pSFx2hMEt8LFslTxA=;
        b=dwZrAbVtJEDnkcY6afa1vCkYHefBD3+W1QmUwN8Q8ZmYLlVvUJMoiBsIlCRbiWoIgl
         3O1SrKs80YWYjrUsGL5j8par82L+6ANrqfeIU0bT4OlBWD9oERLGybaxSuWmofwY4AfO
         UeX6WzTRLvuwfDq72c2SXp4zx5HiNo8LTnQoBqUHBtMkZcNxA73RdMrsP6uELipXuj9f
         8paPxavstJO/iFFzXt5CMJ3ANloY3Vr+uR7GqONaRmg74vYFYVV9wLNbb/6X7G7U3fiy
         cmOyrv3cYWTX2IUxqDOQQm6hUisYZfgC+7rwUd5ard6qAseYn5DslvckeuOAPGgWYeJj
         YkcA==
X-Forwarded-Encrypted: i=1; AJvYcCVsqlrTNeRrhQKju+0K3msq1JFa3Wos933x/rezaSMGqtgfvuEI15QYkBG7U03dR5S4btzZCTeIotqNLwdQ3xgK@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7vaI2Cv2kEnrHu29xcmJk1KeDRoqqA/LTgngYuQA01GwoVDrk
	pWdsZcTcL4+3H72AC1qjjvumPeQx7a1roNw/2BMb1o2woXtj/y44zUvemUCw63jx4g++FH9EC/S
	uJkDJwYBttg==
X-Received: from dycme17.prod.google.com ([2002:a05:693c:2411:b0:2ae:4f51:beac])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:fa12:b0:2b1:7910:b0f9
 with SMTP id 5a478bee46e88-2b6fd7c5909mr4676337eec.42.1769100858042; Thu, 22
 Jan 2026 08:54:18 -0800 (PST)
Date: Thu, 22 Jan 2026 08:53:57 -0800
In-Reply-To: <20260122165407.561888-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260122165407.561888-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122165407.561888-3-irogers@google.com>
Subject: [PATCH v2 02/12] perf annotate: Fix args leak of map_symbol
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

Fix a number of cases to ensure the map in a map_symbol has a
reference count increment and add the then necessary map_symbol_exits.

Signed-off-by: Ian Rogers <irogers@google.com>
Fixes: 56e144fe9826 ("perf mem_info: Add and use map_symbol__exit and addr_map_symbol__exit")
---
 .../arch/loongarch/annotate/instructions.c    | 14 ++++----
 tools/perf/arch/s390/annotate/instructions.c  | 11 +++---
 tools/perf/util/annotate.c                    |  2 +-
 tools/perf/util/capstone.c                    | 14 ++++----
 tools/perf/util/disasm.c                      | 36 ++++++++++---------
 tools/perf/util/disasm.h                      |  2 +-
 tools/perf/util/llvm.c                        |  6 ++--
 7 files changed, 47 insertions(+), 38 deletions(-)

diff --git a/tools/perf/arch/loongarch/annotate/instructions.c b/tools/perf/arch/loongarch/annotate/instructions.c
index 70262d5f1444..1c3abb43c8d7 100644
--- a/tools/perf/arch/loongarch/annotate/instructions.c
+++ b/tools/perf/arch/loongarch/annotate/instructions.c
@@ -10,9 +10,7 @@ static int loongarch_call__parse(struct arch *arch, struct ins_operands *ops, st
 {
 	char *c, *endptr, *tok, *name;
 	struct map *map = ms->map;
-	struct addr_map_symbol target = {
-		.ms = { .map = map, },
-	};
+	struct addr_map_symbol target;
 
 	c = strchr(ops->raw, '#');
 	if (c++ == NULL)
@@ -38,12 +36,16 @@ static int loongarch_call__parse(struct arch *arch, struct ins_operands *ops, st
 	if (ops->target.name == NULL)
 		return -1;
 
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
 }
 
@@ -58,7 +60,7 @@ static int loongarch_jump__parse(struct arch *arch, struct ins_operands *ops, st
 	struct map *map = ms->map;
 	struct symbol *sym = ms->sym;
 	struct addr_map_symbol target = {
-		.ms = { .map = map, },
+		.ms = { .map = map__get(map), },
 	};
 	const char *c = strchr(ops->raw, '#');
 	u64 start, end;
@@ -90,7 +92,7 @@ static int loongarch_jump__parse(struct arch *arch, struct ins_operands *ops, st
 	} else {
 		ops->target.offset_avail = false;
 	}
-
+	addr_map_symbol__exit(&target);
 	return 0;
 }
 
diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index c61193f1e096..626e6d2cbc81 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -6,9 +6,7 @@ static int s390_call__parse(struct arch *arch, struct ins_operands *ops,
 {
 	char *endptr, *tok, *name;
 	struct map *map = ms->map;
-	struct addr_map_symbol target = {
-		.ms = { .map = map, },
-	};
+	struct addr_map_symbol target;
 
 	tok = strchr(ops->raw, ',');
 	if (!tok)
@@ -36,12 +34,17 @@ static int s390_call__parse(struct arch *arch, struct ins_operands *ops,
 
 	if (ops->target.name == NULL)
 		return -1;
-	target.addr = map__objdump_2mem(map, ops->target.addr);
+
+	target = (struct addr_map_symbol) {
+		.ms = { .map = map__get(map), },
+		.addr = map__objdump_2mem(map, ops->target.addr),
+	};
 
 	if (maps__find_ams(ms->maps, &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
+	addr_map_symbol__exit(&target);
 	return 0;
 }
 
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
index 50b9433f3f8e..924429142631 100644
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
@@ -1169,12 +1171,14 @@ static int symbol__parse_objdump_line(struct symbol *sym,
 	if (dl->ins.ops && ins__is_call(&dl->ins) && !dl->ops.target.sym) {
 		struct addr_map_symbol target = {
 			.addr = dl->ops.target.addr,
-			.ms = { .map = map, },
+			.ms = { .map = map__get(map), },
 		};
 
-		if (!maps__find_ams(args->ms.maps, &target) &&
+		if (!maps__find_ams(args->ms->maps, &target) &&
 		    target.ms.sym->start == target.al_addr)
 			dl->ops.target.sym = target.ms.sym;
+
+		addr_map_symbol__exit(&target);
 	}
 
 	annotation_line__add(&dl->al, &notes->src->source);
@@ -1338,7 +1342,7 @@ static int symbol__disassemble_raw(char *filename, struct symbol *sym,
 					struct annotate_args *args)
 {
 	struct annotation *notes = symbol__annotation(sym);
-	struct map *map = args->ms.map;
+	struct map *map = args->ms->map;
 	struct dso *dso = map__dso(map);
 	u64 start = map__rip_2objdump(map, sym->start);
 	u64 end = map__rip_2objdump(map, sym->end);
@@ -1375,7 +1379,7 @@ static int symbol__disassemble_raw(char *filename, struct symbol *sym,
 	args->line = disasm_buf;
 	args->line_nr = 0;
 	args->fileloc = NULL;
-	args->ms.sym = sym;
+	args->ms->sym = sym;
 
 	dl = disasm_line__new(args);
 	if (dl == NULL)
@@ -1501,7 +1505,7 @@ static int symbol__disassemble_objdump(const char *filename, struct symbol *sym,
 				       struct annotate_args *args)
 {
 	struct annotation_options *opts = &annotate_opts;
-	struct map *map = args->ms.map;
+	struct map *map = args->ms->map;
 	struct dso *dso = map__dso(map);
 	char *command;
 	FILE *file;
@@ -1644,7 +1648,7 @@ static int symbol__disassemble_objdump(const char *filename, struct symbol *sym,
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

