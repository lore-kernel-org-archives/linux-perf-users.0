Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454E029D29D;
	Fri,  5 Sep 2025 22:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757111658; cv=none; b=J9A2gA7pQ49l6uJV2Z3rU6bo9q2wHg1hgsaTsOU056FVtOdm+5wsQFKAwoiV20UzwPBT2gMEZDRW5H/PdnGbfvo7IP1esA3uWiq9LNb5xRbFLc8tkd6Ip799m3wDDlTfzuBGkVUMKJkiqwVMq8tyLZKl46fWB52gGtb4ibdcE1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757111658; c=relaxed/simple;
	bh=T9mwKHjL44ncUeSPe1czJjoRX8HQq2UGpQyoqN2MLjE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Zeh1X5Exlpsnwr2MXhS43nX5RjVBeiYJDG52iFYWJ17ixuIVQaupa3qsVrCuqCJievx7sApPodMomDfiQ94FMaehG+JMzQhx3c7D9bsJD88ohX9SRhVBJh9e2EhrlalDud4fBPlCqs0gh2sCQDxPX9CZErLwKA5AAX1JAQ35fWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4zZa+ms; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4zZa+ms"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98C6C4CEF9;
	Fri,  5 Sep 2025 22:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757111657;
	bh=T9mwKHjL44ncUeSPe1czJjoRX8HQq2UGpQyoqN2MLjE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Y4zZa+ms55UagzrLqvdQyBLK/2VS8Jme61Xw3OzHs08IESwQ4KsIwGJhG5RRt2RIE
	 ab+i7c0Oo78gfetolw+rLDjXLpGI/oErp7ZxZvrsz3ad7kxaZicKnCpBhBD6wD5As7
	 2PN/YwOhEIQlcldR9NRMbbnqnw+x6n07FjZGQw3gBNGO/kHXFVSUs8y8HPBLnR8skZ
	 457t03gDwJlMk9g4qfUtkybxEwbh77pTchiOENwsrnj1bUtAqmqghCu4YET4n5B43n
	 1JoIyqk7xwc/aNhyG+EJTHTPkNy7e+IU4tvmUUaFda+WeYRAa6VDf/byQpfFyxcCqw
	 NxZX+ZX7Hq3Dg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D5C383BF69;
	Fri,  5 Sep 2025 22:34:23 +0000 (UTC)
Subject: Re: [GIT PULL] perf-tools fixes for v6.17-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250905202012.2341155-1-namhyung@kernel.org>
References: <20250905202012.2341155-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250905202012.2341155-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.17-2025-09-05
X-PR-Tracked-Commit-Id: ca81e74dc34734078d34485d4aa123561ba75b15
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d1d10cea0895264cc3769e4d9719baa94f4b250b
Message-Id: <175711166211.2706660.17560508984667596967.pr-tracker-bot@kernel.org>
Date: Fri, 05 Sep 2025 22:34:22 +0000
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  5 Sep 2025 13:20:12 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.17-2025-09-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d1d10cea0895264cc3769e4d9719baa94f4b250b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
