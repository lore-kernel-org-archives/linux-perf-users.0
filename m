Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0986B1A6822
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 06:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791094299; cv=none; b=C1OGoSKB0SFo8HsXtErf5c9MLSWyUTWTRkxXQE0EEhnTTRRenpJInka0vZaEtU+lyhvo4F7Qkpa6IzMPjG3ZzpqAPS3D4v8MSkrgMZkFCXy7nw7xoaf6YK0WfvTYKSqtLUvkwq9PvK6TQkleVJjKZrVc2wFYemVdy5yJeMHxSPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791094299; c=relaxed/simple;
	bh=UAr2rXETEow067z6s0QESdZd3tCpphMV7HOIHNNsn6Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ek1Se62VxuggnyzuRaUU/H3TWWX2ojhICi4ezcgHhqhwFXJAxDHEMjxt/TLy69DbqgHNF59ysvVT5WgM5mBZQta7sP52WwYZvOsFZRk0clZ2OJEfwrBUJ6yuQuDlA9CElhOWCbo9PkNBV7gJn0QH5sFOJWvWkLYZkZzVqQqvrLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYoecxUn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYoecxUn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A9D1F000FF;
	Sun,  4 Oct 2026 06:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791094297;
	bh=hK7CpXRmZIfovb/4zC6yg2mUV0Nuk8jKcOFuwTAqxng=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IYoecxUnVuefMX7v0zC4yuP0DW5QFyZO52IuWeBj7JVjE84yZwV15buJ8Z718Y9jX
	 22BuW6sWjWlEoCe7aC6KIWzRh1nHn5fsQo/UU7Sn00GzNbTbPb7RjqBEpgufq8YjKN
	 yJ82YktQwBve/efWFsOp8dCTjjMo+lWomzScd/mlGv8glNb22PoM/N3S6wMUU7zt93
	 FWvLsquuwZqkM9H4rJhl5QyEFjh16yOKLFf4IvGuq4oL0x47psPdiaXxLSSzKNX/HJ
	 SJb628FQSI4VQApBmtQGe8LcAM62ZjrEXmW2eY1tLUeovT2CZF5KkZBGxkZF6/pc4J
	 uc3g69NyZ+sJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 9/9] perf test: Add false_sharing workload exhibiting
 cross-CPU false sharing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261004060457.3353-10-acme@kernel.org>
References: <20261004060457.3353-1-acme@kernel.org>
 <20261004060457.3353-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 06:11:35 +0000
Message-Id: <20261004061137.81A9D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Add a 'perf test -w false_sharing' workload that hammers one shared
> struct from several CPUs, shaped as a TCP connection: a read-mostly
> identity (five-tuple) shares a cacheline with per-packet rx counters
> (the false-sharing line), a second line has packet-path private tx and
> congestion control counters, and a third the connection config.
>=20
> The packet path runs in the main thread and up to four lookup threads
> sum the five-tuple and pull the config, reading one volatile shared
> instance directly so the accesses are PC-relative and resolvable by the
> data type profiler.
>=20
> Data type profiling of the workload with cacheline info:
>=20
> [ ... ]
>              0.00%   0.01%        struct folio +0x34 (_refcount.counter)
>              0.00%   0.00%        struct folio +0x18 (mapping)
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004060457.3353=
-1-acme@kernel.org?part=3D9

