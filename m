Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D90F330659
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 06:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781505177; cv=none; b=gqliMRaCYXG9hL6XVfgNhEsSYflk1IG8Q9Pi09CqIDBzbIzzC9aofwZmVElmsmgWZ+qumHX/sv2nA/WiUX4C+RLw+fT0wL4MuoVKB9Mza6v6t/Hft/66m/idH8srZ36M18NDycqS36q4Mo1//kjFOQU9GaRB4VCYbbyJUrBvqZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781505177; c=relaxed/simple;
	bh=zxFNneFqTRepfjFAt2SBZSX70GpNroj3sC2WHOaNF+A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cUikY4IncPtGYM80VRuv5WPDcUyRNnixGg/fLzN9iSe1GgXmPo7bObapc6xMbdyyOVljo7xoMrPYuSxfoOyFvLoOtY1JGgEHfec3m32ewncHMVqUX1CtNYe7o7S03V+pYVDNYiLd3rvgj6KbATgFvyGgyWIXYLee50IeXMfqwgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aH1pAYHw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aH1pAYHw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BA11F000E9;
	Mon, 15 Jun 2026 06:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781505175;
	bh=F3dNHyE4c6VGh513y4QMOhQligxGYhb8g9N+4HuD2NY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aH1pAYHwfcs6SC6Szazh1eKwYtc7/OMCxjVy6f+EOlMbIy0Kzv/IPchs+bG+LDBEM
	 AfQ97rVeWo9igQJSI3cPBeIHxKEsOyvw609G0bKGy6DJDbChFncv2g9vryf/cHEKSv
	 QpMsctdj2LxvLi7MWTiEqXPFr7RqIsm6RbdEU+/WbIJB+BLmlIq9b/+dcdjzFKmatH
	 oZsnSeKZQfB+1j+tk9T30JDTWrRd1bDa+F/S7G+qzgx3t2GX1rkiCKL8YM9Kdr1/8c
	 xWN+XAMl5D4evX5Nxj/W7kna2peVBvBpaeJ5TDtWtrLNPCPgiJ707ZWvMs8LuP8OyQ
	 vHpkE9iKKFwcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 04/20] perf data: Add open flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615061631.2382079-5-irogers@google.com>
References: <20260615061631.2382079-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 06:32:55 +0000
Message-Id: <20260615063255.B9BA11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If rename() fails during perf_data__switch(), the original data fi=
le is truncated and all previously recorded data is lost instead of continu=
ing to be filled.
--

commit a0b3375203a55f3480fde4ba60f2092e9ceac100
Author: Ian Rogers <irogers@google.com>

perf data: Add open flag

Avoid double opens and ensure only open files are closed. This addresses
some issues with python integration where the data file wants to be opened
before being given to a session.

> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c

[ ... ]

> @@ -457,6 +473,7 @@ int perf_data__switch(struct perf_data *data,
> =20
>  	if (!at_exit) {
>  		perf_data_file__close(&data->file);
> +		data->open =3D false;
>  		ret =3D perf_data__open(data);

[Severity: High]
This is a pre-existing issue, but if the preceding rename() call in
perf_data__switch() fails, the code prints a warning and intends to "contin=
ue
fill original file". However, we unconditionally close and reopen the file
here by calling perf_data__open().

Because the rename failed, data->path still points to the original file.
Looking at open_file_write(), it hardcodes the O_TRUNC flag:

tools/perf/util/data.c:open_file_write() {
    int fd =3D open(data->file.path, O_CREAT|O_RDWR|O_TRUNC|O_CLOEXEC,
                  S_IRUSR|S_IWUSR);
    ...
}

Does this cause the existing trace file to be truncated to 0 bytes,
destroying all previously recorded data instead of continuing to append
to it?

>  		if (ret < 0)
>  			goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615061631.2382=
079-1-irogers@google.com?part=3D4
