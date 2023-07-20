Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DCFEB64DA
	for <linux-perf-users@archiver.kernel.org>; Thu, 20 Jul 2023 14:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjGTOks (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 20 Jul 2023 10:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjGTOks (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 20 Jul 2023 10:40:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DFC10FC
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Jul 2023 07:40:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C08C61B18
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Jul 2023 14:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5690C433C8;
        Thu, 20 Jul 2023 14:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689864045;
        bh=frCv0U6zXkpQWhmKxdqDk00UwkgOIJZTSc2SAU/QP5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IjmTNEk+4yok1OWKBvwdD0YfKu8BOa6ndsLN4KM4ectsq0P9gBs7nJuWH12jFdOOz
         kozXRz2Kv5B5AxR8QeZJghBg/F8kyTmzuahuJyBKvt8a21P7SQ6Fl3w44ARh/WpW6d
         dEJLmRr2dvQA9u4DH/RUv6sX9n2v9xPL3RrAxbBsI1p2bDgUgJNnE2O6Ku0mFhXb1H
         hxDwjqTlr0OREtt1pg97IS0ZV180kXD46lsa1eYAEAKC/Ohcy8GmSZ1aCjmnl2toZ1
         /3EGXkLlLiXP7P3afi1vDs4ngXvfx2Qfz31yRedrTnsUs/AZbNxgLj1lj3CahUn8Yo
         hFsCR/mJ6yTAA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BBE7540516; Thu, 20 Jul 2023 11:40:42 -0300 (-03)
Date:   Thu, 20 Jul 2023 11:40:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-perf-users@vger.kernel.org
Subject: Re: perf probe: Trying to read a 'ctx' named local variable
Message-ID: <ZLlHagQuZGAhOk50@kernel.org>
References: <ZLWDEjvFjrrEJODp@kernel.org>
 <20230718085451.f6e099de7d34f2ae3dc4b7fe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718085451.f6e099de7d34f2ae3dc4b7fe@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jul 18, 2023 at 08:54:51AM +0900, Masami Hiramatsu escreveu:
> On Mon, 17 Jul 2023 15:06:10 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > Hi Masami,
> > 
> > 	Trying to use perf to debug perf I stumbled on this:
> > 
> > [root@quaco ~]# perf probe -x ~/bin/perf -L sigtrap_handler
> > <sigtrap_handler@/home/acme/git/perf-tools/tools/perf/tests/sigtrap.c:0>
> >       0  sigtrap_handler(int signum __maybe_unused, siginfo_t *info, void *ucontext __maybe_unused)
> >          {
> >                 if (!__atomic_fetch_add(&ctx.signal_count, 1, __ATOMIC_RELAXED))
> >       3                 ctx.first_siginfo = *info;
> >       4         __atomic_fetch_sub(&ctx.tids_want_signal, syscall(SYS_gettid), __ATOMIC_RELAXED);
> >          }
> > 
> >          static void *test_thread(void *arg)
> > 
> > [root@quaco ~]# perf probe -x ~/bin/perf sigtrap_handler:4 "ctx.signal_count"
> > Failed to write event: Invalid argument
> > Please upgrade your kernel to at least 3.14 to have access to feature @ctx
> >   Error: Failed to add events.
> > [root@quaco ~]#
> 
> Ah, this is a wrong usage (I'm also trapped the same thing). Correctly, it should
> pass it as a single parameter.
> 
> perf probe -x ~/bin/perf "sigtrap_handler:4 ctx.signal_count"

[root@five ~]# perf probe -x ~/bin/perf "sigtrap_handler:4 ctx.signal_count"
Failed to write event: Invalid argument
Please upgrade your kernel to at least 3.14 to have access to feature @ctx
  Error: Failed to add events.
[root@five ~]#

Didn't work?

- Arnaldo
 
> This is for adding several events at the same time. But now it becomes just a trap.
> Can I change the syntax from
> 
> perf probe [OPTIONS] <PROBE-DEFINITION> [PROBE-DEFINITION...]
> 
> To,
> 
> perf probe [OPTIONS] <PROBE-POINT> [ARGS...]
> 
> ?
> 
> We can keep --add having optional parameter as below.
> 
> perf probe [OPTIONS] --add <PROBE-DEFINITION>
> 
> Thank you,
> 
> > 
> > [root@quaco ~]# uname -a
> > Linux quaco 6.3.8-100.fc37.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Jun 15 01:51:54 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
> > [root@quaco ~]# rpm -qa | grep kernel-debuginfo
> > kernel-debuginfo-common-x86_64-6.3.8-100.fc37.x86_64
> > kernel-debuginfo-6.3.8-100.fc37.x86_64
> > [root@quaco ~]#
> > 
> > -- 
> > 
> > - Arnaldo
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

-- 

- Arnaldo
