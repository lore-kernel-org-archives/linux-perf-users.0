From: Vladimir Nikulichev <nvs@tbricks.com>
Subject: Re: [PATCH] Correctly handle symbols in VDSO
Date: Tue, 8 Apr 2014 19:24:22 +0400
Message-ID: <3C60FB26-A78B-4E37-B4A6-E6F7283CEB4C@tbricks.com>
References: <D6A5CDD8-F8F1-4C9D-8BCF-83A739FD6A2F@tbricks.com> <87eh19y8cm.fsf@sejong.aot.lge.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:34550 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932399AbaDHPYZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 8 Apr 2014 11:24:25 -0400
Received: by mail-ee0-f49.google.com with SMTP id c41so807798eek.22
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Apr 2014 08:24:24 -0700 (PDT)
In-Reply-To: <87eh19y8cm.fsf@sejong.aot.lge.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>

Hi Namhyung,

On Apr 7, 2014, at 10:14 AM, Namhyung Kim <namhyung@kernel.org> wrote:

> Just one question below..
> 
>> 
>> ---------------------------------------------------------------------------------------------------------------------------
>> 
>> perf tools: Adjust symbols in VDSO
>> 
>> Signed-off-by: Vladimir Nikulichev <nvs@tbricks.com>
>> 
>> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
>> index 3b7dbf5..9c8b23b 100644
>> --- a/tools/perf/util/symbol-elf.c
>> +++ b/tools/perf/util/symbol-elf.c
>> @@ -6,6 +6,7 @@
>> #include <inttypes.h>
>> 
>> #include "symbol.h"
>> +#include "vdso.h"
>> #include <symbol/kallsyms.h>
>> #include "debug.h"
>> 
>> @@ -618,6 +619,8 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
>> 		GElf_Shdr shdr;
>> 		ss->adjust_symbols = (ehdr.e_type == ET_EXEC ||
>> 				ehdr.e_type == ET_REL ||
>> +				(dso->symsrc_filename == NULL &&
> 
> Is this really needed?  Just checking is_vdso_map() seems to work well
> for me.  Did you have a specific reason to add it?
> 

Nothing specific, just to don't call string operations in most cases. But here it is only a matter of coding style, of course.
Attaching shorter version of the patch.

----------------------------

perf tools: Adjust symbols in VDSO

Signed-off-by: Vladimir Nikulichev <nvs@tbricks.com>

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 3b7dbf5..6864661 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -6,6 +6,7 @@
 #include <inttypes.h>

 #include "symbol.h"
+#include "vdso.h"
 #include <symbol/kallsyms.h>
 #include "debug.h"

@@ -618,6 +619,7 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 		GElf_Shdr shdr;
 		ss->adjust_symbols = (ehdr.e_type == ET_EXEC ||
 				ehdr.e_type == ET_REL ||
+				is_vdso_map(dso->short_name) ||
 				elf_section_by_name(elf, &ehdr, &shdr,
 						     ".gnu.prelink_undo",
 						     NULL) != NULL);