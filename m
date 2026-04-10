Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6D63DE446
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 22:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775860086; cv=none; b=bub7XHg4MLjUpyd+FKHMc7ZpdeUxsT/2/pJ9Na4ncdtn5FM32gA7ZqQibYHerD2TNYFvDaJQ8zXABu40HV5E5JjPI/KYx3O+42F0W0mvjL0SyEJCymMXn20g1mGfzwk9c/sQFoBEVUEhQWhjHalS6THUX0Gkm/soXvdcled7E9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775860086; c=relaxed/simple;
	bh=3Ug9OxPhOpkKgehHAmMWF0eDnJgT7Y0iZmuY37Iv678=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hhNQMT7ltCHiUUWR2ncai/3NrIMkJKOEsWBuCijZn/ZA+ApoHkJAkaJGZaHCHheP7e4o/0/B/r2Us1vmnNFanpmH//jqsTXHhf8rqr0FbnPZ0oH1w3z6nqKqdN1SZbDcNOZJakqn+Dmrd+J9h3numKGYLnm95JMEwerIvQAYqlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlkWqUvU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlkWqUvU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F245C19421;
	Fri, 10 Apr 2026 22:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775860086;
	bh=3Ug9OxPhOpkKgehHAmMWF0eDnJgT7Y0iZmuY37Iv678=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=KlkWqUvUtH5xYn1wN6B/OuCcvdoBRcoqQoTZjvncpLhFcQpT8pnxemGhhIE7yD0pG
	 Ha4M0qa7CqOnIh1RBtECWclQKTm/khiQ9mIu3s/BeBr1JJMqga2yhvpMZECGYYJZg7
	 2Fj8qvnySjI6MzH+jxNnX+Ac5R0JTh/smBkvAjg5k/rIgtqQIpVYV79kyBVKe2h5z3
	 IZhHpGE3OtTjKIH0ERes05haKz/jZF4Dkc50D1r6k80uywory2v6B6wG6Ep+bLQBe1
	 i0FuCYfChV2wRimSdvB4wd/11sCx2XHI207nSFNDSMp3VCOxnvTEI93AyQ8CfVtfyn
	 mFk7xnrCr6EuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/13] perf header: Sanity check HEADER_GROUP_DESC
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260410220905.200051-9-acme@kernel.org>
References: <20260410220905.200051-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Apr 2026 22:28:05 +0000
Message-Id: <20260410222806.3F245C19421@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Zero-length string allocations and missing null-termination lead t=
o an out-of-bounds read in `strcmp`.
--

commit c734f9dc578da0aba3155da45962b841c79c7260
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Sanity check HEADER_GROUP_DESC

This commit adds an upper bound check on nr_groups in process_group_desc()
to harden against malformed perf.data files. It also moves the environment
assignment after validation.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 77035d9b138cb..993e20debd5ca 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c

[ ... ]

> @@ -3132,12 +3133,25 @@ static int process_group_desc(struct feat_fd *ff,=
 void *data __maybe_unused)
>  	if (do_read_u32(ff, &nr_groups))
>  		return -1;
> =20
> -	env->nr_groups =3D nr_groups;
>  	if (!nr_groups) {
>  		pr_debug("group desc not available\n");
>  		return 0;
>  	}
> =20
> +	if (nr_groups > MAX_GROUP_DESC) {
> +		pr_err("Invalid HEADER_GROUP_DESC: nr_groups (%u) > %u\n",
> +		       nr_groups, MAX_GROUP_DESC);
> +		return -1;
> +	}
> +
> +	if (ff->size < sizeof(u32) + nr_groups * 3 * sizeof(u32)) {
> +		pr_err("Invalid HEADER_GROUP_DESC: section too small (%zu) for %u grou=
ps\n",
> +		       ff->size, nr_groups);
> +		return -1;
> +	}
> +
> +	env->nr_groups =3D nr_groups;
> +
>  	desc =3D calloc(nr_groups, sizeof(*desc));
>  	if (!desc)
>  		return -1;

Since this patch hardens the parser against malformed files, should there
also be validation on the strings returned by do_read_string(ff) later in
this function?

If a malformed perf.data file provides a string length of 0,
do_read_string() can call malloc(0), which on systems like glibc
returns a valid 0-byte allocation. Because 0 bytes are requested,
the underlying read succeeds but provides no null terminator. It
also does not appear to enforce null-termination for lengths > 0.

When the code subsequently evaluates the string:

    if (strcmp(desc[i].name, "{anon_group}")) {
        evsel->group_name =3D desc[i].name;

Can this lead to an out-of-bounds read and crash the perf utility if
desc[i].name lacks a null terminator?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260410220905.2000=
51-1-acme@kernel.org?part=3D8
