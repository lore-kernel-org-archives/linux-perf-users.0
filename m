Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB358221FB4
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781304707; cv=none; b=XWfTtSXhFDgqQI9wpMcJY0vM7+WiyE82pd4olW1QBrSq6Jf+rvigyjSEuwbV9itAHA0CNoQPKwK3N3b3jN4N9mQ6Q04MiFEJ4gFrT1SkjKMOoGP/VLgQR7sgmYVzJbycrJ9G2Z/ik845jUi03Tpe4YXKNKGsyIWOxDv0W/rDLcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781304707; c=relaxed/simple;
	bh=SXWjYTdxtrz+x1uSQlKWQd3zVCK4Znu1YQXL/SP3ut0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W3iCmb7XPJAxIoLZ/a3YxP6m0GQO2OFpIGAPiNrvw/AOF8t0mYDb1yUal0uQJ0hzst29pn3VuB+nFwHcddUICN9E8wC2QnotBCbLINiWVCmt21mZuJbLvF2lo/HFBSYrcv+4rWqQw/0panlsMGN94x35HU1m83XLEapZoKNON6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njnYo5FI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njnYo5FI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4371F000E9;
	Fri, 12 Jun 2026 22:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781304706;
	bh=KZxUXNSwr5uFnVkcLEa5KMbvg9TwmN6K18/QT4ihg3s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=njnYo5FIXvVjhFt078nqaVOAZqtuUQH6thDje1ILCjUvcG9fhQ660586ICE11nfL7
	 NQrJybhTBjEcRVe1eJL/O72eSmvjdiT62YCv8Qk9v4UGkdZkejkTPFNNYYPk+mYqI7
	 BxryhOm2aXEMM+hf2eAu+NMPPWlcDwePdFEPAciPEYOffnf9DxKCrFCg+MX6qCkPV5
	 HScSeEbHPZ6g2cudpdxNkff2QM6G52wPWtpqxAVLJsac7XuyBcAUekmWvZ3KWut5dZ
	 88LCYMwHSX5n0VBB3OIan4aZfyEGQBl5f0gR1z3RmS0SNBcH73UdP6QsxY/ptMxyHA
	 IM3/FATifi8DQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/13] perf cs-etm: Reject CPU IDs that would overflow
 signed comparison
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260612222413.40791-14-acme@kernel.org>
References: <20260612222413.40791-14-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 22:51:45 +0000
Message-Id: <20260612225146.4D4371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Integer overflow when allocating the `metadata` array using an unv=
alidated user-controlled `num_cpu`, leading to a severe heap buffer overflo=
w and arbitrary free on 32-bit systems.
--

commit 485dac05154448b657087d80bf132fafa9c32fbd
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf cs-etm: Reject CPU IDs that would overflow signed comparison

This commit validates that the CPU ID from perf.data fits within an int
before performing a signed comparison with max_cpu. This prevents an integer
overflow that could lead to an out-of-bounds access when indexing the
queue_array.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 5e92359f51a7c..0927b0b9c06b1 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c

[ ... ]

> @@ -3468,7 +3469,13 @@ int cs_etm__process_auxtrace_info_full(union perf_=
event *event,
>  			goto err_free_metadata;
>  		}
> =20
> -		if ((int) metadata[j][CS_ETM_CPU] > max_cpu)
> +		/* CPU id comes from perf.data and must fit max_cpu + 1 without overfl=
ow */
> +		if (metadata[j][CS_ETM_CPU] >=3D INT_MAX) {
> +			err =3D -EINVAL;
> +			goto err_free_metadata;
> +		}
> +

[Severity: High]
This is a pre-existing issue and was not introduced by the patch under revi=
ew,
but since we are looking at error paths and validation in this function, can
the allocation of the metadata array overflow on 32-bit systems?

Earlier in cs_etm__process_auxtrace_info_full(), num_cpu is extracted from
perf.data:

	num_cpu =3D ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
	metadata =3D zalloc(sizeof(*metadata) * num_cpu);

If a large value like 0x40000001 is provided on a 32-bit architecture, does
sizeof(*metadata) * num_cpu wrap around to a small allocation size?

If metadata is undersized, wouldn't the subsequent parsing loop write out of
bounds:

	for (int j =3D 0; j < num_cpu; j++) {
		if (ptr[i] =3D=3D __perf_cs_etmv3_magic) {
			metadata[j] =3D ...

Additionally, if we take an error path (like the one added in this patch)
and jump to err_free_metadata:

err_free_metadata:
	for (int j =3D 0; j < num_cpu; j++)
		zfree(&metadata[j]);

does this read out-of-bounds pointers from the undersized metadata array
and pass them to free()?

> +		if ((int)metadata[j][CS_ETM_CPU] > max_cpu)
>  			max_cpu =3D metadata[j][CS_ETM_CPU];
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612222413.4079=
1-1-acme@kernel.org?part=3D13
