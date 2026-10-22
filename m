Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792702419;
	b=24CCN08j1juIYIikSr6H5av0bPt+KfXuWTgzelRA7xRf36nSzaPbVGeBOwth2whfD6rw
	 xOAwTTSLoXBArqmckRnHncpv3MDl+REjlf3fct+TIEz9C/6BZOds/POif7IyrAOHdz4mQ
	 SVKiFM6Bolt0mZ4SfbBG5X+zh73NNtXU7T7cr8sGtwBlZ+/GD8UFl0c3/NgeNRaPRh6dK
	 7g4mrlbNDAXyuVgZ7ZhGKE45qYrmUxuJqF3KgzjxjY5LFvFKGT/6iGXaNg0bbVZ6jtOtl
	 fcsukLrZZl7G011mPAtR7X/xTjjOjaMbrALjE9QS02gHJ1LXc0Q+QZ4ODqo4miVExjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792702419;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gCFKK0zd2BOTvgt4lEvvzZmkgwqeFJVBDkSXwrtHiGE=;
	b=N0G/T5PT9v7FZQ4B4xNBtD2YaHJuogMOEJEWqIo62jcP9wtovNmALbX8atoWFiHrmpzO
	 7UqrtJ0QaVzlMh1PgoKWelR+B9LiFcRPC9SmKXA0LCz2ncMHFa9ovRVjw3TiQjPF9S6Qr
	 a262FDe5V4MLDNYSR9joHJ7b4tddLtXbHLeilab3v1hNPQao38I/KBwNvOEnuZhcWOAyP
	 LZqRM+mIx/9xgzWlzeFJDJrq6jssFRbS4fAYvlCQkyEWuwXi06IQVhe/5FCd/faynA7np
	 hv43vr09sUeGgDNeHEpWH2Ruyjr/wb94nJnWL9zfjC1KTENyXHvIVi0aW5nfLVwN/vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FADo1Wqd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3CF606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FADo1Wqd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECA81F01825;
	Thu, 22 Oct 2026 20:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792702419;
	bh=gCFKK0zd2BOTvgt4lEvvzZmkgwqeFJVBDkSXwrtHiGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FADo1WqddUJtcl1zLqiS2vVKLIj25lbIjpdR75p0sYpi/TWp+GiJxyAZye6nY554r
	 6rHiVbgpU3XulZpN5NZ/LXYnR0EKtfYxYDVYDtZkiA7ETBKtPPGVdMq3UX/j0Bsi/8
	 dCC68JvGLjGRgd90J8Dc4b8r3q7i8o/omgxRyIEFoSNrtXSWBsCaZ2O0RU6kVAJjok
	 TyJaOvFMyICUxtz8zkl2xzWSuDlJjEjamJTIDdNMjRTGMtLUD/jETgJ530/VAHLg60
	 wK6nfq91jaWlofvl/94mUp7gkMYXkc/vBMw/FCYr3yWVeY2qY/TI8i0KAethc8QfbT
	 UOeAhKHo5uEEw==
Message-ID: <sashiko-outbox-182026@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] perf test make: Add BPF skeleton build tests for
 clang and bpf-gcc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022204627.1813821-3-irogers@google.com>
References: <20261013231430.2163505-1-irogers@google.com>
 <20261022204627.1813821-1-irogers@google.com>
 <20261022204627.1813821-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:53:38 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add make_bpf_skel_clang (CLANG=3Dclang BPF_GCC=3D) and make_bpf_skel_bpf_=
gcc
> (BPF_GCC=3Dbpf-gcc CLANG=3D) targets to tools/perf/tests/make when the
> corresponding compiler and BPF skeleton dependencies are available on
> the host.
>=20
> Include tools/build/Makefile.feature and tools/scripts/utilities.mak in
> tools/perf/tests/make to reuse the existing feature checks
> (libelf, zlib, bpf, libopenssl, clang-bpf-co-re, libbfd-threadsafe, and
> llvm-perf) instead of open-coding compiler invocations.
>=20
> Verify with 'perf check -q feature bpf_skeletons' that BPF skeleton
> support is enabled for both targets and disabled (exit code 1) for
> make_no_bpf_skel.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022204627.1813=
821-1-irogers@google.com?part=3D2

