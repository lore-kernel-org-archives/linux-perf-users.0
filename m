Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69481C00144
	for <linux-perf-users@archiver.kernel.org>; Mon,  1 Aug 2022 19:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbiHATzc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 1 Aug 2022 15:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbiHATzV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 1 Aug 2022 15:55:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32B9B6F;
        Mon,  1 Aug 2022 12:55:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71BFA61373;
        Mon,  1 Aug 2022 19:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4BE5C43142;
        Mon,  1 Aug 2022 19:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659383717;
        bh=BekN5jAjj47WwzmSZBRvLlshdjxJFDD9d0mvWw6oXRQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cLZRxIBt1u8/uTeVa+O40/DGkzzoVXYQ0EaoW/wyv9tGf3qZfKtgr5LnDpc+cDkde
         JAPlgO5CL5wPz6ObOOnamMOIkv1Vh+s/P8ZbxAqkBBRvkcEsgqp4WlzI5PmBUTldFU
         RDXbh31D+emlOQN+6Q1URgMhHemCcslMKG8aB1Cb2QoKXhulgU3X7PIXLh2l/99CHj
         XnT4HLTKJI81epXOVHIopYF1zJnBm0XjgZedeIPIeFu8vgCjE0cVWdnyVSO8G1+TSn
         KsJyDEGUov0awiTcqYjkiSTTahTn4Qlp6tBHHWbJxWhwhRE+3RQ1rMGbUrn9xJaBPn
         l2U/lskaFNLhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4A46C43143;
        Mon,  1 Aug 2022 19:55:17 +0000 (UTC)
Subject: Re: [GIT PULL] Perf events updates for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YufmTs3WbIcjlfyV@gmail.com>
References: <YufmTs3WbIcjlfyV@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YufmTs3WbIcjlfyV@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2022-08-01
X-PR-Tracked-Commit-Id: 326ecc15c61c349cd49d1700ff9e3e31c6fd1cd5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 63e6053add5a6cec4dbfa3dec12e0d4439daac4a
Message-Id: <165938371780.14399.1950720570642156126.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Aug 2022 19:55:17 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Mon, 1 Aug 2022 16:42:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2022-08-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/63e6053add5a6cec4dbfa3dec12e0d4439daac4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
