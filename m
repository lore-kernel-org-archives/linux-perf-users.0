Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC863EFD3D
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 21:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185853; cv=none; b=Iap4RD1R7OeTU1qcdncyYpI8BE4rUA907q9m+HVMCrrxC8Z+/VXLU9Vfi/du6IO6XOHKjnLZ10/BPc3zlmwEfrwfVMcTDwz+IN/7pvLOhR8814YpINmDEHztwt3F9Da8yAZhL0vIk8Y1XcT1vZStm3aBFBjwp5rVyQSclHtZSB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185853; c=relaxed/simple;
	bh=p4VWPGuV3sBXN9xqK1EIGaKnmpU8kh53fcBcyauuRmM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Ji9FkfBg6qPyLtKOehZoMCzpVjbtoZuh28DxxgoilXhyAFHoUlV+QQ5GpiV6MNrNb50fO2flMpbCZsiDOFQWjzag7yhj+xcloRO8nBbknlpXSpva2fODQDlgY8yUkta763/S3JJSj2Ewx+P5B+pyWADX9VEByDf9svARc8p9yZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZbRZj/B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZbRZj/B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54421F000C7;
	Fri, 16 Oct 2026 21:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792185851;
	bh=wWYnhCOCGRGniHlzMztldLrQKPaWkt53x9VY26aGxHg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LZbRZj/B9v1sWYe9TXB7XV7uysTcBYvp+ttDLJUeMPpR6puGLXRQeL3ypAdDc1ytp
	 RcsO8DyDsBSDNxKokK5/bX9m1x6AgxZ1p+3vvY5i9W7yQf8cf0Jq2+2uSFLZG5WlAf
	 tifkWku8QEQEw6tVZ9okIYFO9HlxFYDUT7+7D13JsUdR54bmbZ1EGyW+o1v5Ncqe7N
	 jJC+1q9UDncvTaCT3AfXWdopOayesGWTv6m/4HevIBaO5UbBfcuHGf2sx90/djG06v
	 ASqTTL5s/C99Tj/NQqX1rgVIKhZIzNfpjUYkluIOwGDn8HO9OGJhD+YVOxAaEbXQmL
	 MjGZqfLwbC2fw==
Message-ID: <sashiko-outbox-174957@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/21] perf test attr: Ignore the group read_format
 bit the PMU count can remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016212102.76550-16-acme@kernel.org>
References: <20261016212102.76550-1-acme@kernel.org>
 <20261016212102.76550-16-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 21:24:11 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> read_format's PERF_FORMAT_GROUP bit asks for the group members to be read
> along with the leader, which aside from this bit is verified with the
> fd/group_fd based group checking in Test.compare(), and with more than
> one core PMU a group whose members are pinned to one of them, say
> 'default_core', leaves the clones for the other core PMUs without any
> members:
>=20
>   $ perf stat -e '{cycles,default_core/legacy-hardware-config=3D3/}:S'
>   ... the A53 leader keeps its cohort, both A73 cycles clones are alone,
>       read_format 20 instead of 28
>=20
> so that bit isn't there: whether it is there is a consequence of how the
> evlist got expanded to more than one core PMU, not of the groupness the
> [ ... ]
> when the evlist has more than one event even with a single core PMU, keeps
> applying.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016212102.7655=
0-1-acme@kernel.org?part=3D15

