Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8BD14265;
	Sun,  9 Jun 2024 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717949520; cv=none; b=NW+1gWTL7l9ebxyOgSGRZ+fml1st6919ZOTvAN7bFuNG6QnRZngU6f0hxTEmMrXoTFyk3lH6aO2eB/u9ePLIsp6c9Yo0YOkDkX3310WKyiikTflPHn3l1F7bVUqdgBTPw0w4CVqasvuVBFYGzpkXAAG+ZQLgnXfkMdMQGzL64so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717949520; c=relaxed/simple;
	bh=+BFK1gjPAhIhXwtNYYf7X03MYKy79RgjpwYWJ5T6lic=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dCfPkUeAJIZ5eh9fS99n2BCa8YkWmhTMS3uyVtPLaG+UwEN66qfti0JvDmg+sOpsbfcy/xrSpbBoXcNuOcVfHCpOQkk1VIFBHt3Z6XxU308h1vkdvPnZbkdmhlUUc8cmmRobx/pVVBuKWtg7gNkkHxbk8JzxLemER10GCCQRL4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m204KGdb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m204KGdb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3703DC3277B;
	Sun,  9 Jun 2024 16:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717949520;
	bh=+BFK1gjPAhIhXwtNYYf7X03MYKy79RgjpwYWJ5T6lic=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=m204KGdb5p9jcYqMuOdUZtoxsz0JhCuwkWav6fFs/zJSJ5PPPlNnBUsb6XhylM++p
	 7YS/Bgisjfr+N5LcCyHbMUpiOv7O103pXsq3Dn3kehXtGoKNVi9zvZgR6HzEpx37eB
	 Xo2k3KmmiafPdPPOPW5ukcQu3RkGE2t8aK7aFqr2npZZADULi2ebO9B7zrG08HoLAh
	 o4hSlMlUhSwD4NLt1Zp8M/d+FlLzeDPkwxTWVh+e+2NT5h/SeBxlwx6kY6I+X8K4K5
	 5xwmpowti1JUYPWC5rckuv0pmmuxYi0bS8mtmRo9KNWcqgDaO7xTMWKBUWLrhKj07E
	 C1jc9d8IJsJjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A734CF3BA4;
	Sun,  9 Jun 2024 16:12:00 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v6.10: 2nd batch
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240609134732.172580-1-acme@kernel.org>
References: <20240609134732.172580-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240609134732.172580-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.10-2-2024-06-09
X-PR-Tracked-Commit-Id: ca9680821dfec73c9100860bda4fab1f1309722e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8481381d4e2549f06812eb6069198144696340c
Message-Id: <171794952016.28618.6402777334904014785.pr-tracker-bot@kernel.org>
Date: Sun, 09 Jun 2024 16:12:00 +0000
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Sun,  9 Jun 2024 10:47:32 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.10-2-2024-06-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8481381d4e2549f06812eb6069198144696340c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
