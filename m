Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61E5EE49BF
	for <linux-perf-users@archiver.kernel.org>; Sun, 10 Sep 2023 03:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346018AbjIJDRp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 9 Sep 2023 23:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345971AbjIJDRb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 9 Sep 2023 23:17:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB1B18F;
        Sat,  9 Sep 2023 20:17:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B043C433C8;
        Sun, 10 Sep 2023 03:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694315845;
        bh=ouyStzZ3ETADqbo0bPWUlWLVuVUFgRfFzX299oq7b7s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Z2Es5jUeXfsH8ZDBWiVAhIoilqpNr014R9j4Eyc5BRnIDxd5/h/FnT+LWYELY+W2U
         aJkbM9ikAvk3K2e24b5/85Pc91rOlhMcRM8Icdcf9M0pUzB3t6imZrFiJkt5Z9gP44
         XFeg9NraEpXP9DbAAFTyaKX0U9oINg79ywF1GW9bMz1yaPC9GR0KPpgQaeOf9mBijt
         05VE5WlNhev/aFU2xkEk+WvGji9HGhWgUDetbmTRD+v+RGbzWPMkGTiENJ/GlLJwA9
         q+j6+t8TmtkHEkNL7qjEzZQ6vzBwgf0rmcbpPJJFyVgljYn2h0MLjUcm3pQljoe6Jm
         Xve3A44T9yKLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0888BE22AFC;
        Sun, 10 Sep 2023 03:17:25 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230906005330.373916-1-acme@kernel.org>
References: <20230906005330.373916-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230906005330.373916-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.6-1-2023-09-05
X-PR-Tracked-Commit-Id: 45fc4628c15ab2cb7b2f53354b21db63f0a41f81
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 535a265d7f0dd50d8c3a4f8b4f3a452d56bd160f
Message-Id: <169431584502.25659.1703863725780355599.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Sep 2023 03:17:25 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Aditya Gupta <adityag@linux.ibm.com>,
        Akanksha J N <akanksha@linux.ibm.com>,
        Anup Sharma <anupnewsmail@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Lu Hongfei <luhongfei@vivo.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Tue,  5 Sep 2023 21:53:30 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.6-1-2023-09-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/535a265d7f0dd50d8c3a4f8b4f3a452d56bd160f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
