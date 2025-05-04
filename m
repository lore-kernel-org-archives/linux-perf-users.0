Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DABC170A0B;
	Sun,  4 May 2025 19:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746388763; cv=none; b=rmTxHryz9Cp4oJ7p0ZnrzVV73ySIr8E23gSFS0B/O7Bs2iDkb9/zf2QuIAmcY/kxpjmBKfWrMnSyDZ7XfAL0xeCoczsTl6ANpUrEPndNh2INk00gd8titgGp+16jsOIqqWnBwjTQ1iSyTWWIWl49kCy6cSv0zqyniVrE5yFEyeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746388763; c=relaxed/simple;
	bh=qBtt+GVsZCvSezanP5TtC+a6V6QBE0q5TI2J0Jck5xo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ys/T2/foF0PX2zrbVT6JepEdyGP+UWVb95R14ADhsO1semU7idTycKs6mhg5TsqbIqa9Yj2u4m9WNHixxJhobgmSpC7NqjOrkUWr/DnjRSCAP7LlkFpNon2a6paoeJkXW2cMhGNN7EaaiRip1NhhLfUYVUKFzEyRct/Qyr4uH9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZZl0Isw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZZl0Isw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68B4C4CEE7;
	Sun,  4 May 2025 19:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746388763;
	bh=qBtt+GVsZCvSezanP5TtC+a6V6QBE0q5TI2J0Jck5xo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WZZl0IswDy5RrqIVyCxSncr88ECGCUfnEdEng9LmCDMtOI/vYPPIx0yglg6fos9ou
	 9KU032UVcZTinO+4lppCLIm3qmqfEuqilRl0kMnw9kVLw5Y4FQd73YTU4+vwNDcscd
	 YZqe7eGZuJvDY+HhsD4rBln+UNvNHM/fcsngf7L+QyqGUKK1lL+8eoSd8HW64MiDau
	 JRF9v44JnGl6rylXMYnVtP4uHUZnMncA0pdGzyLKg5UozLb/GrlO1cBgeIprTwsjnQ
	 kZjOoi8UiW0ddkZepTC5tRMGb5TE7fQQAOPwmNl9CbVGg6xx6EeGxg2phQk5qKXHV+
	 drCk1fYKTRfUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 728373805D8E;
	Sun,  4 May 2025 20:00:03 +0000 (UTC)
Subject: Re: [GIT PULL] perf-tools fixes for v6.15-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250504193428.1295124-1-namhyung@kernel.org>
References: <20250504193428.1295124-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250504193428.1295124-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.15-2025-05-04
X-PR-Tracked-Commit-Id: 8988c4b91945173a6b5505764915d470f0238fdc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 14c55b7bb0a8f013d89ccfed7ad540b774abb851
Message-Id: <174638880314.4091672.4676950993703882238.pr-tracker-bot@kernel.org>
Date: Sun, 04 May 2025 20:00:03 +0000
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Sun,  4 May 2025 12:34:28 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.15-2025-05-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/14c55b7bb0a8f013d89ccfed7ad540b774abb851

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
