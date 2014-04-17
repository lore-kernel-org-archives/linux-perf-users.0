From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] perf tools: Adjust symbols in VDSO
Date: Thu, 17 Apr 2014 11:46:42 +0300
Message-ID: <534F94F2.7020402@intel.com>
References: <web-7508803@mx2.tbricks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:44368 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751454AbaDQIr1 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 17 Apr 2014 04:47:27 -0400
In-Reply-To: <web-7508803@mx2.tbricks.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vladimir Nikulichev <nvs@tbricks.com>, Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 04/11/2014 05:25 PM, Vladimir Nikulichev wrote:
> perf tools: Adjust symbols in VDSO
> 
> pert-report doesn't resolve function names in VDSO:
> 
> $ perf report --stdio -g flat,0.0,15,callee --sort pid
> ...
>             8.76%
>                0x7fff6b1fe861
>                __gettimeofday
>                ACE_OS::gettimeofday()
> ...
> 
> In this case symbol values should be adjusted the same way as for executables,
> relocatable objects and prelinked libraries.
> 
> After fix:
> 
> $ perf report --stdio -g flat,0.0,15,callee --sort pid
> ...
>             8.76%
>                __vdso_gettimeofday
>                __gettimeofday
>                ACE_OS::gettimeofday()
> 
> Signed-off-by: Vladimir Nikulichev <nvs@tbricks.com>

Annotation still doesn't work. but this is a start, so:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>


> 
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 3b7dbf5..6864661 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -6,6 +6,7 @@
> #include <inttypes.h>
> 
> #include "symbol.h"
> +#include "vdso.h"
> #include <symbol/kallsyms.h>
> #include "debug.h"
> 
> @@ -618,6 +619,7 @@ int symsrc__init(struct symsrc *ss, struct dso *dso,
> const char *name,
>         GElf_Shdr shdr;
>         ss->adjust_symbols = (ehdr.e_type == ET_EXEC ||
>                 ehdr.e_type == ET_REL ||
> +                is_vdso_map(dso->short_name) ||
>                 elf_section_by_name(elf, &ehdr, &shdr,
>                              ".gnu.prelink_undo",
>                              NULL) != NULL);
