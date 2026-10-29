Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.160.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793298232;
	b=sN4k3wPJFo/TzHGVgOc2r00CPsFnQ9YGQRh14RoEX8gHo+jKg3uAQs3JUUpyWUTxmPSV
	 xFkj8w0kdfMNHien6VMpzKaNpg2Ep49UBhl1QfEcQVSiCKnP+vrHva//IJJEF8U61sQc0
	 X2HmOGVeoEDcoY9LiyEE/ASgH7VNNp/lYGWz7ek9UWRK5jH8yn6V8m4FMjuzKoINylFuD
	 NUxKGy8uppoliejRrl+7Hfn67XF2RI4IXxb7v6HfkHX6e4hFzv0IF2TNiSV4iUqpWvE2N
	 zsQVY99qBePT7epL4CyaZl6lgauD7jFYU0kF9xfw/OQtIZSV4PCODI7jFlkZZZiWdHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793298232;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0kPogFiW6B5fuv9DVpnabZaqR2Qn/IyW3R9/wzN8wTc=;
	b=4hRjV4/Wz53wTlufXcF0m4C3srjgufcxrmPrjuH62jhAveXodp2bnFuw15trUYonsEel
	 oh3DZJ03GjdSyqLLPuA8POlfcS3emz0mWw+15hDwT/S7X5ToTCw5UsYX7blIH54+85xZ+
	 RpH/TxEJod07ia475yPbx/3tsBbZ6VtC2nSA2g3219iTV2bNp0QKo26DXW9uM9dwZycbo
	 Z2v6dpV2MtAVVwDfBLrihXSdv3mkFf0ajwE3Qlgf+ybn+1baBVWsdIpmaZb7wGFXllcO7
	 hnLwMiDGORnm3aMaXzC2W4lvXZLz9VOOnm3grn0G2Eco+Nz3bfziaxo1nBKLJjpygCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DxY9NYue;
	arc=fail smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709B5606A31F
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 18:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 709B5606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DxY9NYue
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-535f598d126so29621cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 11:23:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793298231; cv=none;
        d=google.com; s=arc-20260327;
        b=ZfKEN4Sng3wyc/99fXdeRHeVf2pw9s3zKPvmK90kyDktU/qSp4zfNSjCmTga1mMwQL
         9EMN9bQg2xdnZuwTiAKEEct23Ik4POIuU0f6PnvR5jqheu3SqFIAOZ54z9XOJ81MLC3h
         bhJcQJ0xUFUfgDf2hMrYKw/3ZjnC+GO+bZ+MT8LuD1lTloqha2k+2GKkzUjeSlXWvKso
         pt4Zepdc3xzEIzFXwgZJOGMpnPvmO2CxkMN1vH4HCB+Ssl+8MZ+c7NsGc6qhY+KahkXk
         fdNL4d4A45HFtjtdXrofgezGS0xUQr/0FciTkx7EtngZJbN4+GCcdA+yMbfkZPb9yboJ
         X/2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0kPogFiW6B5fuv9DVpnabZaqR2Qn/IyW3R9/wzN8wTc=;
        fh=y7Wh2uU/iyUNRymKBF8/SMO1OweO5+NWjjGwq4Uq6YM=;
        b=O6Epy3jlmWlEQ6Y9eMSRyktbExjTmezJ6XEYouj9QllVy9CaI5JvFE6M0XopaFPDsJ
         2fPpgxT3voIJeNPwmnm1fmflRI52vCwXG55u33B6bUuKprp1Ps5Qf/xXchijtrrbP4Br
         5plsgDXqVGmu11YZQZTT6SlUXIdBxfdJPYRA6cyiAlmn0rZFXsG2tAq/mtDSIf8NgCc/
         QpSPGiZrr9c8SexhBk1CMQCcy9tEC6AOlMUclMO9YcK7gXLagGbJaEgW+C9grKTc4d2B
         NNFbFovqm+/P84F3JQ/TnpmUnhYRxgsoY4RNtyLafaAajIyySJuCb/l1EcNWdPiWX8V0
         2G2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793298231; x=1793903031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0kPogFiW6B5fuv9DVpnabZaqR2Qn/IyW3R9/wzN8wTc=;
        b=DxY9NYueYpPUw54/1LuKABfDp60AROnzubbbXy7OzS6fWMrILGyAPx+k/TBUzTDoQf
         0+estVcf3DGr+NqskgZltpKjiTwBj0vHxfiZlAv1hdCBqEV+qUGB+fKraqRqaZGJI9Ad
         aHuqa1XDAyOvsrzYt4e2fwVCkmevUnXplUQksj+fp6M1ZkXl+zkUCRvmoFsMOA3v0kwz
         Qz991YYvpNKWfDlgqHmAUX1bJTSVeq5mbReuEAT3YssNt+yd0jN+OmcLTEbZqe3twO31
         DfUU2J0jeNSxbzemGGGlU75TQqjY6sTlc87Wxa++VyWhSCCSHud20YoCA1co6FakOgHn
         lsdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793298231; x=1793903031;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0kPogFiW6B5fuv9DVpnabZaqR2Qn/IyW3R9/wzN8wTc=;
        b=BTJG20yUHNP4PfJqo5E7eQugXlAYC0iYai7vJQfJ+UQHryJImIYHg6W1anq1zLjINS
         bsToovr27IUwpE+am+kHDWmiqyM2a/yNRfGRCHd8VFgl8vI0Ay7T/Q7s3rDvNDFck5pY
         PIZhnpm0E2SiFdI25dW1c6V+6i2V95EiW6adx9MP9wGfCPcesumgTQZ7pX0su3yZEfYZ
         gCmmprqwW8bINoJst84WvSIbA9LRwgmqm1jWZmJLRK/rop7cQSETiFTPay1KWPnK+2Fi
         NWNCFeWjLEc46rs4TMFnNiX9kDyrt6DXS5TgOvi+RhbK4CO8OMenid9i5KArfrlRBtRA
         40CA==
X-Forwarded-Encrypted: i=1; AKwUvBxPprYXS9Uh8PKfgw5aJelHapzBJq+GDFmuBUhVmAN8s836/jb5+yM64m3R75mMOm2x12Tfk1NNba7SjoQ5A6p/@vger.kernel.org
X-Gm-Message-State: AFq9FYIKUFyG2mSDdKu1pl+l7CuEV/WN/Z8lu+/or6pvXXUN0ccreGMu
	I/d6djoC0RVPmM960mwuYVrJObOsY9zwc5H9ZZ2VysBfyEaGPaDR8x1HD4lyHh/mt5u9S0OmG+F
	U2D6L4srlkM5m2ke6DM78COy5mPriE3NZ1zEKRD0k
X-Gm-Gg: AYBFou1gRr/ih+oZ8n/7oBHNr8Ae56CWMGMkVucTvkcdIW+YWEyKqs/lZW+ehpSiBzl
	ssTxxAct1tHw52eQba//YeXnSV5gOqMwGuDWVJK2FUbsGw/bY5CMlRQ3k1kpGTEDYmAzxYqN6+M
	VSS5e6piQrm/cHwWlJm7a5qZ4FszbCqc6//2OYB4Kt1JAb8eo/2pmxUPG0z5C7nqzv4WfsB24+K
	A9nd8JjHCcIqTrLHgcmHG51D/qkwVH5fUV5K3WXTTt/EGqdpVzQAHJ0ddvEAKh/t8ZvqSpPSlCR
	laDAT22UYsBL7MXCCE97YspqVA4VPJqtSgGKwMh5PjCO5xFtXfE2sIFvEaLpOyAquVxsjopZ0i5
	S8R6wkfJ3MYYtoXKhxIc0Ss6p2wu2Wd1Lml5dv9xStBacYl21zziTvuuvrn4djCye5g==
X-Received: by 2002:a05:622a:2b45:b0:532:eff8:3491 with SMTP id
 d75a77b69052e-5414ebdf590mr23748491cf.14.1793298230692; Thu, 29 Oct 2026
 11:23:50 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029162958.3224280-1-irogers@google.com> <CANiq72nrhqK0NP5q8_G=936++gZR3=zrES+cK96T95-ThVTpbg@mail.gmail.com>
In-Reply-To: <CANiq72nrhqK0NP5q8_G=936++gZR3=zrES+cK96T95-ThVTpbg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 29 Oct 2026 11:23:39 -0700
X-Gm-Features: AclHuK8I2R6ZBL0M8gpXX54gY1Y2jQq5EjXVV3xSH1Vs5_u0FZ2MTRQeP10WsJs
Message-ID: <CAP-5=fU8K4as51_Vi2vKAC-kGMVEFn1LDjCg1WvP8R0Y=8SbcQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/3] tools: Add Rust library build infrastructure
 and prefer zlib-rs
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 10:32=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Oct 29, 2026 at 5:30=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > 1. **tools build: Add Rust library build infrastructure and zlib-rs fea=
ture test**:
> >    - Adds `tools/build/Makefile.rust` with helpers to locate Cargo crat=
e
> >      sources in distro (`/usr/share/cargo/registry`) or local Cargo
> >      registries (`CARGO_HOME` / `~/.cargo`), map `.rlib` prerequisites =
to
>
> When we were discussing whether to vendor crates for the normal build
> or whether to fetch them locally from the registry a couple years ago,
> we discussed approaches like this one, i.e. picking a version from the
> registry by folder name etc.
>
> But that doesn't work too well. For instance, the graph of
> dependencies may change, there may be several versions available (and
> the highest may not be the proper one to pick), there may be different
> major versions available (i.e. not backwards compatible), they may
> change the build scripts, etc. Even picking the highest major wouldn't
> always be correct, from what I recall.
>
> I also asked a few distributions how they felt about it, and they
> indeed said that it wasn't a great idea without querying properly the
> registry.
>
> So one should really ask Cargo for the right information about the
> local registry (i.e. offline). It has been a while, so Cargo (or maybe
> `pkg-config` or whatever) may have better support for querying it
> nowadays too -- I would suggest checking that first (e.g. `cargo
> metadata`).
>
> I think depending on Cargo for this, especially nowadays and for
> `tools/`, should be fine (we were considering even back then and for
> the normal build).
>
> By the way, checking Cargo's cache sounds very strange to me: that
> means the version that gets picked is even more "uncontrolled".
>
> I hope that helps!
>
> [ In the end, for normal kernel crates, we decided to vendor for other
> reasons, e.g. we wanted to pin the versions, to customize sometimes,
> and most importantly to avoid any possible user misconfiguration that
> could lead to a subtly incorrect kernel. But for `tools/` it makes way
> more sense, of course. ]

Hi Miguel,

This is great feedback, and it's why I thought this was an RFC series,
rather than a full blown series intended for immediate merging. I
think the other obvious point of contention is preferring zlib-rs over
zlib. I'll incorporate your feedback into v2 along with addressing the
large amount of feedback Sashiko has given, which may become
irrelevant if we trust in Cargo more.

Thanks,
Ian

> Cheers,
> Miguel
