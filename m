Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CB735AC03
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791135402; cv=none; b=f0A6lZD7kYl8sG70gdtC0YVjLeN3btwSXh9XEwqkQ3YVrANgQBTR07xOgjFXnYg3Yjyz2U0i7REsyPpaCIFzzJIDm6Rct9ogHqCrFLT6a8wBscJYv+IUhPWFg/vwXVbewKRg7gQsXINgPuWlEn98ehiQZY1oib3kxxPDnWnuUuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791135402; c=relaxed/simple;
	bh=SDvjbS/9dN+HJKoij8jDxlR7Wezv4VSqTQcrLrRHdr4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=caLGlB4xvSUUlWF2rGtWPPVuArZOEKV1w0431hTvZoWK7rXpzC88aSvLGxoPLPAzV9+j7RxqPkg6r39EN/V2Wh+4yIhjRS6KfDUHqiCJ25VXm8nXmTsRfIEMDqpH6BJevEWwiU+tEs92d8YNyfvy6p09QSzx5qCTBGkJc1yO0rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2YzTAs3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2YzTAs3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931AA1F000FF;
	Sun,  4 Oct 2026 17:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791135398;
	bh=FjGI9D8nWRzKDjaPG+xO7B4ytLeENUsCO4mEvMdu11w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V2YzTAs3KC+FBpq3EH7dr7qZjwNj47MW5RKxtnW33cBxNFuJ6723HtEt9nJuqvHVG
	 9r2jOH0Z2gvOI45iiss1+Up6WK/iKFWv9wVY8MmjRSp3TMhIOJRC8XqdFYly2hKVCl
	 EEB6AV8N5XF3e6D5yZ68ETi1dZ8WQ0aLKDxS4FaAHp2M9ySp0O9wfLTIPmYkW0jjir
	 0qKC55v6tfY4tZ4YIYNnzcvJ+QNx9JyzDbwulodviCIClCZBKZmHlWk5Fq2Wwm94f3
	 SBqKJgNoz2qIBZAd+fKlkR+IzaeM0SmJIqM5kWBjBc4BZTjXr34t57GLEUi8b8jzyl
	 /X7MmH+8IZE0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 9/9] perf test: Add false_sharing workload
 exhibiting cross-CPU false sharing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261004173000.2863935-10-acme@kernel.org>
References: <20261004173000.2863935-1-acme@kernel.org>
 <20261004173000.2863935-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 17:36:38 +0000
Message-Id: <20261004173638.931AA1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004173000.2863=
935-1-acme@kernel.org?part=3D9

