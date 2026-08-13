Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921A8248886
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786582810; cv=none; b=nN3KEAo0Q/rlpqLfy5b4qz1WnBw9x3TbdNbwSikGMDCgR3dX8xp2Zqh9f012tRPPTCtVsucvSR+rU8gEYSk4wxAblqxRGmlTIr1UZtR76CXrRMgG9YyGuvydaHOMY0ePlp/0hLeq/RTJkUnPOM2y8OtuPL6vW5CE968Ha8ydCW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786582810; c=relaxed/simple;
	bh=zEadxPtCGs6HimxtbaqdNmASxgtTFCOs0v92eni9Ozc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DfSf/VNrAu93mhCul+LiBrW24A2qFIbjxfYzPfFXga6+4+TTvsOC10Dc0HNQhJwfI/Y9Xwt/ETL5/M74jBEHk7R5W8ZSH1gLy3Dmj5kn5v29lanL04dmGOHU1R9dgqXBRCcvwHuoaXbpUQIInXaQqavFY7rZZY1vVJAaTwdmao0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEZKygJ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEZKygJ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B691F000E9;
	Thu, 13 Aug 2026 01:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786582809;
	bh=lAf10lou2NiO20iEPcwuXIyCaWGx50kY5P9d7ZEZcFk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iEZKygJ4rpgph/Z/F91gvR7Qd8Vv1rFwnTHDNfLgmr5Qh2PLa9wjWxzGkbzX6r9vQ
	 Dj9uPWSIkR3RPn49TjwsHhMDFI1abVkFpt8JCDqeqOX1Jc/PjvhkrJNQQtBFzFFtOy
	 mC7c/d0IvSAk2ob/byqH69nPOL0SrjwyQ5hSlQQp1day5ZVJF4K6wRdTu514H9n/+0
	 VpUw7W2q9wgeirhoGnHMoVQjXd1vZeY2d7MbRJDMmd/nIEwc383R27oqs0LiCWJ1YE
	 hM0M1Y9mClotIgXueO0SRzfEbJlIHva5XkwWHB8qbmsgCBovL5VYy6uKIN9y+8Ipbl
	 oHV6Hstf9GAGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] perf dso: Use stored fd error instead of stale
 errno in file_read() and file_size()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813004927.16738-4-acme@kernel.org>
References: <20260813004927.16738-1-acme@kernel.org>
 <20260813004927.16738-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 01:00:08 +0000
Message-Id: <20260813010009.10B691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing explicit inclusion of `<assert.h>` for the newly added `ass=
ert()` calls, violating musl libc compatibility guidelines.
--

--- Patch [3]: [PATCH 3/5] perf dso: Use stored fd error instead of stale e=
rrno in file_read() and file_size() ---
commit 9359e4a3d3517acb5c94e232e0f7e3c94b3a7824
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf dso: Use stored fd error instead of stale errno in file_read() and fil=
e_size()

This commit updates file_read() and file_size() to use the negative fd value
as the error code directly instead of relying on errno. This prevents issue=
s=20
where a stale errno could incorrectly appear as an EOF rather than an open=
=20
failure.

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 124193453675c..c7fb9e1d07f14 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1029,7 +1029,9 @@ static ssize_t file_read(struct dso *dso, struct ma=
chine *machine,
> =20
>  	if (dso__data(dso)->fd < 0) {
>  		dso__data(dso)->status =3D DSO_DATA_STATUS_ERROR;
> -		ret =3D -errno;
> +		/* fd is always negative here: -errno or -1, never 0 */
> +		ret =3D dso__data(dso)->fd;
> +		assert(ret < 0);

[Severity: Low]
Does this missing include break musl libc compatibility?

The perf subsystem guidelines require explicit inclusion of POSIX standard
headers for any libc macros used. Could you add the <assert.h> header at the
top of tools/perf/util/dso.c to ensure this compiles properly under musl?

>  		goto out;
>  	}

[ ... ]

> @@ -1151,8 +1153,10 @@ static int file_size(struct dso *dso, struct machi=
ne *machine)
>  	try_to_open_dso(dso, machine);
> =20
>  	if (dso__data(dso)->fd < 0) {
> -		ret =3D -errno;
>  		dso__data(dso)->status =3D DSO_DATA_STATUS_ERROR;
> +		/* fd is always negative here: -errno or -1, never 0 */
> +		ret =3D dso__data(dso)->fd;
> +		assert(ret < 0);

[Severity: Low]
Is it possible to ensure <assert.h> is included for this usage as well?=20

>  		goto out;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813004927.1673=
8-1-acme@kernel.org?part=3D3
