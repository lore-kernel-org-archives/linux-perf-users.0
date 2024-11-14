Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FC418B484;
	Thu, 14 Nov 2024 21:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731618536; cv=none; b=MnBn/55kUi9CAqUjQmm993pROYj2MOJ3oxR3O3m5M+rH3NM7oAfHxeYRqEHqDcmyPBUQEzjEGm3EsnUtPaEXpqSdg6dWqF1t0N5nM5gU/m7Mw70ZmOFwEUmFYgDmU4uF9J0rR7JzYYRxw8T4f8SB9TEaMvGKvASNwC2CMJ4PcnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731618536; c=relaxed/simple;
	bh=Y4GUCrBLDz1kHxQJ9M6WHbtZ8cj+ZnE0LNxsSACppZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIQvodvkRo62n4pIeePE5Cuz3avy1NW0Ya3dd/5iSWsuVofC56euEHFG/j4c1Rb9C7K5bSSLYd0i33t7ovMLt1dE9M9b0gMEHJLwHDI78Uketv+K4L7XAPcPbYGM/5RIu5bA7Bm/a+EeyppLeHMvh0LAmGz1iknbtn80/fG8Wn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXc4qaOR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXc4qaOR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD931C4CECD;
	Thu, 14 Nov 2024 21:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731618536;
	bh=Y4GUCrBLDz1kHxQJ9M6WHbtZ8cj+ZnE0LNxsSACppZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pXc4qaOR+/he4+LzVI2wwFzmJKofilKPoRQI9LXdjCscLKZHCKVa8pjWPMs9CPAcw
	 Z//uap6u7rpE6sz96rkYqZBqNjPc3fGQJWdx1/+nqCn9xGyeU3bibBauLgk2VW0bd0
	 +WJB4EOJPOuk0/pyWQFO0aVchzwtkTAYTJLaECTUoHdJXyscQrjoPTSLiwTh6M232M
	 k+nhjWZoZuO7MHBYbuYR/LfVur5uA3RXx8EfKXwuUbOWvNqkvCEaO5dM0Ch23iwWv6
	 +yiF3lCfV1EBzasTQUR1VZWuWvfFAkNl0qmN5odsbC9q6y/GKPDwyyRE+ZKbw25VRA
	 45lyXJNn+MWpw==
Date: Thu, 14 Nov 2024 18:08:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Benjamin Peterson <benjamin@engflow.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] perf trace: avoid garbage when not printing a
 syscall's arguments
Message-ID: <ZzZm5XbY4ddalbWr@x1>
References: <20241107232128.108981-1-benjamin@engflow.com>
 <20241107232128.108981-2-benjamin@engflow.com>
 <CAH0uvojHH-wmbieqgtVyc7pGWQ0gyrzkWdtUkLpSyreub1uk_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvojHH-wmbieqgtVyc7pGWQ0gyrzkWdtUkLpSyreub1uk_Q@mail.gmail.com>

On Fri, Nov 08, 2024 at 08:21:30AM -0800, Howard Chu wrote:
> Hello,
> 
> This patch solves the garbage output problem I got, and your test can be run.

I'm taking this as a Tested-by you, ok?

- Arnaldo
 
> Thanks,
> Howard
> 
> On Thu, Nov 7, 2024 at 3:21 PM Benjamin Peterson <benjamin@engflow.com> wrote:
> >
> > syscall__scnprintf_args may not place anything in the output buffer
> > (e.g., because the arguments are all zero). If that happened in
> > trace__fprintf_sys_enter, its fprintf would receive an unitialized
> > buffer leading to garbage output.
> >
> > Fix the problem by passing the (possibly zero) bounds of the argument
> > buffer to the output fprintf.
> >
> > Fixes: a98392bb1e169 ("perf trace: Use beautifiers on syscalls:sys_enter_ handlers")
> > Signed-off-by: Benjamin Peterson <benjamin@engflow.com>
> > ---
> >  tools/perf/builtin-trace.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index f6179b13b8b4..28f61d10a2f8 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -2702,6 +2702,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
> >         char msg[1024];
> >         void *args, *augmented_args = NULL;
> >         int augmented_args_size;
> > +       size_t printed = 0;
> >
> >         if (sc == NULL)
> >                 return -1;
> > @@ -2717,8 +2718,8 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
> >
> >         args = perf_evsel__sc_tp_ptr(evsel, args, sample);
> >         augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls_args_size);
> > -       syscall__scnprintf_args(sc, msg, sizeof(msg), args, augmented_args, augmented_args_size, trace, thread);
> > -       fprintf(trace->output, "%s", msg);
> > +       printed += syscall__scnprintf_args(sc, msg, sizeof(msg), args, augmented_args, augmented_args_size, trace, thread);
> > +       fprintf(trace->output, "%.*s", (int)printed, msg);
> >         err = 0;
> >  out_put:
> >         thread__put(thread);
> > --
> > 2.39.5
> >
> >
