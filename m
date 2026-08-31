Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2569375F81
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 19:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788204663; cv=none; b=XU/rL4uG9xB0Jz5OfZPhKATtsfoGys2vfNxuD8LU+JGjeZdPtEKSyHVda4sZ37i6uONO//W3Da5EzQFOBjarlEcIYgqSPUL2lX/ehhC8gy8nPRP62FtcgXmCJmgTZCbfRnMLSrtRxE88Zga0/2LqkLGGjmkTy7KneQ6Yv6rR4BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788204663; c=relaxed/simple;
	bh=0gctKc2LsVY8A3rbjB0KLp9CReqiG9nVlM6p+9dV0ok=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AsBjO/DvCzW0srXVQjCdK0OoCx+ScOIpJNHSbD5Cdlr86PxxYsc5ZSUV+iQT++LoNNDx1+yOrRk7t21OhoidNawaJawfSJ9k35yjmvAkj2lZavhnBd9Dxm5MgWPODCR31IDWcyBx3QR6A0hTppvUiiGjcvul3p9jsj1Al776/iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwAt4HM1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwAt4HM1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BB31F000E9;
	Mon, 31 Aug 2026 19:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788204662;
	bh=0gctKc2LsVY8A3rbjB0KLp9CReqiG9nVlM6p+9dV0ok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YwAt4HM1OOluYdl65pmi/zzXIdt2ZOSH0tVfaCEmxCzmw8Xxgwx70MznsMGRTeKhy
	 rIHsi0K3hO1DRpI/gkLMBiZyeR8pE3Fu8+THPV195EGO7JjK5AMSaVRQnKKrRl9xwS
	 OE4+5qTGh8hAHVlNj/YN0TRVqYTRkSiDJHr007PWfSt+r5XZxHX6Bvr2iQCK8YYsff
	 iBwlgt85hs/AnVgLWLWo4n9wCwCtAM4sS7E8b6tlZEK5CoP3DF4Yj4etvDS6vn8so3
	 CPaaqJKt6ApphvJqjm13R1uUPCzW9CvFCYVukJpJyP+IbuWi5dB2ckecASSJTZ3n+R
	 r+IOfDY2ZHANQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v1 07/19] ptwrite uprobes: Add support to tracing
 infrastructure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831150651.1134594-8-ak@kernel.org>
References: <20260831150651.1134594-1-ak@kernel.org>
 <20260831150651.1134594-8-ak@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:31:01 +0000
Message-Id: <20260831193102.15BB31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Hook up the low level x86 ptwrite uprobes code to the generic trace
> uprobes events parser, so that the new probes can be set up. The
> interface is similar to classic probes, but there is new ptw: syntax
> and various restrictions.
>=20
> Add minimal docs.
>=20
> Architectures without the ptwrite backend are handled by weak stubs.
>=20
> Assisted-by: omp:gpt-5.6-luna
> Signed-off-by: Andi Kleen <ak@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831150651.1134=
594-1-ak@kernel.org?part=3D7

