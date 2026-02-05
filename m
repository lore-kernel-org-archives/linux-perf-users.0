Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FE13321AC;
	Thu,  5 Feb 2026 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770327720; cv=none; b=aTg+Tha8kPWyrb27QI8v2SqejMtjwF2esc9xOy9AFDd62y2lwJVXGgA5tI3UBNqC+h33G43PB+JS06IMm4FRiOD5ws9+e9zaBWP3Lmfq0Wh3kPJo9Blnk6N/nT5REmADcmJHYCgu4f0mPZPgXJw9Lq3ytdZViJb2FXAWqMMzuO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770327720; c=relaxed/simple;
	bh=V8lrK2gSaAHe8XmLJvm2a0dNxLqsnxZAaWdyFo3WJsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZundoyZmKuIb617t94SkifpdYl1fSE1VNppKfAcwRXB+yS596wVK7FNmT9q7cWNOTb/nMum0nq2YLR7xOV2AjRxAMl/O2aa6mB2co6HUErauuEfDS9rBA2p7KmhieX+eQehfuPJVWY3NQM688uaF+NU1sTGZ1vUNBMnmD94/Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8yomJIP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8yomJIP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F258FC4CEF7;
	Thu,  5 Feb 2026 21:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770327719;
	bh=V8lrK2gSaAHe8XmLJvm2a0dNxLqsnxZAaWdyFo3WJsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L8yomJIPD2F4GZtgObgQ1mxpShkGnpqehFAfpQZVXwelGEVzNFwwz+luJsMJv9Ybi
	 vQUVs5Y0S5oMbv50fp3cKb4eslF8nR73UEf90ZvIpTOJQdrWQiDQ20ekjtwcD3OrdR
	 eZHjmU0K+BoKBhYNzELE6pHkaZuAIfhQpMsAH1nNJAU1XWXJNfGfY98YuGuPZM+sZP
	 Ri6yIbJCuEubaoD/ccxtfRgRhhvjhUwBWlFnKWA2mMCs4foAFENwCgpKwgtdydPv6F
	 Yzi9hyJpwHA9IQOPCdpvGpzB2aHwanx6xq2sabYumoom/vRpqSJpuzbcQBrV5ZCx/F
	 HSW8gOqPcJG6w==
Date: Thu, 5 Feb 2026 18:41:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Leo Yan <leo.yan@arm.com>, Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf record: Make logs more readable for event open
 failures
Message-ID: <aYUOowQ_CZf3BDKo@x1>
References: <20260204-perf_improve_log_for_open_event_failures-v1-1-150245792810@arm.com>
 <CAP-5=fUQxuVK+6GObmqVdBmTLzu06FyNaLdLsW6tcgNv5=7gxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUQxuVK+6GObmqVdBmTLzu06FyNaLdLsW6tcgNv5=7gxw@mail.gmail.com>

On Wed, Feb 04, 2026 at 09:29:14AM -0800, Ian Rogers wrote:
> On Wed, Feb 4, 2026 at 6:26 AM Leo Yan <leo.yan@arm.com> wrote:
> >
> > Since commit ee27476fa300 ("perf record: Skip don't fail for events that
> > don't open"), if a user does not have permission to access a PMU event,
> > perf reports:
> >
> >   perf record -e cs_etm// -C 3 -- ls
> >   Error:
> >   Failure to open event 'cs_etm//u' on PMU 'cs_etm' which will be removed.
> >   No fallback found for 'cs_etm//u' for error 13
> >   Error:
> >   Failure to open event 'dummy:u' on PMU 'software' which will be removed.
> >   No fallback found for 'dummy:u' for error 13
> >   Error:
> >   Failure to open any events for recording.
> >
> > The log is not very helpful, as no clear indication of what "error 13"
> > means or how to address the issue.
> >
> > This commit restores evsel__open_strerror() to generate a readable error
> > message and print it out:

I'm applying this one, maybe we can at least suppress the one for dummy
when it is auto added?

- Arnaldo

> >   perf record -e cs_etm// -C 3 -- ls
> >   Error:
> >   Failure to open event 'cs_etm//' on PMU 'cs_etm' which will be removed.
> >   Access to performance monitoring and observability operations is limited.
> >   Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
> >   access to performance monitoring and observability operations for processes
> >   without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.
> >   More information can be found at 'Perf events and tool security' document:
> >   https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
> >   perf_event_paranoid setting is 1:
> >     -1: Allow use of (almost) all events by all users
> >         Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
> >   >= 0: Disallow raw and ftrace function tracepoint access
> >   >= 1: Disallow CPU event access
> >   >= 2: Disallow kernel profiling
> >   To make the adjusted perf_event_paranoid setting permanent preserve it
> >   in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)
> >   Error:
> >   Failure to open event 'dummy:u' on PMU 'software' which will be removed.
> >   Access to performance monitoring and observability operations is limited.
> >   Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
> >   access to performance monitoring and observability operations for processes
> >   without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.
> >   More information can be found at 'Perf events and tool security' document:
> >   https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
> >   perf_event_paranoid setting is 1:
> >     -1: Allow use of (almost) all events by all users
> >         Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
> >   >= 0: Disallow raw and ftrace function tracepoint access
> >   >= 1: Disallow CPU event access
> >   >= 2: Disallow kernel profiling
> >   To make the adjusted perf_event_paranoid setting permanent preserve it
> >   in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)
> >   Error:
> >   Failure to open any events for recording.
> >
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> 
> Lgtm and sorry for making things worse - I believe it was motivated by
> trying to avoid spammy warnings.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/builtin-record.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 2584d0d8bc820676da60bdf5f59d41371d85a93a..aa8dc3e18190dd7db1ed5e3c7673fde8d5785a26 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -1404,6 +1404,7 @@ static int record__open(struct record *rec)
> >                         }
> >  #endif
> >                         if (report_error || verbose > 0) {
> > +                               evsel__open_strerror(pos, &opts->target, errno, msg, sizeof(msg));
> >                                 ui__error("Failure to open event '%s' on PMU '%s' which will be "
> >                                           "removed.\n%s\n",
> >                                           evsel__name(pos), evsel__pmu_name(pos), msg);
> >
> > ---
> > base-commit: 5fd0a1df5d05ad066e5618ccdd3d0fa6cb686c27
> > change-id: 20260204-perf_improve_log_for_open_event_failures-deda2c61b93d
> >
> > Best regards,
> > --
> > Leo Yan <leo.yan@arm.com>
> >
