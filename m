Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2C0229B0E
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Apr 2025 23:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744931298; cv=none; b=S9gXTspkO9/vVKeXGFDyksplPGxcgxJLjbzW+IMpUacKAz/I6TmfdubktEPchtVl1ijXlUf0FKXGO4Bli2d8HBWQI5XblxZBYgdG5uGfm1GlFPLYnUeqcqblySUYb0lHu2e5dJ9l2yHpXqQhM+Pgm4PgXLTs4kapeCVGBPLdeQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744931298; c=relaxed/simple;
	bh=b778ItJAkgSzsZeREtScM1hNY+Ffpp+8QlSXkzwLw4c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=JV27sF1i+N+m/gU8Wwz/sLGgIcFtkCbL4uVx1QKf1TG1KkX4R2LUH7O+jmMGd0syHDQK7D/C6pjBBvc7F0Q6VS72iScu7+5xuu0LpLoIuu4LoxvIx+iP7N8QeZVz5826B/uLZX5UtdGTn4gpeHzOwK4jbNNXP1Olzw86T3UV6po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E4kzD/DN; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E4kzD/DN"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff6aaa18e8so1133423a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Apr 2025 16:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744931295; x=1745536095; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ATo1kG4YAa83tuUgq+g3A09N22DQKM10QzKAR+cwLE=;
        b=E4kzD/DNqkIjviIW1fK7J00Fhkm9186RBel8UyU5KHhXMfhsxy7Nr+dy06uxI3hK8N
         x5SSDlBpRl1aURvjQVAYdqlwLDeq7FLdMTWHjM0rkz7FxjFQvZb0dOblb9abkrEqQsdV
         SidAPD/XEephenBZ975xI85mK8+RNcdYKLyBD1doE7l9zchDoq0cE27LgJsL3g+5bCBg
         Jhd/H4sDACrjKFLvoCj7IqVxfW7ZaZS50fsGripkltSoGZqa3nUZbu6+x7q/h5Nk8EE9
         QWXJ9vvKKAf+iXIaOKcavfFSeifevU8J9PRgg1wPzS+7F0bvsf6EXSR53ySVAYlZcE+X
         zoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744931295; x=1745536095;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ATo1kG4YAa83tuUgq+g3A09N22DQKM10QzKAR+cwLE=;
        b=Vu8N9+VZJZaXPMqSPcCuxdnVkk+qa2a3wqlHkl+KJwYwXZLqdyO7RvD0RujIL1gJDS
         H2/ZIGnLlx5JW2wWwvhBkhVcLQIFtUh36jIOotSBsX5+zI9KVtXfmaEJqsDQ4sXBLynN
         2iXZpTgA1vk3uaVo1vxTwNoapp05nLseoJ1stWHjgPFFPf+lf4C5Y6RobNNbtDtp+RNn
         sUZTfgQq1hmB6XBuKlQlaBE4XQBXceQcnkPzgXTa+Gg1VQJVI9gC8Iu4zt6ohYGulJuc
         09li1aWq0kqA85cje8tKySPHNBTyMnRfEZjCutd9roTOhZiXJPFXk7V3pOyWYX3yiojM
         gClQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0z0l312JY/Mjc32jUj6FmxgrMAvwnjJ7kY7fDsGrER7/rjH82pMnT6GZpqwgqqZ+9GvuupxL+vsLnX9DtbloL@vger.kernel.org
X-Gm-Message-State: AOJu0YySyH0yXeTPiPf+F6Bt8+yLKPVkJAN5EFMARgBE8JgFIGKhwkDK
	JCDU+AfOtmkRiIayDnD+2nT7yuTD3LD8VnfJ4Z1RfSnXg13q50lkihoFspVo8IYyiDs9ArabF11
	+a2ZllQ==
X-Google-Smtp-Source: AGHT+IHH8UVkv/kmT/umdpA7zcimjqNLVkE4OP4Qq3nssLU4bZSOTO9d/zSoNOwy9xWN8TRKnJBaf5gC9JuN
X-Received: from pjbsw12.prod.google.com ([2002:a17:90b:2c8c:b0:2f9:dc36:b11])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:56cd:b0:2ff:4bac:6fa2
 with SMTP id 98e67ed59e1d1-3087bb62a73mr1192181a91.16.1744931295544; Thu, 17
 Apr 2025 16:08:15 -0700 (PDT)
Date: Thu, 17 Apr 2025 16:07:31 -0700
In-Reply-To: <20250417230740.86048-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250417230740.86048-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250417230740.86048-11-irogers@google.com>
Subject: [PATCH v4 10/19] perf dso: Support BPF programs in dso__read_symbol
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Set the buffer to the code in the BPF linear info. This enables BPF
JIT code disassembly by LLVM and capstone. Move the disassmble_bpf
calls to disassemble_objdump so that they are only called after
falling back to the objdump option.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/disasm.c | 12 +++---
 tools/perf/util/dso.c    | 85 +++++++++++++++++++++++++---------------
 2 files changed, 60 insertions(+), 37 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 73343ae5fc96..175d9d3b5c97 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1501,6 +1501,12 @@ static int symbol__disassemble_objdump(const char *filename, struct symbol *sym,
 	struct child_process objdump_process;
 	int err;
 
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO)
+		return symbol__disassemble_bpf(sym, args);
+
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE)
+		return symbol__disassemble_bpf_image(sym, args);
+
 	err = asprintf(&command,
 		 "%s %s%s --start-address=0x%016" PRIx64
 		 " --stop-address=0x%016" PRIx64
@@ -1635,11 +1641,7 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 
 	pr_debug("annotating [%p] %30s : [%p] %30s\n", dso, dso__long_name(dso), sym, sym->name);
 
-	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO) {
-		return symbol__disassemble_bpf(sym, args);
-	} else if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE) {
-		return symbol__disassemble_bpf_image(sym, args);
-	} else if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND) {
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND) {
 		return SYMBOL_ANNOTATE_ERRNO__COULDNT_DETERMINE_FILE_TYPE;
 	} else if (dso__is_kcore(dso)) {
 		kce.addr = map__rip_2objdump(map, sym->start);
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 9b1e3fb3b2b9..d08e2a1f49c1 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1798,48 +1798,69 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
 			   const struct map *map, const struct symbol *sym,
 			   u8 **out_buf, u64 *out_buf_len, bool *is_64bit)
 {
-	struct nscookie nsc;
 	u64 start = map__rip_2objdump(map, sym->start);
 	u64 end = map__rip_2objdump(map, sym->end);
-	int fd, count;
-	u8 *buf = NULL;
-	size_t len;
-	struct find_file_offset_data data = {
-		.ip = start,
-	};
+	const u8 *buf;
+	size_t len = end - start;
 
 	*out_buf = NULL;
 	*out_buf_len = 0;
 	*is_64bit = false;
 
-	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
-	fd = open(symfs_filename, O_RDONLY);
-	nsinfo__mountns_exit(&nsc);
-	if (fd < 0)
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE) {
+		pr_debug("No BPF image disassembly support\n");
 		return NULL;
+	} else if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO) {
+#ifdef HAVE_LIBBPF_SUPPORT
+		struct bpf_prog_info_node *info_node;
+		struct perf_bpil *info_linear;
+
+		*is_64bit = sizeof(void *) == sizeof(u64);
+		info_node = perf_env__find_bpf_prog_info(dso__bpf_prog(dso)->env,
+							 dso__bpf_prog(dso)->id);
+		if (!info_node) {
+			errno = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
+			return NULL;
+		}
+		info_linear = info_node->info_linear;
+		buf = (const u8 *)(uintptr_t)(info_linear->info.jited_prog_insns);
+		assert(len <= info_linear->info.jited_prog_len);
+#else
+		pr_debug("No BPF program disassembly support\n");
+		return NULL;
+#endif
+	} else {
+		struct nscookie nsc;
+		int fd;
+		ssize_t count;
+		struct find_file_offset_data data = {
+			.ip = start,
+		};
+		u8 *code_buf = NULL;
 
-	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data, is_64bit) == 0)
-		goto err;
-
-	len = end - start;
-	buf = malloc(len);
-	if (buf == NULL)
-		goto err;
-
-	count = pread(fd, buf, len, data.offset);
-	close(fd);
-	fd = -1;
-
-	if ((u64)count != len)
-		goto err;
+		nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
+		fd = open(symfs_filename, O_RDONLY);
+		nsinfo__mountns_exit(&nsc);
+		if (fd < 0)
+			return NULL;
 
-	*out_buf = buf;
+		if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data, is_64bit) == 0) {
+			close(fd);
+			return NULL;
+		}
+		buf = code_buf = malloc(len);
+		if (buf == NULL) {
+			close(fd);
+			return NULL;
+		}
+		count = pread(fd, code_buf, len, data.offset);
+		close(fd);
+		if ((u64)count != len) {
+			free(code_buf);
+			return NULL;
+		}
+		*out_buf = code_buf;
+	}
 	*out_buf_len = len;
 	return buf;
-
-err:
-	if (fd >= 0)
-		close(fd);
-	free(buf);
-	return NULL;
 }
-- 
2.49.0.805.g082f7c87e0-goog

