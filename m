Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793428560;
	b=MoAMOksKJm57bOa9YdG5dAxi2fvG8XKm+pyVexxJxc0icwxkI2DnaLdd5L+tlVcOY3Kb
	 wGFfdITLwzm3svVRccPt5TU+3xxuOIIuUetm3qHyBRwpuc/jeH9b29ECPlFHZBH9U4wvV
	 /ITt1M7k5Q0pRDSHpM+xk8IJvWfD8Vz2KnCXOq9opfHGVQb3VAxTRdhlL+sPnJY/QlXu7
	 0CMCuUaoP71TMzBWm0A8zMMFQirxQb0iK9foD+IwqLxThws9qzM094EC1oZdVcvigQTmL
	 s3/faGWSFg2BsQRsRthb5cE9ykqv+Z4C3C5bXdDHykFJKgNL5uEFgt3De4AbAMnuXiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793428560;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=kGWpRJfcTL8/co7PFq+A4heuLnWtafuVyZoV9YBbOho=;
	b=ZvHww4yQqbNp7+u8JBVPomZRyi1rLg0b3tcA1ue1SVD4bo4jHAidMDkwjBh7KCSWX2xU
	 74Sbv5mDnflBolc5BOV4pQulDuWj+VDYLroxxDY1s9uuqLl3KhrBlarGth0P5ixm3HlfV
	 boRAVRChoHqKXkadNGNjSTCsgNZG3rePHOPfWFgok1TGhqZLd9/rAK/gsrxXNJ/VVWTeB
	 p75A+Ti6YT8QRjG+eSufe/4vdRJwNq5+lIYkDMZkQ1lwf5ftQ6UHtQbLnCiRMGdwbzUoX
	 KtiLqqW2BQc3rg7k9MYcVTX+UYobhQveDArUVuAfWqHGjK9u8H20BEGaqLOJ2rnCjFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PXGn9bxy;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C6D60A2602
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Oct 2026 06:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32C6D60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PXGn9bxy
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-351788121cfso6712042eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 23:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793428559; x=1794033359; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kGWpRJfcTL8/co7PFq+A4heuLnWtafuVyZoV9YBbOho=;
        b=PXGn9bxyGrPAmNLg8onJWyfNCXOuREyzC6eV4f66vPISuZ8b7pTKpLTq37q9ncSsOA
         CXIh2xQ5tGuhNir2mt+qo2X5zl/n0pk172I5RPTDyYNhnmwxnDBDS+daAhVBRsuIlbkV
         3LVS6XGE/PM/gLGCsAHSgn3gm1w6Mknj8ra1UsoADNMo2+8DjA7EcwG7rMxA+VfJ7W19
         4+OoZ2Oe53kORfoaAVmv3F3zfjcKiCJBfnkQ4FUjhFhjp3TMbb2sEMAGPd8WDsrZ+5wa
         yl0E9BrcsO0q/WXl0VMK0+QtiTqJZgPbmBVN5BvE6oR/CH4Z/FQ0ZEw9HALsEomAmV5Y
         nu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793428559; x=1794033359;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kGWpRJfcTL8/co7PFq+A4heuLnWtafuVyZoV9YBbOho=;
        b=PLDuHUOyFPQOXsg4oS7TBzlji1EtmFgtSwRtG0kA+WPBWeZ2KtSAzyLrEZYENdLYvh
         MAiC//m6lz0fXQ2ypj2anPWWXQyUGAPXET/7z0aVqjERaP7AzzmUM/4GJ4Cbd05os5jc
         Y7Ye7K1mchoqzMg1KGYosusS4kW9tMOMdtrlaPIZefNUy2/68P1URMNGzzHODwM+EiDk
         6o006zr6xanyuDz7kTsTyGSr75wlZPf0eSFetC8OiOCxXMCag1ksBYOQsltTkB20PALh
         5GRGgcKgsbTVBbR/ekW4LhEQw5PoJlh99R2LsGsbiq5Ms4POnPdBEf+riIcUdGVH7aXZ
         Lk8Q==
X-Forwarded-Encrypted: i=1; AKwUvByPf+W9HaeU7QY+ZA90UOJcAhbM7Af1togHaHfvxGRixBuBsh7YDSKAn8Zv/oGM0Od8S199NSoZLKv5+5smDtTS@vger.kernel.org
X-Gm-Message-State: AFq9FYLD7TH4dVkbpOPcC0DsJ/8M5ZGJ8Un9TpeaCrBrRK7OOq/3/zQe
	nwuZ2IsHGMvCY9q+yRBGJU+xl6MCIG/kuRon8o3CmRd5ullDbZ7V4iaeQy55zTc5j2LaQ14Jxup
	c4dqDU8faNA==
X-Received: from dycnr20-n1.prod.google.com ([2002:a05:7300:e9d4:10b0:34d:46b2:7513])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:da83:b0:366:83dd:46f3
 with SMTP id 5a478bee46e88-36a423a1f05mr6006405eec.14.1793428558997; Fri, 30
 Oct 2026 23:35:58 -0700 (PDT)
Date: Fri, 30 Oct 2026 23:35:48 -0700
In-Reply-To: <20261031063549.1281324-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261031063549.1281324-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261031063549.1281324-3-irogers@google.com>
Subject: [PATCH 2/3] perf symbol-elf: Fix zero-size symbol end calculation
 across .symtab and .dynsym
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Alireza Haghdoost <haghdoost@uber.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

When loading symbols from an ELF binary in dso__load_sym(),
dso__load_sym_internal() can be invoked multiple times: first for
.symtab (or .gnu_debugdata's .symtab) and then for .dynsym.

Previously, dso__load_sym_internal() ran symbols__fixup_end() and
symbols__fixup_duplicate() at the end of each individual symbol table
load. Consequently, a zero-size symbol in .symtab had its end address
extended to the start of the next .symtab symbol before .dynsym was
loaded. If an exported function existed only in .dynsym (for example,
when stripped from .symtab or when using .gnu_debugdata minidebuginfo)
at an address between the two .symtab symbols, the zero-size .symtab
symbol overlapped the .dynsym function and samples inside the .dynsym
function were misattributed to the preceding zero-size symbol.

Move symbols__fixup_end(), symbols__fixup_duplicate(), and
maps__fixup_end() from dso__load_sym_internal() to dso__load_sym() so
they run once after all symbol tables have been loaded into the DSO, and
add a unit test in 'perf test symbols' verifying that a zero-size
.symtab symbol ends at a following .dynsym-only function rather than
overlapping it.

Fixes: 87704345cc60 ("perf symbol-elf: Decode dynsym even if symtab exists")
Fixes: b10f74308e13 ("perf symbol: Support .gnu_debugdata for symbols")
Suggested-by: Alireza Haghdoost <haghdoost@uber.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/symbols.c   | 169 +++++++++++++++++++++++++++++++++++
 tools/perf/util/symbol-elf.c |  36 ++++----
 2 files changed, 190 insertions(+), 15 deletions(-)

diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
index b644d95c6be9..d3180db45ee6 100644
--- a/tools/perf/tests/symbols.c
+++ b/tools/perf/tests/symbols.c
@@ -2,8 +2,11 @@
 #include <linux/compiler.h>
 #include <linux/string.h>
 #include <sys/mman.h>
+#include <elf.h>
 #include <inttypes.h>
 #include <limits.h>
+#include <stdlib.h>
+#include <unistd.h>
 #include "debug.h"
 #include "dso.h"
 #include "env.h"
@@ -308,9 +311,175 @@ static int test__kallsyms_fixup_end(struct test_suite *test __maybe_unused,
 	return ret;
 }
 
+#ifdef HAVE_LIBELF_SUPPORT
+static int write_test_elf(int fd)
+{
+	static const char shstrtab[] = "\0.shstrtab\0.text\0.strtab\0.symtab\0.dynsym";
+	static const char strtab[] = "\0zfun\0efun\0after_fun";
+	struct {
+		Elf64_Ehdr ehdr;
+		Elf64_Shdr shdrs[6];
+		char shstr[sizeof(shstrtab)];
+		char str[sizeof(strtab)];
+		Elf64_Sym symtab[3];
+		Elf64_Sym dynsym[2];
+		u8 text[0x60];
+	} img;
+
+	memset(&img, 0, sizeof(img));
+	memcpy(img.ehdr.e_ident, ELFMAG, SELFMAG);
+	img.ehdr.e_ident[EI_CLASS] = ELFCLASS64;
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+	img.ehdr.e_ident[EI_DATA] = ELFDATA2MSB;
+#else
+	img.ehdr.e_ident[EI_DATA] = ELFDATA2LSB;
+#endif
+	img.ehdr.e_ident[EI_VERSION] = EV_CURRENT;
+	img.ehdr.e_type = ET_DYN;
+	img.ehdr.e_machine = EM_X86_64;
+	img.ehdr.e_version = EV_CURRENT;
+	img.ehdr.e_shoff = offsetof(typeof(img), shdrs);
+	img.ehdr.e_ehsize = sizeof(Elf64_Ehdr);
+	img.ehdr.e_shentsize = sizeof(Elf64_Shdr);
+	img.ehdr.e_shnum = ARRAY_SIZE(img.shdrs);
+	img.ehdr.e_shstrndx = 1;
+
+	memcpy(img.shstr, shstrtab, sizeof(shstrtab));
+	memcpy(img.str, strtab, sizeof(strtab));
+
+	/* Section 1: .shstrtab */
+	img.shdrs[1].sh_name = 1;
+	img.shdrs[1].sh_type = SHT_STRTAB;
+	img.shdrs[1].sh_offset = offsetof(typeof(img), shstr);
+	img.shdrs[1].sh_size = sizeof(shstrtab);
+
+	/* Section 2: .text */
+	img.shdrs[2].sh_name = 11;
+	img.shdrs[2].sh_type = SHT_PROGBITS;
+	img.shdrs[2].sh_flags = SHF_ALLOC | SHF_EXECINSTR;
+	img.shdrs[2].sh_addr = 0x1000;
+	img.shdrs[2].sh_offset = offsetof(typeof(img), text);
+	img.shdrs[2].sh_size = sizeof(img.text);
+
+	/* Section 3: .strtab */
+	img.shdrs[3].sh_name = 17;
+	img.shdrs[3].sh_type = SHT_STRTAB;
+	img.shdrs[3].sh_flags = SHF_ALLOC;
+	img.shdrs[3].sh_offset = offsetof(typeof(img), str);
+	img.shdrs[3].sh_size = sizeof(strtab);
+
+	/*
+	 * Section 4: .symtab with zero-size zfun at 0x1010 and after_fun at
+	 * 0x1040, but without efun (simulating objcopy --strip-symbol=efun or
+	 * .gnu_debugdata minidebuginfo where exported symbols live only in
+	 * .dynsym).
+	 */
+	img.shdrs[4].sh_name = 25;
+	img.shdrs[4].sh_type = SHT_SYMTAB;
+	img.shdrs[4].sh_offset = offsetof(typeof(img), symtab);
+	img.shdrs[4].sh_size = sizeof(img.symtab);
+	img.shdrs[4].sh_link = 3;
+	img.shdrs[4].sh_info = 2;
+	img.shdrs[4].sh_entsize = sizeof(Elf64_Sym);
+
+	img.symtab[1].st_name = 1; /* zfun */
+	img.symtab[1].st_info = ELF64_ST_INFO(STB_LOCAL, STT_FUNC);
+	img.symtab[1].st_shndx = 2;
+	img.symtab[1].st_value = 0x1010;
+	img.symtab[1].st_size = 0;
+
+	img.symtab[2].st_name = 11; /* after_fun */
+	img.symtab[2].st_info = ELF64_ST_INFO(STB_GLOBAL, STT_FUNC);
+	img.symtab[2].st_shndx = 2;
+	img.symtab[2].st_value = 0x1040;
+	img.symtab[2].st_size = 0x10;
+
+	/* Section 5: .dynsym with efun at 0x1020..0x1030 */
+	img.shdrs[5].sh_name = 33;
+	img.shdrs[5].sh_type = SHT_DYNSYM;
+	img.shdrs[5].sh_flags = SHF_ALLOC;
+	img.shdrs[5].sh_offset = offsetof(typeof(img), dynsym);
+	img.shdrs[5].sh_size = sizeof(img.dynsym);
+	img.shdrs[5].sh_link = 3;
+	img.shdrs[5].sh_info = 1;
+	img.shdrs[5].sh_entsize = sizeof(Elf64_Sym);
+
+	img.dynsym[1].st_name = 6; /* efun */
+	img.dynsym[1].st_info = ELF64_ST_INFO(STB_GLOBAL, STT_FUNC);
+	img.dynsym[1].st_shndx = 2;
+	img.dynsym[1].st_value = 0x1020;
+	img.dynsym[1].st_size = 0x10;
+
+	return write(fd, &img, sizeof(img)) == (ssize_t)sizeof(img) ? 0 : -1;
+}
+
+static int test__elf_symtab_dynsym_fixup_end(struct test_suite *test __maybe_unused,
+					     int subtest __maybe_unused)
+{
+	char tmpfile[] = "/tmp/perf-test-symtab-dynsym-XXXXXX";
+	struct test_info ti;
+	struct map *map = NULL;
+	struct dso *dso;
+	u64 text_offs;
+	int fd, ret;
+
+	fd = mkstemp(tmpfile);
+	if (fd < 0)
+		return TEST_FAIL;
+
+	if (write_test_elf(fd)) {
+		close(fd);
+		unlink(tmpfile);
+		return TEST_FAIL;
+	}
+	close(fd);
+
+	ret = init_test_info(&ti);
+	if (ret != TEST_OK) {
+		unlink(tmpfile);
+		return ret;
+	}
+
+	ret = create_map(&ti, tmpfile, &map);
+	if (ret != TEST_OK)
+		goto out_exit;
+
+	dso = map__dso(map);
+	if (dso__load(dso, map) <= 0) {
+		ret = TEST_FAIL;
+		goto out_put;
+	}
+
+	/* Verify no overlapping or zero-length symbols exist. */
+	ret = test_dso(dso);
+	text_offs = 0x1000 - dso__text_offset(dso);
+	if (check_symbol(dso, text_offs + 0x14, "zfun", text_offs + 0x20))
+		ret = TEST_FAIL;
+	if (check_symbol(dso, text_offs + 0x24, "efun", text_offs + 0x30))
+		ret = TEST_FAIL;
+	if (check_symbol(dso, text_offs + 0x44, "after_fun", text_offs + 0x50))
+		ret = TEST_FAIL;
+
+out_put:
+	map__put(map);
+out_exit:
+	exit_test_info(&ti);
+	unlink(tmpfile);
+	return ret;
+}
+#else
+static int test__elf_symtab_dynsym_fixup_end(struct test_suite *test __maybe_unused,
+					     int subtest __maybe_unused)
+{
+	return TEST_SKIP;
+}
+#endif
+
 static struct test_case tests__symbols[] = {
 	TEST_CASE("Symbols", symbols),
 	TEST_CASE("Kallsyms symbol ends", kallsyms_fixup_end),
+	TEST_CASE("ELF zero-size symbol end across .symtab and .dynsym",
+		  elf_symtab_dynsym_fixup_end),
 	{ .name = NULL, }
 };
 
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 1e2716c6af45..77ef5b2dbf32 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1789,21 +1789,6 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		nr++;
 	}
 	dso__put(curr_dso);
-
-	/*
-	 * For misannotated, zeroed, ASM function sizes.
-	 */
-	if (nr > 0) {
-		symbols__fixup_end(dso__symbols(dso), false);
-		symbols__fixup_duplicate(dso__symbols(dso));
-		if (kmap) {
-			/*
-			 * We need to fixup this here too because we create new
-			 * maps here, for things like vsyscall sections.
-			 */
-			maps__fixup_end(kmaps);
-		}
-	}
 	return nr;
 out_elf_end:
 	dso__put(curr_dso);
@@ -1864,6 +1849,27 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		nr += err;
 	}
 
+	/*
+	 * For misannotated, zeroed, ASM function sizes. Run after all symbol
+	 * tables (.symtab, .dynsym, .gnu_debugdata) have been loaded so a
+	 * zero-size symbol in .symtab ends at the next symbol across all
+	 * tables rather than overlapping a .dynsym-only function.
+	 */
+	if (nr > 0) {
+		struct kmap *kmap = dso__kernel(dso) ? map__kmap(map) : NULL;
+		struct maps *kmaps = kmap ? map__kmaps(map) : NULL;
+
+		symbols__fixup_end(dso__symbols(dso), false);
+		symbols__fixup_duplicate(dso__symbols(dso));
+		if (kmap) {
+			/*
+			 * We need to fixup this here too because we create new
+			 * maps here, for things like vsyscall sections.
+			 */
+			maps__fixup_end(kmaps);
+		}
+	}
+
 	return nr;
 }
 
-- 
2.56.0.317.g454f8302e1-goog

