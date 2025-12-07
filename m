Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CFE22D795;
	Sun,  7 Dec 2025 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765120773; cv=none; b=Qg19U33BAIqcL8cm2VCo/iv3JcnL9+l9f/Uq8TMoJc93zi4A1X44cwWtlp0hn472sGc8o3IMnSFIDEO4h6fgHjZD2ItaVIeKNP01dmxNXaKrs6mxHcyjNew96acYMHAgtHMzBUO3kr+9zqlX5biKYB6uhyjtSCEDo8aXiqXpmzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765120773; c=relaxed/simple;
	bh=rGKYFrOPC11ow99H4xYJXSFa5PkZoLX4dswiOvVqCbo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bZMbgImsSV+1GUQhEu9RrBIMU1LQJPix6j7Uvxs1K8YjPDVVOBFEJaxgW6xKKm1Qf/f9nS5PQNP4zhxbN8bNg5gUU4SueB04wJ0pOf0BWTlS4z2mFe4MaDPQhsPG49VrY9w6D3ao1GiyUu2U6phe+r0kVnYutNhosaNy3fXkPCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rr6smIKF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rr6smIKF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4631C4CEFB;
	Sun,  7 Dec 2025 15:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765120772;
	bh=rGKYFrOPC11ow99H4xYJXSFa5PkZoLX4dswiOvVqCbo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Rr6smIKF8a1lBuoAh55UsSluJHz9ka4j7Geh04sX8KZdTsFFn1MWR2nOg9aMvTJqw
	 oJBn1qp6wrrGa45d+iChX6gZTffC3NIlobxLEhUU9nSEf74OoCvhirh1IMoKEhyrft
	 YUaaJ2Cv42lbRMaw6osQu8xV0wdK4wskGnC11T9DD6GfKdIBV6PuT7sk46pN+PA8hi
	 vGGvRRpx5+BBg+0FHSwn2gkShcKZLpsyTURuSROQK815mfY2deAKEXjCy/2WFaVI5x
	 MOLZdehQRw9ofWZtWsY/6yTDS/y2aNiaiUdR9qdqnjd8Eid5P8zeynk2ALoWDDgejX
	 +2aLiFwteQzsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78B1F3808200;
	Sun,  7 Dec 2025 15:16:30 +0000 (UTC)
Subject: Re: [GIT PULL] perf-tools changes for v6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251207064943.798877-1-namhyung@kernel.org>
References: <20251207064943.798877-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251207064943.798877-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.19-2025-12-06
X-PR-Tracked-Commit-Id: 2eeb09fe1c5173b659929f92fee4461796ca8c14
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e906a9dead17d81d6c2687f65e159231d0e3286
Message-Id: <176512058908.2455931.2916452943137927653.pr-tracker-bot@kernel.org>
Date: Sun, 07 Dec 2025 15:16:29 +0000
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Sat,  6 Dec 2025 22:49:43 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.19-2025-12-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e906a9dead17d81d6c2687f65e159231d0e3286

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
