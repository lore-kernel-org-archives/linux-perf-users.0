Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E71EB64DC
	for <linux-perf-users@archiver.kernel.org>; Mon, 17 Jul 2023 23:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjGQXy4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 17 Jul 2023 19:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGQXyz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 17 Jul 2023 19:54:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A33191
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Jul 2023 16:54:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC342612EC
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Jul 2023 23:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B226C433C8;
        Mon, 17 Jul 2023 23:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689638094;
        bh=ZPH3lYHP9DQt/xyW1nnkrosQfmdaz/2RFLVP6nmF6JQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UBTxbalupiSnkYHuCzCVFglahRnsL5P4hLWwgnGEFy47rGd6yZnvmw/fv6kML/yAc
         gaENDKdSBB128w6FYXKGaowSMcALnjjCv9pL6Y1lAtR/HvwF94cz1FTqoyhqjv8hHt
         fYaoE0LQocXkMQEfuwOi6Imv55T6nGg9EDnhKSUL84Lc7ByXbGNEMKQn8fgnCNgIvp
         vpYVcxGvkfek/1uCeOjQz9VfVBy5MLeh5xkZZ3jQll0EeyV/8oykub2F4XQ97/FvIc
         CAkWVYwKbZ4J83lqtGnD/YolmN7KjTHIPO/eoSNfkQubORN90D7oFlGsB+ROKQpYnp
         YuwR9I2MbDqSg==
Date:   Tue, 18 Jul 2023 08:54:51 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org
Subject: Re: perf probe: Trying to read a 'ctx' named local variable
Message-Id: <20230718085451.f6e099de7d34f2ae3dc4b7fe@kernel.org>
In-Reply-To: <ZLWDEjvFjrrEJODp@kernel.org>
References: <ZLWDEjvFjrrEJODp@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, 17 Jul 2023 15:06:10 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Masami,
> 
> 	Trying to use perf to debug perf I stumbled on this:
> 
> [root@quaco ~]# perf probe -x ~/bin/perf -L sigtrap_handler
> <sigtrap_handler@/home/acme/git/perf-tools/tools/perf/tests/sigtrap.c:0>
>       0  sigtrap_handler(int signum __maybe_unused, siginfo_t *info, void *ucontext __maybe_unused)
>          {
>                 if (!__atomic_fetch_add(&ctx.signal_count, 1, __ATOMIC_RELAXED))
>       3                 ctx.first_siginfo = *info;
>       4         __atomic_fetch_sub(&ctx.tids_want_signal, syscall(SYS_gettid), __ATOMIC_RELAXED);
>          }
> 
>          static void *test_thread(void *arg)
> 
> [root@quaco ~]# perf probe -x ~/bin/perf sigtrap_handler:4 "ctx.signal_count"
> Failed to write event: Invalid argument
> Please upgrade your kernel to at least 3.14 to have access to feature @ctx
>   Error: Failed to add events.
> [root@quaco ~]#

Ah, this is a wrong usage (I'm also trapped the same thing). Correctly, it should
pass it as a single parameter.

perf probe -x ~/bin/perf "sigtrap_handler:4 ctx.signal_count"

This is for adding several events at the same time. But now it becomes just a trap.
Can I change the syntax from

perf probe [OPTIONS] <PROBE-DEFINITION> [PROBE-DEFINITION...]

To,

perf probe [OPTIONS] <PROBE-POINT> [ARGS...]

?

We can keep --add having optional parameter as below.

perf probe [OPTIONS] --add <PROBE-DEFINITION>

Thank you,

> 
> [root@quaco ~]# uname -a
> Linux quaco 6.3.8-100.fc37.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Jun 15 01:51:54 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
> [root@quaco ~]# rpm -qa | grep kernel-debuginfo
> kernel-debuginfo-common-x86_64-6.3.8-100.fc37.x86_64
> kernel-debuginfo-6.3.8-100.fc37.x86_64
> [root@quaco ~]#
> 
> -- 
> 
> - Arnaldo


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
