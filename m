Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5220F24469E;
	Thu, 28 Aug 2025 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756348206; cv=none; b=l1Z3v7El+fj5kwzn9ZPXU0f9Qq0HsMGwhItnkqJ9OHzrjrX490ePigu9sze2g/bQMA/F/oZsK7j0bFDeY9tKc7zg1S+ubBw7s6fwG5DB2nxuRYEU/alxTvCPd9q7u8ZQ+cawXvRG7IsOfggc/zDrpBQSa5rS/Ct+d2kaKURnnKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756348206; c=relaxed/simple;
	bh=Gjxv2YrpjZ/n5CKwhXCSM0jptEQWCLDhbqlR9OJhNnI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rrCHzp2lZlXmuszR/DMiisY67H56+IEtH8AYa81j1jX9UkZ58XiYNRch9OO0w0s7cl7fAQwqN3YCmww02dM92ke1PTOnKQeXF4Z2TPCZ2hUhYv2d6NZE2yZfWjEaLNHRkRANdUprO+mqvZJPtcEBuNROYV5p8CJClPez85my8hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4mXf21R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4mXf21R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE456C4CEEB;
	Thu, 28 Aug 2025 02:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756348205;
	bh=Gjxv2YrpjZ/n5CKwhXCSM0jptEQWCLDhbqlR9OJhNnI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=G4mXf21R229mz5oyH8zhuu79sjERZbMVJfxUyi8vJs9MA9RXKFQ19Jmja2e7INenA
	 FjkdZIqx+Dbb2dWcIrwDdRBfwI8W48kPFLg+vHUys5jqkGEnyAvWPq+8ZhlPfSQlmB
	 lHoi9a6y1MlFrlfQo8OHLwiLwY+nFnI9mb8ChR5b2H6QRuH6HVrMUYlhFv5HTboBqP
	 bbE2J4Eg/MXvEeLxbexb75b/LC1Q1gWcsIlEI07C3f0pKzeP1s+lBG7/4dZqqJ2Stt
	 1lxi+Ppxy7Gr/ox7nnGK1DP6LfMliEdIBrXpMe/WnPlff74HF0l7jbhJTBoSWHYzT/
	 MczmTmB1rG7+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 375B6383BF76;
	Thu, 28 Aug 2025 02:30:14 +0000 (UTC)
Subject: Re: [GIT PULL] perf-tools fixes for v6.17-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250827234817.4156091-1-namhyung@kernel.org>
References: <20250827234817.4156091-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250827234817.4156091-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.17-2025-08-27
X-PR-Tracked-Commit-Id: 2c369d91d0933aaff96b6b807b22363e6a38a625
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 07d9df80082b8d1f37e05658371b087cb6738770
Message-Id: <175634821340.914261.15053069721892327124.pr-tracker-bot@kernel.org>
Date: Thu, 28 Aug 2025 02:30:13 +0000
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 27 Aug 2025 16:48:17 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.17-2025-08-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/07d9df80082b8d1f37e05658371b087cb6738770

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
