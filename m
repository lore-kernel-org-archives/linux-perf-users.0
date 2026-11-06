Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939992;
	b=hMA7xutMHSEXxBtH+gBjCykFTz/hxXE/vhIj2AL1BJAzXHmEg4G9yJkW88j1CwlV/pwx
	 bdT6CdgGXYbWvrbcwBUujFtck9fIjpTIcuezEEbIaBS/rjNzfBspy8bMzk+vgn7cuudZV
	 LTGb2X3uAH7KYoCUpDKhT7pRqYPmH56GPXYMv8hPjiGkHmv7uDFU4ZlIbbWdQJKHzcq9f
	 wgBvEHJ30Mk0W1rHU+mdzgORmHjNlCvqDD0Ee21DKLWjHbD6c6enyReyxXI5uAjkt/wA/
	 2fEvxsKXWi9M3NeZBy2tMK67gXjrpDEacZTGS9hfCGgFR+RIqJh3/EstqyoQpFG/l9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939992;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lCgHhDgP0O+436Dzp6BLNvwLI/sZ8sJatnsLLe4PNGk=;
	b=bKXbdE0x/uluuX9KzdpQXsDr19/5YXTFUIf+JmBrNaO8FVdcHDVGYj9SqvB/fxARRAwP
	 C++BYcaUXEIjfmSItUMFQA8nHKI23FnCgKDkveQV0BFQ5+QYeR5Ww3LsEqCmDKTCO7SlH
	 TDNB3Tsq5eCitD8fKJhcrYmT+Hg42ktjVrVQZHRopRDgBZ5TUZQ+IZhIHJL58mg4BWtOu
	 SaaO3nDdUgiDnrWeug1jBdq3f756KZm7kzRlkUG7L5XBwwQS6dY9iEJ4qeH8TO1N3DCTu
	 3oH35erErXoPiTqDXenmPm7o3HMFAXOTSCxtDFqgl2yTXYjS+UWsYMzeOfdsYrpmuQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXJFs+O9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765ED606A32C
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 04:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXJFs+O9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352081F008A6;
	Fri,  6 Nov 2026 04:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793939992;
	bh=lCgHhDgP0O+436Dzp6BLNvwLI/sZ8sJatnsLLe4PNGk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BXJFs+O9W9DxzKgV1omBmItOGf0GOE5OGYN5dmH3B0WRHENcB4kaan6kH0AX8FU3s
	 YbzhH+zsMQGRHTOh9211M/deSTAB4KjmRLcRM5VI9gOuhA/RaV2JbPX1pCkPUTkwMQ
	 gumTHrBTPtrmGV+siiNigqO+UN4WLEMlyWAV0ER2P7iIgGMdMW88Rtq+RblVMH1mnG
	 Q4UTP3zkUcDD/fvtXsS0XNZqo58V2gG+NfLOuM4h7Ov/0mzL6SUy3HLCHpoZ5OJY6n
	 +l/tne3z4aO/kQFrZLxnbb9lV8NQm9PBfy1uebk5BhFR+qt8bJT0FJxQrXTDohqc/2
	 v0FlZhUkW/6TA==
Message-ID: <sashiko-outbox-200750@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/14] alpha/perf: clear PERF_HES_UPTODATE when an
 event starts counting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-alpha-profileme-v7-4-c474e892abb0@gmail.com>
References: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
 <20261105-alpha-profileme-v7-4-c474e892abb0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 04:39:51 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> alpha_pmu_add() sets PERF_HES_UPTODATE and maybe_change_configuration()
> then programs and enables the counter, but nothing clears the flag until
> the first alpha_pmu_start(). In that window alpha_pmu_stop() with
> PERF_EF_UPDATE skips the count update, because the flag claims the count
> is current. Since the next reload rewrites the counter, everything
> counted since the event was added is lost.
>=20
> perf_adjust_freq_unthr_events() does this on the first tick after an
> event in frequency mode is scheduled in, which is the default for perf
> record, and it then sees no count to adjust the period with.
>=20
> Clear the flag where the event starts counting. alpha_pmu_add() cannot
> do it, since the event is not programmed until the PMU is enabled, and
> stopping it before then must not read the counter.
>=20
> Fixes: a4eaf7f14675 ("perf: Rework the PMU methods")
> Assisted-by: Claude:claude-opus-5-5
> Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-alpha-prof=
ileme-v7-0-c474e892abb0@gmail.com?part=3D4

