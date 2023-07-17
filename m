Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545EFEB64DC
	for <linux-perf-users@archiver.kernel.org>; Mon, 17 Jul 2023 18:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjGQSQc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 17 Jul 2023 14:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjGQSQa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 17 Jul 2023 14:16:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B75719B5
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Jul 2023 11:16:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 944B7610A2
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Jul 2023 18:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C462AC433CA;
        Mon, 17 Jul 2023 18:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617730;
        bh=yClenxN+4eb8887C2/BIVVRgYyMgdE8IE/HWbM8IMcA=;
        h=Date:From:To:Cc:Subject:From;
        b=LAPRiBdkGpYNQoDwQm7NoyTImmoaZKVBMOCEbPyeO1Xe3uJXP7KY12+WuJ5xXuTAw
         wgn6HYn7fuLiUhfp8WCrQT1NK8QEm3yYKLYEmDsROUc420184+ARVbU8DADwFemxku
         XmZWKYazKTFPUyQkAabMS6c6wZ+2eUa/1j9euuk31ralBQfV0JVyOnNuiveXxrRy3n
         QJleWL7y1dedMwyTkaO8NZKN2RRo0qPeumti0x43ctiEgr8PqMmmMjdIH3LSeppkww
         kdxyEUvDHteXbAbV6LnjX699NTxOP3BNEjHpaCJ9byFsN8h+Iq5eCHiGRfpb/kpZ0G
         4czYPlQe4WmLQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7828F40516; Mon, 17 Jul 2023 15:06:10 -0300 (-03)
Date:   Mon, 17 Jul 2023 15:06:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-perf-users@vger.kernel.org
Subject: perf probe: Trying to read a 'ctx' named local variable
Message-ID: <ZLWDEjvFjrrEJODp@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Masami,

	Trying to use perf to debug perf I stumbled on this:

[root@quaco ~]# perf probe -x ~/bin/perf -L sigtrap_handler
<sigtrap_handler@/home/acme/git/perf-tools/tools/perf/tests/sigtrap.c:0>
      0  sigtrap_handler(int signum __maybe_unused, siginfo_t *info, void *ucontext __maybe_unused)
         {
                if (!__atomic_fetch_add(&ctx.signal_count, 1, __ATOMIC_RELAXED))
      3                 ctx.first_siginfo = *info;
      4         __atomic_fetch_sub(&ctx.tids_want_signal, syscall(SYS_gettid), __ATOMIC_RELAXED);
         }

         static void *test_thread(void *arg)

[root@quaco ~]# perf probe -x ~/bin/perf sigtrap_handler:4 "ctx.signal_count"
Failed to write event: Invalid argument
Please upgrade your kernel to at least 3.14 to have access to feature @ctx
  Error: Failed to add events.
[root@quaco ~]#

[root@quaco ~]# uname -a
Linux quaco 6.3.8-100.fc37.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Jun 15 01:51:54 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
[root@quaco ~]# rpm -qa | grep kernel-debuginfo
kernel-debuginfo-common-x86_64-6.3.8-100.fc37.x86_64
kernel-debuginfo-6.3.8-100.fc37.x86_64
[root@quaco ~]#

-- 

- Arnaldo
