Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3344D16CD35;
	Mon, 25 Nov 2024 19:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732561655; cv=none; b=UoK4fOYDhHX5F90nXN9jO6OHVKM9T6j5jYoZSCCDoiZKhSiOtii0rivUl4mmH4s3ZeGw5cMJzO6kKSveCUE3YD3hi3/mNkTMKU8cgDRbacsH8jnb7+Z8mEZnZLR/YFRnsMVPHoW+9VSpk+G03ZEvFPLojo+MiqMeLZvff0MafUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732561655; c=relaxed/simple;
	bh=ZXpT8td/F+7FP+hC2pGqZymeWWbCbMH8CMKMrLPSWmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qG01LR9rjdN4B5QHZesRg75ykPmDgeD3yMIpOQn08VzfpcTq5ss7efNQ7cBNxnH78ojXSBnVr8SE2M/B52O9vGW4Ap5S2TzEjTFRQ2mVnHOvMPmUn8RmcME5o2WT6CuEee0eiOjFlcZMlIdj4uEx9dHy0n0BJEIj0XIqGw810ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r722nzmc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r722nzmc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A22C4CECE;
	Mon, 25 Nov 2024 19:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732561655;
	bh=ZXpT8td/F+7FP+hC2pGqZymeWWbCbMH8CMKMrLPSWmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r722nzmcsZdvp/PLMSq0eyH9CLh6CY8NYpTu4j7oVbCK18+ZPVEAW+GQ7/7yY0aBT
	 /rnM5Hgpoyw1KqJ4AWnEJGygZfdMU4cj3uu9veCy3l2XXZdfT7bf2+asMA0pDkPbs5
	 0yOYlfXoS0nWOOvnor4ZUWlCyxzVcnBtKgx1cH7gI8SAPObLSZeVyOzEsscruIRVM6
	 THJ6+FsYKtN60SkzAO/+aRB0rKEvfeZXo8yhPclOyuw9A3AgrbrvtF750MA/XqwUGr
	 9okQAqkS7y2hoSSugd62Oxk+QXGOd0MuV9S+7f34KjZzCoRf8lFzOFCs88eGseq+S3
	 jNjsP7S/tBqrg==
Date: Mon, 25 Nov 2024 14:07:33 -0500
From: Sasha Levin <sashal@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [GIT PULL] perf-tools changes for v6.13
Message-ID: <Z0TK9aqrQO1PremH@sashalap>
References: <20241125071653.1350621-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241125071653.1350621-1-namhyung@kernel.org>

On Sun, Nov 24, 2024 at 11:16:53PM -0800, Namhyung Kim wrote:
>Hi Linus,
>
>Please consider pulling the following changes in perf tools for v6.13.
>
>Thanks,
>Namhyung
>
>
>The following changes since commit 59b723cd2adbac2a34fc8e12c74ae26ae45bf230:
>
>  Linux 6.12-rc6 (2024-11-03 14:05:52 -1000)
>
>are available in the Git repository at:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.13-2024-11-24

Hey Namhyung,

After merging this PR into linus-next, the "Simple expression parser"
test has started failing:

--- start ---
test child forked, pid 292
Using CPUID GenuineIntel-6-1A-3
division by zero
syntax error
Failed to find TSC frequency in /proc/cpuinfo
FAILED tests/expr.c:250 #system_tsc_freq > 0
---- end(-1) ----
   7: Simple expression parser                         : FAILED!

Here's a full log of the run: https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-24716-gab16e9af2ff9/testrun/26045681/suite/perf/test/_7_Simple_expression_parser/log

-- 
Thanks,
Sasha
