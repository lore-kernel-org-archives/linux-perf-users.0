From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 2/2] perf test: fix vmlinux failure on s390x part 2
Date: Fri, 15 Sep 2017 09:14:04 +0200
Message-ID: <20170915071404.58398-2-tmricht@linux.vnet.ibm.com>
References: <20170915071404.58398-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750865AbdIOHOe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Sep 2017 03:14:34 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8F7EXB4108445
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Sep 2017 03:14:34 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2d05x1bcdu-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Sep 2017 03:14:33 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Fri, 15 Sep 2017 08:14:19 +0100
In-Reply-To: <20170915071404.58398-1-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: =brueckner@linux.vnet.ibm.com, =zvonko.kosic@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>

On s390x perf test 1 failed. It turned out that commit cf6383f73cf2
("perf report: Fix kernel symbol adjustment for s390x") was incorrect.
The previous implementation in dso__load_sym() is also
suitable for s390x.
Therefore this patch undoes commit cf6383f73cf2

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 tools/perf/arch/s390/util/Build          |  1 -
 tools/perf/arch/s390/util/sym-handling.c | 21 ---------------------
 2 files changed, 22 deletions(-)
 delete mode 100644 tools/perf/arch/s390/util/sym-handling.c

diff --git a/tools/perf/arch/s390/util/Build b/tools/perf/arch/s390/util/Build
index bd518b6..5bd7b92 100644
--- a/tools/perf/arch/s390/util/Build
+++ b/tools/perf/arch/s390/util/Build
@@ -1,5 +1,4 @@
 libperf-y += header.o
-libperf-y += sym-handling.o
 libperf-y += kvm-stat.o
 
 libperf-$(CONFIG_DWARF) += dwarf-regs.o
diff --git a/tools/perf/arch/s390/util/sym-handling.c b/tools/perf/arch/s390/util/sym-handling.c
deleted file mode 100644
index 581d4c5..0000000
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
2.9.3
