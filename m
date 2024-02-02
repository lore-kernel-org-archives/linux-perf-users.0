Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A129487A0
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Feb 2024 06:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706854606; cv=none; b=plNuhvxzVWELRB0MDORfg9J06QahTxHhcR8f7LAu2myjUYh+EElC7c2MrFzs7SeL0hXhTA7zofYQ1fiZyoLV8p1PzHJ6H3TISXRXuunPfPnZmRX2oBp3Dk1sb2ycW2nz9iEq114w60jyVb315uWRma3tAho9vrRUOTnc3P2+Gko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706854606; c=relaxed/simple;
	bh=HTmMDuQzLKDWBOK/Fg5hhps0giyc5BqyAMhZAoiZKiY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=EnmTMnsxCnJCHznJ9z/rFIm92JJgBpooBKYTQRQdQp6EP8QonqoAumRaIxToDAallefd/Hnr6911wbyAAhnJPVKSGnLCtjxrOVRo0JpC8JZ8pZYa+KBNr1iKdhgIP1r3Df4IbQcFcY+8WHaJks5MVGqmSDGGc45o+uybiPeoWrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eWgChzYT; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eWgChzYT"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26eef6cso2501703276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Feb 2024 22:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706854602; x=1707459402; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n5YvFgFYxmEyXAB6dNy5nJiKJQA6ckdB9Gak22tlTgE=;
        b=eWgChzYTYpjx/3ijzvouZXIZFaSP6xov+U/cMp5k+LtJ/r7vGdB5g4G5XZAzu7DK3T
         QoiK4Xkb9YmmLDa0SgiWAya+7UAYAuhNHm7QCvJn5v0GYx3zKoDEX+LBOTZmufyMekKT
         AEPFcr/QEdtl/of3otCDKXEX6u4/ONSeneyCQzAqmzApifhsdWLFpt4pxdqWtDISI3dm
         LqWOtYChweAahOcF8ko1HEjMZ9uOkaYqBnGlWCVDy35g5S9ISuwpDCl2Rh3podUg6/z1
         /SAJFDz1kJc4l9Oj4mah9cgblyqwxJlYbsIXX4ELQ381iVwil9PQaYxAotcHUSpfbTzL
         xTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706854602; x=1707459402;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5YvFgFYxmEyXAB6dNy5nJiKJQA6ckdB9Gak22tlTgE=;
        b=o0+SKahw3VjxeGgGO83cwxSFs1t8lnsyS2x4bKH5l62tFnt0aGS9qPZSOLriGPEDHt
         DYBvwkDIfkCbnjryagSY9iFmuGKnHqQ0W3VDED9x/hEdgOhFfmP4wZAlD2oML0DRHUFh
         dIzImSqyIokXaqJwQRuEv1zyA27gs37aSs0Zskz5US1HV3IWQFtczY+mvOB+9WBPnLjJ
         sXLplh1GvvaT5JtUAZxrLq8bnaNhdyFqHgLC/xCdS1KbQ8K2boo88DBP7L/91/bbDe1T
         LLBoOHeNmVFVvRzVy16rIf0lNB2Dj771bE5OoH4AJu3lSaiBEsq4ynObHQLiJAXMZ/oU
         ZD/w==
X-Gm-Message-State: AOJu0Yx3qUm6TeYQlKp0XKcbj0wwNQFFoxFHx+d+t+GHeTVOliSAnTFy
	pkUF0kXYNj7smRfXdIYP7yiU1ycLl/ot0lNI/06a+e/iOtaYIyB9fhUwyaJ3Ek9vdFhYAzmZ7FK
	okv6idA==
X-Google-Smtp-Source: AGHT+IGvyAW2mD5BSK+M563yM+jJyYgHMPioFbFs69qd54nQPMVgEsLsITE387Z9Tb9Eg3Q1B/RLCAklTgEa
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a85f:db1d:a66b:7f53])
 (user=irogers job=sendgmr) by 2002:a05:6902:cc9:b0:dc2:57c9:b44d with SMTP id
 cq9-20020a0569020cc900b00dc257c9b44dmr179235ybb.8.1706854602622; Thu, 01 Feb
 2024 22:16:42 -0800 (PST)
Date: Thu,  1 Feb 2024 22:15:31 -0800
In-Reply-To: <20240202061532.1939474-1-irogers@google.com>
Message-Id: <20240202061532.1939474-25-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202061532.1939474-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v8 24/25] perf dso: Reference counting related fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	"Steinar H. Gunderson" <sesse@google.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Colin Ian King <colin.i.king@gmail.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Ming Wang <wangming01@loongson.cn>, James Clark <james.clark@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

Ensure gets and puts are better aligned fixing reference couting
checking problems.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c    |  4 ++--
 tools/perf/util/map.c        |  1 +
 tools/perf/util/symbol-elf.c | 38 +++++++++++++++++-------------------
 3 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 49b8ccd5affe..2dbb7b06b117 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -682,7 +682,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 					     struct perf_sample *sample __maybe_unused)
 {
 	struct symbol *sym;
-	struct dso *dso;
+	struct dso *dso = NULL;
 	struct map *map = maps__find(machine__kernel_maps(machine), event->ksymbol.addr);
 	int err = 0;
 
@@ -695,7 +695,6 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		}
 		dso__set_kernel(dso, DSO_SPACE__KERNEL);
 		map = map__new2(0, dso);
-		dso__put(dso);
 		if (!map) {
 			err = -ENOMEM;
 			goto out;
@@ -734,6 +733,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 	dso__insert_symbol(dso, sym);
 out:
 	map__put(map);
+	dso__put(dso);
 	return err;
 }
 
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 14fb8cf65b13..4480134ef4ea 100644
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
index de73f9fb3fe4..4c00463abb7e 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1366,7 +1366,7 @@ void __weak arch__sym_update(struct symbol *s __maybe_unused,
 static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 				      GElf_Sym *sym, GElf_Shdr *shdr,
 				      struct maps *kmaps, struct kmap *kmap,
-				      struct dso **curr_dsop, struct map **curr_mapp,
+				      struct dso **curr_dsop,
 				      const char *section_name,
 				      bool adjust_kernel_syms, bool kmodule, bool *remap_kernel)
 {
@@ -1416,8 +1416,8 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 			map__set_pgoff(map, shdr->sh_offset);
 		}
 
-		*curr_mapp = map;
-		*curr_dsop = dso;
+		dso__put(*curr_dsop);
+		*curr_dsop = dso__get(dso);
 		return 0;
 	}
 
@@ -1442,10 +1442,10 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
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
 
@@ -1459,21 +1459,15 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
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
@@ -1484,8 +1478,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 {
 	struct kmap *kmap = dso__kernel(dso) ? map__kmap(map) : NULL;
 	struct maps *kmaps = kmap ? map__kmaps(map) : NULL;
-	struct map *curr_map = map;
-	struct dso *curr_dso = dso;
+	struct dso *curr_dso;
 	Elf_Data *symstrs, *secstrs, *secstrs_run, *secstrs_sym;
 	uint32_t nr_syms;
 	int err = -1;
@@ -1586,6 +1579,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		remap_kernel = true;
 		adjust_kernel_syms = dso__adjust_symbols(dso);
 	}
+	curr_dso = dso__get(dso);
 	elf_symtab__for_each_symbol(syms, nr_syms, idx, sym) {
 		struct symbol *f;
 		const char *elf_name = elf_sym__name(&sym, symstrs);
@@ -1674,8 +1668,11 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 			--sym.st_value;
 
 		if (dso__kernel(dso)) {
-			if (dso__process_kernel_symbol(dso, map, &sym, &shdr, kmaps, kmap, &curr_dso, &curr_map,
-						       section_name, adjust_kernel_syms, kmodule, &remap_kernel))
+			if (dso__process_kernel_symbol(dso, map, &sym, &shdr,
+						       kmaps, kmap, &curr_dso,
+						       section_name,
+						       adjust_kernel_syms,
+						       kmodule, &remap_kernel))
 				goto out_elf_end;
 		} else if ((used_opd && runtime_ss->adjust_symbols) ||
 			   (!used_opd && syms_ss->adjust_symbols)) {
@@ -1724,6 +1721,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		__symbols__insert(dso__symbols(curr_dso), f, dso__kernel(dso));
 		nr++;
 	}
+	dso__put(curr_dso);
 
 	/*
 	 * For misannotated, zeroed, ASM function sizes.
-- 
2.43.0.594.gd9cf4e227d-goog

