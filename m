Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793037120;
	b=Z1Eq8pnAOz9TWA+aypWxYrgnYloidzLlIu4XWMYyesQVDH133AutKMcrgqbL4h225z59
	 wjpr1xWHP84FvGG0eRZ5OCR4SsgL7HQco5WzawvPjxRIF4sgZslELuEyiV48C+6ZRCeqo
	 U/BHv/EbYBGz/FAgNl6mbS4bDeODXz8NtD/8Cj0KLKGu+LAlxmp5HhGEyjS6kFtyftPyY
	 qOcgYHTU4TP+mvbhzhcEkUE2YOTq6WXLsbI0RCG7LwxL2b/BXZqdsPcruRcCtinpeRQUl
	 F82Rueu9WSCDuGiPHYao3GivUfo/aW7tCTojbmnqgJuMj/KBq3Kh3SYBl24gNNPNuow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793037120;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ja9nd9yjxqYmAQLWvAmAgcW+MGlyG3Otvkdep84l7Zc=;
	b=O4xGXPTaAYdpgFUcB0q096o44rDBgNKMOxZZdtfuvzHzyNsEexDKloQcyy/hQgZHyk60
	 bAVDK5gcqwkVlGeEbQrhHQEgxLlIuh1YS+ag9nGGZCrtL2GvhN/v05Q3iiI13XjZqFvjM
	 uIu3E1YvL66G2pmdseqHMxPnmEFjY4gWllbefGNB3MM+INoGOtD36WpLikVcfuQ9nPxla
	 PtUft1ZdmwOqtw5nVDl0umneYGlTbIFM+Tsg6XEgSudHbokmI2nCYPwR+s0R/2KrxTRtn
	 OCgIxoebVR0WRXSsRr8Ie6jN2+trg0dOif0uPUM1wKmrP9MOCpKBOiOdS9c9i3wBNkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zd7EctR0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E957C606A321
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zd7EctR0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E011F01828;
	Mon, 26 Oct 2026 17:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793037119;
	bh=ja9nd9yjxqYmAQLWvAmAgcW+MGlyG3Otvkdep84l7Zc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zd7EctR0lakHLhsZYukywI7ZYmBlcMz4gSa3W1bJlssW2tAsaG/rBI/JgiD3vXQ5y
	 PdPs0T5UXoPF+N1B7euDI/QcZzzC1fdl6Cx5QFg6rz5N+CsqOGARKES5GWssDTZwDh
	 niRN2lOmw/GREQgkDlvtT8pn3soB79LC6jsKw83GHiq6v+L9Vln3S3lggEAjA4Puzi
	 0wEWKsZgRaRVWnei3bmxMyA7EoWoNu2PlhI4CEbtoACshDWboqWk4iwpJF43ouMk2B
	 W8xjxW8fZ4SR5OWeqax0FO/u89He1BMIa9VT+C4zb1RhqqN3JWs7r2mwuyfKLXjatM
	 fGHN//12NfvUw==
Message-ID: <sashiko-outbox-185594@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf parse-events: Include errno.h before kernel
 headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBFUkZPUk1BTkNFIEVWRU5UUyBTVUJTWVNURU0=?= <linux-perf-users@vger.kernel.org>
In-Reply-To: <20261026174814.3158229-1-florian.fainelli@broadcom.com>
References: <20261026174814.3158229-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 17:51:58 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Building perf against uClibc fails in config_term_common():
>=20
>   util/parse-events.c:954:30: error: 'ERANGE' undeclared
>=20
> The kernel headers included before errno.h pull in asm/errno.h. uClibc's
> bits/errno.h undefines EDOM, EILSEQ and ERANGE before including
> linux/errno.h, but the kernel header include guards prevent these macros
> from being defined again.
>=20
> Include errno.h before the kernel headers so ERANGE remains defined.
>=20
> Fixes: 6b9c0261b3fb ("perf record: Add ratio-to-prev term")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026174814.3158=
229-1-florian.fainelli@broadcom.com?part=3D1

