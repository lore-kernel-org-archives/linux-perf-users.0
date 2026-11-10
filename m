Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794350695;
	b=Ks1JgvygGkfOzSAWydbmQ75nC+aDn7D4YqMrME4i0mzpc8KPf+VDdC8iY4F3VXv7JYtQ
	 ThVhy7Nnx1I15UF8U6ALl5J9xb76254VV2OYn2UCIso20Jue+MlkKO99kjfuY15FCsfTW
	 Qx670Zq7IubFCwylD3DPoLlE4CGDbeHLHFsUj0H1SUAMthfu5NRRrbTNxSWLbgJrIF3aD
	 xC4FDIo2COl3gj6Y9JJWr9VbjITocQWgmYwZOeFdb+w9yEVhfCtT/9x9tCgKyFo5lUUyn
	 nODbJKl1clc4sg1KaGEYqILjR2ULgwwhl6ck/u56ezjVLtkYQ0zwtQLVrQSsjHGbeqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794350695;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5jycLY3tUyJGBm52TxQICMDd398mNfEti+N0RNeRaSA=;
	b=v/l62L8wGFrX42vdF6zd/On+HehyygbRakxgzIjJQwIWCC1uLzfO3BUKqqac3nQ5vZ4P
	 qYIBR0wHt8/KCppzX2RMiYzODo+gH9HyZ701PePsWzv0u2sQtEzmJ95IBTOtdXzZqX4TB
	 fF1JGzHOz22RK+3l491A1t0iz0Uz8xEkWUwTdZCsa8MD38bKjgv9b2cfpjUa8/fk6FVEd
	 u2RkNIsHwEE0QklGaz38KdvVtPJ9NgcBrSvLpkNgOPYDsYiscMjnVLFPPmCi0YZwLI8Wg
	 evyzhMzS6VLnF2Dn87RrqjeQ8B2mf5Ohri9RiIdLvZHC/ZxWUg0+UENVai4eq6v2yqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fwLJb8ze;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADB7606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fwLJb8ze
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB2C1F008A2;
	Tue, 10 Nov 2026 22:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794350694;
	bh=5jycLY3tUyJGBm52TxQICMDd398mNfEti+N0RNeRaSA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=fwLJb8zePhBqrenFTeQaEsK3ZNKSje1yX6xkxHRcVPKN2oqlolD5AkgbHhOLBlI1H
	 yH0uPGwsR07brZOuE0YHk1cpWwwXRLXa053JkXW2/9EKv/0rlQNhgsx9WxEJQETo7U
	 BaXjcM9i7r3qhnP9NDwzn1fPxy5DlCDH4y8GofFbmc45rP9lpFK9tjZn+ir7ittkv8
	 vAXKGJifAbFZ5QJNMDHK/F39zj2K77V8EzpSmHzmbekzSfe/GSTCHu+UKS5ZDn1rhJ
	 8abgTvCs/x1RFgsq6vcuNk7UOjXURFtKMb7PfRr3kTDG7KUwLTndWd0+18CYGBOiqi
	 xLp15nETNlsmw==
Message-ID: <sashiko-outbox-207843@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] perf jevents: Name the metric when a MetricExpr is
 missing
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261110222250.1864777-2-takano32@gmail.com>
References: <20261110222250.1864777-1-takano32@gmail.com>
 <20261110222250.1864777-2-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 22:44:54 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> jevents.py reads each field it wants out of a JSON object by name, so a
> MetricExpr key that is missing or spelled another way leaves the object
> with a MetricName and no expression. Two different failures followed,
> neither of which named the metric: the rewrite in _read_json_events_impl()
> raised AttributeError on the None, and a metric that got that far reached
> print_pending_metrics(), whose assert fired on it.
>=20
> Raise in the reader instead, naming the metric, before either of them can
> happen. The check is not inside the '-' test that decides whether a metric
> takes part in the rewrite: a name with a dash in it can lose its
> expression the same way.
>=20
> Two smaller changes on the same path:
>=20
> - An architecture standard table that does not parse now carries the
>    reason in its message ("Failure processing '<file>' in '<dir>':
>    <cause>").  The traceback used to end with the file name alone, and
>    only the chained exception said why.
>=20
> - A table that does not parse is reported on stderr with a "jevents:
>    error:" prefix instead of on stdout, where it was mixed with the
>    generated output.
>=20
> And the output file is opened after the tables have been read, and not by
> argparse, so a build that fails while reading them leaves a file the
> caller named as it was instead of truncating it to the header.
>=20
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110222250.1864=
777-1-takano32@gmail.com?part=3D1

