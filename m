From: John Spencer <maillist-linux@barfooze.de>
Subject: Re: [PATCH 2/2] perf Makefile: default WERROR to off.
Date: Tue, 26 Aug 2014 14:11:51 +0200
Message-ID: <53FC7987.10509@barfooze.de>
References: <53FB9064.1050000@barfooze.de> <87oav7bv25.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from hindenburg.barfooze.de ([195.154.9.123]:39502 "EHLO
	hindenburg.barfooze.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932808AbaHZMOE (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 26 Aug 2014 08:14:04 -0400
In-Reply-To: <87oav7bv25.fsf@sejong.aot.lge.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

Namhyung Kim wrote:
> On Mon, 25 Aug 2014 21:37:08 +0200, John Spencer wrote:
>> From 4a72032828a6784d93f4becf723303a17d723544 Mon Sep 17 00:00:00 2001
>> From: John Spencer <maillist-linux@barfooze.de>
>> Date: Mon, 25 Aug 2014 21:25:43 +0200
>> Subject: [PATCH 2/2] perf Makefile: default WERROR to off.
>>
>> Having WERROR on by default breaks build everywhere the author hasn't
>> tested so far; including musl libc which warns about wrong includes.
>>
>> The unsuspecting user will think there's something broken and only
>> if he's coureageuous enough to grep the Makefile infrastructure find
>> out that he may be able to get the build working with WERROR=0.
>>
>> OTOH with WERROR defaulting to off, anything will work for the user
>> and the maintainer can knowingly use WERROR=1 to do his test builds.
> 
> I think it's intentionally turned on to fix any warnings in the first
> place.  But yes, it might miss some non-popular systems tho..

yes, and it's sufficient if someone tries to build it with a 
newer/different compiler/libc version/whatever to make it fail.
having -Werror on by default is just silly and annoying because 90% of 
warnings (at least with -Wall) are utterly unimportant (like unused 
variables etc).
there's probably a good reason the kernel itself is not built with -Werror.

(in my head i call people hardcoding -Werror "Werror-nazis"...)

but i agree that *some* warnings should be fatal, for example implicit 
function declarations, or pointer-to-int casts, because those can 
actually break code.


> 
> How many errors/warnings do you see on your system (musl libc?).  Any
> chance to post fixes instead?

there are tons of warnings, mostly from mixing kernel headers with 
userspace headers (and libc_compat.h is only patched for GLIBC - my 
musl-related libc_compat.h patches have been ignored so far, but they're 
archived at https://github.com/sabotage-linux/kernel-headers ).

In file included from perf.c:12:0:
util/cache.h:74:15: warning: redundant redeclaration of 'strlcpy' 
[-Wredundant-decls]
In file included from util/util.h:53:0,
                  from builtin.h:4,
                  from perf.c:9:
/usr/include/string.h:84:8: note: previous declaration of 'strlcpy' was here
In file included from util/util.h:67:0,
                  from builtin.h:4,
                  from perf.c:9:
/usr/include/sys/poll.h:1:2: warning: #warning redirecting incorrect 
#include <sys/poll.h> to <poll.h> [-Wcpp]
In file included from 
/src/build/kernel/linux-3.14.14.org/arch/x86/include/uapi/asm/ioctl.h:1:0,
                  from 
/src/build/kernel/linux-3.14.14.org/include/uapi/linux/ioctl.h:4,
                  from 
/src/build/kernel/linux-3.14.14.org/include/uapi/linux/perf_event.h:18,
                  from util/../perf.h:156,
                  from util/cache.h:7,
                  from perf.c:12:
/src/build/kernel/linux-3.14.14.org/include/uapi/asm-generic/ioctl.h:65:0: 
warning: "_IOC" redefined [enabled by default]
In file included from /usr/include/sys/ioctl.h:7:0,
                  from util/util.h:69,
                  from builtin.h:4,
                  from perf.c:9:
/usr/include/bits/ioctl.h:1:0: note: this is the location of the 
previous definition
In file included from 
/src/build/kernel/linux-3.14.14.org/arch/x86/include/uapi/asm/ioctl.h:1:0,
                  from 
/src/build/kernel/linux-3.14.14.org/include/uapi/linux/ioctl.h:4,
                  from 
/src/build/kernel/linux-3.14.14.org/include/uapi/linux/perf_event.h:18,
                  from util/../perf.h:156,
                  from util/cache.h:7,
                  from perf.c:12:
/src/build/kernel/linux-3.14.14.org/include/uapi/asm-generic/ioctl.h:76:0: 
warning: "_IO" redefined [enabled by default]

(same for _IOR, _IOW, _IOWR, _IOC)

these warnings are repeated over an over again as they come from headers.
so basically we have
- util/cache.h:74:15: warning: redundant redeclaration of 'strlcpy'
- uapi/asm-generic/ioctl.h: warning: "_IO*" redefined (userspace and 
kernel space defining the same thing)
- util/util.h: incorrect inclusion of sys/poll.h rather than poll.h (see 
man 3p poll)
tho it's possible I may have missed something else in the wall of warnings.

Thanks,
--JS


> 
> Thanks,
> Namhyung
> 
> 
>> Signed-off-by: John Spencer <maillist-linux@barfooze.de>
>>
>> ---
>>  tools/perf/config/Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/config/Makefile b/tools/perf/config/Makefile
>> index 1f67aa0..b1d639a 100644
>> --- a/tools/perf/config/Makefile
>> +++ b/tools/perf/config/Makefile
>> @@ -102,7 +102,7 @@ ifeq ($(call get-executable,$(BISON)),)
>>  endif
>>  
>>  # Treat warnings as errors unless directed not to
>> -ifneq ($(WERROR),0)
>> +ifeq ($(WERROR),1)
>>    CFLAGS += -Werror
>>  endif
> 
