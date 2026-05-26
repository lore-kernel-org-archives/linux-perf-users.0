Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F581427A;
	Tue, 26 May 2026 00:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779754834; cv=none; b=Mh5S+rWQ50Ia2tXvVOjgAsucu402KnLDE8aLUB2nA/sTjGmioRCSfSGZlt/IWoclvnaDcvvARPvYOGhr6JPveGKDzPxh7zreEIKb/MbKvHccvtRhH5CW3M0bGlLJ/XTivuVuwBaA6GAqvroj2ZmPwFZKQyKUK82Boj96IDwpR2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779754834; c=relaxed/simple;
	bh=Eehw0pjAuzvYLoxl5Z8qYyKfjsrQE24AIXFTV8/3wF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7I3tNgEbsGsJhSHBA2V2ulDV1A6p7NBmOHqws+1sw6XjDu1F6iwAGVV9cibzhH2Av7ICXQ9Efcz26pRhzk1PtftR96Q+EeZEhKoVU0jdhqlzlGI/T1zfLlneWBNoDJmxKDblr/xMYJTGE1F6/YZYgzIqa8khZMFEzgW0v71yTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdTamvgO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdTamvgO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D6A1F000E9;
	Tue, 26 May 2026 00:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779754833;
	bh=4CulJcCeZVlUBQrdj1nQhc0A6uCK8N+OzSwaopGGZS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FdTamvgOovWyvmwQIjnxgav6oSB4DOV1+LIBt6L0zV2NmV10d+0F+mhyKFYNUryAv
	 eE2UOt7UcKUqBuQ50JLzNEWQ4XJwoN9eBW32GNl2l0LVjLwxMniIxChkxuVh9rGLE5
	 w93NXfBgczvBvUul+ER3LkxjeFvezLJyTYSEzoTUJ+0vifiiKefAk8UBGh7MM7Y1vZ
	 i5amL24IAW2lUV0NQZos4BS6lRb8D7G5xJ9tFknBJT60ZWSbNd/z+ODl5/zHCAVefh
	 21snhx+sI4nrpmK2yMfZRpWwy991w8QqwNf35AfcH/l01AmnwtYhexWnYOI/4uUIMj
	 6wVCiNdZDH8Gw==
Date: Mon, 25 May 2026 21:20:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org,
	adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org
Subject: Re: [RFC PATCH v2 01/14] perf stat: Introduce core generic print
 traversal engine and header stubs
Message-ID: <ahTnTt2HWa5Zx-0l@x1>
References: <20260522223342.2393553-1-irogers@google.com>
 <20260525231900.3527228-1-irogers@google.com>
 <20260525231900.3527228-2-irogers@google.com>
 <ahTdcAqLUH_Za7qe@x1>
 <CAP-5=fWoetmpFuxAwWyj5cMPn7rsJjPBdK-MvJxw06aVj=DNKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWoetmpFuxAwWyj5cMPn7rsJjPBdK-MvJxw06aVj=DNKw@mail.gmail.com>

On Mon, May 25, 2026 at 04:48:57PM -0700, Ian Rogers wrote:
> On Mon, May 25, 2026 at 4:38 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Mon, May 25, 2026 at 04:18:47PM -0700, Ian Rogers wrote:
> > > This patch introduces the initial infrastructure for decoupling the
> > > perf stat printing API. It declares the struct perf_stat_print_callbacks
> > > interface and the core traversal driver perf_stat__print_cb() inside
> > > the newly created util/stat-print.h and util/stat-print.c files.
> >
> > Can we avoid these kinds of reflowings:
> >
> >                 OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
> > -                       "Set the metrics level for the top-down statistics (0: max level)"),
> > -               OPT_BOOLEAN(0, "smi-cost", &smi_cost,
> > -                       "measure SMI cost"),
> > +                            "Set the metrics level for the top-down statistics (0: max level)"),
> > +               OPT_BOOLEAN(0, "smi-cost", &smi_cost, "measure SMI cost")
> >
> > There is a lot to process and these things gets in the way.
> >
> > I'm trying to make sure this doesnt' happen in my patches with or
> > without AI assistance :-)
> >
> > We need to have this as a skill so that AI don't do this.
> 
> Actually, it was primarily from running "git clang-format" to clean up
> the #includes, but also for the layout of the AI aided stuff. git
> clang-format likes to think that if you edited a function then tidying
> up any style issues within it is fair game. I can resend with a fix.

If the patch is just about reflowing to standardize on some format, then
we expect that to be what the patch is about, but then it still doesn't
add value at all, its just something we have to look at to see if it
isn't introducing a problem even when obviously it probably will not add
any.

- Arnaldo
