Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A651FF606;
	Wed, 30 Oct 2024 22:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730326243; cv=none; b=BCWT60zwuSNH4y3LB7aqfDa6e4JNBJoDfJZMj88g9DQYaK6oAtsXnSEuQpd9DJP9sER2f3WmvfJJP8R1l+WXm2CxGhkyAJiDgkpmVHBfx0mY1Lhp3TgMzWKZkQWPjb6Hm/rm3M5t0aeFJ/ujxN5NTHRzq1v/+2fiKoANIQFiF9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730326243; c=relaxed/simple;
	bh=DwYabsWFpIFS/NYmHbt/4rDnGuBv15CRSV/sHUryTmM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=c4xvcbriSNCSPl0hHJA3m8E68196rXZtx6NjDhm7KBEIh6fvKr1a+NM2C0MiG9PrZAMB/CcpXKgNGB177lKif518SAW0X94dxLcgg7w51e6GL7GK8lsIosKLw9sMNXMZ4zyidOywX+HCCSP+qt/CjgDvZlcokyUx6d/9TEEOcfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZnn/VLE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZnn/VLE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FE6C4CECE;
	Wed, 30 Oct 2024 22:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730326243;
	bh=DwYabsWFpIFS/NYmHbt/4rDnGuBv15CRSV/sHUryTmM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qZnn/VLEJDn8TGj36aTR6A1aI9bYmJEgwqCfg6FVaE/qDnNA+vN17EcAHnxkmR5Qj
	 cPdfDUXj4pS+LyLqcxUubz5Lu0+SOzAn+4jzk1aOWQJQUdi9yIx+BFyJ98I0f7phRc
	 ue2mby+XEoZmX8gKS3Qh9Oz5d7TkznP0O4PqHdEY7X1pfBMwkDzURtKey/ODoQLicZ
	 3rHx1RcOzcvs354OBVudmVo2lKP2wFRqu9nwMw4vhy4rSolNyGhcPiqezdkLEsKe6H
	 k8am0FI4ifInYjbMm9gesf+4vYI5ZR7OBnb6DRL38XozJXlKfYHnhSVM5kEWLPcUdd
	 lqV9klJZ1eQrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71054380AC22;
	Wed, 30 Oct 2024 22:10:52 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v6.12: 2nd batch
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241030204752.316247-1-acme@kernel.org>
References: <20241030204752.316247-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241030204752.316247-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.12-2-2024-10-30
X-PR-Tracked-Commit-Id: a5384c426744ebe41dafc6e5fa3acecc05e43462
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 14b7d43c5c068cb9688a9fe68883f4340effb053
Message-Id: <173032625106.1478573.11230261586948996928.pr-tracker-bot@kernel.org>
Date: Wed, 30 Oct 2024 22:10:51 +0000
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Howard Chu <howardchu95@gmail.com>, James Clark <james.clark@linaro.org>, Jiri Slaby <jslaby@suse.cz>, Veronika Molnarova <vmolnaro@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 30 Oct 2024 17:47:52 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.12-2-2024-10-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/14b7d43c5c068cb9688a9fe68883f4340effb053

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
