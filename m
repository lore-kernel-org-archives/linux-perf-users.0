Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985CF26D4CA;
	Sun, 16 Nov 2025 21:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763330230; cv=none; b=tg1puPQMefS5LX/CLK+G49wNS1ftvFEgTU4B3GMXpudSV1TllI4uERPRUODm8cs1F9dcjHT7cJnZ9/zbKw980uvAP8AcTEpACFOzh98T7NqAg2Oo8KJ1zNV5HLmZvvj7o7RRJhxPpkefz1od2AavBF7wbQOG5uAuRUNvRbcd+NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763330230; c=relaxed/simple;
	bh=9RL9RNt8A1fOzUlOHOJDyDi+dlnw6ypWH6C5qyJRmbc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VXJBL466AUdywGYliygOFH2R8Kxgp4Bn5zUcSq7DPZ2Kqmxz9HYA/1bHAhHllahG/3KgWAXx61N22+/LsFIEnYNS9JVhXPz0x38FcYVfTkZgUDa40pU7YuD2wKO83WvfCv05vjK6V1QxUWyqW+dZSnFaQmjIt84o5LGa39O3lao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnTsJmOA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnTsJmOA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24ED4C4CEF1;
	Sun, 16 Nov 2025 21:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763330230;
	bh=9RL9RNt8A1fOzUlOHOJDyDi+dlnw6ypWH6C5qyJRmbc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LnTsJmOAuh3IOzciHouruJByImAAeHnzY2XbAPEkrhkkiCjwJCqHq1KYTDZ0HgLQn
	 jb4Yg5CsZHND4rLuWpta396DPm3IWti46pRFsTGJIFW0dW5K0KmgWDMsCEMIY1CHI9
	 ohXpbRVXq83mt5SIdgSaUpGXLMIvGJEwGxkJyVSrTulbGSmFRaWCfGEdjhcMboX/sH
	 Th0t5PZQnvAzTi/SBWDjUQhVIPxTvuCffcLingoNLW0U1rH148i0rMISAxFRuf1exk
	 ZHl6lOUDuWxksEoYl0VhyZPrzBv0K2Kei8MzKW1uLWqh29Vp/jfQXZE4gHp1AE6Iqu
	 6xcPndXYznQnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEBB3A78B25;
	Sun, 16 Nov 2025 21:56:38 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v6.18: 2nd batch
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251116192901.272457-1-acme@kernel.org>
References: <20251116192901.272457-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251116192901.272457-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.18-2-2025-11-16
X-PR-Tracked-Commit-Id: b72b8132d8fd2d6bf5b420a03d4fc553980c3a92
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 998ccc327b14c03861247540ff6f8135a5283621
Message-Id: <176333019718.2325379.6209332232667485003.pr-tracker-bot@kernel.org>
Date: Sun, 16 Nov 2025 21:56:37 +0000
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Guilherme Amadio <amadio@gentoo.org>, Ravi Bangoria <ravi.bangoria@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, Tycho Andersen <tycho@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 16 Nov 2025 16:29:01 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.18-2-2025-11-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/998ccc327b14c03861247540ff6f8135a5283621

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
