Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCBCD290
	for <linux-perf-users@vger.kernel.org>; Sun,  1 Oct 2023 17:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5CBCC433C7;
	Sun,  1 Oct 2023 17:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696180098;
	bh=rIxOYjI3GOdZg9X/m/2x92ZThBipc49IsicSCL9XT2g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ehhSlzS2UBj97C3+Q9jH5Xj4RpOdJh2yraxeubLfjvVmtOPn+iCHipo3syf3xH4/R
	 KraoC3a68jzoPO6XvSl37djjtGwOIrX/r+ZF+kc3dhF1q/OBJVdzuvIkzjDENswK/F
	 NoSWVdm1tWzZYxMzTUWW/LNkiPNblS2smrFLbZggLHP4LiKCKUQ32LUSEKQWoXqDqx
	 RbHEjUYdF5ySgHxf44gowwRIdhRhQ7GAzyr/LarJldr/MQ4k8tgPlguq9Y7LlwTboM
	 0mlAa3okJ933lRoo57bIT/nyLefbjw9bym6s2W1/oIqcBi3d7Uy891FtfH/W649PE7
	 TWNT5ReBGSHcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F36BE29AFE;
	Sun,  1 Oct 2023 17:08:18 +0000 (UTC)
Subject: Re: [GIT PULL] perf events fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZRkvXkyEXYfoAPiA@gmail.com>
References: <ZRkvXkyEXYfoAPiA@gmail.com>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZRkvXkyEXYfoAPiA@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-10-01
X-PR-Tracked-Commit-Id: 599522d9d2e19d6240e4312577f1c5f3ffca22f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a38c57a87aeb5c6d71a1b6dd572569112dbce38
Message-Id: <169618009864.11241.5479391659294189712.pr-tracker-bot@kernel.org>
Date: Sun, 01 Oct 2023 17:08:18 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 1 Oct 2023 10:35:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-10-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a38c57a87aeb5c6d71a1b6dd572569112dbce38

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
