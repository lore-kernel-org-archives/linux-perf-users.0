Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260F2C25B4E
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Jan 2023 18:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjATSq7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Jan 2023 13:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjATSqy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Jan 2023 13:46:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA956FD29;
        Fri, 20 Jan 2023 10:46:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BD3BB82793;
        Fri, 20 Jan 2023 18:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05F7CC433D2;
        Fri, 20 Jan 2023 18:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674240412;
        bh=qgmVGhk7ebaz/HhDm5NfJBCHN0VVopGRs7nDDqtp0Ug=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=StK2FBam2ep9Pu5d6nhYAkeYZiDp/L4lpdjAkxXCan5iSvyIp1Dc+hoPZq5KtN7Kx
         bY3b0Jf6y4nongvdG09+ZqiKlU6hbSBFaXpqvxy5Z/yA0ttU8x0yAy0ztDefPSJqxI
         3GeZKBl1pPXbDOaZucUF7kR3doiq2G4FuwaglFdOLCFxMDI4ZpV2tTm7LI1UCwmv3Q
         ZxiLKb1D69biJjCPzehhXq4b6k+Ek8vgHn1sY4LFyU3Z7+bSXQIJO/zMjaTsiw6B0F
         NmVwCnltN03lauYLDpLBlx3DInWG3J7T95FfAgrPGZTowET4OH/SfGXUtsyBzOvu+d
         opnnqTS8J80ug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7BEEE54D2B;
        Fri, 20 Jan 2023 18:46:51 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v6.2: 3rd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230119171510.166368-1-acme@kernel.org>
References: <20230119171510.166368-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230119171510.166368-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.2-3-2023-01-19
X-PR-Tracked-Commit-Id: 3d9c07c4cfc06cf7927cd00c04dffd1165d03c53
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a0c7a6831a0aa56db78a80f5a3e1ad5412d0fa8
Message-Id: <167424041193.21297.9460299615366986566.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Jan 2023 18:46:51 +0000
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
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Sohom Datta <sohomdatta1+git@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Thu, 19 Jan 2023 14:15:10 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.2-3-2023-01-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a0c7a6831a0aa56db78a80f5a3e1ad5412d0fa8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
