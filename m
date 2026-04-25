Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B61288AD
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777159905; cv=none; b=kcTB5CSnVSqmnPJqlt9aQOVaH8txYCkfuXRIthHgSaIybN46L4MdvPkI+s8W06mzPlEXaAqJK3YCPlCKlNWTr8B8L4I7OKGnM47roO1hP11Ms7j2c4iAebwMOzEelu8t/NsoEeVeOjnsGi5DR6LZ7/fxF/ql1RT+MOTHDe1OhMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777159905; c=relaxed/simple;
	bh=K3UKNAeStOLa0886zDhWoinUi52L1cYhlUCEQiwjIOI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nsewgdGf89R6Pv56jt+/ozlWbWD/SvkahSnu629IOW9FR0kMWOwyl3jeQQOsfPKnyOxSqXHQSou+qpit3j8lHgGMKx0ShEJhMUQibZnVsaNM/wL4oGH7NaJ2HOgFF5Df/vUKZPCaToPOgPyev3MRfP/y2PTbLIfUEyynh8iSNJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ut0JQAID; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ut0JQAID"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72475C2BCB0;
	Sat, 25 Apr 2026 23:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777159905;
	bh=K3UKNAeStOLa0886zDhWoinUi52L1cYhlUCEQiwjIOI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ut0JQAIDj6i/0AtFTrERpPjXcMDk8QvW46PERsCihLlVftYE+XzWiKOZEBOGMhCq6
	 raB1eIzrko2TLvweEptXV9lXjm28wFzzhJf2KXpCINLKMP/YnhhDIBkKutjS3aaM/b
	 ptdutcf+G8BybDfImTNtQrFpbn4WBhejUoZ9WGsaxiXy4HVVesMNrnl9vp0XxA8Vib
	 2ZLAx204uh9mt5KzTvjgeu9VPgfAFUSb/+IvwyXyOjZEVnHIRyQOIitdDZgWjFH6eZ
	 s7FP+Ofom53xgSYnt9oj+FhaSJy80aL428qrJviOOgnaXfu5L05EZYxoIgCq0j+T6I
	 1UMrTr9KVkS/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 59/59] perf sched stats: Fix segmentation faults in
 diff mode
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-60-irogers@google.com>
References: <20260425224951.174663-60-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:31:44 +0000
Message-Id: <20260425233145.72475C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Variables cs2 and dptr2 retain stale values when cptr2 becomes NUL=
L, causing incorrect error handling and potential segmentation faults.
- [High] Missing bounds check for domain indices `ds1->domain` and `ds2->do=
main` allows out-of-bounds memory reads.
--

commit e0031dc03b1750088d890fd48c18f0755b2ac4ea
Author: Ian Rogers <irogers@google.com>

perf sched stats: Fix segmentation faults in diff mode

This commit adds bounds and NULL checks to the perf schedstat diff
command to prevent segmentation faults on invalid data.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index d3fa9c70790f..f6c7d100729a 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
[ ... ]
> @@ -4269,12 +4286,31 @@ static int show_schedstat_data(struct list_head *=
head1, struct cpu_domain_map **
>  		struct cpu_domain_map *cd_info1 =3D NULL, *cd_info2 =3D NULL;
> =20
>  		cs1 =3D cptr1->cpu_data;
> +		if (cs1->cpu >=3D (u32)nr1) {
> +			pr_err("Error: CPU %d exceeds domain map size %d\n", cs1->cpu, nr1);
> +			return -1;
> +		}
>  		cd_info1 =3D cd_map1[cs1->cpu];
> +		if (!cd_info1) {
> +			pr_err("Error: CPU %d domain info is missing in map 1.\n", cs1->cpu);
> +			return -1;
> +		}
>  		if (cptr2) {
>  			cs2 =3D cptr2->cpu_data;
> +			if (cs2->cpu >=3D (u32)nr2) {
> +				pr_err("Error: CPU %d exceeds domain map size %d\n", cs2->cpu, nr2);
> +				return -1;
> +			}
>  			cd_info2 =3D cd_map2[cs2->cpu];
> -			dptr2 =3D list_first_entry(&cptr2->domain_head, struct schedstat_doma=
in,
> -						 domain_list);
> +			if (!cd_info2) {
> +				pr_err("Error: CPU %d domain info is missing in map 2.\n", cs2->cpu);
> +				return -1;
> +			}
> +			if (!list_empty(&cptr2->domain_head))
> +				dptr2 =3D list_first_entry(&cptr2->domain_head, struct schedstat_dom=
ain,
> +							 domain_list);
> +			else
> +				dptr2 =3D NULL;
>  		}

If cptr2 becomes NULL after being valid in a previous iteration, will cs2
and dptr2 retain their stale values?

Since cd_info2 is initialized to NULL at the start of the loop but cs2 and
dptr2 are declared outside the loop, the check for mismatched CPUs:

if (cs2 && cs1->cpu !=3D cs2->cpu)

might evaluate to true and incorrectly abort with "Failed because matching
cpus not found for diff".

If it happens to bypass the abort, could this cause a NULL pointer
dereference when accessing cd_info2->domains later in the loop, given that
cd_info2 is NULL but the stale dptr2 is not?

[ ... ]
> @@ -4303,9 +4339,17 @@ static int show_schedstat_data(struct list_head *h=
ead1, struct cpu_domain_map **
> =20
>  			ds1 =3D dptr1->domain_data;
>  			dinfo1 =3D cd_info1->domains[ds1->domain];

Are there bounds checks for ds1->domain before using it as an index into
the cd_info1->domains array?

Since ds1->domain comes from the untrusted perf data file, a large value
could read past the end of the dynamically allocated domains array. Would it
make sense to add bounds checks for ds1->domain and ds2->domain against
cd_info1->nr_domains and cd_info2->nr_domains, similar to the protections
added for cs1->cpu and cs2->cpu?

> +			if (!dinfo1) {
> +				pr_err("Error: Domain %d info is missing for CPU %d in map 1.\n", ds=
1->domain, cs1->cpu);
> +				return -1;
> +			}
>  			if (dptr2) {
>  				ds2 =3D dptr2->domain_data;
>  				dinfo2 =3D cd_info2->domains[ds2->domain];
> +				if (!dinfo2) {
> +					pr_err("Error: Domain %d info is missing for CPU %d in map 2.\n", d=
s2->domain, cs2->cpu);
> +					return -1;
> +				}
>  			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D59
