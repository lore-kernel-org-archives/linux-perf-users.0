From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Perf tool cross build issue
Date: Thu, 16 Aug 2012 09:31:41 +0900
Message-ID: <87628joexe.fsf@sejong.aot.lge.com>
References: <CAAo=-0a74sJ1TieeCH81K+gKFaiKNAKLKL-eiDp-jYnGJVjkbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE6Q.lge.com ([156.147.1.121]:61207 "EHLO
	LGEMRELSE6Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755154Ab2HPAiA (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 15 Aug 2012 20:38:00 -0400
In-Reply-To: <CAAo=-0a74sJ1TieeCH81K+gKFaiKNAKLKL-eiDp-jYnGJVjkbg@mail.gmail.com>
	(Koteswararao Nelakurthi's message of "Tue, 14 Aug 2012 12:00:12
	+0900")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Koteswararao Nelakurthi <knelakurthi@mvista.com>
Cc: linux-perf-users@vger.kernel.org

Hi, Koteswararao

On Tue, 14 Aug 2012 12:00:12 +0900, Koteswararao Nelakurthi wrote:
> Dear Perf developers,
>
>
> I am trying to cross compile Perf source present in 2.6.35/tools/perf

2.6.35? That's too old. Can't you try it with more recent version?

Thanks,
Namhyung


> directory for ARM.in ubuntu machine.(x86 is host machine).But i am
> facing the following compilation error as compiler looks at host
> specific header files instead of looking at header files present in
> perf/ directory..Please provide Makefile changes required to compile
> successfully perf for ARM.{{{
>
> perf>make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi-
>
> Makefile:629: No bfd.h/libbfd found, install
> binutils-dev[el]/zlib-static to gain symbol demangling
>
>                CC
> /home/caveo/20120807_work/mvlinux/tools/perf/builtin-annotate.o
>
> In file included from builtin-annotate.c:22:
>
> util/parse-options.h:86: error: redefinition of 'struct option'
>
> In file included from builtin-annotate.c:26:
>
> util/hist.h:119: fatal error: newt.h: No such file or directory
> compilation terminated.
> make: *** [/home/caveo/20120807_work/mvlinux/tools/perf/builtin-annotate.o]
> Error 1
>
> }}}
>
> Thanks for your help in advance.
>
> Regards
> koteswararao
