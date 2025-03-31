Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE70155725;
	Mon, 31 Mar 2025 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743440855; cv=none; b=suR5ikZPQLd4wh9j4IB2OtkRkJCKXrmdxDcvNxDSm8GrL4a42adf+8pximoUg27Hho4EIWnD/OArweqi7qk4r9lV5X1OGh3nZa1QrYwzeiah2nmvb9gmVhK2h+30d4UmdFI8aliefd1ul1qhNjId/gZaqGpgWJKBG4I+CeNoxDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743440855; c=relaxed/simple;
	bh=1Nk0JxPo3IrWyqDWIESPIvocBYdWxLmAxDWkJ1OndHI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VknTYBmDDAZnmCC4GfNn43Y1fXgmFKVo7+/qptO8zKAFGA9469yW5HkypQF31I2bo74PLf3R6LO3/f59cJRIm2C+jTLM3AbwOzy73ycW2A49jJm0WCVCZAlcyEXi5P0PTw7mNRaS4l7PHLQEr3MHbVd7vUcRRMD/Sl0TCt53Pak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ox0NIZSP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ox0NIZSP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6430C4CEE3;
	Mon, 31 Mar 2025 17:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743440854;
	bh=1Nk0JxPo3IrWyqDWIESPIvocBYdWxLmAxDWkJ1OndHI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ox0NIZSP087PvOMptGPCL2xFsSWvnHcaOTSQLDyU/+Zcn8yiQ78zjCUjhcNSKZNVk
	 IU+GV+1XSUO3C8RNf3dTtmeYLQViOhoJn8tFoOxd0tV973rcOsYuybQwY5FtNFelq3
	 pMx+cPFmJt4arfoz8YwiQEEx5xPGj9IQVdaX7Rdh3hpJAaPfUXhtNBzkfE7ZVkb9d6
	 8heD5X+aG9WGLGBt5RIeFRdC3oI0PB+3aWhvvhTPw5UkoHLcB/IjEzpxMFxHucMoVz
	 w4hVFm5nSov1ysaTuWN0DxqyXbQO3VJqWB0midi/DdrgsOfRjp+VnFzviVgMxPEnqC
	 tXO11yGsYyfUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEBE4380AA7A;
	Mon, 31 Mar 2025 17:08:12 +0000 (UTC)
Subject: Re: [GIT PULL] perf-tools updates for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250328063228.3824573-1-namhyung@kernel.org>
References: <20250328063228.3824573-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250328063228.3824573-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.15-2025-03-27
X-PR-Tracked-Commit-Id: 35d13f841a3d8159ef20d5e32a9ed3faa27875bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 802f0d58d52e8e34e08718479475ccdff0caffa0
Message-Id: <174344089132.63132.13406299838665692519.pr-tracker-bot@kernel.org>
Date: Mon, 31 Mar 2025 17:08:11 +0000
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 27 Mar 2025 23:32:24 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.15-2025-03-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/802f0d58d52e8e34e08718479475ccdff0caffa0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
