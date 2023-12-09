Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A341A5B5
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Dec 2023 20:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ma9sA9bS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0720C433C7;
	Sat,  9 Dec 2023 20:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702154057;
	bh=n4Noo3TNmFi2eadYJMP1OwzH4KbtU2Qygx907mfkC3U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ma9sA9bSkqmecxJGGQfIHcovHv2DgVEX65ggcjKVr2yNRhxivlRk5zm0/bV9PksZ/
	 2q9qj2WLc835GfTtTJDLAJwurU20x5qS7iC6xHisZTbhaCJtTgEpJSu2K7sFLippJn
	 cwQOiYTyAKVYnrRlJz6ocUVv0eTdOG6Ehd0V6qcNXrmKDT82PwAqxVOVyhW3KfNNEB
	 x0P/NGqWIyGIety/bWrYIdeDhz9ACwE5KTvz9O9KVLbVmruLbu01Fd1Kk+MvpbCaEq
	 F5VDqj25BA8iqQVCO4Wa5Gl/GjoZvX03/Om6+UbE81IfesDxFag4+sR92PBEO9V6rC
	 W95poZOArjmlw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8AEE1C595C5;
	Sat,  9 Dec 2023 20:34:17 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v6.7: 2nd batch
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231208223300.3877553-1-namhyung@kernel.org>
References: <20231208223300.3877553-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231208223300.3877553-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.7-2-2023-12-08
X-PR-Tracked-Commit-Id: b1693747487442984050eb0f462b83a3a8307525
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d3bc457a24f837604e45729285e9ceba757b508
Message-Id: <170215405756.1707.10818997570099428534.pr-tracker-bot@kernel.org>
Date: Sat, 09 Dec 2023 20:34:17 +0000
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  8 Dec 2023 14:33:00 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.7-2-2023-12-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d3bc457a24f837604e45729285e9ceba757b508

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
