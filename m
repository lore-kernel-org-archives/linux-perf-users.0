Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465E7C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Oct 2022 17:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiJJRWP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Oct 2022 13:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiJJRWK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Oct 2022 13:22:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D633A26AE3;
        Mon, 10 Oct 2022 10:22:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A877B81059;
        Mon, 10 Oct 2022 17:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B2E5C43144;
        Mon, 10 Oct 2022 17:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665422527;
        bh=hUAcBLSxy7IcFwzqsRD5Q2C2eu1c+DiLNPH/GdAAhw0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=A/sWJGNG8SaCFWSgSAqYcaPJYgSVW8xn+ohBZGSPzW3Ck79rmhjx8irDFYHuBcJQO
         v93i5OKgu+7L5Cr2hTI7xEFlor/STN64IqReIxEX/BXBEdDRv/rbm/kN7UpCGXHbOk
         DJGK+FjKnbEe3aiXzq7/8iT1X60Zwam6MdD94g0OhWbqMLcGRcVAIZhs4aRBMGjltl
         ycd1Psat1+lhl3WbpwWgkDDNIS2WxE6XZ1/8gCdVy7D67bRCMW2S0JTuDlR5stf93l
         Fmpvb5SHVq33t4ANHDZIGfqcaQCOM3x2c5FaXBGtQUn3Z0t1KyTGyLz+Fkl8MnHicn
         ftyowg5h8VpLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2441DE4D023;
        Mon, 10 Oct 2022 17:22:07 +0000 (UTC)
Subject: Re: [GIT PULL] perf event updates for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yz/cpNTSacRMh1FK@gmail.com>
References: <Yz/cpNTSacRMh1FK@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yz/cpNTSacRMh1FK@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2022-10-07
X-PR-Tracked-Commit-Id: 82aad7ff7ac25c8cf09d491ae23b9823f1901486
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3871d93b82a4a6c1f4308064f046a544f16ada21
Message-Id: <166542252714.13651.1176969109294641783.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Oct 2022 17:22:07 +0000
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

The pull request you sent on Fri, 7 Oct 2022 10:00:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2022-10-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3871d93b82a4a6c1f4308064f046a544f16ada21

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
