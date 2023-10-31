Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B501EC8
	for <linux-perf-users@vger.kernel.org>; Tue, 31 Oct 2023 02:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pw8Y+9lW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB0D1C433C9;
	Tue, 31 Oct 2023 02:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698718349;
	bh=/S9RjkfQM+srEm/wdyQkwnt1KJxjEKkHwPDy29O7gL8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pw8Y+9lWg4/pNqZw7YyV6eh1cdQVY7e9z72ET/tXK3Yds1fCssjmYyEP39OxGAmQR
	 x0+xKe63duuXOb7DI2BZ26vuW1gCJAV8Xy6vMsugpRNRTuzS3OrE/6NN4ZjxIxtyf1
	 uyMn6idw3RytYWnh16zZuiaTt17zSVQRjuF1aMKjSugh6JY/t67DgN5Te2sW1US6lk
	 ZcqxCpmt4C1SQxyFCR5VsuMJvE682e2EEMMAFn6lrovg661j4eiFd6BRFOgpibR8CT
	 zfj67Mo4np1xxfPx6VY9yXlRXw8gdUCgoOD3BVwRb8h1QkdEnJl9uIiM+ggqzeSezy
	 unjDJ48nFHCqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C705FEAB08B;
	Tue, 31 Oct 2023 02:12:29 +0000 (UTC)
Subject: Re: [GIT PULL] perf events changes for v6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZTz194jcY008KDCm@gmail.com>
References: <ZTz194jcY008KDCm@gmail.com>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZTz194jcY008KDCm@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2023-10-28
X-PR-Tracked-Commit-Id: 744940f1921c8feb90e3c4bcc1e153fdd6e10fe2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bceb7accb7b60f9844807c7433af06493ed058b7
Message-Id: <169871834980.5591.654322225427050816.pr-tracker-bot@kernel.org>
Date: Tue, 31 Oct 2023 02:12:29 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 28 Oct 2023 13:52:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2023-10-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bceb7accb7b60f9844807c7433af06493ed058b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
