Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4901E4AF
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 22:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775861156; cv=none; b=apZ0xwL2TXsgVErFEMDSHs13ZGgHgLi3RvHw5DiKeX7KRLpifkIVcdXUzH5zUaIK00gB9W7+h5lnatJU8AagtGe3DjIkcavgeMtGiUii6rQnr221RyCYD1SadL1GobSqmsu4YEZBygf9WMVTakgaTJiXHBB7lWP9Z6I1Ev3iyuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775861156; c=relaxed/simple;
	bh=N3/XDazHmHgGSeBL+Y151MkXr+Xd/8O2jMKrpft7xnQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CaojU0GkqTaUDB7jEoAeexpVSX+2jJeyheMdyWDKSvgtL1nGhrDHILv5hoRBBXhRFR0yr5sgu5wMT3yT7x7Ul0QzgZ/omhun7Ns+2z/HnRuUAL4uIyg8iO3YjZnVu7i0MBOJ65mgqSrwc/bK76NsP6umd0lLNTRJyIAc96yS1b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lO8p+w2+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lO8p+w2+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67892C19421;
	Fri, 10 Apr 2026 22:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775861156;
	bh=N3/XDazHmHgGSeBL+Y151MkXr+Xd/8O2jMKrpft7xnQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=lO8p+w2+YUnGXBTSiwQh9Ag7KojzUfRsDrL8sdAiMr6WiJFO82UyWL5FvWRjLweDx
	 xGddTdWwvvLBH4aWvnfQrgfMzKoGEK2un3h/ejctiUKjgDgIy+yAjb/3G2qNmE9D8M
	 0YpvP20UGLqdQT0nw9UsT1sg4UEJufeGK3/l8BBRFn9478UG3447rg5J41syyDLZ6t
	 7y22fjUx1xyOS90JHUCkplrPawz6HVbthJiP8qdEkST+wEdOW5djXU54mpx0+9yOU6
	 9IR9sHCMVbKlHhGahy7hdR2hPScApx/jU+vBBFWoGKhfL6cRoaxdPjflwhaqu4Qcw8
	 MAgc50yqfXy2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/13] perf header: Sanity check HEADER_NRCPUS and
 HEADER_CPU_DOMAIN_INFO
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260410220905.200051-4-acme@kernel.org>
References: <20260410220905.200051-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Apr 2026 22:45:55 +0000
Message-Id: <20260410224556.67892C19421@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Medium] Mismatch in domain array traversal bounds causes a memory leak o=
n malformed domain indices.
- [Medium] Unbounded `nr_cpus_avail` allows massive memory allocations and =
integer cast sign extension.
- [Medium] Integer overflow in the section size validation check bypasses b=
ounds validation.
- [Low] Format specifier mismatch in error messages prints large values as =
negative numbers.
--

commit 05b748d77f989fb396557569862fea65e5d2e722
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Sanity check HEADER_NRCPUS and HEADER_CPU_DOMAIN_INFO

This commit adds sanity checks to process_nrcpus and process_cpu_domain_info
to validate CPU counts and prevent duplicate domain allocations.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
[ ... ]
> @@ -2722,6 +2724,13 @@ static int process_nrcpus(struct feat_fd *ff, void=
 *data __maybe_unused)
>  	ret =3D do_read_u32(ff, &nr_cpus_online);
>  	if (ret)
>  		return ret;
> +
> +	if (nr_cpus_online > nr_cpus_avail) {
> +		pr_err("Invalid HEADER_NRCPUS: nr_cpus_online (%u) > nr_cpus_avail (%u=
)\n",
> +		       nr_cpus_online, nr_cpus_avail);
> +		return -1;
> +	}
> +

Since there is no absolute upper limit checked for nr_cpus_avail here, could
a malformed perf.data file provide an excessively large value?

For example, if nr_cpus_online is 1 and nr_cpus_avail is 0x40000000,
it seems this check would pass.

Later, env->nr_cpus_avail is cast to int, which would result in a negative
value if nr_cpus_avail exceeds INT_MAX. Additionally, in
process_cpu_domain_info, this could lead to a massive memory allocation
when allocating the cd_map array.

[ ... ]
> @@ -3698,6 +3707,17 @@ static int process_cpu_domain_info(struct feat_fd =
*ff, void *data __maybe_unused
>  	nra =3D env->nr_cpus_avail;
>  	nr =3D env->nr_cpus_online;
> =20
> +	if (nra =3D=3D 0 || nr =3D=3D 0) {
> +		pr_err("Invalid HEADER_CPU_DOMAIN_INFO: missing HEADER_NRCPUS\n");
> +		return -1;
> +	}
> +
> +	if (ff->size < 2 * sizeof(u32) + nr * 2 * sizeof(u32)) {

Can this size validation be bypassed due to an integer overflow?

Because nr is a 32-bit unsigned integer, if a crafted file provides a very
large value like 0x80000000, nr * 2 could overflow to 0 before the promotion
to size_t. This would evaluate the requirement to just 8 bytes, completely
bypassing the bounds check.

> +		pr_err("Invalid HEADER_CPU_DOMAIN_INFO: section too small (%zu) for %u=
 CPUs\n",
> +		       (size_t)ff->size, nr);
> +		return -1;
> +	}
> +
[ ... ]
> @@ -3714,6 +3734,18 @@ static int process_cpu_domain_info(struct feat_fd =
*ff, void *data __maybe_unused
>  	if (ret)
>  		return ret;
> =20
> +	/*
> +	 * Sanity check: real systems have at most ~10 sched domain levels
> +	 * (SMT, CLS, MC, PKG + NUMA hops). Reject obviously bogus values
> +	 * from malformed perf.data files before they cause excessive
> +	 * allocation in the per-CPU loop.
> +	 */
> +	if (max_sched_domains > MAX_SCHED_DOMAINS) {
> +		pr_err("Invalid HEADER_CPU_DOMAIN_INFO: max_sched_domains %u > %u\n",
> +		       max_sched_domains, MAX_SCHED_DOMAINS);
> +		return -1;
> +	}

This isn't a bug, but some of the error messages in this function (such as
the nearby checks for cpu >=3D nra and domain >=3D max_sched_domains) use t=
he
%d format specifier for unsigned 32-bit integers. If a malformed file
provides values >=3D 0x80000000, would they be logged as confusing negative
numbers? Updating them to %u might improve error logging clarity.

[ ... ]
> @@ -3760,7 +3797,13 @@ static int process_cpu_domain_info(struct feat_fd =
*ff, void *data __maybe_unused
>  			if (!d_info)
>  				return -1;
> =20
> -			assert(cd_map[cpu]->domains[domain] =3D=3D NULL);
> +			if (cd_map[cpu]->domains[domain]) {
> +				pr_err("Invalid HEADER_CPU_DOMAIN_INFO: duplicate domain %u for cpu =
%u\n",
> +				       domain, cpu);
> +				free(d_info);
> +				return -1;
> +			}
> +
>  			cd_map[cpu]->domains[domain] =3D d_info;

If a malformed file specifies a domain index such that
nr_domains <=3D domain < max_sched_domains, does this create a memory leak?

The array is sized by max_sched_domains, so the allocation succeeds and is
stored safely here. However, if free_cpu_domain_info only loops up to
nr_domains - 1 during teardown, any structures placed at an index >=3D
nr_domains (including their dynamically allocated strings) might never be
accessed and permanently leaked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260410220905.2000=
51-1-acme@kernel.org?part=3D3
