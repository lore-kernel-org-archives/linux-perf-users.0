Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8B14BD7A8
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349338; cv=none; b=VqF3FZES06Bsf30t290d/QafYLkynWXjoEj9Y1QJDxqjbHMuwX2FAIUhuri9WOdlqwqC1TTdylE/0Qv0JO1rtSJ2JK8dCx4SW2rONRBOP70EZY3j4MLDNuoF2adR0yTyi6v8R6+HWRa/4jrJXFIR83vaxb5zdXX72+Jd4sVNGnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349338; c=relaxed/simple;
	bh=qn0F3EcVZzcxoMSsWLnxgSg/PVJOhPSYnarOrtgGe3c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VZ0EhTFvTtpaYy6ttQUpqrEQrIf27qepEo0ZzT/A03z6wq1AI5i8/xtK4vDrf+f2uQ/V3VMV7yTxjhHaXi8ECOreh0xZDRe6zre//PsTYcYwihMprKZDWagX/SxPHyNYgUGAdxkaKJxQ2Y7U9KX9EVnE22Y+br5GoPu+Bf9IZ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaRUohar; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaRUohar"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03C21F000FF;
	Fri, 25 Sep 2026 15:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790349333;
	bh=VLlyKt32LyVcLdhiV4Lt6PZ3gh0HFKZ1iG0WcoJekrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GaRUoharAWTJrvmdREHx1fxlVKykUYeiK0tcvelzgpWxit28b/dMZWaW5T93vPnEk
	 Sp9cZ0GmPPcgK5CWL2KsEuC+qLJy/zkgN2Ke5O4FDKm3F2HhbxQ5noafPOOAphDMVk
	 UzXYc+f1RM/Jzd9oHjdeF/3VKzeORXtXqOEHjQNqaElJaV4AURh38TkFumOhXmO+yt
	 ZUtqWn9ySn2MtUOXlsoZASVx/XEqOoZ09ZF/cxRB9U5GsXeBUfwAcHFmTn1mKUkggp
	 tIvIVNRVyTyhqzOlvNB1k4RpvYp5RfR491Jd48jbiYIF7j3VKoE2OMAPqQFXySYn+A
	 u8sgznKYUjkNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] perf mem record: Use the IBS swfilt filter when
 available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260925150657.1826942-7-acme@kernel.org>
References: <20260925150657.1826942-1-acme@kernel.org>
 <20260925150657.1826942-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 15:15:33 +0000
Message-Id: <20260925151533.B03C21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> IBS events with exclude_{user,kernel} bits, as used for per-thread
> recording when kernel samples are not allowed, are rejected on hardware
> without the privilege filter, so per-thread 'perf mem record' fails on
> AMD:
>=20
>   $ perf mem record -o /dev/null -- true
>   Failure to open event 'ibs_op/ldlat=3D0/u' on PMU 'ibs_op' which will b=
e removed.
>=20
> Kernel v6.14 added swfilt, a software privilege filter exposed as the
> 'swfilt' format term, making those events usable per-thread.  Give the
> ibs_op memory events extra tables with the term, selected in
> perf_pmu__arch_init() when the PMU exposes it, keeping the names that
> need system wide mode otherwise; the knowledge that IBS needs this
> stays in the arch code.
>=20
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Suggested-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925150657.1826=
942-1-acme@kernel.org?part=3D6

