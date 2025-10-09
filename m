Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8494A06;
	Thu,  9 Oct 2025 02:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759977613; cv=none; b=Rx4l4f1whmcHRZbN9eJubKYGc0CJcdtKesbN2VgWU/h7bwhSN9lAaPEiJTXaJ7A8X1St3XFIU2VHOT48BVrL1/a1tzZRVq43dNJ10gnI/ZC6n1t73s8toTjAwDIcl2I2odhoxr3abb3SM2mR2hBAmeTAIgNrXHtXHaIjuHCXr5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759977613; c=relaxed/simple;
	bh=SfF8OsFdqWY0TzUpzXdg3+0k+Nk5GeXD7pfItdDcVj0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dpH+YjxNDj8xtUnyc4mGikHaSH2XRRHHH39ZLoTUIN6tW/PEaKNnrClcnFPacR09BL+af5KeEu3lugxTiyyoQhCmuXo73m8e10jrjtnzSjw4QgaQ2MpqtvwbZ7blXTdcLOIvLOMcn9mzVxsVI/FgCAHIf+T+XbsRsy2A4WCvsqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9adfab5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9adfab5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C50C4CEF5;
	Thu,  9 Oct 2025 02:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759977612;
	bh=SfF8OsFdqWY0TzUpzXdg3+0k+Nk5GeXD7pfItdDcVj0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=u9adfab5FIQorOQIO7san3Wdh+BaE5n1Kn05qaKDNACQ5Dll1l/ee0xVTnc6nAa7y
	 pL8NxheN5x+qIAPrNafWNtd5TQuEgSGfKdnc+sFB1G98Kj+hhREPoUb6PzOpEpB64U
	 Oba1/miLnmfVQChTwvX85TM19txs+0aPFw34E2By/NL5tIKrFVbdsqU8CGh6s28JuM
	 90tsMGeYa2qBCRmXkN82zVoEhlcpFqu1FHnFO7l/HFy3MmbhZh9TBUh0JauYriHxR3
	 e9gWe1/7bHDAVTnUSk0bpWhG+0XHQFuf3Gv0H3nngcOFMIUJZUdX7rktA0HAbwPp03
	 wkGImPZa8FR/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5A39C3A41022;
	Thu,  9 Oct 2025 02:40:02 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251008202804.852200-1-acme@kernel.org>
References: <20251008202804.852200-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251008202804.852200-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.18-1-2025-10-08
X-PR-Tracked-Commit-Id: f3b601f900902ab80902c44f820a8985384ac021
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec714e371f22f716a04e6ecb2a24988c92b26911
Message-Id: <175997760107.3724664.13362648592696519117.pr-tracker-bot@kernel.org>
Date: Thu, 09 Oct 2025 02:40:01 +0000
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Ankur Arora <ankur.a.arora@oracle.com>, Athira Rajeev <atrajeev@linux.ibm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Colin Ian King <colin.i.king@gmail.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, David Binderman <dcb314@hotmail.com>, Fushuai Wang <wangfushuai@baidu.com>, Gautam Menghani <gautam@linux.ibm.com>, GuoHan Zhao <zhaoguohan@kylinos.cn>, Howard Chu <howardchu95@gmail.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, Tejas Manhas <tejas05@linux.ibm.com>, Tho
 mas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, Trevor Allison <tallison@redhat.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Xudong Hao <xudong.hao@intel.com>, Yunseong Kim <ysk@kzalloc.com>, Zecheng Li <zecheng@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  8 Oct 2025 17:28:04 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.18-1-2025-10-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec714e371f22f716a04e6ecb2a24988c92b26911

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
