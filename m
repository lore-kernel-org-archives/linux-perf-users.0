Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFEE16F8EB;
	Fri,  1 Nov 2024 21:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730496643; cv=none; b=Xaiew2g7QNMhmmJmrsvPPDp8bGRbjPzfVVmSbsrxdsvAGBy0QASGgdn+Ur6Q/e15P4MBTRUbc/m2Bx8j9/KE8xSlIcEHVu9+HcAMRy3wB/VWIrVr0StbZBroa8+EwbDJDG26b+H415gStmufgqEivwTS/XJHBQxVRN2UsUiyGfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730496643; c=relaxed/simple;
	bh=zHcpDcHVFycn0Zup9LeBJ46NcGVuJOjUuesO/WUGV8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KO34Q4jru0L7r0zbr6yTb5sCDQVujgSAlnVsznAhYK8h0VKYk+6rXlCs74u1rJatpTYXfNv7AGMTxu/HtJHdj0rufBvo8ouQtCJS3tWcehDd9+kOJOcugN9rlpakomKop5WmwirLwjswfLVWTWh9PCw8IYzD8Y9LHQ3fSX485Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQa6/6cz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQa6/6cz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F79C4CECD;
	Fri,  1 Nov 2024 21:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730496643;
	bh=zHcpDcHVFycn0Zup9LeBJ46NcGVuJOjUuesO/WUGV8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XQa6/6czCdHSO+iPNuKeUpfDPoKq52MBfMn/0CS2dZzMdMIT9h5jQgisFyeLf44rX
	 fMnTL05Il8MTNppCJ4etNfoowfXazswEpQzvhYPbp23FNB6rS/cGFkI31drW67T3tr
	 IpQwXJp2JYmYnNt1hrPoIAEthd/sXZgyqFSpAtYvqPr6UBjt1MfJKgwFxnooVmL6YL
	 07FXbzzjFQfnGxtQGufVYpyYIZMc4hifqX5auUnmYH7lJ9VYKE987++jlOWz4dPXKD
	 SRnQLAXaj/1+pjJBwrgqOZAEM7QS7H+byJZgRJYtSifDIASdnLxXkJW84I0kRrso1n
	 En9AcmA/seIaA==
Date: Fri, 1 Nov 2024 18:30:40 -0300
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
Subject: Re: [PATCH v2] perf trace: avoid garbage when not printing a trace
 event's arguments
Message-ID: <ZyVIgKcAuqZSYYB1@x1>
References: <20241101005338.5846-1-benjamin@engflow.com>
 <20241101172714.84386-1-benjamin@engflow.com>
 <CAH0uvohNO517GAD7XH-VvUvU+dPdeZBKDw0Teij50sAPSe9sCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvohNO517GAD7XH-VvUvU+dPdeZBKDw0Teij50sAPSe9sCQ@mail.gmail.com>

On Fri, Nov 01, 2024 at 02:00:46PM -0700, Howard Chu wrote:
> Hello Benjamin,
> 
> Before your patch:
> 
> perf $ ./perf trace -e net:netif_rx_exit
>      0.000 irq/79-brcmf_p/1694977 net:netif_rx_exit(6n<)
>     28.153 irq/79-brcmf_p/1694977 net:netif_rx_exit(6n<)
>     36.429 irq/79-brcmf_p/1694977 net:netif_rx_exit(6n<)
>     36.461 irq/79-brcmf_p/1694977 net:netif_rx_exit(6n<)
> 
> After:
> 
> perf $ ./perf trace -e net:netif_rx_exit
>      0.000 irq/79-brcmf_p/1694977 net:netif_rx_exit()
>      7.352 irq/79-brcmf_p/1694977 net:netif_rx_exit()
>     30.232 irq/79-brcmf_p/1694977 net:netif_rx_exit()
>     37.529 irq/79-brcmf_p/1694977 net:netif_rx_exit()
> 
> It works beautifully, but I'm thinking can we simplify it by just doing:
> 
> +       char bf[2048] = { 0 };
>         size_t size = sizeof(bf);
> 
> That being said, trace__fprintf_tp_fields() should return void because
> currently its return value is not used by any other functions, plus
> this line:
> 
> return printed + fprintf(trace->output, "%s", bf);
> 
> in trace__fprintf_tp_fields() does not make much sense, since that
> will be 2 * printed. So I'm thinking maybe:
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 748b061f8678..8a628d1e80f3 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3021,10 +3021,10 @@ static void bpf_output__fprintf(struct trace *trace,
>         ++trace->nr_events_printed;
>  }
> 
> -static size_t trace__fprintf_tp_fields(struct trace *trace, struct
> evsel *evsel, struct perf_sample *sample,
> +static void trace__fprintf_tp_fields(struct trace *trace, struct
> evsel *evsel, struct perf_sample *sample,
>                                        struct thread *thread, void
> *augmented_args, int augmented_args_size)
>  {
> -       char bf[2048];
> +       char bf[2048] = { 0 };
>         size_t size = sizeof(bf);
>         struct tep_format_field *field = evsel->tp_format->format.fields;
>         struct syscall_arg_fmt *arg = __evsel__syscall_arg_fmt(evsel);
> @@ -3087,7 +3087,7 @@ static size_t trace__fprintf_tp_fields(struct
> trace *trace, struct evsel *evsel,
>                 printed += syscall_arg_fmt__scnprintf_val(arg, bf +
> printed, size - printed, &syscall_arg, val);
>         }
> 
> -       return printed + fprintf(trace->output, "%s", bf);
> +       fprintf(trace->output, "%s", bf);
>  }
> 
>  static int trace__event_handler(struct trace *trace, struct evsel *evsel,
> 
> 
> Then this will be one more diff line than yours.
> 
> But that's just my opinion, yours works just fine, thank you :).
> Arnaldo, what do you think?
> 
> Tested-by: Howard Chu <howardchu95@gmail.com>

I haven't tested it yet, just in my mind :-)

The patch looks ok and seems to fix a real problem, my only concern, a
pet peeve, was that it, in addition to fixing a real problem, did an
unrelated change, the "Remove the return value...", that part looks like
a distraction, something that shouldn't be there.

- Arnaldo
 
> Thanks,
> Howard
> 
> On Fri, Nov 1, 2024 at 10:27 AM Benjamin Peterson <benjamin@engflow.com> wrote:
> >
> > trace__fprintf_tp_fields may not print any tracepoint arguments. E.g., if the
> > argument values are all zero. Previously, this would result in a totally
> > uninitialized buffer being passed to fprintf, which could lead to garbage on the
> > console. Fix the problem by passing the number of initialized bytes fprintf.
> >
> > Remove the return value of trace__fprintf_tp_fields, since it was meaningless
> > and ignored.
> >
> > Fixes: f11b2803bb88 ("perf trace: Allow choosing how to augment the tracepoint arguments")
> > Signed-off-by: Benjamin Peterson <benjamin@engflow.com>
> > ---
> >  tools/perf/builtin-trace.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index d3f11b90d025..4e785ea29df6 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -3021,7 +3021,7 @@ static void bpf_output__fprintf(struct trace *trace,
> >         ++trace->nr_events_printed;
> >  }
> >
> > -static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel, struct perf_sample *sample,
> > +static void trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel, struct perf_sample *sample,
> >                                        struct thread *thread, void *augmented_args, int augmented_args_size)
> >  {
> >         char bf[2048];
> > @@ -3087,7 +3087,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
> >                 printed += syscall_arg_fmt__scnprintf_val(arg, bf + printed, size - printed, &syscall_arg, val);
> >         }
> >
> > -       return printed + fprintf(trace->output, "%s", bf);
> > +       fprintf(trace->output, "%.*s", (int)printed, bf);
> >  }
> >
> >  static int trace__event_handler(struct trace *trace, struct evsel *evsel,
> > --
> > 2.39.5
> >
