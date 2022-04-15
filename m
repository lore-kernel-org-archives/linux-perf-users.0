Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C55EC433FE
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Apr 2022 18:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347577AbiDOStc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Apr 2022 14:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347317AbiDOStb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Apr 2022 14:49:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA0B673FE;
        Fri, 15 Apr 2022 11:47:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 491F460F02;
        Fri, 15 Apr 2022 18:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0778C385A8;
        Fri, 15 Apr 2022 18:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650048421;
        bh=KxUn3iXY/tE0KNlXz3aeopklm2WuiRMtaEWQMBFgEb8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RY8PEK4jUj92oSOpsTAXfislJLJUpdWbRqnMm6GBs5s79WsDwxWvH27/ShGtT6r4k
         8AuzrDrPXJjbowjesc9fGRpfMJgqlW7UmGXTx/4Jm8WfYQoJJ9JL3xljLPymek8Rd6
         frQyuJNnBkZz+rqwsMmAVC60a7l55Z5fbs/6Z4XaQhKAV/kbaXXqGZfFqUDfp3pYZR
         SZ9B+Pf9TXkArxVs3t5lQujz/T9Ia/2Z6r2pWVffD4FGcRLFOvps1et336Ej1HBbI2
         vGPDP1o3FTk75Td0HgtL+sNyo+E68IMllpGsW3ES+qxpSHvn3V70Gq159jr1oK4fc0
         /35vo5ftJeqTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8AF39E7399D;
        Fri, 15 Apr 2022 18:47:01 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.18: 2nd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220414232954.237812-1-acme@kernel.org>
References: <20220414232954.237812-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220414232954.237812-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.18-2022-04-14
X-PR-Tracked-Commit-Id: f58faed7fb3f784efdbf3b401368dcf51a6e28fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2dec4884454650a87d31206e7cfbc566665ebe6
Message-Id: <165004842155.6717.2837954775260237359.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Apr 2022 18:47:01 +0000
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
        Alexey Bayduraev <alexey.bayduraev@gmail.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Thu, 14 Apr 2022 20:29:54 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.18-2022-04-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2dec4884454650a87d31206e7cfbc566665ebe6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
