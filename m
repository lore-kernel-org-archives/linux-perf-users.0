Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716C878F40;
	Tue,  4 Feb 2025 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738696885; cv=none; b=TyqL2YqnJjTd0ZWiBAeM8OmDqtamGirMHh7jam/uP2xzVoWilml7Xas26O0NTaJYsrYbMLwLWXY8UW/+nxS3bX5UwAR4IKj8GlogtG6WLdkfQNHherkl4o3cYOsK60GxYdyQ+K0lHsGYbvzoudE2O8/a2b+fsF52QU/nGx677Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738696885; c=relaxed/simple;
	bh=riJz/oKWuLBigRN0rJhSFsYqsRGtfqaEMulBtvLGnx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihC0P7s5yDuoabKEZMTIEz3y0+LgIZwxmNvM9P7hA3tR+Y3AM1wnbK3mARqM0wcmaScJ945CrhcMaiUEM2PpSRNGVI6uK3jgFbUOKIqLr4JdPXbghvWXsmet4WiWMj8jxOIeklAfBG8MwkPKn2frHtBXwG3lXfC5ncpY8ncTxu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ge0pvn9v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ge0pvn9v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B0AC4CEDF;
	Tue,  4 Feb 2025 19:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738696884;
	bh=riJz/oKWuLBigRN0rJhSFsYqsRGtfqaEMulBtvLGnx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ge0pvn9v0uKMt5pAv6WMJBtE/Em7cj8cKqiovJnYIBHAkGzOBXcWSto8oV5W+nXMq
	 mUpQ/yW1cWgg3x6pHzfnDwklHm2b8mbRa2PoFQPKpBa4twQbggj3NDCGLM82fW1L/8
	 XceKnpMoCzryvghaSnu1rCjA3pwm2sXT/HMJtnGCn+gCn4zt4xdrOkxGudDLEHgmtj
	 K61+83H5ZMW3GCzqrCN8mCvdEL7m/MyIMNKmhBUr8MM/LuHm/fHZYRAr7Y5u/3Cehc
	 9EhPFOJaUxa28VTLzhiuG1bEVV7HSN4OL0DIXnrPOhZMRW0pQSaGqBAcgQ9mSrqRxf
	 yx0v1ClsFI7Pw==
Date: Tue, 4 Feb 2025 11:21:22 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: Re: [PATCH v2 1/4] perf trace: Allocate syscall stats only if
 summary is on
Message-ID: <Z6JosmbJBmiRHBKK@google.com>
References: <20250130030525.1482498-1-namhyung@kernel.org>
 <20250130030525.1482498-2-namhyung@kernel.org>
 <CAP-5=fVJDi2UuhTYk5g-QaLqZC29tAprKWs_0PKNmd+y=iugjA@mail.gmail.com>
 <Z6GCde4XqCuEZlgz@google.com>
 <CAP-5=fVrFzxcLZG8DyYh2rbd3u4133V6hhrQFCHsq_QMVVW=9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVrFzxcLZG8DyYh2rbd3u4133V6hhrQFCHsq_QMVVW=9g@mail.gmail.com>

On Tue, Feb 04, 2025 at 07:59:01AM -0800, Ian Rogers wrote:
> On Mon, Feb 3, 2025 at 6:59 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Sat, Feb 01, 2025 at 10:57:00PM -0800, Ian Rogers wrote:
> > > On Wed, Jan 29, 2025 at 7:05 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > The syscall stats are used only when summary is requested.  Let's avoid
> > > > unnecessary operations.  Pass 'trace' pointer to check summary and give
> > > > output file together.
> > >
> > > I don't think this last sentence makes sense.
> >
> > Thanks for your review.  I'd say:  Pass 'trace' pointer instead of doing
> > 'summary' option and 'output' file pointer separately.
> 
> This still doesn't make sense. There is lazier initialization:
> ```
> -               ttrace->syscall_stats = intlist__new(NULL);
> +               if (trace->summary)
> +                       ttrace->syscall_stats = intlist__new(NULL);
> ```
> and there are functions that take a FILE* but now we're going to use
> the one in trace instead:

Yep, those FILE* (fp) was from trace->output.


> ```
> @@ -1568,7 +1569,7 @@ static struct thread_trace *thread__trace(struct
> thread *thread, FILE *fp)
> 
>         return ttrace;
>  fail:
> -       color_fprintf(fp, PERF_COLOR_RED,
> +       color_fprintf(trace->output, PERF_COLOR_RED,
>                       "WARNING: not enough memory, dropping samples!\n");
>         return NULL;
> ```
> So why does the one passed to trace still exist? Unfortunately names
> like "fp" and "output" are not intention revealing.

I think "fp" is a conventional name for file pointers (probably from
K&R?).

> 
> Anyway, from the commit message and the code I don't understand what
> this change is trying to do.

I don't know where you didn't get it.  Apparently my English is not good
enough.  So this commit does two things.

1. check trace->summary before allocating syscall_stats
2. change signature of thread__trace from (thread, fp) to (thread,
   trace) so that it can use trace->output (fp) and trace->summary.

I thought the change #2 is trivial enough to be in the same commit.  But
I can split that if you want.

Thanks,
Namhyung

