Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8E02874FF;
	Fri, 23 May 2025 08:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747987845; cv=none; b=H9Y1Zdok1JA9rSzktTyzj0ENp7DpypfecUs5Wa2jh3INXa211XlZUAUgvupVkXdOA77OK94rcXfz+cp0+8m7UzCKw4/3QEzi1ikoX7BqhW+pA2RsfcNglN7ZISd+a54QOQ4x4l20CfFDNJyzGFHluwaPwjipp1ZnEYxF38XKcCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747987845; c=relaxed/simple;
	bh=Pn6soPY7JUJ+aSD2s52N7FMA70X0mdacM1Xy6nBn0iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pu58d+2z5xlZFd1DBjtZweFuU6Jta6gTgpQW6JzGgjjzJkpJRVII2uJdxm9T8PvMRsYsCB96CGyWiWlrN8fOhc/HPHSnhGNud9SqT6BP7h/5P5e0UoOAEvRxaZfw9R1Fsa7LJWDXIoTEV4FRgswH59t5867j0RpQSwJN7lMkOfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7B011758;
	Fri, 23 May 2025 01:10:26 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B44AE3F6A8;
	Fri, 23 May 2025 01:10:40 -0700 (PDT)
Date: Fri, 23 May 2025 09:10:36 +0100
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tests switch-tracking: Fix timestamp comparison
Message-ID: <20250523081036.GB2566836@e132581.arm.com>
References: <20250331172759.115604-1-leo.yan@arm.com>
 <aC_Vn95vYqcXul03@x1>
 <aC_WFRe_4HjVPUrM@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC_WFRe_4HjVPUrM@x1>

On Thu, May 22, 2025 at 10:57:41PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, May 22, 2025 at 10:55:46PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, Mar 31, 2025 at 06:27:59PM +0100, Leo Yan wrote:
> > > The test might fail on the Arm64 platform with the error:
> > > 
> > >   perf test -vvv "Track with sched_switch"
> > >   Missing sched_switch events
> > > 
> > > The issue is caused by incorrect handling of timestamp comparisons. The
> > > comparison result, a signed 64-bit value, was being directly cast to an
> > > int, leading to incorrect sorting for sched events.
> > > 
> > > Fix this by explicitly returning 0, 1, or -1 based on whether the result
> > > is zero, positive, or negative.
> > > 
> > > Fixes: d44bc5582972 ("perf tests: Add a test for tracking with sched_switch")
> > > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > 
> > How can I reproduce this?
> > 
> > Testing on a rpi5, 64-bit debian, this test passes:

Sorry that I did not give precise info for reproducing the failure.
The case does not fail everytime, usually I can trigger the failure
after run 20 ~ 30 times:

# while true; do perf test "Track with sched_switch"; done
106: Track with sched_switch                                         : Ok
106: Track with sched_switch                                         : Ok
106: Track with sched_switch                                         : Ok
106: Track with sched_switch                                         : Ok
106: Track with sched_switch                                         : Ok
106: Track with sched_switch                                         : Ok
106: Track with sched_switch                                         : Ok
106: Track with sched_switch                                         : Ok
106: Track with sched_switch                                         : Ok
106: Track with sched_switch                                         : Ok
106: Track with sched_switch                                         : Ok
106: Track with sched_switch                                         : Ok
106: Track with sched_switch                                         : Ok
106: Track with sched_switch                                         : Ok
106: Track with sched_switch                                         : FAILED!
106: Track with sched_switch                                         : Ok
106: Track with sched_switch                                         : Ok
106: Track with sched_switch                                         : Ok
106: Track with sched_switch                                         : Ok
106: Track with sched_switch                                         : Ok
106: Track with sched_switch                                         : Ok
106: Track with sched_switch                                         : Ok
106: Track with sched_switch                                         : Ok
106: Track with sched_switch                                         : FAILED!
106: Track with sched_switch                                         : Ok
106: Track with sched_switch                                         : Ok

I used cross compiler to build Perf tool on my host machine and tested on
Debian / Juno board.  Generally, I think this issue is not very specific
to GCC versions.  As both internal CI and my local env can reproduce the
issue.

Please let me know if need any more info.  Thanks!


---8<---

My Host Build compiler:

# aarch64-linux-gnu-gcc --version
aarch64-linux-gnu-gcc (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0

Juno Board:

# lsb_release -a
No LSB modules are available.
Distributor ID: Debian
Description:    Debian GNU/Linux 12 (bookworm)
Release:        12
Codename:       bookworm
