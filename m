Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0116FC64981
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Jan 2023 21:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbjAFVTR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Jan 2023 16:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236439AbjAFVTK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Jan 2023 16:19:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9047581D56;
        Fri,  6 Jan 2023 13:19:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4319CB81ED3;
        Fri,  6 Jan 2023 21:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1AE2C433F0;
        Fri,  6 Jan 2023 21:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673039944;
        bh=PknL4V4dbB/FaxNF+2pj+8UrK1gMTNqJOnOhQHG+HEU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n9xK5Sg/yVrQvgjU5UDcO6GtZO7QyBi/Rmz7qxedLqkPYvP69XtKB5NON14RsdMO6
         qgMCiQwuaiKPxZU1VsojNSgeY8WMytQUN6xzcOYK2iUXp0+pjwDjzus8s7fNAiybLk
         0O+qKNAZ17E+8QVkXiN6Odwa61jx4rfWp+c9Yhtuz/IA1475vGPhjb+Ux3EsLYZm8m
         G34OcxzI4eStMiJZmhXdPZmfuqQ1vTa1Eic7rAxhBwp2mo2eSloiwLIXgpeIOR5fev
         Pp0ZAeiaJ/KYGE+giLInYzCq+CjuQCRAUKqYQKrhRBSDCU9VQBbrd7tEyfZqJqiODl
         vk51UWmMK4z7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8885E270EC;
        Fri,  6 Jan 2023 21:19:04 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v6.2: 1st batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230106142256.763489-1-acme@kernel.org>
References: <20230106142256.763489-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230106142256.763489-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.1-1-2023-01-06
X-PR-Tracked-Commit-Id: 481028dbf1daa2808e1be06f6a865b5fe5939efc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 56f814583923a782f1cec43db32bc6da1d3cf7b5
Message-Id: <167303994475.10294.4266917668830508448.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Jan 2023 21:19:04 +0000
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
        =?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Eric Lin <eric.lin@sifive.com>,
        Ian Rogers <irogers@google.com>,
        Jesus Sanchez-Palencia <jesussanp@google.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Torsten Hilbrich <torsten.hilbrich@secunet.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Fri,  6 Jan 2023 11:22:56 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.1-1-2023-01-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/56f814583923a782f1cec43db32bc6da1d3cf7b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
