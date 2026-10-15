Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE6C22370A
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 23:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107994; cv=none; b=HnCC+gvMcfdns7a4ZU3a8waF9UTN/gN7BGzxrcvbHr6bQ7F8rpm04bK0OxKU5H8MXsmaO33btaN4BKNu8VowJNwJAz25c8Zg18RcA6HJXHw2PUB1isqSGRMVoN9Ltm1ltawn671/BAWCLyan1P4pKle5OWzseKY76LtZJTgTMQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107994; c=relaxed/simple;
	bh=tO6JpjiLisi8IVJyfWVJPfKysCqp8bN9KUxj5wQ2sM0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=dHffMaF3nSGJ34D/lB3yyp6SZR1jY2JRGQkvhC+HfPte9m1TpN9ADH5gai21V7XSkuiVyMWjc+o5iIDPZamle2RTrxomVxMOfEojthoB7mMvUd+HQfZXiy1IJe6Jb5EGqa4YvWcFP20EHfTiycZ1gcOKvpG1SmxTP8xq8qWfNTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X64fZmPq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X64fZmPq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F061F000C5;
	Thu, 15 Oct 2026 23:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792107993;
	bh=5/pniW+xK/0gg/r6+ut4CjEtmUYp5QsE8XThUbKQQOk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X64fZmPqvxcnhxmEI9NcDKXGHaFbO5uLeZT2BRKRl0jKw5ak3RxTNY7wydoiO1QUN
	 kDV6APApFD9hfOMhpQ/N4dBswOxT70PtnyoNzTV0n55gToSm7fvHI7MwBLJsK87Z96
	 pGIR0yhrQPJ8A6O8cxDsYcb4DYzO4OCEI8dXeOVCPVY3jv+kVcsEneXBvQhDFpoKxN
	 Z56yVeYWqJc9N7PBtc+rwmbjmEPbZgHWlBAfMDskWZWSoOzQ5vBO0IkwKBjgSbuKM+
	 MFn0WHcFPDYbyUwUWv3v4bkEchoE71gnN9gaRWPj7/b9qCbQ0TVIeKzincbSHm+P54
	 Dn9gyZ0ACfRpA==
Message-ID: <sashiko-outbox-173478@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf c2c: Fix memory leaks on output fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261015233237.542258-1-namhyung@kernel.org>
References: <20261015233237.542258-1-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 23:46:32 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The perf_hpp_list was not freed after use.  Let's add it for the main
> c2c hists list in perf c2c report and a local list in print_pareto().
>=20
> Previously it was detected by ASAN like below.
>=20
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   =3D=3D42183=3D=3DERROR: LeakSanitizer: detected memory leaks
>=20
>   Indirect leak of 1064 byte(s) in 7 object(s) allocated from:
>       #0 0x7f17334ef24f in calloc (/lib64/libasan.so.8+0xef24f) (BuildId:=
 61e8165ca90f7a4f06b73f064a938c76deaae079)
>       #1 0x0000005fa099 in zalloc  ../../lib/zalloc.c:8
>       #2 0x0000004faf6d in get_format  tools/perf/builtin-c2c.c:1978
>       #3 0x0000004fb45e in c2c_hists__init_output  tools/perf/builtin-c2c=
.c:2004
>       #4 0x0000004fb7de in __hpp_list__parse  tools/perf/builtin-c2c.c:20=
47
>       #5 0x0000004fbae9 in hpp_list__parse  tools/perf/builtin-c2c.c:2085
> [ ... ]
>=20
>   SUMMARY: AddressSanitizer: 1064 byte(s) leaked in 7 allocation(s).
>=20
> Fixes: c75540e3160f ("perf c2c report: Add dimension support")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015233237.5422=
58-1-namhyung@kernel.org?part=3D1

