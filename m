Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5554EDDD5
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Nov 2023 17:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFUt143O"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C156FC433C9;
	Sun, 26 Nov 2023 17:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701018979;
	bh=7M3/4ZbMyAhepzjvoftadoun0c9VmWveW1PP1vraAZU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pFUt143OeVpyZMB88ctmg/6C5l34B1l8ljz+lWEJGusMUmSdHRaEC8M1bCSLQ5gKy
	 QJQZ/maWLg0FY/OI7FeuT/+zYc3MIrgF+F/bQcNB+AAM+3DP+2YaD2ukCei1mTwl7W
	 Drz/eNoydusTUSL4SxwcPL6arYROBgm7XPUZrO1p8EQ58id7b4zjzIk53XK8DodOQg
	 YSGSdWAHCP+/o/edcbmtGL4DYR4cD7lX3bexHQ2MdEYiaVOd4kcz93kdfoOG52BW6Y
	 0nDqX5gBuHZB001EYAZimcyYwFyW78an9qY3gSh93UEDdU8xUuqWZuA+HKufaayQAZ
	 /8tI9SBFOAIOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5538C39562;
	Sun, 26 Nov 2023 17:16:19 +0000 (UTC)
Subject: Re: [GIT PULL] perf events fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZWMTOVr/81MoNEEH@gmail.com>
References: <ZWMTOVr/81MoNEEH@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZWMTOVr/81MoNEEH@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-11-26
X-PR-Tracked-Commit-Id: e8df9d9f4209c04161321d8c12640ae560f65939
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e81fe505202fdc07b1925aa70fca5e2a714eb259
Message-Id: <170101897967.23229.17645807255711173572.pr-tracker-bot@kernel.org>
Date: Sun, 26 Nov 2023 17:16:19 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 26 Nov 2023 10:43:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-11-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e81fe505202fdc07b1925aa70fca5e2a714eb259

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
