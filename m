Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47CFC433C1
	for <linux-perf-users@archiver.kernel.org>; Sun, 28 Mar 2021 20:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89A4761951
	for <linux-perf-users@archiver.kernel.org>; Sun, 28 Mar 2021 20:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhC1UZf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 28 Mar 2021 16:25:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231489AbhC1UZY (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 28 Mar 2021 16:25:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D26A66186A;
        Sun, 28 Mar 2021 20:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616963123;
        bh=B86lE1aCWFd2fQbiCl+iMxNQ1SIRLjYfWsfMed+CHhc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l2WSgzVm0Rfxezq9TQrwIaRI7i9QluLwPf9XOVkMjg9Ta1BjIm7T+o1lmL3+sLOnL
         qmUrPbt+pmyEQd5nCSmRcRHNrCIllauUdmx7ZeEmBUraikYuFCbp7H7XdOprN+PpqS
         NHZgWhdvs6eH6/C9rs9SCtUlvL2FxxvDwe96Jn3riOWtfa4Bk71QLMjwdNkFbf7/Ls
         oCtCE1i/tm78nCeyhPG3vNo4RTFvC29I65vn/BQ6387CN6xQkLHZaKKFQsZCGfdeh8
         X92FGLxNs1XZKG6NFU02YsAWxfsmQTFD/EQwv7mFOkDn04H886Sz0f/UnAMnp/6q4V
         IVcQy7BtMp8UA==
Subject: Re: [GIT PULL] perf tools changes for v5.12: 2nd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210328183838.1529920-1-acme@kernel.org>
References: <20210328183838.1529920-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210328183838.1529920-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.12-2020-03-28
X-PR-Tracked-Commit-Id: 1dc481c0b0cf18d3952d93a73c4ece90dec277f0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f9e2bb42cf0db3a624d295122db3475aa3e7ad18
Message-Id: <161696312380.20511.11522597886520743848.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Mar 2021 20:25:23 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Jackie Liu <liuyun01@kylinos.cn>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Sun, 28 Mar 2021 15:38:38 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.12-2020-03-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f9e2bb42cf0db3a624d295122db3475aa3e7ad18

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
