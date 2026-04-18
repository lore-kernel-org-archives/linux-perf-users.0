Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4682E8DE3;
	Sat, 18 Apr 2026 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776536986; cv=none; b=DDnM54CDVcGfooh9EDkJ1WMikLP/Q68Z6f0WwHkPdv2CQ+5sJ7ynn1xOj2Yh2vrzgoZkAoFZYNyZ9v537xVtSjExR+hWIuo2/hPUVnW6aK/Vkp+RjWOdLg+J5UZVbPjzWgRI9umWUrDSCrLa3QN+S8nwIH7zUR+7PwrsJ14RNeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776536986; c=relaxed/simple;
	bh=UuNQ1J/kh08EwHl7faYwvzntlSZu2CRXxuM0A+rG2j8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mcxjpsRkzYFViqlUvRo2LHHUoktEnG1Iv7ruvYHGkzrmI3fqDhBBojEeE9PNkSv/eG9kyh0ErKl8nqoIbaS3AaobOpFaJsmUvyyETkh4EaT7ARG1sNkY3nQgyhzhh3d+zf4YvTAfG0DCO6SbeuVy9xayDbp7e1ZfBtO2ebLDTsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3joYURD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3joYURD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85082C2BCB3;
	Sat, 18 Apr 2026 18:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776536985;
	bh=UuNQ1J/kh08EwHl7faYwvzntlSZu2CRXxuM0A+rG2j8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=U3joYURDldemJvahSx92DLmd8mxG+7EGl57jBxHUC05EQ8d85ZjYi8MFS3YlTxTzc
	 g7j2cfrJSerRMOZoLXRGI7PFH7QtlhuiHzs1B2PygoE9ukiLORdWR8OXZUEpSE3sHK
	 YBIq/PslVqw1mO8e6CnxK2IUqgZ5dN4n9EB6twuoNXE4FL+OyOlw4Cg2jEmjWN73TT
	 jtRAzecMkigsB4mNW4jlYBVVrVKKkFMHktRjynyBfTqNHZ2OQSeUf3uPqwopT8gMwH
	 p023VmmSqSSDFxXbZJRetp9MD6nqlYMVTkeQeSpifgfJ7ZxK0V5RcfrUbPIE39YWeI
	 Drjd7MM8KYWFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 400FA380CEDD;
	Sat, 18 Apr 2026 18:29:13 +0000 (UTC)
Subject: Re: [GIT PULL] perf-tool updates for v7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260417213844.667501-1-namhyung@kernel.org>
References: <20260417213844.667501-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260417213844.667501-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v7.1-2026-04-17
X-PR-Tracked-Commit-Id: 9a683fe0a00d2684ae874fd9eb58e6c1864fdf36
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df8f6181ab57d65a99e61fcfc5be22a42df58642
Message-Id: <177653695175.493726.11181830403099344541.pr-tracker-bot@kernel.org>
Date: Sat, 18 Apr 2026 18:29:11 +0000
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 Apr 2026 14:38:44 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v7.1-2026-04-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df8f6181ab57d65a99e61fcfc5be22a42df58642

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
