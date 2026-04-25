Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92562309B2
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777141553; cv=none; b=adLfanMFEtrFaFAyCQ3HeUpzVj/n1I1TgRbpumypyRR+elumgGYPe+w+WnHuFAEyvJyrdbGZGyclGHqV3abrUgKwrV6uYKHrIqBz+6X/fEgJnW9m3TVQiy/W5AU8DWHDuGz1SPC4R5FcdAjBSjieB8YEsUgVylbHDMeXRohURno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777141553; c=relaxed/simple;
	bh=Y9qkdELqmxCTBy0Ws6twnMYEaFvldtmPCBNj+zvYSi8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mxo0M5ptLVRIWCEeggVHQd6voRU8ev6qm8d57oNKj+OtQFevLe9hzu8DKcH/cs4ifQC4aEzZR3iPj10C+uo2tcP0ALxxIJxVvqIm5DRtQiTo+V3fT91/qemz64kDBBCMKDpWOCWYLgU5wQ3L5sFnW1c639tVGMV314BzkOuZEy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=On2aJGRB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="On2aJGRB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7821FC2BCB0;
	Sat, 25 Apr 2026 18:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777141553;
	bh=Y9qkdELqmxCTBy0Ws6twnMYEaFvldtmPCBNj+zvYSi8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=On2aJGRBdfjWtRlFL2M1Q/xoUwW7o5puqv9TFT6eU3erRpBbcPiWKFscXhRroFKQ6
	 dq6HxaDChajlI6CIRMiwpMB3BqJsZ6PpJYSV/1R/KHt75qO59XjQUEoU6LTVjpNhxR
	 cCRbIRVKpkJ8xfGdDA0O9XpJ6nlF7Rct9eXdJABvBkdwKVDHarEwKAsYOLqTYyJ2R0
	 ehWlRXqfofJoGuXcuMr42BFB6Haa9+Bu7wsoYDnF/oavmpDA0kVGMwUSp8yVhqaltT
	 Uoh7BjYpU0aV8SlvPa4a3SFA7Jy7Aaa09w6Hj2WEsyueaokiep54P3sjxZ64ZFyIkd
	 j9sDwj2eEdTYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 59/59] perf sched stats: Fix segmentation faults in
 diff mode
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-60-irogers@google.com>
References: <20260425174858.3922152-60-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:25:52 +0000
Message-Id: <20260425182553.7821FC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Stale `cs2` and `ds2` pointers lead to incorrect diff computation =
and spurious failures when iterating lists of unequal lengths.
- [High] Missing bounds check on untrusted domain indices leads to out-of-b=
ounds array reads.
--

commit 81cf4f4c4c1266ce2e1faa604bb84ef9cfc8657f
Author: Ian Rogers <irogers@google.com>

perf sched stats: Fix segmentation faults in diff mode

This commit addresses several segmentation fault vectors in perf sched stats
diff mode. It adds NULL checks for CPU domain maps, uses list_is_last to
prevent list iteration wraparound, and adds bounds checks for CPU IDs to
handle files with varying CPU configurations.

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
> =20
>  		if (cs2 && cs1->cpu !=3D cs2->cpu) {

When cptr2 becomes NULL because the second list is shorter, cs2 is not
reset to NULL at the start of the loop.

Could this cause the check here to spuriously fail and abort the diff
because cs2 retains the pointer from the previous iteration?

[ ... ]

> @@ -4303,9 +4339,17 @@ static int show_schedstat_data(struct list_head *h=
ead1, struct cpu_domain_map **
> =20
>  			ds1 =3D dptr1->domain_data;
>  			dinfo1 =3D cd_info1->domains[ds1->domain];

This patch adds bounds checking for the CPU IDs, but ds1->domain is read
from the data file and used directly as an array index here.

Should we also add bounds checking against cd_info1->nr_domains to prevent
out-of-bounds reads if the domain index is invalid?

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
> =20
>  			if (dinfo2 && dinfo1->domain !=3D dinfo2->domain) {

[ ... ]

> @@ -4334,14 +4378,22 @@ static int show_schedstat_data(struct list_head *=
head1, struct cpu_domain_map **
>  			print_domain_stats(ds1, ds2, jiffies1, jiffies2);

Similarly, if dptr2 becomes NULL because the second file has fewer domains,
ds2 is not reset to NULL inside the domain iteration loop.

Does this result in print_domain_stats() computing diffs using stale ds2
data from the previous domain instead of handling the domain as missing?

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
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D59
