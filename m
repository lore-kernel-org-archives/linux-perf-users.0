Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC457C433ED
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 May 2021 22:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C601961585
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 May 2021 22:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhEJW1S (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 May 2021 18:27:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230477AbhEJW1S (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 May 2021 18:27:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2141D611C9;
        Mon, 10 May 2021 22:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620685573;
        bh=6y5nw+b7s7UKVVGidUGsvGr2/SyzQlflf97AOq/puu4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=X76hfo9g6WZwGSMgVcwGgxlK+pXxbF+vnMBBKL+gJPKprQTPdR0hBuaHd+UMqnHuH
         sLvkm/FUE97J2v3f6hlMBy2VJ8ATzttStDTfxwRYOmD5DHLpPRs0jG3bjm5gMzSqU8
         ARBXh4oRubwRE7JHSidGOEdKsxRsOjaA5/ESqY31CryJqqMjl8+yl8orU3SAsxCC3Q
         iHifCMdJLz+MOv85q0DpHc4Lv03wM5SQCNPnz6RoBacUakrcZ7FTiD2sWSAElUOU3+
         XYqR0gjQSMW8xY2EdSS+q5rMvhjioiiRljGZ+z562XdJx7Z0dzB7lRzAzbSiV6XTb6
         Mc+7hgrl2osvg==
Subject: Re: [GIT PULL] perf tools fixes for v5.13: 1st batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210510173227.3644165-1-acme@kernel.org>
References: <20210510173227.3644165-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210510173227.3644165-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.13-2021-05-10
X-PR-Tracked-Commit-Id: 71d7924b3e8acaca6a3b0fc3261170031ada3b70
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1140ab592e2ebf8153d2b322604031a8868ce7a5
Message-Id: <162068557299.19579.15583657279839997037.pr-tracker-bot@kernel.org>
Date:   Mon, 10 May 2021 22:26:12 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexey Alexandrov <aalexand@google.com>,
        Dmitry Koshelev <karaghiozis@gmail.com>,
        Ian Rogers <irogers@google.com>,
        "Justin M . Forbes" <jforbes@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Mon, 10 May 2021 14:32:27 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.13-2021-05-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1140ab592e2ebf8153d2b322604031a8868ce7a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
