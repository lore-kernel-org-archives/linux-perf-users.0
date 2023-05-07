Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7511FC77B7C
	for <linux-perf-users@archiver.kernel.org>; Sun,  7 May 2023 19:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjEGTPf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 7 May 2023 15:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjEGTP2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 7 May 2023 15:15:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAEE13C28;
        Sun,  7 May 2023 12:15:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2547D61CBC;
        Sun,  7 May 2023 19:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7865EC433EF;
        Sun,  7 May 2023 19:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683486918;
        bh=uqqu4+9EOa2w9xo8vDdNyUe++sZfhXyV4IMflcNTXnU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rvkNAxccLCkIxY9r1rPPCIxUpSOTSLsBv2kpaMpTfilQQKnaZTeBDDi0nUxqvMBrc
         84qnHusdlwpITdJiz1n1X8SsN+OkJGemPc05gJkhBdt8Q4+BMhkWJhU+cy5rEXfpN/
         Cib33XHFWSNq4rKFovVf9edMaPI88xGgsT2Kw/HyW7HoIgzis7O3YKK2yYVENPhS8p
         w65xifWFV22xVofMJw6Di+hTsd8OWptNiqcRiPNQj7uDpsiIkJfPmotV5QDXuYBhfT
         1GZ9I6QD9cEJZNfPX/yVoTg0YbKQuWmjsiefDV2/XtUevIngvXPK0+DBHoX4wr1ypk
         QN4F8TZy1IUWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61F80E5FFCC;
        Sun,  7 May 2023 19:15:18 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230503211801.897735-1-acme@kernel.org>
References: <20230503211801.897735-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230503211801.897735-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v6.4-1-2023-05-03
X-PR-Tracked-Commit-Id: 1f85d016768ff19f060f3cce014a43c761de8259
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ecc68ee216c6c5b2f84915e1441adf436f1b019b
Message-Id: <168348691837.15765.8609071749059546846.pr-tracker-bot@kernel.org>
Date:   Sun, 07 May 2023 19:15:18 +0000
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
        Changbin Du <changbin.du@huawei.com>,
        Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Roman Lozko <lozko.roma@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Wed,  3 May 2023 18:18:01 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v6.4-1-2023-05-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ecc68ee216c6c5b2f84915e1441adf436f1b019b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
