Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464BF382380
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 21:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285704; cv=none; b=fU72R4hdZgDyAxBttmO1agb0vLDMxtkkP5izm9f18/e9Hotth4aKJLxTntCtmr8cYAql8eaWyKYNyJpx2KdTCkKWXu2qibYxPhq97aYWHoLykMCWDWSCy8Q07sTM512TLBhrvWaBIAR2aGfI3229x1f3jaSF7U0Gxs+9r6ug6sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285704; c=relaxed/simple;
	bh=HwcB28KD8g5LmJwwTqDM1XAeuUQQa/lnROaiKbrG4ww=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mft8SKlFPf2WWcTFrwAWDkMC/+Oj1BXvSGioMxLAHzbL76K8K930899Z8kHVrWh8aTmS/nBlKJmFQHUJsbnOsp654GfoFtqC0kCvJqb0FXsS1/6pWHfD2Iv/WNPaUPjSCzgf2I7dmWYTn9gXsRR0QYupqwJZ2ubG60h9nLJyWpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0W79akS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0W79akS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB22C1F000FF;
	Thu, 24 Sep 2026 21:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790285702;
	bh=wDLE8+omEPebClIRbdGCqPpkaYld+8rAbhrE1OCw8SA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e0W79akSCkZXW7EKyRuUDu6FlkSxuYn6SD8vtfoTClLztNzNyoAo5y/7BxGKgUT6R
	 LLmINeTcxKNs/samGSMbkjVxlP6Zj2IzMN9jKcpDZBHZLxI7woqHkt07k2ZhNaoGT3
	 loDFuhUX7NcgNaOhQ5q6CPEX5Sa3EF7ZvGKw83puVj4flkJx3VJOUeT55Qcdvx1GWl
	 Z57KHc72nD71R9r/ORbUh4daoUBMX8XKUXvAB6G2JleRl47tpQ/9hhbfhwBmcYwVVw
	 jtO0n4yWJqTiy5/YBaxIMLEud0mKA66B8RN19bgV9lHtO5QEr41srun2GEbU7eXGap
	 m4G9qBiPvTOlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/6] perf mem record: Use the IBS swfilt filter when
 available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924212809.1733663-7-acme@kernel.org>
References: <20260924212809.1733663-1-acme@kernel.org>
 <20260924212809.1733663-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 21:35:02 +0000
Message-Id: <20260924213502.BB22C1F000FF@smtp.kernel.org>
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
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924212809.1733=
663-1-acme@kernel.org?part=3D6

