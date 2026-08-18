Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A65356758;
	Tue, 18 Aug 2026 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787090484; cv=none; b=NfC81PSZsmqniN8khJ+GUCkTYDPIYR5/wXHv0fLesLTZJXgomfLFezog+HFaEeyZ65Jnf7BWOQ5mpL1qYIi/nlTntNhB9qqeKX1lQDZ49YMeuB8AuwAwY23r18qqxtJAbsD07ygiWjLDs0L5MGz/NHnnO+GW2HWSVUIUw2S7Wng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787090484; c=relaxed/simple;
	bh=rzWh+bdtrH52r2pwjoaaomyjyrI/j3MWG6+gZ8sWtR4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VVo4tifsgIMQAuzW0uVH+/2mFNbnzW3MiX2PFHFJ5I1TBIHqXMHRHVz/+1/Ojz1pFaeAdTgSp0UEH6SuHqfPiPTVaLlyfI8OVlmXSiaYkG2mmhoH+3RH4iZLIqD8xrJSzWE5kpODj724ydDxM7MPYaAqeL5Jfsjt+0CWcw5qhMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNDEBtGJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNDEBtGJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39E31F01569;
	Tue, 18 Aug 2026 22:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787090480;
	bh=jlpiD3cHKc/QJvhdFweGj7C4x1HcSacpjA4i9K9qiOE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=PNDEBtGJdVqbMUCrD2zp6ziK+VV+YxV+WXbhkDGNw/J7rBfkQlY4CUH6l2R0mDC+W
	 cej45YC+VJlP44ujWlVswZ/w9DwqYAJ+fviYG7ZPMcM9Dx64trnw/EFWZ8NdOVrxsx
	 zazLfzOg6ix+sZlfm25jGhaQNo00yQGPuzeOiDyamS3PEjv2cMWNCl7659Aw+eJSaU
	 vqsUpabB1XcyIq3Hh9eALW/nWwZr+U0l3llghexPkyebtySvnCB2lOPBUw5XxaKwE3
	 RDFbeRwG3dTdOwgQeaNkbsxSq0aIbWDASG9yZ+y+5V/SnPH0fKTpsBaR7IpX06H/vr
	 RIB/nTqa1M7eA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 86073392705E;
	Tue, 18 Aug 2026 22:00:33 +0000 (UTC)
Subject: Re: [GIT PULL] Performance events updates for v7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <aoLUyf6R-TBxOgjT@gmail.com>
References: <aoLUyf6R-TBxOgjT@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aoLUyf6R-TBxOgjT@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2026-08-17
X-PR-Tracked-Commit-Id: 917d558b151cad5b05991e5eaee22efab33525ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8915457146a11d20a6c0786396376afda65eec40
Message-Id: <178709043241.2714916.10542583230993946915.pr-tracker-bot@kernel.org>
Date: Tue, 18 Aug 2026 22:00:32 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 17 Aug 2026 11:30:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2026-08-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8915457146a11d20a6c0786396376afda65eec40

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
