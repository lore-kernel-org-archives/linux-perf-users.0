Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF632C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 18:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABDE961040
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 18:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243668AbhJGS2R (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 14:28:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243703AbhJGS2N (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Oct 2021 14:28:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AD33261130;
        Thu,  7 Oct 2021 18:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633631179;
        bh=KOXTLTgb//ommYiNEDu2CxQlbDAdct6xRAxnPpg/XXI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RRW9DGugsx8cC01NWXe0pKjgiU6liaKzM/Kt/ad+JGP5YDNJ1sdYxY6lOfbwM9Lhv
         SCgM/I4hMoWSE/vvB14TLYeOUprb0Fwzzml1/yoc4c5/6VECwWLPn0FXgs3lsukrQa
         HzDIGCbBGKJZp8gHDI/R8T6gvRTSpL/1K8CC+7ceoe0voudc03aLTsYi8sjCZ7jZ3n
         /mQej9255H5X4LJO8JWHj1CrogmD5ryqFbKC4/lG/clgel6QRslLlGfQ2axyt4FWVc
         ogyBYQwpa856sun+mpJ8dixFQq/rXAcRSYdPSlBphjZ1HuAT+J4m+5kh4bxo7xLzhZ
         QWMdArPjaKn+Q==
Subject: Re: [GIT PULL] perf tools fixes for v5.15: 3rd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211007162034.613793-1-acme@kernel.org>
References: <20211007162034.613793-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211007162034.613793-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.15-2021-10-07
X-PR-Tracked-Commit-Id: 0b6c5371c03c2b17963e1abd7ed0e3f1f950cba9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 14df9235aa99e43ddeb78b8d2a78cf20c21a1114
Message-Id: <163363117965.25708.847002202565508931.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Oct 2021 18:26:19 +0000
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
        Branislav Rankov <branislav.rankov@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Like Xu <likexu@tencent.com>,
        Tamas Zsoldos <tamas.zsoldos@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Thu,  7 Oct 2021 13:20:34 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.15-2021-10-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/14df9235aa99e43ddeb78b8d2a78cf20c21a1114

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
