Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E227257CA7;
	Thu, 15 Aug 2024 23:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723765270; cv=none; b=Ky7yMpUVW15ek2EpndYTkKzlhB57o7UmViOdz9hIExg9F+63xgBUnusmkJTo8Z6q/h0mhRFaGrhnVZCUvZjsnTpInNhN4AbWn3bwCwjMNXMeYHTCo+b0pns0ZpB0tJTf3vt/57xRuwM10Wb27wWpNDbESJyHscu6ZntLuyuUhyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723765270; c=relaxed/simple;
	bh=CG2qeKy22j7Lky/3R1iANLdAgIVXKiGRcsASzreB8sw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FEuK3umt/yOSDyMeIJ/aU7DVtdqs3L1TiH+cP0sq5mEvggMYVc4XMTGy1L70a9PtWgnjJljn5TsfT2R3ZLXYxoByWucJ1G4W4/iM5Z19cZ51mBw2yAhSmt/1nUzhAeyA6DfcR/xlrWOxwr62w7IyvwS6cNQ48f7xRa+ZD8ACBl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMfF56Iy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMfF56Iy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B332C32786;
	Thu, 15 Aug 2024 23:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723765269;
	bh=CG2qeKy22j7Lky/3R1iANLdAgIVXKiGRcsASzreB8sw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cMfF56Iyl6bHYfJ/l5j37V9HtzLRKVAOq2L6UxuQgwOLlCaZlWej0ebjDwmNLy/tV
	 LhtJyRDS+S+9QILR0IiSewFVnsC+RI/xrT7Z28dZuMAzNo9DksVJMcYQgWKfLq5vjy
	 KyFRRGJ/VpyAD74v3E9FhERvsNt8oP1wE3KImL2ZM/Jw0lCvc1WDBRa/1W9Hj2uyH0
	 IpxRDpD0wj/mzOyzn13+0ZoVG2dFneBVekk2H/J5mJe0VNUgYgmni2WcQco8MojSVM
	 rlTg+4TCVElZLtMCJA7+cucCrZz9Z7/rqKcYjDZ6wVjkvRFu2i4gVQHTmBIBKZCH6l
	 AdsWW9MlCZn5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBCC9382327A;
	Thu, 15 Aug 2024 23:41:09 +0000 (UTC)
Subject: Re: [GIT PULL] perf-tools fixes for v6.11-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240815230319.2406358-1-namhyung@kernel.org>
References: <20240815230319.2406358-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240815230319.2406358-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.11-2024-08-15
X-PR-Tracked-Commit-Id: 4bbe6002931954bbe82b25f25990b987b0392e18
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d7a5aa4b3c007fae50405ca75c40258d90300e96
Message-Id: <172376526851.3066214.12003734363521642927.pr-tracker-bot@kernel.org>
Date: Thu, 15 Aug 2024 23:41:08 +0000
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 15 Aug 2024 16:03:19 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.11-2024-08-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d7a5aa4b3c007fae50405ca75c40258d90300e96

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
