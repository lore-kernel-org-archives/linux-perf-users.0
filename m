Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9024D9F9F
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584340; cv=none; b=fBEQ9/73ihvO/qW/CabR7s8Fs8aYpBMdhYvq3F6LXPQZRPER7J8eSSZlQoHLUFq2HdNILdziSE+UbxEx3HpHVewyPkTgcrcPOtVq5NfxMEi2xUWU7h6M9RC6olfRMKSaZHLVpfdLZe84xK3OyPpLUsFXv13tW5KTxO1oRJGiyNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584340; c=relaxed/simple;
	bh=S3nZ6dB2jzT8phWYrICSqOdFxbOuiEf2H0ZH//CCDvQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V48ZtnZRlIHsiSfzLooXPEWD+n5L7yoD4efskSr/pQHjPGNK4aqJAvMVRco9BZWnRUlaiTPRa1E1Vg5D0oVJdCPgtjdzydU97A0QEAx/hvm+JxevuBcsNYKfuiHwL/LDANb546zLe18Da9WE+whNmINqLePV8GBihrDGNlD8Fyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8RNGKhp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8RNGKhp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AA31F0089A;
	Wed, 16 Sep 2026 18:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584320;
	bh=4lmU05ImbZTzn9m98EtFqa27aJBeblxKhaYcWzVNTuM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I8RNGKhpjZ/NuQ/PM6348F0B2i+UR7F8wyuOLgBGPefn1cHq6mhE+rQJZM4mRk+2N
	 FrlyGSkHoiwsssuKBzvhhEwGbNxIyliKK0FyaFHJ1iHRZNy4RV3ze9ecjp0Bj6OfuX
	 QO33+w+/Z1Y6CanwTT6P87Q1yaZIydoDOmBJ6orNy9ZtbdCRJBuzdFoDzXDAZoWU9l
	 DISoZKDNh6ktL4xCoipYSPujlrbNcRqdLGRTryiYetVpiMLjnxhI2nD1wDESixfCZT
	 qaibcD01r91bjHzQMv2BYS/IaKNxCztU5QR3ZbAEQGwn1Bg/c27i1DI/kWCmrHem2+
	 r2UP9JpjNtuDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/12] perf mem record: Request PERF_SAMPLE_CPU by
 default
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916183215.54305-12-acme@kernel.org>
References: <20260916183215.54305-1-acme@kernel.org>
 <20260916183215.54305-12-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 18:45:20 +0000
Message-Id: <20260916184520.93AA31F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The data-type profiling per-sample stream keys cross-CPU contention on
> sample->cpu: without PERF_SAMPLE_CPU the cpu field is the (u32)-1 "no
> CPU info" sentinel, documented as such in perf_session__deliver_event(),
> and same-instance reads and writes from different cores are
> indistinguishable from same-CPU traffic, so pahole's false-sharing
> detector cannot tell them apart.
>=20
> builtin-record.c already defines --sample-cpu and 'perf mem record'
> forwards unknown options to the record parser, so passing it explicitly
> works today; make it the default, next to the -d (addr) and -W (weight)
> the command already requests, documenting it in perf-mem(1).
>=20
> The rec_argv array is sized as nine arguments per memory PMU plus the
> user arguments, not counting the arguments __cmd_record() adds itself,
> up to eight with all the optional flags.  On PMUs with separate load and
> store events the four event arguments plus the fixed ones already filled
> the array to its last slot, so this new argument would write past it;
> reserve space for the fixed arguments explicitly.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916183215.5430=
5-1-acme@kernel.org?part=3D11

