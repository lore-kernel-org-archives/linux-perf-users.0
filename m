Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3262EE49A4
	for <linux-perf-users@archiver.kernel.org>; Sun, 10 Sep 2023 18:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbjIJSIv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 10 Sep 2023 14:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjIJSIu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 10 Sep 2023 14:08:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87A9188;
        Sun, 10 Sep 2023 11:08:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81B86C433C8;
        Sun, 10 Sep 2023 18:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694369326;
        bh=J0aaIBeWFyBrzvKntuSVVFSamTzOmO++30dugFF8XoI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=of7eB3fAgWSOZLU8dnQSHEiNfMK/S+wWxXj57amNjbPXGF5f/oN7R7SlZpX/yrUC7
         CWx8GdXFf4xAL3zVlBf/l8mHAjwi2ZaUyWmiooMvc/A9sMojGUUSLofNB76UnjbGNY
         AWaz7FH7pERw/kUCFBTG2yr5zCtkIS+JYOeC27vnL/FKse1sqJmZPCUIyUg1HkHxbQ
         KmRbu8Lw5PmamPSfrUqm5qATargBYWnhdF8QWRoXZWE6uavq85nPsysJXLGMNgwHS9
         jy5vuND4v6s9Ji/ahqjNFqK1vmjv2sM0r/Xlks0HPnr9XBxc9wyRQuxmRJz4UFf6i0
         v2EA+SgGYbBtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6CA64C04E27;
        Sun, 10 Sep 2023 18:08:46 +0000 (UTC)
Subject: Re: [GIT PULL] perf events fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZP3s4yKcWtgCn6zb@gmail.com>
References: <ZP3s4yKcWtgCn6zb@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZP3s4yKcWtgCn6zb@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-09-10
X-PR-Tracked-Commit-Id: 6f7f984fa85b305799076a1bcec941b9377587de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e79dbf03d87b2d9978d76ddc1c06424b07b215ad
Message-Id: <169436932643.25650.16162340598525455096.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Sep 2023 18:08:46 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Sun, 10 Sep 2023 18:20:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-09-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e79dbf03d87b2d9978d76ddc1c06424b07b215ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
