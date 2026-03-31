Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273F4253F13;
	Tue, 31 Mar 2026 07:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774940874; cv=none; b=ht2HSelyn2ls3MmY4qzgervqaKVKnMOWFdg4Q2AFnq1bVzo0P8mE6Rxz+S2P/DZ4/WdhUolXviwFHENvxtoHfatDISRTYHEbyGp0/qTYu5lvoDZWRzM/AVFiEcMGgnzYAceTmE9r2fCVRZhYetk6YmgtGE4pGGi6XRfdMHEL2wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774940874; c=relaxed/simple;
	bh=PvxKhH94gOvfE4j/2oXPW+Cxs7eqWGxGYtar2KEQj10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTp1rSTi9YqFpFLgtrKJ/4fs+kSMkceqrYC//E/orsFI9bLI5R4O4aCVmvLO4w1YAQTg3E/EBoCb9NDATJlC9VCWuo0SAcMjVndmlNAAkqsnFvIvB2Un8oRAHPmB3TyTeTDPFjXlOWO7ip8WgYBvf7vAnJdNyP560iaATwwk3ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/iBWgYy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/iBWgYy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D269C19423;
	Tue, 31 Mar 2026 07:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774940873;
	bh=PvxKhH94gOvfE4j/2oXPW+Cxs7eqWGxGYtar2KEQj10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e/iBWgYy6PAWg/QS3QY4c/Lnup1AH3qz+tM8VqiGjFQ8rc3Cjz0nRO4ErM4Nq0hVB
	 ZLgovSrIt98OJEYYRCVi30/X9e144no6+7XIXdogByQEYqvgtozLTQBDzjKNyuvTD+
	 05yEkq+y/Ze9nckIjjtUwQynJl8/vipHhFuFZyEQdrU1QFjEt3sNVyNhgL96Uf9oxR
	 LgaH9VKa2C6jjkxW75vtaYXCmdFzl7Gc+HU8kW3Mmri76WntrNxG6YTJ8cHlQaMQt/
	 CjC5dKn1Wrv7XAyjUf1vqY2L6sivILf60UPpk2DOwDt36Z8b2w6Mm8Xt3F7L1QwTjQ
	 L5oLiyJFC20uA==
Date: Tue, 31 Mar 2026 00:07:52 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: Re: [PATCH] perf trace: Skip unnecessary synthesis for summary-only
 mode
Message-ID: <actyyLHzGLK7jWkH@google.com>
References: <20260330201439.689899-1-namhyung@kernel.org>
 <CAP-5=fV0SKCOtYoJGUuui116wnbowZFcDu18tvrBQTiCF_5g3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV0SKCOtYoJGUuui116wnbowZFcDu18tvrBQTiCF_5g3w@mail.gmail.com>

On Mon, Mar 30, 2026 at 02:00:08PM -0700, Ian Rogers wrote:
> On Mon, Mar 30, 2026 at 1:14 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > It needs to synthesize task info for the comm name.  The mmap
> > information is only needed for callchain symbolization which is not used
> > by the summary mode.  Also total or cgroup summary mode don't require
> > the task info.  Let's skip the processing if possible.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-trace.c | 22 +++++++++++++++++-----
> >  1 file changed, 17 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index f487fbaa0ad60028..d09d78b3222717d1 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -2004,11 +2004,23 @@ static int trace__symbols_init(struct trace *trace, int argc, const char **argv,
> >         if (err < 0)
> >                 goto out;
> >
> > -       err = __machine__synthesize_threads(trace->host, &trace->tool, &trace->opts.target,
> > -                                           evlist->core.threads, trace__tool_process,
> > -                                           /*needs_mmap=*/callchain_param.enabled,
> > -                                           /*mmap_data=*/false,
> > -                                           /*nr_threads_synthesize=*/1);
> > +       if (trace->summary_only) {
> > +               if (trace->summary_mode == SUMMARY__BY_THREAD) {
> > +                       err = __machine__synthesize_threads(trace->host, &trace->tool,
> > +                                                           &trace->opts.target,
> > +                                                           evlist->core.threads,
> > +                                                           trace__tool_process,
> > +                                                           /*needs_mmap=*/false,
> > +                                                           /*mmap_data=*/false,
> > +                                                           /*nr_threads_synthesize=*/1);
> > +               }
> > +       } else {
> > +               err = __machine__synthesize_threads(trace->host, &trace->tool, &trace->opts.target,
> > +                                                   evlist->core.threads, trace__tool_process,
> > +                                                   /*needs_mmap=*/callchain_param.enabled,
> > +                                                   /*mmap_data=*/false,
> > +                                                   /*nr_threads_synthesize=*/1);
> > +       }
> 
> Could this be simplified to something like:
> ```
> if (!trace->summary_only || trace->summary_mode == SUMMARY__BY_THREAD) {
>        err = __machine__synthesize_threads(trace->host, &trace->tool,
> &trace->opts.target,
>                                            evlist->core.threads,
> trace__tool_process,
> 
> /*needs_mmap=*/callchain_param.enabled && !trace->summary_only,
>                                            /*mmap_data=*/false,
>                                            /*nr_threads_synthesize=*/1);
> }
> ```

Looks good, will update.

Btw, it'd be nice if you could find a mail client that can turn off the
line wrapping. :)

Thanks,
Namhyung

