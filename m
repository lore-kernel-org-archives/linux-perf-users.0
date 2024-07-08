Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C859014F118;
	Mon,  8 Jul 2024 21:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720474901; cv=none; b=F0xP29xePoSM7tDzev7v4tTUoPmxMGrMTcvLU6gzzyXv4NN8HR5VyuoSsXCERxdgnvO/beMP+asr9B1+6xqxYkQFF5d5CHzBt7jXqNPCP08fA43kp42XBgFx6rgW+Y11HMhGDA5+HfiWGjQFmbF9w/eAUvppdnJgyK+5hMCCGd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720474901; c=relaxed/simple;
	bh=/21opqWrYjHbqfKcHZT+OyBVJ7i7fg8mTKy5gCFv+uQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=f4gndAgLUzfxs7Z8IlIpJ6KMo0WsyjZ23RbjG7Ycax3l+Gp1GG5c/DedWk0dTBVLSMdoEELgQFttnh39QJxO+JnhQOARcpeJ1qIDosHoAAYs+hFwX1NiAcWBO/RB3aVwTV9KqJhhX9LRLF2s6c3LnsyNIwNh2Ry97aSJhiVQhtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiI6huFt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiI6huFt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CAA7C3277B;
	Mon,  8 Jul 2024 21:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720474901;
	bh=/21opqWrYjHbqfKcHZT+OyBVJ7i7fg8mTKy5gCFv+uQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kiI6huFtJchdgA5P6UF+QQ1K/Y+ULQyZeNH/+MnHLtY6fleiKpXb7ox/gIWQbcuhN
	 7uGcYqt987NvAys6DAW0XPhIxPahszADWHCA3UuJp3/TEnYQwGmHAaJ2meERqJ+3FX
	 hmGtpcTZSGRY0pfopEJqAbsdeE8XP4lEnVfLVRW252f5j4EBIIrTLko++wQLaIvKjB
	 G1pG6Zbz3JK1IHt6KfgskMsL45t3f7rfXGMqn304KMaOm1bz9KzrKybNnJLx36Bc3r
	 9KiUeYGE+hA9VNjt6rcHAoLTACA1H+z/zvMG91pqm5m/TNZhh5qPaWN7xnZxuIbYr/
	 2v+zRCQv012CQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 50539DF370E;
	Mon,  8 Jul 2024 21:41:40 +0000 (UTC)
Subject: Re: [GIT PULL] perf-tools-fixes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240708150820.404000-1-namhyung@kernel.org>
References: <20240708150820.404000-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240708150820.404000-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.10-2024-07-08
X-PR-Tracked-Commit-Id: 7b2450bb40275802b73593331b0db2fc147ae2b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4376e966ecb78c520b0faf239d118ecfab42a119
Message-Id: <172047490031.22044.16970037342997773688.pr-tracker-bot@kernel.org>
Date: Mon, 08 Jul 2024 21:41:40 +0000
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  8 Jul 2024 08:08:20 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.10-2024-07-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4376e966ecb78c520b0faf239d118ecfab42a119

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
