Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41A726FDA8
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 19:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759172950; cv=none; b=pWytUTK8RYP13V4BNbZPK0YiRPm6gPRL//VdzboUPft8K/058QB1ZlyVjn1tN3bC0DM9NRRZOPANbTO/u+uxZkpoJ+hqUNn/FqmgEf+9i4dO5TuLRYOLWiHH/l4YQUaSYtr2Z2tRqA/xxY7r2s+w+8tcDHV2XY21U6l3HrEfXnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759172950; c=relaxed/simple;
	bh=612MmCdeynDCJhM2xzf4ABRBj4OerTlGO2/5DPdcThw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=UApWkxwJrAsc2pyYaonF8w8eozbq526gJEvxvh0/WSRtXCkqvLnwOwPwJiIdvaAYFePtxUgv4T5OEEEGe+9Z43qnNQuEJ6gTYcpz0tw4TNlaAAQw74SJYJVoGmPxuskhKbe41clwJsn1sMLNAq6/C7J+U/IT2Ir0l71QIz0nShk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SMrVe3cf; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SMrVe3cf"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-28d1747f23bso6454065ad.3
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 12:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759172947; x=1759777747; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T80LtbzuTq5QEV4YhukVhePJHtqZ6mXSdjQ51H1sVJk=;
        b=SMrVe3cfGPN5Sz2eC7qO0QXM1/jaCRSOZpO7E85PNWH4sDY2wJWuiFYFXGUhBNSMMX
         bkKHYnT3P2cnlh209NWzmnHcwLURoQFCAYg76Qok8D0Oe77EuHMd+HZJ5IO1KYJ7Mv/y
         l6SMGnkt222nca+N/mvEpCvLpi1vrFIATVB0XfDxZeCj9AfbaaVOjYj6A7EBZBQY5p+n
         TLLIxiM729qtF6YyqzYDPf1YL3SbOPcWMwwDLUBJXtcTTLxz1SQ7pTwuWhIobOKZEcDn
         4PJ7mt6rLlfoP641Sb96y3t/Wy70HgZLWPego6mT3qIMx1mIWvmu7vz07uJE++Cnsn1H
         J3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759172947; x=1759777747;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T80LtbzuTq5QEV4YhukVhePJHtqZ6mXSdjQ51H1sVJk=;
        b=N1bfl3Yq3KpVGq2TC2Q1w/wDuQP70gDeotpbw9lUYtVEct6G3UakCoZlxMj9S4m3OZ
         2cfOBbb1yXvM0yuMrH/3rRQi47t0MwAkTW4k+oRupnFQ/1UY8xjG7yIN7exhJRS6iCaB
         1RUc4IZ6rNTu+u86/VnoZ9tvpT8ipX2TCcQ/i+wETyhvL9BW/5u7do4zop1LbDTD32jE
         g3iYffvM0RaqVMXg7p7TMPVhrLOuxOo/8SDMOhSZfZeTf+Txsraicb4lNzFjvI8kiIal
         Yr8rOjEDiT786klgzoOhNgkETo6r1d12bt7c6dPVrdxBPYB4QVlzkikbnVy+noStcGJV
         Brgw==
X-Forwarded-Encrypted: i=1; AJvYcCVSGlvHQIAsASwpKEz8LQHgIPvkuX+va++L2UU50FKnlYouT5fgLisOURJyTvzzd91RXoEmtMvMZTmTx5t6XE2U@vger.kernel.org
X-Gm-Message-State: AOJu0YzTyBKds7RaE4+MbfWjZ9VFwh1NQ1UHQ4JWgse/ltO9AgvTJl5/
	Zfp2jFS3nLtFmJ5GqV5zeK6JkzHAZALtlHipL4jJsiCTRFYTrvFHq27b0iNSiuPnbHUs68yvmfe
	WW313HBg2SA==
X-Google-Smtp-Source: AGHT+IEvvky+/EgLWwl3K8Zs/55gu/czFI/PdGTNrcAlGJ4vN8lSEIzR8QJ/i33rJKHm2HVt07K26itw31Jq
X-Received: from pgdf9.prod.google.com ([2002:a05:6a02:5149:b0:b52:19fd:897f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:244c:b0:27e:ec72:f67
 with SMTP id d9443c01a7336-27eec7211f2mr148076835ad.6.1759172947312; Mon, 29
 Sep 2025 12:09:07 -0700 (PDT)
Date: Mon, 29 Sep 2025 12:08:00 -0700
In-Reply-To: <20250929190805.201446-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250929190805.201446-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.570.gb178f27e6d-goog
Message-ID: <20250929190805.201446-11-irogers@google.com>
Subject: [PATCH v6 10/15] perf dso: Support BPF programs in dso__read_symbol
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
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

Set the buffer to the code in the BPF linear info. This enables BPF
JIT code disassembly by LLVM and capstone. Move the common but minimal
disassmble_bpf_image call to disassemble_objdump so that it is only
called after falling back to the objdump option. Similarly move the
disassmble_bpf function to disassemble_objdump and rename to
disassmble_bpf_libbfd to make it clearer that this support relies on
libbfd.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/disasm.c |  12 +++--
 tools/perf/util/dso.c    | 100 ++++++++++++++++++++++++++-------------
 tools/perf/util/libbfd.c |   4 +-
 tools/perf/util/libbfd.h |   6 +--
 4 files changed, 80 insertions(+), 42 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index a1240543c89c..e64902e520ab 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1521,6 +1521,12 @@ static int symbol__disassemble_objdump(const char *filename, struct symbol *sym,
 	struct child_process objdump_process;
 	int err;
 
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO)
+		return symbol__disassemble_bpf_libbfd(sym, args);
+
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE)
+		return symbol__disassemble_bpf_image(sym, args);
+
 	err = asprintf(&command,
 		 "%s %s%s --start-address=0x%016" PRIx64
 		 " --stop-address=0x%016" PRIx64
@@ -1655,11 +1661,7 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 
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
index 87d075942de6..0aed5c8691bd 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1816,23 +1816,17 @@ static int find_file_offset(u64 start, u64 len, u64 pgoff, void *arg)
 	return 0;
 }
 
-const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
-			   const struct map *map, const struct symbol *sym,
-			   u8 **out_buf, u64 *out_buf_len, bool *is_64bit)
+static const u8 *__dso__read_symbol(struct dso *dso, const char *symfs_filename,
+				    u64 start, size_t len,
+				    u8 **out_buf, u64 *out_buf_len, bool *is_64bit)
 {
 	struct nscookie nsc;
-	u64 start = map__rip_2objdump(map, sym->start);
-	u64 end = map__rip_2objdump(map, sym->end);
-	int fd, count;
-	u8 *buf = NULL;
-	size_t len;
+	int fd;
+	ssize_t count;
 	struct find_file_offset_data data = {
 		.ip = start,
 	};
-
-	*out_buf = NULL;
-	*out_buf_len = 0;
-	*is_64bit = false;
+	u8 *code_buf = NULL;
 
 	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 	fd = open(symfs_filename, O_RDONLY);
@@ -1840,28 +1834,70 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
 	if (fd < 0)
 		return NULL;
 
-	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data, is_64bit) == 0)
-		goto err;
-
-	len = end - start;
-	buf = malloc(len);
-	if (buf == NULL)
-		goto err;
-
-	count = pread(fd, buf, len, data.offset);
+	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data, is_64bit) == 0) {
+		close(fd);
+		return NULL;
+	}
+	code_buf = malloc(len);
+	if (code_buf == NULL) {
+		close(fd);
+		return NULL;
+	}
+	count = pread(fd, code_buf, len, data.offset);
 	close(fd);
-	fd = -1;
+	if ((u64)count != len) {
+		free(code_buf);
+		return NULL;
+	}
+	*out_buf = code_buf;
+	*out_buf_len = len;
+	return code_buf;
+}
 
-	if ((u64)count != len)
-		goto err;
+/*
+ * Read a symbol into memory for disassembly by a library like capstone of
+ * libLLVM. If memory is allocated out_buf holds it.
+ */
+const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
+			   const struct map *map, const struct symbol *sym,
+			   u8 **out_buf, u64 *out_buf_len, bool *is_64bit)
+{
+	u64 start = map__rip_2objdump(map, sym->start);
+	u64 end = map__rip_2objdump(map, sym->end);
+	size_t len = end - start;
 
-	*out_buf = buf;
-	*out_buf_len = len;
-	return buf;
+	*out_buf = NULL;
+	*out_buf_len = 0;
+	*is_64bit = false;
 
-err:
-	if (fd >= 0)
-		close(fd);
-	free(buf);
-	return NULL;
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE) {
+		/*
+		 * Note, there is fallback BPF image disassembly in the objdump
+		 * version but it currently does nothing.
+		 */
+		return NULL;
+	}
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO) {
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
+		assert(len <= info_linear->info.jited_prog_len);
+		*out_buf_len = len;
+		return (const u8 *)(uintptr_t)(info_linear->info.jited_prog_insns);
+#else
+		pr_debug("No BPF program disassembly support\n");
+		return NULL;
+#endif
+	}
+	return __dso__read_symbol(dso, symfs_filename, start, len,
+				  out_buf, out_buf_len, is_64bit);
 }
diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
index 09a0eeb78a1a..01147fbf73b3 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -448,8 +448,8 @@ int libbfd_filename__read_debuglink(const char *filename, char *debuglink,
 	return err;
 }
 
-int symbol__disassemble_bpf(struct symbol *sym __maybe_unused,
-			    struct annotate_args *args  __maybe_unused)
+int symbol__disassemble_bpf_libbfd(struct symbol *sym __maybe_unused,
+				   struct annotate_args *args  __maybe_unused)
 {
 #ifdef HAVE_LIBBPF_SUPPORT
 	struct annotation *notes = symbol__annotation(sym);
diff --git a/tools/perf/util/libbfd.h b/tools/perf/util/libbfd.h
index 7441e95f8ec0..e300f171d1bd 100644
--- a/tools/perf/util/libbfd.h
+++ b/tools/perf/util/libbfd.h
@@ -29,7 +29,7 @@ int libbfd__read_build_id(const char *filename, struct build_id *bid, bool block
 
 int libbfd_filename__read_debuglink(const char *filename, char *debuglink, size_t size);
 
-int symbol__disassemble_bpf(struct symbol *sym, struct annotate_args *args);
+int symbol__disassemble_bpf_libbfd(struct symbol *sym, struct annotate_args *args);
 
 #else // !defined(HAVE_LIBBFD_SUPPORT)
 #include "annotate.h"
@@ -72,8 +72,8 @@ static inline int libbfd_filename__read_debuglink(const char *filename __always_
 	return -1;
 }
 
-static inline int symbol__disassemble_bpf(struct symbol *sym __always_unused,
-					  struct annotate_args *args __always_unused)
+static inline int symbol__disassemble_bpf_libbfd(struct symbol *sym __always_unused,
+						 struct annotate_args *args __always_unused)
 {
 	return SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF;
 }
-- 
2.51.0.570.gb178f27e6d-goog

