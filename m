Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DEFBA33;
	Mon, 26 May 2025 22:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748300275; cv=none; b=QXEXhn/sG3A7BPgiHIqsI+ZQjKGRI/7Mgg5wiB/VAyYmidijFAa4U9qL+PRLl1iRXMy00T+ddRs9bcWVLRUOtJtDWUcLF5ZEuW2ImpaAcjYsuLRHYYhiirAgMSnxJYKsGSobxBstIyOAsjcYxhEDbV9omcUPmMctYW1h/mkjwvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748300275; c=relaxed/simple;
	bh=sErhwWXDVEF34Nn3shJX57YOXN6QEVKwSMv6f86mXCQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ct4Pi4X3b4Ot4TTd7stE23I+L8EmCKTUKySTPoMl2+LSKv+V1GO8Yu8WO0+794Qy1g8qqzpove9uQCcbZrFU9xDKqFYuORdMjYpne2AvUFD5y2R+vl9NIxoPFCExFD96oZi2Dkc9DAvcJ4XnKdSgKBs38Dc5t8QCsLgt/aoGQRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQtHpEKa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQtHpEKa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E061C4CEE7;
	Mon, 26 May 2025 22:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748300275;
	bh=sErhwWXDVEF34Nn3shJX57YOXN6QEVKwSMv6f86mXCQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CQtHpEKabkQ+a4oMzYYU2dciEnG9iYPMB+91HV+ZmEWufkxpIhZ44wvfUO+NYY7ZG
	 D/Oo1MY03zAo+ienP6dbXgNBfjja/0mVfCvI+9NAGx1X3ifQhbJLNi13IyS43aCUGy
	 wwVQCbhJp5Dd8ph9xHgVxNQmCFUn78r6Nk6B7z2JsIovY+HDaZlWGHpFLeOGbgMtYj
	 vCkZb1GUyotJOd57ivSg6dqcABXdyJyr24opzEejw1/FUj2hfzgYemMJ86KAmCmbYN
	 eQr733wFabV/CqG9RWBkl5eWVo9pwHGUXxNViAF3oU5ftrCsPzPzJej7Orn321HB3h
	 bb0hTXrPgL+fw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE39E3805D8E;
	Mon, 26 May 2025 22:58:30 +0000 (UTC)
Subject: Re: [GIT PULL] Performance events updates for v6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <aDLjswBHxzKz1gx2@gmail.com>
References: <aDLjswBHxzKz1gx2@gmail.com>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <aDLjswBHxzKz1gx2@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2025-05-25
X-PR-Tracked-Commit-Id: e7d952cc39fca34386ec9f15f68cb2eaac01b5ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ddddf9d64f7361323da663637adb4a02466bfc99
Message-Id: <174830030936.1082063.15501785939071012930.pr-tracker-bot@kernel.org>
Date: Mon, 26 May 2025 22:58:29 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 25 May 2025 11:32:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2025-05-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ddddf9d64f7361323da663637adb4a02466bfc99

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
