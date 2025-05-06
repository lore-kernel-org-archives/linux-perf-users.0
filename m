Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C0D28D8C5;
	Tue,  6 May 2025 05:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746509454; cv=none; b=DmmLWl1zlukSa2/nQKDEV0pTRrUiK9z1LWQEbfIUtetVwocMGAvSMaiEkIirxQz1Zz1cgH/pXAfbUQSdpRIuDZXHUbEm0rdiLIAXst1Fo1gJCKUGDpXwWF3J5R4OAMT1mlIS3tmwQhGQy5tf5ZXuZzl53+Hz93vfO+kSnTlAE+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746509454; c=relaxed/simple;
	bh=cLFooBXgRn8ODZsXU+Y9p4al/umeSaxBwRdxCv426Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BR5D9JzFg4ADM7oBkiXBhSnHNWw57RozOkEFu16NLk7vRspCdBcpoUmihoOiniiPALBJI0i90r4HnZoCPVGHLyEGHziG8X3/H4GoBNoZALIfU2LJYgoTOrU0GBR5GI2QY6CC9uSiBuBcxEl/ft2nsYJMBgrfGw6gpjQgpd0lx5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huH0rdMd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huH0rdMd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C57CC4CEE4;
	Tue,  6 May 2025 05:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746509454;
	bh=cLFooBXgRn8ODZsXU+Y9p4al/umeSaxBwRdxCv426Po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=huH0rdMdNZOSluLe1qXY5AKcLV0+6nkXsUQACvWiP9Y8x8VoHFtD21Ln9ldSogG2Z
	 ZxnzMSTXa7DQmHhP18YcCNFn4XyJQxEQJB4RIovD4msDYGEpuiOfUAK4zpD95sDRFx
	 KtS1PQrXGbpghm+3f/OKk4TSoS3ro4LxrpZQfFCyawbtVYmx1ZUJ/ar6WHKl6x7KTv
	 oY/DoentdsfMGWhEXFXdHk6uDTWcCGnU868091K54e7mLQoVww3aWlx+dWr+O7C5dX
	 4ZxKRW6c4rxLFm0ygfYubVHu4MSAUogz3/ifAS1z1Se0s8nkfQ9g3Y096dgGpDonm3
	 iEtQ8i5sj93cA==
Date: Mon, 5 May 2025 22:30:51 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC/PATCH] perf report: Support latency profiling in
 system-wide mode
Message-ID: <aBmei7cMf-MzzX5W@google.com>
References: <20250503003620.45072-1-namhyung@kernel.org>
 <CACT4Y+Yr7vffLYG+YmyB=9Vn_oxdQqR_6U4d-_WeQoOtPXZ6iw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+Yr7vffLYG+YmyB=9Vn_oxdQqR_6U4d-_WeQoOtPXZ6iw@mail.gmail.com>

Hello,

On Mon, May 05, 2025 at 10:08:17AM +0200, Dmitry Vyukov wrote:
> On Sat, 3 May 2025 at 02:36, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > When it profile a target process (and its children), it's
> > straight-forward to track parallelism using sched-switch info.  The
> > parallelism is kept in machine-level in this case.
> >
> > But when it profile multiple processes like in the system-wide mode,
> > it might not be clear how to apply the (machine-level) parallelism to
> > different tasks.  That's why it disabled the latency profiling for
> > system-wide mode.
> >
> > But it should be able to track parallelism in each process and it'd
> > useful to profile latency issues in multi-threaded programs.  So this
> > patch tries to enable it.
> >
> > However using sched-switch info can be a problem since it may emit a lot
> > more data and more chances for losing data when perf cannot keep up with
> > it.
> >
> > Instead, it can maintain the current process for each CPU when it sees
> > samples.
> 
> Interesting.
> 
> Few questions:
> 1. Do we always see a CPU sample when a CPU becomes idle? Otherwise we
> will think that the last thread runs on that CPU for arbitrary long,
> when it's actually not.

No, it's not guaranteed to have a sample for idle tasks.  So right, it
can mis-calculate the parallelism for the last task.  If we can emit
sched-switches only when it goes to the idle task, it'd be accurate.


> 2. If yes, can we also lose that "terminating" even when a CPU becomes
> idle? If yes, then it looks equivalent to missing a context switch
> event.

I'm not sure what you are asking.  When it lose some records because the
buffer is full, it'll see the task of the last sample on each CPU.
Maybe we want to reset the current task after PERF_RECORD_LOST.


> 3. Does this mode kick in even for non system-wide profiles (collected
> w/o context switch events)? If yes, do we properly understand when a
> thread stops running for such profiles? How do we do that? There won't
> be samples for idle/other tasks.

For non system-wide profiles, the problem is that it cannot know when
the current task is scheduled out so that it can decrease the count of
parallelism.  So this approach cannot work and sched-switch info is
required.

Thanks,
Namhyung

