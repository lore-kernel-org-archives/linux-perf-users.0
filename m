From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 7/7] perf test: Fix vmlinux failure on s390x part 2
Date: Fri, 29 Sep 2017 13:00:17 -0300
Message-ID: <20170929160017.29335-8-acme@kernel.org>
References: <20170929160017.29335-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752535AbdI2QCA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 29 Sep 2017 12:02:00 -0400
In-Reply-To: <20170929160017.29335-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Thomas Richter <tmricht@linux.vnet.ibm.com>, Zvonko Kosic <zvonko.kosic@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

On s390x perf test 1 failed. It turned out that commit cf6383f73cf2
("perf report: Fix kernel symbol adjustment for s390x") was incorrect.

The previous implementation in dso__load_sym() is also suitable for
s390x.

Therefore this patch undoes commit cf6383f73cf2

Signed-off-by: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: Zvonko Kosic <zvonko.kosic@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Fixes: cf6383f73cf2 ("perf report: Fix kernel symbol adjustment for s390x")
LPU-Reference: 20170915071404.58398-2-tmricht@linux.vnet.ibm.com
Link: http://lkml.kernel.org/n/tip-v101o8k25vuja2ogosgf15yy@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/util/Build          |  1 -
 tools/perf/arch/s390/util/sym-handling.c | 21 ---------------------
 2 files changed, 22 deletions(-)
 delete mode 100644 tools/perf/arch/s390/util/sym-handling.c

diff --git a/tools/perf/arch/s390/util/Build b/tools/perf/arch/s390/util/Build
index bd518b623d7a..5bd7b9260cc0 100644
--- a/tools/perf/arch/s390/util/Build
+++ b/tools/perf/arch/s390/util/Build
@@ -1,5 +1,4 @@
 libperf-y += header.o
-libperf-y += sym-handling.o
 libperf-y += kvm-stat.o
 
 libperf-$(CONFIG_DWARF) += dwarf-regs.o
diff --git a/tools/perf/arch/s390/util/sym-handling.c b/tools/perf/arch/s390/util/sym-handling.c
deleted file mode 100644
index 581d4c5a896b..000000000000
--- a/tools/perf/arch/s390/util/sym-handling.c
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * Architecture specific ELF symbol handling and relocation mapping.
- *
- * Copyright 2017 IBM Corp.
- * Author(s): Thomas Richter <tmricht@linux.vnet.ibm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
- */
-
-#include "symbol.h"
-
-#ifdef HAVE_LIBELF_SUPPORT
-bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
-{
-	if (ehdr.e_type == ET_EXEC)
-		return false;
-	return ehdr.e_type == ET_REL || ehdr.e_type == ET_DYN;
-}
-#endif
-- 
2.13.5
