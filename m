Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9D72BF001
	for <linux-perf-users@vger.kernel.org>; Sun,  5 Oct 2025 21:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759699351; cv=none; b=ULukeSEEBtGJbsdXswQ9DscQnicqxc8Lslmmaa0ihhDp3yIPIN87v/2yTUAuKoLtj1puLgsNPz1nEAhEvlCfpvmNyVfV2zhK7QHZ1551VGpUq/Mk3PzrAN1hZpepvl8KmrESOs2ami9lxQAQkkpByRLVv4tATtTTRj/8NLfM89g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759699351; c=relaxed/simple;
	bh=1AcAVTJaNRek7hoOhiMLQ+rsKXs+qNDcn0xrSWd0d40=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=EFVWfgGCrCbVX7MR2S5oZlS3ZGmCct15oGcCL7/LcCWinWN+3Xf3u9YuN5ADFD1qeYT6mjQmG/wH7FMUF5sUMbS8hVvqWp2Ac6bGxtQv3hYLjbitT/uLQVa0vXoRDM6SJlfxAzK+Btm+ywLvQ4Jl4IR1253GjTtfv8DACbe1oWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qUQ4nYFO; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qUQ4nYFO"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-26983c4d708so34168385ad.3
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Oct 2025 14:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759699347; x=1760304147; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O+l/WGm8eAK1INkc4qzoRNUwkFMn5H1vWu1UxQ6sXUY=;
        b=qUQ4nYFOHzyK1yvED+gc3RiW+rftl9MjMRFHs3zNlizjPkxIT+f517HR1dQGpSfYr+
         jVAVMRp3Z+9GLS8AwZCCLYCvDRw3uxhDW8dSzzsu2EPefby7Mj/qBrGjlDYQA1Fbfrt8
         +H3GlpE/DAM4/j7W0w/P6+GnBGgNw2AB0GO1EdtgmxU/4j+25VahQvNaCuhnZbD/2AYl
         319ysLY2eeMXsJaB/ZFGKsKOuKT5fEAwoGTNTHCwEuk6EvRDgMr7o8OUxSJ2L80trHzI
         hiDyfLQ+cWz0TphYN7Ym47/Pbb6lJMdKnaR/CVQQik49okWgXrrp6EQJTrZivAodGgOn
         Nr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759699347; x=1760304147;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O+l/WGm8eAK1INkc4qzoRNUwkFMn5H1vWu1UxQ6sXUY=;
        b=LPN5gOTOST67camTY36Oz1J3k3aXLzrZqwpF4lmGBi5wj8gdQ1VNxyJn5hB5DCysCV
         OdlLCFtTTtD9gR2KJSMJRGGIZym1EM/N9aTnEGA2sSp+4YBATbqrJWBKKTyeYq9wS6ig
         zu4laxuWUCzyiQKNlDj5x1fUSpIAiP9PtmlKxYhbUFtQfKVaoBwhHnjmDJOWbd5Kdy2A
         lDww8NL6CFgz4J+lml4sp8cGK79xSy9hHCFlV5LeBUBnydqcj4Gj/oYthP4PmE8NU0Fw
         07iUYa/yzfCre5mhfRruXfWiTRvcVxLxpCCSHy9+jqCFO/ecxrwyLma6bqCJ8TKrGNlz
         peVg==
X-Forwarded-Encrypted: i=1; AJvYcCUroHdq4jmnM/1iCJL9yFFHy3N8EQmQtd1X8nM7wTTLI9f3iu2kNlOYST7b6309Fom/hy+UKOfzhat/STRFguig@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjip6N1WN42WzVTAchQ75g12LpfvUSD6qGgKfs3o2/Akx2k27B
	k9Ds5qVV+lfH3oQSv8CfDlsKEIW5xlJJIMtmLMiKC/nuK72NTdGfa4N1MbFJA37Jzc5Pm0QiUda
	cGeQ4kOJWKw==
X-Google-Smtp-Source: AGHT+IFu3ifLGHl9t/SXSR8xeghMcMlScLbRJvVQc0sMzH1px7fbKrot0jtLZYXkZgynu4Xl7VItdjoJR39p
X-Received: from pldb2.prod.google.com ([2002:a17:902:ed02:b0:269:6a61:3d1a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c7:b0:269:96ee:17d3
 with SMTP id d9443c01a7336-28e9a6fd7c4mr106405305ad.51.1759699347119; Sun, 05
 Oct 2025 14:22:27 -0700 (PDT)
Date: Sun,  5 Oct 2025 14:22:04 -0700
In-Reply-To: <20251005212212.2892175-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005212212.2892175-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005212212.2892175-4-irogers@google.com>
Subject: [PATCH v7 03/11] perf dso: Move read_symbol from llvm/capstone to dso
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Collin Funk <collin.funk1@gmail.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Move the read_symbol function to dso.h, make the return type const and
add a mutable out_buf out parameter. In future changes this will allow
a code pointer to be returned without necessary allocating memory.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/capstone.c | 66 +++++-----------------------
 tools/perf/util/dso.c      | 67 +++++++++++++++++++++++++++++
 tools/perf/util/dso.h      |  4 ++
 tools/perf/util/llvm.c     | 88 +++++++-------------------------------
 4 files changed, 97 insertions(+), 128 deletions(-)

diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index 01e47d5c8e3e..c23df911e91c 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -215,55 +215,6 @@ static int find_file_offset(u64 start, u64 len, u64 pgoff, void *arg)
 }
 #endif
 
-#ifdef HAVE_LIBCAPSTONE_SUPPORT
-static u8 *
-read_symbol(const char *filename, struct map *map, struct symbol *sym,
-	    u64 *len, bool *is_64bit)
-{
-	struct dso *dso = map__dso(map);
-	struct nscookie nsc;
-	u64 start = map__rip_2objdump(map, sym->start);
-	u64 end = map__rip_2objdump(map, sym->end);
-	int fd, count;
-	u8 *buf = NULL;
-	struct find_file_offset_data data = {
-		.ip = start,
-	};
-
-	*is_64bit = false;
-
-	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
-	fd = open(filename, O_RDONLY);
-	nsinfo__mountns_exit(&nsc);
-	if (fd < 0)
-		return NULL;
-
-	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data,
-			    is_64bit) == 0)
-		goto err;
-
-	*len = end - start;
-	buf = malloc(*len);
-	if (buf == NULL)
-		goto err;
-
-	count = pread(fd, buf, *len, data.offset);
-	close(fd);
-	fd = -1;
-
-	if ((u64)count != *len)
-		goto err;
-
-	return buf;
-
-err:
-	if (fd >= 0)
-		close(fd);
-	free(buf);
-	return NULL;
-}
-#endif
-
 int symbol__disassemble_capstone(const char *filename __maybe_unused,
 				 struct symbol *sym __maybe_unused,
 				 struct annotate_args *args __maybe_unused)
@@ -271,13 +222,17 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 #ifdef HAVE_LIBCAPSTONE_SUPPORT
 	struct annotation *notes = symbol__annotation(sym);
 	struct map *map = args->ms.map;
+	struct dso *dso = map__dso(map);
 	u64 start = map__rip_2objdump(map, sym->start);
-	u64 len;
 	u64 offset;
 	int i, count, free_count;
 	bool is_64bit = false;
 	bool needs_cs_close = false;
-	u8 *buf = NULL;
+	/* Malloc-ed buffer containing instructions read from disk. */
+	u8 *code_buf = NULL;
+	/* Pointer to code to be disassembled. */
+	const u8 *buf;
+	u64 buf_len;
 	csh handle;
 	cs_insn *insn = NULL;
 	char disasm_buf[512];
@@ -287,7 +242,8 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 	if (args->options->objdump_path)
 		return -1;
 
-	buf = read_symbol(filename, map, sym, &len, &is_64bit);
+	buf = dso__read_symbol(dso, filename, map, sym,
+			       &code_buf, &buf_len, &is_64bit);
 	if (buf == NULL)
 		return -1;
 
@@ -316,7 +272,7 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 
 	needs_cs_close = true;
 
-	free_count = count = cs_disasm(handle, buf, len, start, len, &insn);
+	free_count = count = cs_disasm(handle, buf, buf_len, start, buf_len, &insn);
 	for (i = 0, offset = 0; i < count; i++) {
 		int printed;
 
@@ -340,7 +296,7 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 	}
 
 	/* It failed in the middle: probably due to unknown instructions */
-	if (offset != len) {
+	if (offset != buf_len) {
 		struct list_head *list = &notes->src->source;
 
 		/* Discard all lines and fallback to objdump */
@@ -359,7 +315,7 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 		if (free_count > 0)
 			cs_free(insn, free_count);
 	}
-	free(buf);
+	free(code_buf);
 	return count < 0 ? count : 0;
 
 err:
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 282e3af85d5a..87d075942de6 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1798,3 +1798,70 @@ bool is_perf_pid_map_name(const char *dso_name)
 
 	return perf_pid_map_tid(dso_name, &tid);
 }
+
+struct find_file_offset_data {
+	u64 ip;
+	u64 offset;
+};
+
+/* This will be called for each PHDR in an ELF binary */
+static int find_file_offset(u64 start, u64 len, u64 pgoff, void *arg)
+{
+	struct find_file_offset_data *data = arg;
+
+	if (start <= data->ip && data->ip < start + len) {
+		data->offset = pgoff + data->ip - start;
+		return 1;
+	}
+	return 0;
+}
+
+const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
+			   const struct map *map, const struct symbol *sym,
+			   u8 **out_buf, u64 *out_buf_len, bool *is_64bit)
+{
+	struct nscookie nsc;
+	u64 start = map__rip_2objdump(map, sym->start);
+	u64 end = map__rip_2objdump(map, sym->end);
+	int fd, count;
+	u8 *buf = NULL;
+	size_t len;
+	struct find_file_offset_data data = {
+		.ip = start,
+	};
+
+	*out_buf = NULL;
+	*out_buf_len = 0;
+	*is_64bit = false;
+
+	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
+	fd = open(symfs_filename, O_RDONLY);
+	nsinfo__mountns_exit(&nsc);
+	if (fd < 0)
+		return NULL;
+
+	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data, is_64bit) == 0)
+		goto err;
+
+	len = end - start;
+	buf = malloc(len);
+	if (buf == NULL)
+		goto err;
+
+	count = pread(fd, buf, len, data.offset);
+	close(fd);
+	fd = -1;
+
+	if ((u64)count != len)
+		goto err;
+
+	*out_buf = buf;
+	*out_buf_len = len;
+	return buf;
+
+err:
+	if (fd >= 0)
+		close(fd);
+	free(buf);
+	return NULL;
+}
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index fd8e95de77f7..f8ccb9816b89 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -924,4 +924,8 @@ static inline struct debuginfo *dso__debuginfo(struct dso *dso)
 	return debuginfo__new(dso__long_name(dso));
 }
 
+const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
+			   const struct map *map, const struct symbol *sym,
+			   u8 **out_buf, u64 *out_buf_len, bool *is_64bit);
+
 #endif /* __PERF_DSO */
diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
index 2356778955fe..0369f3adcdb6 100644
--- a/tools/perf/util/llvm.c
+++ b/tools/perf/util/llvm.c
@@ -86,72 +86,6 @@ static void init_llvm(void)
 	}
 }
 
-#if defined(HAVE_LIBLLVM_SUPPORT)
-struct find_file_offset_data {
-	u64 ip;
-	u64 offset;
-};
-
-/* This will be called for each PHDR in an ELF binary */
-static int find_file_offset(u64 start, u64 len, u64 pgoff, void *arg)
-{
-	struct find_file_offset_data *data = arg;
-
-	if (start <= data->ip && data->ip < start + len) {
-		data->offset = pgoff + data->ip - start;
-		return 1;
-	}
-	return 0;
-}
-
-static u8 *
-read_symbol(const char *filename, struct map *map, struct symbol *sym,
-	    u64 *len, bool *is_64bit)
-{
-	struct dso *dso = map__dso(map);
-	struct nscookie nsc;
-	u64 start = map__rip_2objdump(map, sym->start);
-	u64 end = map__rip_2objdump(map, sym->end);
-	int fd, count;
-	u8 *buf = NULL;
-	struct find_file_offset_data data = {
-		.ip = start,
-	};
-
-	*is_64bit = false;
-
-	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
-	fd = open(filename, O_RDONLY);
-	nsinfo__mountns_exit(&nsc);
-	if (fd < 0)
-		return NULL;
-
-	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data,
-			    is_64bit) == 0)
-		goto err;
-
-	*len = end - start;
-	buf = malloc(*len);
-	if (buf == NULL)
-		goto err;
-
-	count = pread(fd, buf, *len, data.offset);
-	close(fd);
-	fd = -1;
-
-	if ((u64)count != *len)
-		goto err;
-
-	return buf;
-
-err:
-	if (fd >= 0)
-		close(fd);
-	free(buf);
-	return NULL;
-}
-#endif
-
 /*
  * Whenever LLVM wants to resolve an address into a symbol, it calls this
  * callback. We don't ever actually _return_ anything (in particular, because
@@ -191,8 +125,11 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 	struct map *map = args->ms.map;
 	struct dso *dso = map__dso(map);
 	u64 start = map__rip_2objdump(map, sym->start);
-	u8 *buf;
-	u64 len;
+	/* Malloc-ed buffer containing instructions read from disk. */
+	u8 *code_buf = NULL;
+	/* Pointer to code to be disassembled. */
+	const u8 *buf;
+	u64 buf_len;
 	u64 pc;
 	bool is_64bit;
 	char disasm_buf[2048];
@@ -207,7 +144,8 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 	if (args->options->objdump_path)
 		return -1;
 
-	buf = read_symbol(filename, map, sym, &len, &is_64bit);
+	buf = dso__read_symbol(dso, filename, map, sym,
+			       &code_buf, &buf_len, &is_64bit);
 	if (buf == NULL)
 		return -1;
 
@@ -259,14 +197,18 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 	annotation_line__add(&dl->al, &notes->src->source);
 
 	pc = start;
-	for (u64 offset = 0; offset < len; ) {
+	for (u64 offset = 0; offset < buf_len; ) {
 		unsigned int ins_len;
 
 		storage.branch_addr = 0;
 		storage.pcrel_load_addr = 0;
 
-		ins_len = LLVMDisasmInstruction(disasm, buf + offset,
-						len - offset, pc,
+		/*
+		 * LLVM's API has the code be disassembled as non-const, cast
+		 * here as we may be disassembling from mapped read-only memory.
+		 */
+		ins_len = LLVMDisasmInstruction(disasm, (u8 *)(buf + offset),
+						buf_len - offset, pc,
 						disasm_buf, sizeof(disasm_buf));
 		if (ins_len == 0)
 			goto err;
@@ -324,7 +266,7 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 
 err:
 	LLVMDisasmDispose(disasm);
-	free(buf);
+	free(code_buf);
 	free(line_storage);
 	return ret;
 #else // HAVE_LIBLLVM_SUPPORT
-- 
2.51.0.618.g983fd99d29-goog

