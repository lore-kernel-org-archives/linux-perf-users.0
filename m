Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F929C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 00:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECB1161029
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 00:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhJTAEH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Oct 2021 20:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhJTAEG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Oct 2021 20:04:06 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6087FC06161C;
        Tue, 19 Oct 2021 17:01:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 8D6C01F43E27
Message-ID: <0d55b0a0-dd8c-0494-a200-7acb1976e32a@collabora.com>
Date:   Tue, 19 Oct 2021 21:01:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/2] perf bench futex: Use a 64-bit time_t
Content-Language: en-US
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alistair Francis <alistair.francis@opensource.wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Darren Hart <dvhart@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <atish.patra@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <alistair.francis@wdc.com>
References: <20211015005634.2658470-1-alistair.francis@opensource.wdc.com>
 <YW74wK03ibOS3jVZ@kernel.org>
 <CAKmqyKP6AU-9tcYOp-ERvYFP7t6DMp4kbQgDmJxD6wb0WTUy+w@mail.gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
In-Reply-To: <CAKmqyKP6AU-9tcYOp-ERvYFP7t6DMp4kbQgDmJxD6wb0WTUy+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Às 20:17 de 19/10/21, Alistair Francis escreveu:
> On Wed, Oct 20, 2021 at 2:56 AM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
>>
>> Em Fri, Oct 15, 2021 at 10:56:33AM +1000, Alistair Francis escreveu:
>>> From: Alistair Francis <alistair.francis@wdc.com>
>>>
>>> Convert tools/perf to only use a 64-bit time_t. On 64-bit architectures
>>> this isn't a functional change. On 32-bit architectures we now only
>>> perform 64-bit time_t syscalls (__NR_futex_time64) and use a struct
>>> timespec64.
>>>
>>> This won't work on kernels before 5.1, but as perf is tied to the kernel
>>> that's ok.
>>
>> No, perf is not tied to the kernel, one can use a new perf tool on any
>> previous kernel, and an old perf tool should work on new kernels as
>> well.
> 
> + André, I won't be doing this the way you requested
> 

Ok, thanks anyway for your work and sorry for the trouble :)

> Ok, so back to the previous version then. I'll send the patches soon.
> 
> Alistair
> 
>>
>> - Arnaldo
>>
>>> This allows us to build perf for 32-bit architectures with 64-bit time_t
>>> like RISC-V 32-bit.
>>>
>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>> ---
>>>  tools/perf/bench/futex.h | 26 ++++++++++++++++++++------
>>>  1 file changed, 20 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
>>> index b3853aac3021c..b9665d43d2988 100644
>>> --- a/tools/perf/bench/futex.h
>>> +++ b/tools/perf/bench/futex.h
>>> @@ -12,6 +12,7 @@
>>>  #include <sys/syscall.h>
>>>  #include <sys/types.h>
>>>  #include <linux/futex.h>
>>> +#include <linux/time_types.h>
>>>
>>>  struct bench_futex_parameters {
>>>       bool silent;
>>> @@ -27,12 +28,14 @@ struct bench_futex_parameters {
>>>       unsigned int nrequeue;
>>>  };
>>>
>>> +#define timespec64 __kernel_timespec
>>> +
>>>  /**
>>>   * futex() - SYS_futex syscall wrapper
>>>   * @uaddr:   address of first futex
>>>   * @op:              futex op code
>>>   * @val:     typically expected value of uaddr, but varies by op
>>> - * @timeout: typically an absolute struct timespec (except where noted
>>> + * @timeout: typically an absolute struct timespec64 (except where noted
>>>   *           otherwise). Overloaded by some ops
>>>   * @uaddr2:  address of second futex for some ops
>>>   * @val3:    varies by op
>>> @@ -47,15 +50,26 @@ struct bench_futex_parameters {
>>>   * These argument descriptions are the defaults for all
>>>   * like-named arguments in the following wrappers except where noted below.
>>>   */
>>> -#define futex(uaddr, op, val, timeout, uaddr2, val3, opflags) \
>>> -     syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, val3)
>>> +/**
>>> + * We only support 64-bit time_t for the timeout.
>>> + * On 64-bit architectures we can use __NR_futex
>>> + * On 32-bit architectures we use __NR_futex_time64. This only works on kernel
>>> + * versions 5.1+.
>>> + */
>>> +#if __BITS_PER_LONG == 64
>>> +# define futex(uaddr, op, val, timeout, uaddr2, val3, opflags) \
>>> +     syscall(__NR_futex, uaddr, op | opflags, val, timeout, uaddr2, val3)
>>> +#else
>>> +# define futex(uaddr, op, val, timeout, uaddr2, val3, opflags) \
>>> +     syscall(__NR_futex_time64, uaddr, op | opflags, val, timeout, uaddr2, val3)
>>> +#endif
>>>
>>>  /**
>>>   * futex_wait() - block on uaddr with optional timeout
>>>   * @timeout: relative timeout
>>>   */
>>>  static inline int
>>> -futex_wait(u_int32_t *uaddr, u_int32_t val, struct timespec *timeout, int opflags)
>>> +futex_wait(u_int32_t *uaddr, u_int32_t val, struct timespec64 *timeout, int opflags)
>>>  {
>>>       return futex(uaddr, FUTEX_WAIT, val, timeout, NULL, 0, opflags);
>>>  }
>>> @@ -74,7 +88,7 @@ futex_wake(u_int32_t *uaddr, int nr_wake, int opflags)
>>>   * futex_lock_pi() - block on uaddr as a PI mutex
>>>   */
>>>  static inline int
>>> -futex_lock_pi(u_int32_t *uaddr, struct timespec *timeout, int opflags)
>>> +futex_lock_pi(u_int32_t *uaddr, struct timespec64 *timeout, int opflags)
>>>  {
>>>       return futex(uaddr, FUTEX_LOCK_PI, 0, timeout, NULL, 0, opflags);
>>>  }
>>> @@ -111,7 +125,7 @@ futex_cmp_requeue(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2, int nr_wak
>>>   */
>>>  static inline int
>>>  futex_wait_requeue_pi(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2,
>>> -                   struct timespec *timeout, int opflags)
>>> +                   struct timespec64 *timeout, int opflags)
>>>  {
>>>       return futex(uaddr, FUTEX_WAIT_REQUEUE_PI, val, timeout, uaddr2, 0,
>>>                    opflags);
>>> --
>>> 2.31.1
>>
>> --
>>
>> - Arnaldo
