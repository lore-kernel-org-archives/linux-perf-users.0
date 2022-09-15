Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17C3ECAAD3
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Sep 2022 09:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiIOJ3l (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Sep 2022 05:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiIOJ3c (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Sep 2022 05:29:32 -0400
Received: from mail.kdab.com (mail.kdab.com [176.9.126.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968EC559A
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Sep 2022 02:29:29 -0700 (PDT)
Authentication-Results: mail.kdab.com (amavisd-new); dkim=pass (1024-bit key)
 reason="pass (just generated,
 assumed good)" header.d=kdab.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdab.com; h=
 content-transfer-encoding:mime-version:message-id:date:date
 :subject:subject:from:from; s=dkim; t=1663234166; x=1664098167;
 bh=oY3D8H/4R0xq3XPM/3DyyNJelFWHJLyr5+Ksu4cRmwk=; b=AzTgOyLNTWQ2
 FwHMs/6sVzB7Ny1r+Ns2XZWLl3HE5quVUi/zWPbpoUX61nHXR6PdhohwutIKi/AO
 QpBdOj8N8lf8629F2ixDleaIYZondXy1aHvtfedr9YdUWYlzFoNfdOFM5Z6D3RkL
 Ktrru3uvt3fu2qfmcUDGk0tQpzLA83k=
X-Virus-Scanned: amavisd-new at kdab.com
From:   Lieven Hey <lieven.hey@kdab.com>
To:     acme@kernel.org, linux-perf-users@vger.kernel.org
Cc:     Lieven Hey <lieven.hey@kdab.com>, Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2] perf jit: Include program header in elf files
Date:   Thu, 15 Sep 2022 11:29:10 +0200
Message-Id: <20220915092910.711036-1-lieven.hey@kdab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The missing header makes it hard for programs like elfutils to open
these files.

Fixes: 2d86612aacb7805f ("perf symbol: Correct address for bss symbols")
Signed-off-by: Lieven Hey <lieven.hey@kdab.com>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/genelf.c | 14 ++++++++++++++
 tools/perf/util/genelf.h |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
index 953338b9e887..02cd9f75e3d2 100644
--- a/tools/perf/util/genelf.c
+++ b/tools/perf/util/genelf.c
@@ -251,6 +251,7 @@ jit_write_elf(int fd, uint64_t load_addr, const char =
*sym,
 	Elf_Data *d;
 	Elf_Scn *scn;
 	Elf_Ehdr *ehdr;
+	Elf_Phdr *phdr;
 	Elf_Shdr *shdr;
 	uint64_t eh_frame_base_offset;
 	char *strsym =3D NULL;
@@ -285,6 +286,19 @@ jit_write_elf(int fd, uint64_t load_addr, const char=
 *sym,
 	ehdr->e_version =3D EV_CURRENT;
 	ehdr->e_shstrndx=3D unwinding ? 4 : 2; /* shdr index for section name *=
/
=20
+	/*
+	 * setup program header
+	 */
+	phdr =3D elf_newphdr(e, 1);
+	phdr[0].p_type =3D PT_LOAD;
+	phdr[0].p_offset =3D 0;
+	phdr[0].p_vaddr =3D 0;
+	phdr[0].p_paddr =3D 0;
+	phdr[0].p_filesz =3D csize;
+	phdr[0].p_memsz =3D csize;
+	phdr[0].p_flags =3D PF_X | PF_R;
+	phdr[0].p_align =3D 8;
+
 	/*
 	 * setup text section
 	 */
diff --git a/tools/perf/util/genelf.h b/tools/perf/util/genelf.h
index ae138afe6c56..b5c909546e3f 100644
--- a/tools/perf/util/genelf.h
+++ b/tools/perf/util/genelf.h
@@ -53,8 +53,10 @@ int jit_add_debug_info(Elf *e, uint64_t code_addr, voi=
d *debug, int nr_debug_ent
=20
 #if GEN_ELF_CLASS =3D=3D ELFCLASS64
 #define elf_newehdr	elf64_newehdr
+#define elf_newphdr	elf64_newphdr
 #define elf_getshdr	elf64_getshdr
 #define Elf_Ehdr	Elf64_Ehdr
+#define Elf_Phdr	Elf64_Phdr
 #define Elf_Shdr	Elf64_Shdr
 #define Elf_Sym		Elf64_Sym
 #define ELF_ST_TYPE(a)	ELF64_ST_TYPE(a)
@@ -62,8 +64,10 @@ int jit_add_debug_info(Elf *e, uint64_t code_addr, voi=
d *debug, int nr_debug_ent
 #define ELF_ST_VIS(a)	ELF64_ST_VISIBILITY(a)
 #else
 #define elf_newehdr	elf32_newehdr
+#define elf_newphdr	elf32_newphdr
 #define elf_getshdr	elf32_getshdr
 #define Elf_Ehdr	Elf32_Ehdr
+#define Elf_Phdr	Elf32_Phdr
 #define Elf_Shdr	Elf32_Shdr
 #define Elf_Sym		Elf32_Sym
 #define ELF_ST_TYPE(a)	ELF32_ST_TYPE(a)
--=20
2.37.3
