Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D09EC433EF
	for <linux-perf-users@archiver.kernel.org>; Sun, 12 Sep 2021 23:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FFE9610A6
	for <linux-perf-users@archiver.kernel.org>; Sun, 12 Sep 2021 23:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbhILXWo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 12 Sep 2021 19:22:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236546AbhILXWn (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 12 Sep 2021 19:22:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BBDDC60FA0;
        Sun, 12 Sep 2021 23:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631488888;
        bh=4tPd9+jMvygWfc1poT16/de2IeCtsmrPTz2MdO/1HGc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=K42kSLAqLsrbimzcWWj+TEJJcvLzRdlbi8rhU5cKO/i++2k6nd06Th3tHhGD/qc0t
         F4B41NbEYgDJIy6Hck29OU1TPlyEj4ckEIqRY1b9nK5ShteNaAm7fKJMgxVr3UQwGA
         +LR0VUjpVu0K4046rEoPb4/PUB4mIPVv+12VPl5pZa9piwFIroJeeY5K4kPPV4oqT+
         GIu3cAqYuH+CougfpPJI3wcUeGipFUW4lO5m3gUsKV0KqRN34+fzCXvV6cRJzyDbSH
         6Pl2ZuCRjJwWoSMFzSZF05v7p585OFWcqkJlK5epxG5wN8ow3rH9X6yu0gf+oAziVx
         jQJVAPG6q6U6Q==
Subject: Re: [GIT PULL] perf tools changes for v5.15: 2nd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210911234513.121740-1-acme@kernel.org>
References: <20210911234513.121740-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210911234513.121740-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.15-2021-09-11
X-PR-Tracked-Commit-Id: 17a99e521f67743a5d3405cba0aacd8a10f9ff7d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5b65f1398274fd726eca87dbebd39f3e603348a
Message-Id: <163148888862.14345.5364190323789590554.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Sep 2021 23:21:28 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pull request you sent on Sat, 11 Sep 2021 20:45:13 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.15-2021-09-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5b65f1398274fd726eca87dbebd39f3e603348a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
