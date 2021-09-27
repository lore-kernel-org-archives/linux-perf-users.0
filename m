Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A69C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Sep 2021 21:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCE106109F
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Sep 2021 21:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237201AbhI0Vgu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 27 Sep 2021 17:36:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237180AbhI0Vgu (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 27 Sep 2021 17:36:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 96D5A61058;
        Mon, 27 Sep 2021 21:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632778511;
        bh=0noRQppx6b016iTc2IHsaAo0DwKCJvOpMN09kuNANRc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ojj/l+N/SvQa4NhLZD8hSUk36MLzrHhPBAXt+3DSExT6NItpOB1mdQwSV5wTO4OZo
         Lv1TucuI8JiBAOxGTD5CNtpW4YLOEk6jFiDYmv5m2u9oY6XvDhSAU0KcddfPohEpwQ
         qatgg6euHnj2MOCV2MSL+I+1WvimxOTmjbtIDbIA6VG8oaFY6ao0PL6MweE+mCz0rn
         /nh5R5r2NI06RPVYS7FWyUfSFt37Vjz+V6U9ShKN15y76XDPkihbedRrIzdJVx1TDC
         4dd429VO6J0w5E4ioB0qIZJNsFtf+zAu9a/oFP6pF12tQNU5gfe1Ev5oFTZeFT5jPO
         gYtlxpxFrhVOQ==
Subject: Re: [GIT PULL] perf tools fixes for v5.15: 2nd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210927185026.389135-1-acme@kernel.org>
References: <20210927185026.389135-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210927185026.389135-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.15-2021-09-27
X-PR-Tracked-Commit-Id: 4da8b121884d84476f3d50d46a471471af1aa9df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0513e464f9007b70b96740271a948ca5ab6e7dd7
Message-Id: <163277851155.31120.5474009644532300705.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Sep 2021 21:35:11 +0000
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
        Colin King <colin.king@canonical.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Like Xu <likexu@tencent.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Mon, 27 Sep 2021 15:50:26 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.15-2021-09-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0513e464f9007b70b96740271a948ca5ab6e7dd7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
