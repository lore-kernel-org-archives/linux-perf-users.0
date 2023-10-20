Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E17E2FE09
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Oct 2023 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOslLnLi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E571BC433C7;
	Fri, 20 Oct 2023 21:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697838844;
	bh=H7eTnQBsNSkxsVEZFpxF7ZW3ihkhDqciD68W6jKMEzk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eOslLnLiBStvpOffGOJxWr5szJVcnuFEnW3DSS11/37f7aWU0vT8n5FLIsa+kjAiB
	 5y4FTsUOldGmjOkQKgFt0Shx1wEtmpa7ALy8eaGyCXAJfj7ajgmpXNQ4gsdK38Lw6p
	 YvLaZAKCVrkiBNAZE6VS83H/Z5rZ6yy9tkNP63Hk1uLRXmke03pZS4M9OopEZHUne8
	 24gBTVhErL0sHtA9phrj/BWkBZIlrrbVcYJ+76+3e4n9Yo2DbQu6eFGSPkpDZaHLZK
	 ED8jJPsQXPRYX/ssKG+lwmKbSJhk6V6njcZo93CXShyoa5JJtCPYFLgmqanmVvLpCQ
	 eKpt9VDw8rDyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CFEDEC595CE;
	Fri, 20 Oct 2023 21:54:04 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v6.6: 2nd batch
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231020200846.99350-1-acme@kernel.org>
References: <20231020200846.99350-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231020200846.99350-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.6-2-2023-10-20
X-PR-Tracked-Commit-Id: 4fa008a2db484024a5cb52676a1b1534dc82330c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c5d00cb7b6bbc5a7965d9ab7d223b5402d1f02c
Message-Id: <169783884484.25290.8242745922703774031.pr-tracker-bot@kernel.org>
Date: Fri, 20 Oct 2023 21:54:04 +0000
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Clark Williams <williams@redhat.com>, Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Manu Bretelle <chantr4@gmail.com>, Wyes Karny <wyes.karny@amd.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 20 Oct 2023 17:08:46 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.6-2-2023-10-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c5d00cb7b6bbc5a7965d9ab7d223b5402d1f02c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
