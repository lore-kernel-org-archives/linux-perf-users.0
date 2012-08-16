From: Koteswararao Nelakurthi <knelakurthi@mvista.com>
Subject: Re: Perf tool cross build issue
Date: Thu, 16 Aug 2012 12:17:52 +0900
Message-ID: <CAAo=-0bfY6ZeTbaM9OiL8=1KY-FXWwp9f1JN2qmmeEiY_fJsHw@mail.gmail.com>
References: <CAAo=-0a74sJ1TieeCH81K+gKFaiKNAKLKL-eiDp-jYnGJVjkbg@mail.gmail.com>
	<87628joexe.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:63043 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884Ab2HPDRx (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 15 Aug 2012 23:17:53 -0400
Received: by vbbff1 with SMTP id ff1so2056112vbb.19
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Aug 2012 20:17:52 -0700 (PDT)
In-Reply-To: <87628joexe.fsf@sejong.aot.lge.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org

Dear Kim,

Thanks for your reply.
I am using 2.6.35 since it is my base kernel, and i have to cross check
perf in that kernel only.
That's why i requested..the info for how to compile perf with out any issues
Any inputs regarding changes to Makefile to build perf successfully?

Anyway..thanks for your information

Regards
koteswararao.

On Thu, Aug 16, 2012 at 9:31 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> Hi, Koteswararao
>
> On Tue, 14 Aug 2012 12:00:12 +0900, Koteswararao Nelakurthi wrote:
>> Dear Perf developers,
>>
>>
>> I am trying to cross compile Perf source present in 2.6.35/tools/perf
>
> 2.6.35? That's too old. Can't you try it with more recent version?
>
> Thanks,
> Namhyung
>
>
>> directory for ARM.in ubuntu machine.(x86 is host machine).But i am
>> facing the following compilation error as compiler looks at host
>> specific header files instead of looking at header files present in
>> perf/ directory..Please provide Makefile changes required to compile
>> successfully perf for ARM.{{{
>>
>> perf>make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi-
>>
>> Makefile:629: No bfd.h/libbfd found, install
>> binutils-dev[el]/zlib-static to gain symbol demangling
>>
>>                CC
>> /home/caveo/20120807_work/mvlinux/tools/perf/builtin-annotate.o
>>
>> In file included from builtin-annotate.c:22:
>>
>> util/parse-options.h:86: error: redefinition of 'struct option'
>>
>> In file included from builtin-annotate.c:26:
>>
>> util/hist.h:119: fatal error: newt.h: No such file or directory
>> compilation terminated.
>> make: *** [/home/caveo/20120807_work/mvlinux/tools/perf/builtin-annotate.o]
>> Error 1
>>
>> }}}
>>
>> Thanks for your help in advance.
>>
>> Regards
>> koteswararao
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
