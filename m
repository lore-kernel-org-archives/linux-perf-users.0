Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794884378;
	b=hs9OHF+m+w6vTwN7sMi+8RbmZmNNu8S02K/UhXXAsoOR8wDKq8r+A+ziOYS6dnhD1MJm
	 R9SU8OvKur77GZ0H1XSpPmxPdJ6U8QrCERZmbGulWObJbD+srb+uCdTvnxZQw7RbUa4d4
	 EBoupkQC/n/J8MLhfgBkTpVyKeMUqZw4fgnWknNPAS255KGvnRkv2XIWemeyj03aIf7IP
	 i0ynRak+afuA3wtM0wFE6YzF2dy6omv7p3mxUrsh47eklAhlzam/nm8fWTutgGDTu9l+2
	 7a7HWy2605zmm2TJ77YQYGU47AtGoH4BD7uGQU+Mq6Kfe6KmY2U6vqNnqqxUIo7bUDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794884378;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+irMxY8MEjKNHJOmPnRNLREBlHJ5VqG48DP8GtJXnIM=;
	b=HKr9R6HFqvi670Nckk8rClQHSwYqGFWFSpncd+gl81t9kzRP/7jZHufEIm2okExaYFFg
	 XSjhDrpLaPFsmAPzUehiOCT7PtvA3pBlfz9+PEqfXQjildfz12VH7dujaWOUgByRxpqLX
	 /E/lnasjmQwJD3TpKgSU7aA6oNKIrH7pR1yxAQn4eKkTPjxhtVvRnFOJHDnNqrDpzxIgE
	 mn2ZeUQLx4TqYfK+ijJa3VIIvLyzZn+Nqm4u6+75kF345QbTzQKIUvQoOzc2m5Bs2682Z
	 LePP0g7B/s951yDIicupttorMJdEsBeiscy69DanuNnDA15Ke60skmk0om0E2UIh3fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IEAWblQK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7382606A329
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 02:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IEAWblQK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5103A1F000C4;
	Tue, 17 Nov 2026 02:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794884378;
	bh=+irMxY8MEjKNHJOmPnRNLREBlHJ5VqG48DP8GtJXnIM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IEAWblQK32s2isvSLMZck5Gf226q+hL+WDkrd75I0k8k51alddUSEFx+CD/KYxyZ5
	 BWqjUcEZ/jrKGbroV9c0eQwqAyOLX9ZmeunFCPIxQfjiqKtV2OSC7czbDRLq39O6QE
	 uHd2OLQ128TTbqrzegPKXDQTc9vWOLp8MKpRbVnpZ8CAci9BmBF4NY4857Doa39qKs
	 tI90lltPwSkHn7w4a8tA2rZAf/oklxv7lE9F6rOi18eL+zGKt+60wbSvZfReOuYThj
	 Z+EHYEICD93W6tsYzOENcoqy2WIg2cfvBZS7FD6LKw2yDT3g+yn2BcDhUn07jF45uV
	 KtPXe5SEBdj4w==
Message-ID: <sashiko-outbox-218106@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/12] perf tests: Exercise data type resolution from
 a register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117025305.3958882-7-acme@kernel.org>
References: <20261117025305.3958882-1-acme@kernel.org>
 <20261117025305.3958882-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 02:59:37 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> At -O2 a struct pointer lives in a register and DWARF describes it with
> a register location, while the unoptimized workloads the data type tests
> profile keep their variables on the stack.
>=20
> Add a regptr workload with a noinline function that gets the pointer from
> a volatile global, which keeps it in a register, and check that its three
> member accesses are resolved from that location.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117025305.3958=
882-1-acme@kernel.org?part=3D6

