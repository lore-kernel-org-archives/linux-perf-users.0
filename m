Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE3EC433FE
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Sep 2022 23:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiI3XF2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Sep 2022 19:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbiI3XFX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Sep 2022 19:05:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A69138A3E;
        Fri, 30 Sep 2022 16:05:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83D06B82AB8;
        Fri, 30 Sep 2022 23:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2668BC433C1;
        Fri, 30 Sep 2022 23:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664579117;
        bh=KKnpDwy0z0NMAinMrUZI7nWLSvBCwLJfTmdtIYZcP18=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BfVUmZcxzgDgf2jsqDaxAtVJEdGnNDJHlAMAEMbhfDVvUDS8tPLslTjECsmFyELAk
         YW8bzWh9oMcmWLyCeksfYzHOskdo2XmcEkcgrrb3Uj6TeVURD6dk1RYvQTDYBHOjCA
         GaawbQpnNNgrYVehBORspA6/CHTYpyKrtDBKCiArspoQfYM6ETZaleCj/GU9dLxI3o
         9kfKNTYj5N+dIjWITclDr2M8taKhIbAxc8IIHGvKAAW7LjZ9gecJ3xaVkm/HRPdsba
         q+nyl9Pvf8RhLvt8tCPaC+kQ9XOeDtzFwS3FuXLqsul9391hjmw5wLE5Ix697UzpA/
         j6o2paNhktXhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0DBDAE49FA5;
        Fri, 30 Sep 2022 23:05:17 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v6.0: 5th batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220930003316.62853-1-acme@kernel.org>
References: <20220930003316.62853-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220930003316.62853-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.0-2022-09-29
X-PR-Tracked-Commit-Id: 8e8bf60a675473a034ecfcb7a842b98868ed74a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c816f2e9813d218b36343c67b443c77c539ea294
Message-Id: <166457911701.27763.15288640570510111212.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Sep 2022 23:05:17 +0000
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
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Yi Ammy <ammy.yi@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Thu, 29 Sep 2022 21:33:16 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.0-2022-09-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c816f2e9813d218b36343c67b443c77c539ea294

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
