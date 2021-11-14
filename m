Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7AEC433EF
	for <linux-perf-users@archiver.kernel.org>; Sun, 14 Nov 2021 17:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 873A160F41
	for <linux-perf-users@archiver.kernel.org>; Sun, 14 Nov 2021 17:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbhKNRzV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 14 Nov 2021 12:55:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:35420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229725AbhKNRzV (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 14 Nov 2021 12:55:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 42358608FE;
        Sun, 14 Nov 2021 17:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636912347;
        bh=HcIt+1H5ZwCqWSNhS3Zbxl3eT+i+IoUwBRUTJvsuok4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HgvbVrGceamAluVHheREaA6A8EVV2F2+DgM2/dTD7UbgGKGlnvOKddKJ3njLT5JUV
         pNgbGanw59CV8RQ2eJalIUkGmK056L/xsp3fylJEsTYHez0b667eqBC4Lh7LGPo4AY
         0L2+6nMQjl2nCFU/a85B1Vw+qpXXwtKefgMQ+XYNZm4W+yO6kpTx0JO0MHEi0oERi7
         J5vNslf+V5H47g22ju3kukYbmtpGdgHOCnX51QZ8zlOrpMJsxDsoxs2CHbLZq1qERK
         53+o4e3MDfBWJo+bj/AAkvkPGezg3aQoriW3O4Qk0jJNAGXgxafYMhMLErkxG6GXsq
         VX1QegauXzzWw==
Subject: Re: [GIT PULL] perf tools changes for v5.16: 2nd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211114012258.33507-1-acme@kernel.org>
References: <20211114012258.33507-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211114012258.33507-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.16-2021-11-13
X-PR-Tracked-Commit-Id: ac96f463cc9aebb00ca7bbee47efb0794dfd0f3f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35c8fad4a703fdfa009ed274f80bb64b49314cde
Message-Id: <163691234711.31405.9427532504370663937.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Nov 2021 17:52:27 +0000
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
        Andrew Kilroy <andrew.kilroy@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>, Leo Yan <leo.yan@linaro.org>,
        Like Xu <likexu@tencent.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Sat, 13 Nov 2021 22:22:58 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.16-2021-11-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35c8fad4a703fdfa009ed274f80bb64b49314cde

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
