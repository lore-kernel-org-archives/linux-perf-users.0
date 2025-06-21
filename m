Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7878F14B092;
	Sat, 21 Jun 2025 15:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750520821; cv=none; b=sEY4HcTkwmeVutdl0KUBlZFRrlzMiW8QL2IusisvnOKYy2dIP9H/xvPKc/G0uVLiaDldir2YM8/Oqdpl/WY5B4NIJFsYLMpU67Xdp1J4mpNg/Gt2AFoI0jXzpQAzgF0LpPCnyB5xsSQpiy5RKNXERKfr+NUwCEGBvsEFdU4lXY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750520821; c=relaxed/simple;
	bh=y6eg7XY08StA1u8AARMkMD85lKeWZ+32lW8mFR48Ahg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ht4XAfO1NdAq6E/6lO1+0+/md2TB8s9Yr0gWHn9dxV+XA5k6OSdyeIXEgZyZGSotPvbXepbOGWiGdRbJzMT6mkGSnDuIMIBzskW1XMvGYspBnOtF6JXuEnbUB4PugZT+6nTm8UP+/sR8/kh0gA5B3//BjyXMI08y+y7yR8AS9Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gs11E1rS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gs11E1rS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5499EC4CEE7;
	Sat, 21 Jun 2025 15:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750520821;
	bh=y6eg7XY08StA1u8AARMkMD85lKeWZ+32lW8mFR48Ahg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gs11E1rS5cNWrAchUwwE8HS+PMEaYWtWPrCfwR/qJJNv3o+ZpruzYbErbDjgLxF93
	 BLzbIfrKvRbzALc2VLz+FKCEuvO1zro2fekv2RaSl5ZGu7qyGm1GjJ3PL14fbkLvCE
	 CXovEUQhN3Dg7DY3+pX2LJ360QB2Ry1ir/xW+ZGczxVrasab0hNrvGFfo3IYpYiPti
	 F6lMfnWDbgTI9NUKRfnaMRV4aK5fW7c26WZtCODni2nN2MAUcBLDr/Gow6h+hAF+d6
	 iUPmBlma6xjramLZusj+8oa27wn060kh6ckKdUJ+aRUMIS6xaoqLdoX3F/yNjtnTNv
	 9EnthqLswBiGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B2A38111DD;
	Sat, 21 Jun 2025 15:47:30 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250620155415.88215-1-acme@kernel.org>
References: <20250620155415.88215-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250620155415.88215-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.16-1-2025-06-20
X-PR-Tracked-Commit-Id: d222b6e6fb31e320eca506e665694d8ddf459157
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c7f9dd1ea3fc6b175b7227bb473dc883b925548
Message-Id: <175052084884.1887408.15139709076211027681.pr-tracker-bot@kernel.org>
Date: Sat, 21 Jun 2025 15:47:28 +0000
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Chun-Tse Shao <ctshao@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 20 Jun 2025 12:54:15 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.16-1-2025-06-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c7f9dd1ea3fc6b175b7227bb473dc883b925548

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
