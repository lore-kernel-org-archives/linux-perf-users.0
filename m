Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649D6E571;
	Sat,  2 Aug 2025 00:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754095240; cv=none; b=d48hk3ZzkaBEnXlTNIR5JMEfm+AfWK8TVOjn3bLpF5hJjJElSkLLEszieLy2DiOfmYYdz4pVNJnFuljM4YbYHTxiROc8eHqBfGHwH9mBR12I3nkzYykxABYg/gG21lvzAOlrk4cRNe5IGz0hOAsqgmM4PmKGI4BYMTxV0ovyouA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754095240; c=relaxed/simple;
	bh=7Hm8eFTIujiwgPQ0YTkSGkfHbBQRLnLJNPdADzxDQUw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bCpuxZ1ql5LKLagTTe+K7z87bYSKbIy7hk4csLSIVszMPoEVA3AP32c6FQ6S/nKDLGgnDzkJ4Hn0egzgO6XWsTiMsd0U1V77jRS3F78dsreAhw6ZxNGYjiv3r+ssaxb0wcZDIiL8JDYlaE2r5Ck/d/qTLG5fNnK7HSo4xjT72AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPmxS7Ph; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPmxS7Ph"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A344C4CEE7;
	Sat,  2 Aug 2025 00:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754095240;
	bh=7Hm8eFTIujiwgPQ0YTkSGkfHbBQRLnLJNPdADzxDQUw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RPmxS7PhEhrQETLs5kSJ/twvF28AANGxAo8I72h/cFoK+D4KC4Ta9+MkOYLzU0xro
	 RNi+DqOeTC9Hrl8qs+RwBWh6nihH1Ix12Q6Ja2lvgc3kWumwIrQJbM/Cj7iNQ2W3lr
	 v/OElZ1ylrK52aqaCR+i+m7zSDPw6gyITOh4hlB3b0p0oJrXoJP1UESUeznT15vNdA
	 B8SXrmL/hdJL3Mz60dQ2fhpV9mvkg8f9Pja0bPMyuDoigUwCdJsTvyEhB6KUtr+mc3
	 aGzWSlrRHGwLXUwKppm904oRamAatGM2xyXptmYSPNeAgRUsvFCHUJp3ljeTx9akEW
	 wXBGqxO/JXe7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD2A383BF56;
	Sat,  2 Aug 2025 00:40:56 +0000 (UTC)
Subject: Re: [GIT PULL] perf-tools updates for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250801174527.1479322-1-namhyung@kernel.org>
References: <20250801174527.1479322-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250801174527.1479322-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.17-2025-08-01
X-PR-Tracked-Commit-Id: 6235ce77749f45cac27f630337e2fdf04e8a6c73
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4f346c3465949ebba80c6cc52cd8d2eeaa545fd
Message-Id: <175409525520.4175294.17223039883253281872.pr-tracker-bot@kernel.org>
Date: Sat, 02 Aug 2025 00:40:55 +0000
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  1 Aug 2025 10:45:27 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.17-2025-08-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4f346c3465949ebba80c6cc52cd8d2eeaa545fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
