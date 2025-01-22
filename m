Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F2B215798;
	Wed, 22 Jan 2025 19:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737572890; cv=none; b=DXTb3iJm1fWwN0NCgUZHs7cDaOuzQAo4nrt6VjSYKPctSPT/5NGqHeNZRXQjG4bg2ByK6MpfRTd9bB72lvWLdwYfyNM702hX3oKZmGcRpbhjQR8icELIH4UKPxC/9iYNrmzdqguUSrw2sUJrZmBm1/iPoXP9l7ozCljRK24VqoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737572890; c=relaxed/simple;
	bh=YQM2wOt+tXg/eaxTsi8ZA6SK7q0Ma7jK/eHW+A/fOBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbD/HP33lVUEJUfI2pTNmCQC8k/IIhCvHCpo9WIqtr16d2vLTdaSevA3emseE8/sUHzWRaRttbfMG3nP+JRqqareC+4Nl0NFBWPU2dI1L9trRVvwvkc1qIqG7QzRuiiT0XKGmh3li+czo18ggrdKtnwDJliJNTIE702gMV4LIUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGpoiK5P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGpoiK5P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175EBC4CED2;
	Wed, 22 Jan 2025 19:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737572890;
	bh=YQM2wOt+tXg/eaxTsi8ZA6SK7q0Ma7jK/eHW+A/fOBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HGpoiK5PEMHyIJZX7apJrSX10fIMnyCBpUC8mkwO8r9BclZlOcL59kzWZdSU4YpBC
	 4WdUkbKxXXrZxdPkGY9mZWk4bwSIgx+tfCLEE8WxiHPpyDijh8i5gRBmv7NUgjqbHf
	 juliir/P9bYV45sK/dnT07HcDmpgZetABmNs2w72IOk9X2fYggPD6yF4YzcxKxuj4H
	 byLE5A8msYS+KWy8m2jxMtRkDCpDGynGhsLqF/Tm2gGrOhnbttOlNvrJtj/JZxE2km
	 rmDJMjIm01DdQsIqf6iyy57eKQ1S4AG/f3CRphK7cLCQ3yukeeIOLbAf55gRN9BxWe
	 6FryUDxWIfopg==
Date: Wed, 22 Jan 2025 11:08:08 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Benjamin Peterson <benjamin@engflow.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf trace: Remove return value of
 trace__fprintf_tp_fields
Message-ID: <Z5FCGGBxBHD95zjT@google.com>
References: <20241212-void-fprintf_tp_fields-v1-1-b0c23fff4c54@engflow.com>
 <CAH0uvoi6=JmtX2xit9y7+NR5O+1S5zbxWpmLpbzC9+9nrkudHQ@mail.gmail.com>
 <CAH0uvohQvqRYo8JBX_Z1yVobqcxRgQG4G1Y8o8XMv18CnrqBbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvohQvqRYo8JBX_Z1yVobqcxRgQG4G1Y8o8XMv18CnrqBbA@mail.gmail.com>

Hello,

On Tue, Jan 21, 2025 at 07:01:53PM -0800, Howard Chu wrote:
> Hello fellow maintainers,
> 
> Just a slight ping.

Thanks for the reminder.

> 
> Thanks,
> Howard
> 
> On Fri, Dec 13, 2024 at 10:06 AM Howard Chu <howardchu95@gmail.com> wrote:
> >
> > Hello Benjamin,
> >
> > On Thu, Dec 12, 2024 at 7:56 PM Benjamin Peterson <benjamin@engflow.com> wrote:
> > >
> > > The return value of this function was meaningless and therefore ignored by
> > > the caller. Remove it.

In fact, I don't see the reason to merge this, as it's the convention to
return the number of characters it prints.  Yes, it's not used but not
much reason to remove it.

Thanks,
Namhyung

> > >
> > > Signed-off-by: Benjamin Peterson <benjamin@engflow.com>
> > > ---
> > > This is a small followup cleanup to my earlier commit 5fb8e56542a3 ("perf
> > > trace: avoid garbage when not printing a trace event's arguments").
> > > ---
> > >  tools/perf/builtin-trace.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > > index 6a1a128fe645014d0347ad4ec3e0c9e77ec59aee..246be66fd59a4b9d76e4d3c42b68d0a444ca366a 100644
> > > --- a/tools/perf/builtin-trace.c
> > > +++ b/tools/perf/builtin-trace.c
> > > @@ -3022,8 +3022,8 @@ static void bpf_output__fprintf(struct trace *trace,
> > >         ++trace->nr_events_printed;
> > >  }
> > >
> > > -static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel, struct perf_sample *sample,
> > > -                                      struct thread *thread, void *augmented_args, int augmented_args_size)
> > > +static void trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel, struct perf_sample *sample,
> > > +                                    struct thread *thread, void *augmented_args, int augmented_args_size)
> > >  {
> > >         char bf[2048];
> > >         size_t size = sizeof(bf);
> > > @@ -3088,7 +3088,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
> > >                 printed += syscall_arg_fmt__scnprintf_val(arg, bf + printed, size - printed, &syscall_arg, val);
> > >         }
> > >
> > > -       return printed + fprintf(trace->output, "%.*s", (int)printed, bf);
> > > +       fprintf(trace->output, "%.*s", (int)printed, bf);
> > >  }
> > >
> > >  static int trace__event_handler(struct trace *trace, struct evsel *evsel,
> > >
> > > ---
> > > base-commit: eefa7a9c069908412f8f5d15833901d1b46ae1b2
> > > change-id: 20241212-void-fprintf_tp_fields-8aaae2f5525f
> > >
> > > Best regards,
> > > --
> > > Benjamin Peterson <benjamin@engflow.com>
> > >
> > >
> >
> > Thank you for the follow-up patch, LGTM. Built and tested.
> >
> > perf $ ./perf test "perf trace"
> > 109: perf trace enum augmentation tests                              : Ok
> > 110: perf trace exit race                                            : Ok
> >
> > Reviewed-by: Howard Chu <howardchu95@gmail.com>
> >
> > Thanks,
> > Howard
