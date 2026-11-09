Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794224375;
	b=rcnBYKok0k8ZZOhBUcHU6schnQbT5jHztyfnd8qCw7PYBXjpowVL0Anj7icljJAdcNgK
	 xUlN1Le2u1XRvLelJln1lbiDQCrt/SCJMaGyeyf3BQQyU6FCuQmKtp/8ZHokMxaA7QWTK
	 y2/ho+lypP0bbKWqLOIxXEDUgzglII/HvzowJMF6tsPSl0LMYAPAWRl6HygT5ldRhHk2Z
	 L1eGkW1o3DOO7LzZdn2/52fB+wFbkiYAAJ+F9mzZL32Qi2i9dfpf8QT6a4TnyJ0b76l+b
	 Wj0R2OoVyGMcMds0qvh9TNv6QcIUy224NPEP2SLFKGfweYK33+HtbbI6xC/TODDZ6wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794224375;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VNSDZvpLO7HPc4KWDDbaXkgpfXjIhKp3V3cctZWwApA=;
	b=NYXFBGnHlrRgh672v9Vlrb+vPVqIfI46SAaqlMcsmlxeOwf7G0BX3qsIjGlCzA/+H73j
	 19N66NGDpbVl7HMFCgj1/vxNQaj8TI4IGTjMykx7THYA+65Ov/2uTi7i1imCARfqyWvX0
	 q2qbB0DBwYMKNzt4jbtxT/WaZB2Mtvq2hqPyzyOjKpYIeAxThst98nj/hulEuRwm3cl+L
	 TEDbdN1sxdvv7sSI9LeESU2nX852+Gf0OVDx/0nuq6b88SKq94H6SUsW8zP6k2Rifo1Z8
	 gyo4IQOEGsEX6xGKLKWLgc8P02Zx98RNs1YpQD9JTRYK3GOlXkllVEyQP5sS9y7WlRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KMheanti;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7C2606A325
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 11:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KMheanti
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A001F008A2;
	Mon,  9 Nov 2026 11:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794224374;
	bh=VNSDZvpLO7HPc4KWDDbaXkgpfXjIhKp3V3cctZWwApA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KMheantiWZ++yByclTBvsAXgtznDVhyDink4tvNd4JlnF6JFah50I2oDmJz7QfahP
	 6y9uw7ab8yd6yGsi1wDTS9+un/IshqmrVUEXSNUlgCmtvooAA8fu2GDL1E9zFPY9AU
	 j7FFovURx6DrvuFNIMylhSLyXk5Hrm4rSsKfz0hCks2wN4LePlMPC3LXqRaaynkd81
	 eh4LBkKtCgSzg2kwPOFgVhF3P1CMMU1aqK9mgH/YTNO8nTSNeYGPX6ec5RQT3tA0RA
	 pPTLZtyTDm29b8Kydgqm+Y6b/8UImKblmkYLtlQt7U3OvpI6l+onYYgUqRkpbsxI8/
	 t2SUY41iwtBmQ==
Message-ID: <sashiko-outbox-204886@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/aux: Fix a memory leak on AUX allocation failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261109-perf_fix_aux_page_memleak-v1-1-aae781d6749c@arm.com>
References: <20261109-perf_fix_aux_page_memleak-v1-1-aae781d6749c@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 11:39:34 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> rb_alloc_aux() allocates rb->aux_pages before allocating the AUX data
> pages. If the first rb_alloc_aux_page() call fails, rb->aux_nr_pages is
> still zero, so __rb_free_aux() skips freeing the pointer array.
>=20
> Commit ee9397a6fb9bc ("perf: Fix double-free of the AUX buffer") added
> the aux_nr_pages guard because AUX cleanup and main ring buffer release
> shared an IRQ-work callback that could call __rb_free_aux() twice.
>=20
> Since commit 95ff4ca26c49 ("perf/core: Free AUX pages in unmap path")
> removed that shared cleanup path, main ring buffer release no longer
> invokes AUX cleanup. The earlier double-free race is therefore gone, so
> the guard is no longer needed for freeing the pointer array.
>=20
> Free rb->aux_pages unconditionally to cover the zero-page failure case.
>=20
> Fixes: 95ff4ca26c49 ("perf/core: Free AUX pages in unmap path")
> Closes: https://sashiko.dev/#/bug/linux-c1a2bb3b-5d2a-4fca-a697-ce07992a5=
cc1
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-perf_fix_a=
ux_page_memleak-v1-1-aae781d6749c@arm.com?part=3D1

