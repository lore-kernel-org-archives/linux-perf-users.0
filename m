Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D8A46AED5;
	Thu, 22 Jan 2026 05:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769061574; cv=none; b=gaJLaDtsl4wH3/AiceBJQweq0v3/3CbuxDVHA31FDKG3BOvjgy5d+iBVSt6Mziq6LW6onBWxtRmtnSGvHVT3Jaq2gBruTBoOpqUcm0MrFnasc1Zw3Zd1Y/zp5GSi2BO75AD/w0mc0DQWfM5ZAJ/NXVecOduJzPIZe/CdgCf/AMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769061574; c=relaxed/simple;
	bh=qiNhm8M6F/ciSiHi0yqZD3KHGWoPm6LyRpdiAcQJjIg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YlOySUadJfLrFjmA20FNscpC+5rzMP2T5EDxp0YnJ0CwdcxUxYYgnF9pXpYH5jJ+uZJ8jyzN+9UaidQ/IYuMb+d83Mt+g58oWvLxg3DoRJe49FTW7+0NPje/cbkYWLtn5pNtcTt6gd6hyetUyJTN4t6QqQoMkOIF6XZGQlejbcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWTW8ad1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWTW8ad1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1794CC116C6;
	Thu, 22 Jan 2026 05:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769061574;
	bh=qiNhm8M6F/ciSiHi0yqZD3KHGWoPm6LyRpdiAcQJjIg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MWTW8ad1hqbmuXHjXpZ3JW9hK+Qu59I+xuTJ/KczxC6HyKDzwaGYHlmmrC8fEqVHL
	 wRnfkuX5sj6OnhrEKNd2HksHeIMxg1rewD73ucBTB6koDzh5nuEOrRuyWLcTSEnKOZ
	 2NqDE3Krh3ic/y627SxHPQBBnUynV02t8gCBE4G4fyl+KAub/Qwe1NPtDdwbC2LYfK
	 DPmc2IXj8GP7SVAOZlGWfNmlOGz3TlO1fJzIoGzTp3LJDizmuFfMPcLUnwcGjcXG75
	 CBGGfKflAcw3EZBbaiDIgIqC3xB7uCPq4yIrW/3d4QJfsGOSFq4nD7Wlc8exfwLy8n
	 1GEhobFagsZ+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11C813808200;
	Thu, 22 Jan 2026 05:59:32 +0000 (UTC)
Subject: Re: [GIT PULL] perf-tools fixes for v6.19-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260122043032.3466118-1-namhyung@kernel.org>
References: <20260122043032.3466118-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260122043032.3466118-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.19-2026-01-21
X-PR-Tracked-Commit-Id: 1eb217ab2e737609f8a861b517649e82e7236d05
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79f255b2e9a2f714efcd91777ccb9e4827e20006
Message-Id: <176906157060.1573610.16554068421097542682.pr-tracker-bot@kernel.org>
Date: Thu, 22 Jan 2026 05:59:30 +0000
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 21 Jan 2026 20:30:32 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.19-2026-01-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79f255b2e9a2f714efcd91777ccb9e4827e20006

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
