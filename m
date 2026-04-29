Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57938379EFF
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 20:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777493907; cv=none; b=KjSKfPGYf2VHvyfayYolqOV/5THaDrcfjnHno7xESPyK3AvPJ2Qs8h0ChES88XyHsdrwh+6mT+Hl/zGZVh9+egDWugLyj2EdFxZA59YmSLmTjharfKU1ysRNzknA0HEwt40AwdWToH3eQg6Qstw8e2FFLr+MMErMUUVstOuY9U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777493907; c=relaxed/simple;
	bh=vYqJC0UIt1+/d2skc1HngU7tWlrB0sLEKc9lVxBqZY8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tHHsdc2pVUhfGXgv6XES7Zkxzz8V6NV5TfxB3YC9P+EFVeIEA1wu/LZA74Swed9v353sedHkCzMF4wkDEitN4VknR1/6Oes3bteIF8mW4ra8UEXIVrb6JbsGEQx4mRAsY+Wghax0/ohVb1pF+BKt54UbAOrI6o2/y/ID7p15/Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yy4tYJTC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yy4tYJTC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AC5C19425;
	Wed, 29 Apr 2026 20:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777493907;
	bh=vYqJC0UIt1+/d2skc1HngU7tWlrB0sLEKc9lVxBqZY8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Yy4tYJTCscJ6tlbSvCTzYwiPKwJl5AMg8lXTZ9amvouRkcgIJfSP3UzDMQnIJBSIA
	 zmYLyHc/0wSKeLX244gTr0L/xkHaNFbhXQAAcb5m85kPEoxTIQdn+hyRSWbcz3RAyi
	 Zktjr5m+zSYYpZIrYXuDRgxZ0umT7rYET2bw7RkrW61V3NVlZ5RLQ+QvZUmrdwuaPh
	 UTdwT+e8ZkWvDcOtmddLwowqA546gmiQgVux51kpXDfGdB5zraULKrHo5etDDEyxuj
	 Zj7O6y1v/FbI/ZQLxkJtpdeZPHI83gB7QC7vNaaMoPakSag7Hf6ReamBzSB0KM9zt3
	 Qi+G19GPMKKXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf sched stats: Fix segmentation faults in diff
 mode
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260429173931.2700115-1-irogers@google.com>
References: <20260429173931.2700115-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 20:18:25 +0000
Message-Id: <20260429201826.E4AC5C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Stale `ds2` pointer leads to invalid domain diff comparisons.
- [High] Missing NULL check for `summary_head->cpu_data` allocation leads t=
o a segmentation fault.
- [High] Memory leaks on error paths in `get_all_cpu_stats()`.
- [High] Failure of `get_all_cpu_stats()` is silently ignored, leading to d=
ata corruption.
- [Medium] Commit message falsely claims fixing an uninitialized variable.
--

commit 9defc7ef4fdb95729f7675ddb4788cb55728c905
Author: Ian Rogers <irogers@google.com>
Subject: perf sched stats: Fix segmentation faults in diff mode

The patch addresses multiple segmentation fault vectors and out-of-bounds
reads in perf sched stats diff by adding bounds checks, NULL checks, list
termination checks, and zero-initialization.

> 1. In get_all_cpu_stats(), added assert(!list_empty(head)) to prevent
>    unsafe list_first_entry() calls on empty lists, fixed uninitialized
>    variable ret, and added list_is_last check when iterating domains to

This isn't a bug, but the commit message mentions fixing an uninitialized
variable ret. Looking at the original code, ret was explicitly initialized
to zero (int ret =3D 0;).

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 555247568e7a..e67241415255 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c

[ ... ]

> @@ -4170,40 +4170,40 @@ static void summarize_schedstat_domain(struct sch=
edstat_domain *summary_domain,
>   */
>  static int get_all_cpu_stats(struct list_head *head)
>  {
[ ... ]
> -	if (cptr) {
> -		summary_head =3D zalloc(sizeof(*summary_head));
> -		if (!summary_head)
> -			return -ENOMEM;
> +	summary_head =3D zalloc(sizeof(*summary_head));
> +	if (!summary_head)
> +		return -ENOMEM;
> =20
> -		summary_head->cpu_data =3D zalloc(sizeof(*cs));
> -		memcpy(summary_head->cpu_data, cptr->cpu_data, sizeof(*cs));
> +	summary_head->cpu_data =3D zalloc(sizeof(*summary_head->cpu_data));
> +	memcpy(summary_head->cpu_data, cptr->cpu_data, sizeof(*summary_head->cp=
u_data));

If zalloc() for summary_head->cpu_data fails and returns NULL, could this
memcpy() dereference the NULL pointer and cause a crash?

> =20
> -		INIT_LIST_HEAD(&summary_head->domain_head);
> +	INIT_LIST_HEAD(&summary_head->domain_head);
> =20
> -		list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
> -			tdptr =3D zalloc(sizeof(*tdptr));
> -			if (!tdptr)
> -				return -ENOMEM;
> +	list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
> +		struct schedstat_domain *tdptr =3D zalloc(sizeof(*tdptr));
> =20
> -			tdptr->domain_data =3D zalloc(sizeof(*ds));
> -			if (!tdptr->domain_data)
> -				return -ENOMEM;
> +		if (!tdptr)
> +			return -ENOMEM;
> +
> +		tdptr->domain_data =3D zalloc(sizeof(*tdptr->domain_data));
> +		if (!tdptr->domain_data)
> +			return -ENOMEM;

If either of these zalloc() calls fails and the function returns -ENOMEM,
what happens to the memory previously allocated for summary_head and
summary_head->cpu_data? It seems they might leak since they haven't been
attached to the list yet.

Additionally, does the caller of get_all_cpu_stats() properly handle an
-ENOMEM return value? In show_schedstat_data(), if this error is ignored,
the summary node won't be prepended, which might cause the subsequent loop
to treat the first CPU's actual data as the summary.

[ ... ]

> @@ -4302,10 +4339,30 @@ static int show_schedstat_data(struct list_head *=
head1, struct cpu_domain_map **
>  			struct domain_info *dinfo1 =3D NULL, *dinfo2 =3D NULL;
> =20
>  			ds1 =3D dptr1->domain_data;
[ ... ]
>  			if (dptr2) {
>  				ds2 =3D dptr2->domain_data;
[ ... ]
> @@ -4334,14 +4391,22 @@ static int show_schedstat_data(struct list_head *=
head1, struct cpu_domain_map **
>  			print_domain_stats(ds1, ds2, jiffies1, jiffies2);
>  			print_separator2(SEP_LEN, "", 0);
> =20
> -			if (dptr2)
> -				dptr2 =3D list_next_entry(dptr2, domain_list);
> +			if (dptr2) {
> +				if (list_is_last(&dptr2->domain_list, &cptr2->domain_head))
> +					dptr2 =3D NULL;
> +				else
> +					dptr2 =3D list_next_entry(dptr2, domain_list);
> +			}

When dptr2 is explicitly set to NULL at the end of the second file's domain
list, the next iteration of the loop will skip the ds2 =3D dptr2->domain_da=
ta
assignment.

Does this leave ds2 holding the pointer from the previous iteration, causing
print_domain_stats() to perform a diff comparison against a stale, unrelated
domain?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429173931.2700=
115-1-irogers@google.com?part=3D1
