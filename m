Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B6614F88
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Nov 2023 19:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POjf9aza"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AEA6C433CA;
	Fri,  3 Nov 2023 19:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699041207;
	bh=eWbf+K66GYytFJTtMIaAJdCE2F8axlLD9adripxwAVE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=POjf9aza5WzC9bDqfmPS0ldnJVNKtBldXdtAR+f9PWa3X1RtE2zpxxsQ/R5PecvuS
	 iDIOVj6OVYyUgjnDygYH4be/Zr/LkW3GYv2R9D/032CXEmyMXbgHD9gwVsmudh4Mzz
	 UDvgCYPHychwC/t9VVT/EAxlEZu9BMbIDL2//0hTkqFQyM2ER2hVxB7dDy57/iOI3s
	 HlVguDtEANfTxDuAIAv65562JfjRwjuf57XS3Op88ebMB1NGOrokefi5JcyPrhJ1S/
	 C50bj1glZko9bszb44QtxgrbUJQuDgb6lFjE90OuRl4d7DtpX5vqNNnfly1pHuRKpw
	 HvINLSP+vt5oA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1971AEAB08A;
	Fri,  3 Nov 2023 19:53:27 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231102150620.940538-1-namhyung@kernel.org>
References: <20231102150620.940538-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231102150620.940538-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.7-1-2023-11-01
X-PR-Tracked-Commit-Id: fed3a1be6433e15833068c701bfde7b422d8b988
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ab89417ed235f56d84c7893d38d4905e38d2692
Message-Id: <169904120710.17286.1383363118665594734.pr-tracker-bot@kernel.org>
Date: Fri, 03 Nov 2023 19:53:27 +0000
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  2 Nov 2023 08:06:19 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.7-1-2023-11-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ab89417ed235f56d84c7893d38d4905e38d2692

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
