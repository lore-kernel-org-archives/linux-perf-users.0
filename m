Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35F1221DAE
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 01:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792027323; cv=none; b=Toh2lUf/Nlw96FkQ/i6R7fT+yemnesdoYK0Z1hymYABUT1BN2Kg2taKbZs6kpstE26jx1C2QAwdEI+WvRPScrMq2I50I04z0leuyRxMSsy80sOxoXH0xZ3eqDc77z1rjcnDljJWp8bXw6GFB+SUcV0DXU5wsdknIH2XthzxyE7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792027323; c=relaxed/simple;
	bh=iw1f9cfkYjoNnx3wR6ii8qn14Jj3PQfk/ygeWFIi3QE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=CSuD3B4jLoTVf8MRJQcQkJP2N2slfO7b94npkkszVvTK5N1sAbaYIfUpteKfSAO58oiSHQoQ6J0qiHWRfBuJg5MM3jxU4XOdZlpe24puc8fkudKUDiqRdTzZdkQZbp2ctbwoOcRoM00nx6Y1aHziUtmE6xxIbCILh6Lao4gqo+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3qXxHLf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3qXxHLf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD8D1F000C4;
	Thu, 15 Oct 2026 01:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792027322;
	bh=lidjtelik6mIbIXVHDXL1LXvc8BW2C+Qr1bGW+x9YZ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N3qXxHLf9yizrScqB9ASGWyeC2iejThh7dMVc6GEzPSOg/uwIgznMJlYtXu6bmxZN
	 7yoLMJc8lIb0Nx0BiQAQJ3Bl8v9IpJP2L0VUBy8EwthuJDiIvehA0AMAYuuhUsXp/T
	 YMRqDmCd1eDV0Yp0jZrI2efpVqIvI7V7WxPTZKdTQ6QIHXD2SQ5d3f9woG1OlVr8D5
	 FPdr6Q3iXvYs48rClooZQUk8pcIN4vtEz1HofdbEz8q4WFbIyYniXzWQqEokKZxN82
	 N/UgrNlllGTtIN07+oDG2h8EBj+bg8s7bL3o58luL5U3sQyz7QSRsPUExCTN0XI71t
	 VgSCcbbEYT95g==
Message-ID: <sashiko-outbox-172086@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v5 2/5] perf ftrace: Support filtering
 return address comments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261015011155.414667-3-atomlin@atomlin.com>
References: <20261015011155.414667-1-atomlin@atomlin.com>
 <20261015011155.414667-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 01:22:01 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015011155.4146=
67-1-atomlin@atomlin.com?part=3D2

