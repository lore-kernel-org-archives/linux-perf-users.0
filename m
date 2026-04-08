Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8F927979A
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 18:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673536; cv=none; b=LJGkzSdpEE8H0H5vhUeUghZpM/KK9Z4Pv/kMU8gWFBtgsBgIY2ydjKKf5P9Kxbwbrb97tzdKhOZ/x2Y5jNnVOx49oANliwvIQIxoeIJ4Dabk4olImLU9+FH0YbQMuvFLadGra6S36WZrWYRpaX3riheNhnYSeiVLRPXMEDOqLMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673536; c=relaxed/simple;
	bh=LMp4WtZVka4RZjrt9yvRKkC7ZLhwqZKpeoN7+0r1n40=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sdC6kxiIABTWppY0TSsqVY5nDXkeauJWn/xuC1k3bMPiCfIMRY1/NwNUSu+I+ooioLMSplvJ+8i9NaSZoEkxhbHs5Xr23I/bCxtvKVPA3Ab3fn80w7/FLSvx4ojw571GgnuyYVtdCLYHhVXreZy1jQUwXvmYuMy50kfQV1HjSjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMqC0gLS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMqC0gLS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA3AC19421;
	Wed,  8 Apr 2026 18:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775673536;
	bh=LMp4WtZVka4RZjrt9yvRKkC7ZLhwqZKpeoN7+0r1n40=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=rMqC0gLSIBd3K/VyDJcKwPVz8isXzN8Xf7wKF3BzGYS8fI+xf1wccih9+GVbQUF4v
	 Vt+BGYMTi8HRZBkNeT7Vb2iLPaKCg/DTvPsDSKK9GszQbZH1V+UHhT2VUHnAngxPax
	 CgqD1WPPB1a/dpcUJECEn2NLwm1P9YDggNVBBn9ZJ3x9vq8hXMm3uIEprXdqCrUHLO
	 96LlkhgpkYKQSRSUrOpZXIjoT6Me+/X5zxpY6XCENi9Z/kPMNMwfnSDU0AmPorT14f
	 AHSv1m0dyhvSciwqiRQs+N53F0S/UpfLXqegJE7rcECdAqA53Bi1q2bs7ReO338zPw
	 VzzI+SEqUPibg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] perf header: Do validation of perf.data
 HEADER_CPU_DOMAIN_INFO
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260408172846.96360-7-acme@kernel.org>
References: <20260408172846.96360-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Apr 2026 18:38:55 +0000
Message-Id: <20260408183856.0CA3AC19421@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Critical] This problem wasn't introduced by this patch, but the patch fa=
ils to completely validate untrusted data from the `perf.data` file, leavin=
g a critical out-of-bounds read and arbitrary free vulnerability. The bound=
s validation checks `cpu >=3D nra` and `domain >=3D max_sched_domains` but =
misses the validation of `nr_domains`. The variable `nr_domains` is read di=
rectly from the file and stored in `cd_map[cpu]->nr_domains`, while the `do=
mains` array is allocated with a size of `max_sched_domains` (which is also=
 read from the file). There is no check ensuring `nr_domains <=3D max_sched=
_domains`. If an attacker crafts a file where `nr_domains > max_sched_domai=
ns` and induces an early exit (e.g., by providing an invalid `domain` index=
, which the patch now explicitly catches and returns `-1`), the parsing fun=
ction aborts and the cleanup function `free_cpu_domain_info()` is invoked. =
The cleanup loop iterates `j` from `0` up to `cd_map[cpu]->nr_domains - 1`,=
 reading `cd_map[cpu]->domains[j]`. This reads out of bounds of the `domain=
s` array, interpreting adjacent heap memory as `struct domain_info *` point=
ers. If these out-of-bounds values are non-NULL, the code calls `zfree()` o=
n their fields and the pointer itself, resulting in a severe memory corrupt=
ion vulnerability.
--

commit 5c7601d84031087ca2a9bfeeedd3934e8e426309
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Do validation of perf.data HEADER_CPU_DOMAIN_INFO

This commit validates the cpu and domain values read from perf.data files
against nr_cpus_avail and max_sched_domains. The newly added validation
prevents using out-of-bounds indices to access the cd_map and domains
arrays.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index a18f216f77c27..4925e33778b91 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c

[ ... ]

> @@ -3736,6 +3741,12 @@ static int process_cpu_domain_info(struct feat_fd =
*ff, void *data __maybe_unused
>  			if (do_read_u32(ff, &domain))
>  				return -1;
> =20
> +			if (domain >=3D max_sched_domains) {
> +				pr_err("Invalid HEADER_CPU_DOMAIN_INFO: domain %d >=3D max_sched_dom=
ains (%d)\n",
> +				       domain, max_sched_domains);
> +				return -1;
> +			}
> +

Does this code leave nr_domains unvalidated against max_sched_domains?

Earlier in process_cpu_domain_info(), nr_domains is read and assigned to
the map, but the domains array is allocated using max_sched_domains:

	if (do_read_u32(ff, &nr_domains))
		return -1;

	cd_map[cpu]->nr_domains =3D nr_domains;

	cd_map[cpu]->domains =3D zalloc(sizeof(*d_info) * max_sched_domains);

If a perf.data file contains a nr_domains value greater than
max_sched_domains, and an invalid domain index triggers the new return -1
path shown above, could this lead to an out-of-bounds read during cleanup?

If the cleanup function iterates up to the unvalidated nr_domains, it would
read past the end of the domains array. If these out-of-bounds values are
then freed, could this regression result in an arbitrary free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408172846.9636=
0-1-acme@kernel.org?part=3D6
