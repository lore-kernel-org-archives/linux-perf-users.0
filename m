From: "Wangnan (F)" <wangnan0@huawei.com>
Subject: Re: cross compiling perf
Date: Mon, 20 Jun 2016 09:56:09 +0800
Message-ID: <57674D39.1000104@huawei.com>
References: <16135005.c00Xa53Rc9@milian-kdab2>
 <20160616161111.GA13337@kernel.org> <29350352.ftQorT9lcR@agathebauer>
 <20160617110056.GJ13337@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:32144 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbcFTB5V (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 19 Jun 2016 21:57:21 -0400
In-Reply-To: <20160617110056.GJ13337@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Milian Wolff <milian.wolff@kdab.com>, jiri@infradead.org, He Kuang <hekuang@huawei.com>
Cc: linux-perf-users@vger.kernel.org



On 2016/6/17 19:00, Arnaldo Carvalho de Melo wrote:
> Adding some folks to the CC list, that either worked on the make
> infrastructure or that I know works with cross compiling environments,
> maybe they can help.
>
> More below.
>
> Em Fri, Jun 17, 2016 at 11:49:28AM +0200, Milian Wolff escreveu:
>> On Donnerstag, 16. Juni 2016 13:11:11 CEST Arnaldo Carvalho de Melo wrote:
>>> Em Wed, Jun 15, 2016 at 04:24:52PM +0200, Milian Wolff escreveu:
>>>> I'm trying to compile a more modern version of the user-space perf tools
>>>> for an arm64 embedded target. So far, no cigar.
>>>>
>>>> Neither tools/build/Documentation nor tools/perf/Documentation/Build.txt
>>>> explain how this should be done. Right now, I'm trying the following from
>>>> an SDK with an environment that already sets up CC, CFLAGS etc. pp.
>>>>
>>>> [SDK] ~/milian/linux/tools/perf$ make ARCH=arm64 CROSS_COMPILE=/home/sdk/
>>>> sysroots/x86_64-oesdk-linux/usr/bin/aarch64-gnu-linux/aarch64-gnu-linux-
>>>> CFLAGS="--sysroot=/home/sdk/sysroots/aarch64-gnu-linux
>>>> -I/home/milian/target- prefix/include -L/home/milian/target-prefix/lib
>>>> $CFLAGS"
>>>>
>>>>    BUILD:   Doing 'make -j8' parallel build
>>>>
>>>> Auto-detecting system features:
>>>> ...                         dwarf: [ OFF ]
>>>> ...            dwarf_getlocations: [ OFF ]
>>>> ...                         glibc: [ OFF ]
>>>> ...                          gtk2: [ OFF ]
>>>> ...                      libaudit: [ OFF ]
>>>> ...                        libbfd: [ OFF ]
>>>> ...                        libelf: [ OFF ]
>>>> ...                       libnuma: [ OFF ]
>>>> ...        numa_num_possible_cpus: [ OFF ]
>>>> ...                       libperl: [ OFF ]
>>>> ...                     libpython: [ OFF ]
>>>> ...                      libslang: [ OFF ]
>>>> ...                     libcrypto: [ OFF ]
>>>> ...                     libunwind: [ OFF ]
>>>> ...            libdw-dwarf-unwind: [ OFF ]
>>>> ...                          zlib: [ OFF ]
>>>> ...                          lzma: [ OFF ]
>>>> ...                     get_cpuid: [ OFF ]
>>>> ...                           bpf: [ OFF ]
>>>>
>>>> config/Makefile:272: *** No gnu/libc-version.h found, please install
>>>> glibc-
>>>> dev[el].  Stop

I think this error message is missleading. Let's see source code:

ifdef NO_LIBELF
   ...
else
   ifeq ($(feature-libelf), 0)
     ifeq ($(feature-glibc), 1)
       LIBC_SUPPORT := 1
     endif
     ifeq ($(BIONIC),1)
       LIBC_SUPPORT := 1
     endif
     ifeq ($(LIBC_SUPPORT),1)
       ...
     else
       ifneq ($(filter s% -static%,$(LDFLAGS),),)
         msg := $(error No static glibc found, please install glibc-static);
       else
         msg := $(error No gnu/libc-version.h found, please install 
glibc-dev[el]);
       endif
     endif
   else
     ...
   endif # libelf support
endif # NO_LIBELF

So the 'libc-version.h' error message really means the failure of 
feature-glibc detector.
There's many reasons cause libc detector fail. 'libc-version.h' in error 
message provides
wrong clue, lead user to check this file instead of checking feature 
check result.

Thank you.

>>>> How can I figure out where perf's buildsystem is looking for the
>>>> dependencies? How can I configure it to look into both, my sysroot as
>>>> well as a secondary path that contains some additional software I
>>>> compiled manually?
>>>
[SNIP]
