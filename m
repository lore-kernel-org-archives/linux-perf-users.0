From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] Correctly handle symbols in VDSO
Date: Tue, 8 Apr 2014 17:41:01 +0200
Message-ID: <20140408154101.GA21094@krava.brq.redhat.com>
References: <D6A5CDD8-F8F1-4C9D-8BCF-83A739FD6A2F@tbricks.com>
 <87eh19y8cm.fsf@sejong.aot.lge.com>
 <3C60FB26-A78B-4E37-B4A6-E6F7283CEB4C@tbricks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3C60FB26-A78B-4E37-B4A6-E6F7283CEB4C@tbricks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vladimir Nikulichev <nvs@tbricks.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Tue, Apr 08, 2014 at 07:24:22PM +0400, Vladimir Nikulichev wrote:
> Hi Namhyung,
> 
> On Apr 7, 2014, at 10:14 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > Just one question below..
> > 
> >> 
> >> ---------------------------------------------------------------------------------------------------------------------------
> >> 
> >> perf tools: Adjust symbols in VDSO
> >> 
> >> Signed-off-by: Vladimir Nikulichev <nvs@tbricks.com>
> >> 
> >> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> >> index 3b7dbf5..9c8b23b 100644
> >> --- a/tools/perf/util/symbol-elf.c
> >> +++ b/tools/perf/util/symbol-elf.c
> >> @@ -6,6 +6,7 @@
> >> #include <inttypes.h>
> >> 
> >> #include "symbol.h"
> >> +#include "vdso.h"
> >> #include <symbol/kallsyms.h>
> >> #include "debug.h"
> >> 
> >> @@ -618,6 +619,8 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
> >> 		GElf_Shdr shdr;
> >> 		ss->adjust_symbols = (ehdr.e_type == ET_EXEC ||
> >> 				ehdr.e_type == ET_REL ||
> >> +				(dso->symsrc_filename == NULL &&
> > 
> > Is this really needed?  Just checking is_vdso_map() seems to work well
> > for me.  Did you have a specific reason to add it?
> > 
> 
> Nothing specific, just to don't call string operations in most cases. But here it is only a matter of coding style, of course.
> Attaching shorter version of the patch.
> 
> ----------------------------
> 
> perf tools: Adjust symbols in VDSO

hi,
could you please put explanation from first email
into the patch changelog?

cc-ing lkml

thanks,
jirka
