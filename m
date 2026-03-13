Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D6234D909;
	Fri, 13 Mar 2026 22:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773440115; cv=none; b=W56yNhkn3bAqq0sxNiBAYZVC+yPMtLOckFzKmbLrUCK7EKHydu7PF0oxrOh7CG14HxzWxiCOK3OgsBDCe+U2L13/tsgiS+/gf9vtHL2Iil1Dw8VYgrK4io4X8C7KiVEIY34YAUKLsdA1V1BQX8KpYy9e+BHNNXwhHwSQuVHZXAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773440115; c=relaxed/simple;
	bh=SbkMdtOI00DXZ/ZnlQ94Fw8jU/tkUlXJD+cc0laGz0E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LzBGZoe3tYR721JC9J0kMBk0fhLpOCp1awxr+zUtE42umlBZxbgdBlK4QXDYV96x77lLi1Uz5YNSDbcubOCUqxBMn/qKmwEzpRbHYy7JXrAks7qL4kjN8/NfzZjV0Tkj17o0EVdrpNpZrluyjufe7q392ZOLZHdAdkjpy2x/7dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/Y+0ppw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/Y+0ppw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23067C19421;
	Fri, 13 Mar 2026 22:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773440115;
	bh=SbkMdtOI00DXZ/ZnlQ94Fw8jU/tkUlXJD+cc0laGz0E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=n/Y+0ppwxh0s7WUAvICmNN6zMhfX06ekeOzsAOZyaBwT+kP9vu1zMRjLjQZ72Rexq
	 K6HpPI6mczwzHXkgKN+M+PBmFmRq2A9qdDLxwtXfu4YS+dXroj3oZxjx0/sgTMNNwp
	 f4isyDQjVyNazYEhEbaPrBL8bdlG96yIz4hejjgf1U7ZnmnRIO4CNYFDAYBVtjwEx8
	 k+LuicLDPILYbLzd0DvVYaDXht7oq/VFMQO2FlLYOSxr7TjbmXpNAP8gegnQS6rZe8
	 uKR2hj93yeeKngu/yE+PdtSiPFgtLLmDtQr4y55hBCte93ETi8hpt9LrB4ONme6S+4
	 n0e0uVS5T+PQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 030DE3808200;
	Fri, 13 Mar 2026 22:15:11 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260313151434.1695228-1-acme@kernel.org>
References: <20260313151434.1695228-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260313151434.1695228-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v7.0-1-2026-03-13
X-PR-Tracked-Commit-Id: 35b16a7a2c4fc458304447128b86514ce9f70f3c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8040dc41d272658ac22939ed9cb5ff24240ad851
Message-Id: <177344010964.1522840.10491107437946418587.pr-tracker-bot@kernel.org>
Date: Fri, 13 Mar 2026 22:15:09 +0000
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Changqing Li <changqing.li@windriver.com>, Chen Ni <nichen@iscas.ac.cn>, Chuck Lever <chuck.lever@oracle.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, Leo Yan <leo.yan@arm.com>, Markus Mayer <mmayer@broadcom.com>, Peter Collingbourne <pcc@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Mar 2026 12:14:34 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v7.0-1-2026-03-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8040dc41d272658ac22939ed9cb5ff24240ad851

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
