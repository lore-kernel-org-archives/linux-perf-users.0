From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] Correctly handle symbols in VDSO
Date: Mon, 07 Apr 2014 15:14:17 +0900
Message-ID: <87eh19y8cm.fsf@sejong.aot.lge.com>
References: <D6A5CDD8-F8F1-4C9D-8BCF-83A739FD6A2F@tbricks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE6Q.lge.com ([156.147.1.121]:54863 "EHLO
	lgemrelse6q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743AbaDGGOW (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 7 Apr 2014 02:14:22 -0400
In-Reply-To: <D6A5CDD8-F8F1-4C9D-8BCF-83A739FD6A2F@tbricks.com> (Vladimir
	Nikulichev's message of "Tue, 1 Apr 2014 23:15:14 +0400")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vladimir Nikulichev <nvs@tbricks.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>

Hi Vladimir,

On Tue, 1 Apr 2014 23:15:14 +0400, Vladimir Nikulichev wrote:
> pert-report doesn't resolve function names in VDSO:
>
> $ perf report --stdio -g flat,0.0,15,callee --sort pid
> ...
>              8.76%
>                 0x7fff6b1fe861
>                 __gettimeofday
>                 ACE_OS::gettimeofday()
> ...
>
> In this case symbol values should be adjusted the same way as for executables, relocatable objects and prelinked libraries.
>
> After fix:
>
> $ perf report --stdio -g flat,0.0,15,callee --sort pid
> ...
>              8.76%
>                 __vdso_gettimeofday
>                 __gettimeofday
>                 ACE_OS::gettimeofday()
> ...

Tested-by: Namhyung Kim <namhyung@kernel.org>

Just one question below..

>
> ---------------------------------------------------------------------------------------------------------------------------
>
> perf tools: Adjust symbols in VDSO
>
> Signed-off-by: Vladimir Nikulichev <nvs@tbricks.com>
>
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 3b7dbf5..9c8b23b 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -6,6 +6,7 @@
>  #include <inttypes.h>
>
>  #include "symbol.h"
> +#include "vdso.h"
>  #include <symbol/kallsyms.h>
>  #include "debug.h"
>
> @@ -618,6 +619,8 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
>  		GElf_Shdr shdr;
>  		ss->adjust_symbols = (ehdr.e_type == ET_EXEC ||
>  				ehdr.e_type == ET_REL ||
> +				(dso->symsrc_filename == NULL &&

Is this really needed?  Just checking is_vdso_map() seems to work well
for me.  Did you have a specific reason to add it?

Thanks,
Namhyung


> +					is_vdso_map(dso->short_name)) ||
>  				elf_section_by_name(elf, &ehdr, &shdr,
>  						     ".gnu.prelink_undo",
>  						     NULL) != NULL);--
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
