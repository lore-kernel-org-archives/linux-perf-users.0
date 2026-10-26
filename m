Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007117;
	b=mEACIKTUc+wENSicE/ceF7ZmJH2rCA8wiIEmVuV90uaxM+ehbN4Ma/lW9XVyHTFT7qSq
	 kIXipB6ZZtw859ABEFOMy5dsdUu/Gn2c2UoCRljnU2+Z8mQSF8rmX5U1eci1FhhrP9gvY
	 KxDGBYRwcodsSc6HH2CdOZtOxy+Zs4joSD9j2rYETD1y8WfK/CXi0PAIwOTwczQMi2+MW
	 eTyUrcInODWTHmNxz6+hNhKkjUpP8hq4aVU/FWOKFIJgbqIx0l3AIXNu6+YBCF4yed+Mi
	 4q8D+9Ib0FMg+u+81cAYunBgVjJh2+Fjv6V0QSjrLBW4SrmU/K/19TWZNhtT1e1IVNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007117;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FFsEFJ1WD3YeD2dfJauiwgg6r953+CUn5zPgneaJWbQ=;
	b=pOhmQ1y3O9WzRx9ch4iMv1Zq5TnEtuTfF7AJBgY9IYVisjjdmyj9Ion8TovFrrvOzpcB
	 0UVbE3r6D8f7uy4q/QEsqrVAqPmSK39+jV92szy9BSBRRbbhQo/MOn3AbGOfYcOSI3aWH
	 yX1o5Oz+RpsOyQ9ilxvAOsNOfyiJxfB/Q2MG/Np+OmceDU6Xx2B8hIlhWwHRAENMupxiG
	 oXQ6FDYTJtkg4GkNjfISm3k0+0SE5xxSE1vINs8cigs1zMUr93LlMQePyIYmKtTGh8wTy
	 ePBDp5F9akaamp1vjr0X4+g122tfw8JXQvuWbNOV7RlT1IkVOo3juuELNI/mkqgsGXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aWjVdx1F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45AD606A31F
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 09:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aWjVdx1F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBBB1F01825;
	Mon, 26 Oct 2026 09:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793007116;
	bh=FFsEFJ1WD3YeD2dfJauiwgg6r953+CUn5zPgneaJWbQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aWjVdx1FxWeOjGxEs/9mHucHPZu+4k8vuOMj0maCetkz+EyyQemaxgqJdMzqu0F4V
	 2j4OHZAlyxUuLPloZ4h3sDj7uR2iDrtYjaqKBQBBCdF705C05dhiRNcFNuhUcZMVq2
	 Tvw5hK/ZlnY2u5URqduZ5WjMJ/J0LTtmq96zBanh4AkeyEPJTpj2YapyozFSaGTW0Y
	 kXMp9oCNJCo9vRdbbdEAi9cFvofCPmK2UNHuEJIK4TN4r9RGSowo8ZfLuEprknQQpo
	 3o/GBuBwEnwNHzSFNTZHKWlN4p24Lh2FuP3TBKnJy42klirYSFD3hWyQOa2KMeijnb
	 vqPP+260nDVdQ==
Message-ID: <sashiko-outbox-184798@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] perf libdw: Optimize fallback logic for missing
 DWARF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <6cb3acf7a54ed1638ce0172a79c7e3263be17780.1792995775.git.irogers@google.com>
References: <cover.1792995775.git.irogers@google.com>
 <6cb3acf7a54ed1638ce0172a79c7e3263be17780.1792995775.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 09:31:55 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When libdw encounters a DWARF definition it cannot accurately un-inline
> or an address block natively missing structural line maps,
> dwfl_module_getsrc() returns NULL. Previously, libdw__addr2line()
> returned -1 in both dwfl_module_getdwarf() and dwfl_module_getsrc()
> failure paths while addr2line() in srcline.c only stopped its fallback
> loop on ret > 0. This caused perf's addr2line_style loop to fall back to
> llvm, libbfd, and the cmd__addr2line() subprocess wrapper on every
> unmapped address or stripped DSO.
>=20
> Update the addr2line_style pipeline return semantics consistently:
> 1. Backends return 0 to denote conclusively missing information
>    (e.g. valid ELF but no DWARF inside, or parsed DWARF with no mapped
>    lines), stopping the fallback loop.
> 2. Backends (and uncompiled stubs) return < 0 to denote initialization
>    or backend errors, instructing the loop to iterate to the next
>    configured fallback.
> 3. Backends return > 0 on successful source line resolution.
>=20
> Fixes: bf96e296d52d ("perf libdw: Fix Dwfl discovery with split files")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792995775.gi=
t.irogers@google.com?part=3D1

