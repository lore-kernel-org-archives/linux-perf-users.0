Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254651;
	b=25f2HRF+0JyE2/b1Qfg4w3NyGzG2Vq8L5ge3C9aATy6M6m9Z4y1F6cFQ8I7wKdxBs51E
	 VOiZnZE2c3MvVsDoO+82vh0mtnS7HZ57rl5NqqKRd/XQpnJrcSZEMnDH8unyx6Qo7OhE8
	 8Mj9iAFghheNt2MADpxiNd/86ERSOFOuxMQHnbXuOGgzG6RDCkFiqGFIgLQ+q6gPODWOL
	 /CS2Am/zlm2EW72iNs6lpTxxhEKQMJkUf3HEgIncraDlXbtVG6/G1+yELUKJbDoTw3mwj
	 2McbtMyKEirkSPy6iXpvOjAgYiE52a3kGtvAhODRQQ3/PI2f/LYJ+2VuVfJYHnkECgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254651;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3dXS8MXwCFowZLM7LX7mEmr3W4hw8AHA0bjXrDB0Tyo=;
	b=v/bTlZwA9jkt1MPY2St0PA/+rsrjZ9h3OXjYAGmPUtrsf8hWnDgtrLG530L+QwwAoBAw
	 RZhyqND4Pyitg7oT/JyG8x16z/xBHMnc6q0rsn7l0WbjcyQlzGfEwbkth6CO5xnf8v2rn
	 UjLkEr6+qq3fF/8R4YmV0TMMrlb+ORVuO7XKtx/HXqYm55g5HzuSJmLZ+lFMaPWdB3dzS
	 fyfmVBE92Kncwi0a5diXVRTY7vqAAHXIkrSwBxajEs019VCQoVtQZIqKz/wlOelAnOYO/
	 lJNB0B0ljaUpUDEymmLzDsaA8Ys0wXrUOL+XwksPzNCsJUUuQTLo8lONHePbtfNo8mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZpN0hBxt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A478606A31C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZpN0hBxt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC801F0089F;
	Mon,  9 Nov 2026 20:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794254651;
	bh=3dXS8MXwCFowZLM7LX7mEmr3W4hw8AHA0bjXrDB0Tyo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZpN0hBxtG1P627z2YkoHKa7WlItUACaF/zbnbIkM9MOIdOXBuS81VqHPdaJE3Ouv9
	 1nzVuvh5TPfG1iTDZxYLQ+yFbk1JjhjmBvX1ZVLz+GC/PvkZQ7QfqJfRpLYS0fFNaJ
	 K0LPu+DjpDEnT0NGjfVGQkbRSQuHmClgCkH9BCDUxMkGxHTjEHBfgKVOAzphfLz6C9
	 q2nu1k/aHrcvZwNbDZcujMB9/ZKOIexwx0NcSlAUksLjiCQMumyNmF6ctzeuNp2qJ/
	 ZXfNIVvCRNaNxL6HFGUdVKF78mSlqTLo/b/V/PjPcBtIFVEoBdvM+h1yWGBbB77STd
	 rEcey2OINWSJA==
Message-ID: <sashiko-outbox-205530@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 03/20] tools headers: Synchronize
 linux/compiler-context-analysis.h with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107044102.1506626-4-irogers@google.com>
References: <20261107044102.1506626-1-irogers@google.com>
 <20261107044102.1506626-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 20:04:08 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Replace the no-op stub tools/include/linux/compiler-context-analysis.h
> with the full kernel implementation from
> include/linux/compiler-context-analysis.h and add it to
> tools/perf/check-headers.sh so future changes are tracked.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107044102.1506=
626-1-irogers@google.com?part=3D3

