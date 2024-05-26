Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E8AD524;
	Sun, 26 May 2024 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716742806; cv=none; b=ULfvBCcko17vjNxTAmMI5VwMRjk4J0ze4pFfeKZ3AigDsc4OztXFwdNO2n2wXAETxhoycASlR8b1i+hbUM83cz/fxdch0D6vxMq64TsIO0e6SN+yH/q7IV8zYXO+qfhG5EgXAjZrq6iMpZgQOMS88AXxKqkwXTBEwPQnf3nCc2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716742806; c=relaxed/simple;
	bh=RxevVCz/VKL7gWOtSnkCv/6LrpxrIuubSx4lvATAUME=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pKwldihY47W1lI+DipMPzXaIVLyFiFFItCeZ0zG8Q5CGRo2u7nvE/2+i88jK/fqUANkyBZKXx4CiRCwAiecB+YXknaU68gjN6nNFK+XJbX95bGw3DX/ovOZ/B5rpVVLTP0Z+/+9Y5YA2NYkMmOy8litftUQfbh+QevpywbkpHx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjwBKDNv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjwBKDNv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2476C2BD10;
	Sun, 26 May 2024 17:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716742806;
	bh=RxevVCz/VKL7gWOtSnkCv/6LrpxrIuubSx4lvATAUME=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZjwBKDNvQRnEyvqUdeEKssJDTAKJgfS+CzcMouUYpxD9N20zd4WrPuzsnO/yZpGCO
	 ZCTI4Y3bHCbq64mDRCZxw/eIQOxR7aix/hznE0B9ocWX12rQ/zEuKORdqMHkInFEyl
	 k+oJQuPdHPKqJLh11qAHAp/OlmM2K7CcoZd44IOqfxfpOpU4jPDeT5xV1Uigm/EET2
	 M4S6oi/YiKIcrWvUGTBsnJhj9/FZiT4C2ksugoCmfqB9VHrBg9k9WzuhgbOL3eou5z
	 /FGTA9sYksYv9HU7fbJNmtcD4o3CuxliqTPY5jk0WcYwh0hVz2xzKYq75sIXJT9rdl
	 o8Kd47RpKB1qg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C64B6D6033C;
	Sun, 26 May 2024 17:00:05 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fix for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240526115834.4080389-1-acme@kernel.org>
References: <20240526115834.4080389-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240526115834.4080389-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.10-1-2024-05-26
X-PR-Tracked-Commit-Id: 4f1b067359ac8364cdb7f9fda41085fa85789d0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6fbf71854e2ddea7c99397772fbbb3783bfe15b5
Message-Id: <171674280579.20245.12855170738646474612.pr-tracker-bot@kernel.org>
Date: Sun, 26 May 2024 17:00:05 +0000
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Clark Williams <williams@redhat.com>, Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Leo Yan <leo.yan@linux.dev>, Bhaskar Chowdhury <unixbhaskar@gmail.com>, Ethan Adams <j.ethan.adams@gmail.com>, James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, Tycho Andersen <tycho@tycho.pizza>, Yang Jihong <yangjihong@bytedance.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 26 May 2024 08:58:34 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.10-1-2024-05-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6fbf71854e2ddea7c99397772fbbb3783bfe15b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
