Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78600C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 21 Sep 2021 02:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63F9F61183
	for <linux-perf-users@archiver.kernel.org>; Tue, 21 Sep 2021 02:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348668AbhIUCYJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236835AbhIUBvd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 20 Sep 2021 21:51:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA34C0364A5;
        Mon, 20 Sep 2021 15:47:55 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id A7DF31F426D9
Message-ID: <72990864-5ec6-1f73-efd9-61b667a172dd@collabora.com>
Date:   Mon, 20 Sep 2021 19:47:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v3 2/2] perf bench: Add support for 32-bit systems with
 64-bit time_t
Content-Language: en-US
To:     Alistair Francis <alistair.francis@opensource.wdc.com>
Cc:     linux-kernel@vger.kernel.org, alistair23@gmail.com,
        linux-riscv@lists.infradead.org, namhyung@kernel.org,
        jolsa@redhat.com, linux-perf-users@vger.kernel.org,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        acme@kernel.org, dave@stgolabs.net, dvhart@infradead.org,
        peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        atish.patra@wdc.com, arnd@arndb.de,
        Alistair Francis <alistair.francis@wdc.com>
References: <20210917061040.2270822-1-alistair.francis@opensource.wdc.com>
 <20210917061040.2270822-2-alistair.francis@opensource.wdc.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
In-Reply-To: <20210917061040.2270822-2-alistair.francis@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Alistair,

Às 03:10 de 17/09/21, Alistair Francis escreveu:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Some 32-bit architectures (such are 32-bit RISC-V) only have a 64-bit
> time_t and as such don't have the SYS_futex syscall. This patch will
> allow us to use the SYS_futex_time64 syscall on those platforms.
> 

Thanks for your patch! However, I don't think that any futex operation
at perf has timeout. Do you plan to implement a test that use it? Or the
idea is to get this ready for it in case someone want to do so in the
future?


Also, I faced a similar problem with the new futex2 syscalls, that
supports exclusively 64bit timespec. But I took a different approach: I
called __NR_clock_gettime64 for 32bit architectures so it wouldn't
require to convert the struct:

#if defined(__i386__) || __TIMESIZE == 32
# define NR_gettime64 __NR_clock_gettime64
#else
# define NR_gettime64 __NR_clock_gettime
#endif

struct timespec64 {
	long long tv_sec;	/* seconds */
	long long tv_nsec;	/* nanoseconds */
};

int gettime64(clock_t clockid, struct timespec64 *tv)
{
	return syscall(NR_gettime64, clockid, tv);
}

Then we can just use &timeout at __NR_futex_time64 for 32bit arch and at
__NR_futex for 64bit arch.

This might be a simpler solution to the problem that you are facing but
I'm not entirely sure. Also, futex's selftests do use the timeout
argument and I think that they also won't compile in 32-bit RISC-V, so
maybe we can start from there so we can actually test the timeout
argument and check if it's working.

Thanks,
	André
