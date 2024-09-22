Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F1B2BAF1;
	Sun, 22 Sep 2024 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727024310; cv=none; b=ANgM8EJaTXZDJWNDxx0NYeCb8qwKbIgoixpWFlgpsNcLoMAkdW+ESXw9uWvVc3ebAf1Q0EkyySsE/q75Xk5BVVFVBZP8jKmp5RIyL9Vjzjo+6gFeBBRyzKvDoh+9Cj/5RKu2QCEq51ftnZuKjmafKqr+17r4glob043eKNNAPdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727024310; c=relaxed/simple;
	bh=jNLGMMFl1HpPDCVhPGotmGUZ/mE3XWTiqr6uX/cB80Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eyIbjaWRu7DmHebqYGd/i2b4bncMp2nZR7aHjJOv/2Jmqqem3mlDrMpr+1f9oHOx+eAf4fgnMKd/qU6CJebxe1Ot7l3zVGyYlKf3T9Z3xLGwzYrJuwmiiJiv6Oy3ADfP91Cpiu3niFcNAX7VXWiEO322Yl2ibPE+nu40dYwBytA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaK4vU0j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaK4vU0j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F52C4CEC3;
	Sun, 22 Sep 2024 16:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727024310;
	bh=jNLGMMFl1HpPDCVhPGotmGUZ/mE3XWTiqr6uX/cB80Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DaK4vU0j7U+eWTuqPYM4tTqKKGSvI1Qds3dNUdTcJIvKJiCgX+FQELlAVauGbyTyH
	 JWVsiIzGjzUz7GLNE2/JQ0m0VqLVn164mSsYl7WAVlpVuX7Cy0am2XyzZyidlXS2g2
	 xxd09RYbt1OkOgSTxrfyrIXH6/WFMXHG9G80g+rplkdI1u2QrOJtn45nDmgHr9zVkZ
	 hpsxi3+NcZorR/3VtcggEFbIb4mUL+FRn4alKNOX3y4HQk0ceRSBHJ/roJCzFJ9vYo
	 3AbvtO6aZmn22gMy3c6P93q7ujfNwcKY1MkK7PDajDSmFHXPbCOK8Ffdq6msPbwy5V
	 FD45+yUeSqrEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1FE3806655;
	Sun, 22 Sep 2024 16:58:33 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240919143330.492157-1-acme@kernel.org>
References: <20240919143330.492157-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240919143330.492157-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.12-1-2024-09-19
X-PR-Tracked-Commit-Id: 1de5b5dcb8353f36581c963df2d359a5f151a0be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 891e8abed532423d3b918b0c445dc8919bc445b5
Message-Id: <172702431255.2797494.9066269254241132576.pr-tracker-bot@kernel.org>
Date: Sun, 22 Sep 2024 16:58:32 +0000
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Andi Kleen <ak@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Brian Norris <briannorris@chromium.org>, Charlie Jenkins <charlie@rivosinc.com>, Chen Ni <nichen@iscas.ac.cn>, Dan Carpenter <dan.carpenter@linaro.org>, Disha Goel <disgoel@linux.ibm.com>, "Dr . David Alan Gilbert" <linux@treblig.org>, Howard Chu <howardchu95@gmail.com>, James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, Leo Yan <leo.yan@arm.com>, Martin Liska <martin.liska@hey.com>, Song Liu <song@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>,
  Veronika Molnarova <vmolnaro@redhat.com>, Weilin Wang <weilin.wang@intel.com>, Zixian Cai <fzczx123@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 19 Sep 2024 16:33:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.12-1-2024-09-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/891e8abed532423d3b918b0c445dc8919bc445b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
