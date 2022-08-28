Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712AEECAAA2
	for <linux-perf-users@archiver.kernel.org>; Sun, 28 Aug 2022 18:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiH1SSh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 28 Aug 2022 14:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiH1SSb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 28 Aug 2022 14:18:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DA126ADD;
        Sun, 28 Aug 2022 11:18:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3124960DDA;
        Sun, 28 Aug 2022 18:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 853CDC433D6;
        Sun, 28 Aug 2022 18:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661710709;
        bh=fY4nXKyq/kTJb4oXh9mVEjZpYJBafhxiDeNjZIHaJvs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SdhZaL9hdc1d/aTf15CEoyIBMhaLsnd+eJ1r8QlUgKGY/sysinNPHtguz2L6pTPwV
         PdReDY+C+rjpFIAwSfdTnyaCMTZcTfd5oWca2kMAKBdQo8mNanj7qlz+0eJMuAIMi1
         WSDQ8nQ2hHWkwj1UyEKzzRY2nwiGJUOU/guE2aPWGii1UrUpOm5+AioPB35qjVt9B0
         rYgRYmPZ/94mbDINEgmeoeN+k6OKKpdq6RZgSueMFz26lsPpU/gXRxOyPlUHsCBPAB
         7hXwxYV+E+ABAPpXu78qpiV7jukzLAGktfmqBfE9OfQNwTKBiMpkMzwP7T4fWwkfb0
         dZ/GdSaTXW2HQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E4A8C5A8AF;
        Sun, 28 Aug 2022 18:18:29 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v6.0: 2nd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220827181655.406024-1-acme@kernel.org>
References: <20220827181655.406024-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220827181655.406024-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.0-2022-08-27
X-PR-Tracked-Commit-Id: 48648548ef764dcb1f6ffc9c9f9057f7c610caa4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 611875d510a1ea7bcdf0e58ff7eedda08199d77e
Message-Id: <166171070944.6107.15565868937639433687.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Aug 2022 18:18:29 +0000
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
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Sat, 27 Aug 2022 15:16:55 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.0-2022-08-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/611875d510a1ea7bcdf0e58ff7eedda08199d77e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
