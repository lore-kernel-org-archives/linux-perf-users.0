Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3C4C433E0
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Dec 2020 19:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ECE222203
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Dec 2020 19:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgLYTKh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Dec 2020 14:10:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:53230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgLYTKh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Dec 2020 14:10:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 089A522252;
        Fri, 25 Dec 2020 19:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608923397;
        bh=GMqy8CznyQeOv7tF9A4+fNZ4IHG0XfmDnaVVsrgaLFs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lp2V2IbjKQhvdfUn/CjICV4vXo15aUaQTExdsEpOFY2cseyy/sr+w24fFg+F9+ZpN
         962jCKe81LyeoWCfCmY4XvkiMZVD3MYBMcb/BRcVnhjpK5gw78ekNTtZeX/Fb2rh2f
         RIsOMVHqcIvZK6hTjJSecxYUP8ZnwmZmjtaoTkWCAJ+zRieUsy+nb66w0ukFVtjB+v
         rsq6EyXAmQY1rc8z9jGSw5x9M/GIjt3X5XAJGLejvcYTk3o4z6qYtmDpSgG8Ho9Hpw
         okQVTaV2BGupTwc+pYYGWCbal1W7mwbBrXlU/tBISA1ZsvU+BkNKmy11cZXvClgTCz
         vo32yQDUXaN6w==
Subject: Re: [GIT PULL] perf tools changes for v5.11, 2nd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201224185633.514066-1-acme@kernel.org>
References: <20201224185633.514066-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201224185633.514066-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-2020-12-24
X-PR-Tracked-Commit-Id: 5149303fdfe5c67ddb51c911e23262f781cd75eb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5814bc2d4cc241c1a603fac2b5bf1bd4daa108fc
Message-Id: <160892339699.18440.3590581285873558593.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Dec 2020 19:09:56 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Thu, 24 Dec 2020 15:56:33 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-2020-12-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5814bc2d4cc241c1a603fac2b5bf1bd4daa108fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
