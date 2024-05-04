Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7541384DE7
	for <linux-perf-users@vger.kernel.org>; Sat,  4 May 2024 21:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714858707; cv=none; b=XIxoSN7NVJ1E1dxJkIljhxgZiKsRCCRx7YauLYZUaMx5AyxLg+I7mroZ2gpeS4N463uzqSRNgjbWV7QAlPL1fzlnsHAlngzgAGfATSZ9bR7oa3seNvBHi3EUu9/x3csZMSC+0c4LhQvze5ftvmo6oMMh/qQacq2NKty/K2N7Np0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714858707; c=relaxed/simple;
	bh=959DZd8qkd+X8LIZJmOHSNnlaaoOGuHx8DbvxZOIG4k=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Ju4FLv8E0KdL+JY7Lw/rfY710y+P/xTDgGLyxrirZGO6OOMmqhtObqyfnKe9wmy4yVku4ZmKi0TuyvvaLaYclro0UulFNr2di6Uv7DIiqFwBtS6fEl64Hc3jpuTNxL0J6kEYjD3aEhuYSnyYntJTNp1WDafzxKnu9n/JmIylZGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pl+skHdp; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pl+skHdp"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6ceade361so2259751276.0
        for <linux-perf-users@vger.kernel.org>; Sat, 04 May 2024 14:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714858704; x=1715463504; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0X7bEo8dXZLnF/gM0kmXNQzWSFJh5vgm9u9Nr5H0Bxc=;
        b=Pl+skHdpm6qUbH5NMKr/Nc7IRqTmUYN5iMZcVTclxLrTAGB/4HDyy4DBrJZc1RBjjJ
         nZJpz0kABobookUEYh8vZlqo0YO1K7q2qkYdJQZQ31NcmKY82py+I/lMlwBJYUHio5fO
         mQ/S3NyiS+KlfTWj0vWzSkI2MIs+yCCj7v5g5o/ijXfqwOu0EZCq/mb9HjxmqdTqXdwm
         Ek35NREW9jtTzXguC+DfwUpmtJ3URqEqp6CRILmMmaYvhXlEyEpwS87Ze3mylbjTnej4
         c+qbR47/xI93RKBF8dGvJAGxNPcC+F97/GPkAovhn9goLlae+dw87CpB/22dWq3ACgRj
         kRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714858704; x=1715463504;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0X7bEo8dXZLnF/gM0kmXNQzWSFJh5vgm9u9Nr5H0Bxc=;
        b=ko6INSttPD1gtUjXpsoK3fR9rXL8Jtw2BfXR9ZBBDFJPsv4dBYPH34SHNmVXMUZnil
         56gEfHwYSENmgUyLeyZJ6YqlIUvWtf6Hddg35u30DQ0NL26wXTh+gTC8PKrwMRz7kvAS
         JLxew7aF9WI5xItiJE14lSdjrWSc87bZ32TcyeHro+/POm8r/DEV1FH3qU/aZX4jddej
         gJ9UZuE3kmv+GsolZ0jOjB8TmECLvfMm3tNqclo5qOfbty9CH4wuqA1WnkLNy1TcJ38x
         tEgtD3f8IjpTblhzeH2Dih5/PNL2aT8J6Vq6CZ8IzO9CdmGhQwdDXefb3kE6hsQYnJIr
         9hLA==
X-Forwarded-Encrypted: i=1; AJvYcCV6cAWQmb5f6pXaopA2fwAO4teDrILX8iCyVp/2jFJipUCNEYsuEK5jq4uAEcImIrrTB23B+W1uQjYhdGIUq22tKoQxFzC4sUWZv81p5Q/TLQ==
X-Gm-Message-State: AOJu0YwHs5Gujm4sngwa6eR2m2AavP5TLj4/S5hvcbuzmOwgmdV+msC+
	ZvOXR34MzfXWuANWGql7hQyzaueAKyEMq77Bc1JyX4C3xjpT+T2hQuVoLT8J2O7XKoI8vpkM5iR
	8W0/U0A==
X-Google-Smtp-Source: AGHT+IGUZHv3VZ+7KR6aIt8LVQCrs1Q8FFRQERBx1dBaWHBgx+NQ1CXrNj6ond6MZHL2D8u7SMTU7Mfkl1c9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:566d:1f52:f5f5:c8ec])
 (user=irogers job=sendgmr) by 2002:a05:6902:110d:b0:de4:7bae:3333 with SMTP
 id o13-20020a056902110d00b00de47bae3333mr2064992ybu.3.1714858704530; Sat, 04
 May 2024 14:38:24 -0700 (PDT)
Date: Sat,  4 May 2024 14:38:02 -0700
In-Reply-To: <20240504213803.218974-1-irogers@google.com>
Message-Id: <20240504213803.218974-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240504213803.218974-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v6 6/7] perf dso: Reference counting related fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	nabijaczleweli@nabijaczleweli.xyz, Leo Yan <leo.yan@linux.dev>, 
	Song Liu <song@kernel.org>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ben Gainey <ben.gainey@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Changbin Du <changbin.du@huawei.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Dima Kogan <dima@secretsauce.net>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Paran Lee <p4ranlee@gmail.com>, Li Dong <lidong@vivo.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Chengen Du <chengen.du@canonical.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ensure gets and puts are better aligned fixing reference couting
checking problems.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c    |  4 +--
 tools/perf/util/map.c        |  1 +
 tools/perf/util/symbol-elf.c | 51 ++++++++++++++++++------------------
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 0b8fb14f5ff6..4a4541a2e887 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -683,7 +683,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 					     struct perf_sample *sample __maybe_unused)
 {
 	struct symbol *sym;
-	struct dso *dso;
+	struct dso *dso = NULL;
 	struct map *map = maps__find(machine__kernel_maps(machine), event->ksymbol.addr);
 	int err = 0;
 
@@ -696,7 +696,6 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		}
 		dso__set_kernel(dso, DSO_SPACE__KERNEL);
 		map = map__new2(0, dso);
-		dso__put(dso);
 		if (!map) {
 			err = -ENOMEM;
 			goto out;
@@ -735,6 +734,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 	dso__insert_symbol(dso, sym);
 out:
 	map__put(map);
+	dso__put(dso);
 	return err;
 }
 
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 117c4bb78b35..e1d14936a60d 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -200,6 +200,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 				dso__set_build_id(dso, dso__bid(header_bid_dso));
 				dso__set_header_build_id(dso, 1);
 			}
+			dso__put(header_bid_dso);
 		}
 		dso__put(dso);
 	}
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 3be5e8d1e278..e398abfd13a0 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1419,7 +1419,7 @@ void __weak arch__sym_update(struct symbol *s __maybe_unused,
 static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 				      GElf_Sym *sym, GElf_Shdr *shdr,
 				      struct maps *kmaps, struct kmap *kmap,
-				      struct dso **curr_dsop, struct map **curr_mapp,
+				      struct dso **curr_dsop,
 				      const char *section_name,
 				      bool adjust_kernel_syms, bool kmodule, bool *remap_kernel,
 				      u64 max_text_sh_offset)
@@ -1470,8 +1470,8 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 			map__set_pgoff(map, shdr->sh_offset);
 		}
 
-		*curr_mapp = map;
-		*curr_dsop = dso;
+		dso__put(*curr_dsop);
+		*curr_dsop = dso__get(dso);
 		return 0;
 	}
 
@@ -1484,8 +1484,8 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 	 */
 	if (kmodule && adjust_kernel_syms && is_exe_text(shdr->sh_flags) &&
 	    shdr->sh_offset <= max_text_sh_offset) {
-		*curr_mapp = map;
-		*curr_dsop = dso;
+		dso__put(*curr_dsop);
+		*curr_dsop = dso__get(dso);
 		return 0;
 	}
 
@@ -1507,10 +1507,10 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		dso__set_binary_type(curr_dso, dso__binary_type(dso));
 		dso__set_adjust_symbols(curr_dso, dso__adjust_symbols(dso));
 		curr_map = map__new2(start, curr_dso);
-		dso__put(curr_dso);
-		if (curr_map == NULL)
+		if (curr_map == NULL) {
+			dso__put(curr_dso);
 			return -1;
-
+		}
 		if (dso__kernel(curr_dso))
 			map__kmap(curr_map)->kmaps = kmaps;
 
@@ -1524,21 +1524,15 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		dso__set_symtab_type(curr_dso, dso__symtab_type(dso));
 		if (maps__insert(kmaps, curr_map))
 			return -1;
-		/*
-		 * Add it before we drop the reference to curr_map, i.e. while
-		 * we still are sure to have a reference to this DSO via
-		 * *curr_map->dso.
-		 */
 		dsos__add(&maps__machine(kmaps)->dsos, curr_dso);
-		/* kmaps already got it */
-		map__put(curr_map);
 		dso__set_loaded(curr_dso);
-		*curr_mapp = curr_map;
+		dso__put(*curr_dsop);
 		*curr_dsop = curr_dso;
 	} else {
-		*curr_dsop = map__dso(curr_map);
-		map__put(curr_map);
+		dso__put(*curr_dsop);
+		*curr_dsop = dso__get(map__dso(curr_map));
 	}
+	map__put(curr_map);
 
 	return 0;
 }
@@ -1549,11 +1543,9 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 {
 	struct kmap *kmap = dso__kernel(dso) ? map__kmap(map) : NULL;
 	struct maps *kmaps = kmap ? map__kmaps(map) : NULL;
-	struct map *curr_map = map;
-	struct dso *curr_dso = dso;
+	struct dso *curr_dso = NULL;
 	Elf_Data *symstrs, *secstrs, *secstrs_run, *secstrs_sym;
 	uint32_t nr_syms;
-	int err = -1;
 	uint32_t idx;
 	GElf_Ehdr ehdr;
 	GElf_Shdr shdr;
@@ -1656,6 +1648,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 	if (kmodule && adjust_kernel_syms)
 		max_text_sh_offset = max_text_section(runtime_ss->elf, &runtime_ss->ehdr);
 
+	curr_dso = dso__get(dso);
 	elf_symtab__for_each_symbol(syms, nr_syms, idx, sym) {
 		struct symbol *f;
 		const char *elf_name = elf_sym__name(&sym, symstrs);
@@ -1744,9 +1737,13 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 			--sym.st_value;
 
 		if (dso__kernel(dso)) {
-			if (dso__process_kernel_symbol(dso, map, &sym, &shdr, kmaps, kmap, &curr_dso, &curr_map,
-						       section_name, adjust_kernel_syms, kmodule,
-						       &remap_kernel, max_text_sh_offset))
+			if (dso__process_kernel_symbol(dso, map, &sym, &shdr,
+						       kmaps, kmap, &curr_dso,
+						       section_name,
+						       adjust_kernel_syms,
+						       kmodule,
+						       &remap_kernel,
+						       max_text_sh_offset))
 				goto out_elf_end;
 		} else if ((used_opd && runtime_ss->adjust_symbols) ||
 			   (!used_opd && syms_ss->adjust_symbols)) {
@@ -1795,6 +1792,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		__symbols__insert(dso__symbols(curr_dso), f, dso__kernel(dso));
 		nr++;
 	}
+	dso__put(curr_dso);
 
 	/*
 	 * For misannotated, zeroed, ASM function sizes.
@@ -1810,9 +1808,10 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 			maps__fixup_end(kmaps);
 		}
 	}
-	err = nr;
+	return nr;
 out_elf_end:
-	return err;
+	dso__put(curr_dso);
+	return -1;
 }
 
 int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

