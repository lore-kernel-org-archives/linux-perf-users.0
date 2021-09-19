Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EACC433EF
	for <linux-perf-users@archiver.kernel.org>; Sun, 19 Sep 2021 20:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98BB761004
	for <linux-perf-users@archiver.kernel.org>; Sun, 19 Sep 2021 20:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhISUiY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 19 Sep 2021 16:38:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232004AbhISUiX (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 19 Sep 2021 16:38:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1776760240;
        Sun, 19 Sep 2021 20:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632083806;
        bh=T2c8bMYXBskh9FZsrU6GF3pxxSkFGJVq3SeIae8HZl0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ApukXedAYArl44wjPZw8WIbITY9mO7ywuxlSNtxdb1w5RG05G/HKBq6kyn9nURztx
         Y39maP+gHeoLKn4VKnOW2oMNx+PJNzn7vi9hY1ldMUMOs7NG4FT6yWWXnuWdBb1L18
         9O4pFGFm2YoX7S+UcsAXwVHVk9z8p4MvjvuQGrfCyWJEmUulzH5EnOvkzF4/EaBOVd
         4lcsV0/+QaixLa6umLyrorx+JnEX9/Rn+/DtFoNiyEoWkCrhayIiDqTItgOuj2xWHI
         YLLRjDIVGNepsSkqOBSBTmVnNJR6SQhsIdH6uv9nHssU3Mnt8kjO2jB+qs3a/h34zn
         scTcINuYfnnJg==
Subject: Re: [GIT PULL] perf tools fixes for v5.15: 1st batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210919001030.301511-1-acme@kernel.org>
References: <20210919001030.301511-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210919001030.301511-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.15-2021-09-18
X-PR-Tracked-Commit-Id: 219d720e6df71c2607d7120d6b9281614863e5b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d94f395772aeee64325d8b2f279560f08ac06fac
Message-Id: <163208380595.27843.9098127255998207602.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Sep 2021 20:36:45 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Juri Lelli <jlelli@redhat.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Sat, 18 Sep 2021 21:10:30 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.15-2021-09-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d94f395772aeee64325d8b2f279560f08ac06fac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
