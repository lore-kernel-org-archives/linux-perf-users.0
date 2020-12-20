Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA69AC4361B
	for <linux-perf-users@archiver.kernel.org>; Sun, 20 Dec 2020 19:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A395323D59
	for <linux-perf-users@archiver.kernel.org>; Sun, 20 Dec 2020 19:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgLTT0d (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 20 Dec 2020 14:26:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbgLTT0c (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 20 Dec 2020 14:26:32 -0500
Subject: Re: [GIT PULL] perf tools changes for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608492352;
        bh=XAsI6jLVQZ1CUkMZ0vnrUGZbK5lhSHx0UIPPrL1h2VA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=s0ste4ccVmdQ6IG8S590bn/xYcGrWsUQ57Lc30wF5ne1GBIe2pcgTnq4QK9rrEMPx
         dDq0xVcTSy8r/CHmms50CxOKkX2RXjRzMwSwS+nl6rT+20nvTyx441R1XrlqQxxeix
         6L18zc6AbYu6m2TLMDjeMrGI6eRI7yv1/puEis9ZxsBOeuXS3dGEQad1Pq+aKHH8qe
         PufqqFLtzfZ/yJj59toRzMcwaAgyNFG+jmu3wEINzLf/sTXiiorVLiK93u7vvWzggq
         oqdqoqkRptkMjB+VTHduuUG1M6O7yNMpf9DKeU3IUv0DsOwDyVXj+iwJEFF3/XVBCE
         /pcu0IwvpxjIg==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201219224648.388804-1-acme@kernel.org>
References: <20201219224648.388804-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201219224648.388804-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-2020-12-19
X-PR-Tracked-Commit-Id: 2e7f545096f954a9726c9415763dd0bfbcac47e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 48342fc07272eec454fc5b400ed3ce3739c7e950
Message-Id: <160849235201.10699.3279617048830298383.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Dec 2020 19:25:52 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Dengcheng Zhu <dzhu@wavecomp.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Peng Fan <fanpeng@loongson.cn>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Wei Li <liwei391@huawei.com>,
        Zheng Zengkai <zhengzengkai@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Sat, 19 Dec 2020 19:46:48 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-2020-12-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/48342fc07272eec454fc5b400ed3ce3739c7e950

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
