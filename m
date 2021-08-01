Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89CBC4320A
	for <linux-perf-users@archiver.kernel.org>; Sun,  1 Aug 2021 19:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B98E761050
	for <linux-perf-users@archiver.kernel.org>; Sun,  1 Aug 2021 19:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhHAT2l (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 1 Aug 2021 15:28:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230072AbhHAT2k (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 1 Aug 2021 15:28:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 41E2061050;
        Sun,  1 Aug 2021 19:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627846112;
        bh=h7lMpajtRgA6JSFT0rCwE44PESYr/kUlVATNxxiqA6Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mYdMc0QgdQ0GGrKNRxqtJ287LBQY2GglcwbrhOzli2GuvZWz7yO0S5SU58TbE9XQG
         B2/FkqtpBcRDlNizjxz0GHEmFG7/BAbZ3m37Y719NsXv6w+Z9ZJspO3oN/a3LBfyqB
         O9kCi38TAAN/mRXXpa7Hu2QblSw8mOuv9K922CDIYkaSFHR0Q3Ne0ksKYme1CTa5MH
         m/j18tSYieQluO0X7VpXRNBS/r7bFmsoOHFRNjFu0kZ2qBwZpJbEASm+gWyfv8McP8
         Jx6zR/7IlgN+eIjKPW6Tljwn/GTwPvGUxkFEeeIeQNIhZ+x2lAinVyF5JirqO9+Vyr
         +o+6x2o6N8xaQ==
Subject: Re: [GIT PULL] perf tools fixes for v5.14: 2nd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210801143904.473154-1-acme@kernel.org>
References: <20210801143904.473154-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210801143904.473154-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.14-2021-08-01
X-PR-Tracked-Commit-Id: 9bac1bd6e6d36459087a728a968e79e37ebcea1a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4affd6b6e81443ec8d00de0306ca61911e81441
Message-Id: <162784611223.1186.17070052772026197284.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Aug 2021 19:28:32 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Sun,  1 Aug 2021 11:39:04 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.14-2021-08-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4affd6b6e81443ec8d00de0306ca61911e81441

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
