Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ED214D283;
	Tue, 30 Sep 2025 21:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759266175; cv=none; b=Q0FSxkRQacyRjVdiACSibMAIQMKcXZfBqLlmiAlQY1/TrnXGJWx3omjU8UNS/jJRi0p9c+cYbTTenjuz0FeEmP3EI18flWv+/FCmJnxlw0mYODixm3nWsLCBNpwKrIdfnq+NYQKBnbYquhGwNZ9fJeil4/Jj//v1HIVGmxE/TUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759266175; c=relaxed/simple;
	bh=1dNBa5iJO9nW02veobgRqyC3UUfsDBibF3RRd+6t9u8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Cn+pmjKenM+Lcbtk8GqWeW6OG45w3vor4w6ve29tQL7dht3Ri/rNgE8f9O+94lwKNGK/TPqAh8K1+4nIqcBqWWb6wgBnj6CHU0eaV68w71QqaMjqRxGc/vR8wL1UlFtDThPaLwqxUv7riS00ig8I5qsb1Z6CgKYlx/zcW+e7eGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxEsgAoe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxEsgAoe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8220BC4CEF0;
	Tue, 30 Sep 2025 21:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759266175;
	bh=1dNBa5iJO9nW02veobgRqyC3UUfsDBibF3RRd+6t9u8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JxEsgAoez8Vj1+br7CpqicCxeymOsEXv9jwQTZazcmuJ8v+PfED5iZkbb7ByC/9Fa
	 vyyGXLMxrch+61Psyj6QbOSuyfrhRoNq8UuTPbTm/lrGeN0A0mi1i6zVHe7ckehH5I
	 OmDmQCqIhNB4HWWY1kBzToWnnafChbghjThcdcf5imuKz6TfGpbinGLWMTtXA/fFti
	 bOuFqDAZdAlgtkvbg0178BePLfWCZEQrxaIXJ572U9VQ/NcF2yaQmTpUztciOHoIpk
	 ANXbphx2/BbscpL9AJH0K+ZsTv/JlDdr2kB2FBwutBEcRqMZXOeIUktJU6fEVI0L/1
	 eY7QXPXY2Dchw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE5A839D0C1A;
	Tue, 30 Sep 2025 21:02:49 +0000 (UTC)
Subject: Re: [GIT PULL] Performance events updates for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <aNak0jUWA0JvVEMX@gmail.com>
References: <aNak0jUWA0JvVEMX@gmail.com>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <aNak0jUWA0JvVEMX@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2025-09-26
X-PR-Tracked-Commit-Id: 6d48436560e91be858158e227f21aab71698814e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4dcbdff114e2c0a8059c396e233aa5d9637afce
Message-Id: <175926616822.2146267.5048110846561675921.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 21:02:48 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 16:36:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2025-09-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4dcbdff114e2c0a8059c396e233aa5d9637afce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
