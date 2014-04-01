From: Vladimir Nikulichev <nvs@tbricks.com>
Subject: [PATCH] Correctly handle symbols in VDSO
Date: Tue, 1 Apr 2014 23:15:14 +0400
Message-ID: <D6A5CDD8-F8F1-4C9D-8BCF-83A739FD6A2F@tbricks.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:33263 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbaDATPR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 1 Apr 2014 15:15:17 -0400
Received: by mail-wi0-f170.google.com with SMTP id bs8so5353172wib.5
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Apr 2014 12:15:16 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>

pert-report doesn't resolve function names in VDSO:

$ perf report --stdio -g flat,0.0,15,callee --sort pid
...
             8.76%
                0x7fff6b1fe861
                __gettimeofday
                ACE_OS::gettimeofday()
...

In this case symbol values should be adjusted the same way as for executables, relocatable objects and prelinked libraries.

After fix:

$ perf report --stdio -g flat,0.0,15,callee --sort pid
...
             8.76%
                __vdso_gettimeofday
                __gettimeofday
                ACE_OS::gettimeofday()
...

---------------------------------------------------------------------------------------------------------------------------

perf tools: Adjust symbols in VDSO

Signed-off-by: Vladimir Nikulichev <nvs@tbricks.com>

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 3b7dbf5..9c8b23b 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -6,6 +6,7 @@
 #include <inttypes.h>

 #include "symbol.h"
+#include "vdso.h"
 #include <symbol/kallsyms.h>
 #include "debug.h"

@@ -618,6 +619,8 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 		GElf_Shdr shdr;
 		ss->adjust_symbols = (ehdr.e_type == ET_EXEC ||
 				ehdr.e_type == ET_REL ||
+				(dso->symsrc_filename == NULL &&
+					is_vdso_map(dso->short_name)) ||
 				elf_section_by_name(elf, &ehdr, &shdr,
 						     ".gnu.prelink_undo",
 						     NULL) != NULL);