Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365BA3D4129
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 18:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672931; cv=none; b=hpagWiEU79Ok6cBOZuFwEp+yjtmwd085+W7Ztz32u3ltkUoLSjMKxla5pPWu9f1VT/y4w2HbX9sqNMEYmdFa/2tYT+/tDx5RWUp/aX2JDuV2pVCsPMKAUikD5I0ecU9c2ejCTVwAp7QDlsL8+VIDDLgredpN8GF8P6a5uIeYSMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672931; c=relaxed/simple;
	bh=/1QX4eJgmVGxDAJxXHEx7bGcPtt4aeNKuznR3mAA19E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XUyCYMNgO5jJLujlyHWuCDKk/BMt0hQp28yX/Koee+9RVANz/MVNa3HMzCoY4k7eQxEQpc9PLH2ZnDWIR7eIsuplArIyQvfRH/ZfmwB4ceBcYzlBfZfYiOiPWzVHr9AC02eTOrMesH7lxI0YKhBzpKWZyoW3bNPXqt9/5vyjVl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsiBIlhl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsiBIlhl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC446C2BC9E;
	Wed,  8 Apr 2026 18:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775672931;
	bh=/1QX4eJgmVGxDAJxXHEx7bGcPtt4aeNKuznR3mAA19E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=fsiBIlhljWAsL8zk3Jy9rjhCcZC5vaN41J3HM8yYMjVPFJy6uBaV1eCFw7F02eaud
	 wDTtPJSBFywoNn2juzD8IAvDpYQG8Cv6NvMRt7tA97mo0+jJcMYJ1EyrVioPLmQQ/a
	 9J+m8JkoHYyuQV8MHWrcgWn++PXana+bdVL/Od7PpxjCX4kTLYRvtvf1/lZEuRGI++
	 dlBwe7WV3ytY1lN/8CgfBOHpGCliPEqcfF9D0wk2LUHhtxnrSbEus9UfT9kf7/f7ag
	 FvfJs6tcXrBXdg8efciQ+gNkk+chYZXdNWew4i9zViGwutzK97Hp/mIEXz8d/kLLtV
	 Q3DdJQWdoVsIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] perf header: Do validation of perf.data
 HEADER_CPU_DOMAIN_INFO
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260408173203.96700-7-acme@kernel.org>
References: <20260408173203.96700-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Apr 2026 18:28:49 +0000
Message-Id: <20260408182850.DC446C2BC9E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Lack of validation for `nr_domains` causes out-of-bounds reads and=
 arbitrary frees during the cleanup path.
--

commit 0f6144cf61c4816d686ec4a1fe5d43fdc14b7669
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Do validation of perf.data HEADER_CPU_DOMAIN_INFO

This commit adds bounds checking for cpu and domain indices read from
a perf.data file's HEADER_CPU_DOMAIN_INFO section. It ensures these
values do not exceed nr_cpus_avail and max_sched_domains respectively.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c

[ ... ]

> @@ -3736,6 +3741,12 @@ static int process_cpu_domain_info(struct feat_fd =
*ff, void *data __maybe_unused
>  		cd_map[cpu]->cpu =3D cpu;
> =20
>  		if (do_read_u32(ff, &nr_domains))
>  			return -1;
> =20
>  		cd_map[cpu]->nr_domains =3D nr_domains;
> =20
>  		cd_map[cpu]->domains =3D zalloc(sizeof(*d_info) * max_sched_domains);
>  		if (!cd_map[cpu]->domains)
>  			return -1;

Could there still be an issue with an unvalidated nr_domains value?

If a malformed file provides an nr_domains value much larger than
max_sched_domains, the loop below will eventually fail and return -1.

This triggers session teardown and calls free_cpu_domain_info(), which
iterates up to cd_map[i]->nr_domains and accesses cd_map[i]->domains[j].

Since the array size is only max_sched_domains, could this cause an
out-of-bounds read on the heap? If the out-of-bounds data is non-zero,
would it be treated as a pointer to struct domain_info and passed to
zfree(), causing arbitrary frees?

Also, if the domains array allocation fails here, cd_map[cpu]->domains is
NULL. Would the cleanup loop then blindly dereference a NULL pointer while
trying to access cd_map[i]->domains[j]?

> =20
>  		for (j =3D 0; j < nr_domains; j++) {
>  			if (do_read_u32(ff, &domain))
>  				return -1;
> =20
> +			if (domain >=3D max_sched_domains) {
> +				pr_err("Invalid HEADER_CPU_DOMAIN_INFO: domain %d >=3D max_sched_dom=
ains (%d)\n",
> +				       domain, max_sched_domains);
> +				return -1;
> +			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408173203.9670=
0-1-acme@kernel.org?part=3D6
