Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A0C2F1FC7;
	Thu, 18 Jun 2026 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781800126; cv=none; b=KYODvhrNX//u5c65zsvRj6teA5e0MMvk9mne/VcfKyk77LZoOqGVE5rJVi2QROXb1UMZc+cq39xS/sv08Quu8Ej5VlO8uTzWe/xQd8ldXzBm2wy0syem93EU+iZjz2ZoAteHZkc+d7kmJYGfeAWnmPciY7Mzo7nHqWaTfu9hZho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781800126; c=relaxed/simple;
	bh=E5HAizW64IFFlpUPvCs/aM5Cgn6ks6/CU0Q7zjirHfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WeFgV2DWYX99+RUkHfh1q8s3DHeZdB0pknfPaD0O5jPS3DvcrgbtFrYDouzl9XYfaEouwJxfNt6Icss1yZKef+YO2AZhaeH/KFM5Z1ofsR9kSW2YSsMl18C1/cZGcIk54Id+alK+jNvazlFxsK2I77dZsTrCGf2j2EXEeevPvRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUhd0abT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUhd0abT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A741F000E9;
	Thu, 18 Jun 2026 16:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781800125;
	bh=yfYxaGW6jn2uGZ+2EoY6Tvfw3kF3jHEtiBL1eoULZgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bUhd0abTvfAvK6PvAy35qM4ki0TISpbGaNby8/76Y/uDM5dTJd7LSyh0GPMbiAJOB
	 9YYzNaOfazekUfe4w5sD/L+NGmmQLKIRAKqEdXVxpppdDxF12Xnv+Mh8VC5jj+aLvW
	 i6TkV6pKsYEEXoHtZLhppnSYzOovUO8AArhl+G3odviXbsCTfjM6pd+f9bX38ZR0as
	 +647c/QFlRsgqquXY5UbtL2ErERe1Zpz9Y+l5Z0AKFbFpMRH7IAAEuzHSD0NunsZpD
	 8NotyFV7bAqDz3dl93Is/++YDm69U08Csm+wP+HQtgEsMGItflWxpoWHOsFS0qI4Xd
	 2QBIEPRmHK9IQ==
Date: Thu, 18 Jun 2026 09:28:42 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Aaron Tomlin <atomlin@atomlin.com>
Subject: Re: [PATCHES v3 0/2] perf tools: Add cached probe type detection for
 evsel
Message-ID: <ajQcukDCbMgjLA7b@google.com>
References: <20260616182546.8892-1-acme@kernel.org>
 <ajMkLzJpXzyeqQh4@google.com>
 <ajPzhxj3KEF7jOTE@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ajPzhxj3KEF7jOTE@x1>

On Thu, Jun 18, 2026 at 10:32:55AM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Jun 17, 2026 at 03:48:15PM -0700, Namhyung Kim wrote:
> > On Tue, Jun 16, 2026 at 03:25:44PM -0300, Arnaldo Carvalho de Melo wrote:
> > > 
> > > Arnaldo Carvalho de Melo (3):
> > >   perf evsel: Add lazy-initialized probe type detection helpers
> > >   perf trace: Guard __probe_ip suppression with evsel__is_probe()
> > >   perf evsel: Add no-libtraceevent stubs for evsel__field() and evsel__common_field()
> > 
> > It seems you squashed patch 3 into 1. :)
> 
> Yeah, I noticed and fixed it up before pushing publicly:
> 
> acme@x1:~/git/perf-tools-next$ git log --oneline 27dc372c83d90ccbb19107a2acffe01d6a076a53^.. | tail -3
> 846f367ff02226e7 perf trace: Guard __probe_ip suppression with evsel__is_probe()
> fbb5e6e3ca28a325 perf evsel: Add lazy-initialized probe type detection helpers
> 27dc372c83d90ccb perf evsel: Add no-libtraceevent stubs for evsel__field() and evsel__common_field()
> acme@x1:~/git/perf-tools-next$

Thanks, looks good to me.  For the series,

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
> acme@x1:~/git/perf-tools-next$ git show 27dc372c83d90ccb
> commit 27dc372c83d90ccbb19107a2acffe01d6a076a53
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Tue Jun 16 16:37:09 2026 -0300
> 
>     perf evsel: Add no-libtraceevent stubs for evsel__field() and evsel__common_field()
> 
>     When building without libtraceevent (NO_LIBTRACEEVENT=1), evsel__field()
>     and evsel__common_field() are declared but never defined, causing link
>     errors in any code path that references them.
> 
>     Add inline stubs that return NULL when HAVE_LIBTRACEEVENT is not defined,
>     matching the pattern used by other evsel accessor functions.
> 
>     Cc: Aaron Tomlin <atomlin@atomlin.com>
>     Assisted-by: Claude:claude-opus-4.6
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 8009be22cc3f1055..b959d4797b14035d 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -397,8 +397,22 @@ struct tep_format_field;
> 
>  u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sample, bool needs_swap);
> 
> +#ifdef HAVE_LIBTRACEEVENT
>  struct tep_format_field *evsel__field(struct evsel *evsel, const char *name);
>  struct tep_format_field *evsel__common_field(struct evsel *evsel, const char *name);
> +#else
> +static inline struct tep_format_field *
> +evsel__field(struct evsel *evsel __maybe_unused, const char *name __maybe_unused)
> +{
> +       return NULL;
> +}
> +
> +static inline struct tep_format_field *
> +evsel__common_field(struct evsel *evsel __maybe_unused, const char *name __maybe_unused)
> +{
> +       return NULL;
> +}
> +#endif
> 
>  bool __evsel__match(const struct evsel *evsel, u32 type, u64 config);
> 
> acme@x1:~/git/perf-tools-next$
> 
> acme@x1:~/git/perf-tools-next$ git show 846f367ff02226e7
> commit 846f367ff02226e7089181d2adae45a6cca4a3e6 (number/perf/evsel-probe-type)
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Mon Jun 15 22:17:41 2026 -0300
> 
>     perf trace: Guard __probe_ip suppression with evsel__is_probe()
> 
>     trace__fprintf_tp_fields() compares every field name against
>     "__probe_ip" for all tracepoint events, but this field is only
>     implicitly added by the Ftrace subsystem to bare dynamic probes.
> 
>     Add an evsel__is_probe() check before the strcmp so the string
>     comparison is skipped entirely for non-probe events.
> 
>     Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
>     Assisted-by: Claude:claude-opus-4.6
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index a8492da23a9cc178..57f3f14c5d435805 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3267,7 +3267,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *
>                  * If verbose mode is enabled, ensure it is formatted as a
>                  * hexadecimal memory address rather than a signed integer.
>                  */
> -               if (!strcmp(field->name, "__probe_ip")) {
> +               if (evsel__is_probe(evsel) && !strcmp(field->name, "__probe_ip")) {
>                         if (!verbose)
>                                 continue;
> 
> acme@x1:~/git/perf-tools-next$
