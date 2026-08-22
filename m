Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACFF30E82B;
	Sat, 22 Aug 2026 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787415558; cv=none; b=OkME+mIjvR/wb+TxEAdJ2an6IbEhGs+1RsJYXpGc43W/JA28D2/h+3cpEn67ezwGzpAHACAhxDv0bg10UsaZLrnb3R6csmu+TUauL7lIx8ZeR7K6DzOyEfTl74RK75+qOfRco2jAyJqJApvZTY5EUPik8oa7M0ZpvFBNs7uTW18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787415558; c=relaxed/simple;
	bh=KbrSsalh7tNy3KEM3ASK2+lIcQrk8Mvhs+qWgCjqy8U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cnVeLikl0cgUY97CCbzsjBBDYbUK1WB6hFFYGA87Emqux7HIcnDSOCLasu0aGwszYfchXL/Q6WY5YXLV++7ii2iE2o4xqFlWlYoZxOMI+OlPEu4huOqxoeoAytt4HLaAvUbWI0Vp/r7AjRBeupi2Ax2P8A+RfQ051f2EFgVHWo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZUv2pM2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZUv2pM2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381531F000E9;
	Sat, 22 Aug 2026 16:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787415556;
	bh=EOY9R6Vj7e7x3XPY1B3AmKFREo3qmBXZzXUKzbPKuuM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=nZUv2pM2ZwJhVbiJgwh34XYr67GesijGZslXZgUZ2Hf1RNkKDHAyrpzSA1MD17D+o
	 7xLwaUp0fZfTkpRINu9DcP0hjW3hwn2KzTaBqyTS2+aM40TvCXt87Efm99y4mnElaY
	 ZUaXqV+6nMJ5tx1UkCuHtpGuVSsSjJOCXuu0zOoe0zR34R5cAZvbZm5zI4i2MH8hqI
	 h3f0K+H70QFGs5ZiRydUNf2yv81bGnvrVk2KKlgGyYh63o00NdD1NfRk0G91dqrHrO
	 Cn0O+9ruP/NP1Zdkr0xETGvPMGLnCOFWG0KZm5MH9QvxAV8rNQpiPu0tK9QFBCIGhT
	 rD6kQH93bNirQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56C20380CEF8;
	Sat, 22 Aug 2026 16:18:26 +0000 (UTC)
Subject: Re: [GIT PULL] perf-tools changes for v7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260821213724.1315605-1-namhyung@kernel.org>
References: <20260821213724.1315605-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260821213724.1315605-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v7.3-2026-08-21
X-PR-Tracked-Commit-Id: 9453bc6a69ef43755f1c28d5688cacdd69fa16bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 473f6c8f437b049f8ec015d57cd59bb983b1d85c
Message-Id: <178741550489.1761060.8912875795125848524.pr-tracker-bot@kernel.org>
Date: Sat, 22 Aug 2026 16:18:24 +0000
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Aug 2026 14:37:24 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v7.3-2026-08-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/473f6c8f437b049f8ec015d57cd59bb983b1d85c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
