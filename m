Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794219743;
	b=nhf8Xk0siK328qvzaDsnu8aVRIFCqmhOi8l2dZZT/G66zNraXKEoiQ6CsXNOYHcBH80I
	 1oFD3fObC4/EJEuu7xh/2MMvgJW1kga1uO66sLUDFftq+nVG9hNtHqkg2xNQL2dVy9Fel
	 qEoCCHpPHeZSBGPuXI/tU+F/FM5S2kpDps89gYMYOpfcI2vIRgNVl3zzARboK48vS47T5
	 9U6Umjv7/tV+JDFWrl96ISzTczylE26hWd3bm/ZFUlTEEQTYP/zQW8WnfriaNnEkfJky3
	 JDbk/xCZEY1of8wvPvdidSRVyfwXMiPrwpGmJBYZNi7Gghhp45NuGtznGS9iH/B+Sug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794219743;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6r2Lu/5zHCxqaeNw5gTKU7GKO2KqmGoSoals6DD7Yms=;
	b=FBP6X1qvL5JZ5Z1yhhPFSB8b7l0GbJ4oZ6k7jZUCT8SgaxVr/BW0sP3L9CD6R2ONUSuA
	 rGoVj+nN2kGn0EilrbAKwbLtq/ToK6eH5nXXF4BxNywilzqgrO6+gMCd6rDsh2ZNt5qR6
	 tn5H9tkbp4cySKJvtUbozRkvgl++pC4tmNnaZHoHPrKToVrtUKD7hmn6i6cEAlhNiM6/Q
	 12i78k1vQiYdQGYQaUxrPm3Fnj41/MyF1B0NlB0FI5pVz25ShNF8UIQQqGVtVPFYKQAjl
	 D9V8B8yX/0OSa1CWC8PLUrvy9l75EAPiggSgHUIpu6NLLDSN9YTrcUaTlXU44K4gyCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VxwIbJqP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109F9606A31C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VxwIbJqP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9321F0089F;
	Mon,  9 Nov 2026 10:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794219742;
	bh=6r2Lu/5zHCxqaeNw5gTKU7GKO2KqmGoSoals6DD7Yms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VxwIbJqPjCG/Y7yUazVkBFHpxWluWvxyc/sz8K7CYloQgp00iQGUrfAYfyPq4sDwO
	 1wdawhd7vKFljRDUdFLX7pbPuKvdheEQ/uDS5A0w96oOWf3YE8BmUGNA8zluEWO02s
	 68UpKtON3dB8s4oxb7u2+/DcUGtdabsYP8vXM7YjB/BOjipQz2b/mgkqeAGCFAYQRy
	 X4R5cjWd6wzb6apwShHYzL2khnW8CO5EC7mLadc+fd3/g81bkgX38ejA22fmtFYKr1
	 ypQaMJevq9o5Yn+cy3P9sSKR1quzzxxYT3ZHTgTHeMhaLFK9lBXhefr5wtE6q99WQx
	 a9EZJB0d4EC+w==
Message-ID: <sashiko-outbox-204807@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] perf test probe_vfs_getname: Fix missing
 debuginfo detection
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261109-james-perf-test-fixes-v3-3-e8d0a65e618a@linaro.org>
References: <20261109-james-perf-test-fixes-v3-0-e8d0a65e618a@linaro.org>
 <20261109-james-perf-test-fixes-v3-3-e8d0a65e618a@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 10:22:22 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> skip_if_no_debuginfo() looks for the errors that 'perf probe' prints when
> there is no debuginfo in the output of add_probe_vfs_getname(). But since
> commit 92b664dcefab ("perf test probe_vfs_getname: Skip if no suitable
> line detected"), add_probe_vfs_getname() returns early without adding a
> probe if 'perf probe -L' doesn't find the line, which is also what
> happens when there is no debuginfo. The error from 'perf probe -L' is
> discarded, so the debuginfo errors are never found.
>=20
> This causes the debuginfo dependent subtests of the
> "perftool-testsuite_probe" test to fail instead of being skipped on
> kernels without debuginfo, because test_adding_kernel.sh calls
> skip_if_no_debuginfo() unconditionally. The other users only call it
> when add_probe_vfs_getname() returns 1, so they aren't affected.
>=20
> Fix it by doing a dry run of a probe that needs debuginfo instead. This
> [ ... ]
>   ...
>   189: perftool-testsuite_probe : FAILED!
>=20
> Fixes: 92b664dcefab ("perf test probe_vfs_getname: Skip if no suitable li=
ne detected")
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-james-perf=
-test-fixes-v3-0-e8d0a65e618a@linaro.org?part=3D3

