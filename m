Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CCF194C67
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jan 2025 07:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738134788; cv=none; b=bDHvimlDRWI0smg3KDp4aSxVirn2zHjarQ+fTTW/twMSjfjt3w4vY8rKPdy0d7WUY/ECvttDbo0TGwwvcKbaoUpHJgjCEteXX+dGu7fN1/LO0ELjJ3OlEqUeYjkFnPW0s052yVjtS99YSlhf/93ZUo6eWVkfUffd/mcSQlrBv5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738134788; c=relaxed/simple;
	bh=p4fWACLqsFv60PVp8I+9w9vEgtlzlz0H+yq9eix6hKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mjlwgt4YNirPJMqER3hnvMfU8Mj3gnzwfXLclBc0txtFjqhxdBAu2ws9gRyt0l/gbOOn4oxV/DqtetfvpgLuCe+zcBfU/ofsCW36q+9N5rsaWg9BEWaIspoeie9yEk8+MoquTlXSLGU1sASWzQpeiNjkpH4A4S7f8X03xiBC9bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bng6sWHG; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bng6sWHG"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30036310158so54259941fa.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jan 2025 23:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738134783; x=1738739583; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=123ya/hFwYR98OKz8eHFIK7abKqgXMUC7dmnJ7IfpHk=;
        b=bng6sWHGZ/KIjlFMjJ0mmzNh8lsx+zTf3DHdvfcSXoswNOQ6c8ROP2YKttVPeep4gM
         oxpr96OTApvE9pNO1OLdYbw+NCQHQg7QRlA+RWbnBXt4Y/iBK6tCrQj/arh9n0Z8jD9z
         RNcT1nqKWoJ3yTvrUciwMv1Egxy7im6IPEtA5FaUsl3eXnYEOl03/XX971pCQLJoG2xO
         A9epTQcCPVc9wv+c47fFcR4/V6iPbUULSbiXG7KqgOwdabme9bAFdGZ9XpRaAknPtYsi
         CsKgrWBWDXy/v63dYh3lTn0OezAJcOnSOaZi6khljUREZbdqOKcNFFDZ37FLWFY+d6a1
         29zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738134783; x=1738739583;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=123ya/hFwYR98OKz8eHFIK7abKqgXMUC7dmnJ7IfpHk=;
        b=casfn9BmhQQlsjyR+W9B0n/es+fEtCk7qvRCEsDImnYjbb3mj2NY7G6WGzqOiHkHYJ
         3JXkPFyTDnJSGs/ICziXanQcv7rkHQR8fFstxjQglt9ocU8QP7bM2doMnkOPvY8mE79y
         I1sC9aVLqkhY6soVECt0qC6cRbgZ8TihCzeWQcYgYncCJUchTXFPJyvOSk01HjPzC6gt
         p2r+BsyZ5dtAjnkWTN317c6kYYeYqE0YCV42na3UD01A627Eg5p8vKIc63ypF3NlOrRA
         orfx9CeK6mt5BVE3zR8R4ROP+h6Go5b+gHC62WqoHHSCtUtEBvSPpkPPeRmYScBP7H6z
         Q1sw==
X-Forwarded-Encrypted: i=1; AJvYcCVIifKoRAAlQrvkHhOLANL0BTu0kKgyineQUKza7vPxR7AIAHIF2qNG7t3IBTZBV/uI13SU+vBF+zOaBRa21c7A@vger.kernel.org
X-Gm-Message-State: AOJu0YwTeABZrbe0hFOSwJruwYj1q8Frvo02JxYosZ827FrBsGMrQUPX
	m15d0Q2G4qOUnEAWV/TToCBYOxUOv4nFT6MvHrlnrh5MhI0jevw+w4SdMnzJMmISvd/m2RPoINA
	sbcSgtJmJQ1nLFKnfELbGYolPZtPQ9Q8CrZoExiTgZzekynlC7Jgg
X-Gm-Gg: ASbGncscYZMvllRJRty6ZNaum8KyDUxHDKjsRJtpVPTD/eG7m3u0nAOg4BR396tmCBo
	spy3DJCSgis2uYruOkzhreuig3hMGNLqldd6UVrcSnd0nFaZDJw/SGxxyBk/7mbS2jTpygp/08X
	5KfW39h8JCHL2opw28sFx7mLDETmHgrw==
X-Google-Smtp-Source: AGHT+IHPsp/s+HLr29zE+xJeZqLtVkrmPiqL16W/FRbEvEMEOg4Iy0bmqTrRfa6L5a7hIvrVsvY3LHLxx2J2RwefsRM=
X-Received: by 2002:a05:651c:b2a:b0:2ff:c86b:5b4f with SMTP id
 38308e7fff4ca-307968ef606mr7431291fa.21.1738134783104; Tue, 28 Jan 2025
 23:13:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1737971364.git.dvyukov@google.com> <70523ae7dd5d5c41d2d954324297d9d2cfad1b1f.1737971364.git.dvyukov@google.com>
 <Z5m2hdR3HZxIdhWR@google.com>
In-Reply-To: <Z5m2hdR3HZxIdhWR@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 29 Jan 2025 08:12:51 +0100
X-Gm-Features: AWEUYZnB1t8_KyebWXxaNUJERczxRRtsLIFSiPkdFoGz3jkwsvnzz6__i3OuDpQ
Message-ID: <CACT4Y+Z6KoYxY0AiC1eK=Ch9CQFuk7rWud_4GAMyjGdv+yemtQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] perf report: Add --latency flag
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Jan 2025 at 06:03, Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Mon, Jan 27, 2025 at 10:58:53AM +0100, Dmitry Vyukov wrote:
> > Add record/report --latency flag that allows to capture and show
> > latency-centric profiles rather than the default CPU-consumption-centric
> > profiles. For latency profiles record captures context switch events,
> > and report shows Latency as the first column.
>
> It'd be nice if you could add a small example output in the commit
> message.
>
> >
> > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: linux-perf-users@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> [SNIP]
> > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > index bc4c3acfe7552..2b6023de7a53a 100644
> > --- a/tools/perf/util/sort.c
> > +++ b/tools/perf/util/sort.c
> > @@ -2622,6 +2622,7 @@ struct hpp_dimension {
> >       const char              *name;
> >       struct perf_hpp_fmt     *fmt;
> >       int                     taken;
> > +     int                     was_taken;
> >  };
> >
> >  #define DIM(d, n) { .name = n, .fmt = &perf_hpp__format[d], }
> > @@ -3513,6 +3514,7 @@ static int __hpp_dimension__add(struct hpp_dimension *hd,
> >               return -1;
> >
> >       hd->taken = 1;
> > +     hd->was_taken = 1;
> >       perf_hpp_list__register_sort_field(list, fmt);
> >       return 0;
> >  }
> > @@ -3547,10 +3549,15 @@ static int __hpp_dimension__add_output(struct perf_hpp_list *list,
> >       return 0;
> >  }
> >
> > -int hpp_dimension__add_output(unsigned col)
> > +int hpp_dimension__add_output(unsigned col, bool implicit)
> >  {
> > +     struct hpp_dimension *hd;
> > +
> >       BUG_ON(col >= PERF_HPP__MAX_INDEX);
> > -     return __hpp_dimension__add_output(&perf_hpp_list, &hpp_sort_dimensions[col]);
> > +     hd = &hpp_sort_dimensions[col];
> > +     if (implicit && !hd->was_taken)
> > +             return 0;
>
> I don't understand why you need 'was_taken' field.  Can it use the
> 'taken' field?

I've started getting failed asserts in
perf_hpp__cancel_cumulate/latency when removing columns still linked
into sort order list.

I've figured out that columns we implicitly add in setup_overhead and
perf_hpp__init must match exactly. If we add one in setup_overhead,
but not in perf_hpp__init, then it starts failing.

Taken does not work b/c there is reset_dimensions call between these
functions, so they actually add the same columns twice to field/sort
lists (and that prevents failures in
perf_hpp__cancel_cumulate/latency).

Initially I've just tried to match logic in setup_overhead and in
perf_hpp__init. But it turned out quite messy, duplicate logic, and
e.g. in setup_overhead we look at sort_order, but in perf_hpp__init we
already can't look at it b/c we already altered it in setup_overhead.
That logic would also be quite fragile. Adding was_taken looks like
the simplest, most reliable, and less fragile with respect to future
changes approach.


> > +     return __hpp_dimension__add_output(&perf_hpp_list, hd);
> >  }
> >
> >  int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
> > @@ -3809,10 +3816,24 @@ static char *setup_overhead(char *keys)
> >       if (sort__mode == SORT_MODE__DIFF)
> >               return keys;
> >
> > -     keys = prefix_if_not_in("overhead", keys);
> > -
> > -     if (symbol_conf.cumulate_callchain)
> > -             keys = prefix_if_not_in("overhead_children", keys);
> > +     if (symbol_conf.prefer_latency) {
> > +             keys = prefix_if_not_in("overhead", keys);
> > +             keys = prefix_if_not_in("latency", keys);
> > +             if (symbol_conf.cumulate_callchain) {
> > +                     keys = prefix_if_not_in("overhead_children", keys);
> > +                     keys = prefix_if_not_in("latency_children", keys);
> > +             }
> > +     } else if (!keys || (!strstr(keys, "overhead") &&
> > +                     !strstr(keys, "latency"))) {
> > +             if (symbol_conf.enable_latency)
> > +                     keys = prefix_if_not_in("latency", keys);
> > +             keys = prefix_if_not_in("overhead", keys);
> > +             if (symbol_conf.cumulate_callchain) {
> > +                     if (symbol_conf.enable_latency)
> > +                             keys = prefix_if_not_in("latency_children", keys);
> > +                     keys = prefix_if_not_in("overhead_children", keys);
> > +             }
> > +     }
>
> Do you really need this complexity?  I think it's better to fix the order
> of columns in both case.

This is sort order which affects ordering of row, and order of rows is
basically the most important thing for a profiler. If we fix the
order, it will be showing completely different things.

"latency" and "overhead" are equivalent with respect to their
fundamentality for a profile. So we shouldn't be adding any of them,
if any of them are already explicitly specified by the user.

For example, the command from tips.txt:

perf report --hierarchy --sort latency,parallelism,comm,symbol

if we prepend "overhead", it all falls apart.

Or for 2 default modes (normals and latency) we want "overhead" or
"latency" to come first. Prepending "latency" for the current CPU mode
would lead to completely different ordering.



> Thanks,
> Namhyung
>
> >
> >       return keys;
> >  }
> > diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> > index 11fb15f914093..180d36a2bea35 100644
> > --- a/tools/perf/util/sort.h
> > +++ b/tools/perf/util/sort.h
> > @@ -141,7 +141,7 @@ int report_parse_ignore_callees_opt(const struct option *opt, const char *arg, i
> >
> >  bool is_strict_order(const char *order);
> >
> > -int hpp_dimension__add_output(unsigned col);
> > +int hpp_dimension__add_output(unsigned col, bool implicit);
> >  void reset_dimensions(void);
> >  int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
> >                       struct evlist *evlist,
> > diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
> > index c5b2e56127e22..cd9aa82c7d5ad 100644
> > --- a/tools/perf/util/symbol_conf.h
> > +++ b/tools/perf/util/symbol_conf.h
> > @@ -49,7 +49,9 @@ struct symbol_conf {
> >                       keep_exited_threads,
> >                       annotate_data_member,
> >                       annotate_data_sample,
> > -                     skip_empty;
> > +                     skip_empty,
> > +                     enable_latency,
> > +                     prefer_latency;
> >       const char      *vmlinux_name,
> >                       *kallsyms_name,
> >                       *source_prefix,
> > --
> > 2.48.1.262.g85cc9f2d1e-goog
> >
