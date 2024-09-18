Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A7918E359;
	Wed, 18 Sep 2024 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668011; cv=none; b=RznWhwExZ/xohoKGrLOAXz5I7Ohzgq921C7pGQbXRQ3is4GBczmMbftziAqZHy46vgy1IF0HBV0Fndsitu8yqhtkNiim5n1Ufkobl3vF4E1lJRDTKXIjrzyqqJ3BZqT5YV+XI7Jgmwdao+nEBqjjfrzERSe9d0ZEqlQHUS8fYM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668011; c=relaxed/simple;
	bh=OYrRM1ZiignuvSwRVknjngmA7d+ErTTEkalxCIFhQB4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=N/SuwmR7Zh6MRqoY2C9ZNF5esvbean0rn+/xGVx2+33LxOxApFnJuohZQEhWz+JnON4iWCjznoVRPYrjtfRiTi8akbYss3BV2szBB0IDpBSzircOmC/U3PAZtXFHEZFAIf51zyMRBICw40/LBIqJx0PrPKG03TZ+DECcVoCczUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSA2GI5m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSA2GI5m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42171C4CECF;
	Wed, 18 Sep 2024 14:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726668011;
	bh=OYrRM1ZiignuvSwRVknjngmA7d+ErTTEkalxCIFhQB4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CSA2GI5m191Hw8q1e6CDWlSkXgx7qAQ3H+4RKGADErqy7dfpuGrmmFErCJ1ZqNyhl
	 J20c1PpV27nnzcJI26bCWRckNxdFM2ulsiU1OysxFktgQGjcr1En0t+DF+8p/WtUfQ
	 TGB77WKXr9qhj/1ERK1D6QFBXvssI5r75lftH8ySvBVnhLC+o+gSI+SPTxXaVQqgEL
	 4glNvQrTKvVYojTm1IfY5AlGUMdxrewH3lYVKCov9MYLx2KOPRhdgd5xlUe83hzemA
	 I/ug5UUooEHgmYD7XZEvuvAA8sx3ZQXFuxx2UiYl5qRLw84jbeFB1GsUk/HQRefqYO
	 ryQ/Teo2dqpZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 515F33806656;
	Wed, 18 Sep 2024 14:00:14 +0000 (UTC)
Subject: Re: [GIT PULL] Performance events changes for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZurLc9qEjBH9MkvK@gmail.com>
References: <ZurLc9qEjBH9MkvK@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZurLc9qEjBH9MkvK@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2024-09-18
X-PR-Tracked-Commit-Id: 5e645f31139183ac9a282238da18ca6bbc1c6f4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f0c253ddddca608457a42e509267bed2dee0a50
Message-Id: <172666801314.843157.13367011248923781262.pr-tracker-bot@kernel.org>
Date: Wed, 18 Sep 2024 14:00:13 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 18 Sep 2024 14:45:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2024-09-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f0c253ddddca608457a42e509267bed2dee0a50

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
