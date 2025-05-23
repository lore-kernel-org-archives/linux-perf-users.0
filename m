Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009CA22318;
	Fri, 23 May 2025 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020388; cv=none; b=VMGtlL5fU9/HgNk9B59D897KQFjEWx/Tb08v1OLQy84BkOJo9ExeRJx0/OCgeGPT+v7+S7LFfy54OeotOlzzIWiPz5QOt5B6njLhpVACXRr3kh3crRucnTPXRlizlzrB6h0vy2xUPOI1I5eH63f3CgDts3NbHoL05DzdxfrdW10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020388; c=relaxed/simple;
	bh=vR9SjEVhKMUFcmTGm2cEl/qeEA+zX6+5RQFExQz9c6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyMYJbviuQRnAA/h6sS+WtWMfG4sx1BNkKuzfhSV7QjYiu2z1Me11Qp2HjD7KFlb8MPjz9mWgA5nvHNzq4XSTavhDPpL0hiROUCF59ax/lXKH1wPUXrZny7Gj9eKgtdD8r6S21Ewy5eWZrhvbAKXqJZ5dni9BdwH9bR4I/1X3Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiLfLUAT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiLfLUAT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8083C4CEE9;
	Fri, 23 May 2025 17:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748020387;
	bh=vR9SjEVhKMUFcmTGm2cEl/qeEA+zX6+5RQFExQz9c6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kiLfLUATa14dzW/25PsGhCmLyFtgx25M/YfRee1Q3RZZAqmcqLKB9Un/Y1F7F7ycj
	 KBrK1nBQoaYFBeSs2DWTmmo7U6OzPy6QieOgcSFr7ugGXxrRRCLT7kTjZHPBPEfYRG
	 QIo5Nv+NcF9RMKFSczy9NKWAY/qwDfv94PJrzNZ0XUciAmkWbG8JonAMKt/QbRS/eW
	 JM/oEzTwcwDfx2HCtCCXfDVw8OGYIb9FDPkS3tHnpNzbYi3B2TTCEFm/L7f/G8LrbL
	 Fuc71OxOpSfs5r5VTANEZJVU056V3aPLnPnDBG0glyVIfbo65JyytqmDImfOPLmT3r
	 MZibnHllmMatg==
Date: Fri, 23 May 2025 14:12:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tests switch-tracking: Fix timestamp comparison
Message-ID: <aDCsmjb7Fex1ccOW@x1>
References: <20250331172759.115604-1-leo.yan@arm.com>
 <aC_Vn95vYqcXul03@x1>
 <aC_WFRe_4HjVPUrM@x1>
 <20250523081036.GB2566836@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523081036.GB2566836@e132581.arm.com>

On Fri, May 23, 2025 at 09:10:36AM +0100, Leo Yan wrote:
> On Thu, May 22, 2025 at 10:57:41PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Thu, May 22, 2025 at 10:55:46PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Mon, Mar 31, 2025 at 06:27:59PM +0100, Leo Yan wrote:
> > > > The test might fail on the Arm64 platform with the error:

> > > >   perf test -vvv "Track with sched_switch"
> > > >   Missing sched_switch events

> > > > The issue is caused by incorrect handling of timestamp comparisons. The
> > > > comparison result, a signed 64-bit value, was being directly cast to an
> > > > int, leading to incorrect sorting for sched events.

> > > > Fix this by explicitly returning 0, 1, or -1 based on whether the result
> > > > is zero, positive, or negative.

> > > > Fixes: d44bc5582972 ("perf tests: Add a test for tracking with sched_switch")
> > > > Signed-off-by: Leo Yan <leo.yan@arm.com>

> > > How can I reproduce this?

> > > Testing on a rpi5, 64-bit debian, this test passes:
> 
> Sorry that I did not give precise info for reproducing the failure.
> The case does not fail everytime, usually I can trigger the failure
> after run 20 ~ 30 times:
> 
> # while true; do perf test "Track with sched_switch"; done
> 106: Track with sched_switch                                         : Ok
> 106: Track with sched_switch                                         : Ok
> 106: Track with sched_switch                                         : Ok
> 106: Track with sched_switch                                         : Ok
> 106: Track with sched_switch                                         : Ok
> 106: Track with sched_switch                                         : Ok
> 106: Track with sched_switch                                         : Ok
> 106: Track with sched_switch                                         : Ok
> 106: Track with sched_switch                                         : Ok
> 106: Track with sched_switch                                         : Ok
> 106: Track with sched_switch                                         : Ok
> 106: Track with sched_switch                                         : Ok
> 106: Track with sched_switch                                         : Ok
> 106: Track with sched_switch                                         : Ok
> 106: Track with sched_switch                                         : FAILED!
> 106: Track with sched_switch                                         : Ok
> 106: Track with sched_switch                                         : Ok
> 106: Track with sched_switch                                         : Ok
> 106: Track with sched_switch                                         : Ok
> 106: Track with sched_switch                                         : Ok
> 106: Track with sched_switch                                         : Ok
> 106: Track with sched_switch                                         : Ok
> 106: Track with sched_switch                                         : Ok
> 106: Track with sched_switch                                         : FAILED!
> 106: Track with sched_switch                                         : Ok
> 106: Track with sched_switch                                         : Ok
 
> I used cross compiler to build Perf tool on my host machine and tested on
> Debian / Juno board.  Generally, I think this issue is not very specific
> to GCC versions.  As both internal CI and my local env can reproduce the
> issue.
 
> Please let me know if need any more info.  Thanks!
 
> ---8<---
 
> My Host Build compiler:
 
> # aarch64-linux-gnu-gcc --version
> aarch64-linux-gnu-gcc (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0
 
> Juno Board:
 
> # lsb_release -a
> No LSB modules are available.
> Distributor ID: Debian
> Description:    Debian GNU/Linux 12 (bookworm)
> Release:        12
> Codename:       bookworm

Thanks for the extra info, I'll add it to the commit log message, and
perhaps we could make this test exclusive and use stress-ng to generate
some background noise in the form of a good number of processes, see:

root@x1:~# stress-ng --switch $(($(nproc) * 2)) --timeout 30s & for a in $(seq 50) ; do perf test switch ; done
[1] 1773322
stress-ng: info:  [1773322] setting to a 30 secs run per stressor
 77: Track with sched_switch                          : Running (1 active)
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : Running (1 active)
stress-ng: info:  [1773322] skipped: 0
stress-ng: info:  [1773322] passed: 24: switch (24)
stress-ng: info:  [1773322] failed: 0
stress-ng: info:  [1773322] metrics untrustworthy: 0
 77: Track with sched_switch                          : FAILED!
[1]+  Done                    stress-ng --switch $(($(nproc) * 2)) --timeout 30s
 77: Track with sched_switch                          : Ok
 77: Track with sched_switch                          : Ok
 77: Track with sched_switch                          : Ok
 77: Track with sched_switch                          : Ok
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : Ok
 77: Track with sched_switch                          : Ok
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : FAILED!
 77: Track with sched_switch                          : Ok
root@x1:~#

Now with your patch it also fails, so its for another reason:

--- start ---
test child forked, pid 1777071
Using CPUID GenuineIntel-6-BA-3
mmap size 528384B
45221 events recorded
Missing comm events
---- end(-1) ----
113: Track with sched_switch                                         : FAILED!

Lots of short lived processes makes it fail as well :-\

Oh well...

I was just trying to improve this test case so that we would show it
failing before your patch and passing after it, but I ran out of time
:-\

Your patch is correct, so I'll probably just add your comments and go
with it.

- Arnaldo
