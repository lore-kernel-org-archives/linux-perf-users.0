Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F76EB64DA
	for <linux-perf-users@archiver.kernel.org>; Fri, 21 Jul 2023 00:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjGUAin (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 20 Jul 2023 20:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGUAim (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 20 Jul 2023 20:38:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51575272A
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Jul 2023 17:38:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB65A61CD6
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Jul 2023 00:38:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1B6C433C8;
        Fri, 21 Jul 2023 00:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689899918;
        bh=YUqCTJKd11G947Iu4AkFd6wVW29p+NEL0O+TW6oAc1k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rvhppO1qtk0hJpPK+lCWHJgP1ADmzk3DqaX0FDXYZx/hLNz1pKAczMDquAqvjZSoQ
         ksEXeM5cS18ARt4IMchNU2VzHUO0dijJb0ORshk7Ifdo5WiH/QZXAUEVdwF46M/a7X
         6/LJzrx8mdeU0XhI6V5z3QMx3fYAEvoGJqbVxAhXvte0neBu2EuVh7sulcw7syvXgy
         0FuAagOyPFHhVaCkNYuOdCgJtqfJ6b7BRdl3I1eiwyWTIclcCJNCWEsI7zJc3RhaPQ
         0xOagsJJLALFRRzGt1rIn8WDvek9Yw1qDVOMvM2IJh2WNXbR03WtnyorMqAJJaXUl7
         UGUGB/HdGmn2A==
Date:   Fri, 21 Jul 2023 09:38:34 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org
Subject: Re: perf probe: Trying to read a 'ctx' named local variable
Message-Id: <20230721093834.a3e39a0adc0814cd655ead70@kernel.org>
In-Reply-To: <ZLlHagQuZGAhOk50@kernel.org>
References: <ZLWDEjvFjrrEJODp@kernel.org>
        <20230718085451.f6e099de7d34f2ae3dc4b7fe@kernel.org>
        <ZLlHagQuZGAhOk50@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, 20 Jul 2023 11:40:42 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Tue, Jul 18, 2023 at 08:54:51AM +0900, Masami Hiramatsu escreveu:
> > On Mon, 17 Jul 2023 15:06:10 -0300
> > Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > > Hi Masami,
> > > 
> > > 	Trying to use perf to debug perf I stumbled on this:
> > > 
> > > [root@quaco ~]# perf probe -x ~/bin/perf -L sigtrap_handler
> > > <sigtrap_handler@/home/acme/git/perf-tools/tools/perf/tests/sigtrap.c:0>
> > >       0  sigtrap_handler(int signum __maybe_unused, siginfo_t *info, void *ucontext __maybe_unused)
> > >          {
> > >                 if (!__atomic_fetch_add(&ctx.signal_count, 1, __ATOMIC_RELAXED))
> > >       3                 ctx.first_siginfo = *info;
> > >       4         __atomic_fetch_sub(&ctx.tids_want_signal, syscall(SYS_gettid), __ATOMIC_RELAXED);
> > >          }
> > > 
> > >          static void *test_thread(void *arg)
> > > 
> > > [root@quaco ~]# perf probe -x ~/bin/perf sigtrap_handler:4 "ctx.signal_count"
> > > Failed to write event: Invalid argument
> > > Please upgrade your kernel to at least 3.14 to have access to feature @ctx
> > >   Error: Failed to add events.
> > > [root@quaco ~]#
> > 
> > Ah, this is a wrong usage (I'm also trapped the same thing). Correctly, it should
> > pass it as a single parameter.
> > 
> > perf probe -x ~/bin/perf "sigtrap_handler:4 ctx.signal_count"
> 
> [root@five ~]# perf probe -x ~/bin/perf "sigtrap_handler:4 ctx.signal_count"
> Failed to write event: Invalid argument
> Please upgrade your kernel to at least 3.14 to have access to feature @ctx
>   Error: Failed to add events.
> [root@five ~]#
> 
> Didn't work?

Ah, I got it. The error message is wrong.

/sys/kernel/debug/tracing# cat error_log 
[122869.758693] trace_uprobe: error: Symbol is not available with uprobe
  Command: p:probe_perf/sigtrap_handler_L4 /usr/local/bin/perf:0xfc8e9 signal_count=@ctx+4:s32
                                                                                                          ^
"ctx" is not a local variable in this context and @ctx (global variable) is not
accessible from uprobe events.
Hmm, it must be checked while parsing the debuginfo.

Thank you,

> 
> - Arnaldo
>  
> > This is for adding several events at the same time. But now it becomes just a trap.
> > Can I change the syntax from
> > 
> > perf probe [OPTIONS] <PROBE-DEFINITION> [PROBE-DEFINITION...]
> > 
> > To,
> > 
> > perf probe [OPTIONS] <PROBE-POINT> [ARGS...]
> > 
> > ?
> > 
> > We can keep --add having optional parameter as below.
> > 
> > perf probe [OPTIONS] --add <PROBE-DEFINITION>
> > 
> > Thank you,
> > 
> > > 
> > > [root@quaco ~]# uname -a
> > > Linux quaco 6.3.8-100.fc37.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Jun 15 01:51:54 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
> > > [root@quaco ~]# rpm -qa | grep kernel-debuginfo
> > > kernel-debuginfo-common-x86_64-6.3.8-100.fc37.x86_64
> > > kernel-debuginfo-6.3.8-100.fc37.x86_64
> > > [root@quaco ~]#
> > > 
> > > -- 
> > > 
> > > - Arnaldo
> > 
> > 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> -- 
> 
> - Arnaldo


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
