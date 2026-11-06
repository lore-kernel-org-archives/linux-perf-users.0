Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949231;
	b=nlg6hOX6ycfPaihiyrPMRJhxwrL/iHzoZmmiqyBN1xvNrcXxFGVJ+cVKzuG0ZsB9iLKV
	 gvCNcYKRviLkJ5UgMhZRLbR2HL42bn0H/OwzpNvZGuzl3MRS125+P5lYycULpKJYp7PtX
	 eTjbT7w7WQH2vdt+BAuPc1N+wHiXdD1nhzmhKXvRiYLEvAFZFCpdkrDKcDDBH0zUrVhCZ
	 SppjSjMQ9YhPPgz1Ghye23kNrRRQrxgTUf/bBPPsE/LVDShgioH86QNoeS2PYl7IFB5nO
	 fdslw6rFNTHQK2G+EYbeBPwYMD0NTZORkbApKeraKslPhOP23IXaFZ10Ssm8Z2ApHqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949231;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ek30tQqXRrFL6+y+kBquu0Xmo3qCepG7CWZ7/n71N0U=;
	b=LvENNc4lQ5Ub03Go9E92Bo9jg68GEIMpKo+6/fwaGzWmGiCTMfLmLqBw9D8f5ABeNJ4q
	 gLPUB0kAC4Ec8Kq4mykWA0z4aTBtE9tcjinSlp+tDnTApOI3mna3hHd9rQyfaSSFHytGX
	 cSdl/WnIpc2X+VAlmlUEt7Mv6HpoBLkW0Cu+NY3TdH5J4Z/Sb2TAdYoXNYdb4ALFddaYC
	 C4ft5k0ZGt+G/nSKdNzmeBc+XoumWmNtGNdkV04iRtCghNVVpjxyu61J+0dkYmardOqC9
	 SsTKYUCAbVL8oMzXL3KA3vSjxXxtNwMwu9w1Jx8nnv6WJnKp50YO+cWtN838FELg+Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c6q8Yxhr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1025E606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c6q8Yxhr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36271F0089F;
	Fri,  6 Nov 2026 07:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793949230;
	bh=ek30tQqXRrFL6+y+kBquu0Xmo3qCepG7CWZ7/n71N0U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c6q8Yxhrak5Lqt1MXs7fMn/7eCMyifUNZYbjsQ9+WnkaMiSSJF7wpImmMlg3aN3Y7
	 DbrRLc/cXYRCZTxe6I4RxccLJ4eKwxPVFlBkOeLzSCCwqjD7BoycDLLxQhhQxr5IP4
	 acOMstr9wX+paooL1XugGyM+WEQGsOvWesH2ZRcKEMJNv6Upnf3JH+z82xb3CrYOxy
	 EBuW5j9E0LdnuhRS9dG+esO6v+RfDoMh8ycin4lxww8hFf2BGJBu49SuDjkyRJ3EF9
	 u+Eel3olNHvssGyxU9WnhY2xmxPIsSTqAd4fJ2L5HwoGlhI9SW9/AkvFZpMaQSkKje
	 PhiWg5Ro9vQyg==
Message-ID: <sashiko-outbox-200978@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 20/20] perf maps: Add context analysis annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106070344.329897-21-irogers@google.com>
References: <20261106070344.329897-1-irogers@google.com>
 <20261106070344.329897-21-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 07:13:50 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add __returns_ctx_lock() to maps__lock(), annotate DECLARE_RC_STRUCT(maps)
> members protected by lock with __guarded_by(&lock), and annotate
> internal maps helpers with __must_hold() and __must_hold_shared().
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106070344.3298=
97-1-irogers@google.com?part=3D20

