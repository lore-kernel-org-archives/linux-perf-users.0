Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B79F2980A8;
	Tue, 19 May 2026 00:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779152299; cv=none; b=sLeIwXPjgvNmtcsfUZU1YAVwmFJ24EeHFEfLTFaaA6QOYqOrAOv17YHsRu+PgG8Cj0JsxQ6i92mXLeEVn4+ibIH6THaz4wbHoTShQj3yu0kZsj8facUAbYiKMe87RzcqF1MIgWDCVs9d8jVH1NNw1SvB6TmxqH1TuiEqPEEIUmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779152299; c=relaxed/simple;
	bh=FQHooL/P6Ybuv4s5zws6SI3CoyKAVk/EJTQQc5z6jr8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hI5u2ymhcfmFNBVriBdPFL2sjfrMHcS3gEN15egQ5/q18u7KRvRQFxN7jHvXUqhnCqp3hu3+WOn51yMsY0xzwCFGUBQLFFcIa/DaJosph9EfNdsnquEtebR8EALrS4G835n4xefcg0SgTsAyhT3SXDIkza6YudsKHE6E/bJ2ojs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLmUShD9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLmUShD9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07EDAC2BCB7;
	Tue, 19 May 2026 00:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779152299;
	bh=FQHooL/P6Ybuv4s5zws6SI3CoyKAVk/EJTQQc5z6jr8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZLmUShD9m5Szjn5I3E5KBqCvulvjCIIwoSXkALpctNfB0Uqn7FA04uIr6VhErDwfm
	 /+yvmBLIeHdJe94sJlDrc4yrSdv5QG23C1vkvAZtugC2dwNvB4KNJLsRmRgkE3c757
	 RxCX5QKSQw1rR7TMb7Q6lQu1Y2v3mxJUrJ4TOsU2J2NEsHMwCh3EolITjlSnctbqFa
	 BLGZtE2N5/P3UzIkcfB6XyYCEWINFzPqkUticXzbVJmmGkpPE016oNpGnDKHzKt6wc
	 Rboflik5t226DkaWQyT47hg8XisB6ljfUKK+RWCeuXG8sMEil9f1lq+KCvZgnZ/TOS
	 GOBcuaif9SKfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B633930CBF;
	Tue, 19 May 2026 00:58:31 +0000 (UTC)
Subject: Re: [GIT PULL] perf-tools fixes for v7.1-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260518194641.1509400-1-namhyung@kernel.org>
References: <20260518194641.1509400-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260518194641.1509400-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v7.1-2026-05-18
X-PR-Tracked-Commit-Id: 9a424b62f771a759b040b9be2f3762bad0da283f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab5fce87a778cb780a05984a2ca448f2b41aafbf
Message-Id: <177915231005.2035975.15700598557053976649.pr-tracker-bot@kernel.org>
Date: Tue, 19 May 2026 00:58:30 +0000
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 May 2026 12:46:41 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v7.1-2026-05-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab5fce87a778cb780a05984a2ca448f2b41aafbf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
