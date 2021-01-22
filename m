Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEE8C433DB
	for <linux-perf-users@archiver.kernel.org>; Fri, 22 Jan 2021 22:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0BC623B06
	for <linux-perf-users@archiver.kernel.org>; Fri, 22 Jan 2021 22:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbhAVWEd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 22 Jan 2021 17:04:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:34150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730607AbhAVWBT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 22 Jan 2021 17:01:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9578923B17;
        Fri, 22 Jan 2021 22:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611352839;
        bh=9kwNm4P10i9O3BIphHH/GNZHPJGH0UcwvlCZF5aeO7M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Yxyp5Pf3uH/j1W8339zyquj02XsnUnCE+xZ9xE5KRm2hkawy5dslVta/zoqU1F6OU
         BAzO7dx0Wxu8E2qyX/If/sHikpokj/u9Q3qFu8aEGBbtDfmudlwc8hrawiAKvZ7PwR
         0jkSaUwOzAWCbodI9FQSBoXVUtDsGa6sydOxqsbC1QUGjcPYpzkDAyVmXFl5/GrFyl
         BjNpL73xKGMXi2QjbeNGAcPO8QzX/S2ra8XNK3o/bDGHYdx31EBLXjlAJxqWE05DOV
         8gn4fohByPVrwY9m9pAN/L2JdkUmFsx2Hs9thEGyaaDz0U1UOwcNH1pF39qr/iclfL
         /v+5pgob5ESlg==
Subject: Re: [GIT PULL] perf tools fixes for v5.11, 2nd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210122135156.608434-1-acme@kernel.org>
References: <20210122135156.608434-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210122135156.608434-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-v5.11-2-2021-01-22
X-PR-Tracked-Commit-Id: 8adc0a06d68a2e433b960377e515e7a6b19b429f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: faba877b3bccb5af79f0cd8c6af93392030e6e41
Message-Id: <161135283958.4174.10836254569905042796.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Jan 2021 22:00:39 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        John Garry <john.garry@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Fri, 22 Jan 2021 10:51:56 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-v5.11-2-2021-01-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/faba877b3bccb5af79f0cd8c6af93392030e6e41

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
