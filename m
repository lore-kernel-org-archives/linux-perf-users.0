Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794348633;
	b=gCVSrsfBxOS+r0IK4Q58VOVaQEaLzSNBBt0WHWtbHRHDRTxxEBx7B8AH75tDScQn0rrC
	 vkWzirvP7oC0Ywir4TJYGVucigsSHRyce4A9DRfinw1+ILZrGwWQUZg8g+LxPbtyp/M6l
	 7SEquLdnB86b5tOAHe7h4nIPaiUuQ1LhG825l4AqLjagwVcKxWXidm7Qe2tb3i1jmaVZJ
	 BWpReGvu1BEK8w7kZQL4U7HY8MD9T2tpTNKtGfu6fKgVDujGgulxf8cveEKT6/hLpfr7X
	 uTy7VHEoCk+G+ylIV09O93bEbiZRv+B/KKtMmHX5cArTxvcMrB3c+2pP7dAJ8sc5dOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348633;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=23Pxla0x0VyCOsnAcGwpllmJRatGxCqJdHyvmPf4tJA=;
	b=pE45teKr+QakqCADaKdaHhEZmM9zWVyEbjx3ug5yu0auWJBrwZVd7iClcIBsMyxAHqCN
	 iIRQaEuhEuIUcMCTZ2ol9g+HlzrJR9bTbkxiBsuYD4D3wPl/WGoSDy9mjHdHLrS8e4hXv
	 au3EJlJORtDMAvVFaE9/oeKhyL0T3wHaYb/41Q3GfIc4Cd/GqktU2BrRPwvUh2ig8s4oq
	 iOrtPyE9O7Hprth75TOoNMHy5Qx3R9KbJCw2KsE9l4fuH9dEoek5Rmjh86Yv1dHWtTql+
	 vfLYw0Uc/m67Hj8OlUHmSfpoJFuWEVyDE0tUXx67c9NChyXRsaGUZrhKZYkQKVHnm6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EGvKviX9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABCD606D511
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ABCD606D511
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EGvKviX9
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-533202fe429so35311cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 14:10:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794348632; cv=none;
        d=google.com; s=arc-20260327;
        b=Pq/8JkcEEhD00Q09kKols3zIcqKONg1PAcqrRlq43Mt3QCE3opKqr4qQZLDJR24G0I
         BxWny6ImbticTp3R/0ftxxNUhOB31MSydtwcbcbCHATXbw86qiQyQ3lYHAZP4yIaqcgk
         Yg+IZTv9TD/36Qocbs9udloEGVuQ+ftG4ZpVKCjD7bphWgWj1quppRrc7ywFzk4WMbrl
         jdZJy8XowJG+tBx1mMQy1ptUwoNPHU8pOuJbt7fgCHgOHUcPzTxGk6e/cxMhae97yKYF
         FKwlZ0Py9Q6kBz7XbjlT+Wsf9BSKfQHtqfpzNR1ydVZKMqNoI0VqkqnT4aWyp85aQJc/
         1brg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=23Pxla0x0VyCOsnAcGwpllmJRatGxCqJdHyvmPf4tJA=;
        fh=VqZ7fiMz5hELIMKhgZSjaohNyKb6kgEEJbRrrsm4x10=;
        b=WOdzRMcZGpaQuyM3tbhTVu8iXkMtNZXuCu9L+P7XmpAhTSv1BbDosVErp1EcGm+qYF
         Uyq+RqNoUxlkzEnztL1d3PRe5PIjcwQPllzbvhBhdx1J/eDjSH30mdjotLmbw6WoGAa5
         9pvqYDzC1Yxz6MQg6HOSK1D+87JC29JD2Ka/fqUC5EJ4f8DLO38YqX8jSUlsoUSUY6qE
         eTMyp0kPxPS61uygp8XnZ2wNw2Hg2zI2NmOtiwFN/iSrekBr15bOwGeaUZ3Oi6R3YEk9
         vp6fhjb13mzVWKfWEYzWckGUfX8w088QT7kCcPd2WR2dVPH/4NqsLHDfc3a8nry3D5q+
         05oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794348632; x=1794953432; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=23Pxla0x0VyCOsnAcGwpllmJRatGxCqJdHyvmPf4tJA=;
        b=EGvKviX9LR/v1fV8uIa6Cdte1WjlOLXl9MLPt0Lmyy+ssas7SbxStEHIGx0I4EX6aN
         RIHuPG/YUvqe/k1xPplN0u5qLzkiCyHFAudkbqU1mn2drnz+x0dKfoI9NWvPHzan7Eqo
         Im5b+dtb+Z4YxYEhya1ymLQGa34yCzMMb7D0WyajYIaImNZlE9ChBAuWALt4oGDCD3Ac
         tR5DwPD0bF4ZD5wLE+r7SUATCjUjXUTWIm10N3bJZ/pvP2/7hcqoRR/I4gWbFH6nzFTG
         aU/bk4VspZTg0fXWRhtdxFnNBL4oePXkVQfJFLxuYP9Q+5OYUh9fctNHpl9O9RF5l44R
         BBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794348632; x=1794953432;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=23Pxla0x0VyCOsnAcGwpllmJRatGxCqJdHyvmPf4tJA=;
        b=u0HY1PrHldOMGoaquwIOcZDI3PLg90kA9l0b8JEfL1mMTeYkB+zwlM/k20xqvDDD+t
         m5D/dsIB4lsJ9b011AWc2WMxiWCclzKsw+n1vY4sNhwnjykeHm48ss0U2/XvJyaxxdCy
         xasH2aFnTbrLVAuk1+n6Jt0eUAXTQaz1xhvpgygWMWoQ9QpK7NkZKybg2LzBlmhYX2LC
         WDt/irhWdkud4SYPYagsqk8J+RouCcHUP09iSULlDPPaRzm/4/eMd70TKhkCGXjDu4xH
         w7AFmDqRrPSqzGLJLo8iG2QWYpZn+x5uBjlAN0Nztb0+eupfK2F8uKOaHQGiiExHTlFT
         Coaw==
X-Forwarded-Encrypted: i=1; AL+hErGzsgNkqN0RrmvsDSKHNN8rv04jHCoASMHZKt8AfwBKA+EpCYTi7o3BxhvQdz6A2p+rmmI08WMzLFAFFPHqoMug@vger.kernel.org
X-Gm-Message-State: APuU4Z/rkjRPGH8MIx+rlnKiDYTdyPr4NwlVamwoaQlfYpyHa2n79llX
	H4Qd0CBOfxyz7e3dH6mKqH1CjCgOPIgkmdlZKxC4DAIpQKmC7C9ll7bKFRbgX/7ygz5M3W2MfbG
	k0UJIGuKqIg5OQKRpB02ZOgOog+9mY5qVJU0ZecLq
X-Gm-Gg: AYBFou05qf6DlxGvyGPzcyFjDYPEf+kiglynCM374Rz+/+AJFu24PNVH68HKeyVMKP8
	JEASSUOHuG68+hXUfTLb/bmO02Xr4pLfNQOdZWFYCuAHniSpAYCP44/0E8vNbLFUn/dIJaNkowo
	5XIWBI+rE04mXvb/4b1ngeioMeXc5X3ymJdhIFeNO+lB8BGKh1tKHXPHenAdaTLsV+nz0eKKCYp
	GdBgGhmmXGS4uBMHBnjR8t7wsTYjHhTQWn2zZmC1P1buthEHLJ/2J9N/zp+TSBqtfvKAaNjgPhF
	cDC95LVOZ7hax7Vz5evHOjWrdNkA+8bK+fqyWIb6T2/jpnYBR6mkClhQNwv7IeMvR229EoGUGzx
	uzXxt3+Ly26zmBaUjUStWQWGvCtxRB2+/1TyX73E/j941zsabRu2CymtYXvrl4gt3Tx8=
X-Received: by 2002:a05:622a:488d:b0:536:78de:775f with SMTP id
 d75a77b69052e-556c399f89cmr1771181cf.15.1794348631513; Tue, 10 Nov 2026
 14:10:31 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261013231430.2163505-1-irogers@google.com> <20261022204627.1813821-1-irogers@google.com>
 <CAP-5=fXh4VD5bimc-pEezOJXLRX-pYHOzx9j=sFo0VRiPgsmsQ@mail.gmail.com>
In-Reply-To: <CAP-5=fXh4VD5bimc-pEezOJXLRX-pYHOzx9j=sFo0VRiPgsmsQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 10 Nov 2026 14:10:19 -0800
X-Gm-Features: AclHuK8wEnQfk_-sHOPur9fgjbLia7lKpNE_SXlhvIz0_WDZZ0WArK0Fic1f-50
Message-ID: <CAP-5=fWjYyr3dfkrUYxp0y=_NpNOiimWGvxTy0W6Gx+Xx1t_yg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] perf build: Support building BPF skeletons with bpf-gcc
To: irogers@google.com, acme@kernel.org, cupertino.miranda@oracle.com, 
	jose.marchesi@oracle.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, andrii@kernel.org, eddyz87@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 7:52=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Thu, Oct 22, 2026 at 1:46=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Currently the perf build requires clang (>=3D 12.0.1) to compile BPF
> > skeleton programs (.bpf.c -> .bpf.o). bpf-gcc (>=3D 14.0.0) also suppor=
ts
> > BPF CO-RE and BTF generation and is already supported in
> > tools/testing/selftests/bpf/Makefile.
> >
> > This series updates the perf build to support both clang and bpf-gcc:
> > - Patch 1 updates Makefile.config, Makefile.perf, and bpf_skel.mak to
> >   prefer bpf-gcc when building perf with GCC (CC_NO_CLANG=3D1) and clan=
g
> >   when building with Clang/LLVM (CC_NO_CLANG=3D0), while respecting
> >   explicit BPF_GCC=3D... or CLANG=3D... command-line overrides and fall=
ing
> >   back to whichever compiler is available.
> > - Patch 2 adds make_bpf_skel_clang and make_bpf_skel_bpf_gcc build-test
> >   targets to tools/perf/tests/make, reuses tools/build/Makefile.feature
> >   for feature detection, and verifies with
> >   'perf check -q feature bpf_skeletons' that BPF skeleton support is
> >   enabled (or disabled for make_no_bpf_skel) as expected.
> >
> > v3: Reuse tools/build/Makefile.feature and tools/scripts/utilities.mak
> >     in tools/perf/tests/make rather than open-coding compiler feature
> >     probes, and explicitly check for exit code 1 from 'perf check' in
> >     make_no_bpf_skel so crashes are not masked by shell negation.
> > v2: Pass only -dumpfullversion when querying BPF_GCC_VERSION, guard
> >     against an empty version string, and fix version-ge3 / version-lt3
> >     in tools/scripts/utilities.mak so empty or <3-component version
> >     strings do not shift awk fields and evaluate as false in version-lt=
3.
> >
> > Ian Rogers (2):
> >   perf build: Support building BPF skeletons with bpf-gcc
> >   perf test make: Add BPF skeleton build tests for clang and bpf-gcc
>
> Ping. Just to note that the 2 patches are clean with Sashiko:
> https://sashiko.dev/#/patchset/20261022204627.1813821-1-irogers%40google.=
com

Ping.

Thanks,
Ian

> >  tools/perf/Makefile.config     | 83 +++++++++++++++++++++++++++-------
> >  tools/perf/Makefile.perf       |  8 +++-
> >  tools/perf/bpf_skel.mak        | 36 ++++++++++-----
> >  tools/perf/tests/make          | 71 ++++++++++++++++++++++------
> >  tools/scripts/Makefile.include |  1 +
> >  tools/scripts/utilities.mak    |  4 +-
> >  6 files changed, 159 insertions(+), 44 deletions(-)
> >
> > --
> > 2.56.0.307.g5fe7bd680c-goog
> >
