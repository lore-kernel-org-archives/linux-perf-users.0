Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15F3C433FE
	for <linux-perf-users@archiver.kernel.org>; Sun, 22 May 2022 00:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347849AbiEVAWg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 May 2022 20:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347815AbiEVAWe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 May 2022 20:22:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006003FBC5;
        Sat, 21 May 2022 17:22:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 819C660EE8;
        Sun, 22 May 2022 00:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4231C385A5;
        Sun, 22 May 2022 00:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653178951;
        bh=uksIx+9OT377IDsqIceomLhankvWe+BJo6pkgd1joDI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IkFCD9NWxpmbJQXU8HNo1IsaunZeUaz+r+khnt2hVfckqrftJOd9TMN/iKKsltxFF
         fwiYmLldmcQ9qeNnUfa5Fp+KUMxKEbFVxIkC/EiTs68rIypfNTvyc9b43IojhRIm8j
         IlaYbXyYmzPZd2gtTGzgzMLcf9cD42FwUIk3YSOcMszs2lXvKquvkXxtP5Js07WlGi
         5E15mdkMSLIhcOy7eOx+Vo6re++MEolksx0KKHjjSvtc1RhFigo0OyntqvFN48TSod
         ujZug13726d2gr41ijwYHquGSOXtOuC1V13goHCn5wS4lMZkh/Ov/vSuYyAqFrcyoM
         4UFxgQ2OTCpkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD414F0393B;
        Sun, 22 May 2022 00:22:31 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.18: 6th batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220521212722.964514-1-acme@kernel.org>
References: <20220521212722.964514-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220521212722.964514-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.18-2022-05-21
X-PR-Tracked-Commit-Id: 51d0bf99b8342be82369aa63eff343bf5df586dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eaea45fc0e7b6ae439526b4a41d91230c8517336
Message-Id: <165317895177.14812.3617530872504754503.pr-tracker-bot@kernel.org>
Date:   Sun, 22 May 2022 00:22:31 +0000
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
        Ammy Yi <ammy.yi@intel.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Avi Kivity <avi@scylladb.com>,
        Chengdong Li <chengdongli@tencent.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Sat, 21 May 2022 18:27:22 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.18-2022-05-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eaea45fc0e7b6ae439526b4a41d91230c8517336

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
