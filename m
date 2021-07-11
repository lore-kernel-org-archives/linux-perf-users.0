Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5D4C07E96
	for <linux-perf-users@archiver.kernel.org>; Sun, 11 Jul 2021 18:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B43C6610E5
	for <linux-perf-users@archiver.kernel.org>; Sun, 11 Jul 2021 18:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbhGKSYz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 11 Jul 2021 14:24:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231284AbhGKSYy (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 11 Jul 2021 14:24:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 94005610CB;
        Sun, 11 Jul 2021 18:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626027727;
        bh=E1VtGmzoVKxaGP0CiLhEmL9NHK1CXxyOsprbQytnoA4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FNgAPKUJX3URNPDf2IAIaFf7Cm67TNufbg+dWUXhRb0pNHUPEocJi6juQieSN0qV7
         sXzSMvAuUQ1qlVOtIXuk3boqg07/XWA+UYMTtpFDfNwEaA9lu/JHDPkEte8DUvuikt
         QypC+UL9cA5lPykKsKwzuZaFjb3U+dKworITModpj5BIys1MMvYjsDQcAvCfztgtvd
         qR7gOL4TMmUc+FQ9ywoJGzVpifAUVcMIW28UF+kj8yaVLUJrQxJamRDPFB5d3uuzII
         gJU5zGUvqrObP77HC8T1dUP3Lu470AgKpGGjpsFgAvOWaEorUVpVvfkXeREoJ6wN1m
         tXjclomnz3Fow==
Subject: Re: [GIT PULL] perf tools changes for v5.14: 2nd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210710205240.1343120-1-acme@kernel.org>
References: <20210710205240.1343120-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210710205240.1343120-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.14-2021-07-10
X-PR-Tracked-Commit-Id: eb7261f14e1a86f0fd299a2ec408990d349ce3d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b1412bd75abe8b1c57ecca4a85f92c8ddb4ccd39
Message-Id: <162602772745.20558.13948980429567261337.pr-tracker-bot@kernel.org>
Date:   Sun, 11 Jul 2021 18:22:07 +0000
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
        Jiri Slaby <jirislaby@kernel.org>,
        "Justin M . Forbes" <jforbes@fedoraproject.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nageswara R Sastry <rnsastry@linux.ibm.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Sat, 10 Jul 2021 17:52:40 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.14-2021-07-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b1412bd75abe8b1c57ecca4a85f92c8ddb4ccd39

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
