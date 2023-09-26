Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D51030FB9
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 16:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02EEFC433C8;
	Tue, 26 Sep 2023 16:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695744877;
	bh=I2/eCq+ueesjbaY1wQtRUaEZU9IZyKf5RNPtZKzXGQc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=F7alCDU3JBFLO6G+ixaNXv2Hus++yh9AmVNtlPRQqR5bdZv4hm3k5gOq/3H1m0tCn
	 6IFfaJKCw401KveRKoLAkhooAN8bw1G6qCp8fZTd8wLuTDt+gPACzojDNbUPutLXjt
	 ba7Ph5sL8pdEOopjqcPcixkWiPlkVZXQEFcY5cCHwjSsKK0GQjym3yjIXWinRY2Rq9
	 erfww6t44D3Z8XytzNIIXupaY+tAxFsFXHzucG7GwILJtD453F33AF3uw3F4dWrWKU
	 mleTr6JhWqxNYtoVVplmuzYaSYOiilY7pxlYpwB4lfCAqHN5+jZdbULGie2hTjy2VN
	 +DNNzPuJoFOfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4DF3E29AFF;
	Tue, 26 Sep 2023 16:14:36 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v6.6: 1st batch
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230925223709.3417084-1-namhyung@kernel.org>
References: <20230925223709.3417084-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230925223709.3417084-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.6-1-2023-09-25
X-PR-Tracked-Commit-Id: e47749f1796d1df39a7eaae95f2784aaa43df57d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c519bc075b3306a5b6a6d5f1e22f37357e936d9
Message-Id: <169574487693.15087.7978378581214612181.pr-tracker-bot@kernel.org>
Date: Tue, 26 Sep 2023 16:14:36 +0000
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 25 Sep 2023 15:37:09 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.6-1-2023-09-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c519bc075b3306a5b6a6d5f1e22f37357e936d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
