Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352F2296BAF
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 04:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792124080; cv=none; b=DMzzw8LErFL+OpZ0kLvBAD8r/Fupw0JkPXlS+dkT+W1xRd7apTeBPJsgmxof9VYZcvfuDdWyvCfzxU++NqFL3ievtvNrv1zE68NEBSzFrpRWbBBeqcLdp51SHKA11iNGh4yz0npB+F1L7R9uOIHk6LhZZQaZZEocPDjlSy81dDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792124080; c=relaxed/simple;
	bh=Fi+J+osdGRq/GqaOh9NWnEU4XkOQ9wq3nDWkMg59+dY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=uvFtm7xCBTtxPaV0IHYQMd6Iyeu9PQmngZp2tnBAWKgVJaNpeV1wrzq6ddnBSKMR1mi5X+kPk6E7Dwk0zwD9AleCRtNlxLp9jCbXJHVnBQl71mT7Cgcf0fFUKGuObNcaK2yhygpBU7D3ij+R6Fe2OYx3mhZcDqwBlImMNhUPh7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqVYcF7O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqVYcF7O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53F31F000C4;
	Fri, 16 Oct 2026 04:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792124078;
	bh=Wl4HPo2IXRlV6SVlR1AzAWkKHd3B+x8J2hE3rD84E8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bqVYcF7OULXYh0F2snXAv7mvVgQHXvbpVDX2jWzsgL1rqhfcfpspRmTcd6/SfpiIb
	 xOArKy3BgNxEFamzLJ/u6AP6qypoEGiCOXhPD5Kt77Lj6aRfscLknCZdZsUKZ6wXy9
	 sSakOZp3t+uTUuLwNr/R0zSHfvqa8nljbdvHJrybXddXfM5MdqX6FAWpwm51EXOm+N
	 2ZuBacpdf6et84JBDQru0FyUQQBMCZs8axa/08yd+rIndChZxyBJDKIe19LJC8obJX
	 05FY2iqvOA+HMyX1m3Dn2oL6ao/2/auH0cJ2bp8SNChQW3Fu1V7qCvdApcmPHstPcf
	 EeDhFjRnXrIPg==
Message-ID: <sashiko-outbox-173751@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v6 2/5] perf ftrace: Support filtering
 return address comments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016040310.482876-3-atomlin@atomlin.com>
References: <20261016040310.482876-1-atomlin@atomlin.com>
 <20261016040310.482876-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 04:14:38 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When tracing with the Linux kernel's function graph tracer, enabling
> funcgraph-retaddr records the return address of each function entry as
> a comment in the trace stream (e.g. /* <-load_elf_phdrs+0x6c/0xb0 */).
> While valuable for tracing execution origins, these trailing comments
> can add considerable visual clutter to the call graph, particularly
> when examining deeply nested call trees or when synthesising higher-level
> abstractions.
>=20
> Introduce support for filtering out return address comments from
> function graph trace output. Provide a standalone --filter-retaddr
> flag.
>=20
> Key aspects of this implementation:
>=20
>     1.  Return address parsing and filtering
> [ ... ]
>         processing") in tools/perf/tests/ftrace.c to validate comment
>         parsing and string filtering across all supported formats.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016040310.4828=
76-1-atomlin@atomlin.com?part=3D2

