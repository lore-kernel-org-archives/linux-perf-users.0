Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792966604;
	b=PpWE8jyJbty8mM6lVhXVrothRIe8/JilolfdnLa+PDgLEENd0U8NoZiAYVHTOdpAwyq6
	 +Iz3LKFuY6rdLG7Oiad5h+wVMBOjHU+x2h1qZfjUPjJPl5AG8NQzCQBiJSf7ltwpM6NOq
	 3cMRuoTytcykWIbnsgmt/R/qwMApQhdsNeUmOaxO9PvI5j2aSu+PwicpPlhERx+tCpLpw
	 gjxrBniVE2wj1gHYnXnQRyr7S8PoOgcA2WMBDJGu0UAzDyH4kI5xRRgCEhboLOqaDewfR
	 42m+iyShpovHXV3V4woY7oIMgniRs6izuyE7qCxDqEl9jei/0kGuE0Z0lRbA5BI1Mdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792966604;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0k8QHCtJiR7XRuwjdWhiMSkvJhVBegLv0lq+/8OTylw=;
	b=rWeBdZ6dteQViTJwAEkzOoMmPfVupVerD3m4Dky0sB6wrYiiyeHTN+YBocjZlFCBBL8W
	 xpRLPiu/ga/ICgDwjVyLNRFH3zCyVko0KVtcyaFkdl8nxfRVxsvkL3LJIZlSGTne+S4Iv
	 P8fwcLPgWzOgrdxI0Q2ubfjQTOtKqpNHptWC/hnH7AlgqRxFd4xSlzWP5zqrqVkTfjZZG
	 W8ugCeP+dA4x0QjjCk12HdfhIzvyAYlGcPDKkQYXtn9ruBsEmW+SkKqv07+16mpPMyN/Y
	 q8HaBhPA8u9CpBQkWKLuWhVuUFxstkhv7ZsrdjUUjT6Ezv7MTpQ5Hd7QeWil4T3c4Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AMD/kbRi";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFA6606A31B
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 22:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AMD/kbRi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3DC1F01825;
	Sun, 25 Oct 2026 22:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792966604;
	bh=0k8QHCtJiR7XRuwjdWhiMSkvJhVBegLv0lq+/8OTylw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=AMD/kbRixJaSaapl79Mo657P0PO1MuZtGjq9E4/oa64+wdVV/HUMemzaI5/j4w1rA
	 bgwHQdC3LFvWgvATxYd8NFU+zTR2w+UWO1x9dZe6JnwVrveuoo8K8XDKqH/gF7S2aM
	 VcMi3icBnG0mPiHCntR3U3DuOBTafPhT9FmK4/2eoPtJS6PtUPT1WGGlJRm99rIlrX
	 /yKmjwh+7m6UEdsyCQgAB9AqGJs9kfPImvwpBrPrG2YE2WBnFIrPwtQ8NiFXUOEySl
	 frTfMkprNU6HOH9hu+jcRb1Qk2ZKRK82sDyFQMccteLuRXI9h9zbf1oL5Q3fOvGLLr
	 O3Gv92QgUa+Gg==
Message-ID: <sashiko-outbox-184468@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] perf/core: Clamp deferred callchain entry count
 to fit u16 header.size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261025215508.1237480-2-irogers@google.com>
References: <20261025215508.1237480-1-irogers@google.com>
 <20261025215508.1237480-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 22:16:43 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In perf_callchain_deferred_output(), if trace->nr is large enough that
> sizeof(deferred_event->event) + trace->nr * sizeof(u64) + id_header_size
> exceeds U16_MAX, header.size wraps while the output loop still writes
> all trace->nr entries into the ring buffer. Clamp nr per event (accounting
> for event->id_header_size when sample_id_all is enabled) so the record
> never overflows u16 header.size.
>=20
> Fixes: c69993ecdd4d ("perf: Support deferred user unwind")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025215508.1237=
480-1-irogers@google.com?part=3D2

