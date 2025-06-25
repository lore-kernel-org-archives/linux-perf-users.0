Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775322D8797;
	Wed, 25 Jun 2025 18:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750874685; cv=none; b=crztePisKkuyPR4zP0/q7C9GYbsgLeAKJzkhUhqzKmTpAIoAuTVPfTPDefhpe+78vkn35NqomscuY2kENrm+x66KlvXWE5qiKH9ke+kadKnOWPcWao0k+r4EMMnBrMNBjrZgnZQBuYkYJ+HEv6JWUboWILnuYtkRcgeaZNOaMhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750874685; c=relaxed/simple;
	bh=qmiQoQpF5584atSrenVQkQySd2pVyPBVliKWVQjQIbA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hstYLqVFyOmv++KBo42MToOL1kxFjwDLz2L7hd8V/hThXjeFF1OkgKH4mF8Fkz2WaSZ/8TyXKk6xVmUam8B5FdFVMrY9HyNGZBpybk1CrU3GtEBx/fU4TQV7aDLwfNkU3DGwJS+2BhpdGp28H28PKwm+OofEZo0VBVKbT3FHIpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j88BTki+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j88BTki+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8907EC4AF0B;
	Wed, 25 Jun 2025 18:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750874685;
	bh=qmiQoQpF5584atSrenVQkQySd2pVyPBVliKWVQjQIbA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=j88BTki+ubMVzpPPFJvVh9Zj4IeQlKaYclaPry+Q/lWDV9DNwu5r9/Tx0rgEGgiRa
	 uO9ICyfzFuNV2y+cVyAOnLbB/HrwHxjKeixXP6owKzAcaAPC5ZALKToKTiQxFIVxg0
	 pkryGcdOUnJPiX8mbVUlPkvPPbb6LdgB3lx7nkYoF9hqSC3SXbJlp/0qnbrkaYul8Q
	 0xpe/fK6AKdegA+hex+qHW1CVplHBrcUVrsR9wjZZ1ExNnjTrVneymSdNFtiwOCJDG
	 HEvyQXeTmwn4glBna0GCnnWinWGF5BqDBP/1RW1l5LxSIZyCfxN5g8US5XNhlVLPef
	 wfxzMp/6I40Cg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
 Howard Chu <howardchu95@gmail.com>, Yicong Yang <yangyicong@hisilicon.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20250624210500.2121303-1-irogers@google.com>
References: <20250624210500.2121303-1-irogers@google.com>
Subject: Re: [PATCH v5] perf debug: Add function symbols to dump_stack
Message-Id: <175087468452.1361639.1912600389243885469.b4-ty@kernel.org>
Date: Wed, 25 Jun 2025 11:04:44 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 24 Jun 2025 14:05:00 -0700, Ian Rogers wrote:
> Symbolize stack traces by creating a live machine. Add this
> functionality to dump_stack and switch dump_stack users to use
> it. Switch TUI to use it. Add stack traces to the child test function
> which can be useful to diagnose blocked code.
> 
> Example output:
> ```
> $ perf test -vv PERF_RECORD_
> ...
>   7: PERF_RECORD_* events & perf_sample fields:
>   7: PERF_RECORD_* events & perf_sample fields                       : Running (1 active)
> ^C
> Signal (2) while running tests.
> Terminating tests with the same signal
> Internal test harness failure. Completing any started tests:
> :  7: PERF_RECORD_* events & perf_sample fields:
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


