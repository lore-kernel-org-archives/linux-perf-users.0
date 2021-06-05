Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB4EC4743E
	for <linux-perf-users@archiver.kernel.org>; Sat,  5 Jun 2021 01:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F7BF613BF
	for <linux-perf-users@archiver.kernel.org>; Sat,  5 Jun 2021 01:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhFEBht (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 4 Jun 2021 21:37:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231424AbhFEBhs (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 4 Jun 2021 21:37:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2E2FA613AC;
        Sat,  5 Jun 2021 01:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622856961;
        bh=XSkfsV7/WtaBLG+bsTNHCt2zHpDBIPZJLjRxdk43DKs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ww3etRyv+rddjrCxfdrZ9av4SdM+EfYsp6H/TC0Nqt7oLuC/4pQ1MsT2D4QdvtzQ9
         V4IzA3vllUzREH5K5BeCPNeRQU+d0BYPPfbpy2a8Mt/jzAokUpKJq6I+Qxi/Wro6mh
         thzgNIV3P8hrua0zcVmxV4aTQbjq0SBO17VIhZDkU8A7c/rXUaRvAga5Iw3ihaj1Cz
         AtwwPIYsyrs1sDHFwqJAL0jCYbcF98R+/aLIBne7/ZV6AFL9//7hOBWTDb2FEo/I/+
         MV/+LHJ+MY2iZhRMR5VGxFG4s6ZwI+Px7AscI61N61gTQcslDeyyI0FVR10xJT0CQg
         6S55DbDdx7nTQ==
Subject: Re: [GIT PULL] perf tools fixes for v5.13: 4th batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210604195827.517650-1-acme@kernel.org>
References: <20210604195827.517650-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210604195827.517650-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.13-2021-06-04
X-PR-Tracked-Commit-Id: 67069a1f0fe5f9eeca86d954fff2087f5542a008
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2cb26c15a247a2b2bc9de653773cf21d969bf570
Message-Id: <162285696115.3539.17398265731408584788.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Jun 2021 01:36:01 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Li Huafei <lihuafei1@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yu Kuai <yukuai3@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Fri,  4 Jun 2021 16:58:27 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.13-2021-06-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2cb26c15a247a2b2bc9de653773cf21d969bf570

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
