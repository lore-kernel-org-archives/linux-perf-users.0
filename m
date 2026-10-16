Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD61E2367B5
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 00:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110211; cv=none; b=V8dqowECEAOXx2K4LardofWdKFb6agTBKthxepPsLagLRPn+KI7kYlL+zOX1oLDaLQ/qV5kvPPCOeUGZn1G9feHbsPPKsouEpn22HtyDFi6UN9jpqtf4tMrVj0ExKLiOJj10NTPeOgMsm/+pYSWrWBU7FN0oHY4q2Oi2vNlBFwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110211; c=relaxed/simple;
	bh=aIveE77shiGJUc3aa82sTFamKHYahCbg7/sQiDVEEPU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=euy2nZQu3hjsuLkR8TpEZdUoUvWLmGn1O/Z3b8PPYeKW1+llzRiBR6NtAgEqcWp5wXDEabc86hxvLbPjcZKubmwvN5dR01Syp1t4XBp7Xz4hpfoQS/UGkiAd+C+CVISIsC4uWxQa0OImLXxf9dmAT5JEvYnEwhugYzl4I9lEnY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqfwCDMD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqfwCDMD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4DC1F000C4;
	Fri, 16 Oct 2026 00:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792110210;
	bh=aIveE77shiGJUc3aa82sTFamKHYahCbg7/sQiDVEEPU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aqfwCDMDJRePSJimQbdCaSJ97PUsNf7RUzSCeqKiT+punjdjWAPPpVLxYZiuoIlgn
	 pWYWjRfM/jDtduY4/Q8q6ZLc5uasiejPn2J/lIo2Aqvv3qOd7Kx/TrA7XvfGVECAcP
	 rxoRxQ1AxyogHj0yOibu587nvkYETGC8Z3k8FZ27qoJ/GB/qTMP2YidgQCaFOQ7btg
	 exMbX6nxtFWaeJepKu4yGYs8qvQy9gmhm9R/+LPYmQgRfSrcUxedqQylsf0J77khUh
	 HOo8IoyqIQxLWWuYtZaEtAenAdl7qm7nmDvDL4plP4pSRPngHcLtzOSwz+G08LGjk/
	 coySUGtaWHwPA==
Message-ID: <sashiko-outbox-173516@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/19] perf test attr: Introduce mask_bits(),
 generalizing hide_core_pmu_type()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016001843.71978-10-acme@kernel.org>
References: <20261016001843.71978-1-acme@kernel.org>
 <20261016001843.71978-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 00:23:29 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> What hide_core_pmu_type() does is take a set of bits out of each of the
> '|'-separated alternatives in a value, wildcards included, keeping the
> rest of the expression: extract that as mask_bits() and implement
> hide_core_pmu_type() in terms of it, a prep for using the same thing to
> ignore, when comparing expectations, the sample id bit perf ends up
> asking for and the read_format group bit that a PMU count can remove.
>=20
> No change in behaviour.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016001843.7197=
8-1-acme@kernel.org?part=3D9

