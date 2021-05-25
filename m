Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B5AC2B9F7
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 May 2021 03:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B39B261415
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 May 2021 03:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhEYDDr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 May 2021 23:03:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:51206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhEYDDr (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 May 2021 23:03:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AB30060231;
        Tue, 25 May 2021 03:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621911738;
        bh=00meE9e3uxz2ASWJEmYuflVdwSwqYLstOLlrAlm46Cw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Vhxrd1unWOVEFm7WcSvuyYKsPCgZWj7LYtPiTLPm/vrKwZDPstRpBFzXRBKJpHAF/
         Zd8jwAGLDB8C3Iw782FO+SUL6aLnucbKheFrl2JQMIpKA0U0GlIWBBkHhJS2/18Lef
         Kk2MQ4deM3/k9AtLZorBV2BGil46ljWX06c23n2id5syhELlrQmHn1hhSlm1uYGoIk
         D33zGS4w5eY5lMijkhFhfmrnLyRO1F0trgedChWvLM0LamwlNIcE2KxKfrWHhWd/8h
         j18cuzkrYYpEylZ1RSy6NTatdAdhGyi1i8vudJj8zGlAm3pBP1KA+bZfgMfDHu0tcf
         sPDFsV/KRhrZQ==
Subject: Re: [GIT PULL] perf tools fixes for v5.13: 2nd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210524200028.174578-1-acme@kernel.org>
References: <20210524200028.174578-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210524200028.174578-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.13-2021-05-24
X-PR-Tracked-Commit-Id: f8b61bd20479c094fb421da42fef6b4ff22a589e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a050a6d2b7e80ca52b2f4141eaf3420d201b72b3
Message-Id: <162191173856.27460.1101405891066256642.pr-tracker-bot@kernel.org>
Date:   Tue, 25 May 2021 03:02:18 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Song Liu <song@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Mon, 24 May 2021 17:00:28 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.13-2021-05-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a050a6d2b7e80ca52b2f4141eaf3420d201b72b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
