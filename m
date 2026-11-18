Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019397;
	b=4fWmItopOb4hGX22D2EXXAR6yV6yeo+tMlDGCW4z/GYEobgE2albk/CsV5RQsg3Tal/T
	 6T1r4awKsHYYRdawnmDE0H/SBrcD8ViELQjl1n96+VJXJixolPaHfgDkpLWZjFZOs1CjF
	 0FDjNZeUaGEVkT/l8gLKvaPzIMk/HEZK3XyHAS5u5djt7GcEND9TNaq1ue951fN94tZu+
	 UixeAzxkGgcvo+WpNlNgqbspEAL11kkwCg/kvd3dhloHQE4qSsF08K42uRj3hcJh7ggdq
	 vyUdMclRLIAwPPfh+B8J1ehzbvOK75DvHdV1wwn+DWyIkiGdmbgbbvxHnYj27BEhmjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=dNQDu45hRxK42vQ4yOX5cPIZBkSnKSKiQldYYSn1aqI=;
	b=3T4GBWRJlKLl5tdtggaKGdJ9cIF3FZBBUkLDLRSpmkkhF/PedV9S1zxgRSktEsmcLLIe
	 y/Lc7ZzrnXNvuvcWbV593g/ZfJKWmE6B2u5MGiAjiCFUusycZoUPumAop/Z9TBOO2D+qR
	 Ubyg7K5RngPQ8yRxJYxGydACCjwlh3lVbRr765RpJwXSxt7FMPNjR8fIYHAVksVcRi+uQ
	 R67DbWxbp0aPLiXNqqa19GHiWt1OgwW3nKB6BrzucvX2UBCezQDaO3xMTN0T+JXOKOyEN
	 RGzKoPvoQNE32SiM+TlPmMBwlgPheFN1sdXKMKKdenkxNtLkbEdJZ78BBiL65GMySyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="NCGkXi/x";
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A903360A2620
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A903360A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NCGkXi/x
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-492f0a1b685so840407f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795019391; x=1795624191; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dNQDu45hRxK42vQ4yOX5cPIZBkSnKSKiQldYYSn1aqI=;
        b=NCGkXi/xCkcuWkAZ9LI8BuN4UITaOcFU6h28fD10kdoHG9hCmV+5dhSM9sYvZwRJWU
         OkDerYPjdvwU80Vgjyn1GWDCLnbAaH7Q3Rmu+83qWMRx8gZ4O95sQCMsIPbEfm75YMcy
         xbFtTQ3OQzCT11hVR2ycFLmis2oYOrpdm0Jj5mcfHf332fnGP2fY/jTNCypw65V1MLDH
         Q7w/FHgFv9glk8VW09GiYHkHAVhZcJw+wzDLD253UjmM3TR5XBrf4wpYVxR5nyScDtLz
         WXxuBXl8UomwtevywWTWB/T22O7M8zOnu9Vuz8fbVeWbmmE6sk4DEYpbLPYBdoudBZRv
         GHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019391; x=1795624191;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dNQDu45hRxK42vQ4yOX5cPIZBkSnKSKiQldYYSn1aqI=;
        b=J4fqPpZjvzTRDwEQFzt+SJDbl8F3sB32rtMzrLTYRp892KxPnnFAeQUtZ3JNQKn6vY
         9CTJ6iEAnowmvNXW1D8WAsJx3nMipszbF/83dkR3ob31B8tP0T9+bSlfH61Cov777HE1
         FhQ6dZnmbM58UgCUQYbahOjNQfzHmc43g8lh9WillNxmo+u8qG6AB9ppNDdzRqYMnMv6
         XmX6y/ms/uGTpOR1obHCClUDZZ0rZQrJnHSwEf4krLVLST4rkMTmATYdbCPMj9J9FtFg
         okLxb9rv7UyHzrDcd3yh0Mr7fJD6EAtuVrEmH5RTWTJV57bEX9P5On+iXU1Nf/WWbUNt
         wi+A==
X-Gm-Message-State: APuU4Z+ThfVS7Nk2ufu7gtLZpybIL3Ll9ryehfC2HeJVc0G9YSPtVoyS
	NywmX4bFn3obsSgC41qSxIewiGqeehXQz3bgMDW+mlicGQXMkDZezRuAi2DBhXQk5DGtDxKWQPQ
	HZ/w82zY=
X-Gm-Gg: AZFdTZeVaVvX7uvUHz2oVA+C7z632Gw6ZJA0S9rTO9gxlCYFJzHJkh08s1+ST4XMMr8
	HGDPcl76zmdeoUOR3t+hnuPYPnNFPCXpO5MuSrq3LLF97L5ATW46kEJqMQ73igAjgYmm00H/jxJ
	syPgeKnTyBtHvpQVfGz1miZCAPBXZ0GzS723j5GXg6vIk4Aihghcj4UWtIdFQDGwB8Fqh1QoUUg
	++U8PFTclqqVmDqZB64J1d4gi4lQgy/f9cU39SxgUf3jH7bwKw0kl4RO9+m8jmDtlMgkBh3Wa2F
	t/flUJgj3hMcRFlp2VS3C6paV/4hvt0vW9EPSg5R5h/f9CfamQoUFu1+/2ZNQ07zKlvRHQcZeNC
	6P7VIxbindVfcVamZ4ury8FymZ1nr1HWHkERxArnkJxLM5fg9V1YC3Qpang8MFtD2y75WTPsBii
	+UIVX9+DpZw89CLDGy1aZ9+n1fbKrG9TLGvPDnrdG3vQr5lzM3dyzuAyG4VUAnI26lsy836UmoI
	p2NQysbEez9s0GnXQIPKg6d40sbs9oihPpAeyagOD+g55okEPWxXfEHynPaxZ0xLaQ+ThR25kNe
	hQTsOdp+dgI3VmUHHAJb63cssdynSpVLNyhXhSj1kmq3vLWqSQ6JdQ==
X-Received: by 2002:a05:6000:4312:b0:4a6:4ac6:d952 with SMTP id ffacd0b85a97d-4a64ac6dad3mr6914932f8f.31.1795019391032;
        Wed, 18 Nov 2026 08:29:51 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c23bsm4980927f8f.12.2026.11.18.08.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:29:50 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 18 Nov 2026 16:29:25 +0000
Subject: [PATCH 03/34] perf jit: Add address ranges to DWARF compilation
 units
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-james-coresight-jit-v1-3-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
In-Reply-To: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, 
 Leo Yan <leo.yan@arm.com>, Amir Ayupov <aaupov@fb.com>, 
 Suyash Mahar <smahar@meta.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

The JIT ELF writer emits a line table and a compilation unit containing
only DW_AT_stmt_list. LLVM locates the CU by address before looking up a
source line, but the CU address range isn't written into the DWARF.
Therefore it can't resolve these files even though GNU addr2line could
by reading the line table directly. This means that JIT src line lookups
when LLVM is used.

Pass the generated code size to the debug information writer and emit
DW_AT_low_pc and DW_AT_high_pc address ranges. Also mark the compilation
unit as childless to match its contents.

Add a test which writes JIT debug information at a nonzero runtime load
address and resolves an ELF-relative address through LLVM.

Fixes: c3f8644c21df ("perf report: Support LLVM for addr2line()")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/genelf.c      | 70 +++++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/genelf.c       |  2 +-
 tools/perf/util/genelf.h       |  3 +-
 tools/perf/util/genelf_debug.c | 22 +++++++++----
 4 files changed, 88 insertions(+), 9 deletions(-)

diff --git a/tools/perf/tests/genelf.c b/tools/perf/tests/genelf.c
index 95f3be1b683a..4d23778c1979 100644
--- a/tools/perf/tests/genelf.c
+++ b/tools/perf/tests/genelf.c
@@ -5,6 +5,8 @@
 #include <string.h>
 #include <unistd.h>
 #include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/unaligned.h>
 
 #include "debug.h"
 #include "tests.h"
@@ -12,6 +14,8 @@
 #ifdef HAVE_JITDUMP
 #include <libelf.h>
 #include "../util/genelf.h"
+#include "../util/jitdump.h"
+#include "../util/llvm.h"
 #endif
 
 #define TEMPL "/tmp/perf-test-XXXXXX"
@@ -50,4 +54,68 @@ static int test__jit_write_elf(struct test_suite *test __maybe_unused,
 #endif
 }
 
-DEFINE_SUITE("Test jit_write_elf", jit_write_elf);
+static int test__jit_write_elf_dwarf(struct test_suite *test __maybe_unused,
+				     int subtest __maybe_unused)
+{
+#if defined(HAVE_JITDUMP) && defined(HAVE_LIBDW_SUPPORT) && defined(HAVE_LIBLLVM_SUPPORT)
+	const uint64_t load_addr = 0x12340000;
+	static const char filename[] = "jit.c";
+	unsigned char code[16] = { 0 };
+	unsigned char debug[2 * (sizeof(struct debug_entry) + sizeof(filename))];
+	struct debug_entry *entry = (struct debug_entry *)debug;
+	char path[] = TEMPL;
+	char *file = NULL;
+	unsigned int line = 0;
+	int fd, ret = TEST_FAIL;
+
+	/* The second row terminates the first row's source-line range. */
+	for (int i = 0; i < 2; i++) {
+		put_unaligned(load_addr + i * 8, &entry->addr);
+		put_unaligned(42 + i, &entry->lineno);
+		put_unaligned(0, &entry->discrim);
+		memcpy(entry + 1, filename, sizeof(filename));
+		entry = debug_entry_next(entry);
+	}
+
+	fd = mkstemp(path);
+	if (fd < 0) {
+		perror("mkstemp failed");
+		return TEST_FAIL;
+	}
+
+	if (jit_write_elf(fd, load_addr, "main", code, sizeof(code),
+			  debug, 2, NULL, 0, 0))
+		goto out;
+
+	/* LLVM must find the CU from the ELF address before reading its lines. */
+	if (llvm__addr2line(path, GEN_ELF_TEXT_OFFSET + 4, &file, &line,
+			    NULL, false, NULL, NULL) <= 0) {
+		pr_debug("LLVM could not resolve the JIT source line\n");
+		goto out;
+	}
+	if (!file || strcmp(file, filename) || line != 42) {
+		pr_debug("Unexpected JIT source line: %s:%u\n", file ?: "??", line);
+		goto out;
+	}
+	ret = TEST_OK;
+out:
+	free(file);
+	close(fd);
+	unlink(path);
+	return ret;
+#else
+	return TEST_SKIP;
+#endif
+}
+
+static struct test_case tests__jit_write_elf[] = {
+	TEST_CASE("Write JIT ELF", jit_write_elf),
+	TEST_CASE_REASON("Resolve JIT ELF source line with LLVM", jit_write_elf_dwarf,
+			 "requires JIT dump, libdw and LLVM support"),
+	{ .name = NULL, }
+};
+
+struct test_suite suite__jit_write_elf = {
+	.desc = "Test jit_write_elf",
+	.test_cases = tests__jit_write_elf,
+};
diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
index 14882def9704..fc145f9401d2 100644
--- a/tools/perf/util/genelf.c
+++ b/tools/perf/util/genelf.c
@@ -449,7 +449,7 @@ jit_write_elf(int fd, uint64_t load_addr __maybe_unused, const char *sym,
 
 #ifdef HAVE_LIBDW_SUPPORT
 	if (debug && nr_debug_entries) {
-		retval = jit_add_debug_info(e, load_addr, debug, nr_debug_entries);
+		retval = jit_add_debug_info(e, load_addr, csize, debug, nr_debug_entries);
 		if (retval)
 			goto error;
 	} else
diff --git a/tools/perf/util/genelf.h b/tools/perf/util/genelf.h
index 9f0b875d6548..67309794239a 100644
--- a/tools/perf/util/genelf.h
+++ b/tools/perf/util/genelf.h
@@ -10,7 +10,8 @@ int jit_write_elf(int fd, uint64_t code_addr, const char *sym,
 		  void *unwinding, uint64_t unwinding_header_size, uint64_t unwinding_size);
 #ifdef HAVE_LIBDW_SUPPORT
 /* genelf_debug.c */
-int jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries);
+int jit_add_debug_info(Elf *e, uint64_t code_addr, int code_size,
+		       void *debug, int nr_debug_entries);
 #endif
 
 #if   defined(__arm__)
diff --git a/tools/perf/util/genelf_debug.c b/tools/perf/util/genelf_debug.c
index 7d9ef43aa6ac..a124ab40f36b 100644
--- a/tools/perf/util/genelf_debug.c
+++ b/tools/perf/util/genelf_debug.c
@@ -449,9 +449,13 @@ add_debug_abbrev(struct buffer_ext *be)
 {
         emit_unsigned_LEB128(be, 1);
         emit_unsigned_LEB128(be, DW_TAG_compile_unit);
-        emit_unsigned_LEB128(be, DW_CHILDREN_yes);
+	emit_unsigned_LEB128(be, DW_CHILDREN_no);
         emit_unsigned_LEB128(be, DW_AT_stmt_list);
         emit_unsigned_LEB128(be, DW_FORM_data4);
+	emit_unsigned_LEB128(be, DW_AT_low_pc);
+	emit_unsigned_LEB128(be, DW_FORM_addr);
+	emit_unsigned_LEB128(be, DW_AT_high_pc);
+	emit_unsigned_LEB128(be, DW_FORM_addr);
         emit_unsigned_LEB128(be, 0);
         emit_unsigned_LEB128(be, 0);
         emit_unsigned_LEB128(be, 0);
@@ -459,9 +463,11 @@ add_debug_abbrev(struct buffer_ext *be)
 
 static void
 add_compilation_unit(struct buffer_ext *be,
-		     size_t offset_debug_line)
+		     size_t offset_debug_line, int code_size)
 {
 	struct compilation_unit_header *comp_unit_header;
+	uintptr_t low_pc = GEN_ELF_TEXT_OFFSET;
+	uintptr_t high_pc = low_pc + code_size;
 	size_t old_size = buffer_ext_size(be);
 
 	buffer_ext_add(be, &default_comp_unit_header,
@@ -469,6 +475,9 @@ add_compilation_unit(struct buffer_ext *be,
 
 	emit_unsigned_LEB128(be, 1);
 	emit_uword(be, offset_debug_line);
+	/* DW_FORM_addr uses the address size declared in the CU header. */
+	buffer_ext_add(be, &low_pc, sizeof(low_pc));
+	buffer_ext_add(be, &high_pc, sizeof(high_pc));
 
 	comp_unit_header = buffer_ext_addr(be) + old_size;
 	comp_unit_header->total_length = (buffer_ext_size(be) - old_size) -
@@ -476,7 +485,7 @@ add_compilation_unit(struct buffer_ext *be,
 }
 
 static int
-jit_process_debug_info(uint64_t code_addr,
+jit_process_debug_info(uint64_t code_addr, int code_size,
 		       void *debug, int nr_debug_entries,
 		       struct buffer_ext *dl,
 		       struct buffer_ext *da,
@@ -489,7 +498,7 @@ jit_process_debug_info(uint64_t code_addr,
 		put_unaligned(get_unaligned(&ent->addr) - code_addr, &ent->addr);
 		ent = debug_entry_next(ent);
 	}
-	add_compilation_unit(di, buffer_ext_size(dl));
+	add_compilation_unit(di, buffer_ext_size(dl), code_size);
 	add_debug_line(dl, debug, nr_debug_entries, GEN_ELF_TEXT_OFFSET);
 	add_debug_abbrev(da);
 	if (0) buffer_ext_dump(da, "abbrev");
@@ -498,7 +507,8 @@ jit_process_debug_info(uint64_t code_addr,
 }
 
 int
-jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries)
+jit_add_debug_info(Elf *e, uint64_t code_addr, int code_size,
+		   void *debug, int nr_debug_entries)
 {
 	Elf_Data *d;
 	Elf_Scn *scn;
@@ -510,7 +520,7 @@ jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries
 	buffer_ext_init(&di);
 	buffer_ext_init(&da);
 
-	if (jit_process_debug_info(code_addr, debug, nr_debug_entries, &dl, &da, &di))
+	if (jit_process_debug_info(code_addr, code_size, debug, nr_debug_entries, &dl, &da, &di))
 		goto out;
 
 	/*

-- 
2.43.0

