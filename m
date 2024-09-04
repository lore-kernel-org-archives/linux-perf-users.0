Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1571E00B7;
	Wed,  4 Sep 2024 19:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725477405; cv=none; b=M7raF1BR25mfoXcYX7iU7Lnt9kDaHVXh1vOdqGQlUhveqGSo4tMU5E3l5+dREUmtEWJvMOL6D/qIroGIhW6Pm9KJX5P+MowJlujIDyxvo1aozc0Xjy/QLzX7hNqQCVP5Kw+YO3GnuqR6oEU9nL++c36iDIbX6XwTjvZZfBtaiSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725477405; c=relaxed/simple;
	bh=f7II1IdWzs3cfE7wiW+hiFpacAuoS9NMzhqHSHGuJgs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fxmQsFZbB8ZsRKYWutkUw1KtHuor4w6QDIjatecz8FLnV7oyfdfYUFZhBQpQeUWoIlMugQEQttWEntXoBeJGpOdo5fynBi7vJrUNNspk7+JWvfEUMiRaDmLOUxhSZtadFefHVDXr8qyhmtmPMDK2QQbb0GVfQ9KkD30MF83c2/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSIO3OGA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSIO3OGA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C00C4CEC2;
	Wed,  4 Sep 2024 19:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725477404;
	bh=f7II1IdWzs3cfE7wiW+hiFpacAuoS9NMzhqHSHGuJgs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OSIO3OGABy5nshvJSKow+aJJj40eIFDh3RDP6EZP2ZJSnZCxWlHXGs6F399seJ0aR
	 iq2/vKWXbp/8cqqi8izm/YwU5MzBWuHzGKFQNkeFF/vDhGS/PhRqfBuu6ybbGNianW
	 pZBWvo8nioxzkn6BVo6XnMArO8ZpkAE4aRGV6h8TTBxZaAszG79c/hJDUc1EK14AKI
	 2FFkHrq7QYfBcPeaAyvNYCiZcpXDi+jmc3K8HyMqXXk1VwPdZs5cyRfMjK5I9bxXbo
	 8CENaacmFaobPYYHXZHNH/Fr8kE6WXXPn1NMsTmcu7pejdR5jo3FjCjLtMSdPkNxJa
	 S6O4V3ChSZ2fw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3473822D30;
	Wed,  4 Sep 2024 19:16:46 +0000 (UTC)
Subject: Re: [GIT PULL] perf-tools fixes for v6.11-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240904190540.4086525-1-namhyung@kernel.org>
References: <20240904190540.4086525-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240904190540.4086525-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git perf-tools-fixes-for-v6.11-2024-09-04
X-PR-Tracked-Commit-Id: e162cb25c410afc42051a582c46a47dde597f51c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2adad548f74c30739c35994da419eb2318e6fbd1
Message-Id: <172547740521.1139567.12804773063239725703.pr-tracker-bot@kernel.org>
Date: Wed, 04 Sep 2024 19:16:45 +0000
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  4 Sep 2024 12:05:40 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git perf-tools-fixes-for-v6.11-2024-09-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2adad548f74c30739c35994da419eb2318e6fbd1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
