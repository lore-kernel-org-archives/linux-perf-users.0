From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 3/3] perf report: don't crash on invalid inline debug
 information
Date: Thu, 27 Sep 2018 16:10:37 -0300
Message-ID: <20180927191037.GG25764@kernel.org>
References: <20180926135207.30263-1-milian.wolff@kdab.com>
 <20180926135207.30263-3-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180926135207.30263-3-milian.wolff@kdab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: jolsa@kernel.org, yao.jin@linux.intel.com, namhyung@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Sep 26, 2018 at 03:52:07PM +0200, Milian Wolff escreveu:
> When the function name for an inline frame is invalid, we must
> not try to demangle this symbol, otherwise we crash with:
> 
> #0  0x0000555555895c01 in bfd_demangle ()
> #1  0x0000555555823262 in demangle_sym (dso=0x555555d92b90, elf_name=0x0, kmodule=0) at util/symbol-elf.c:215
> #2  dso__demangle_sym (dso=dso@entry=0x555555d92b90, kmodule=<optimized out>, kmodule@entry=0, elf_name=elf_name@entry=0x0) at util/symbol-elf.c:400
> #3  0x00005555557fef4b in new_inline_sym (funcname=0x0, base_sym=0x555555d92b90, dso=0x555555d92b90) at util/srcline.c:89
> #4  inline_list__append_dso_a2l (dso=dso@entry=0x555555c7bb00, node=node@entry=0x555555e31810, sym=sym@entry=0x555555d92b90) at util/srcline.c:264
> #5  0x00005555557ff27f in addr2line (dso_name=dso_name@entry=0x555555d92430 "/home/milian/.debug/.build-id/f7/186d14bb94f3c6161c010926da66033d24fce5/elf", addr=addr@entry=2888, file=file@entry=0x0,
>     line=line@entry=0x0, dso=dso@entry=0x555555c7bb00, unwind_inlines=unwind_inlines@entry=true, node=0x555555e31810, sym=0x555555d92b90) at util/srcline.c:313
> #6  0x00005555557ffe7c in addr2inlines (sym=0x555555d92b90, dso=0x555555c7bb00, addr=2888, dso_name=0x555555d92430 "/home/milian/.debug/.build-id/f7/186d14bb94f3c6161c010926da66033d24fce5/elf")
>     at util/srcline.c:358
> 
> So instead handle the case where we get invalid function names
> for inlined frames and use a fallback '??' function name instead.
> 
> While this crash was originally reported by Hadrien for rust code,
> I can now also reproduce it with trivial C++ code. Indeed, it seems
> like libbfd fails to interpret the debug information for the inline
> frame symbol name:
> 
> $ addr2line -e /home/milian/.debug/.build-id/f7/186d14bb94f3c6161c010926da66033d24fce5/elf -if b48
> main
> /usr/include/c++/8.2.1/complex:610
> ??
> /usr/include/c++/8.2.1/complex:618
> ??
> /usr/include/c++/8.2.1/complex:675
> ??
> /usr/include/c++/8.2.1/complex:685
> main
> /home/milian/projects/kdab/rnd/hotspot/tests/test-clients/cpp-inlining/main.cpp:39
> 
> I've reported this bug upstream and also attached a patch there
> which should fix this issue:
> https://sourceware.org/bugzilla/show_bug.cgi?id=23715

Millian, what about this one, which is the cset it is fixing?

- Arnaldo
 
> Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Reported-by: Hadrien Grasland <grasland@lal.in2p3.fr>
> ---
>  tools/perf/util/srcline.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> index 09d6746e6ec8..e767c4a9d4d2 100644
> --- a/tools/perf/util/srcline.c
> +++ b/tools/perf/util/srcline.c
> @@ -85,6 +85,9 @@ static struct symbol *new_inline_sym(struct dso *dso,
>  	struct symbol *inline_sym;
>  	char *demangled = NULL;
>  
> +	if (!funcname)
> +		funcname = "??";
> +
>  	if (dso) {
>  		demangled = dso__demangle_sym(dso, 0, funcname);
>  		if (demangled)
> -- 
> 2.19.0
