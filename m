Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E14345757
	for <linux-perf-users@vger.kernel.org>; Thu,  7 May 2026 22:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778191981; cv=none; b=ib+x5fmZ6OHlHn5Lq6y7eAOhbzP8DR9ku1qz0+IX7FX2nGru5+IQxCP1xz+nly7Zg2JY/dqBEaACJZ5Bq2s1MyAYlu/DuRVi54jrQKUsV5GHaZM65RTAmer2/UKtiJV6CjE45bYeXzynhZ62fKxUAR2p/E0cgmiC/jfqhTVRo7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778191981; c=relaxed/simple;
	bh=GrpgUqoRuLx5V4ZdtpbnQjckKvUf/UlhaQZoXO2mz0w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lXHDHVHKARfrE5a5b24auevNJWWFPVdvqtgJdimdzFfVTUFvyfTI8bCUwbUdZz/vvSJOJ2bjmHvk7O0z/ocIYsZTfZoN8aIDPCriI/ZaFWf8r+XY+ELLrKEIu+/vIt8yQ8a0/Pnt0HRvHwc1mK3tRS5tQDw8KSPlZRPpegyjTdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaQH0eSB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaQH0eSB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFDCC2BCB2;
	Thu,  7 May 2026 22:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778191981;
	bh=GrpgUqoRuLx5V4ZdtpbnQjckKvUf/UlhaQZoXO2mz0w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=BaQH0eSBCfHT1hrxE59Z4sapQQKL+2N0IHD48mmbeB4n1hqR4RTMKzpCoP/OKJ0j9
	 vSQe1PtgfZHSKtxK/LuHjn8oDsG2i4xB/6KJu3AUBmhdAUhjwesfMlwIKiydV13okl
	 p+lZd5gtHu8TVdAT/Xccpi95u2Wy9ezg1QM240kCV5vkWayOfMxCO7exHBInII5L9D
	 FqOUsEsggLqfdBng5zj5XywX+B/YsZap4OdS/vuLZT+GVT3xHYpDLxkcOvAxGKynvE
	 s9OwpCWyRpB3Opgq9C6oEZr9WEfzGmRAdwtRblhFnKKtp7MzHrXUrXv4RSyJplrZoT
	 Y1/NT0tc30eog==
From: sashiko-bot@kernel.org
Subject: Re: [RFT PATCH v2 6/7] perf-iostat: Make x86 iostat compatible with
 new iostat framework
Reply-To: sashiko@lists.linux.dev
To: "Yushan Wang" <wangyushan12@huawei.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260507063737.3542950-7-wangyushan12@huawei.com>
References: <20260507063737.3542950-7-wangyushan12@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 22:13:00 +0000
Message-Id: <20260507221301.0CFDCC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The global constructor `x86_iio_iostat_pmu_init` unconditionally t=
riggers a synchronous sysfs scan, severely regressing binary startup perfor=
mance.
- [High] Reassigning the local `evlist` pointer in `iio_iostat_prepare` cau=
ses a Use-After-Free in the caller.
- [High] Failure in `realloc` leaves `nr_entries` incorrectly incremented, =
leading to an out-of-bounds read and invalid free.
- [Medium] The PMU matching probe `iio_iostat_probe` violates subsystem gui=
delines by lacking a `fake_pmu` fallback.
--

commit 315073cef675058ba43972361532dbecbed38e8d
Author: Shiju Jose <shiju.jose@huawei.com>

perf-iostat: Make x86 iostat compatible with new iostat framework
   =20
Change the original x86 iio iostat supporter to be compatible with the
set of iostat frameworks. The matching function of x86 iio may not be
correct.

> diff --git a/tools/perf/util/x86-iostat.c b/tools/perf/util/x86-iostat.c
> index f8d4c97185949..778655cbc2a0a 100644
> --- a/tools/perf/util/x86-iostat.c
> +++ b/tools/perf/util/x86-iostat.c
> @@ -354,7 +354,7 @@ static void iostat_prefix(struct evlist *evlist,
>  	}
>  }
> =20
> -int iostat_prepare(struct evlist *evlist, struct perf_stat_config *confi=
g)
> +static int iio_iostat_prepare(struct evlist *evlist, struct perf_stat_co=
nfig *config)
>  {
>  	if (evlist->core.nr_entries > 0) {
>  		pr_warning("The -e and -M options are not supported."
>  			   "All chosen events/metrics will be dropped\n");
>  		evlist__delete(evlist);
>  		evlist =3D evlist__new();

This problem wasn't introduced by this patch, but does reassigning the local
evlist parameter here leave the caller with a dangling pointer?

When evlist__delete(evlist) frees the memory, the local evlist pointer is
updated with evlist__new(), but the caller's evsel_list pointer remains
unchanged.

Could this cause a use-after-free when the caller subsequently passes its
pointer to functions like iostat_list()?

[ ... ]

> +/*
> + * FIXME: pmu name prefix match might not work for x86 iio.
> + */
> +static bool iio_iostat_probe(struct iostat_pmu *iostat_pmu)
> +{
> +	return perf_pmus__scan_matching_wildcard(NULL, iostat_pmu->pmu_name_wil=
dcard);
> +}

Does this probe function need to handle the fake_pmu fallback behavior?

According to the perf subsystem guidelines, any code performing PMU lookups
by name must provide a fallback when fake_pmu is enabled.

Since this function does not handle it and evaluates at constructor time
without a parse_state, does it return NULL on non-Intel architectures and
refuse to register the x86 iostat PMU, breaking cross-architecture tests?

> +
> +static struct iostat_pmu x86_iio_iostat_pmu_list[]  =3D {
> +	{
> +		.pmu_name_wildcard =3D "uncore_iio*",
> +		.match =3D iio_iostat_probe,
> +		.prepare =3D iio_iostat_prepare,
> +		.parse =3D iio_iostat_parse,
> +		.list =3D iio_iostat_list,
> +		.print_header_prefix =3D iio_iostat_print_header_prefix,
> +		.print_metric =3D iio_iostat_print_metric,
> +		.print_counters =3D iio_iostat_print_counters,
> +		.release =3D iio_iostat_release,
> +	},
> +};
> +
> +static void __attribute__((constructor)) x86_iio_iostat_pmu_init(void)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(x86_iio_iostat_pmu_list); i++)
> +		register_iostat_pmu(&x86_iio_iostat_pmu_list[i]);
> +}

Does executing this logic in a global constructor cause a binary startup
regression?

This initialization calls register_iostat_pmu(), which invokes
iio_iostat_probe(), which then calls perf_pmus__scan_matching_wildcard().

This unconditionally executes pmu_read_sysfs() to open and parse the
/sys/bus/event_source/devices directory.

Does this force heavy file I/O on every single execution of the perf binary
(such as "perf help"), preventing lazy initialization?

Additionally, this problem wasn't introduced by this patch, but looking at
iio_root_ports_list_insert() in tools/perf/util/x86-iostat.c:

static int iio_root_ports_list_insert(struct iio_root_ports_list *list,
				      struct iio_root_port * const rp)
{
...
	if (list && rp) {
		rp->idx =3D list->nr_entries++;
		tmp_buf =3D realloc(list->rps,
				  list->nr_entries * sizeof(*list->rps));
		if (!tmp_buf) {
			pr_err("Failed to realloc memory\n");
			return -ENOMEM;
		}
...

If realloc() fails, does this leave list->nr_entries incorrectly incremente=
d?

When the error path subsequently calls iio_root_ports_list_free(), does it
iterate up to the inflated nr_entries and cause an out-of-bounds array read=
 of
list->rps, followed by an invalid zfree()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507063737.3542=
950-1-wangyushan12@huawei.com?part=3D6
