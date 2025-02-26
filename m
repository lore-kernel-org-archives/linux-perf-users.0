Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB7BDDCD;
	Wed, 26 Feb 2025 00:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740529198; cv=none; b=LtCE3IzCxiYo3wtaMvKpuGCUWkch8H4TTtL6DnhBuiSW4UJlxMbBPEFV1j+1PSGfmxO+yyt+4kJnyQ01XqKvkyhf5yK9CAKRV3XC2fPU90V2VF7KqE/50hRosttB1AloBCBUrq4tDPWgP4cdBYaWmqYlsVobyj11eIl6i/91cMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740529198; c=relaxed/simple;
	bh=wyuE+HQdjDPiLBHCXVWwd2bHxF9sJ6kKMUdRklRIjDA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=u/H++DETBqxFru4+9uwgfRps8LaOYwjnaYzIGBlTlUVQMKrLAW+37xBP9DgBq1ScqMz/+MCrpXVJqsHTtVBW/8ysLiF6VhSuAn93pz5b41M5qa0Qs5ofZnUGiqdaxXfg+WilfdlmoT9+BI61qUO51C3BqIHuU22cf68qqNulRBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiRQfezN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiRQfezN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A98C4CEDD;
	Wed, 26 Feb 2025 00:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740529198;
	bh=wyuE+HQdjDPiLBHCXVWwd2bHxF9sJ6kKMUdRklRIjDA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RiRQfezNf9Yj0xruAgmPIPvEW7nftyX4aDT1mPhlZY4TM3ZchvQStG4KEP430H/fN
	 s/6Y+the/TgSD893TOfda58zbo1xwCQ3C3rvHz3Xto8r3paCpt7LyzH88NX2WOm0dN
	 oIlyR0bZVDkBviAJkfppEMwdTVW46+yTjiQx2EDe+/ACnXijUBA5JTcT8PCZZlhUrU
	 fQEFQ9vH4UrH3aN+mu8V4Yr6LIdfcDurYuNvdn3U8wEYoghIux3I6XaaeFfZiKeipg
	 FjXz/CPGuAZcaSAnxicRQArBZOvf9TTxZ8qn335UC3lMsYwVtFNrxQGxTlxkvivxpa
	 SgBRdFEB8Tl/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB37F380CFDC;
	Wed, 26 Feb 2025 00:20:30 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v6.14: 2nd batch
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250225190552.115479-1-acme@kernel.org>
References: <20250225190552.115479-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250225190552.115479-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.14-2-2025-02-25
X-PR-Tracked-Commit-Id: 42367eca7604e16e170bd6bd94ef61ffdd335f4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f5270d758d955506dcb114cb863a86b30a4c783
Message-Id: <174052922944.175592.7729004694751845663.pr-tracker-bot@kernel.org>
Date: Wed, 26 Feb 2025 00:20:29 +0000
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Charlie Jenkins <charlie@rivosinc.com>, Andrii Nakryiko <andrii@kernel.org>, Quentin Monnet <qmo@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 25 Feb 2025 20:05:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.14-2-2025-02-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f5270d758d955506dcb114cb863a86b30a4c783

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
