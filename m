Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F5D22A4EB;
	Tue,  3 Jun 2025 23:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748992779; cv=none; b=EpCqDJIyowJKWVvvToW/Aq3SChBb2Awu25aYAOoTdZmoMjqIETAcTcMum0BIWovbMRfpSNOX1kUh+0W4RQl55214ZwpX4ff8fPzfjjJeXiXb57eP+XshG9KSxA4jdwrNQAavEMdssvxL7rqiWVPwlM0rAUddBgztwsqrCWRWNQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748992779; c=relaxed/simple;
	bh=zgyzLu0186S6pt9BoBS4AN19AzSRhe5EDhGuHICiHYY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=i0VPCkrb2fKcu10ahYctTVPDk6E5xdBW1GApIbLrM6o+xQPt+0JN3AxrnWd4zFXSv2j62AN2uDKmsUZIYM+OC0A02J+3o4M4lNAf0q3GtNxuJmlZzckt3ZSj+lXOj4QNAlwyVztqYpfpAy9rxM6uhVV2fizRFV2bhQ4V+Hw/HaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFsS37vC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFsS37vC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937F7C4CEED;
	Tue,  3 Jun 2025 23:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748992779;
	bh=zgyzLu0186S6pt9BoBS4AN19AzSRhe5EDhGuHICiHYY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fFsS37vCHufzXpJnUmtrH7kP+HsfZ+Nc7bR+YhYRZAGTsqwq+bleCInXR8XqP4wWE
	 RekwNzH2astJyxkN4nDMerURlImkFRsPo1xFQDcKu2XF7D/TCa8U2iSfmrg3BtjAsd
	 /jMBtnP1FlQStfnV1O4ku3cRST6KZwii3JSs/R+JT+WBel5ZDXxWVXqfZ2fAuez9y8
	 Q9ZyqXchtIemUCqiV/MVl8rVQ01I0XPbUNeLBLkW/u7LZle6PZPztbmyF+SL8O7S3f
	 f8YDDbI/T6pweflmcMvKcGCopTXy+tWyTphDy1RHNS7yV2tUDl4ZQNSIC7mXpyIFFL
	 +2nSN0ve2XGsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3431D380DBEC;
	Tue,  3 Jun 2025 23:20:13 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250603203501.1961487-1-acme@kernel.org>
References: <20250603203501.1961487-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250603203501.1961487-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.16-1-2025-06-03
X-PR-Tracked-Commit-Id: a913ef6fd883c05bd6538ed21ee1e773f0d750b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0939bd2fcf337243133b0271335a2838857c319f
Message-Id: <174899281172.1701538.2545209801834676409.pr-tracker-bot@kernel.org>
Date: Tue, 03 Jun 2025 23:20:11 +0000
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Chun-Tse Shao <ctshao@google.com>, Heiko Carstens <hca@linux.ibm.com>, Jakub Brnak <jbrnak@redhat.com>, Junhao He <hejunhao3@huawei.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Stephane Eranian <eranian@google.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, Weilin Wang <weilin.wang@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Tue,  3 Jun 2025 17:35:01 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.16-1-2025-06-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0939bd2fcf337243133b0271335a2838857c319f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
