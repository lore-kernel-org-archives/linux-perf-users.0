Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18B7C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 17:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B868F61350
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 17:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbhKHRmI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 12:42:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:50098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240931AbhKHRmI (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 12:42:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9A634619A6;
        Mon,  8 Nov 2021 17:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636393163;
        bh=0iFP3OtgvdA9uhz5ybB4Ym9SxyFymDDyWrAidabHht4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oLFvX2h9/bit7VLGjQjvK94VaXAjK5j+syQdHbl3NPfHox3JCW6l+IODpZKwYZKHF
         JOAhJVhw9ij+kTmMvTztU51Z6LMsuT2sbJATg6j37Oe+EBYZy+njcRzcP7+fp3XMAh
         vBrymGs4VmA0ESAbN4ILbyBkUmoeP/v4Sl20Zz93xdKqpsIaf4ylOhEp6KCPGfqQtz
         qpG6hY31ZjqGHhs25o8ytRft1maA/NDSEE3Vv2EQPlBGeOCA46sYa4/wx2tsQyLPe7
         mDy1lAZuszUozC/sPr6IxJ7udG+yONpQmnzu5diEaf4/Fd0710l25Z6YXPuhFBKinN
         dHbytToBorR2Q==
Subject: Re: [GIT PULL] perf tools changes for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211107204947.1394255-1-acme@kernel.org>
References: <20211107204947.1394255-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211107204947.1394255-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.16-2021-11-07-without-bpftool-fix
X-PR-Tracked-Commit-Id: 6b491a86b77c0dc323ca49f3a29a0f67178b75f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bbdbeb0048b443082bcce5ed65a336bcc578a60e
Message-Id: <163639316357.31155.5257507232974495649.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Nov 2021 17:39:23 +0000
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
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Denis Nikitin <denik@chromium.org>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        John Keeping <john@metanate.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Lexi Shao <shaolexi@huawei.com>,
        Michael Eller man <mpe@ellerman.id.au>,
        Michael Petlan <mpetlan@redhat.com>,
        Muhammad Falak R Wani <falakreyaz@gmail.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Tony Garnock-Jones <tonyg@leastfixedpoint.com>,
        William Cohen <wcohen@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Sun,  7 Nov 2021 17:49:47 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.16-2021-11-07-without-bpftool-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bbdbeb0048b443082bcce5ed65a336bcc578a60e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
