Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793738744;
	b=JsfmxmexWymQ9KeGv6HBhNo521KkNxO+b4aQZUYo/mONNxp6ihOt9Ps8tS9SIhUMBL5n
	 7WXBsMEouJwaDoamFqimiemaXvueX3XqtsywEhUU6+hbNq+KUTw/zfseyI5oVUeOVlRqU
	 FufHbkM3fpsRvAVxsrLriMcBKqAMhRG0EjFjbaoOCynk6Ny8SWx+sC6E4xJSwwAaWvqIx
	 L5m94B2MGrzzgqZaFVrdnqou2VL+AYerAPjDMFvhrH80f/vML6zCzAuEJMnl72Ov/TGeC
	 i0vagAaN8WCko7/HXP8F7hiuBolbsIoB47Nua3xmiSI3g5BBRP5xbP5Jyl6wDOrv/Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738744;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=g8BU+ndRRmNnzHMJjGqyAQDlDeigXG55KVAl3ESdnoM=;
	b=B169dGVafw0F4UH+idqfDhWKItfHpbYdn9I5YS+E7FEo2DPuFcRm78OPy/NVKaudLJxx
	 27kGqKczFR+hf2cMck3kqOrjvCoKEz/Xcwb21WVbKYXdkfOaqgobi4+wvfYyRRPL+PKkY
	 M29l9QPMB881AzPpfz6gg+T2g/dIT7vJJAlaAwiCCWPLy7WrEXtV+TeJSKFg7b12OB9dn
	 Hk1SdL9/L7WOhPhmOLic+uR+YfpIpkxpd5Tqz1CLySpK8jM8TwX0TQ85VlEEVi2lQX6H8
	 JouFZeagVpxs5YpMCjOlyL16sjSLZMk1kIsm5aT4RywVshYZOJN0l6VbOPQt4btQR2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EAIyejEA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F56E606A31B
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 20:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EAIyejEA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F18F1F0093A;
	Tue,  3 Nov 2026 20:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793738744;
	bh=g8BU+ndRRmNnzHMJjGqyAQDlDeigXG55KVAl3ESdnoM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EAIyejEAJ4L4PZQBHnbiQi9Y0iSl4CBMQUizeyngFWwdzGqR9nwyTSZsl+GsZNfL7
	 NiRqYNDzeYZhZd5Ida1M72i0sa/ZP+fOD0PI8EO1/SHLBpV/QkG+anO6jgBuXbXzs6
	 V54dDHBw1Oc1ww037EpweUq1wB6N4eGwQoDV0dfLF+l9kQQE9Y2/6fVUK53wh9KZBJ
	 3uO4Gb8BT2dim1MvQg1UyYwwZ1uRz6jNuG4ccP459Clqp/nwuhHbODNLhrY6DWhZYQ
	 e8eGpoai+dlgaSSNjjIsz0ieV36HR5Z+3HwRTA++40bFIqS1h+Xkoz3P9d/kRP9Gtq
	 smFFAaDQmzH1w==
Message-ID: <sashiko-outbox-196009@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/11] alpha/perf: optionally randomize the ProfileMe
 sampling interval
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103-alpha-profileme-v5-7-bbe3937fbf3a@gmail.com>
References: <20261103-alpha-profileme-v5-0-bbe3937fbf3a@gmail.com>
 <20261103-alpha-profileme-v5-7-bbe3937fbf3a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 20:45:42 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> A fixed sampling interval can phase-lock with a loop whose length divides
> it, so that the same few instructions are profiled over and over while
> the rest of the loop is never seen. DCPI avoided this by randomizing the
> interval.
>=20
> Add a randomize config bit that varies each interval by up to 1/16 of
> the period in either direction. Only ProfileMe events accept it, since
> Aggregate mode samples already land a variable distance from the
> instruction that overflowed. Counts are unaffected, because prev_count
> already records the value written to the counter. The jitter
> is computed with mul_u64_u32_shr() and the sum saturates, so that a
> period beyond 32 bits cannot overflow.
>=20
> The jitter comes from a per-CPU prandom state rather than
> get_random_u32_below(), which takes the batched entropy local lock and
> triggers an invalid wait context report from lockdep in the PMI.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-alpha-prof=
ileme-v5-0-bbe3937fbf3a@gmail.com?part=3D7

