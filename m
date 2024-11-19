Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5781C4A22;
	Tue, 19 Nov 2024 23:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732059212; cv=none; b=lAO7qZEv7+I0AMUABbpmIXXMbiA87xsFVg3YpAP2MTZZV18Lq3v3iilw7v39lTUQSqpLAApwn8oHmhN89xJJ0ayqDNy2E9w7QbqwfgCa0kOtXkRFgnLLUD6u6GT19pfb86OMPBSZUHG57nLTtm1RAIw+YwpvcNVe3NmGG//6BMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732059212; c=relaxed/simple;
	bh=t1SMkLGWqJguiu7im//ZfS5ZYmFCFhX7aWltM7g8ldg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=g3Ot0HRDbdTq0ikk00p0EHLBF5AB3azVSn00LGsMb1Upz3jVstrhGuyxE9x5WZjJ9Ujkl5gcZ7v+xOfpUsa4WSoomp+krsfACuPKPqDUoP7o87IMeLdltdb4yt4/gPU43LPb8x9y++dUQTCARr+Q6HfuBWM/ea1qlUQQZlrOPGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0thv8s7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0thv8s7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23999C4CECF;
	Tue, 19 Nov 2024 23:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732059212;
	bh=t1SMkLGWqJguiu7im//ZfS5ZYmFCFhX7aWltM7g8ldg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=I0thv8s7b0ZBwV8i4oRG5oR1X0BLVqIsSDdmlbcYKZ9Y4OVp8IBxEoynM+TgCMvOh
	 dMVQgjRFnIfSiLAiOiQYNPjVXsp3jyHaihDSf50rFYz63a+0YfYisHAwMOFDD3nvNl
	 8iJ7M1xMA7HmioQcWxHqFKRLJtCwK/XpZtDxdubUJsoxn0/DM01g80YiNo5ALGqBzk
	 d5CbGiE2/ghQAvd4u1nqzRKnbueimj+emCHrwAh35LZW8cpWw/6ai4/mm+aE8r14ar
	 RLG+WYjgW4toNtKWIhIJUe6IW/tvJsl9VzIIMxoTbSLZfoS2cPHlunntFsASldAjeq
	 5J+x6jsseLufw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF2C3809A80;
	Tue, 19 Nov 2024 23:33:44 +0000 (UTC)
Subject: Re: [GIT PULL] Performance events changes for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zzt5lYZGF8IOrgpB@gmail.com>
References: <Zzt5lYZGF8IOrgpB@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zzt5lYZGF8IOrgpB@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2024-11-18
X-PR-Tracked-Commit-Id: 2c47e7a74f445426d156278e339b7abb259e50de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f41dac3efb7582cd3f518fadf7764d424f453788
Message-Id: <173205922346.720598.958966713670712493.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 23:33:43 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 18:29:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2024-11-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f41dac3efb7582cd3f518fadf7764d424f453788

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
