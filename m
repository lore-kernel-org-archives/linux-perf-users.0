Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C9D165F16;
	Tue, 10 Feb 2026 22:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770761086; cv=none; b=KXROZBEWPhkFy7KAQHqTU8NQgfGeUnrRElYNEgiv7wPc3UoohPgD00oKN2UUqPCll+wHafdrMu2to74ppljiQvJKicDEAXE3zpkG32njrnBUPVhtc8UKNQ5t5EL+dDz0RT+07ewBf3EjuLggI+cgGFKQPtnXJBEnebpweag4p6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770761086; c=relaxed/simple;
	bh=egOx0qWPEhOKt2E6KwtBEkU0vo1lfyKcwcJ7B1WW5uY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=r2fLSuNblKlNOsAZkfJ5YHPRyIIZ9h+nVHet3SRWKadt0cBu3ZqxoxmcxZfKnRhF4Nzm7J2TlFiK6B34nThnuKadlXM2xZFkOL2EO7eC9oDQuCMxwsDXp6Hu+r7N9/QpmvWy0fHxY12JCmK/5WoA/d6deATGXgOFH/7rSPqxx6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKS5oQrT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKS5oQrT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B4DC116C6;
	Tue, 10 Feb 2026 22:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770761086;
	bh=egOx0qWPEhOKt2E6KwtBEkU0vo1lfyKcwcJ7B1WW5uY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oKS5oQrTSXpJpEAu23o2pwSbOh2WtMf2QrG+rGy+adJu5z4d0wI6YsPL9nuXRvlwY
	 oDO5KbEPP/9PgCFvglRu0+CHq3Wt+LwrTMpMrhLJ8cA9kO7TtRkz+0Qjt/hrbCF20C
	 m4rkstV97FVww+0xR3x8PqDhwQX7ikCKwowWsVdzlq5iLXmdaYAhjxj0KZL/UXFIGB
	 0/tu5Y4vkenRimzxEGtMPciFNpSIfC/cQ73JnT7XwjUUwNPIM3J2oXTSZTdMDei9lX
	 bzxWh6rtH3/60N6ODc1USbYiB3LABX8GwrYgbbH0OjWjL7PMkkoc627a8CjGcw6MVs
	 XzzMnBObb5jTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8545539E3B79;
	Tue, 10 Feb 2026 22:04:42 +0000 (UTC)
Subject: Re: [GIT PULL] Performance events changes for v7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <aYmF-cST9h4MhX3I@gmail.com>
References: <aYmF-cST9h4MhX3I@gmail.com>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <aYmF-cST9h4MhX3I@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2026-02-09
X-PR-Tracked-Commit-Id: 7db06e329af30dcb170a6782c1714217ad65033d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d84667627c4ff70826b349c449bbaf63b9af4e5
Message-Id: <177076108123.3702729.5750450426278896315.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 22:04:41 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 9 Feb 2026 08:00:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2026-02-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d84667627c4ff70826b349c449bbaf63b9af4e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
