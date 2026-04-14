Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A0A371D02;
	Tue, 14 Apr 2026 20:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776199552; cv=none; b=dtxxJYUphphpugNVSSPh7fm9mWdPLsrockXdY38U55iO5eGZT73lv2KezQZEaGfMPeSDe8W5D1q9yxGgjECYApRK+DOrUoQiZVCZQxbWQcnzkAic6t34TnYzPxAZHQ5u8rA2u4ihWjVhtBAbbzUkYAmuMMj0JNKwlLNIup3g64A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776199552; c=relaxed/simple;
	bh=JyP2exsGuys7WmjrRNxlbtiiJOwA6rP27kRHtemAbZ0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Nv/QiZl/iZaVnoGo71orCWiyJbgn0Iy/vlhLOxSAL1/ebxBdHPiA7YFsqTz8PDYbuwunOovBJLyzbpx/1OoOU2wnIEkkWRbKC2uIdCC4bpBaRtv//AyyqDlpwq8SUrXfuCw2ra8eRjh2k44D0ZtFQ+4t1emiab6GJhTJqbXOjfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PX6rJ6O7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PX6rJ6O7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEECDC19425;
	Tue, 14 Apr 2026 20:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776199552;
	bh=JyP2exsGuys7WmjrRNxlbtiiJOwA6rP27kRHtemAbZ0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PX6rJ6O7wWT/G2kV0N1mCW921xGdUMPhK9yeYdkvTuQVpLJJgRDsdE9vSH9g+uJl9
	 spd9c/GaCpkiLjOQdkPhNUP4t6EUkxNkvJgtmNVRriMmvQsHQ2DzRPqHweOH9P3Yk5
	 /mtAPJN3ZTMq4eaSRjRWPEdiV95uItOj5jrU+KcjRLj/GPFgZk4uNaqXkU5GdjGi1N
	 /KIPo/fBdpx6jHm2jubXst3naKkU+3DbCiRaPxCQq+6wcsYeMFC+JWXvspIjT1SsQj
	 Jxe6SsP5hPnN2TgYV5Y3U5eMapzi8SUG6IY4V213PmERNTcuvbQTUcI5H/qPXcCnkQ
	 VgHqqSLS1dWLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D08F3809A0C;
	Tue, 14 Apr 2026 20:45:23 +0000 (UTC)
Subject: Re: [GIT PULL] Performance events changes for v7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <adynEfZ0r_GIu06k@gmail.com>
References: <adynEfZ0r_GIu06k@gmail.com>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <adynEfZ0r_GIu06k@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2026-04-13
X-PR-Tracked-Commit-Id: 5a84b600050c5f16b8bba25dd0e7aea845880407
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 33c66eb5e9844429911bf5478c96c60f9f8af9d0
Message-Id: <177619952207.1463863.14030529006553265079.pr-tracker-bot@kernel.org>
Date: Tue, 14 Apr 2026 20:45:22 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 Apr 2026 10:19:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2026-04-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/33c66eb5e9844429911bf5478c96c60f9f8af9d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
