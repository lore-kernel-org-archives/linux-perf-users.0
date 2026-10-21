Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792623129;
	b=tyHOTlt2FwhR92zW/Hej4Xp8+qhWdtDzy8Z7H12FvfmNeIrivQ6aLlJWhGgBgN9sk96J
	 ZD8f/j4VzHTwDKsjfO8G35TgC6iBcfeXxmrA9GowbrwT7LoFi62NYd2EykPe55M9zwD4c
	 drZE1kvqVC08WF6xpHpGeW+HmOaUuQFijMhDgHlziRxIXnrYTB4dnKUKXRn2jCmKxemSR
	 EBZpXRpsVF4zZQkaG69Etup8X5r1xwlImZVQ30jz710QAEuj9OJ0TssnMylaBSI+knC18
	 k/AC06OUzj9UHngV57y/hiCI9YjHzQow95wd+97aPwGi8DXdi51hLZIPo00WTEbDliQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792623129;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=h9DT0cMoA50Jh4alT4jvciF9jhrSUnny0ak+sMFv5bY=;
	b=2dq2FEtjA8uK3wFHeHmfrNyjxGAu1wiXtmR9nuLvz9doTStIdHxqnSi1x58NfWBT+9yg
	 4AHhbf4YAvDRJucDrAh+fcJugG5v9MUEBE6/Tcn+dgeY9F0xK+WoSr053mLuBzKrTtGss
	 6Nnhr25TjyNl6DPBQOs4o6/n0QzXInwLt0udxdIE3rBMtAM2sY5ckBXvifAIxihJH9Xri
	 M2xnFPg3n1zrRa/mAhxscufDMExR3m77sscrZcrpSI0oLZwEzoueIhbeWYcUbtnjhTbKe
	 fUgDXP3wkXtfbkYH8TNebUqlyVBGdnc3dpxpR5pY0eHTZfsSwogYCdDT8s/yL5+iWlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gdB3gj8C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7CC606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gdB3gj8C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90C91F000C1;
	Wed, 21 Oct 2026 22:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792623128;
	bh=h9DT0cMoA50Jh4alT4jvciF9jhrSUnny0ak+sMFv5bY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gdB3gj8CcOnXuu4B4+hq59/JRaGmshQktVhLTxoae0+KQ67Qq7AN6XBDibt0F2cFW
	 X/oA+KL7HkJm7WEqBIsEjFhQxbsXbCmEsyQd8RNhs/lzy6iFYybxbkq8zy+1NFioLQ
	 +WQeXvcYMh8RLk3dzqeRbE3lmxqLlAdyBZ4IMly8aU7WRvvdl1nDNcZIaL+J/qrsP+
	 CiBISwPVmbcMiTnh/Q1crUoZGhDjjdJ29TbUvOriPIWIk1deEgrGrGxXqXmGJ/w/Gx
	 cAz1MwGJnuAfLV9HwwDjB9bpae/e1CwqIn7RpA/ke9Mv+zdGSRF6ur5R0CDN0TY2tS
	 4z5g6N6Zyw7lQ==
Message-ID: <sashiko-outbox-180746@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/17] perf dso: Use DEFINE_MUTEX for
 dso__data_open_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021223905.715051-10-irogers@google.com>
References: <20261021171044.155240-1-irogers@google.com>
 <20261021223905.715051-1-irogers@google.com>
 <20261021223905.715051-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 22:52:08 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Replace _dso__data_open_lock and its pthread_once() initialization
> wrapper dso__data_open_lock() with DEFINE_MUTEX(dso__data_open_lock).
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021223905.7150=
51-1-irogers@google.com?part=3D9

