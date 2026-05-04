Received: from va-2-112.ptr.blmpb.com (va-2-112.ptr.blmpb.com [209.127.231.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF63735A3AD
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 09:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777885603; cv=none; b=TgozMSt3IuXGPmfG/GAGSRfeKmhnxH5v09oRcQ2nAenZ7wMsweFlXNm1rqGQl4itQgkS4x7R3r2oFpR/Hzr6CUyoYJFGUK78C3c206E2IhQKBeUPk3zqB8trmIFyyOVHOyCy20vxyRZ2zQr6iLYhcCn2K2WoX0fqXPw5zoey3PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777885603; c=relaxed/simple;
	bh=CL5GWPoPCBW5qcFJxqhZukCnku1qPYAwh7E1vF+r914=;
	h=Subject:Mime-Version:Message-Id:From:Cc:Date:Content-Type:To; b=Dd8a/DMKN314SwSiF/3zhSQ3MUcE8fhnwJVnqB9P+d652kuZ/AIF6FoerpS1g8cXSHnXUHNOb8qkWpnaecN0094SUyocOMeKPDFLYkRcmLkEM1Yw0NsaI4u3lI/fHUVCox1jDlME+8AQPzcF+oDYC2UHRCnFFqJeddjnN1DxSiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iZ21inOC; arc=none smtp.client-ip=209.127.231.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iZ21inOC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1777885588; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=H+leLFINElIQNVmF4aeCmczij9WvGEmD6AUh5gGHels=;
 b=iZ21inOCRuW9LxYZMKTDxPq0TmZjx4tUaLpbnSRB2gvRJxMzxFjNF6Dm1Z/18E+TPVAcuc
 zijDSUwgAeLIt4xe99v2hTUWKDpOjZdhFO9QwYP/b5xgR532fS7Ajv8ZrT1wQ2TRAdOU7W
 zbR2om8y8+5ngUFkKfXmwI3qhDe2ka8h+9fUm1mM938pnoKqipvpRjwxfS1bcHI5SZdcmI
 EbmMxJaQtcLYh3YwDfT0L8HRZyOKs+Wq2Ee6aitNP9hZQ18iLlEhdqCk/ka3TE97GaOghl
 D28Zs+r8W09o5aPhzQcNUvJr6cF24QxVD02mRdu+YgtR966i3XUq0j99KwNb3w==
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.20.1
X-Lms-Return-Path: <lba+269f86192+8d0cab+vger.kernel.org+qirui.001@bytedance.com>
X-Original-From: Rui Qi <qirui.001@bytedance.com>
Subject: [PATCH] perf: Extract is_mapping_symbol() helper for mapping symbol filtering
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <20260504090609.1801880-1-qirui.001@bytedance.com>
From: "Rui Qi" <qirui.001@bytedance.com>
Cc: "Rui Qi" <qirui.001@bytedance.com>, 
	"Peter Zijlstra" <peterz@infradead.org>, 
	"Ingo Molnar" <mingo@redhat.com>, 
	"Arnaldo Carvalho de Melo" <acme@kernel.org>, 
	"Namhyung Kim" <namhyung@kernel.org>, 
	"Mark Rutland" <mark.rutland@arm.com>, 
	"Alexander Shishkin" <alexander.shishkin@linux.intel.com>, 
	"Jiri Olsa" <jolsa@kernel.org>, "Ian Rogers" <irogers@google.com>, 
	"Adrian Hunter" <adrian.hunter@intel.com>,  "Liang, 
	 Kan" <kan.liang@linux.intel.com>, "Haibo Xu" <haibo1.xu@intel.com>, 
	"Alexandre Ghiti" <alexghiti@rivosinc.com>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Date: Mon,  4 May 2026 17:06:09 +0800
Content-Type: text/plain; charset=UTF-8
To: 

The perf tool currently has ad-hoc logic to filter out ELF mapping
symbols scattered across multiple files and architectures.  ARM,
AArch64 and RISC-V each have their own inline checks in
dso__load_sym_internal(), and kallsym processing in map__process_kallsym_symbol()
has yet another check for ARM module symbols.

This is fragile: adding support for a new architecture or adjusting
which prefixes are considered mapping symbols requires touching
multiple places, and it is easy for the checks to diverge.  It also
does not match the kernel's own is_mapping_symbol() logic, which
additionally covers x86 local symbols ('.L*' and 'L0*').

Introduce a single is_mapping_symbol() inline helper in symbol.h and
convert all call sites to use it.  The helper covers the existing
'$' prefix used by ARM, AArch64 and RISC-V, and also adds the x86
local symbol prefixes so that perf stays consistent with the kernel.
This makes future maintenance simpler and reduces code duplication.

Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 tools/perf/util/libbfd.c     |  4 ++++
 tools/perf/util/machine.c    |  6 ++++++
 tools/perf/util/symbol-elf.c | 17 +++--------------
 tools/perf/util/symbol.c     |  8 ++++++--
 tools/perf/util/symbol.h     | 12 ++++++++++++
 5 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
index c1c12308cc12..a8474d287fc1 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -383,6 +383,10 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
 		if (bfd2elf_binding(sym) < 0)
 			continue;
 
+		/* Ignore mapping symbols in BFD symbols */
+		if (is_mapping_symbol(bfd_asymbol_name(sym)))
+			continue;
+
 		while (i + 1 < symbols_count &&
 		       bfd_asymbol_section(symbols[i + 1]) == section &&
 		       bfd2elf_binding(symbols[i + 1]) < 0)
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e76f8c86e62a..cce3faa70b32 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -769,6 +769,12 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		dso = dso__get(map__dso(map));
 	}
 
+	/* Ignore mapping symbols in ksymbol events */
+	if (is_mapping_symbol(event->ksymbol.name)) {
+		err = 0;
+		goto out;
+	}
+
 	sym = symbol__new(map__map_ip(map, map__start(map)),
 			  event->ksymbol.len,
 			  0, 0, event->ksymbol.name);
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 7afa8a117139..ddf5a9c4d6c9 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1592,20 +1592,9 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		if (!is_label && !elf_sym__filter(&sym))
 			continue;
 
-		/* Reject ARM ELF "mapping symbols": these aren't unique and
-		 * don't identify functions, so will confuse the profile
-		 * output: */
-		if (ehdr.e_machine == EM_ARM || ehdr.e_machine == EM_AARCH64) {
-			if (elf_name[0] == '$' && strchr("adtx", elf_name[1])
-			    && (elf_name[2] == '\0' || elf_name[2] == '.'))
-				continue;
-		}
-
-		/* Reject RISCV ELF "mapping symbols" */
-		if (ehdr.e_machine == EM_RISCV) {
-			if (elf_name[0] == '$' && strchr("dx", elf_name[1]))
-				continue;
-		}
+		/* Ignore mapping symbols in ELF files */
+		if (is_mapping_symbol(elf_name))
+			continue;
 
 		if (runtime_ss->opdsec && sym.st_shndx == runtime_ss->opdidx) {
 			u32 offset = sym.st_value - syms_ss->opdshdr.sh_addr;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index fcaeeddbbb6b..1e7ffeb6a539 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -770,8 +770,8 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
 	if (!symbol_type__filter(type))
 		return 0;
 
-	/* Ignore local symbols for ARM modules */
-	if (name[0] == '$')
+	/* Ignore mapping symbols */
+	if (is_mapping_symbol(name))
 		return 0;
 
 	/*
@@ -1566,6 +1566,10 @@ static int dso__load_perf_map(const char *map_path, struct dso *dso)
 		if (len + 2 >= line_len)
 			continue;
 
+		/* Ignore mapping symbols in perf map */
+		if (is_mapping_symbol(line + len))
+			continue;
+
 		sym = symbol__new(start, size, STB_GLOBAL, STT_FUNC, line + len);
 
 		if (sym == NULL)
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index bd6eb90c8668..9528fd777b87 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -28,6 +28,18 @@ struct maps;
 struct option;
 struct build_id;
 
+/*
+ * Ignore mapping symbols, matching kernel is_mapping_symbol() logic.
+ */
+static inline bool is_mapping_symbol(const char *str)
+{
+	if (str[0] == '.' && str[1] == 'L')
+		return true;
+	if (str[0] == 'L' && str[1] == '0')
+		return true;
+	return str[0] == '$';
+}
+
 /*
  * libelf 0.8.x and earlier do not support ELF_C_READ_MMAP;
  * for newer versions we can use mmap to reduce memory usage:
-- 
2.20.1
