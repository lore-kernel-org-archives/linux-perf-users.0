Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1227CBA45;
	Tue, 14 May 2024 02:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715655089; cv=none; b=fdgQdsjI6w1TCnC0Zp5qF6FRYHZM4X0NlouNTIjrSf7n59OJy5an3CR2t2HHxFCYains+7u76XvMSBSZKYERl+I6pHfK8JKKXvf9Mg+Evrp0Rkjm5H9+zrZUF7w0Um7j1UzvwcJ/3m79ucNflTQgtzqDRq70b7uIjwf4bcy+ckM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715655089; c=relaxed/simple;
	bh=WPbFjtwo3REYqM/gsVuLxAMqb7P/vH8MfuvB8XSJKqk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FWP8TpXH4HtwnUjeQ6k7gFlyDwJozYGE2D9ThR2Pf6hO2xueiTr2PQmOXi/PWtVrGlKgfS4El3b6BBJh0erZyww6US4gYHFkpqKVAgZPlGtDq2JfsqPbgXE5uKaCWaZEFAC/pyBzhOAG74xhN3lxqlATzFSnZU3CBng4UqDHQMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bh3fv/FO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bh3fv/FO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEA2FC32782;
	Tue, 14 May 2024 02:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715655088;
	bh=WPbFjtwo3REYqM/gsVuLxAMqb7P/vH8MfuvB8XSJKqk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Bh3fv/FOpOMbN0Avfu73o2vPoOkvGLzJLoIhjgJZLg4BetCDazHV3zudX6MSbaloD
	 Ok3tL3dWccHSk1Tn9mbrvhdWpU81KYJCUTwkqWpjHZbLh6Uy9BTusswABtAyMp5/Zz
	 OnhptC6tqtfnsqu05VSL9w7pWELg5e9ch0MHA/Egd43Wvf9aC6B7LdFbSNAq85mr0b
	 03Donj2+sWqcE3yFRL3uEl35J+V2JEOvUWaJ7fBWruFk5K3Ol0v2YGBWjFOc57z4yd
	 ml1uSMj3sfFjEJEeBihoFdJ9ngYyOuxO5CN9KDJMlFhikm2N9NCJ1aG7mak15DF1k2
	 cw8gP6akvIm8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5069C433E9;
	Tue, 14 May 2024 02:51:28 +0000 (UTC)
Subject: Re: [GIT PULL] Performance events changes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkGwxW0JArbudf/+@gmail.com>
References: <ZkGwxW0JArbudf/+@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkGwxW0JArbudf/+@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2024-05-13
X-PR-Tracked-Commit-Id: 854dd99b5ddc9d90e31e5f112462a5994dd31810
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17ca7fc22f4bbc795e4d136449521b2fecb88e06
Message-Id: <171565508886.649.10559957865894799347.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 02:51:28 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 08:18:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2024-05-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17ca7fc22f4bbc795e4d136449521b2fecb88e06

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
