Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6388189B94;
	Tue, 26 Nov 2024 23:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732664440; cv=none; b=NiRsd6cy2W8oesW0URxdaGBr1w5e4pwAnaTfm4RUGMv2HrIxEGCSSPgkGSHd8Rfv/h+DRwWAZipcDvTcR3bgffvtxhxffa6o5JSd7ncgz517bdcvAHdqkX+0mGS3FX7nsuWG82HFvCobk/ibhiG55JeFC3p6yyim12BniRhO/20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732664440; c=relaxed/simple;
	bh=qdexSSwbLKi2XHGC1Sgn/ZBTleNGY2F6rtMn7iUYhXQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=m1WYyXIwP8Ns2aUwhieZPxdls6pFLaq6OZ/WvyVHsjkJmzwTgCm7NWN8iZ23BmsNtu+JcuB+HI1xMsRGme+7msXfKcl+9xB4ybIdp881PeTgoAViRIUesrGrbL9g0DTXTK38rwSDuqTiRAoRUYB4XVu/wz7CRfnt5SrAzZmFso0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PD1JmL+T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PD1JmL+T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6986C4CECF;
	Tue, 26 Nov 2024 23:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732664439;
	bh=qdexSSwbLKi2XHGC1Sgn/ZBTleNGY2F6rtMn7iUYhXQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PD1JmL+TZ2mPLyl+7gq7z5INVkHxzI4no+60pdvhVwcXJ0HayWB85xJUS3lwpKcWL
	 uj/wLk7Go2X1PYKG3AgcOX+hWx6rE/Yxqyz+4HF1z188UchdAcw3YByPZHswwDbIn4
	 vL0YSJc/9F6TKDKm1Mb8fgJiwnLbFx4nN1muTr2/+0s6ozAVAkE1b9NDfPfYek0LDO
	 /e/MvxxM/NgO5Nq3xoRk8Mh/8MjDIpxMMah6fU1TD0TrYAvFWywypR/NpeSBuGyPvb
	 H/MjR+/bigVOI6Dou09eX3aVc+KvEUlizejIF0G94qStJYbp/TBb4kL5vOHvhG4/Y1
	 1Su2KzlFCrZig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ED9133809A00;
	Tue, 26 Nov 2024 23:40:53 +0000 (UTC)
Subject: Re: [GIT PULL] perf-tools changes for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241125071653.1350621-1-namhyung@kernel.org>
References: <20241125071653.1350621-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241125071653.1350621-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.13-2024-11-24
X-PR-Tracked-Commit-Id: 6d78089da9805787a72e52604ad4b2ed7380be3f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b50ecc5aca4d18f1f0c4942f5c797bc85edef144
Message-Id: <173266445244.577215.10853513841530631756.pr-tracker-bot@kernel.org>
Date: Tue, 26 Nov 2024 23:40:52 +0000
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 24 Nov 2024 23:16:53 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.13-2024-11-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b50ecc5aca4d18f1f0c4942f5c797bc85edef144

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
