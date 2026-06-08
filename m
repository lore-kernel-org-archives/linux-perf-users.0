Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D324134CCF
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 01:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780883522; cv=none; b=sLg7xqshD2JdAF9ei+ILRjMY3hj2OhXoqNiozQXBXKHyQEJG1Bop5Frf43HJas2buxydJYPRC51ozCYZChPhUeD/0IYr8EjTQy9e7JzSLy6pd9stvTe4BA2GANtyj8I0K1ArPrEr+/TBr3B/+aG1st3Xxvui5RzhQp+HjBm7lfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780883522; c=relaxed/simple;
	bh=/1UviTwdY3nHnF33c6CRJt6CT0Vb1ujrzVTDCfEcaUI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OW2ZattY9mfooXhtSTc5/Us9LRtBuqbsHtUHTGe7bBqDkK4xu4wFNruhW3JBg5i3+e3NcLbDVvQ+egU8wiEw98s+8fllmCERDJflX3HYu8fRT1sQcj0ZXXCyruIWiL7gxU4j3WTNGn7SfKnp/rEC2WF1NSzuPbBdEw0C3ChmkVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggTWBP6r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggTWBP6r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A331F00893;
	Mon,  8 Jun 2026 01:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780883521;
	bh=QxqmS0hJEptT12eBkRYS7clsFIiVl3wN7XMGcmIZGGM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ggTWBP6r4LfDwusImKpb4lPIJqeJRVjVHr603viJ8uBIJ0fPNdv63flJj8wL0z9a8
	 lyBsmB7ZULLFxnUuWa9rXPK6vSv4qpksc481z21KmfcRHEjkuF1zZDpjQERDZbp3aq
	 NXCZ01VWJfdjCmM5Q8RfXd8+MUH1V7RyD6U1PiutzjdvEVSwnUeHn79KGuZOebTSyr
	 yLeJ8SISj7UjeD2I6G6oTgHuFCVFbek1G6cejbeakAAFMgTNd7tDwAX/74WmdU/TgU
	 p7KqkQn4xcY/uK4c/yr5Gg6qTwLXXkJm/e5uNU2YYLl7eBNwsovhWBY543rMEOFxwZ
	 WNsXoc8+TfBXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/11] perf tools: Use perf_env__get_cpu_topology() in
 machine__resolve()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260608013057.1942953-4-acme@kernel.org>
References: <20260608013057.1942953-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 01:51:59 +0000
Message-Id: <20260608015200.D4A331F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Silent truncation of a 32-bit CPU index (`al->cpu`) down to a 16=
-bit `struct perf_cpu` bypasses intended bounds validation for malformed in=
puts.
--

commit 93fba7be75f567784ab8e6d8ce5f966760c09265
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Use perf_env__get_cpu_topology() in machine__resolve()

This commit updates machine__resolve() to use perf_env__get_cpu_topology(),
replacing direct array access to prevent out-of-bounds heap reads from
untrusted perf.data samples.

> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c

[ ... ]

> @@ -835,9 +836,13 @@ int machine__resolve(struct machine *machine, struct=
 addr_location *al,
> =20
>  	if (al->cpu >=3D 0) {
>  		struct perf_env *env =3D machine->env;
> +		struct cpu_topology_map *topo;
> =20
> -		if (env && env->cpu)
> -			al->socket =3D env->cpu[al->cpu].socket_id;
> +		if (env) {
> +			topo =3D perf_env__get_cpu_topology(env, (struct perf_cpu){ al->cpu }=
);

[Severity: Medium]
Does this cast silently truncate the 32-bit al->cpu?

Since al->cpu is an s32 from the untrusted sample, and struct perf_cpu uses=
 a
16-bit integer for the cpu index, an attacker providing an index like 65536
would truncate it to 0. Wouldn't this bypass the downstream bounds validati=
on
and falsely associate the sample with CPU 0's topology?

Also, for systems with more than 32,767 CPUs, wouldn't this wrap to a
negative number and incorrectly fail the bounds check?

> +			if (topo)
> +				al->socket =3D topo->socket_id;
> +		}
>  	}
> =20
>  	/* Account for possible out-of-order switch events. */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608013057.1942=
953-1-acme@kernel.org?part=3D3
