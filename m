Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD10D26D;
	Tue, 26 Nov 2024 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732589584; cv=none; b=KRLidAaXDb0oXJRqVxbVBxH+Umou/tP37N+F67g1dkFi2rKBaneeuANXV9OLDV2trusNtwC3P22lSktZ/Wlt1ltOrvVEH+BiiKTfi+8U9OZPK7qm/UK0FErN7UM/4fZHNUd+6rdta0i+4DI2dc50halHEYVD+d1sMMnljGWhYX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732589584; c=relaxed/simple;
	bh=1bIygSuurKVJrm+y5RfLrB2t6e7qykl+uo3eNRNLbjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kI6qpLFft2YfJ+Ip1F1xdgK+1kCgQ88BJ9R9W8sZXgJ/mCScGyKVIadOEZH0n41M2TOPNc+TuLu48cXaMo/A/FpwZiS4X8EusqCn0AiJB398pIx16eDnmt7gD7dhuOduWQJP6sOzvYHdZ8xte34HKLjN7rcSbXF/n0IiQKqtqYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3rTNPXV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3rTNPXV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC569C4CECE;
	Tue, 26 Nov 2024 02:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732589584;
	bh=1bIygSuurKVJrm+y5RfLrB2t6e7qykl+uo3eNRNLbjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K3rTNPXVnGRB6NrRGj/9gkVo+mcDS3GtlW6Am6UPKohLNg3+SHII5ytecyO/WB8ZJ
	 5B+UPqXvNfRRiNqlKsa0wOx8fWSKFNXY4pl6y4q8J6e/HbY8UGqL2gwfk7iRVqFW5n
	 TC6AGbURM8lb3A3iubF/b7XXLE1yZJyBBreKYFior488W2zp0G1L+cqHKh7N86jjIM
	 AL9T94JIY6ratimMkTdxotxIkn8XtIfXpjh6No0TZx5QYwhXN8TRXexescIFhmGRFI
	 A2nFU7u+1Blj9p5oJvz27ujfColVv2jk1+Twvq/V4d64XDO6M+k0/5riSTsjm/LFzu
	 jzXkEdQeLKHSw==
Date: Mon, 25 Nov 2024 18:53:02 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [GIT PULL] perf-tools changes for v6.13
Message-ID: <Z0U4Dk_W30x4JSXG@google.com>
References: <20241125071653.1350621-1-namhyung@kernel.org>
 <Z0TK9aqrQO1PremH@sashalap>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z0TK9aqrQO1PremH@sashalap>

Hello,

On Mon, Nov 25, 2024 at 02:07:33PM -0500, Sasha Levin wrote:
> On Sun, Nov 24, 2024 at 11:16:53PM -0800, Namhyung Kim wrote:
> > Hi Linus,
> > 
> > Please consider pulling the following changes in perf tools for v6.13.
> > 
> > Thanks,
> > Namhyung
> > 
> > 
> > The following changes since commit 59b723cd2adbac2a34fc8e12c74ae26ae45bf230:
> > 
> >  Linux 6.12-rc6 (2024-11-03 14:05:52 -1000)
> > 
> > are available in the Git repository at:
> > 
> >  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.13-2024-11-24
> 
> Hey Namhyung,
> 
> After merging this PR into linus-next, the "Simple expression parser"
> test has started failing:
> 
> --- start ---
> test child forked, pid 292
> Using CPUID GenuineIntel-6-1A-3
> division by zero
> syntax error
> Failed to find TSC frequency in /proc/cpuinfo
> FAILED tests/expr.c:250 #system_tsc_freq > 0
> ---- end(-1) ----
>   7: Simple expression parser                         : FAILED!
> 
> Here's a full log of the run: https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-24716-gab16e9af2ff9/testrun/26045681/suite/perf/test/_7_Simple_expression_parser/log

Thanks for the report, I'll take a look.

Namhyung

