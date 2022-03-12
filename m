Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32732C433EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 12 Mar 2022 18:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbiCLSoi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 12 Mar 2022 13:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiCLSoi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 12 Mar 2022 13:44:38 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB855723D4;
        Sat, 12 Mar 2022 10:43:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 23B91CE0DC6;
        Sat, 12 Mar 2022 18:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CDA9C340EE;
        Sat, 12 Mar 2022 18:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647110609;
        bh=dun9hxN9g43cQ3j5ZU76+2IfU6GtG+uBgFxLzLlFA3g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IoWK3V7yNiQ8MZ3drHMIYE1+58QEsewFgqw5str1rf5LorYd9QrYKDWBLcvDYf0a3
         V9MELln4ML0er5NPAap84Gs0wzc3SsAvymTAtqbw1gCFRiuOFSlzvjUVootXn5qZ+x
         GBV0UIz3sARnF6+4bX8b2vEIPsWXZMiRBK1d+EB8LZYWqx9O+kfE+qoJvpnl3y2rs2
         k7ulXxVRKdAADoX+/PAo1WLWyT6xODLZHSbkaJQcqauVI+WgsH1n+bSa+QucM+y6Or
         nGhFwYAwsjQvAxYDZgpZ7IP5t/SM0w2UVtu5uj3HyNoDRba0k4PTeBB1oJTcw5UEhA
         /r305N0NaeTPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 784EBE73C2D;
        Sat, 12 Mar 2022 18:43:29 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.17: 4th batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220312155723.1149183-1-acme@kernel.org>
References: <20220312155723.1149183-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220312155723.1149183-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.17-2022-03-12
X-PR-Tracked-Commit-Id: 91c9923a473a694eb1c5c01ab778a77114969707
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aad611a868d16cdc16a7d4a764cef955293e47e3
Message-Id: <164711060948.14941.5750042589298580024.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Mar 2022 18:43:29 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Weiguo Li <liwg06@foxmail.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Sat, 12 Mar 2022 12:57:23 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.17-2022-03-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aad611a868d16cdc16a7d4a764cef955293e47e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
