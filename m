Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12267212B3B
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Feb 2025 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593929; cv=none; b=VACIZF027nCmWycwNf+fiyTfsSFDSsAgZzP11sGx1MYDwIVZFMYSzte+RQoXS5n0QnVAoeemVdXicQoeWY1DaCeS6CVNvoGVmtTJ+mc+3Slr/Z6xMRijbNmXL7jR4CzaKv7c3RvONBZwNUxAL8jqYTD/IJs8YoWnvT0VnwrwprE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593929; c=relaxed/simple;
	bh=OpxJMFnv/T1gzYLzng4N96zBL35qTrhkXO4t27HLNeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f54OE91WKrqQp4EEKStYKruUZxT8SrQawKJq/igsGgKt1t85MwLYMx0et8SWoJj/hsycr6yXxAASxy8hhK1FubWu6RUdvpbLNtREafQjiwwUzW1VD3yMsrMZVKOr9cscSLEVB02QuM5F3sxBaHyecMQ/tMQxiwDs+Pcd1clo9D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vVY3d/I0; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vVY3d/I0"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30225b2586cso52004491fa.0
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Feb 2025 06:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738593925; x=1739198725; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CgZWMbrsC8Ij7Hb0M5QH6HsBjmwyLIPOZpeHyhXcCxg=;
        b=vVY3d/I0GwjAAmSDLnS5UCFyxYNVcyE0FbOgswCCsKXenCbCaOuqxXhQ15w1f74c9R
         dn9obe3CZYI5/vM0NQXfHmz5XgOPbHoES+BCpebeIryU0JVxWe9NfJjwNXF3Y9cOxgB2
         /X5bdTUSugayAF+GY+p+PboAHSB+j4z3ZleQlOu/oKj001e5yGmqCrbV7mFCixV4N+iK
         sk9F6Qy+OwNwOjx8yP+gCV0q2BB/JXDJYqwgs1vaKlE/mN94ZGZgQWOyUvLHqM/ceu/a
         vFDBaQp3dbmjwQZ39k+griaajW0qHU7ADTDooXiQUffNpygfMgSh4OWTMk0TE/RLfHd7
         +RGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738593925; x=1739198725;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CgZWMbrsC8Ij7Hb0M5QH6HsBjmwyLIPOZpeHyhXcCxg=;
        b=pca89jtfAy4fti2TVSHLvNP+XdvCWk0P1CswFtEezvoygayysmHl0Hmu0LpguCPPrg
         LxqSiCx0+XdOuG34wmmReo2a0a9K0jNBOSgKATRHXCpzfM/TQFORnfsVP58eNEX+AMmA
         nUUUgWTJ8XtklNHq14ijDveAhN1mOx4ITXAjFCxWOxAyphBcWyfL3hWYcLaLk6/uVG5l
         4e+qslMthus0xJr5jQdxOS0ajfhDkPq6y6BHmvZ/0CL2ndY5OTfsMxl0JnWAlp7eRhGm
         8T+Xyl39OOZrrxr6ceVSUmd7BUYtziM0pu2Wp1iwqsx9JZBbfUh5otBWcv7F3Q11XzmS
         40Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUtDtErefoazXfonZlLB5ds+yw0tS8Zy46sXGP/JU8SN9AwtSMCRwaD4Uw7Ed9lY+SsxhrE06goy2rH3BCSW4ch@vger.kernel.org
X-Gm-Message-State: AOJu0YwW1K/rsardcESesfI3q2kXMKzZp/TxSaOw+tJtlyWAysUMwmDP
	xiJATc/Ko9+agge17lw1mweud6x0n6CUABiMuT+BtvrBXidDmkAn3XMr4yMJ/2wLwHY8DTcr8QU
	Sokb9x43vrJeJK6e22GaYRkle9Olw/5GJs+NW
X-Gm-Gg: ASbGncvePX4DIFND6ECR0MIidzpiTbxL5fD34KyK2vLVq0qVRTuU52vZijvZ1l0NOsK
	Dy7ZGCWnFo/PYaUETXc2QfaiKFYi1HBot2xETNcREwGf8B9B88LKdl7Nn78KeXunQqMs5Sg6CV+
	0+1Xqm/D6s16U+KaCT7o/lPJG8
X-Google-Smtp-Source: AGHT+IFdX20Dg79dKyo+FKKkKsITuCwGf69uB9vyO+Cx2mCC0SBMPBW7bLxT/A6zbwHn6Q/jEPB7m6Y2AjpSO0ySv00=
X-Received: by 2002:a2e:86d3:0:b0:306:10cd:7bbe with SMTP id
 38308e7fff4ca-307aa37d20cmr37648251fa.4.1738593924922; Mon, 03 Feb 2025
 06:45:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1737971364.git.dvyukov@google.com> <70523ae7dd5d5c41d2d954324297d9d2cfad1b1f.1737971364.git.dvyukov@google.com>
 <Z5m2hdR3HZxIdhWR@google.com> <CACT4Y+Z6KoYxY0AiC1eK=Ch9CQFuk7rWud_4GAMyjGdv+yemtQ@mail.gmail.com>
 <Z5sccIPaYBeB_yab@google.com>
In-Reply-To: <Z5sccIPaYBeB_yab@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 3 Feb 2025 15:45:13 +0100
X-Gm-Features: AWEUYZlCJLC2kCWpCd-EenFvSdwDDoS87usTiieBHkpVbB4VVnJRh8jqXqhYW10
Message-ID: <CACT4Y+ZREdDL7a+DMKGFGae1ZjX1C8uNRwCGF0c8iUJtTTq0Lw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] perf report: Add --latency flag
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Jan 2025 at 07:30, Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Wed, Jan 29, 2025 at 08:12:51AM +0100, Dmitry Vyukov wrote:
> > On Wed, 29 Jan 2025 at 06:03, Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > On Mon, Jan 27, 2025 at 10:58:53AM +0100, Dmitry Vyukov wrote:
> > > > Add record/report --latency flag that allows to capture and show
> > > > latency-centric profiles rather than the default CPU-consumption-centric
> > > > profiles. For latency profiles record captures context switch events,
> > > > and report shows Latency as the first column.
> > >
> > > It'd be nice if you could add a small example output in the commit
> > > message.
> > >
> > > >
> > > > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > Cc: Ian Rogers <irogers@google.com>
> > > > Cc: linux-perf-users@vger.kernel.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > ---
> > > [SNIP]
> > > > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > > > index bc4c3acfe7552..2b6023de7a53a 100644
> > > > --- a/tools/perf/util/sort.c
> > > > +++ b/tools/perf/util/sort.c
> > > > @@ -2622,6 +2622,7 @@ struct hpp_dimension {
> > > >       const char              *name;
> > > >       struct perf_hpp_fmt     *fmt;
> > > >       int                     taken;
> > > > +     int                     was_taken;
> > > >  };
> > > >
> > > >  #define DIM(d, n) { .name = n, .fmt = &perf_hpp__format[d], }
> > > > @@ -3513,6 +3514,7 @@ static int __hpp_dimension__add(struct hpp_dimension *hd,
> > > >               return -1;
> > > >
> > > >       hd->taken = 1;
> > > > +     hd->was_taken = 1;
> > > >       perf_hpp_list__register_sort_field(list, fmt);
> > > >       return 0;
> > > >  }
> > > > @@ -3547,10 +3549,15 @@ static int __hpp_dimension__add_output(struct perf_hpp_list *list,
> > > >       return 0;
> > > >  }
> > > >
> > > > -int hpp_dimension__add_output(unsigned col)
> > > > +int hpp_dimension__add_output(unsigned col, bool implicit)
> > > >  {
> > > > +     struct hpp_dimension *hd;
> > > > +
> > > >       BUG_ON(col >= PERF_HPP__MAX_INDEX);
> > > > -     return __hpp_dimension__add_output(&perf_hpp_list, &hpp_sort_dimensions[col]);
> > > > +     hd = &hpp_sort_dimensions[col];
> > > > +     if (implicit && !hd->was_taken)
> > > > +             return 0;
> > >
> > > I don't understand why you need 'was_taken' field.  Can it use the
> > > 'taken' field?
> >
> > I've started getting failed asserts in
> > perf_hpp__cancel_cumulate/latency when removing columns still linked
> > into sort order list.
>
> Ok.
>
> >
> > I've figured out that columns we implicitly add in setup_overhead and
> > perf_hpp__init must match exactly. If we add one in setup_overhead,
> > but not in perf_hpp__init, then it starts failing.
>
> Right, I don't remember why we don't have unregister_sort_field or let
> the perf_hpp__column_unregister() remove it from the sort_list too.
>
> >
> > Taken does not work b/c there is reset_dimensions call between these
> > functions, so they actually add the same columns twice to field/sort
> > lists (and that prevents failures in
> > perf_hpp__cancel_cumulate/latency).
>
> I see.
>
> >
> > Initially I've just tried to match logic in setup_overhead and in
> > perf_hpp__init. But it turned out quite messy, duplicate logic, and
> > e.g. in setup_overhead we look at sort_order, but in perf_hpp__init we
> > already can't look at it b/c we already altered it in setup_overhead.
> > That logic would also be quite fragile. Adding was_taken looks like
> > the simplest, most reliable, and less fragile with respect to future
> > changes approach.
>
> Maybe just remove it from the sort_list.  There should be no reason to
> keep it in the list.

I've tried that (and removing setup_overhead entirely), but none of
that yielded the same result.

E.g.:

perf report --sort latency,symbol

currently gives intended:

 Latency  Symbol
   4.37%  [k] native_queued_spin_lock_slowpath
   2.71%  [.] _PyEval_EvalFrameDefault
   2.18%  [.] iterative_hash
   2.00%  [k] clear_page_erms

but if I remove was_taken logic and make perf_hpp__column_unregister()
remove from the sort list, I get:

Overhead   Latency  Symbol
  38.17%     4.37%  [k] native_queued_spin_lock_slowpath
   0.86%     2.71%  [.] _PyEval_EvalFrameDefault
   0.47%     2.18%  [.] iterative_hash
   0.68%     2.00%  [k] clear_page_erms

So, so far the current version of the code is unfortunately the
simplest version with intended behavior that I come up with.



> > > > +     return __hpp_dimension__add_output(&perf_hpp_list, hd);
> > > >  }
> > > >
> > > >  int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
> > > > @@ -3809,10 +3816,24 @@ static char *setup_overhead(char *keys)
> > > >       if (sort__mode == SORT_MODE__DIFF)
> > > >               return keys;
> > > >
> > > > -     keys = prefix_if_not_in("overhead", keys);
> > > > -
> > > > -     if (symbol_conf.cumulate_callchain)
> > > > -             keys = prefix_if_not_in("overhead_children", keys);
> > > > +     if (symbol_conf.prefer_latency) {
> > > > +             keys = prefix_if_not_in("overhead", keys);
> > > > +             keys = prefix_if_not_in("latency", keys);
> > > > +             if (symbol_conf.cumulate_callchain) {
> > > > +                     keys = prefix_if_not_in("overhead_children", keys);
> > > > +                     keys = prefix_if_not_in("latency_children", keys);
> > > > +             }
> > > > +     } else if (!keys || (!strstr(keys, "overhead") &&
> > > > +                     !strstr(keys, "latency"))) {
> > > > +             if (symbol_conf.enable_latency)
> > > > +                     keys = prefix_if_not_in("latency", keys);
> > > > +             keys = prefix_if_not_in("overhead", keys);
> > > > +             if (symbol_conf.cumulate_callchain) {
> > > > +                     if (symbol_conf.enable_latency)
> > > > +                             keys = prefix_if_not_in("latency_children", keys);
> > > > +                     keys = prefix_if_not_in("overhead_children", keys);
> > > > +             }
> > > > +     }
> > >
> > > Do you really need this complexity?  I think it's better to fix the order
> > > of columns in both case.
> >
> > This is sort order which affects ordering of row, and order of rows is
> > basically the most important thing for a profiler. If we fix the
> > order, it will be showing completely different things.
> >
> > "latency" and "overhead" are equivalent with respect to their
> > fundamentality for a profile. So we shouldn't be adding any of them,
> > if any of them are already explicitly specified by the user.
> >
> > For example, the command from tips.txt:
> >
> > perf report --hierarchy --sort latency,parallelism,comm,symbol
> >
> > if we prepend "overhead", it all falls apart.
> >
> > Or for 2 default modes (normals and latency) we want "overhead" or
> > "latency" to come first. Prepending "latency" for the current CPU mode
> > would lead to completely different ordering.
>
> I see.  You want to sort by overhead in the default mode even if it has
> implicitly-added latency field, and to sort by latency if --latency is
> given explicitly.
>
> I think it can be done with the following command line.
>
>   $ perf report -F overhead,latency,parallelism,comm,sym -s overhead
>
> or
>
>   $ perf report -F overhead,latency,parallelism,comm,sym -s latency
>
> IOW, you can keep the same output column ordering and sort the result
> differently.  But I'm not sure if it'd make the code simpler. :)
>
> Thanks,
> Namhyung
>
