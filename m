Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBE518A6A8;
	Fri,  2 Jan 2026 22:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767394734; cv=none; b=dgURDZmAJgGCgG5n44IisZPsaKlJs+qe7e5VCc0s1w4pEKQ4peN7n8VXPGulTHWGMJQjVBi37+7bi6Moljacn4c7yp7FA1TlTfmTOlZjm2706CoR6GxOtFc4INaSMGv4kTncnSQTqA1ju/kfv9M8jAUccSggrfIgeqjrrXa5pvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767394734; c=relaxed/simple;
	bh=Id1MTZeaJZPV2RSNGKakAuRO4xTgmnhExrwxqMzAu1o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aziUL0lS+ac7NQpOcgZT0vBE6/ch9fbHIG4ZMLhzSLzuZnUGYtoa6GnA1vKeOEoK2wW+ZWI39uWujMR2e3BIuP4HSCAb8UbVpap83Xd8sSJ66QhSTQBEGz2nkYbvHk8kIrmfB/GduBZ8EhP+j3mX7HPUn4Q9gEYH6rfvCI7F5qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TERow7ZN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TERow7ZN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82567C116B1;
	Fri,  2 Jan 2026 22:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767394734;
	bh=Id1MTZeaJZPV2RSNGKakAuRO4xTgmnhExrwxqMzAu1o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TERow7ZNZyPhZaj+NJEbp3mGKRUDQGIzto+M6i4YCXqgvbelX/xabCmRxGgUPzVmO
	 /GGGr9S4r6F7gmvsvhwuu2aBX/8HacVE6E4zrix4LTRZoNUs8bqe/EPXkbNZqJRD3x
	 U5elijY8PiN/sZxPxOMxuT7j/B4KX79A6IRinxZgkPxvZ71uUlsJffUi5sM9V764Aa
	 TxNJcEVaLJan+thFe8gubqR0b42487kRnkRFqSVJ0onyWZcneu1kbZRA2G8KNU+H9l
	 3piL3OvGq5Xs9amsA75eQUseEA+NfIHUER1ychcSBGdNux7UoaNyvbuyyot+ZL7kJq
	 aNbmsmGPOEuDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5D11380A962;
	Fri,  2 Jan 2026 22:55:35 +0000 (UTC)
Subject: Re: [GIT PULL] perf-tools fixes for v6.19-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260102220113.3067493-1-namhyung@kernel.org>
References: <20260102220113.3067493-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260102220113.3067493-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.19-2026-01-02
X-PR-Tracked-Commit-Id: fe072f651083c612278de82ce08bccdfecf574b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 805f9a061372164d43ddef771d7cd63e3ba6d845
Message-Id: <176739453435.4025290.15134203122497283310.pr-tracker-bot@kernel.org>
Date: Fri, 02 Jan 2026 22:55:34 +0000
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  2 Jan 2026 14:01:13 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.19-2026-01-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/805f9a061372164d43ddef771d7cd63e3ba6d845

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
