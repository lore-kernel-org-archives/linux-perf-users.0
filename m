Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD071E49D;
	Sun, 19 May 2024 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716147417; cv=none; b=BltwZ5wYNQLDn7ZFA1ljK/X2lYwkwMbZ9DtFRtWV2mPTcYaphJZlA8lfpkhLWCTqOwFFC9LRNyRJfj53Xl8M57BETbu5t2Dy4oPh+TVjmWnfaTh6fH0GgUA6LnJxAY2ullrggGKIlG4Ze5Da711GNS7Dos2VMN/kMtSz0cfvi9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716147417; c=relaxed/simple;
	bh=7GZxWbYdatlz2iedZ9NQcJpwSKtBx9MSaFDpM2xV22Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=h2wGlQO2qqezQ3QSRx43jbwY6I1kRzeuO/vZv1n3V/GrkwTY6K7QofW0Bv/ekogDYyRJ2cE3SdOJTxr3JqwZcFoej2mSH9ph7o0hFnIZD57yYAFXB11sde/bLITb0L2Nb3y3xxrvlfv2rV1tEq9kkDtCnqqiG+EKYu2TNou/ocI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLzdGrzI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLzdGrzI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E141EC32781;
	Sun, 19 May 2024 19:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716147417;
	bh=7GZxWbYdatlz2iedZ9NQcJpwSKtBx9MSaFDpM2xV22Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WLzdGrzIftSwnoNzDUfGQvZLqUFhdhWgCf3gkHVOxP/ZNCBiGIdYMcX2FwUmKUK6s
	 KYgKzbHuGw+B57ieFlXG60Iu/5+4aRoCd+tRpPwyCjmd1EtNfJz2kJkZv5lPg+zz+v
	 a/6rwD0VXWojlu+E0RfCqiwYtjHgbwFfDZB2EmqE/f9usfzI6EmoMJYjhEyHmtrTyi
	 ARPMuH4kR7ji22kbmfE/sechifN5p+3E66kri21RgFxj48E8+GMSmj7vmLqO0U297n
	 XXGL1AjlOO1X0t8UCFAyow1Da8BNXBvmwmqow1ygRBBvrcnqmJm0hvNKkP54Z3Wln4
	 M9b/jK4V9ZpTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6C7EC54BB2;
	Sun, 19 May 2024 19:36:56 +0000 (UTC)
Subject: Re: [GIT PULL] Performance events updates for v6.10, #2
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zkhtfutbppql4/p7@gmail.com>
References: <Zkhtfutbppql4/p7@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zkhtfutbppql4/p7@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2024-05-18
X-PR-Tracked-Commit-Id: 9d351132ed706ae24325809afa821cabf6d72568
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe0d43f23110ec80aea1f94eeb1e6ddab9ef453f
Message-Id: <171614741687.6582.3775890467750548438.pr-tracker-bot@kernel.org>
Date: Sun, 19 May 2024 19:36:56 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 18 May 2024 10:57:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2024-05-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe0d43f23110ec80aea1f94eeb1e6ddab9ef453f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
