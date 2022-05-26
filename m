Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0738C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 May 2022 00:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345945AbiEZAJg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 25 May 2022 20:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348086AbiEZAJQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 May 2022 20:09:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597D8644C4;
        Wed, 25 May 2022 17:09:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB214615A7;
        Thu, 26 May 2022 00:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48A81C385B8;
        Thu, 26 May 2022 00:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653523753;
        bh=jTLBYobhUkBsdmzoU4YpAWuG9pJVRc2HjmMPnus4QFI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cHrLIj8CKcT94pmnHnJj7XusJRMMoCdiuqzIn2YQVlZdHxn+ltd5jM4axqlqy48qi
         HaWcMkgwClPXoaKUSrKUFiuLKxF95tOAlWgxbHa/mTTBtQeUUEih3yhH3a3cec3JPw
         LdvoSdyDKRG3Y2YgbWjKT3lXtvPpXLEbNTNuAcn94TwKilcjpsqadlQLsEoRMiZDZ0
         heDlv4PZ9LV/rqzJmLVeirVA6cBxcViGSwCdyoRL3W2jc5oq3WTb1wEd7wBBH887TL
         Aqqbc0QAgFgI/ReSAb5arMkdJFO9qdCxj2IcnCUJnB8GoDLdFom8/9cblaKKoo1kLS
         JEzOlrECRXs1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35D7FEAC081;
        Thu, 26 May 2022 00:09:13 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v5.19: 1st batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220524014938.46153-1-acme@kernel.org>
References: <20220524014938.46153-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220524014938.46153-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.19-2022-05-23
X-PR-Tracked-Commit-Id: 5d2b6bc3a6a27ad265d2ec0d53dd7ef33bd314fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d223575e50f8da0de358c0098defd560069ecf66
Message-Id: <165352375320.5177.3664357052040729431.pr-tracker-bot@kernel.org>
Date:   Thu, 26 May 2022 00:09:13 +0000
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
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Eric Lin <eric.lin@sifive.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 22:49:38 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.19-2022-05-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d223575e50f8da0de358c0098defd560069ecf66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
