Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0633E3E410C
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185851; cv=none; b=Lsv2Bztd4ycCo9zzqJjTmKZ6wc8N1RoQ++9xzxmdm82MNB/I5CQ6ry9xMfEK/3yQL22oGXJA37xejgleVAnZc+1bY+4gb4pZDUilTsuPjme23SYqFD3wiRJr6IX1ovV7jG1iTM6n/jA07MoTyruiXk90ZbUQqEDfz1zkC05t8qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185851; c=relaxed/simple;
	bh=fjl4djq4fVtL5TtB+YKeYLaJzxhH7nEEMr64uKwhO1c=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=fJY2abiYE90hiCYzugvUoJTpk7xO0ChVhTpGGKiknomPFRcN90cW6H1SwJCFZOHe4cOj8j0+E8noKV5cqL36iPvZzexYbfE+7Bd2ZvFoAT+VV8m8uOVfWN2rjIZGKxFszSCyDSd9PNKpWYMTJ+IctD+UgK8PR98sDzb/X/O18Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X953IgP2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X953IgP2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723A41F000C4;
	Fri, 16 Oct 2026 21:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792185850;
	bh=NVnH0iOlfElR3aIquapSVnk06oU5zYimV0jqnTwi7VQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X953IgP2wnyugoaFPxsJAAiHiz89/KIE2EY6rO+fi0XVXhSBr6EjKlnCollBCuiYa
	 MXRJq7sv7DINs922qoaD1aWqH9TqObWnGT34w+VRbfRz6kH5flwt4fAIydGY7Uyde4
	 wF6NarwNXc9weYvTfIUYDSkvAzmEIXeZloinKLUATV6F6kavlJXvfNIDWycUwdXq88
	 nvUdw4tR/WzHuW8GWJO5OqBdSt5b53xBA9+4nT8EOwNkKu0ULJA4cElmi1gweIffuz
	 +WS4z+/Hi79tt8Pz+zkY2LpVg7jpqEpvYwYxYbUVHcfWUFSTPbc6oVrTiQiDK08qCd
	 /dJu/YYeijzUg==
Message-ID: <sashiko-outbox-174955@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/21] perf test attr: State, spelled out in a line,
 why a test is skipped
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016212102.76550-17-acme@kernel.org>
References: <20261016212102.76550-1-acme@kernel.org>
 <20261016212102.76550-17-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 21:24:10 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Per skip the default output shows a self contained one liner:
>=20
>   unsupp  'test-record-branch-filter-any' exit 255, expected 1, no attrs =
recorded to verify
>   skipped [kernel newer than 6.12] 'test-record-group-sampling'
>   skipped [arch =3D !aarch64, machine =3D aarch64] 'test-record-graph-def=
ault'
>=20
> The extra notes explaining the reason, with a copy pasteable command to
> observe the failure, come in the very same stream when the verbosity is
> bumped, at -vvv, nothing is written to a separate place for later
> consultation, it is just the logging ladder:
>=20
>   detail: '/root/bin/perf record -o /dev/null --no-bpf-event -j any kill'
>   exited with 255, the expectations want the workload's 1 exit, so there
> [ ... ]
> The command suggested to observe the failure writes to /dev/null, so it
> doesn't leave a perf.data in the directory it is run from.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016212102.7655=
0-1-acme@kernel.org?part=3D16

