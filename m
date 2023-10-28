Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7783C22
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Oct 2023 18:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lC/kYO7B"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C33BC433C8;
	Sat, 28 Oct 2023 18:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698517064;
	bh=dTvlh6cdqkB5NiPhQLx4frL2C2VnNrFy/jhuQkThw1o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lC/kYO7BnPyJzZIlpO2zENTs9Yc1mTF1jbNrcsyoGXPZvhGjFuubFJb/egZch7xp/
	 DJGlTzuidPNm36JjGn+qKEUpnTvo2eP7K9D5A18jhrOoKLG9KoXVHpfv/TpOFq0Y41
	 T3UkO5U6J53bQCB7fkSgdVFRk1JK0zVQhz8KJSc9SmMVxFeZavvE0MHyiG0yr4wEQi
	 RSREE8vMjieU+COrE/g+d1yb3Ue8SLmWVMZ28pqK6MECCOjYIXiDs9DlIjUB4+FwfB
	 fZeNVX8MQ59uW4uXmTBJU4ZllnaFB0hSFIcQvfkyjcTHCyzFEtNur4qnqR9uwf4n8D
	 01URRXe8BnUCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 875D1C4316B;
	Sat, 28 Oct 2023 18:17:44 +0000 (UTC)
Subject: Re: [GIT PULL] perf events fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZTzlUz5PMxr36K1S@gmail.com>
References: <ZTzlUz5PMxr36K1S@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZTzlUz5PMxr36K1S@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-10-28
X-PR-Tracked-Commit-Id: a71ef31485bb51b846e8db8b3a35e432cc15afb5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4714de03329810b9ac57762b6bfdb73b123fedd5
Message-Id: <169851706454.30729.12166886772743119077.pr-tracker-bot@kernel.org>
Date: Sat, 28 Oct 2023 18:17:44 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 28 Oct 2023 12:41:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-10-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4714de03329810b9ac57762b6bfdb73b123fedd5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
