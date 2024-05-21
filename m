Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B6AA2D;
	Tue, 21 May 2024 23:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716332557; cv=none; b=QbxyFq+ecgB5IUnDhKx/H+3YLRSJkinpZ6HTQ5f74LzQ+39Z2bDddtsPb2hu5Y5mXJor9+QZ5AklXFIXhPNydJpl0JPJjtFHzrBNRGTy6EbCRCFIUtyblMXpcUl9E/YTuvdcDSad0U4Kgndk9QTy0N0UHEOW96NuSX3HFzpYMT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716332557; c=relaxed/simple;
	bh=ifQyzic2NNtFqbnYPsEyP/mg7BBSJGDsjj6YuGS4WH0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aMZ6lw3S+gGwLtXHZpNk52876lIgW+y2o2/nXN8K18hbM1JW6zqbxen/GfEeozriGrdSZf4xevsEAN2Cm80ZO7ZD9y6WjXneIo7/POIzX0CN2kPkTUwYtqyLRX/CJesndGdN2ELfdplIWGaPULn2OE52vvj7j76LeN+iIR1AGGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LW1usw0D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LW1usw0D"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF291C2BD11;
	Tue, 21 May 2024 23:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716332557;
	bh=ifQyzic2NNtFqbnYPsEyP/mg7BBSJGDsjj6YuGS4WH0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LW1usw0DahmmzJz2mWNJ1ntF65/ebxnhz2MiYljevD5ccL/eGaVPic1YgCM3dYKSV
	 asRLfvOp7jCeU9qB9jZyX73LqCpPWlP7uYYWksxUvXf/vgwMiEzMB0Nmv4R2mf9MwL
	 93O4eoWJLshwGNGijuBx1nnxDiVoVKOd46nV/cPpl1NjBn2179f2BGPbhtkGy+uVLU
	 lZrj1tK2xoeY2XDqq1JWEwAOm9hUR4S4MMwFG3PPqK8OmY9oTVLqCLlliUR5NYMa3Z
	 F6YL9CERUbD8+FDEWYqZqHc5GhW1JPrn9HW6hQWS50hC/CIwgoZP0ONIOYcClibuZA
	 3J2IMqm+JFsGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE5BDC4936D;
	Tue, 21 May 2024 23:02:36 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240521192614.3937942-1-acme@kernel.org>
References: <20240521192614.3937942-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240521192614.3937942-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.10-1-2024-05-21
X-PR-Tracked-Commit-Id: ea558c86248b4955e5c5f3c0c921df450880605e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 29c73fc794c83505066ee6db893b2a83ac5fac63
Message-Id: <171633255683.31098.16627302013499975744.pr-tracker-bot@kernel.org>
Date: Tue, 21 May 2024 23:02:36 +0000
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Clark Williams <williams@redhat.com>, Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Anne Macedo <retpolanne@posteo.net>, Bhaskar Chowdhury <unixbhaskar@gmail.com>, Ethan Adams <j.ethan.adams@gmail.com>, James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, Tycho Andersen <tycho@tycho.pizza>, Yang Jihong <yangjihong@bytedance.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 May 2024 16:26:14 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.10-1-2024-05-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/29c73fc794c83505066ee6db893b2a83ac5fac63

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
