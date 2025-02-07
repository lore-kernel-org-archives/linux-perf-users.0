Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6E81DF25D
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 11:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738928542; cv=none; b=snX2sO+6ZMbrqtynGqAvY4RQB7p2ADa/A2hT3zTwg+8t/mmxORPtCSpz8/DZac0fiPAmtbH0uSz9hLhg12Wa58aM988O3TnEKu0ABkjJ7zYq/ldD/wcULYPEfYJcCuSJBj72lcHkhSXFTbYCThiO0D0SJTMg28WzOphZ7ZVbhrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738928542; c=relaxed/simple;
	bh=klwOF03lrs5WfgpLMCHzDkvspHlKzduFjJXTk1pvuwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZG5LyCQovEumGI+Xh+ti7QGj1w45vxQg7qMzYZcNWl8GKX8TdxcOH+9KlVWVWmPtal53ItPcbOoB5K10ygum3g9xOGQ8mDrnMZCW+o5J+qZIgyDx4b6+PjUcxVBHIUiyxEvHOFZDqq7QyTpZPOMhYJI8/C18IU4qiXs5spjsHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wFC5wsbU; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wFC5wsbU"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30613802a6bso21751281fa.1
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 03:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738928538; x=1739533338; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2gj3cqRMH8oEJS0PPwBCkwaddutVKDKmEi7zTls5x5g=;
        b=wFC5wsbUuXPr/p0kYOqPGndUVZYiB5+aTon7JaJNtGCMuN0GklTBTwL19AhbeePjni
         9JWvRXMSCSvUSpzRvUO7E+4pVZVgK+rJqTYcU1ICmQu365iiAwHFMXY8cKw2OWwb03Yb
         Ewqehus3rAtRXNY9QsaMh+Kh/ZKEOdAAYw+spDdsf9uW2XPy5DHEbMHSIlhF82XgZAa9
         CDmn++Nzps/VCXEWedNtpDai8V8G/PARmLB1LDE4iZ/ZGCqTHGnKQcfWpEiTuMs9WU3R
         cH6EP+XDloDIG+H8htNKsStv/ibG+UhCQddmuU3oiN65vd6H7pWTunAq3NXNgIr9Ffr8
         EnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738928538; x=1739533338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2gj3cqRMH8oEJS0PPwBCkwaddutVKDKmEi7zTls5x5g=;
        b=KMQB9g1Gp05RFQaMo/t3yxghPOUB2CAE9hkh2t4OZUDCxwLTdYt9doz0ubYM7VZ+M8
         ygefXGJu8O2aod+oYtfRnSH62lqYDObJkWu51RBz6jcWTbGQcCb6r97TJDOrb12kNgaC
         6Zw57woEQdRIO/YH3O1ntZSpCzDVuRPy+bTRXgDOu20O65MYJRQqL+eDnrHE0OMk6+xH
         OM/6jtP7kI+Cz2KHnPH4YWC0vRWqv6AXUnRvlUg4lXAXx4ONuZJ6VC3IfQsn0q3P4/pT
         94eaCpMXSJGaIJlALyqKjDgeR58mUktIxrBMHvIueerFKlQdOpncfVq3DJobkiEQA/Hb
         GPyw==
X-Forwarded-Encrypted: i=1; AJvYcCXaE162o2ztBnCEbUV1zhpvyt0MswhcDsYjt5grlYjUC151ZCt7nb1tSq5tbTaHOHet2YueMGVyr8br/2WL2LL/@vger.kernel.org
X-Gm-Message-State: AOJu0YyR9e75apFeTUjXWTex2idJRnJ0L6EnnEuGBZLUGBgE6dN+L/B9
	coWptffrWGrgi5Rq0UfESycNwdN09Sf9dTUk978GRoYyOLF25GciPj+Hz46DqC5O/nOZnnGI8NE
	BD+KgPkCmKdA9wOs3qLxNystZhbI0DdxhqX8r
X-Gm-Gg: ASbGnctNLQZeyrthAU/L6iPTNiPeM0nDL6uZyLlTkpUv1QA8RJ4jOTAxdrJ/sXz4OOH
	6h58FbibXMA/v4Rj6xRRANLRVNOaMQR2TTxPwsd33df9N2r57SFlj/4eP2fvWq+QCpyy1C06CqU
	0B5d6C4hh/5hnZHF0h9SppuV8Xt38=
X-Google-Smtp-Source: AGHT+IGFHU+CN4cItl1wzJ30Ez4MneuGaUaIS5CR/Ym/3wJ5p/73tbwANprWw+B8TuE3yzX/oSTjZjhz/uIP4GiNa/k=
X-Received: by 2002:a05:651c:1613:b0:300:1f12:bbc9 with SMTP id
 38308e7fff4ca-307e5a80f68mr11633481fa.34.1738928538087; Fri, 07 Feb 2025
 03:42:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738772628.git.dvyukov@google.com> <eb32b9b13856b0d508836b61b3e8377aef9163a3.1738772628.git.dvyukov@google.com>
 <Z6WDsmeVr7qPk0te@google.com>
In-Reply-To: <Z6WDsmeVr7qPk0te@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 7 Feb 2025 12:42:06 +0100
X-Gm-Features: AWEUYZnlDsvkjivC9zZ9T2cWpIcIDgBO6AtZZ9MOQ3v9j-G2dUtWDsnhG8Fwp8E
Message-ID: <CACT4Y+ZtFQdA+EkWfxkdt_6NU-u7BvARRuU6fZvxa+Kf_7g9SQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] perf report: Add --latency flag
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Feb 2025 at 04:53, Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Wed, Feb 05, 2025 at 05:27:45PM +0100, Dmitry Vyukov wrote:
> > Add record/report --latency flag that allows to capture and show
> > latency-centric profiles rather than the default CPU-consumption-centric
> > profiles. For latency profiles record captures context switch events,
> > and report shows Latency as the first column.
> >
> > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: linux-perf-users@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> >
> > ---
> [SNIP]
> > +void perf_hpp__cancel_latency(void)
> > +{
> > +     struct perf_hpp_fmt *fmt, *lat, *acc, *tmp;
> > +
> > +     if (is_strict_order(field_order) || is_strict_order(sort_order))
> > +             return;
>
> This also needs to be changed since you call setup_overhead even if you
> have a strict sort_order.
>
> For example, it's strange these two are different.
>
> With default sort order:
>
>   $ perf record --latency -- ls /
>
>   $ perf report --stdio
>   ...
>   # Overhead  Command  Shared Object         Symbol
>   # ........  .......  ....................  ........................
>   #
>       64.50%  ls       ld-linux-x86-64.so.2  [.] do_lookup_x
>       33.41%  ls       [kernel.kallsyms]     [k] chacha_block_generic
>        2.00%  perf-ex  [kernel.kallsyms]     [k] put_ctx
>        0.09%  perf-ex  [kernel.kallsyms]     [k] native_write_msr
>
> Same sort order, but explicitly:
>
>   $ perf report --stdio -s comm,dso,sym
>   ...
>   # Overhead   Latency  Command  Shared Object         Symbol
>   # ........  ........  .......  ....................  ........................
>   #
>       64.50%    64.50%  ls       ld-linux-x86-64.so.2  [.] do_lookup_x
>       33.41%    33.41%  ls       [kernel.kallsyms]     [k] chacha_block_generic
>        2.00%     2.00%  perf-ex  [kernel.kallsyms]     [k] put_ctx
>        0.09%     0.09%  perf-ex  [kernel.kallsyms]     [k] native_write_msr
>
> Maybe you want to cancel the latency field even if sort key is given
> (unless it has 'latency').
>
> Something like this?

Makes sense! Done in v6.

> ---8<---
> @@ -714,7 +715,9 @@ void perf_hpp__cancel_latency(void)
>  {
>         struct perf_hpp_fmt *fmt, *lat, *acc, *tmp;
>
> -       if (is_strict_order(field_order) || is_strict_order(sort_order))
> +       if (is_strict_order(field_order))
> +               return;
> +       if (is_strict_order(sort_order) && strstr(sort_order, "latency"))
>                 return;
>
>         lat = &perf_hpp__format[PERF_HPP__LATENCY];
> ---8<---
>
> Thanks,
> Namhyung
>
> > +
> > +     lat = &perf_hpp__format[PERF_HPP__LATENCY];
> > +     acc = &perf_hpp__format[PERF_HPP__LATENCY_ACC];
> > +
> > +     perf_hpp_list__for_each_format_safe(&perf_hpp_list, fmt, tmp) {
> > +             if (fmt_equal(lat, fmt) || fmt_equal(acc, fmt))
> > +                     perf_hpp__column_unregister(fmt);
> > +     }
> > +}
> > +
> >  void perf_hpp__setup_output_field(struct perf_hpp_list *list)
> >  {
> >       struct perf_hpp_fmt *fmt;
