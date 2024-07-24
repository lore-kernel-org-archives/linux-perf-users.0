Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5189479F4;
	Wed, 24 Jul 2024 01:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721784080; cv=none; b=Lo1qITO7N7921eeDEzD2zQnkNLXYFXTKTlG87SCUCKrHHkqvfoOgu/ISe7M9D7LZSBfNajzebc4eM5RkXWU9Gnx0M+ctbYAp6HzwcgjEL3i/nRR5HFgvQag5W2j/dvSoFVdoy19bFapNgAsrN1HJiFK/sxdMZzzzq5bAewmtkck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721784080; c=relaxed/simple;
	bh=pp81yuwYhvAXS63Z2o3psOebmDlbIBXhY6R/v+2mWr0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=av9Eq7Q6rhWNwxQluOU6AwxRsAR6kdPT1F7n33MlOorYcKtH3p3ioDWLvA/XiliMSt/NLWSC3FX5G3TOrMwVTVVd43I/k5xdz6TqsHAy3mICyl8IEnr1/dSVPIjztPDl1qGotwryqI/vIWmttScqTKoymE0VcobQUyqHCDeUC/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWEnAuMT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWEnAuMT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D254BC4AF0C;
	Wed, 24 Jul 2024 01:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721784079;
	bh=pp81yuwYhvAXS63Z2o3psOebmDlbIBXhY6R/v+2mWr0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nWEnAuMT/nmWYJisSNC17aPr6rYhISxZqnpTIlSZUB70520vQamq1yFGlTylCaj8+
	 KYIhfWQAFWWreJ+nHBVBmHGc87Y9ct3HKweIb6PR/PnXVtCECOy6BcnZUQlJALwGH9
	 Fiw73dazzKONyccHUSM9ix+Inm20DfMjn3EVemt1Kig+YLUCAWudxk6JVSmgWUC5JQ
	 hIsLSjSlzaXVybSRbezu8G0ANYY5oxDyOJbKcVpaKnpRSp1IxH2XVmP6wdPvU5k4Uj
	 1yNErueRXZMqxvWV3ZYy8PJyg2r47/GTOHJSte0E9gN2yTzSEDoPQfpzjxBjQEY4B5
	 PeosRshKuRviw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C652EC4332C;
	Wed, 24 Jul 2024 01:21:19 +0000 (UTC)
Subject: Re: [GIT PULL] perf-tools fixes for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240723230436.1050616-1-namhyung@kernel.org>
References: <20240723230436.1050616-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240723230436.1050616-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.11-2024-07-23
X-PR-Tracked-Commit-Id: 92717bc077892d1ce60fee07aee3a33f33909b85
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 786c8248dbd33a5a7a07f7c6e55a7bfc68d2ca48
Message-Id: <172178407980.1898.206599382824296437.pr-tracker-bot@kernel.org>
Date: Wed, 24 Jul 2024 01:21:19 +0000
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 23 Jul 2024 16:04:36 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.11-2024-07-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/786c8248dbd33a5a7a07f7c6e55a7bfc68d2ca48

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
