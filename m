Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB1E1FCFF3;
	Sun,  4 May 2025 19:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746388763; cv=none; b=mZGXabZnO1jYPXfSC2SscXtLm/QQP7S2j+pdRV2/WHM2f61XiJm+sK049HBDjYmHUPh+dsBAkFNL382d240dvHAuXOUwdTYIe5CVqrFDnhWTTC18kcCw8VXOs2Aa7RXFzvimSETcQ6uT236teFfg1ZoYza7BdnTWliBm1N2hN9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746388763; c=relaxed/simple;
	bh=qBtt+GVsZCvSezanP5TtC+a6V6QBE0q5TI2J0Jck5xo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ANTogSt5rtWEOoWhevBsU6JlVXwrgG4pT1wX3I6KWHUND21koui9hxFSsbY7qfnIRsUVhU0EyJBZqX1b+4TLZcOVhThLWITXGFHGOIjsWCA0WP91ksfodeC6ySqKPIuJo9pLYAUwzhvzO6Mq2SUei3LV4BteRov8CglsvkrwaYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYdjgFCJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYdjgFCJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A96C4CEE9;
	Sun,  4 May 2025 19:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746388763;
	bh=qBtt+GVsZCvSezanP5TtC+a6V6QBE0q5TI2J0Jck5xo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SYdjgFCJqg+4Jr51TPLRTwZd+p+/s7psHb8BtkA1UzeyoOj4GCX70xr080YpmqNVI
	 GmnCS4BSrA+x9cC2CWLAt6XoJfAHyOyEsOkDmNDAN4D6RXpRdm8jH4Q9AYisSV44NM
	 KRxOSMLNokAPJRkVNGorFuyWTTadHVbl0BzYey0TFqU5rov56LgTwKXo7xPbB90pKm
	 CtThdBmqV2MmigsWY5m1COUe4TteXMoFphb4063ndGDXVyNAwiBsPKYq13Xh2VXJ7c
	 O7OcPetbFvYCAWqMdh28GFyWRRA9AoLXk1CKl1KK/8HGJHCllM7XNAD1INmBJSWIE5
	 1XAyvVBdosmWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F023806659;
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
Message-Id: <174638880216.4091468.16205945171387196691.pr-tracker-bot@kernel.org>
Date: Sun, 04 May 2025 20:00:02 +0000
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
