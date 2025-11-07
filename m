Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85442EBB90;
	Fri,  7 Nov 2025 00:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476611; cv=none; b=LC5ut5NBuEGO73P5jXVEPWtP2bIIazWWWUK3I/XQIFO1+dtkmM06b2dD+SU7HZM37pxAVc8KXUm4VYnqw/nKp0JirVPOPLdQyW504YXdAs0wtQUgUVcTtsRHXEYFNMc+aRcKCT4h0M4hyzQP/wfZhVtO0kSi8rbV8cR0ptgXf6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476611; c=relaxed/simple;
	bh=HX9d0ERERexfsjVqhZv+ZWmaD305vYEpved8Y6u6NTM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IYsdRApJP9LHtf4zb2n3f2CQWM4S6/vhERrPby6jjjI+wGWiASzIdTNTfmj16RnpuL6VLxXGDM/mKK0DfjcKN+qobGxS4yjTW8ohOrJaB0TzIhwqd59euBtJyxaLYBUscff3O/Jjc/uAk/+8ZMjKWOfmgroeTMHNKkWMh8LQ1Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiPzTCHh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiPzTCHh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9D4C4CEFB;
	Fri,  7 Nov 2025 00:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762476611;
	bh=HX9d0ERERexfsjVqhZv+ZWmaD305vYEpved8Y6u6NTM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IiPzTCHhT1+sOYN2XtUCW+kRXwRcXzH0pzZIgtWq3eu/MLxd/qQE/645Mc1Jwz/Lb
	 BbHPJA/JnT2sQ7KiZtYoGPSr9vckQSys23hMIc8o6F4skQy5OhQFzRWPVd25bIsYiH
	 0j3WuakeBM40JcNh1sj/0suPIzOM9TI46Iat6KbqLXpMVDbnDHNQnDJ2JCUViXfNex
	 BTISBX1k+PiYb5xCLozO3qi8XZfD3oO+0Ez7cJnVFkPflDG+tBcdhN1V1BivuSthmn
	 rpD2qja3bJ4zqJAD17f6m0pZmkyfVI8Rp/D5r5W4Ir4Vp4KjJmoAlkEYRjRIaXoIhg
	 TrkOs7xtJsbKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E6F39EF974;
	Fri,  7 Nov 2025 00:49:45 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251106203353.919035-1-acme@kernel.org>
References: <20251106203353.919035-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251106203353.919035-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.18-1-2025-11-06
X-PR-Tracked-Commit-Id: 7f17ef0d47b9aa01b89a92b2514fbfe800d8aeca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f5f2e20b1cbc5f9ea20b372d15967b24921ede19
Message-Id: <176247658379.436188.12222833564317318670.pr-tracker-bot@kernel.org>
Date: Fri, 07 Nov 2025 00:49:43 +0000
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  6 Nov 2025 17:33:53 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.18-1-2025-11-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f5f2e20b1cbc5f9ea20b372d15967b24921ede19

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
