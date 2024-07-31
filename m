Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A23917552;
	Wed, 31 Jul 2024 02:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722393811; cv=none; b=ooFGszGynAng2l4fykl1S06jz7jJcdZAMPTWBPSYDw6uVD2vO9thp/qePP3wTOvQYkKJz61rxOHo+e1wDzSSxgEUMUuHEtYYkDdHGrtpwZKYyKS1lYIa+JYmIGaeXzerCIPqFZqSep0guoZ508Tn2XOY3FeTMFeMYkLimYcTE2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722393811; c=relaxed/simple;
	bh=eUxGqWcFaQBtQJ/6BEGxdzX0w/XiGw/LzFQyc81q0fQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kXd82aJBSKQJ99mHkQFr8OMYCUv7HJQ2X99jp5ls1KBNLctjTosN0BHTVjKSOEn5XDvUq8Hc4tQS4TWP9T8hnHPfVvwoVC+kBIbiJrjM1vzbsSFx8DDPusx+HFNm96ANdu3CWwsdWRp1AuMs4YuxzH1VMNjYge7FoDC5tmFeocI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyAnbI2M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyAnbI2M"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57518C32782;
	Wed, 31 Jul 2024 02:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722393811;
	bh=eUxGqWcFaQBtQJ/6BEGxdzX0w/XiGw/LzFQyc81q0fQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YyAnbI2MDlIxzqcwOMz5e5czlbat1FoBkH57bgMXiqJ/qRXK0T/yON869uil7CuPV
	 4Qte9joiMycUv+PBOSzlHsAptgc4QqjERxL2sWdRtyEPU4jK1HNMaH5VxYVNskwV/9
	 /MgKFXdfWSJKTESIbFmsRAYJVvolu+iQwhu4JI0eSMgMxu4OjYPTXSlUDHDsrFiNtJ
	 m62Z/V3wZCv84Qjf8X1mhSwVmFzVVBWH5KY1Nunrywj1WUg3FPncoquMMF6S3/yY0b
	 xIsUf8s1yoF2fUVOEH2D3dyzqLbbSHXl8HNOpFT0UK79M5WKsS0Z5Io2fLtKMsowL6
	 oTFZmP2dDVm2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D58BC4332C;
	Wed, 31 Jul 2024 02:43:30 +0000 (UTC)
Subject: Re: [GIT PULL] perf-tools fixes for v6.11-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240730225124.4057811-1-namhyung@kernel.org>
References: <20240730225124.4057811-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240730225124.4057811-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.11-2024-07-30
X-PR-Tracked-Commit-Id: d27087c76e3c859ea05b7581ef7ce8aa5a088dd8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e254e0c5baeae28717d1b312821e6ded29e7d969
Message-Id: <172239381030.6103.14656541905594288606.pr-tracker-bot@kernel.org>
Date: Wed, 31 Jul 2024 02:43:30 +0000
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linux.dev>, Casey Chen <cachen@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 30 Jul 2024 15:51:24 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.11-2024-07-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e254e0c5baeae28717d1b312821e6ded29e7d969

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
