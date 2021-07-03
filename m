Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF262C07E97
	for <linux-perf-users@archiver.kernel.org>; Sat,  3 Jul 2021 15:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9EB96161E
	for <linux-perf-users@archiver.kernel.org>; Sat,  3 Jul 2021 15:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhGCPiD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 3 Jul 2021 11:38:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:35994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229924AbhGCPiD (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 3 Jul 2021 11:38:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D8EF6161E;
        Sat,  3 Jul 2021 15:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625326529;
        bh=tS9//WzT5l76oJrWdPtooZEXhKPrvqWOWetH8EF9ECc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cpHKUDThrbCuUMCLNDb18TdLCitqznqCEWjev58affhL+3L6HRJsK4S0JNte6yeDh
         wNm3SxPsTFwmXYnsMMC2GRiWe5YHNwwEi3cJNahgREclkJpr5h7oxHt5kI4EbQJ0Ea
         bI2tRfrMial9iBE9gwfm/yY9rIreEAf7SMTANasQdC8ckqfILG97Vsm0sbK2QEuaWp
         FR4bH5fj+pWHsUvFvwuriHJtV34g1TAIyE2zcZ+Al2Kgr0w6snUNeShrmLOJDH6AIX
         B7qlgkxOMVDa1hUnfQo+ZR6rkAONVt5uvooz9z3ybusL3E9mVEnZX8iGUqOGqWih9b
         Ki4HjqVJUFd5w==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Stefan Liebler <stli@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] perf symbol-elf: Decode dynsym even if symtab exists
Date:   Sun,  4 Jul 2021 00:35:27 +0900
Message-Id: <162532652681.393143.10163733179955267999.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162532651032.393143.4602033845482295575.stgit@devnote2>
References: <162532651032.393143.4602033845482295575.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

In Fedora34, libc-2.33.so has both .dynsym and .symtab sections and
most of (not all) symbols moved to .dynsym. In this case, perf only
decode the symbols in .symtab, and perf probe can not list up the
functions in the library.

To fix this issue, decode both .symtab and .dynsym sections.

Without this fix,
  -----
  $ ./perf probe -x /usr/lib64/libc-2.33.so -F
  @plt
  @plt
  calloc@plt
  free@plt
  malloc@plt
  memalign@plt
  realloc@plt
  -----

With this fix.

  -----
  $ ./perf probe -x /usr/lib64/libc-2.33.so -F
  @plt
  @plt
  a64l
  abort
  abs
  accept
  accept4
  access
  acct
  addmntent
  -----

Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/symbol-elf.c |   82 ++++++++++++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index a73345730ba9..eb10b4e0d888 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1074,8 +1074,9 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 	return 0;
 }
 
-int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
-		  struct symsrc *runtime_ss, int kmodule)
+static int
+dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
+		       struct symsrc *runtime_ss, int kmodule, int dynsym)
 {
 	struct kmap *kmap = dso->kernel ? map__kmap(map) : NULL;
 	struct maps *kmaps = kmap ? map__kmaps(map) : NULL;
@@ -1098,34 +1099,15 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 	if (kmap && !kmaps)
 		return -1;
 
-	dso->symtab_type = syms_ss->type;
-	dso->is_64_bit = syms_ss->is_64_bit;
-	dso->rel = syms_ss->ehdr.e_type == ET_REL;
-
-	/*
-	 * Modules may already have symbols from kallsyms, but those symbols
-	 * have the wrong values for the dso maps, so remove them.
-	 */
-	if (kmodule && syms_ss->symtab)
-		symbols__delete(&dso->symbols);
-
-	if (!syms_ss->symtab) {
-		/*
-		 * If the vmlinux is stripped, fail so we will fall back
-		 * to using kallsyms. The vmlinux runtime symbols aren't
-		 * of much use.
-		 */
-		if (dso->kernel)
-			goto out_elf_end;
-
-		syms_ss->symtab  = syms_ss->dynsym;
-		syms_ss->symshdr = syms_ss->dynshdr;
-	}
-
 	elf = syms_ss->elf;
 	ehdr = syms_ss->ehdr;
-	sec = syms_ss->symtab;
-	shdr = syms_ss->symshdr;
+	if (dynsym) {
+		sec  = syms_ss->dynsym;
+		shdr = syms_ss->dynshdr;
+	} else {
+		sec =  syms_ss->symtab;
+		shdr = syms_ss->symshdr;
+	}
 
 	if (elf_section_by_name(runtime_ss->elf, &runtime_ss->ehdr, &tshdr,
 				".text", NULL))
@@ -1312,6 +1294,50 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 	return err;
 }
 
+int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
+		  struct symsrc *runtime_ss, int kmodule)
+{
+	int nr = 0;
+	int err = -1;
+
+	dso->symtab_type = syms_ss->type;
+	dso->is_64_bit = syms_ss->is_64_bit;
+	dso->rel = syms_ss->ehdr.e_type == ET_REL;
+
+	/*
+	 * Modules may already have symbols from kallsyms, but those symbols
+	 * have the wrong values for the dso maps, so remove them.
+	 */
+	if (kmodule && syms_ss->symtab)
+		symbols__delete(&dso->symbols);
+
+	if (!syms_ss->symtab) {
+		/*
+		 * If the vmlinux is stripped, fail so we will fall back
+		 * to using kallsyms. The vmlinux runtime symbols aren't
+		 * of much use.
+		 */
+		if (dso->kernel)
+			return err;
+	} else  {
+		err = dso__load_sym_internal(dso, map, syms_ss, runtime_ss,
+					     kmodule, 0);
+		if (err < 0)
+			return err;
+		nr = err;
+	}
+
+	if (syms_ss->dynsym) {
+		err = dso__load_sym_internal(dso, map, syms_ss, runtime_ss,
+					     kmodule, 1);
+		if (err < 0)
+			return err;
+		err += nr;
+	}
+
+	return err;
+}
+
 static int elf_read_maps(Elf *elf, bool exe, mapfn_t mapfn, void *data)
 {
 	GElf_Phdr phdr;

