From: Arnaldo Carvalho de Melo <acme@infradead.org>
Subject: Re: Perf tool cross build issue
Date: Mon, 20 Aug 2012 11:08:39 -0300
Message-ID: <20120820140839.GC3046@infradead.org>
References: <CAAo=-0a74sJ1TieeCH81K+gKFaiKNAKLKL-eiDp-jYnGJVjkbg@mail.gmail.com>
 <87628joexe.fsf@sejong.aot.lge.com>
 <CAAo=-0bfY6ZeTbaM9OiL8=1KY-FXWwp9f1JN2qmmeEiY_fJsHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:53724 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754034Ab2HTOIr (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 20 Aug 2012 10:08:47 -0400
Content-Disposition: inline
In-Reply-To: <CAAo=-0bfY6ZeTbaM9OiL8=1KY-FXWwp9f1JN2qmmeEiY_fJsHw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Koteswararao Nelakurthi <knelakurthi@mvista.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org

Em Thu, Aug 16, 2012 at 12:17:52PM +0900, Koteswararao Nelakurthi escreveu:
> Dear Kim,
> 
> Thanks for your reply.
> I am using 2.6.35 since it is my base kernel, and i have to cross check
> perf in that kernel only.
> That's why i requested..the info for how to compile perf with out any issues
> Any inputs regarding changes to Makefile to build perf successfully?
> 
> Anyway..thanks for your information

You can try building a recent perf and then using it on that old kernel,
there is no need to tie perf/kernel versions, the tool notices if
features it tries to use are not present on the kernel it is being run
and acts accordingly, falling back to using the features present in
older kernels.

If it doesn't work like that, we'd like to know.

So please grab the latest kernel sources and build the tool, then
transfer the binary to your target machine and try it.

If it still doesn't build, please report here.

- Arnaldo
 
> Regards
> koteswararao.
> 
> On Thu, Aug 16, 2012 at 9:31 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> > Hi, Koteswararao
> >
> > On Tue, 14 Aug 2012 12:00:12 +0900, Koteswararao Nelakurthi wrote:
> >> Dear Perf developers,
> >>
> >>
> >> I am trying to cross compile Perf source present in 2.6.35/tools/perf
> >
> > 2.6.35? That's too old. Can't you try it with more recent version?
> >
> > Thanks,
> > Namhyung
> >
> >
> >> directory for ARM.in ubuntu machine.(x86 is host machine).But i am
> >> facing the following compilation error as compiler looks at host
> >> specific header files instead of looking at header files present in
> >> perf/ directory..Please provide Makefile changes required to compile
> >> successfully perf for ARM.{{{
> >>
> >> perf>make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi-
> >>
> >> Makefile:629: No bfd.h/libbfd found, install
> >> binutils-dev[el]/zlib-static to gain symbol demangling
> >>
> >>                CC
> >> /home/caveo/20120807_work/mvlinux/tools/perf/builtin-annotate.o
> >>
> >> In file included from builtin-annotate.c:22:
> >>
> >> util/parse-options.h:86: error: redefinition of 'struct option'
> >>
> >> In file included from builtin-annotate.c:26:
> >>
> >> util/hist.h:119: fatal error: newt.h: No such file or directory
> >> compilation terminated.
> >> make: *** [/home/caveo/20120807_work/mvlinux/tools/perf/builtin-annotate.o]
> >> Error 1
> >>
> >> }}}
> >>
> >> Thanks for your help in advance.
> >>
> >> Regards
> >> koteswararao
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
