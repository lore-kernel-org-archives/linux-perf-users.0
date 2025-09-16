Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F4632E2F1;
	Tue, 16 Sep 2025 22:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061750; cv=none; b=ckaCpJQeTiOQW/FF7406z2GkzysBjdger+w26+Ex25qzzyvz53ddIhut+cNTD+S4m2MdnLELld9T051a8EGi8i7DO7mlGdzQB+h7FVimcoANXF8hEJyr03omJUxZBOdwd3k/rXRMFUgiSWEQnrwNZrZXeg+p/DK2xL2Y/53XZMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061750; c=relaxed/simple;
	bh=LoRaHXiFjX2WaXLaWJDJkSFx4i3UDMK7friz1RJycoQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QkY8kr28QVrtM+9TezuNL8NGfKKmpXbdGIK69saLjIpWF39KzB+fr3FMLxC2NWaPg1IBKLR3SZYCdA54clM7HUfdyHKLSvpa1ONnBcb35lAxICxO5STyWyK/+R4R4+CzYUGLmSPWyY6qqjNnm4anIG6u2adttdCl8h2rgbQzDeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpBtF2Ie; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpBtF2Ie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2EEC4CEEB;
	Tue, 16 Sep 2025 22:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758061750;
	bh=LoRaHXiFjX2WaXLaWJDJkSFx4i3UDMK7friz1RJycoQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YpBtF2IeMb5z9Lds4H1EZfyK0gJMi53AuuAS8UfFK91/hGiV7oxELA2oXTHYbE6Cz
	 wWPVJ5OxgwgWev5hEy5nsCR0yEGIw5j98PmT1FFlUu5F2vUuS+exGFdtDVANf15eit
	 8VTe5Neev5YPjca4mxrrq7iDEk9ybqt8MKNAvrvN+oM7TObLhzAYoNcmTMoHDuACn9
	 EPNhPbPVE2b8aCZ2GOPzihA+VrscaNVqs8UmomfYwOIEm8/oFGeeCAnLZjdZhUp6eW
	 Nqb3PfCV2a+t1OK5ydvLKK/wNLPY4PAfQEeKIBn4UWuWyhCPyovT5XnQTVdgOYfnLJ
	 7MN84lZ5F9Bxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FEB39D0C1A;
	Tue, 16 Sep 2025 22:29:10 +0000 (UTC)
Subject: Re: [GIT PULL] perf-tools fixes for v6.17-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250916215921.773759-1-namhyung@kernel.org>
References: <20250916215921.773759-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250916215921.773759-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.17-2025-09-16
X-PR-Tracked-Commit-Id: 20c9ccffccd61b37325a0519fb6d485caeecf7fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5aca7966d2a7255ba92fd5e63268dd767b223aa5
Message-Id: <175806174872.1382555.6890730749007353152.pr-tracker-bot@kernel.org>
Date: Tue, 16 Sep 2025 22:29:08 +0000
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Sep 2025 14:59:21 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.17-2025-09-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5aca7966d2a7255ba92fd5e63268dd767b223aa5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
