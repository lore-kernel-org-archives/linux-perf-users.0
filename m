Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538BF3E5EC1;
	Tue, 24 Mar 2026 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774369106; cv=none; b=uNKiP2XxRpO2mfDDRh7pCDkFfdvjKoXlLdxYEc8tt0tYjZy9BJ4mI2FYXM7cMvZjuDPZF6ONokR3k5Zl8tL4y1htsY9X124D1QzMia0tNwqbOYVlVMi7pfXfbf2yaDN5f4S30NJufJjU4MlgAnrb7/GCpPtTyVy1YziFwTFChgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774369106; c=relaxed/simple;
	bh=WNvAIt3nMQtZ1aohMxu65Tq7j5XoD3j2bvh/mippOu4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BX6jqLETons0wxbjIzNMojU4oiCcnH69pQKyYIUZ+/2zBMzEaTMiJpetAmyZ4RIvu7E1H3O1ZGTA6IdfzuXE8zhwPEDrjqJYc7fSZgsiUM95q+rwyUmmvTG60h0RT5XzOhyeMNSQxo9mUwwPKdQwpotxhdwGw/KqViCGSlApgG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xyf/rbZM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xyf/rbZM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2207C19424;
	Tue, 24 Mar 2026 16:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774369105;
	bh=WNvAIt3nMQtZ1aohMxu65Tq7j5XoD3j2bvh/mippOu4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Xyf/rbZMlL2yyPumCjOWMm+aWNPbXETKPwnGyA/vzcXB5A2L0bmNLbfcJesZUOC1W
	 tlHtEq74R3jHw06hlywixuVdRLMxGOVUOoq2tP2MFlOca1jPZ/FHx41zYL+FxRqqvq
	 FzPXmYg3NRxl/BPvIQZpIm6xdy0FnC7Udtu38sBE8f442q5l6koHScH+kXA0B5SFiu
	 f7LJ/E0q1wyJxUrB/x+JiqihQfftcZi3/NbkpuErZbw4fAbk8+1GSMjWqzwztuNN7I
	 EhH0ewPszlY6fDry0vtnHi67mfP1y6Je7GIpodbQmjT9xu2zmCyVsZeEhGfmJGOaFh
	 1z8xEp0xDXi2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FCE3808203;
	Tue, 24 Mar 2026 16:18:14 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v7.0: 2nd batch
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260323105725.1882966-1-acme@kernel.org>
References: <20260323105725.1882966-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260323105725.1882966-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v7.0-2-2026-03-23
X-PR-Tracked-Commit-Id: 493ad070cbcb0d62deed877d90e80e554cac7f01
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26a01984ddc1e67025fd150e845ab61d5271d6b7
Message-Id: <177436909333.1187739.7733972338597960405.pr-tracker-bot@kernel.org>
Date: Tue, 24 Mar 2026 16:18:13 +0000
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Leo Yan <leo.yan@arm.com>, Thomas Richter <tmricht@linux.ibm.com>, Francesco Nigro <nigro.fra@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 23 Mar 2026 07:57:25 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v7.0-2-2026-03-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26a01984ddc1e67025fd150e845ab61d5271d6b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
