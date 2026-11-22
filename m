Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795386014;
	b=28wHM6gZRJPMrUnz4V3EvCt5amT4/e8YOiWlXzXCbp+henoJdPtT3CbWvkvGf1TUNHJs
	 +jZ3sPFs6xqinpo+xv8OTFkknELdTDcvIktpEkKAvHrku58yrtAnBvl3o15j/IhhVX9CY
	 fgOxB5vw35E+sd25MHfXRPqi2c61177qQO4roWLnA8eeSiM+UwAMQnb0UhBxiESiPcsiU
	 NH+iqeM2VdFZHXsCdexl0Q5BcJU5PwuVpMWdetAHBM47QjuEsc9A/7LW2cODu7ikOa6Xn
	 TipjdWo9+6ZD78Z8ev2UPwXPCcAMTqLTMa6RHvkBTTa7NA8dmXSUOpmyOso/VE2TqUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795386014;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=bv2PaUBM3TDE4I8imimZlfQBbC6XunIRwq7lOU+FeyI=;
	b=5d4xJs6UnK6TgrMCQUicE4eKWSNBGgrwo+izGkKBliwoKGaBwrNMa2ZhqGr1mqbhrkwV
	 Q03+211VNZI7xLRQu/eymbD4EzHCzyZTVkgBD7soU0gO8Jfg5HuDy1R8l6IexddkwGiMO
	 J9+eT3zV90s4/LRRvnyXiNDJYf5WI3Am9kS9muOW32tC30z+QGFS1z6GsMsuABinIWYjb
	 ePFKWtavbbBbQkFGwUfTDHBfPLmCjrj2tkUg/A2Yqtjc5nth7ZMI8gQVJkS/N66ywAoRj
	 nV1jATwSOPTTgmSQTtFckMA6dkgOe6HvMps86Wt0lQ6t8Nf5vmxyT5EneBz3DlEtj5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NfXoWYSG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF0C606A681;
	Sun, 22 Nov 2026 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NfXoWYSG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D5F1F000C6;
	Sun, 22 Nov 2026 22:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795386014;
	bh=bv2PaUBM3TDE4I8imimZlfQBbC6XunIRwq7lOU+FeyI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=NfXoWYSGRXil2uQmUVuNYNVHLwmjZ3MzUlHCD4YodXy9J61oT5wUVvcwbp95X5yrr
	 Ul3z4JCAyenllRr+UlLvDnpfHjOY5tUXRwbl7axZc0xCD9HA/Qb1gQexQPSIBOTaxT
	 ZxMEqaZzNlRchFg0NQlE3DUsbFLeJPD/mfuuLK/4l54K+RkZ2W4lDafbn/eGgSuMHB
	 4Ci0dYC2W6u6nr0+/QAtA8AkJIk7BjpuOEQmtCfVnBfi0Q3IwP8fMeRNeJ1sFCA5tZ
	 jizomTRiwOYH4OqFMTTljbxLYAp73cVHExKciPRHvFjMztwzgu/pm0DfPXzx0q/XeP
	 GZfqIgtLs4m/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773FA392ED41;
	Sun, 22 Nov 2026 22:20:14 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261122211128.12684-1-acme@kernel.org>
References: <20261122211128.12684-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261122211128.12684-1-acme@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v7.4-1-2026-11-22
X-PR-Tracked-Commit-Id: 82838789646f9f5881dd1c8b3a3c960ee2a28772
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e4122f0242a3262512ee3e6f2e7e6de0bd5792b
Message-Id: <179538601303.1569645.12913258935528060894.pr-tracker-bot@kernel.org>
Date: Sun, 22 Nov 2026 22:20:13 +0000
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Dmitry Safonov <dima@arista.com>, Gu Bin <gubin@cmss.chinamobile.com>, Leo Yan <leo.yan@arm.com>, Li RongQing <lirongqing@baidu.com>, Paul Moses <p@1g4.org>, TAKANO Mitsuhiro <takano32@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Sun, 22 Nov 2026 18:11:28 -0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v7.4-1-2026-11-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e4122f0242a3262512ee3e6f2e7e6de0bd5792b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
