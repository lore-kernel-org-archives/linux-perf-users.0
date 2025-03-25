Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA366FC5;
	Tue, 25 Mar 2025 05:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742878960; cv=none; b=sbNVXHTQX4WSR8a4abVyOaLSM7I//C5QRfaky17ABwE2BL0xpaf1vR4OmeRSnwFYjrvOiVWL5pbSkZG8FHRGMuA05JQumMLR8sd3kjk35tggoHiC7tjW1E8c3R8CoVWDpQklbl7vmWwtn1lrZwu7sO5S3nQAptRcskV/UajG3DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742878960; c=relaxed/simple;
	bh=gS+BdE9+tAuHELg4mrgG37bdfaAAkqHV8aedkNjAn50=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TX9mrky5f3plBUuPXugX+qjA6TmboSjc3R7c5CMUW3oKb+BLbcrqsXbsWEzc3RrqGGud6VaeOp1o5EbqQ7Ujw6FR5u8Bbbsie/j6ycpUjmHhd3F4lZFntKkNckkeE8EEqLJQ2PNvH9gTvrlCUvruH9gJgC302ydoSEQ/XV01g9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYJJ08Gy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYJJ08Gy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC91C4CEE8;
	Tue, 25 Mar 2025 05:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742878959;
	bh=gS+BdE9+tAuHELg4mrgG37bdfaAAkqHV8aedkNjAn50=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SYJJ08GyncdpY22GJYL85BjO51wVjbfvBvSYJduQsLfBkbLyejwQSAV0nCFC5isyb
	 F9zTo3dkOcQ1R9y+Z+V2ezuucu1UCRNR3VPNP468UzWr0HANkaEYA9mzHi1woA1LKO
	 5tBPXXKrOt4gb2UuiB3mcHJDuWS9gJfS3zF3o9rmg1hwjVbrn4ITxUo/RL9K1k+oDB
	 PVsfa9Dbr/bhNM1I8evyKz+8d/96sRk+RGYxiKaWlaROWdkMmK3l91bMfpMeRyBvSV
	 OBVT+IPjGnC6XAdKPrV97DgKfKJsSlkwQdPNHoVC63X5O5EOP+4T12xV45Phibu1np
	 aeHWpSIxQjOQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DB3380DBCD;
	Tue, 25 Mar 2025 05:03:17 +0000 (UTC)
Subject: Re: [GIT PULL] Performance events updates for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z96FtpuyGXHbvKKS@gmail.com>
References: <Z96FtpuyGXHbvKKS@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z96FtpuyGXHbvKKS@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2025-03-22
X-PR-Tracked-Commit-Id: 12e766d16814808b6a581597cef6ce9fc029e917
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 327ecdbc0fda28da3563a34426f63d80384062be
Message-Id: <174287899572.94045.2125621443245347851.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 05:03:15 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 10:41:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2025-03-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/327ecdbc0fda28da3563a34426f63d80384062be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
