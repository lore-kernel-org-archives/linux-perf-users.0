Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CB8C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 Oct 2022 00:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbiJ0AsR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 Oct 2022 20:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbiJ0AsQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 Oct 2022 20:48:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CA6136405;
        Wed, 26 Oct 2022 17:48:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27444B8247D;
        Thu, 27 Oct 2022 00:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C355CC433C1;
        Thu, 27 Oct 2022 00:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666831692;
        bh=yDklc4TEKnq9VGMNLsKPGOZls6jY/WfmMQY12fzC6Lc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=baYJuuz/HtM371OYQKmmFHy/WocO7OaI8hafkH+BJ2rtMliT1Lu+d/zl5xlOKXMnC
         oCI2q1TwnSaLy6TXCYe3shkFp4tKakXPpARDSOI4Bf4qPUkoocd5HLya0rSduz1RNh
         lP9XNQlYBxHiGfGDwtvu0THR6hCzJU/iLImAbVHbsCzHb76Fe2LH4SWykGtFbRlydO
         hQL6tLKRC6yK3CESZnkV4O7Gzy9lOFYQnToTH0JnDYC7PEPigER0tgzN1vJ6zuh+2l
         p5QtGJsxp6hvBqw7dSBn1PyVqkqoiLNO7SOX0IOIxtGfpZgLapsdCaWW8m7BB0/51g
         QFNCOL+fgsx0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AFD53E270DB;
        Thu, 27 Oct 2022 00:48:12 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v6.1: 1st batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221026204443.158004-1-acme@kernel.org>
References: <20221026204443.158004-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221026204443.158004-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.1-2022-10-26
X-PR-Tracked-Commit-Id: e9229d5b6254a75291536f582652c599957344d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b229b6ca5abbd63ff40c1396095b1b36b18139c3
Message-Id: <166683169271.19821.16573738554538675135.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Oct 2022 00:48:12 +0000
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
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Greg Thelen <gthelen@google.com>,
        Ian Rogers <irogers@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Shang XiaoJing <shangxiaojing@huawei.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Wed, 26 Oct 2022 17:44:43 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.1-2022-10-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b229b6ca5abbd63ff40c1396095b1b36b18139c3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
