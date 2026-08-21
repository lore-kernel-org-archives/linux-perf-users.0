Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0FD46C833
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306284; cv=none; b=tYQWCjNxoOTSVf07d/5SgmTU2M4hlDIHM4nWQWEbE2fyN17BwphquQMrUV+7PQbhON/gUbisoCdyb3t/8CPWVa7hqHySKrPtpLDsyqQJ7b27bONtURA+BxWxhAnpQpMOxyC0IaVfN7lsfpIVhY+wmGPNXL2hJnn7xh2jm/bZVVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306284; c=relaxed/simple;
	bh=EJIha4Z9pvZ/7dQ0EB35K/ZfgSkWdpbhipgs+QroFWQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dQ3A9Z+eFUF5ZrHQNfjsERzxAppGZGfe1WP/QTLadK/pZy28qXiCsXJT55PttJpbXOKs5K32zLEqVeXbVXZVXejOn7TI0G4KKLKkX7tQv2Cl9yiBM9v2yoTT1UABuvtMdUXgsCt4RXpeHMaNm7/yuG7UuBUHjaQEXvX4EsG5BG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dz2Qvdng; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dz2Qvdng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319B31F000E9;
	Fri, 21 Aug 2026 09:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787306275;
	bh=tR6M2NNtb9v5myUe+oUQnoJQFR4ffBtkGbu94cvo970=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dz2QvdngB6umJHhfpgX00rjUL50okJNoNiVSQYvaq0C5IEiSModdd4Gj6BHKl7Kt4
	 5lc0id2Jxq06NU50d6ZYmDqA8ISPdR0t8+fr0sUlxu+/jDxxb58Mt5YRPtjRB6qVlt
	 uIsz9KNkymW+QEv1oOHTd95By9fgaX8j+1KKZ9a0p5symuawVAmP5O/dgppM3kTMd2
	 4M/BpEbCofO6JDfVsQPa+EYxdObZPEIBbShYqoS5+64/ZTfR6PnWYFGYBmskOyS/Zh
	 pm6BpQ3KCSlDZyj8tJCBCKUgaa7bYshDw45gZ0FTxVqSLt8uGPcId1Y3sc5vFmMuN4
	 EMaqBgAPTxtZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/14] perf arm-spe: Use generic snapshot search
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821-james-cs-unformatted-per-thread-fix-v2-7-00c4fd0701b4@linaro.org>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
 <20260821-james-cs-unformatted-per-thread-fix-v2-7-00c4fd0701b4@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 09:57:54 +0000
Message-Id: <20260821095755.319B31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The new generic snapshot search gives a similar result as the
> reimplemented version of it here. One slight difference is in the
> pointer fixup. SPE has:
>=20
>   *head +=3D mm->len;
>   *old =3D *head - mm->len;
>=20
> Which gives exactly the same result but written in reverse order to the
> generic one:
>=20
>   *old =3D *head;
>   *head +=3D mm->len;
>=20
> SPE also had a special fixup case for head pointers greater than the
> buffer length, which is not needed because the SPE driver always wraps
> them, and __auxtrace_mmap__read() handles that anyway. It also didn't
> have the special case for old > head for when the wrap heuristic fails
> but the pointers showed a wrap had happened.
>=20
> The other feature lost is that this search only looked from head to the
> end of the buffer, rather than always at the last 512 bytes. This was
> flawed because once head is close to the end, it's likely it could
> contain zero padding from actual SPE data and a wrap would be missed.
> It's better to err on the side of caution and mark as a wrap, rather
> than trying to optimize by limiting the search from head onwards.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-james-cs-u=
nformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org?part=3D7

