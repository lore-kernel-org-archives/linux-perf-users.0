Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF381DED52;
	Wed, 30 Jul 2025 03:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753846769; cv=none; b=b2FMl+G+5jh/NuSALRLNBJOz8qBFA4bsESYVoB78Ey5jyLlgu8lTgRKkngDfXC7PLXEwCDPxEoRfC0TKZLZ5Flbl8mbt66pgHs65gIOdXIO3/qrCiCxVw6pjs4Wx6Kn2Rc3+imxtcQ4002dp/sMquLhAMrIlfwyni/izraOZ6H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753846769; c=relaxed/simple;
	bh=SK/Xzl5TUFEsr7jdoEl0gaYZu8MHgQsbbvN2hnR5N/w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CyMiQIV8G14iKR5djbEy6IwH8o9+UqdQjzd4XoNo2JrqTMYTF4I7dnS64TiJd0Z16Y/lmgcVUA8OgH4zAoDEEiskYqxguucTB//22mV31yrgw5Tup00CMiePntpnjN8nThP9JJmQWv8NCRLVdz1uhQWAzbKaz29p0Yz8vYwaCWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8RNqu9m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8RNqu9m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8D7C4CEE7;
	Wed, 30 Jul 2025 03:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753846769;
	bh=SK/Xzl5TUFEsr7jdoEl0gaYZu8MHgQsbbvN2hnR5N/w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=X8RNqu9mrBB3ca+DYhExOok3Z2KNszQOUDDnffz5xFPS6WqtJj7Y3zxqqV2jeguXd
	 Pb7cVPekyf0nAy1Sqvbce2gKEFlQSjkJJetjTkMQyKX7FIZhqDMClp9KO68juEN/MD
	 qy92Q7sJwLzMhYQ4iEgPZonxugczsIxMsufki6qUXpEB7fh8pcwbQw8s45dvfWPJxj
	 5/x+EMKn9lAMglh88alXsnKOhQRXO6MlIJjaX2poOlYWtg7yanwYUuRJqGD8UdHiKR
	 w5mEiFOqPAdM2P5Hji/J/JetviuREfJ2UXoeGP3jgdNqAzmvDEPotkviFwHwVKjTBc
	 3+gGtN/5JX4Sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE4A383BF5F;
	Wed, 30 Jul 2025 03:39:46 +0000 (UTC)
Subject: Re: [GIT PULL] Performance events updates for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <aIcNKXiXOFPFhh8B@gmail.com>
References: <aIcNKXiXOFPFhh8B@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aIcNKXiXOFPFhh8B@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2025-07-28
X-PR-Tracked-Commit-Id: 829f5a6308ce11c3edaa31498a825f8c41b9e9aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bcb48dd3b344592cc33732de640b99264c073df1
Message-Id: <175384678547.1749338.12418086907388523005.pr-tracker-bot@kernel.org>
Date: Wed, 30 Jul 2025 03:39:45 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 07:39:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2025-07-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bcb48dd3b344592cc33732de640b99264c073df1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
