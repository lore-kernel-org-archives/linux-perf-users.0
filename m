Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754EF1845
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Oct 2023 22:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpaNn6Np"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5578C433C8;
	Sat, 14 Oct 2023 22:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697323795;
	bh=r7KmBeLhIBHztwszX055XwePH4046HAouTs+IP0R7nQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TpaNn6NprZ2j0FjjLY9/BOGIsnDfJ7XXqqBHX9k5Ap45ehJHhUrNmRShoeoGu9DLD
	 ziKkMU6W+TKMf0XW3G20G1kFUDD74PnQ4oN0ODqXfuKmSMRiRdcPVAg2RwX8ijWzR2
	 JbDyyUkRnlJGdkg1TMezw4IGfCjFyw6yMkYpkjG9zQWVozzzWxTIWIZMiUMzAtcs5g
	 XfAcFTbBM0zz0zvyWB72nVnM3qpeF17VcIn1FIK5O+FLEpKREck9JewAGCBOqnVl2u
	 iielkfR2zQjU1yLcJDtqcUIomzGX9FSPt5sJ+KHz6OmOlMvSFi1BPJlgLcMQ1JvfCo
	 i80MAVQkgDyDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C918BC73FEA;
	Sat, 14 Oct 2023 22:49:54 +0000 (UTC)
Subject: Re: [GIT PULL] perf events fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZSsO8/2KhWgd6kLS@gmail.com>
References: <ZSsO8/2KhWgd6kLS@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZSsO8/2KhWgd6kLS@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-10-14
X-PR-Tracked-Commit-Id: e53899771a02f798d436655efbd9d4b46c0f9265
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23931d935363846a9b39a890d4aead208cd46681
Message-Id: <169732379481.22000.5001415593902459941.pr-tracker-bot@kernel.org>
Date: Sat, 14 Oct 2023 22:49:54 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 14 Oct 2023 23:58:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-10-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23931d935363846a9b39a890d4aead208cd46681

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
