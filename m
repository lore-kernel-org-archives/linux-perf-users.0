Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792603019;
	b=2YmMD5sztDdRhbLwzvIBvk1RnuyHkA+QV4MuZqoxmVUcg44QtCl/NRMcUgDIFQJnSEAy
	 QfVlwFDeuT/9HAoINnz6p5VQmyI/66vconxddo4azmPS7vBJM5lWQusMObFe9dhsVxgeZ
	 MDNRpG5gjIw7paEJGaw8wOHC8O85NsD5qv7uvy/GFoIVYWYz40NVqd57qwn+SuO8nFNMW
	 04bYCXBPYtVDyFk1I2Ryc38qef+b3+dPDrSLwUNniMN+lPKiJDlobH6ctWcOPfrfe37NC
	 RjuqEVuIM98qNAh0HcQ8UR/geHORx2T5+dddQHEs4iq1fkerbw+zIZ2WGw5KSZQdhHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603019;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PT/tXT7uO6BdYxLnOHXFdzSTMqtAzmyxpZauj6I729E=;
	b=1bUSlPx/M7fBNx4490PiX/VHOaSMLD5dRpd5FtambnmpPJUWkZ5gxOyPl8pAidxzxFzN
	 zeVO1w7M39N+NPYkjDVljJYLLQz1qRw0RIJVH82cc1eMViKc3FplDrw3ye94hhkq2HHev
	 JMgyN9gHSW50n0SmdTaJYZeVA3C/yrrhphuwGmN3tcrNyzCLAUiiR7//N/W/rkAqZAe8T
	 J2si+T+a7cxVK3uC7U1kczSj32t/32z4FZeMxiBx1Wab3Xp2oDzr0tlKW1lAMRErAxl9e
	 m8zf6RIbwyhRIqrvNou0d5hG6z5TMscbaXDpIdp5WeIdScp2DM8rJESnmjegT7nPWFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nrGgCvrx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C219606A324
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nrGgCvrx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABC21F000C5;
	Wed, 21 Oct 2026 17:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792603018;
	bh=PT/tXT7uO6BdYxLnOHXFdzSTMqtAzmyxpZauj6I729E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nrGgCvrxQ1gRP0Bc5dvSF9sfnfcZzNdx82QZv9lBvnGlN7CmU3SbURzgFCCfk/eqB
	 qExwNHGVgZEEEZz8WulY1zyrqVQ/l8ISqBn64AHoSOT/P5Xz/MB+8078AaFBPzDN3g
	 50S+UlaXpoeEkcNKx1ZI7wIrqrNaAT9VEvrdwdO4E4vJF0XdsfyPzDcL6QCOQ80Cdf
	 G39HwO3syPG6s7+7F4vc0rBzJJMtMruB9q4xGnanFt2CeGoiTEYWYubgKMWwuIBb5k
	 j9LnZIMlDX5NlDvCMAblRtRcnmkLtlUB+3jOpsssRqfwNPKyiAh5Fxkp4+WwABqRNX
	 l651xpFF0oIRg==
Message-ID: <sashiko-outbox-180506@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/17] perf comm: Add __guarded_by annotations to
 struct comm_strs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021171044.155240-7-irogers@google.com>
References: <20261020163640.746159-1-irogers@google.com>
 <20261021171044.155240-1-irogers@google.com>
 <20261021171044.155240-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 17:16:58 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Annotate strs, num_strs, and capacity in struct comm_strs with
> __guarded_by(&lock) and __pt_guarded_by(&lock) so Clang verifies all
> accesses hold comm_strs->lock.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021171044.1552=
40-1-irogers@google.com?part=3D6

