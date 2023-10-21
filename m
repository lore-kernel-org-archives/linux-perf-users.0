Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09842D291
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Oct 2023 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozgdfBHt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7ACD3C433CC;
	Sat, 21 Oct 2023 18:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697912942;
	bh=Pn1ojjDybqAFtIyPJYpiWQ3vTaEatjgQcMJH/lCkV6Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ozgdfBHtrq3YojOsoHOe0RfNz6qZuRJU+TJp2owqnHCcr4mwSOjPQGr2Q2lYSFYqJ
	 Nv/CH3Im8DCNQH+zi7COK770dw1EqsiPzM7AxY9/H95UiE7nhu6arPRCN5wiCW59cD
	 9YYcIzOvEF6GT84FqQp5Z60me6He+zUxzJYJXem2FYL/bMlVPRCU0NyEfWk5rA4FOs
	 werx1N9R1b8YtJ7f742NDC/jslkbaI+R8HA3qybZJMjXyQ58WIbPk22Aw6FLHTXl05
	 4z3Q7MlF3P7BCM3G6wLEZp7ib3EiceDMyK7Es0jJtEA/3BkAYe6E9ZN0OoSVto+P0E
	 f+izJe+OvkpEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65027C04DD9;
	Sat, 21 Oct 2023 18:29:02 +0000 (UTC)
Subject: Re: [GIT PULL] perf events fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZTPs0ncHILbDrGh6@gmail.com>
References: <ZTPs0ncHILbDrGh6@gmail.com>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZTPs0ncHILbDrGh6@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-10-21
X-PR-Tracked-Commit-Id: 32671e3799ca2e4590773fd0e63aaa4229e50c06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 94be133fb2b8a36d79b362b3bafbdfd054a4da89
Message-Id: <169791294240.7212.16966205135487191844.pr-tracker-bot@kernel.org>
Date: Sat, 21 Oct 2023 18:29:02 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 21 Oct 2023 17:22:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-10-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/94be133fb2b8a36d79b362b3bafbdfd054a4da89

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
