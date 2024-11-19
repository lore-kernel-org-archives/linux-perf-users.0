Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8301A29A
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 00:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731976604; cv=none; b=ElIxSjTP8A6vgEoQ4cMy330ULVX2Mgr1sEwuW/u+4Ep96j6dtvbjGZe/J34l44z/ebfLVeb/hSofR5mXyaNc/fxI160zsPZ0mHu+zPS3J41rV0T/4bsglvoX6dQIGAdnTSiU10ILbDZs6GLJVD29CahgL7S5KrMbMvIwGQDSCAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731976604; c=relaxed/simple;
	bh=xwyIYiHCRkz6pY8AqDYso3S3HF8ja1GFtdmQ7xyA+R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvJgeOhi9P30qHZMf0ue9ztscVK5/mtPmnRZHNaOyxr14gPJn4wmHPaX9dwJzb+JRxBLp4yWyPn6mIVBqRUIAHnun3ZCvWCVPcLXFHGtIvQ+CSysyG3tq4TjeFS2f2IfIAvOYUDx3X7ccsdj4ZELHqdgnVgx3dfwgxeTU+CStgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzLtp6zZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzLtp6zZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810AFC4CECC;
	Tue, 19 Nov 2024 00:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731976603;
	bh=xwyIYiHCRkz6pY8AqDYso3S3HF8ja1GFtdmQ7xyA+R8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IzLtp6zZJXJnEiADYSMz5NH7QaaSUHZUKMwygwyJ4GHpR0bBW1T1ugv6UiCnb7O8p
	 azck3XKDX6YSNxQvx4ybjBLk1MXN2meNGSOTzdfkiqZUahbTdQfNKQMyexZ+1clv+l
	 PmBM0Zui3cI6+jgM4gdtBh2Z161JtoXO9t1FMAMVNAqLVy8QW51FwWctRpJbBjzJam
	 Gj/uj6Bhc+53JaKyrEA9w1L71jzZvVhMOS9FrrXdWW/GMa8I9JPWl99ZF04pNmPXDh
	 eJjG4IxGpUwDHY+hqd7zqSE5YrofHui7khuudemxKpOt/Mc5o61071GzhW1F2LrabZ
	 NTMVlMhVQ20uA==
Date: Mon, 18 Nov 2024 16:36:42 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: David Alvarez <david.alvarez@bsc.es>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf: use C LC_NUMERIC locale for json output in perf
 stat
Message-ID: <Zzvdmne-nOz9LAS6@google.com>
References: <20241118184145.8829-1-david.alvarez@bsc.es>
 <CAP-5=fWf86BFpjvkUZ328o267afdsoXzZ3VgKwCF8gJUWntEKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWf86BFpjvkUZ328o267afdsoXzZ3VgKwCF8gJUWntEKg@mail.gmail.com>

On Mon, Nov 18, 2024 at 01:40:34PM -0800, Ian Rogers wrote:
> On Mon, Nov 18, 2024 at 10:45 AM David Alvarez <david.alvarez@bsc.es> wrote:
> >
> > When using perf stat, the tool will use the system locale to format
> > decimal values. This is incorrect for json output, since the user locale
> > may lead to incorrect json formatting (which requires a dot as decimal
> > separator). The following example is perf's output under a ca_ES.UTF-8
> > locale:
> >
> > {"interval" : 1.005100134, "counter-value" : "0,486755", "unit" : "Joules", "event" : "power/energy-pkg/", "event-runtime" : 100240331, "pcnt-running" : 100,00, "metric-value" : "0,000000", "metric-unit" : "(null)"}
> >
> > Solve this issue by setting the LC_NUMERIC locale to "C" when enabling
> > json output (after parsing arguments).
> >
> > Signed-off-by: David Alvarez <david.alvarez@bsc.es>
> 
> Thanks for the report but ugh, this is broken everywhere. For example,
> for CSV output the printf format is created here:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/stat-shadow.c#n199
> Before being used:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/stat-display.c#n417
> On BSD there is a locale specific printf with printf_l, but it looks
> to be missing with glibc and no doubt missing on all the obscure libcs
> the maintainers test with. Given this I think this is the right fix
> but wonder, should we just set the locale globally and not for json
> output?

+1.

This might break something but it looks like a proper fix.

Thanks,
Namhyung

> 
> We could also change tests like:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/shell/stat+json_output.sh
> to test both with the default and locales like ca_ES.UTF-8 (export
> LC_NUMERIC=...). We could test other forms of output like CSV
> similarly:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/shell/stat+csv_output.sh
> 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/builtin-stat.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 689a3d43c258..b9ebb06b254d 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -2840,6 +2840,15 @@ int cmd_stat(int argc, const char **argv)
> >         if (evlist__alloc_stats(&stat_config, evsel_list, interval))
> >                 goto out;
> >
> > +       /*
> > +        * For JSON output, we cannot use the user's numeric
> > +        * locale since decimal separators must be dots.
> > +        * Set the locale to "C" instead now that we've already parsed
> > +        * all of the arguments using the user's locale.
> > +        */
> > +       if (stat_config.json_output)
> > +               setlocale(LC_NUMERIC, "C");
> > +
> >         /*
> >          * Set sample_type to PERF_SAMPLE_IDENTIFIER, which should be harmless
> >          * while avoiding that older tools show confusing messages.
> > --
> > 2.47.0
> >
