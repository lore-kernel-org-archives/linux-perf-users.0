Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2935A145B1F;
	Thu, 18 Jul 2024 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721337986; cv=none; b=eZ2cjfI6DMECAKFAqy6S5LIsuplpTLEXQ4QnflUz12uddyxkA4oV+TIYu7hDO6702qowFvQ2lrxqD1hWqU48mpGKnqWeogmIAPcjX9KDgfp2lSyKFqJuM68+A4M5b40/h3bOEkPV0muV/msrveSPieksNVm8K4f4NN+WhiTTQK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721337986; c=relaxed/simple;
	bh=rmYJ4+hOXaskhOHAWSiUapA+t5tgnuWODjQDUs7CHwk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tg5svfv9ly1JoZ3lsKOZN78MSNtanY+Zt/zZm0jX7pNvsMnt2bBR6crslxYS8Bm71kYfNGos1MwYFDHOT/lShb+gfG4dL79JKztiFsA5ItJigJCFRISj67FeYiR1swa3w+rRxKsDucvbJArKs3mE8LgaFa44PuQaPbhht1J8+mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mwq/kATW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mwq/kATW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7FE6C4AF10;
	Thu, 18 Jul 2024 21:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721337985;
	bh=rmYJ4+hOXaskhOHAWSiUapA+t5tgnuWODjQDUs7CHwk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Mwq/kATWPgPjhecZpvkK2WNFrm48+bRijNWJm9z9Pb7fgCppJ9BU9M5saA5NuMCil
	 mBqbNY9uEwslhAj0FO7BJPP1JHbUoXHEBa4Gtl1z1H1/IxFp3ZoXI9J7dzkoJ7n/jO
	 g+BUA3wK+8O24kvlwaF8ER48WnHmSvCTYSYgUVsd6EJkE/csiJeEC3xlBgks39/1Od
	 65N+nViK6Yqh79HOnI/GWcmbtfBtkPBw1FwkkQit2P0P1YQ7MBhm5fc1FHU0kUPpdL
	 aoqf9Cr4Xr1LQH0oBoG8Z6QPpR8enxM8zog0is6AAd7CmdPo80EZ58sOyAnBRYm9PV
	 U79xXhHmA/ABQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF753C433E9;
	Thu, 18 Jul 2024 21:26:25 +0000 (UTC)
Subject: Re: [GIT PULL] perf-tools for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240717010342.900344-1-namhyung@kernel.org>
References: <20240717010342.900344-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240717010342.900344-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.11-2024-07-16
X-PR-Tracked-Commit-Id: 7a2fb5619cc1fb53cb8784154d5ef2bd99997436
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 68b59730459e5d1fe4e0bbeb04ceb9df0f002270
Message-Id: <172133798571.21905.7530548478478871627.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jul 2024 21:26:25 +0000
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jul 2024 18:03:40 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.11-2024-07-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/68b59730459e5d1fe4e0bbeb04ceb9df0f002270

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
