Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3CA2F693C;
	Tue,  2 Dec 2025 05:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764655034; cv=none; b=URPAwJ6mtPWvQAbNYCTozMHBFKUpuhAVJ+u6RNsC0YM5r3GuYx7yykBBO25lfnyX0smB54p9GxFPX16WyPKmL4fBhNaadZxu32VufDXISdaqKPwdTmRfFc1zSqa0Yd1OSDCyp3siyi1yXvDuzLeND9yXYBX8E6zhCUUQFVk0Qd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764655034; c=relaxed/simple;
	bh=WcvAia8YtngQoj/NfZlCgtvhHGzNSvGKXwf/OzSZ8C4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=S5g2kJNShQ1gkrAP8ceuT0EYZvUHzImSEyQXihnrYDcfYjU/VXsN02JJPm2flPupbAoJ0FxHEIpvrGrHc+aUxzcgKOq5gko7q3+k3JsdRDXnIQLrkKuEJy8tplpGLoaFkqgara4xxePLyUHEKFxgxijMcsWFf9ETF/vCQ1W1epE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHUQSQLz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHUQSQLz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86480C4CEF1;
	Tue,  2 Dec 2025 05:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764655034;
	bh=WcvAia8YtngQoj/NfZlCgtvhHGzNSvGKXwf/OzSZ8C4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lHUQSQLzyThp9Fu//lYk4pHIfrTW70na0EFWVjyNEw8cOmq7UcbX9bt+9WTVrbGMo
	 wOGm8K9W5hNa9+v8qB1czEBGctYjwo01MPtIKKQqkLaGXEO+siyWus9NJtvP2EJDJz
	 rtUGHNGYvHNzStc7Mx5saJuT4MZXKBOBv3PsbtP3ZGpDdMBWFkx9LNwiHOp7L+3XSL
	 SjR4p1Upjpk7jjhZlmD+cHjDOP2MSNCXewdY9aD1KJ+Q9nJGZw+gQ0cZZsRLdQ3JhN
	 UJglCM8Du+/b7oQzkpTlDllbxqghWj7QmqCueKggPTFIc072hMjCuS2tHNK74hS6Cz
	 91+npCcWj5oHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78B973811978;
	Tue,  2 Dec 2025 05:54:15 +0000 (UTC)
Subject: Re: [GIT PULL] Performance events changes for v6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <aS1x278mfIu6gIcd@gmail.com>
References: <aS1x278mfIu6gIcd@gmail.com>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <aS1x278mfIu6gIcd@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2025-12-01
X-PR-Tracked-Commit-Id: 9929dffce5ed7e2988e0274f4db98035508b16d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c26fbe8c9d3e932dce6afe2505b19b4b261cae9
Message-Id: <176465485413.3079227.7371646321425695800.pr-tracker-bot@kernel.org>
Date: Tue, 02 Dec 2025 05:54:14 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 1 Dec 2025 11:45:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2025-12-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c26fbe8c9d3e932dce6afe2505b19b4b261cae9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
