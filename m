Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECE143AB9;
	Fri, 31 Jan 2025 01:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738288784; cv=none; b=AcL2or96slX7UuWlFRidUG7rDXjh5KsDQAdZ1E6HKtqrHuCJyEpj5nqlN2FMB2tSuxJixubtInAK1+hMyOfT0Ex3prS+CXK++499FtlXjQmisXMBWXht4sqhj1PB1G7v/X69NjiZk47jaE0mCtCuQmvtVukjggliYxRUvn04NoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738288784; c=relaxed/simple;
	bh=6k6/JvF8SF+TsWqA7pXtmOOza36S9caQtvRAjGohGNk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=M29+admyXTber7HzhnhvYtWNjsAGhL0abzhYdiyPpRXM0U9HW4VeHbKF5o0L7aeZ0zAe4kRXcGzwEWpYwWVAotb4bbEil9eMsAtOj4Z75Gg0XDMHmRdsOYdik1aRy9j9x1+F8NR1wU14HTPObmJOYhysPQmno7zevOFJ5N18xg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1ey/HNW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1ey/HNW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0588C4CED2;
	Fri, 31 Jan 2025 01:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738288783;
	bh=6k6/JvF8SF+TsWqA7pXtmOOza36S9caQtvRAjGohGNk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=k1ey/HNWYH44q4Z/Km13IZmXQq8Tp+qW7ahQv7n6YztGhMYZ27ONof852YK1QlCBM
	 gU6Iva+ofDlwgztzw2uepBLh/yfabJx2dU9vQhUMnHNSIX9m8Lva6pdJmAVFC1OxL4
	 vUYnAZ43PkWqNSZ0I8W5iHAL1LtDbALHxoTDI4A16VX5jvpAjCrpfn7suvu10Y2Q+l
	 TF7+YRnn//4d2B9TFNubVHDHb6v8/7TG2JcRI/CMNGGE3KwIFCtJaYASdoT0QpzlAK
	 rOPrXjhJyJHPELcvql9rMpqLVnYmPoUmWGTxXy5wZ2TRoK/UaWEG1DRpMK8pjy6nKx
	 agPTE45w2qW2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34349380AA66;
	Fri, 31 Jan 2025 02:00:11 +0000 (UTC)
Subject: Re: [GIT PULL] perf-tools fixes for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250130214935.2148549-1-namhyung@kernel.org>
References: <20250130214935.2148549-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250130214935.2148549-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.14-2025-01-30
X-PR-Tracked-Commit-Id: 9fae5884bb0e3480dbb69314b82ed3d8f8482eef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c06310fd6b1c98f27f51a81637311ad560c614e9
Message-Id: <173828880968.1146049.16231176812701576112.pr-tracker-bot@kernel.org>
Date: Fri, 31 Jan 2025 02:00:09 +0000
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 30 Jan 2025 13:49:35 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.14-2025-01-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c06310fd6b1c98f27f51a81637311ad560c614e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
