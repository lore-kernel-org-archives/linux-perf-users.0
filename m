Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A1712E4A;
	Fri, 24 Jan 2025 14:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737727559; cv=none; b=iclA0Sw7i5ddLjwpbfxd5V0YFuJJy/vAmWE2QPgwgxCkbVB9DODc9qQH4ndBeF+toCfz6E6x9JgU7P8H/PprF+7snhU5uD5QHRzYLhT9yX47KxUSILYwB4zCcrg7ilLC+CfCUTc4Gc/bwk/LYZzs3ChAOh2Mws6p3kfpCyCThEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737727559; c=relaxed/simple;
	bh=VyhDDyXAJJGUDefdql1liA8Y4i9+n0hD4qIXDwfOQco=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oZHMpsMiMWpWSgVzvIo9rClm+//ee0M7JvECJXvNePT1RFYeAOoFOz6lqlEoGzwvMNWkTIqizgFr4B3gWXcfXT8UdRNKl7funmtmGLgfpZbhFZ8H+V7h1lrEEyoJSdKNiSwwCZY9ok9jUwHiUSwwX2mPbL7IlNzGyzRbwfhzZsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLLW2qWt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLLW2qWt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D688DC4CED2;
	Fri, 24 Jan 2025 14:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737727558;
	bh=VyhDDyXAJJGUDefdql1liA8Y4i9+n0hD4qIXDwfOQco=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GLLW2qWtDPzxjm0p/SvoWiBsV0Sc8ItInwzTIyiurGUEJW3J/epXea64thuoJRcwm
	 NamkZLJDy4KMyASzozPLAGYP+xUUxBlCBNpGyNmuJYSL9wECgRLTgUJJaeSnOaQ24i
	 W1DtEy98LAUzvU0/2iKjxbA+SI9AW6XEinC059UIoy1zDsW+vCifXGr+bEtzpn+mrQ
	 0NFy55Mc2/h7gqJXEcFo1ZDiQnccgqyyojohFB4lLT0t/PY5U+M+b3WaLD41aPMuwU
	 5672lpkdcofyQ6351lm6/e207/SdQIy+99DLjYTaYe1aVSEU7a1ULOMSAfMdntsQ5C
	 w+uwDHPwhKQnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB6D0380AA79;
	Fri, 24 Jan 2025 14:06:24 +0000 (UTC)
Subject: Re: [GIT PULL] perf-tools for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250121223539.358798-1-namhyung@kernel.org>
References: <20250121223539.358798-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250121223539.358798-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.14-2025-01-21
X-PR-Tracked-Commit-Id: 91b7747dc70d64b5ec56ffe493310f207e7ffc99
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7685b334d1e4927cc73b62c65293ba65748d9c52
Message-Id: <173772758343.2045518.1278089026774491743.pr-tracker-bot@kernel.org>
Date: Fri, 24 Jan 2025 14:06:23 +0000
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 Jan 2025 14:35:39 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.14-2025-01-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7685b334d1e4927cc73b62c65293ba65748d9c52

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
