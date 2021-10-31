Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E470DC433F5
	for <linux-perf-users@archiver.kernel.org>; Sun, 31 Oct 2021 19:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B811660E8F
	for <linux-perf-users@archiver.kernel.org>; Sun, 31 Oct 2021 19:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhJaT1Q (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 31 Oct 2021 15:27:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230291AbhJaT1Q (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 31 Oct 2021 15:27:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B70E960EB8;
        Sun, 31 Oct 2021 19:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635708277;
        bh=MuXIfCp3C6UdWx3sS05cqVSn7TkInpkw5aQXku6+aCs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=e9PmpQREAoiuipawsVn3JXmNcxavSXmPwGsQP/6l/Nr2tp26TAoFiFjUA2a0vfM9f
         Nq0ReugTj7vZ0uwdIAP05iqOoMTOxMeZUT+GpmpVYp7H1+GFXqfMAEmIC+NZsBCrir
         NHOqsgwa+x72/bDzaM322lLxRGJipxKBXzF9SWb8D22OtOJ/kQpsEXzxlDJORU3Nbk
         RRkoijZ7a8guE1F0dLCsjx1dArqZ2OA6dUvl9lyCl+YbZJWKI4B3+O5TnUAAtbsdqx
         XBOqFLhE52WaFYIoV4FGt7Ht+Sv0st2wgDjAsDNN+KC9H/sbcpplqA+mufhabK7z4R
         pZN8PNzxMPhqQ==
Subject: Re: [GIT PULL] perf tools fixes for v5.15: 5th batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211031172234.1028822-1-acme@kernel.org>
References: <20211031172234.1028822-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211031172234.1028822-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.15-2021-10-31
X-PR-Tracked-Commit-Id: 27730c8cd60d1574d8337276e7a9d7d2ca92e0d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 75fcbd38608c3ce9f4dc784f2ac8916add64c9a8
Message-Id: <163570827760.30704.9340964593469438546.pr-tracker-bot@kernel.org>
Date:   Sun, 31 Oct 2021 19:24:37 +0000
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
        Adrian Hunter <adrian.hunter@intel.com>,
        Joe Mario <jmario@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Sun, 31 Oct 2021 14:22:34 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.15-2021-10-31

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/75fcbd38608c3ce9f4dc784f2ac8916add64c9a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
