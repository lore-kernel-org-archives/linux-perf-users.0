Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332DAC433B4
	for <linux-perf-users@archiver.kernel.org>; Sat,  1 May 2021 19:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7536613CD
	for <linux-perf-users@archiver.kernel.org>; Sat,  1 May 2021 19:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhEATfO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 1 May 2021 15:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231556AbhEATfN (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 1 May 2021 15:35:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8FB0D613AD;
        Sat,  1 May 2021 19:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619897632;
        bh=kDN2nlfsi6/KnbTkNqD7tL6K/EHafQy0xAF9Rz2GfZE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=R6F5pcu+tGas0zwFYiFePJB5iLzBHxcNv+eBiiFECVPUCO9vqIMe9rskvFePrw9Mm
         tqwPR/2mXqmunlGs3DHHf1Kectt34E4zf6oyJW4eOkdYmIAVR/KPm64fewqcb6khw5
         yzqn46UswbPIHh2hTXM3qqm+GFt2Cz9AVIbKgGJvIeTQ6dZKq3jlYHUcC9SJ49j8lD
         2JZgvDJes+nWAA8nfZyeK6vitqceDJlbasm9eopY582Io2Q4abTxABm0q62NErG2jg
         KM1L6mJOrNquDtT1KNUvb55wrKktf7zwnMe0angBQOhl1NW6yuSb1K05/u3RRNoMsW
         LSOvvAbJpIW+g==
Subject: Re: [GIT PULL] perf tools changes for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210429211516.2748106-1-acme@kernel.org>
References: <20210429211516.2748106-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210429211516.2748106-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.13-2021-04-29
X-PR-Tracked-Commit-Id: c6e3bf437184d41d885ba679eab0ddd43f95db56
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 10a3efd0fee5e881b1866cf45950808575cb0f24
Message-Id: <161989763241.29777.12736155921673673221.pr-tracker-bot@kernel.org>
Date:   Sat, 01 May 2021 19:33:52 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Archer Yan <ayan@wavecomp.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Changbin Du <changbin.du@gmail.com>,
        David Daney <david.daney@cavium.com>,
        Fabian Hemmer <copy@copy.sh>, Ian Rogers <irogers@google.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>, Leo Yan <leo.yan@linaro.org>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Mike Leach <mike.leach@linaro.org>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Ralf Ba echle <ralf@linux-mips.org>,
        Ray Kinsella <mdr@ashroe.eu>, Rob Herring <robh@kernel.org>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Song Liu <songliubraving@fb.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Vitaly Chikunov <vt@altlinux.org>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Xiong Zhenwu <xiong.zhenwu@zte.com.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Thu, 29 Apr 2021 18:15:16 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.13-2021-04-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/10a3efd0fee5e881b1866cf45950808575cb0f24

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
