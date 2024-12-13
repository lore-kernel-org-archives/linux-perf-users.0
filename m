Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C44F17BEC5;
	Fri, 13 Dec 2024 05:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734066020; cv=none; b=NHJe8394XBd3iRgmRVfltpUKHnoTy9pCkuoa4jwhqsO1EE2Jx+XLsnpID+jIkH1IlYnulViwUnTMaOUD9kEbPbciG0h+x+mO8Z87Oi2BymQg3pcW3+CtVB//3fcBT4m7pPs+2NDI7xifxwSxIRdWwCyDGhJfRhNlEASKgFCB6vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734066020; c=relaxed/simple;
	bh=Vpj+1Y82AGnSF5x+dqxYoeY+jVqHXwLu4p1+s/IWQPo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=evdCVMSYtyxLdzLjdYe4biZLojBmAqeCXPop/JGN2FqVZDzA6DvyzyFKEngZyz1Nf+N5YuJN7sYV4TL5lDtAA7PdRMI2EmfKsCyzZnW/OHW0wplixMeJdm4j0Zl8V5t0mIHakAsIdQ8xjSIwFieJEktKgUUCAYQvBMwVxpmUCyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oz9REbFz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oz9REbFz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94447C4CED1;
	Fri, 13 Dec 2024 05:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734066019;
	bh=Vpj+1Y82AGnSF5x+dqxYoeY+jVqHXwLu4p1+s/IWQPo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Oz9REbFziq/dZqfx+kWMhK0UzBQk+9WCOcb5oahbmRWJXSLvbRik83d45+gbmeyu5
	 4cvD145oK6dyEEIJ5JTaMABRL7PK9AshIBvECvhOanSaPouBkLcgDSaFceLX2nyzT7
	 xadEE1hYD+HyQrYP29SG1ztzVyVaFlP2/35efjhWAV/uDccr7b1x8W7fk6rW1ukK7u
	 Y5w6iIpK1hvYk7reKCJkHirvxua/EW9PZNc6h59pCAlc9zhdXGm296IYwusfLUS/Pp
	 GjwRFmcq8nqYyji2IPYGmfGkDjrUUkdUqLaRKqAikPpdkrpnEbeAmwfDUhPLH8UyHU
	 hLyp4Nkl4PPSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F118F380A959;
	Fri, 13 Dec 2024 05:00:36 +0000 (UTC)
Subject: Re: [GIT PULL] perf-tools fixes for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241212215702.70608-1-namhyung@kernel.org>
References: <20241212215702.70608-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241212215702.70608-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.13-2024-12-12
X-PR-Tracked-Commit-Id: 434fffa926b10706f2bde2db22979d68463302fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01abac26dccd77eddffec6b032e51f501714dee3
Message-Id: <173406603546.2542567.1045027924565076517.pr-tracker-bot@kernel.org>
Date: Fri, 13 Dec 2024 05:00:35 +0000
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 12 Dec 2024 13:57:02 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.13-2024-12-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01abac26dccd77eddffec6b032e51f501714dee3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
