Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5578020D51C
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736514010; cv=none; b=KApMfGi46QVaGy2on3MmN5FOv+kxyBMevGNuJ6lmjlx5HDQVhWnQSqSINZD7D/P6cK7uQbQL48JoF9+ZotrUzOwQglaGlcMV9HXp7FsYppSelAo++XC2vmL0gcTMzBGWMz9Gxq0Q7q3jEmRrnPqlGGKNOOM8Msd3kAhiR0FAigI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736514010; c=relaxed/simple;
	bh=BBOMQEwO4lHZrqhgmqKrdxa1Avbgz9XW109w5tul5+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dixEg8jknfvOtP5JrQyrQafkmxuYJzVqoNKHBAOX8B31vj+hFYAonDZnfa6oaYkj17JUBFo8iu78Vq+7lcGXT5FAZ3hZGU0qGm0MTlKwzhat797P0Na38mmEfVIVgRFYM+Lf5+XO/92CDLHDpxal1R/nQGpy0uTD+E+A6ot/NNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EZXaxerb; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EZXaxerb"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-304d760f118so14163911fa.0
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 05:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736514006; x=1737118806; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G4p1relGUMyIzXuzLvWRXXGYj0FGG01Tdcew1wLT3iM=;
        b=EZXaxerbcXw+x3w4FoyXaxlVBnY43Q1TtKupmjG7V7x8ZEBOM063u29VgEnI1u8+OP
         BTxZlNunGWz8qAytSTVFTOFmeWRuROeWRvcaINjWxKPUm/iMUo/h6pbjAe+BOSanKhFL
         BOeQN9SMYK09W0La/bYWp78QQZsZWLzVdeg8VdDhRbxZ1kqIrjGux0mxFyiDGCY6Ly5K
         1/nB5e5kUjXhS2qI9S+/1wveG2xxF0h4oju8QSOBhq7B/WNiS6wPO852nz/8Ik8FRb3M
         Qu/2btPNSxecvr9lptBo9BxKeVa8dWqx/wXC3ii0k5JcHPre4FMjhhfUf8ieNyKiQ/IQ
         B+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736514006; x=1737118806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G4p1relGUMyIzXuzLvWRXXGYj0FGG01Tdcew1wLT3iM=;
        b=swNXmeiZYU+JeMKYilw7GBlRNhUMXYxQi1h+LYkEGRLUiBfyJhIAl6XXps+FfQ0bjt
         Be9XyOBifQGuWdpHuqtbbJk1q2CS9GyyENZBjKnOvqpznj645eol6776tW1Iaezw+9Ga
         SRDKKTK5qHgnmqBTchmubXqEHwSLTXWMW55pYYC1w9205rAq/d/9zilWgUlKnBqusxy9
         vQLJzF5OZnuT8gCGp7XSZ4tKqI/MJrhaS8JoiiMVVvwUlmRot8+/OxeCrdvz7fAL3Tjp
         XenZRGZ1EqKMEbWqHVtcCfQ53T9wq4kv3Ckw1ZdOIJQkq5W+RmrVDeQvkSvDOreQ02Ny
         znEw==
X-Forwarded-Encrypted: i=1; AJvYcCXz3TtkLeBRyImP+fIoGWrSBH9hHQQe2YAxhX/HVs7PY6Af7nLam9/rv/G9mHufpFMJEUi7pnLwLkpwEkOqaZgM@vger.kernel.org
X-Gm-Message-State: AOJu0YyTMiGCbazceDG7pVwkZJ9qAWynTEyq1SqdRWsjJq7zLgT7wic3
	FgxYTCIHaEximdpnlD6KpSMTBZ1SKJYM8rUUXAtpG/Fi7lRvKhP1rWHgiNOyP17QXO03wh5c5Qn
	YhE66mNPz/y7NM9dJDkWp4nBV42fqsDUpijG7
X-Gm-Gg: ASbGncv4qcz5SthAjzSHlsnLfUfjFSO1rRHMPUGQsnwGSVz3yt5iPYRwCBve2nYH5ff
	Of/AsYmT1MJ+ciI1Vhs9fVcq5+oGGWfjbpbN/iyI6SGwzGrItEcBOUxWmIQ168UQpdk8BrNg=
X-Google-Smtp-Source: AGHT+IEQEs9ZKuj6m3nVToPGYb6X4fyepwmkCstUWnuY/cOyHonuv3ovKDtXnRWPNSQh8Ifb7vv38eDHXlayz6aiEMo=
X-Received: by 2002:a2e:bb8e:0:b0:2ff:56a6:2992 with SMTP id
 38308e7fff4ca-305f45fe704mr23512951fa.37.1736514006011; Fri, 10 Jan 2025
 05:00:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1736321686.git.dvyukov@google.com> <177603055d58e3d82e38f236f3be9fa52dc2d2c5.1736321686.git.dvyukov@google.com>
 <Z4BGuYG-V9H4wk9i@google.com>
In-Reply-To: <Z4BGuYG-V9H4wk9i@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 10 Jan 2025 13:59:54 +0100
X-Gm-Features: AbW1kvaBDhljrbMkbJf4E4IJCpliGimzPWYqQV49HW3cEqidKVEWuh9OgCVxt8I
Message-ID: <CACT4Y+YwLy903AHPQ43gm7iM4Hn-ZroG=HHFvFo9Pk1_ko+cOg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf hist: Fix bogus profiles when filters are enabled
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Jan 2025 at 22:59, Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Wed, Jan 08, 2025 at 08:36:54AM +0100, Dmitry Vyukov wrote:
> > When a filtered column is not present in the sort order, profiles become
> > arbitrary broken. Filtered and non-filtered entries are collapsed
> > together, and the filtered-by field ends up with a random value (either
> > from a filtered or non-filtered entry). If we end up with filtered
> > entry/value, then the whole collapsed entry will be filtered out and will
> > be missing in the profile. If we end up with non-filtered entry/value,
> > then the overhead value will be wrongly larger (include some subset
> > of filtered out samples).
> >
> > This leads to very confusing profiles. The problem is hard to notice,
> > and if noticed hard to understand. If the filter is for a single value,
> > then it can be fixed by adding the corresponding field to the sort order
> > (provided user understood the problem). But if the filter is for multiple
> > values, it's impossible to fix b/c there is no concept of binary sorting
> > based on filter predicate (we want to group all non-filtered values in
> > one bucket, and all filtered values in another).
> >
> > Examples of affected commands:
> > perf report --tid=123
> > perf report --sort overhead,symbol --comm=foo,bar
> >
> > Fix this by considering filtered status as the highest priority
> > sort/collapse predicate.
>
> Do you mean when you specify filters not in a sort list?
>
> I guess it's an undefined behavior.. probably better to warn users not
> to do that and exit.  The hist entries are built using only the fields
> in the sort list.  Filtering by unspecified fields would be meaningless
> and won't work well IMHO.

We could warn as well, but I do want this feature for:
https://lore.kernel.org/linux-perf-users/CACT4Y+an1LSY15f9MS_vnbaaeeqMf+k4-Dqqfu-zwcUAHFNk=w@mail.gmail.com/T/#t
I think it may be useful for other cases as well, let's discuss the
feature below.
Why won't it work well? At least in my local manual testing, it worked
well. This does make hist built using filtered fields as well.


> > As a side effect this effectively adds a new feature of showing profile
> > where several lines are combined based on arbitrary filtering predicate.
> > For example, showing symbols from binaries foo and bar combined together,
> > but not from other binaries; or showing combined overhead of several
> > particular threads.
>
> I'm not sure I'm following.  I'm seeing this even with your change.
>
> Without filters:
>
>   $ ./perf report -s dso --stdio -q
>       98.41%  perf
>        1.11%  [kernel.kallsyms]
>        0.41%  ld-linux-x86-64.so.2
>        0.05%  libLLVM-16.so.1
>        0.03%  libc.so.6
>
>
> With filter:
>
>   $ ./perf report -s dso -d '[kernel.kallsyms],libc.so.6' --stdio -q
>        1.11%  [kernel.kallsyms]
>        0.03%  libc.so.6
>
> You said you want to have them combined together, right?
> But I think the current behavior makes more sense.


If you add a field to both sort and filter, then this change does not
affect anything (filtered fields already participate in
sorting/merging). It affects things when the filter field is not in
sort.

Consider the following queries:
"What symbols consume time in this subset of binaries (but not in the rest)?"
Naively, one would try:
perf report --sort=symbol --comm=cc1,ld
And this deceptively works and shows something, but as far as I
understand these are random numbers now.
With this change you can actually do this (you will see things like
malloc/free in both of these binaries, or if one profiles e.g. Go
programs, then there will be lots of common symbols from
runtime/stdlin).

Another example: profile for this particular subset of threads/cpus
(but not for the rest).

And in particular for:
https://lore.kernel.org/linux-perf-users/CACT4Y+an1LSY15f9MS_vnbaaeeqMf+k4-Dqqfu-zwcUAHFNk=w@mail.gmail.com/T/#t
I want to enable: --parallelism=1-8 filter.
Currently you will either see random garbage numbers, or if you add
'parallelism' to sort order, then you will see each symbol/comm
duplicated 8 times for each separate value of parallelism (which is
not useful). But currently you can't see symbol/comm for these 8
parallelism levels combined, but not for the rest.

All-in-all, this looks like a change that defines behavior that's
currently undefined in a useful and intuitive way, without changing
any of the currently defined behaviors.











> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: linux-perf-users@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  tools/perf/util/hist.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > index 8e4e844425370..b70170d854a0c 100644
> > --- a/tools/perf/util/hist.c
> > +++ b/tools/perf/util/hist.c
> > @@ -1303,9 +1303,18 @@ hist_entry__cmp_impl(struct perf_hpp_list *hpp_list, struct hist_entry *left,
> >       typedef int64_t (*fn_t)(struct perf_hpp_fmt *, struct hist_entry *, struct hist_entry *);
> >       struct hists *hists = left->hists;
> >       struct perf_hpp_fmt *fmt;
> > -     int64_t cmp = 0;
> > +     int64_t cmp;
> >       fn_t fn;
> >
> > +     /*
> > +      * Never collapse filtered and non-filtered entries.
> > +      * Note this is not the same as having an extra (invisible) fmt
> > +      * that corresponds to the filtered status.
> > +      */
> > +     cmp = (int64_t)!!left->filtered - (int64_t)!!right->filtered;
> > +     if (cmp)
> > +             return cmp;
> > +
> >       perf_hpp_list__for_each_sort_list(hpp_list, fmt) {
> >               if (ignore_dynamic && perf_hpp__is_dynamic_entry(fmt) &&
> >                   !perf_hpp__defined_dynamic_entry(fmt, hists))
> > --
> > 2.47.1.613.gc27f4b7a9f-goog
> >
