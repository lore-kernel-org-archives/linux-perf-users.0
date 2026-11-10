Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349416;
	b=QJVuN9F/ZdiFcnM/jtIQIl7q88eiuGeidn4X+NGLyFDtVvnKdPsmc/wCmsfd6p+rA6eZ
	 jnzsSDKTdjEOZZjj8vbYmiKaewz4zUXKh3WMRdNwbJ3GxeqCxs5m1TXrMSXnOwHzg2EV8
	 HAVXdHWBc50TVUuPS9loBjm8PHWSzr23QBSdOv3t9nNf3rU5YKQ5/8RYwgkWNq42kJQH6
	 E//6I0PntOP/1OTKGzNSHXTqa1HEh3QoKuR6FZ2n/t0I+Z43E+NHEJIrAlHtrF00iaMKT
	 m/gH7YXyPPmkiVnEvqLSnzobEQZxAEdFueJrW/oJLYR+c4h/wMEM3POL/ljXOwdDqKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349416;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IveUz8MhtTVNYskK0J4Zd2urfS4oEQ2T9uY8gl0ZTmY=;
	b=T4bNl+8k8SBe1FXPuzE17dIlIjmP9JlwVhF8iowgJ22FcnIir3TfTumydg6GB0zzaS0F
	 i6IOJTD3N/Cw+olS0OraitkH2dHCOSWSZ9cd2k5Vpf3c6646BvnypI/P1UK9N63H5mIzE
	 Lw21lRnQnpLL8UMbUJ6tBj27AqobmhNVMvJUMlkVOp9cuswu6wnwmGRqThOcCkGhuSBu2
	 69eSECz1zQZHDk63JFtgV+5b9IN5QVt24LSNgByjcdAxfti8wgzlgW7Xa1QlAZ+3ypYxb
	 IFYevu0GW3vOk42xGPFgru80FQ/XFXEzVZ4BTnWbvKM+3qBY+3wVUzn7XV4oI7bS/Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UC5AhGS2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FBD606A320
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UC5AhGS2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FB31F008A2;
	Tue, 10 Nov 2026 22:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794349415;
	bh=IveUz8MhtTVNYskK0J4Zd2urfS4oEQ2T9uY8gl0ZTmY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UC5AhGS27DFwxdyqUyc5AE+I3jDSsv2lYpZuyLV2rgFv9Iaa7u8cIMRLM6bMu3ST/
	 lFHCsdrDEaJAxH3eb9WxANQxys916eNgsIm7+98m6REqGQODfkkeXhW2R6T6Yb67nV
	 ztPGtvo0Q+pGBx6OpSZqRJlebsA2YKRcO0JAWOzC1jYXzJqY9AnYOQAA3JgNyMrko9
	 cwKt0+ftKz8KN8FbRxKq/ig256KvihzPMzajAjbQRwBvvEJdp+AjuOlHhk2mJ+aEhk
	 XhBfgdG/SwF7vT4bSwpVhO0L2ycBpHq3c1xbQQABixtVWRrvwe0hdyCsqLK5TQWr+s
	 7adauv4k/o4Iw==
Message-ID: <sashiko-outbox-207822@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/20] perf demangle: Add fast-path prefix checks for
 Rust and Java demanglers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261110220803.2503416-12-irogers@google.com>
References: <20261027231513.816148-1-irogers@google.com>
 <20261110220803.2503416-1-irogers@google.com>
 <20261110220803.2503416-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 22:23:34 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> During DSO symbol loading in dso__load_sym_internal(), dso__demangle_sym()
> is called for every ELF symbol. Both rust_demangle_demangle() and
> java_demangle_sym() previously performed string searches or buffer
> allocations before checking whether the symbol name could possibly be a
> mangled Rust or Java symbol, adding unnecessary overhead on plain C
> symbols.
>=20
> Add fast-path prefix checks in dso__demangle_sym() before calling
> rust_demangle_demangle() (using strstarts() for '_ZN', 'ZN', '__ZN',
> '_R', 'R', or '__R', keeping demangle-rust-v0.c unmodified relative to
> upstream rustc-demangle) and in java_demangle_sym() (requiring 'L', ';',
> '(', and ')') to reject non-Rust and non-Java symbol names immediately.
>=20
> Using 'perf bench internals symbols':
>=20
>   Before (perf binary):
>     Average DSO load + sort: 7.348 msec (+- 0.069 msec)
>   After (perf binary, -4.2%):
>     Average DSO load + sort: 7.041 msec (+- 0.051 msec)
>=20
>   Before (libLLVM.so.21.1):
>     Average DSO load + sort: 81.196 msec (+- 0.780 msec)
>   After (libLLVM.so.21.1, -3.2%):
>     Average DSO load + sort: 78.599 msec (+- 0.857 msec)
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110220803.2503=
416-1-irogers@google.com?part=3D11

