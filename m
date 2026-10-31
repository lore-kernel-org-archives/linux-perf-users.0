Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793424129;
	b=HMCZ/BHNW1cu3kz/PsXevjmLQXHMNXYh/c+kjfXCV0IeD08mrdB+flrPS7vWgDXvwIFC
	 lrMtoVJzK1aLoHSAwBLkltK2M0akva2cGywaCiph6McAj+LFMPQI/MWiu5SAomNcPuNTs
	 0Rp0kW5NUlpeW5EhTBJJSfYiZWNrc3H5dsfA4Qf18oW7qoq5QMrbpv/4zG4H4h8vGW3gC
	 qiXjNgtnahJA+Zny2VZVVCFVww41AcsqdT4yWyTZdy0d5N6WzktGH+8zpAPBd2JiStvbT
	 SUoSrrwrtbkaLzblxsUla14WYPyfPcoISMkV9CvdiuGdtjAgqO9UnO9aHSSBWIzFbRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793424129;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=89hniTA14+zLFpbds6fJzzb1670tsFDUAgg7XEIrMEY=;
	b=pLfPBfzr64cKbKHhXvQL1vtW4EWPHRZQePUe76Ux9uWNfCPDz2ffRVDASRDEEUm9wpzJ
	 0Dw3PvUhslAqqdD8iBUX3jzY67S83G04Ybrl2f2W3YhHVQItL+XT43gDUXSohhEFrcwzt
	 FyqYDM5ZSUhGHEami2DbxPwFzdJuNCJP6zm/7Vfxm+VIQejl5eyTxkPoZiyYx33CW1m0c
	 XGxgFx9zWEf5//S9eaNZ3Eo/2HMroBNYgy7kaR/MsoKcZw0VlTobFejkKFkrhAmskKSdD
	 ioYPdxVBAo/TU2PQL83tQhzdljpjhMjtSBWM8WSneKQHI14TEyQvXE+7BTkkWSyLNTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mcn8H/Q+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD00606A31C;
	Sat, 31 Oct 2026 05:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mcn8H/Q+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDD21F000C1;
	Sat, 31 Oct 2026 05:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793424129;
	bh=89hniTA14+zLFpbds6fJzzb1670tsFDUAgg7XEIrMEY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=mcn8H/Q+e/i7xwUyeguAhkwBgxbYLtOEbiK/FNV3T86pMDPOIQtja6oeO4cCEQzeq
	 S/1XK4HIq8oYrPzdGgSNl03eIuJer5kqHkO/a8asSOiFpTplDR2RfCsuSu4g6U9UEf
	 v3avy/r9xDWLT/yJ1WZhIKTLqu2vgXB5JAClOuJAEGjUHsXQ7Ng9+Mia7cSeVdw9y8
	 AE8/8cHYfHQoSOkETBP+OK1jWuqcZM50yzo2gk2rpl7KsUHjiXFbGHZe0RYJ1A5dVo
	 8Qggt76MnrtYvCW5JW27ehXvJg2FeKWKX/Bic/5NfnaMb8k3V+baI3lLYtR1RbCPtp
	 aCrvUIIUh4q7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0334C380047C;
	Sat, 31 Oct 2026 05:22:09 +0000 (UTC)
Subject: Re: [GIT PULL update] perf tools changes for v7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261030220603.27617-1-acme@kernel.org>
References: <20261030220603.27617-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261030220603.27617-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git tags/perf-tools-for-v7.4-1-2026-10-30
X-PR-Tracked-Commit-Id: 4626d370ae89b8af4d46a45372b269f926ec662d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd384658c738d15783a786d3af2851e02490f171
Message-Id: <179342412770.1961943.10787848066034752638.pr-tracker-bot@kernel.org>
Date: Sat, 31 Oct 2026 05:22:07 +0000
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, Alice Rogers <alice.mei.rogers@gmail.com>, Andi Kleen <ak@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, liujing <liujing@cmss.chinamobile.com>, Mark Amirkan <markdamirkan@gmail.com>, Matt Turner <mattst88@gmail.com>, Nylon Chen <nylon.chen@sifive.com>, Qerogram <qerogram@naver.com>, sashiko-bot <sashiko-bot@kernel.org>, Tengda Wu <wutengda@huaweicloud.com>, Thomas Richter <tmricht@linux.ibm.com>, Triet Hoang <triet.hoang.dev@g
 mail.com>, Wang Yan <wangyan01@kylinos.cn>, Zide Chen <zide.chen@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Fri, 30 Oct 2026 19:06:03 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git tags/perf-tools-for-v7.4-1-2026-10-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd384658c738d15783a786d3af2851e02490f171

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
