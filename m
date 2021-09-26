Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB47C433EF
	for <linux-perf-users@archiver.kernel.org>; Sun, 26 Sep 2021 21:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DF4760FC2
	for <linux-perf-users@archiver.kernel.org>; Sun, 26 Sep 2021 21:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhIZVep (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 26 Sep 2021 17:34:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46786 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhIZVeo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 26 Sep 2021 17:34:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 8B0D01F4239D
Message-ID: <a65dfe31-a355-8cf8-99d8-70ddf23c5384@collabora.com>
Date:   Sun, 26 Sep 2021 18:32:57 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v3 2/2] perf bench: Add support for 32-bit systems with
 64-bit time_t
Content-Language: en-US
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Alistair Francis <alistair.francis@opensource.wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Darren Hart <dvhart@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <atish.patra@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <alistair.francis@wdc.com>
References: <20210917061040.2270822-1-alistair.francis@opensource.wdc.com>
 <20210917061040.2270822-2-alistair.francis@opensource.wdc.com>
 <72990864-5ec6-1f73-efd9-61b667a172dd@collabora.com>
 <CAKmqyKM+VN-KST9-VMULZMC=2sNbjH2wiE-CZ1WRfVFj3WmpdQ@mail.gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
In-Reply-To: <CAKmqyKM+VN-KST9-VMULZMC=2sNbjH2wiE-CZ1WRfVFj3WmpdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Às 01:34 de 24/09/21, Alistair Francis escreveu:
> On Tue, Sep 21, 2021 at 8:47 AM André Almeida <andrealmeid@collabora.com> wrote:
>>
>> Hi Alistair,
>>
>> Às 03:10 de 17/09/21, Alistair Francis escreveu:
>>> From: Alistair Francis <alistair.francis@wdc.com>
>>>
>>> Some 32-bit architectures (such are 32-bit RISC-V) only have a 64-bit
>>> time_t and as such don't have the SYS_futex syscall. This patch will
>>> allow us to use the SYS_futex_time64 syscall on those platforms.
>>>
>>
>> Thanks for your patch! However, I don't think that any futex operation
>> at perf has timeout. Do you plan to implement a test that use it? Or the
>> idea is to get this ready for it in case someone want to do so in the
>> future?
> 
> I don't have plans to implement any new tests (although I'm happy to
> add one if need be).
> 
> My goal was just to get this to build for RISC-V 32-bit. The timeout
> was already exposed by the old futex macro, so I was just following
> that.
> 

I see, thanks for working on that.

>>
>>
>> Also, I faced a similar problem with the new futex2 syscalls, that
>> supports exclusively 64bit timespec. But I took a different approach: I
>> called __NR_clock_gettime64 for 32bit architectures so it wouldn't
>> require to convert the struct:
>>
>> #if defined(__i386__) || __TIMESIZE == 32
>> # define NR_gettime64 __NR_clock_gettime64
>> #else
>> # define NR_gettime64 __NR_clock_gettime
>> #endif
>>
>> struct timespec64 {
>>         long long tv_sec;       /* seconds */
>>         long long tv_nsec;      /* nanoseconds */
>> };
>>
>> int gettime64(clock_t clockid, struct timespec64 *tv)
>> {
>>         return syscall(NR_gettime64, clockid, tv);
>> }
>>
>> Then we can just use &timeout at __NR_futex_time64 for 32bit arch and at
>> __NR_futex for 64bit arch.
> 
> So the idea is to use 64-bit time_t everywhere and only work on 5.1+ kernels.
> 
> If that's the favoured approach I can convert this series to your idea.
> 

Yes, this is what I think it will be the best approach. I believe the
code will be less complex, it's more future proof (it's ready for y2038)
and when glibc supports time64, we can make this code even simpler using
`-D__USE_TIME_BITS64` to compile it. Thanks again for working on that!

> Alistair
> 
>>
>> This might be a simpler solution to the problem that you are facing but
>> I'm not entirely sure. Also, futex's selftests do use the timeout
>> argument and I think that they also won't compile in 32-bit RISC-V, so
>> maybe we can start from there so we can actually test the timeout
>> argument and check if it's working.
>>
>> Thanks,
>>         André
