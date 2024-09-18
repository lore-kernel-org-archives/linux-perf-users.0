Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2231018D623;
	Wed, 18 Sep 2024 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668010; cv=none; b=Q5PHZmhUXfHH67yztOv3liJKwIEyEz0C3b84RUY9wc2OS+w2Ef/9tJd4q5tvyKldX5HJL8grYory9SR9Ipt2PUoskt7fUdUZ5IYbAdHk+gRjisr3nGFWKaVhvqqKBPltK6jyr3o1DYKNzBLwiFHQB27TElHv/hvToSMWLPx7YNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668010; c=relaxed/simple;
	bh=OPAO0rXk5DBxuQbpWBD5xFf3QjTWu7IlCvYs2tVhtkk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SamHa4rlfwV8bMBsT63jDfMrMpGXs3husyhXpLeYfKHGYGHa3mV02SQXrHKmTQQ3q9PGeemrvhzyfaW1uyqrpJcb4+qygZBuh11FMGPPOBYqxW1euqA2gCbpaMPZe0E6Pf3Y4PE2QbMy1kG9Crr5LWY8x5v/ZNlE53VQzAtXgUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABxZmt7N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABxZmt7N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1424C4CEC6;
	Wed, 18 Sep 2024 14:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726668009;
	bh=OPAO0rXk5DBxuQbpWBD5xFf3QjTWu7IlCvYs2tVhtkk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ABxZmt7N4OrtMJQgDaCO8hkeMQMi/CGRjOerNfo3efnopjdYbEL4YY3qqJ82tj4bp
	 UUv4hq4w8ljOKrC8SuZbDj72Y72WYivepQFEQirmM75MLLAVBm0hWI/lIn6C7M5OWR
	 khdC3NjBCShEt6iuFG7wGmrGJcBPafcyV7TBIH5g1+bSDW4SC5KP27KqPripmddTQD
	 lLs8rDrv6DDMXJXy9NdFm+VRSXFZNvPlXZVsf09ikqJMNOpeK6xDKLp9YYjSwc0pto
	 JBdIm8C/OoBxvDm5ThHhZ0dADZb96jql3C2Z80Oebjb7wb0MZao4NEz4dYLlVmtsja
	 y9CBZ+bfppD3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB4C43806655;
	Wed, 18 Sep 2024 14:00:12 +0000 (UTC)
Subject: Re: [GIT PULL] Performance events fixes left over from v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zuq7AXjknK8ooci6@gmail.com>
References: <Zuq7AXjknK8ooci6@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zuq7AXjknK8ooci6@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2024-09-18
X-PR-Tracked-Commit-Id: ef493f4b122d6b14a6de111d1acac1eab1d673b0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 941c122da5c8355335dc16011c1c291a32cd1118
Message-Id: <172666801180.843157.16581232998497997873.pr-tracker-bot@kernel.org>
Date: Wed, 18 Sep 2024 14:00:11 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 18 Sep 2024 13:35:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2024-09-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/941c122da5c8355335dc16011c1c291a32cd1118

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
