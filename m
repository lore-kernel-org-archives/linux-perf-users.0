Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFB5145B24;
	Thu, 30 Jan 2025 06:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738218610; cv=none; b=pei0WUh0IGXfYUmktbsmlegbTjTjF8cyGjXcumYL/7zaAKbkZaDjJBZ9jxUmJJMkLn1ZT0OoIkVymP4c56p5nJNC4eIfVPBJcT5edum0wreVE2aqdBVARpTF7oDXSwDUqxvQeW6eXhnf3YtYGNSdJZ8eFmQ/POgMe0zLUvJitEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738218610; c=relaxed/simple;
	bh=sVkmUUPh4YLSPorZuqJX284KUinJpLgBrTR6CpJDNsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g70HcR7Kil8VJsv/9BRzCuVGzCPF0CHrVKdpnJUteLUWzqZ4XZ4pjpDsuE2VjSX4b+h4MWzFiAdgJvS5ZhKyOE0D1n+2MtUfFRYr3QIc4IffFekdCvmhgs8F7bSIAQQkkY7fx4mB6xl6clwc8YLMHiVUOuP2B3jBXx0QuITnSwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6cBWVOC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6cBWVOC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00CEC4CED2;
	Thu, 30 Jan 2025 06:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738218609;
	bh=sVkmUUPh4YLSPorZuqJX284KUinJpLgBrTR6CpJDNsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c6cBWVOCRHsdDwCsmKvQUfDXErr/YDNAeqfgEBD/CUMI4aA/qUSkIDhrS2+iDqM8N
	 T6Ee580cCzy5dIDFFC0F4diBziXau08LZYNcfT2gOf39BI7L7/woBlxjmeCgde+kwl
	 VW4olio1SjZz/dXx3M5bNKU1tH7kBstVOXj1IdXhXvmnkM02tHzk1Sll+bfw8XJkQ7
	 f3vbQi8yKMX+c08o+1TLfHi8fpUKRlHRryuaCgSKUB9wBs1J8GqYpLfIPl6Q4/J/5P
	 hnY92PawlXUHL5JPOQM1gzUl+ROCKFdvAcwEkSyyhGazIepZALQzmyKGwIqWFa2z6m
	 NqU7X7vCoILbA==
Date: Wed, 29 Jan 2025 22:30:08 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3 6/7] perf report: Add --latency flag
Message-ID: <Z5sccIPaYBeB_yab@google.com>
References: <cover.1737971364.git.dvyukov@google.com>
 <70523ae7dd5d5c41d2d954324297d9d2cfad1b1f.1737971364.git.dvyukov@google.com>
 <Z5m2hdR3HZxIdhWR@google.com>
 <CACT4Y+Z6KoYxY0AiC1eK=Ch9CQFuk7rWud_4GAMyjGdv+yemtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+Z6KoYxY0AiC1eK=Ch9CQFuk7rWud_4GAMyjGdv+yemtQ@mail.gmail.com>

On Wed, Jan 29, 2025 at 08:12:51AM +0100, Dmitry Vyukov wrote:
> On Wed, 29 Jan 2025 at 06:03, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Jan 27, 2025 at 10:58:53AM +0100, Dmitry Vyukov wrote:
> > > Add record/report --latency flag that allows to capture and show
> > > latency-centric profiles rather than the default CPU-consumption-centric
> > > profiles. For latency profiles record captures context switch events,
> > > and report shows Latency as the first column.
> >
> > It'd be nice if you could add a small example output in the commit
> > message.
> >
> > >
> > > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > Cc: Ian Rogers <irogers@google.com>
> > > Cc: linux-perf-users@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > ---
> > [SNIP]
> > > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > > index bc4c3acfe7552..2b6023de7a53a 100644
> > > --- a/tools/perf/util/sort.c
> > > +++ b/tools/perf/util/sort.c
> > > @@ -2622,6 +2622,7 @@ struct hpp_dimension {
> > >       const char              *name;
> > >       struct perf_hpp_fmt     *fmt;
> > >       int                     taken;
> > > +     int                     was_taken;
> > >  };
> > >
> > >  #define DIM(d, n) { .name = n, .fmt = &perf_hpp__format[d], }
> > > @@ -3513,6 +3514,7 @@ static int __hpp_dimension__add(struct hpp_dimension *hd,
> > >               return -1;
> > >
> > >       hd->taken = 1;
> > > +     hd->was_taken = 1;
> > >       perf_hpp_list__register_sort_field(list, fmt);
> > >       return 0;
> > >  }
> > > @@ -3547,10 +3549,15 @@ static int __hpp_dimension__add_output(struct perf_hpp_list *list,
> > >       return 0;
> > >  }
> > >
> > > -int hpp_dimension__add_output(unsigned col)
> > > +int hpp_dimension__add_output(unsigned col, bool implicit)
> > >  {
> > > +     struct hpp_dimension *hd;
> > > +
> > >       BUG_ON(col >= PERF_HPP__MAX_INDEX);
> > > -     return __hpp_dimension__add_output(&perf_hpp_list, &hpp_sort_dimensions[col]);
> > > +     hd = &hpp_sort_dimensions[col];
> > > +     if (implicit && !hd->was_taken)
> > > +             return 0;
> >
> > I don't understand why you need 'was_taken' field.  Can it use the
> > 'taken' field?
> 
> I've started getting failed asserts in
> perf_hpp__cancel_cumulate/latency when removing columns still linked
> into sort order list.

Ok.

> 
> I've figured out that columns we implicitly add in setup_overhead and
> perf_hpp__init must match exactly. If we add one in setup_overhead,
> but not in perf_hpp__init, then it starts failing.

Right, I don't remember why we don't have unregister_sort_field or let
the perf_hpp__column_unregister() remove it from the sort_list too.

> 
> Taken does not work b/c there is reset_dimensions call between these
> functions, so they actually add the same columns twice to field/sort
> lists (and that prevents failures in
> perf_hpp__cancel_cumulate/latency).

I see.

> 
> Initially I've just tried to match logic in setup_overhead and in
> perf_hpp__init. But it turned out quite messy, duplicate logic, and
> e.g. in setup_overhead we look at sort_order, but in perf_hpp__init we
> already can't look at it b/c we already altered it in setup_overhead.
> That logic would also be quite fragile. Adding was_taken looks like
> the simplest, most reliable, and less fragile with respect to future
> changes approach.

Maybe just remove it from the sort_list.  There should be no reason to
keep it in the list.

> 
> 
> > > +     return __hpp_dimension__add_output(&perf_hpp_list, hd);
> > >  }
> > >
> > >  int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
> > > @@ -3809,10 +3816,24 @@ static char *setup_overhead(char *keys)
> > >       if (sort__mode == SORT_MODE__DIFF)
> > >               return keys;
> > >
> > > -     keys = prefix_if_not_in("overhead", keys);
> > > -
> > > -     if (symbol_conf.cumulate_callchain)
> > > -             keys = prefix_if_not_in("overhead_children", keys);
> > > +     if (symbol_conf.prefer_latency) {
> > > +             keys = prefix_if_not_in("overhead", keys);
> > > +             keys = prefix_if_not_in("latency", keys);
> > > +             if (symbol_conf.cumulate_callchain) {
> > > +                     keys = prefix_if_not_in("overhead_children", keys);
> > > +                     keys = prefix_if_not_in("latency_children", keys);
> > > +             }
> > > +     } else if (!keys || (!strstr(keys, "overhead") &&
> > > +                     !strstr(keys, "latency"))) {
> > > +             if (symbol_conf.enable_latency)
> > > +                     keys = prefix_if_not_in("latency", keys);
> > > +             keys = prefix_if_not_in("overhead", keys);
> > > +             if (symbol_conf.cumulate_callchain) {
> > > +                     if (symbol_conf.enable_latency)
> > > +                             keys = prefix_if_not_in("latency_children", keys);
> > > +                     keys = prefix_if_not_in("overhead_children", keys);
> > > +             }
> > > +     }
> >
> > Do you really need this complexity?  I think it's better to fix the order
> > of columns in both case.
> 
> This is sort order which affects ordering of row, and order of rows is
> basically the most important thing for a profiler. If we fix the
> order, it will be showing completely different things.
> 
> "latency" and "overhead" are equivalent with respect to their
> fundamentality for a profile. So we shouldn't be adding any of them,
> if any of them are already explicitly specified by the user.
> 
> For example, the command from tips.txt:
> 
> perf report --hierarchy --sort latency,parallelism,comm,symbol
> 
> if we prepend "overhead", it all falls apart.
> 
> Or for 2 default modes (normals and latency) we want "overhead" or
> "latency" to come first. Prepending "latency" for the current CPU mode
> would lead to completely different ordering.

I see.  You want to sort by overhead in the default mode even if it has
implicitly-added latency field, and to sort by latency if --latency is
given explicitly.

I think it can be done with the following command line.

  $ perf report -F overhead,latency,parallelism,comm,sym -s overhead

or

  $ perf report -F overhead,latency,parallelism,comm,sym -s latency

IOW, you can keep the same output column ordering and sort the result
differently.  But I'm not sure if it'd make the code simpler. :)

Thanks,
Namhyung

