Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D2528A1F4;
	Mon, 14 Apr 2025 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652472; cv=none; b=EBKbMX1cuX1f5svkEyjkEGjRX8OZvKNh9g7hOkQNwP/7FqM0K5wGG4nZQivsRkl5LrQ3iIzkrdiyRCI1tsdJsAPy41AoAepZK3DT9DcXJQi7yol7DRa/oDJpxbESLDDjB0ANmDxhr2/oPvevkLnfZgfbTD5t1ASnF64gvfu/BcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652472; c=relaxed/simple;
	bh=NJghDzVBAeow0Sd/MWaujRt628pUVE0NfgucctssCgQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CQshK+trAyRArk2y9UHi9PaRvlC0sy5uPr7X4UqZXfLq3NqLxiQdD1TSAY3UOKCkkPrDXeO2nQhw9bCfNcYiOLxt9uVW0MZc3Fq9X3ABUJSbF2bfkDnhuKYS+DFRxYuWgAxAwZAnodwS5adhc5okX/8rNBiVFYyT1qxtSwwf7x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vmxvv/nT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vmxvv/nT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79CEC4CEE2;
	Mon, 14 Apr 2025 17:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744652471;
	bh=NJghDzVBAeow0Sd/MWaujRt628pUVE0NfgucctssCgQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Vmxvv/nTPdBaapAHkbYDj3+0m9cw1Wk8B1wSYpTUUD707+YXZkcB7t0YIAjWb/YH1
	 ZXJBVkhFV6kxqxYu+zSgXbGdZg3t7be7zDUiMTPZsJL4NMT80axiPESccPdwkkpZY8
	 WsfhRjiuhQGewrx6UYSmWqPQOLlNLGK+pyFjiTzDjEvBep8d52+eq9NloDKeC2nruD
	 k9j/8MK4GfGA8x7NjccaCUuIn5XDRUCgYbVA2nl5gNha+PEsgAvIKk2BdKk71IkdOq
	 n2HHku1CnxqVMAE3QIy/O39GLFQOiPxi6Hw9uKNfDCvBQew4zDefI4928mVNwSyK76
	 LDtyxJiqXIsvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB05D3822D1A;
	Mon, 14 Apr 2025 17:41:50 +0000 (UTC)
Subject: Re: [GIT PULL] perf-tools fixes for v6.15-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250413232538.4094456-1-namhyung@kernel.org>
References: <20250413232538.4094456-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250413232538.4094456-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.15-2025-04-13
X-PR-Tracked-Commit-Id: 2b70702917337a8d6d07f03eed961e0119091647
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 10e66f29fad2bac7f44e99372398b39358daf6e3
Message-Id: <174465250947.1985657.12810222329470726407.pr-tracker-bot@kernel.org>
Date: Mon, 14 Apr 2025 17:41:49 +0000
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 13 Apr 2025 16:25:38 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.15-2025-04-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/10e66f29fad2bac7f44e99372398b39358daf6e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
