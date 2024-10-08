Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E730B487BF;
	Tue,  8 Oct 2024 18:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412368; cv=none; b=kdgnluYEV6m09XWr9l9vHI8XndexGTZhrxOETNSdgU3LYPZL71fAj2/caXcPYjyQj1BULLAQS0N+y8qT+ClvrEvl4DqMuIPw8nHYYPJivxAbEhuGcNMjPbZ+m680juB2rzXeQ6tdhNcQHSTRK1aIzLdsXsoEIUSdI0UOKKxRxJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412368; c=relaxed/simple;
	bh=EZcXyQnK92mhEIojwW1omtIJwUnP3T0fmnE4nmCzEWc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=n/+1l6XG/Mxz0VQMYtogkAicoC2FozY657YA+MDVzl4cmDrODeXlf5cJxyf4cCSm6+HYB9KABJZ4l6Z4qSQBa4fFZcNnxp07xBwj1JYkiMUa0e9pK0wk5txK4heMWTKTOnmu4tPAuzzDRI8PC+ISiKqs79d/3lfaofTIrPHlteQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvj01IXe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvj01IXe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA36C4CEC7;
	Tue,  8 Oct 2024 18:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728412367;
	bh=EZcXyQnK92mhEIojwW1omtIJwUnP3T0fmnE4nmCzEWc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nvj01IXe/Gb+5ThCrqZhOWW1T2JUyhvLfNqY672J2I86xbtjlzgveEnwIfW4smmSE
	 SQESRod91SOPcji67t30GjFwAlS8L4K/2FcRCnYZUJnEhkkAX1T5qb/eoZeHpqvr23
	 JwzyAOSMmwwKVRQyQsdkkB0CY8vCr84MQONfeLKymIKxstkLmmzYWxI14F3zPqRwLD
	 7TCzhz/ne+hBemDHpisw2hoaiOKNuwdHVvCU41kJOghHr11cNWXkR1CrguGZl39OVP
	 GmRgsvaGMOYbq++05ih609DIddG5tJfhe+i0y3tMVG3wyQOUWWWTbJPaQjBzKG4Pjj
	 R3xje/w6SU8pA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FAE3810938;
	Tue,  8 Oct 2024 18:32:53 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241008135549.988547-1-acme@kernel.org>
References: <20241008135549.988547-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241008135549.988547-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.12-1-2024-10-08
X-PR-Tracked-Commit-Id: e934a35e3cc1fe0bfb1bc771e64f3ba6e70c40e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b2760b839044132c29234b648aa4f6a2877de234
Message-Id: <172841237167.640621.9516345254030033808.pr-tracker-bot@kernel.org>
Date: Tue, 08 Oct 2024 18:32:51 +0000
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Monakov <amonakov@ispras.ru>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, James Clark <james.clark@linaro.org>, Yang Jihong <yangjihong@bytedance.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Tue,  8 Oct 2024 10:55:49 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.12-1-2024-10-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b2760b839044132c29234b648aa4f6a2877de234

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
