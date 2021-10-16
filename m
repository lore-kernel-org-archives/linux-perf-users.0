Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B142C433FE
	for <linux-perf-users@archiver.kernel.org>; Sat, 16 Oct 2021 18:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA98A6120A
	for <linux-perf-users@archiver.kernel.org>; Sat, 16 Oct 2021 18:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244534AbhJPSd2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 16 Oct 2021 14:33:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240331AbhJPSd1 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 16 Oct 2021 14:33:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6B732611AF;
        Sat, 16 Oct 2021 18:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634409079;
        bh=00uZBzqaHbR8YzwXalsaf0xQALYAxZHIh7dNQMzA/VQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bKWsDYaalHxSsSGBXs16aE+sbf3m08VdRZRfawUcK5os2h3IBf7F0OkroU+up3y9q
         Y/Ynd0xaFXmcF7fE1dk0FAn56aRVQKz3GhyjBts5fhRZLGn+ZwK90TWj+H60Tw3fPB
         XKrjP02oO2d60UoQrkWYybOY98ZexiIeOCY9QXBKB1rsg7IYQKyzTuqsY2nD2Wipbi
         D2J3PpC2g4vxo+yx9EH1cjtnRh5PZbQW209xR7SegYelqwSwABc9HR80/66KyklvzZ
         ZbeWoybDtm9z8Q4PdzRQa2ql+h4HuIOzRlNuIwbu4GbkYbqWDXxgmu6VEUPrF0iVGQ
         eCdrQJi1TmfDA==
Subject: Re: [GIT PULL] perf tools fixes for v5.15: 4th batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211016113523.791937-1-acme@kernel.org>
References: <20211016113523.791937-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211016113523.791937-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.15-2021-10-16
X-PR-Tracked-Commit-Id: 3ff6d64e68abc231955d216236615918797614ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d999ade1cc86cd2951d41c11ea769cb4452c8811
Message-Id: <163440907936.17248.725481396149753023.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Oct 2021 18:31:19 +0000
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
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Sat, 16 Oct 2021 08:35:23 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.15-2021-10-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d999ade1cc86cd2951d41c11ea769cb4452c8811

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
