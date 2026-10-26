Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004138;
	b=YXYbAMsw4HiYrrRKfGRymDunEKpqUWu2MaimJoJNmyyRj0Q8tlPa/JTKLHmNWBPH98IX
	 watQSvEpgtL48dCk9WeqcVm70sDuHYJATrGkRXFh+c2wrxVPZVp6vmLiiF1tZ+V3n+IXK
	 jwsD7I5jeXKAHeCmcvrANCNTw09jir4dVig4Da7y+lJr1g4QZ2QiKYfwKseqsZqsupgd7
	 CrR0wyW7BjIbEXjTWSnTd4QVvr+FasgZZNFfzCxfbs+GQwQcJctGnEumvw7Hf5ARa8aXs
	 hGGmWLhZaGcjHld8b4rq3WJlBFh5+qe3G8r19AwYrYbw3q02HhdYlo/JA9nxlIJqvng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004138;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=G//dxEgkwobQLIWob0wfA7w3Dgc1ltNlOKBPwO/9/ew=;
	b=144DhmKXVYA440tbtCHdkXf6EkzfxJGGIBWlCOsi/7O0aVK7ZLOHhOiE9nVVJogLc41k
	 8GY8QpyYbzb11Xw29JQX9EOQ48XSDQdSGat/12hobC4ucBaIrd6Vwx0xx8SSIIHJX2Dy7
	 kP66KPFKmzoaHrbh+ttwdPYNJC/0T2jz1KfaGJhMnIAcv28300a3fizBPovK1rHdrcRkR
	 VVLBP/6/ztZ+yZikU/db715c8QCryLrGiic20jA/vBeBatQR88eiCRX/SV5Xkl1mVXn5f
	 sS3Tn33JdQUxELCWvyqv2EXU/bUzixLfn19u3sLMpYWzefE43v6GRkWMUdo9525DFPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nv+75iPL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75DE606A326
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nv+75iPL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D281F01829;
	Mon, 26 Oct 2026 08:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793004137;
	bh=G//dxEgkwobQLIWob0wfA7w3Dgc1ltNlOKBPwO/9/ew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nv+75iPLp/Oc3D2HKniaCZQ53qXrZEQXvRfPXD/Px7Eb3t5jgccGIAbqyiHnj5wju
	 94XZvQFC3lCSD8YdBy5OSeiEcMqyMLkT4acMb8rXj8bHC1T4mvrIfV9Q2NrbBM/0Ud
	 lvkO+o9VYmaPG70Xzjmo413qWS3WZIRQAA+3PiVnqJ4S4O/7XcdB1raRgsPnbhyu55
	 5ODj+nBhB1hkvbWmv+65yOo4OCOxnHjmCMRODhrBmB9fyo3hGWfPwyMIrYouG6T+/w
	 zv6GMolaPKVpYYQxHuMD6FWEtLdob7oSiL7UEaCPrzbSnY0gxLEzJJj8kdLDUUEGgn
	 h1Bfp/7PAUGMQ==
Message-ID: <sashiko-outbox-184683@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/7] coresight: etm4x: Fix event count decoding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <4d45171946cf41751215e8c1cd9a8b14d38d3159.1792989860.git.aaupov@fb.com>
References: <cover.1792907332.git.aaupov@fb.com>
 <cover.1792989860.git.aaupov@fb.com>
 <4d45171946cf41751215e8c1cd9a8b14d38d3159.1792989860.git.aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 08:42:16 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Leo Yan <leo.yan@arm.com>
>=20
> TRCIDR0.NUMEVENT normally encodes the number of events minus one.
> From ETMv4.3 onwards, including ETE, a zero TRCIDR4.NUMRSPAIR instead
> means that no events are implemented and NUMEVENT is zero. The sysfs
> event controls currently interpret this combination as one event and
> allow writes to unsupported event fields.
>=20
> Decode NUMEVENT after NUMRSPAIR and store the actual number of events
> in nr_event. Use the decoded resource count so that older ETM versions,
> where a zero NUMRSPAIR represents one resource pair, still report at
> least one event. Update both sysfs event controls to use the actual
> count and clear their event fields when no events are implemented.
>=20
> Also correct the instruction event enable mask for the single-event
> case to use INSTEN[0]. The existing mask uses INSTEN[1], preventing
> event 0 from being enabled.
>=20
> This change depends on the recent driver refactoring. With no reported
> failures, it is not intended for stable backporting.
>=20
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792989860.gi=
t.aaupov@fb.com?part=3D1

