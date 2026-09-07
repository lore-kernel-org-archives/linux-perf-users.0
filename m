Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081603403EF;
	Mon,  7 Sep 2026 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788803017; cv=none; b=skvyBE5PV3qEvET90oal9ZM49NT4XhiWTXLBHqPMsmElYw+g4OGqUZkl9vaYjd/gVUBzML9Fgt7dQv+wridy4L3wfolhRjqpNrxIiv78tP4JcMG7qU2AxRbPVdIx+TCxB5UEqgmlEw+qsvI3jZiZRijxVcy6PQtyo9p+xOh5be8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788803017; c=relaxed/simple;
	bh=c9wea5u61gvkufaCVarKmYlCo4MD5BWy0b4FTwdn5Mw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jmQfKzdYQqHJMLHIMyzE6jz5UksrM2Uwc1O4gjCYNvBnlQMJJabtNZxKoQenSetuzSc7jl3l1613zGkt5gdE+J/YSpgTKW5PpYcAi0/YXwsqH8jrZGTpC3GAOXbAD8eJOKaSiLABdMEi0fI5T8mB5Bx0/Yoj1JOuyKYld/SLrfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdmK8uvC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdmK8uvC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94F51F00A3A;
	Mon,  7 Sep 2026 17:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788803015;
	bh=ZmgWGQU4/wfOiSxF6ur0Yu3gGAmZbocA2sIo0L/6oEg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=YdmK8uvCWxaTSZwr/2/TG9cFjPpXZN0s7WOuZm9Qdhgq9vNWKQ8COhgAl0/+EXjhZ
	 6Lgp7RA33zdMHYD4ZEOxMTtKEpVXOj7rwFw8EnvbZ8GqFJ7uz0gQ4IW+dQBG691NiU
	 BOyXcyJySAAGippgzkk0IqBxnsdf7zQ9bZG0yIaKWdjpuypVl/s6ZbpLkwW5Fp84B5
	 lWo+kHJAZgwRjaaCbVhtlx06dCxojhZ7V/nsooARx0aWyEn0hKtRE7w2+4Hn2+Ibtp
	 ZjxgxyA+xnz3kaMABnALHI/e8JN0/Pm6WKQ9l/t7xSxBkz5cRFPmYBHtqfFsPXt7Pf
	 XOfUzIjsCLzcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19B2939E8A46;
	Mon,  7 Sep 2026 17:42:36 +0000 (UTC)
Subject: Re: [GIT PULL] perf-tools fixes for v7.3-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260907172557.3679541-1-namhyung@kernel.org>
References: <20260907172557.3679541-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260907172557.3679541-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v7.3-2026-09-07
X-PR-Tracked-Commit-Id: aadea57f532882d8bab444646863c7ef8a778ff1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28924df2a08f440c73991b83028032c901de2ae4
Message-Id: <178880295459.3100560.6284398277670215220.pr-tracker-bot@kernel.org>
Date: Mon, 07 Sep 2026 17:42:34 +0000
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  7 Sep 2026 10:25:57 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v7.3-2026-09-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28924df2a08f440c73991b83028032c901de2ae4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
