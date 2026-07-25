Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB35C3F39C8;
	Sat, 25 Jul 2026 17:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785000325; cv=none; b=QaTUViQk1UMwMmcUAiSFXmx8EO5bqrkDDoNgY3T5pTUyhMsTbx+Y+3sDl6n/mFIcZ0m7OGGVRZLj45ePU41PZ1r8LxUqbK26aKG6/pUfSpgjuWj5q++mQDDH678EZlvMWOy1rsuT1geDIu+P0rCaEldqoBVktz7bHI4WP7zZ6XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785000325; c=relaxed/simple;
	bh=gYcwyXj0ZgUzA2bbUHNz96p9HgZaswtEQMAxZfFdjyk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Wvxr0pIApAM2DLbgT388D3H7tUVq62EKfrKX4evTxZVKBrouIhLIgR7SOyXMXfRCk/U6fn8sz9Dl/XlQKXhHXjpOlTn5Z7glINHR7evzN5fYbuF4F18l4YDp6U/P46/gcA2KX9oCwWB60YPY0tXtdZhr+d3RY7aGrgJ9Qs1n758=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxdpJa2p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxdpJa2p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3F21F000E9;
	Sat, 25 Jul 2026 17:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785000324;
	bh=4wkDthqGC6oBvhKnux/uMIi7uOwczlbHEemAVsczQLA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=LxdpJa2p6CYzZZ0h9Cr+0L0YhRxQhNfAU4pAtkqrL9fZmL2/RftBQtDCKhWGGYl4h
	 sduMxABCYrxiuA24WUhNLsTUzGMSON4MGr8xyF0KT3FFuOlDavzmh1FW9XzKUXvV3B
	 o7QelIihi9PGfkUA+RESOAsHEcVABZGIID9PlSoO4StI7YZSNHhCOqPM7xlMT/yrhN
	 ininQcGjcIMFmYwMtKlvIUOyMZJiBFaZmqB2mr64psdOa03y0jpaS8la0AcgZOFjdF
	 PhDQf1ikSkB3bDCgyrAP+pvBFP0tXLo96L5FMQCsIaCxfTgqZ3ZgjnEM4gL6725V9x
	 ZnPk/ZDevxKxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AA28038119C5;
	Sat, 25 Jul 2026 17:24:52 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260725123317.29010-1-acme@kernel.org>
References: <20260725123317.29010-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260725123317.29010-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v7.2-1-2026-07-25
X-PR-Tracked-Commit-Id: fac520e43a60230b24026f462a2b63e4d170566e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef9ce800df95726978490534f9e2c14ca71858e8
Message-Id: <178500029151.3569165.17041236429062124471.pr-tracker-bot@kernel.org>
Date: Sat, 25 Jul 2026 17:24:51 +0000
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 25 Jul 2026 09:33:17 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v7.2-1-2026-07-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef9ce800df95726978490534f9e2c14ca71858e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
