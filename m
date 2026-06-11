Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE91F175A7E
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 23:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781218842; cv=none; b=D/9LA4tdA1UFItWwCusl1+Ae0lrdZhwZu1uqyDVZBHtOWUtuA7S8htgdiRp3V9x+2a4Am0lPdfSLTbQpuxwv5LttjtkPzV9ahhsLQEGRmIlLKN/DorBOcDdzNP5VK/1uy9q8xsblXWPWBs2U12wIgC5ZDhNq/RZUavHKMgyt/L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781218842; c=relaxed/simple;
	bh=Z8bB3M40AYe0KEjkCUc2IMakOORgn72r515r1YuW0GM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tz29e/ua/ropj2QB7bdEx1xMmwpk0wFuEb4ioM1rBY9FXpcRhAYk5y7azr0nF1PtYj9oHkqqah44W7w6pi+XJHVcl2vfLgyzFVuDuPaIznvLhYZQqmM/bvu1jt994JS2+jD+g1YUpV+iRB5YqOVgSVIzR8Ea5pXdg3fD/rAO9k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFRA0akX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFRA0akX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAD71F000E9;
	Thu, 11 Jun 2026 23:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781218841;
	bh=W1ty1jWikUBBn4Bua2uUY04mwbqa5zaFCyJ2HKFwW8A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cFRA0akXbGUPGKNP9B6hJvAygt6K2IRemGShthE3A0qfmgyZELiIbbKX2AGe4nR6s
	 RprdJEf2uMfgbUfRF2wvejVr3gDSPwY3iPCeRgntiTOu0obtrFSZMruomsdyuCD7TW
	 9G+SDzdqRU+hK+7CW8zDb3VetEYpEozSw4SAdJKYgbB89c7k8YlWojJ4RIUY3mSmb5
	 9fzHHw8tQI0dMEaBKoCTZooVDucqH/j2SjgJBCN0Gwz97uJk9hBolpG6WV77HPl26/
	 4UZsbR0VvgH0x7s3UsF7TpdQxCsvALrfOOGZajJzTbSHYkvv6TEUTAg9CZ2UaOeH+I
	 KDm7RAeCmtJug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 07/19] perf evlist: Add reference count checking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611224455.201994-8-irogers@google.com>
References: <20260611224455.201994-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 23:00:40 +0000
Message-Id: <20260611230041.2BAD71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Flawed lockless cycle collection in `evlist__put()` causes concu=
rrent double-frees and memory leaks when an `evsel` outlives its `evlist`.
- [Medium] `evlist__splice_list_tail` fails to update `evsel->evlist` wrapp=
er back-pointers, causing semantic bugs and leaving zombie `evlist`s.
--

commit e1de0010654c0fa0886c5cb58a3c718bfcfcd268
Author: Ian Rogers <irogers@google.com>

perf evlist: Add reference count checking

This commit adds reference count checking for the evlist structure to ensure
that gets and puts are correctly paired. It introduces accessors for evlist
functions and switches the codebase to use them.

> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2127,13 +2131,13 @@ static int add_default_events(void)
>  			evlist__for_each_entry(metric_evlist, evsel)
>  				evsel->default_metricgroup =3D true;
> =20
> -			evlist__splice_list_tail(evlist, &metric_evlist->core.entries);
> +			evlist__splice_list_tail(evlist, &evlist__core(metric_evlist)->entrie=
s);
>  			metricgroup__copy_metric_events(evlist, /*cgrp=3D*/NULL,
> -							&evlist->metric_events,
> -							&metric_evlist->metric_events);
> +							evlist__metric_events(evlist),
> +							evlist__metric_events(metric_evlist));
>  			evlist__put(metric_evlist);
>  		}

[Severity: Medium]
Could this lead to a memory leak of the temporary metric_evlist? If
evlist__splice_list_tail() does not update the evsel->evlist back-pointers
of the spliced events, they will maintain references to this temporary
metric_evlist. The metric_evlist would then become a zombie because its
refcount never reaches 0, which might break functions like
evsel__session() that rely on the evsel->evlist back-pointer.

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -220,13 +240,43 @@ static void evlist__exit(struct evlist *evlist)
>  void evlist__put(struct evlist *evlist)
>  {
> +	struct evsel *evsel;
> +	unsigned int count, ref_cnt;
> +
>  	if (evlist =3D=3D NULL)
>  		return;
> =20
> -	if (!refcount_dec_and_test(&evlist->refcnt))
> -		return;
> +	if (refcount_dec_and_test(evlist__refcnt(evlist)))
> +		goto out_delete;
> +
> +retry:
> +	count =3D refcount_read(evlist__refcnt(evlist));
> +	ref_cnt =3D count;
> +	evlist__for_each_entry(evlist, evsel) {
> +		if (RC_CHK_EQUAL(evsel->evlist, evlist) && count &&
> +		    refcount_read(&evsel->refcnt) =3D=3D 1)
> +			count--;
> +	}
> +	if (refcount_read(evlist__refcnt(evlist)) !=3D ref_cnt)
> +		goto retry;
> =20
> +	if (count !=3D 0) {
> +		/*
> +		 * Not the last reference except for back references from
> +		 * evsels.
> +		 */
> +		RC_CHK_PUT(evlist);
> +		return;
> +	}
> +out_delete:

[Severity: Medium]
Could this lockless loop be concurrently evaluated by multiple threads
dropping their references? If two threads concurrently drop their references
to the evlist, it appears they might both observe the conditions to delete
it, falling through to out_delete and resulting in a double-free.

Additionally, if an external caller takes an extra reference to an evsel,
evlist__put() skips deletion, but would a subsequent evsel__put() have the
necessary cycle-breaking logic to prevent permanently leaking both the
evsel and the evlist?

[ ... ]

> @@ -284,6 +324,7 @@ void evlist__remove(struct evlist *evlist, struct evs=
el *evsel)
>  void evlist__splice_list_tail(struct evlist *evlist, struct list_head *l=
ist)
>  {
> -	perf_evlist__splice_list_tail(&evlist->core, list);
> +	perf_evlist__splice_list_tail(evlist__core(evlist), list);
>  }

[Severity: Medium]
Does this function need to update the evsel->evlist wrapper back-pointers
and reference counts for the spliced events? Since the new refcounting
design mandates that each evsel holds a reference to its parent evlist
(established in evlist__add), moving the inner core nodes between lists
without updating the wrapper pointers seems like it leaves the spliced
events referencing the old evlist.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611224455.2019=
94-1-irogers@google.com?part=3D7
