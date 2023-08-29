Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7173C83F13
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Aug 2023 00:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbjH2AX5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 28 Aug 2023 20:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbjH2AXs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 28 Aug 2023 20:23:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9158109;
        Mon, 28 Aug 2023 17:23:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AD7A62BDD;
        Tue, 29 Aug 2023 00:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF005C433C9;
        Tue, 29 Aug 2023 00:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693268625;
        bh=8YhGzn8vr/PxhY4sMDFaC5u137fjxNMyv1VUZPybOhg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=okT4wDLJXHO1ysZRNskIs1O8vM871BsFGCsC0fMxhiy0D7gTGOmem5kQC0z5H+49U
         xJR+hnkDSvOUKULCKf89dO6ngh3cTvqAVDt/zBBMuppLk4T5hEJk+D8TZU6ax6TATs
         jiaxjRRuRG1h7kf8ILeF4Vfat7nIX9qJvG607FtQ90PtFlrGFndKK4I47UtBJLvVZE
         IU5LAsLfPdUSz9uxrfKVFfA/ROYB0Q39BVLiu2N/tQLLsgaiEVB4bkhamFcmlapmlJ
         cU2HsY0MGpevW6gPxx376alQ2+wjQQ9tCA2zVn6PYAAc3208ukJX1gLk2XUOX1cgyp
         Me/PZ2/hiqdxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9BCFDC3274C;
        Tue, 29 Aug 2023 00:23:45 +0000 (UTC)
Subject: Re: [GIT PULL] perf event changes for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZO0HMo6QD+l/uvWz@gmail.com>
References: <ZO0HMo6QD+l/uvWz@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZO0HMo6QD+l/uvWz@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2023-08-28
X-PR-Tracked-Commit-Id: 2c65477f14a359db9f1edee5dd8e683d3dae69e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a7c611546e552193180941ecf6b191e659db979
Message-Id: <169326862563.9848.8297650919521441415.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 00:23:45 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 22:44:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2023-08-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a7c611546e552193180941ecf6b191e659db979

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
