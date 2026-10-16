Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4122A3B42D9
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 21:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185894; cv=none; b=J2bNBFduvuu3LToKVQHsc5m5CUKBvPQAS/8WLS+btuUkiSoSQKMnBmcf/7VY8We1lFECqPn9mr0gynCZtB/Ofbknad7ODsfEa23r5zrDVjh94+0Bc3X/hS9ZHwOpl0uvZKXc8gN+wwkmcynSl6M9KqtTQ1slPwXbvmkqWANAUtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185894; c=relaxed/simple;
	bh=cA/PKmGKWHxcm49IkbhFqBwLYek/JR1mnYusm2aa/L8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=M8xagkHKlu1/jx5i0tqeOgW9Dk9eUayxVU+5q9JIDzEPX8OnVLDwSythzG7ayuV+lP1yz++PfVdjsdvdcRiN0TmsOJ8wzpwYgGs4sSKzztSJBsbVFq/IJZ9F2hAY+fuo2Mil1Gl6l7swSpa884WDsHkh/ErZicSxJlvzZ4dkQes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoTeSGGS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoTeSGGS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037281F000C4;
	Fri, 16 Oct 2026 21:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792185893;
	bh=QN9q77dRAnw0DVhiebGcfjK95h0aZRTLw+zPTGQ3vgM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EoTeSGGSJlc5W4Jci6q7YKOqrDam7mLhRZB3/eh6eFnIBA/L8HAHBgMu31cOW9ctb
	 W0IK6oCd55tO0Os9lGutuSWEbHdLJ1PPmYhxtmlv8KvsihlpBsN6iKsAvSOFDmHKMt
	 ShkKXquKLrAQjPTNYYG6VTXjJvI8YqDqj8u6+p1nHTHGwa07Cy2d9K6ML5LQ1qwcbD
	 agjIkF2j8T9QKN59jJM4IYoOcr8acOlveGKfu29Y6NUHvDdUIwl/KTFW9oYqWrrd+j
	 n+ca3dPRLLZxwvG7ZgU+h/w7r0Mgs8wS4AMDEifDgvT16ydANJ148WgGaZoWpJg/Su
	 Y+gMxLWAFULsA==
Message-ID: <sashiko-outbox-174959@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/21] perf test attr: Accept either sample id bit
 perf asks for
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016212102.76550-13-acme@kernel.org>
References: <20261016212102.76550-1-acme@kernel.org>
 <20261016212102.76550-13-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 21:24:52 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> evlist__config() asks for a way to tell the samples apart,
> PERF_SAMPLE_IDENTIFIER where available, PERF_SAMPLE_ID otherwise:
>=20
>   bool sample_id =3D opts->sample_id;
>   ...
>   if (opts->full_auxtrace || opts->sample_identifier) {
>         ...
>         use_sample_identifier =3D perf_can_sample_identifier();
>         sample_id =3D true;
>   } else if (evlist__nr_entries(evlist) > 1) {
>         ...
>         use_sample_identifier =3D perf_can_sample_identifier();
>         sample_id =3D true;
> [ ... ]
> values as they are, nothing to un-mask by hand to see what is being
> complained about.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016212102.7655=
0-1-acme@kernel.org?part=3D12

