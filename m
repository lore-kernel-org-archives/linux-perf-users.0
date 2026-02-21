Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8140233F8A7;
	Sat, 21 Feb 2026 19:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771703732; cv=none; b=J9OvaUzJhDWsjOGfMGom1DxqnU/TUWYSJMGDSDbCJMZj+96E2d71J+ldunU5k9x+HLnntSDecBidwVGpNBUrzRbJlcmtXUzbTWpd5pa0BJFd6lAwB1tRGOxYL1c0AaNHcd43RSwEsvR9JVEZim7ZFebRwodvjp22qE5jGme4rsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771703732; c=relaxed/simple;
	bh=6bbVZLOU83FNXRvBOuavzXH6crGVFDAQsI74AkfdLfM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=L7CH8jtunXdag4vtOSYhtgvMm7o0oc2LYVEhRWhxWRDnOtJ/4eSParPwx2kOQxxmi4bkCuUpTXwsJ99CGW/wjhnHUWryINU3F6yy85UrvOdit2VRdTmBDjMxpF4HFQ+S3zOQja1zr7XCfKQIoevx2us7EEMk5/H8vvdKX9jqp4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGHkTg3D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGHkTg3D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAAEC4CEF7;
	Sat, 21 Feb 2026 19:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771703732;
	bh=6bbVZLOU83FNXRvBOuavzXH6crGVFDAQsI74AkfdLfM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jGHkTg3Df4qvccZn9P5y0mlEMntyOBgKky+84mV0IJfcflKDJ9L8f4pk4bkVEO8L2
	 AHaKXQSbUQyqEPmKHq6/qB61M1WYbe70T+aD1nI9qpvDFLiTix7Vvxu9HegDsAzstk
	 yOdxeNJNRvtiOVH4cHW0YitQHhweE7HekwCZaWZyc6j7aPoahJcbSvPd85g3HNO59f
	 1OvXL5S+ntsAc/m+/8+54siq/r6KXrXw++rxkD8EKHiwLWZ75H2tzQQdbn0oS8+R0x
	 kSjs5n+ABk+n/Yg09PmDUmgwMddBaeZVpRp8iW1eDkMYjH8uFjo+z3Z417okGqOroP
	 1wEwLyhDTTuEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02ECE3808200;
	Sat, 21 Feb 2026 19:55:41 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260221182435.1221570-1-acme@kernel.org>
References: <20260221182435.1221570-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260221182435.1221570-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v7.0-1-2026-02-21
X-PR-Tracked-Commit-Id: dbf0108347bdb5d4ccef8910555b16c1f1a505f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c7decec2f2d2ab0366567f9e30c0e1418cece43f
Message-Id: <177170373970.1218354.13749211484890543250.pr-tracker-bot@kernel.org>
Date: Sat, 21 Feb 2026 19:55:39 +0000
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Al Grant <al.grant@arm.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, Derek Foreman <derek.foreman@collabora.com>, Eric Biggers <ebiggers@kernel.org>, Gabriel Marin <gmx@google.com>, Gary Guo <gary@garyguo.net>, Guilherme Amadio <amadio@gentoo.org>, Haiyue Wang <haiyuewa@163.com>, Julia Lawall <Julia.Lawall@inria.fr>, kernel test robot <oliver.sang@intel.com>, Leo Yan <leo.yan@arm.com>, =?UTF-8?q?Manuel=20Hern=C3=A1ndez=20M=C3=A9ndez?= <manuel.hernandez@openchip.com>, Nicolas Schier <n.schier@avm.de>, Roberto Sassu <roberto.sassu@huawei.com>, Sand
 ipan Das <sandipan.das@amd.com>, Shimin Guo <shimin.guo@skydio.com>, Sri Jayaramappa <sjayaram@akamai.com>, Thomas Richter <tmricht@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 21 Feb 2026 15:24:35 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v7.0-1-2026-02-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c7decec2f2d2ab0366567f9e30c0e1418cece43f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
