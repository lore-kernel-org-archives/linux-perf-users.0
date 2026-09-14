Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD30837D12E;
	Mon, 14 Sep 2026 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378368; cv=none; b=tl4ZbUm+va7vqIXBwUvZHmAl/FR+rzPoOWOpykCDjbPoABkeSE2MyxJtjNlkXFHoveuAbTw+oJIR94vWgRGhcZkg7gn0lZlYkOQRdLqW8W2wPtF8SL8cYCWn1kwPuXXdTo9nbGtWOB2wJkPKofnFODYLjwciKtycVXw500npFY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378368; c=relaxed/simple;
	bh=EGGLwfkvC/bmmdRr9joHnUFtlfZrZE1gg7U1RgrGHAE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I1WWfbd3ZANxKRvQMp9T8iX/phs0S37tcckPw+Zt+F2qSJQndMT105RkS20ZEExWaP4XdNWzbwQ784AXrCxQDvyi/tiWTKdT1BinHCjWOvHWTW1eVee84j9R+V46/4pMO+9TUNBUcoOCuCpVrCDdD4+d1CWrXDYfXhh5ml8DOZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Th8wHv4J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Th8wHv4J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661861F000FF;
	Mon, 14 Sep 2026 09:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789378367;
	bh=EGGLwfkvC/bmmdRr9joHnUFtlfZrZE1gg7U1RgrGHAE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Th8wHv4JNNKzyrlYUql3b+BYne0/udn0j0EUsxiSV3CUGcDnitBFbPjFP2Rj7e0qy
	 rFT48xpZcwuFEn5DsHs2Fs3fgOLQCSmes7/uuTWxP4lh+lwWd6I12d9dmOsOgS/+WJ
	 yCAotq4osVaMMdyeA+HgeOw4C5VsIl1hgVKEFKjKtRFaMIhScNU66sQw26n/BIXlUp
	 drF60/ndtDPpi94lAFkqn8zIhdkqZszn97XsCNpa4d0+utIFCHTIUKsYFnp+hPv3hI
	 3NmVkW8p0TNTBx+wOIoD/Z0XoOOmBb+MyUaqzKNuuR5VsNV/ottLU5ZN95Cf18sZ6Z
	 TM/8O7gCfw57w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/7] riscv: stacktrace: disable KASAN and KCOV
 instrumentation for stacktrace.o
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shuai Xue" <xueshuai@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260914092648.51254-3-xueshuai@linux.alibaba.com>
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
 <20260914092648.51254-3-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 09:32:46 +0000
Message-Id: <20260914093247.661861F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Wang Han <wanghan@linux.alibaba.com>
>=20
> KASAN records stack traces for every alloc/free, which means it walks
> the unwinder very frequently. Instrumenting the stack trace collection
> code itself adds substantial overhead and makes the traces themselves
> noisier.
>=20
> KCOV instruments every basic-block edge. The unwinder is a hot path,
> especially with KASAN enabled, so KCOV instrumentation has the same kind
> of cost and noise problem here.
>=20
> Mark stacktrace.o as not KASAN- or KCOV-instrumented, matching the x86
> treatment of its stack unwinding code. RISC-V keeps the relevant unwinder
> code in stacktrace.o, so a single translation-unit annotation covers the
> equivalent scope. This is a prerequisite preference for the upcoming
> reliable unwinder, but the change is valid on its own.
>=20
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Assisted-by: Qoder:Qwen-3.8-MAX-Preview
> Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914092648.5125=
4-1-xueshuai@linux.alibaba.com?part=3D2

