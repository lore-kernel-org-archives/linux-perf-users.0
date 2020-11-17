Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BDFC64E7A
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Nov 2020 19:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A3282463B
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Nov 2020 19:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pe3KVlj+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbgKQTee (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 Nov 2020 14:34:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:43596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729952AbgKQTeb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 Nov 2020 14:34:31 -0500
Subject: Re: [GIT PULL] perf tools fixes for v5.10: 3rd batch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605641670;
        bh=C9WVBRTA1FV9GZQjy2G0M2hF3wPgro6d9m3aiWrDExo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pe3KVlj+H+S1la9zEjdEK79d+wJ55iZLtJxFHb07f9++p8gW/1tVe8d+Gmp7p3uFe
         r8f9jAGFaQebI/XT7Ah2ZxTGMctLnP33iOMQiokNrTDVD1UO/rL2/jHWM1VbhQ+kHN
         WlGtUE7O3Cp1ldVAaUaFeNBIb2kBT8i1YDwiYk1M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201117131747.650843-1-acme@kernel.org>
References: <20201117131747.650843-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201117131747.650843-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.10-2020-11-17
X-PR-Tracked-Commit-Id: 568beb27959b0515d325ea1c6cf211eed2d66740
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: be1dd6692adbdb1d70da47da124ac8376bba5ad5
Message-Id: <160564167075.32053.4061899843308734124.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Nov 2020 19:34:30 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Al Grant <al.grant@arm.com>, Ian Rogers <irogers@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Tue, 17 Nov 2020 10:17:47 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.10-2020-11-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/be1dd6692adbdb1d70da47da124ac8376bba5ad5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
