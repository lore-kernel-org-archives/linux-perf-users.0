Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137CFC3F6B0
	for <linux-perf-users@archiver.kernel.org>; Sat, 20 Aug 2022 21:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbiHTV7r (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 20 Aug 2022 17:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbiHTV7m (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 20 Aug 2022 17:59:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB3C27B30;
        Sat, 20 Aug 2022 14:59:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56CAE60BD3;
        Sat, 20 Aug 2022 21:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AED94C433C1;
        Sat, 20 Aug 2022 21:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661032779;
        bh=+UQtVeg/mBt3ZYbAYsNppNACGD8ZIrHD1zXagvj8Xww=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HbBN5mvq3SF30nCvftoiPmwL5oDGH9qU2xaWIoQqi+wwuQI+yEqlf7qRsVJpSoGbF
         +ExMMI2kLzYOuid5x6K3gorAYSidffPSJFctwCOI7c14jSZvZRcJGHRRqNC9mAJPGP
         jyE0P1RpKqkpv5Ak/kd12Rt7FN6ZYmnILO4KUQ4O9FT1GzL1x7t0aBe3zFdh1Uj6rJ
         h5Ct+LP54yKkaMa7j21Fb9eu/6ItR6RwMB8tr7Itu/YkrGWITPnCbNbnjZmpIEDde7
         OxgwcZ6Ocrg2XG6URddjICyvRqzrNUZ0xaQHItEvbrw7C/8ngPeyTvUGzJEYsDmQme
         TE7a9xdRp+0bA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C51AE2A053;
        Sat, 20 Aug 2022 21:59:39 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v6.0: 1st batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220820011109.25811-1-acme@kernel.org>
References: <20220820011109.25811-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220820011109.25811-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.0-2022-08-19
X-PR-Tracked-Commit-Id: f52679b78877f17e95a317e18a4c9c46cc3d845a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 16b3d851c0146123507fe864fdd97411ded51147
Message-Id: <166103277963.18400.15000815346355554395.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Aug 2022 21:59:39 +0000
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
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Fri, 19 Aug 2022 22:11:09 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.0-2022-08-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/16b3d851c0146123507fe864fdd97411ded51147

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
