Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792537822;
	b=TzmtFk8LzQqXOcyavYBvI0e2BzCmTGrERp6S0JU3LKowWmifCktCfHTZbs1R0WssfuWG
	 H+3XvOnPMZ0Tb9CwBIceQ2XDw5T7m/bJXAHamtQvCFAMkMZY6V1aJ7658m01IedHaRsHd
	 cji/ujWB2iekYLSkqMrs1UWfEmZj2Ax5e3dbO1F2Ufc50BncSlA41UoSel+E6aDmjK9vz
	 E7aVWtPdJcdJGDLzcKLGskJ/KgIJ/PdeFxM2Edt8a84aHzhIBRfi0JtRAJAm+QuBvyVu8
	 Uilbdg5MOijuHBKcdiYqFJL8/dY/5K5XjjaacuhiYBEw19oUwKzXn/vzynIsl7qhqHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792537822;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=UHi+Ht7oWCrghotH1fFqWFDECugOtnkvaUX7dp8MUh0=;
	b=spywd7gC4xPZe9xJLY+dQOt8pry1nmhoS+A/GJr9AjzdQ/tVRjL+dGDfrkRHQgBqkmJ8
	 E+4blvZc1z7285I8G+IXftaMfnb488jndxVzJIg5SNP2KVErLtDE7totqWIyS1o0wTvzu
	 7OL0zEgWjg/ob8JyaLNAUqR+HIy8ILSAbjmghn4L5rzCxD4CpVzhR6NonIbLr83dK+M08
	 vz9W0TGkWEI/UUEYhKo46S/nDmyo5CZyPXYuIflT4bSs7EfkAD3bRqbNgfwd2A6V3jnxM
	 4MNHyt5icQ0UNzelzxJCBtM0lZEO3Q9+0b8hPGWTU6E+XEAxzb6+N7BSGVEs3ktW9zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f5iKOnCc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7792606A330;
	Tue, 20 Oct 2026 23:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f5iKOnCc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE23A1F000C9;
	Tue, 20 Oct 2026 23:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792537821;
	bh=UHi+Ht7oWCrghotH1fFqWFDECugOtnkvaUX7dp8MUh0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=f5iKOnCcLVMoo7I20nOdwiGOJIZ4caIgGieK01sw4JUHINvLXs9qqri5dTjYyyLKQ
	 oddGyNb+5FkLnGTophPGrgn5oNUYtsLzph2CxLHDmpRyrvv2w7JHAfydtzTvrbuU6E
	 agUGydnNYqJH2nBzdfjBuDB+2DIfH/jDvfdSepEZB2AJNm6wyP9a8paRGaADibeMu3
	 ARCU6h1DB3JpCHfngxG5lvWTBN2aIn3/hop5DLYdCoSgT1qsbw7llZ8GvqRwovZmR2
	 YzzY7DT/cp5MegAVf0ZpDBU918E/iT6ynDYKoOrch1XJLPSPWw25ENl5rifotpXOjm
	 daN13fu8Kezzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B43D03809A0C;
	Tue, 20 Oct 2026 23:10:21 +0000 (UTC)
Subject: Re: [GIT PULL] Performance events updates for v7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <atSZt26TkKplm5qA@gmail.com>
References: <atSZt26TkKplm5qA@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <atSZt26TkKplm5qA@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2026-10-18
X-PR-Tracked-Commit-Id: f5a78ecccd98a04c47cea1cd63c2a2fdce8a4b48
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4cbdd58dfa7aaad679bf62f81cdbc96a6cb7c6ae
Message-Id: <179253782050.260052.8152593764682381544.pr-tracker-bot@kernel.org>
Date: Tue, 20 Oct 2026 23:10:20 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, Sean Christopherson <seanjc@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Sun, 18 Oct 2026 12:04:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2026-10-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4cbdd58dfa7aaad679bf62f81cdbc96a6cb7c6ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
