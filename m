Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2404CC43334
	for <linux-perf-users@archiver.kernel.org>; Sun, 17 Jul 2022 20:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiGQUaY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 17 Jul 2022 16:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbiGQUaX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 17 Jul 2022 16:30:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70703DF00;
        Sun, 17 Jul 2022 13:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2117CB80EB2;
        Sun, 17 Jul 2022 20:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6EFBC3411E;
        Sun, 17 Jul 2022 20:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658089820;
        bh=RbBeSPcXAsgEE6dXxkn0R7jTn/Jb4gqRMVAcGDND2Eo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=T8eYGFuGyyB04P8KxDRHIoN97hE4i7U29mlPCzOhj+QttbB1/RPg5I9yO7So0aX5e
         uZB+YwSsexVvulc/CwL/kXSlMbfqgwhCcRZqkO7X4LTILIoPCbffv2OIWfQQnMO6WH
         Qw3ZWCEMo+x4LWQpYoot0rKuJ/9inkW/B+8/pyvk50i/s006Ans5AprXFAjKWzCTAo
         /EuXdd/1bSxzGhDtNc0/wX/I1QVRQWSp3zd7nhZLn734d92tcwDTRYcpva3GEANlyD
         1WTvUGUg3MOI7GD8yIsGmHpvbzNgcnSpg1nHWAnb6YCtimw2GGA25qR2vA8c3qfYlw
         YHg4V1pat8jtg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A20C3E45225;
        Sun, 17 Jul 2022 20:30:20 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.19: 4th batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220717172544.47204-1-acme@kernel.org>
References: <20220717172544.47204-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220717172544.47204-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.19-2022-07-17
X-PR-Tracked-Commit-Id: 4b335e1e0d6f8fa91dac615a44b123c9f26e93d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f7f4da303dd8946228860e78bd7f36c2cc47a636
Message-Id: <165808982065.1462.12118315656130413265.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Jul 2022 20:30:20 +0000
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
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Sun, 17 Jul 2022 14:25:44 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.19-2022-07-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f7f4da303dd8946228860e78bd7f36c2cc47a636

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
