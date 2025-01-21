Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB2B1F7546;
	Tue, 21 Jan 2025 19:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737488382; cv=none; b=Krs22ja9A5agkruzwGenlRgXwOgFSP9mm93+hj65besBy1RuPbrBOhLeyceT94d0Qjiji8oVO/V8PDX+FARsc101DxZKjsp7hUWt6xy44iKULCgbZ+T1aumqRtGlj8mCEMHOiTPMObmr8Q/qc3x4DH102L88BXpGyDG6yn4OQYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737488382; c=relaxed/simple;
	bh=Lk5JBL7u8q5gtntCCrWqSthmnnDLkYpOimVrICAZ4rQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mmBWc51UvYMe6/8I4ae0BNOqlp6iUjK7N20pgVtPZsQ1e/Yygppi+mOORNTwR+cQDIewInqeYVe8WiK+Z/WL+uAgX91jp7k3ebzixSJ77suAOGER3Z/C3EneBCzXJCzAEvqdqqQzbDs/WPxTOMw+Hzxy6zRbuYxBF5UPxA4Ollg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFXkzrHp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFXkzrHp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F9CC4CEE0;
	Tue, 21 Jan 2025 19:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737488381;
	bh=Lk5JBL7u8q5gtntCCrWqSthmnnDLkYpOimVrICAZ4rQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pFXkzrHpijeKw5Fvt+X49+Jap03h9gy7KBXKoxxySvIm9LyOyzBCHjYfMzf/wMP09
	 uRiOFmcySPSNxXXJjWc0J5pWBJTOlhhL1B7d8yciFWMmKOGfENrG3gRipuDmwmjUIf
	 TEudK/mgif2e6ehYRZjNPBLNgFgPAUnV3JmebXJAWHz1+Kcg3ElpN1qgT6xQPhPRmZ
	 ZjpKkN4B6I08aCLDa3x7UX5KBAsjyRhvuplxq1ZodTLiOgi14xaf3vhcHUY6qHgn19
	 K5ANq3LOAla0i5VrZW+FWxfLTcRTR8eT6J2vqvfthyzFLMMfFgK8aYyXs6STNM2iiS
	 PzkIi6eboOUxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3EB59380AA77;
	Tue, 21 Jan 2025 19:40:07 +0000 (UTC)
Subject: Re: [GIT PULL] Performance events changes for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z44md4du6C1un3FB@gmail.com>
References: <Z44md4du6C1un3FB@gmail.com>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z44md4du6C1un3FB@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2025-01-20
X-PR-Tracked-Commit-Id: b709eb872e19a19607bbb6d2975bc264d59735cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c4aa896ebee5edf2b35a9d071e5a468797f96d8
Message-Id: <173748840601.97486.4917964343716793854.pr-tracker-bot@kernel.org>
Date: Tue, 21 Jan 2025 19:40:06 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 20 Jan 2025 11:33:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2025-01-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c4aa896ebee5edf2b35a9d071e5a468797f96d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
