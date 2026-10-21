Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792603386;
	b=gKWeM/bsr2dsAmP5L5hLFOMg5y/4hvfz+DppV6pKSRpl6xznt//Mi3B5E+Nzl0m1ngE5
	 XkdCGAmzUG2/sGZudSdkzn0OuCNYBmxpeBBFXHahdN/N8yNutyMQ4/ydJBjCGl56R8DJm
	 gObr1MSTaAQ7rJ9VNT0Tp5rtfJsYibIufAuVquvBrCXF1epRiIXygPzmwVH8tUdJTXwOc
	 e7WssNACKj6asCuNfBvwfPvoKBOs43eqEroInv7MEzikPFwzmcciW71HPxIVWxOIDm4+v
	 umQOwR3SKRYFeQmzIsV/xXE8cWVSh1lN1Zok/n95LXaWQpqT9cQ/s5Tc84Cmqc+j8zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603386;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QvGY5tznW291TlJ1orP26zByeEIusxCujHAMBFLoe3U=;
	b=C/9XM4uTKn7hKmhZnrABrsaWVAK5ydp0CKVlINR7kTRbhHBFmnsqFSl19LEwu0qGLhZ0
	 HAHQ4/b4VJFu9VN5h90i+4LfzUTuiYGdYeKHANt+flJtmAGZHmDaeBJJxzM3OqqYZcg8/
	 edexbJnK4OfdedxgPH1wzsyG8jhnx7LI9s+LAIEtsPgUMaHROWLRhbsVJKVLdKYVpA+/i
	 V1BDCasVoFdqh1YjMGAKDNYIDnx1KjcyiJ/Q7I0x8YMOYmY6HgCoaIEZ3tnhjPaD2iw9c
	 YRAyB9NcnZt5aOaJ4gLXy9f0WD4upmGk1pvmvuLbKXwy5HCD1MESyIMvP74kd+qXWMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NjdPDa31;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9969A606A31A
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NjdPDa31
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579001F000C1;
	Wed, 21 Oct 2026 17:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792603386;
	bh=QvGY5tznW291TlJ1orP26zByeEIusxCujHAMBFLoe3U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NjdPDa31MsMkWa/uAzNsy1gg/ykm9c0c1u0Q9t5BjIZgtunvB4Ye0AUsPgoSyCsYI
	 ITqsNJut2ci0TzAxG9/GkbvaLrRkkl3VvgEC+EgiDyk0UNAG6p2nWzaNc6cbZjY5wA
	 O18QaDWoABjj2Uc6K0QK3Sl56J2vKkiG/vSooARmpWdOJv0sEzUI2yREp2KkAS57Rr
	 6TWPFz+kDLSubd5corulHw0WGgo/HXsHKSvf8ChLdF2joNMllgBNgv3SdBDSLKwIeF
	 9HcyfU4FITPLwwbypX+gZXsfT2jh3l+PxwJj19JaQGSAUHL4f5v2HVNcOuanXXdUvx
	 cC3O40X5iLnaA==
Message-ID: <sashiko-outbox-180520@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/17] perf build: Enable additional Clang
 thread-safety flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021171044.155240-6-irogers@google.com>
References: <20261020163640.746159-1-irogers@google.com>
 <20261021171044.155240-1-irogers@google.com>
 <20261021171044.155240-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 17:23:05 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Align tools/perf's Clang thread-safety flags with the kernel's
> scripts/Makefile.context-analysis by adding -Wthread-safety-pointer,
> -Wthread-safety-beta, and (when supported by the compiler)
> -fexperimental-late-parse-attributes.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021171044.1552=
40-1-irogers@google.com?part=3D5

