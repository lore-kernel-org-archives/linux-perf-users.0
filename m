Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E26C3DD51F;
	Mon, 15 Jun 2026 10:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781518316; cv=none; b=XX8TRnVf+KZQYf3DW9ENEuPFH+7UWS8cN+RdvHkUk0Qjxaa7pB5uMP33zBHSt0Euy+ZeCCj2bRwnVedZwI3r1l+uaSxga0TpM2kJlE1tvyx/fF7TF7kOsm7aTnCCgETKz745PeSapYoC0gkNInGznl4c9e+xG5fV330/DXh1Ja4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781518316; c=relaxed/simple;
	bh=T68ZNqL+nQ5lprOKXlt29aVaIpKyBAjhdz/nLkLjy9c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WgBxOdfuR78ZcuJshieGL+k7JXUD02TsYnAsQF+XbXRkVkb0RS/wDh5A4xpUm4fHcGWRnnQL2pS2+EKS8w0alhRhBEPN+ML8J4aTT3nijOCs9KmXF5E88bdCKD9WmuJqnEoMjubHC1/CDuFuVq5yi5vMSrL5ffqP27jCkJ7aL0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDFH5nVo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDFH5nVo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5169B1F000E9;
	Mon, 15 Jun 2026 10:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781518315;
	bh=/g+wjX3SAwFutTyE4qvD6SVYkg1mXoU1M9JhD4hp2NA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=VDFH5nVotZBAVKYJ9lm2yYFilc2f0Kr99/CfX8fMgB6hN4U05AY1bpxKXgVPKxjKF
	 303Mldawa3kyKCprc7F00pW5FwdkBP3sOSXAb/o/4jUj49k+ULFgaVdBhP6djDyaTV
	 21cafhDnNna0lZNzSjeuuJVk7/+zDAn4FUTY6CDJd93aVZ0gXR09PTqw9VC6vbbDUq
	 DrluUaGS5K6zWI7Yuv84sF0Lmlh1vsq96tqQd+pZ9SHzM1GgvUSPBGIZYzbCTtgTU+
	 rnBVdEaGoP+IfhWrnjF1cv+Lk9fhp6BasMtNM3Qh+Lz0uy4TPM8evzCxav7xWN4sEt
	 E1FU7Sz3GcK5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A633A5676B;
	Mon, 15 Jun 2026 10:11:51 +0000 (UTC)
Subject: Re: [GIT PULL] Performance events updates for v7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <ai6_xmvbz9ISX-Dm@gmail.com>
References: <ai6_xmvbz9ISX-Dm@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ai6_xmvbz9ISX-Dm@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2026-06-14
X-PR-Tracked-Commit-Id: 67d27727854def4a7e2b386429941f5c4741ccc4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0bcc2dc22f38e57fa97d8238b2e0bcdde5376f33
Message-Id: <178151831054.2987508.14495051711979091722.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jun 2026 10:11:50 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Jun 2026 16:50:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2026-06-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0bcc2dc22f38e57fa97d8238b2e0bcdde5376f33

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
