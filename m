Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604386;
	b=P283SpaDCWPaRaLDWdyV1lU6JDzVG61WWjcVGh9P0j7WbghM+0E5AJtpl9t5LWF+nbra
	 lvuZZwDY4OAKIvI0It0mYtRwPYeYrr8q1M+eJ+2fOFuYZImg/JQJwiimi+TWtI03U4JXk
	 VzANgR0UnUuqYkxP96RtoFrsCEjizIPP77VBj0rNUfRCSpa7OocVreP2coPpmM4tZ6Hvg
	 wLJh9FJRn5EnMd0h7dS/Yoowi0/w+TegoMgR9BNNh7eeMGF4uWWgfYDnxi0IodkLj51xL
	 ZFoTB5YE+2UOfHqPY+P+9m1xMWEDZyLoKhpVpBXzBXCIpXue8ZRwX+3FIS6M0SgAv8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604386;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=G3CGRAr0OAm6owT49A6bX7I0JWJJjyn/93q9eOLzc7k=;
	b=oJFophVbrBYRyl4AHbXwFc1QIvFhV7wFSK2kfV+laK80B1m3Jp/Sy35DmkWxPz5CoMVx
	 IeQJFqHwK8qoZmKTXwF0F6Ls17l5AIXMi13OiqKu8l7WW8auIPp7lDkRLOzp3cnp/frB0
	 ENbqWukU+FPMQdM4rdTmGozc/WBF7Oc8DJvR9UNEsza7t0crjmsMjwbN1RDu3nlKhSHQp
	 xUNodCrF8ssQyGQT39wA/AiRgktym3CzWDaQqBfGqo2iFp4/IEWJBbKLjHGzxt0deTMFC
	 vySmoctz5PPHPFdI2mRPs52ZArG/0Bwj43+u2ZlANvBizjtEcVtL+1CKneGu4bh0Tug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DhptCm39;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAF9606A334
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DhptCm39
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2FF1F000C6;
	Fri, 13 Nov 2026 21:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794604386;
	bh=G3CGRAr0OAm6owT49A6bX7I0JWJJjyn/93q9eOLzc7k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DhptCm39a+VYk5nF41/ayA0uOwIQiMQH3keBmNusCyNnP7wWhM/Vkc8v4OSdw64K9
	 QsuFEIMbfgrE6TQNr68HR9F4X3qK8P4UnH8NLPGRZZYStQkVFUIAmJUucd83ZStxDO
	 9bwQ1UDHZBSrgwXRtF9922ntcvPw75+r2k94i5tGsEtN3Y2pSg2xwLaIAUz7BKmO8A
	 ZGID4BTN3Q8EYzxFZyIuLBCW2R58EJRGBiojhqPpPI9AM9tJWsP0vxSPM8QGdv4Trx
	 fhveMc+LV9CePB13VicyJVBqgNweyv7OSQ4lYReaXfEqg80WY+0XgZAaJEEsApCgUB
	 T3AGtc5nRu2kw==
Message-ID: <sashiko-outbox-213695@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/10] perf jevents: Add --compress=lzma block
 compression backend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113210822.3112700-7-irogers@google.com>
References: <20261113210822.3112700-1-irogers@google.com>
 <20261113210822.3112700-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:13:05 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add an 'lzma' block-indexed string compression backend to jevents.py
> using Python's standard-library lzma module (imported lazily) to
> compress each ~8 KiB string block independently as a raw LZMA2 stream
> (FORMAT_RAW + FILTER_LZMA2, dict_size=3D64 KiB) decoded on demand via
> liblzma's lzma_raw_buffer_decode() in pmu-events-string.c.
>=20
> This provides random-access per-block string decompression indexed by
> (block_id << 16) | sub_offset on builds where liblzma is enabled without
> libzstd or zlib. On x86, --compress=3Dlzma shrinks pmu-events-string.o
> from ~6.90 MB to ~819 KB.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113210822.3112=
700-1-irogers@google.com?part=3D6

