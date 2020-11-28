Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6798C64E7B
	for <linux-perf-users@archiver.kernel.org>; Sat, 28 Nov 2020 22:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CDAF21534
	for <linux-perf-users@archiver.kernel.org>; Sat, 28 Nov 2020 22:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmKD8qGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgK1WPv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 28 Nov 2020 17:15:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:46460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726865AbgK1WPo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 28 Nov 2020 17:15:44 -0500
Subject: Re: [GIT PULL] perf tools fixes for v5.10: 4th batch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606601704;
        bh=Iu3Gz+9ibTHVllcRCCZ+Ot4Tzcs3nSVbmicYhZj1sYg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZmKD8qGwI7atg5C+SivPxuVnyY4DZssxI6W7rOGspIH0TOTMwNFqB5xuCkhSPnDUK
         wFU7zDzPXYeQgK8Eocs1VHfVL5CU/S4WT12PcfxdZF2uMYb8mzkU1AMdqGeFdElLVJ
         tIAq41XRCF6KKSZoKsb/oTww1HOs/lq+reQ9x+NE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201128153005.21172-1-acme@kernel.org>
References: <20201128153005.21172-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201128153005.21172-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.10-2020-11-28
X-PR-Tracked-Commit-Id: a9ffd0484eb4426e6befd07e7be6c01108716302
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca579827c9a7ec1b6fbfd2f8b157acaf138be838
Message-Id: <160660170411.2772.13335334859704327171.pr-tracker-bot@kernel.org>
Date:   Sat, 28 Nov 2020 22:15:04 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Hulk Robot <hulkci@huawei.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sam Xi <xyzsam@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Sat, 28 Nov 2020 12:30:05 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.10-2020-11-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca579827c9a7ec1b6fbfd2f8b157acaf138be838

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
