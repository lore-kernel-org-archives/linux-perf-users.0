Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1C963A
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Dec 2023 01:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akgwYWAa"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F07FC433C8;
	Fri,  1 Dec 2023 01:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701393872;
	bh=Qnc9Ow9uW1WXd41S5OXRqUVE5Vxrs5QYLhkMLt4I2Hw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=akgwYWAaF8e68BagB5MxnMORmM4ydmbhlcuiT8c5QgAYfqR3thyB6e2uIbu6O0ngB
	 yjR4GG14THLthAxgvqjRL2BCOj4FjRLdZ6lGfCJvOEIcT0uJq/CM0JgJoLyR/W/3wl
	 W+iEZ6ecqkkUYQVt6UKDhVBLiGVI0yB6e+/7UVTprMLkh3NppwY7417fDzdqwgKxQo
	 Irrl27lgPoRmAn8QTPd3Xp9tq5cXSWHYzo2AzvuZQkZF/iKIx73wSi73OtW7lHLMW2
	 mnxoy69HuDbd6zKHzodxAQBth6GTt9lEpTqrp9AjCzFZWYmHSqptNurTQYRIEALUk9
	 LNXPtxWbDZ0jw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C9C4DFAA86;
	Fri,  1 Dec 2023 01:24:32 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v6.7: 1st batch
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231129192158.1026606-1-namhyung@kernel.org>
References: <20231129192158.1026606-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231129192158.1026606-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.7-1-2023-11-29
X-PR-Tracked-Commit-Id: 57686a72da08ae555d93148aa8756b16417a6aff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2594faafeee2f4406ff82790604e4e3f55037d60
Message-Id: <170139387224.13864.8455010638349731961.pr-tracker-bot@kernel.org>
Date: Fri, 01 Dec 2023 01:24:32 +0000
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 29 Nov 2023 11:21:58 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.7-1-2023-11-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2594faafeee2f4406ff82790604e4e3f55037d60

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
