Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793764348;
	b=EKCAoRHuq7JFAA3BcUyeLK8FKZKReHzn8dM+b0lsNthAaM7tVe70qvTt5bYntmyPXeLo
	 wYJI8oTPLta6fAvdbpYD8K9tdDUdHmKJKItlHj/IOlIY8rwrDQ5E7V9qoSqNn7KhoiV+E
	 xiXb1xWM0QgDNrz7rPPhWQ+ojAyrJF6hXAgbz4xcFfq1fzpqP/IkB7wlMlxcs9kfU1RTH
	 6GgchrZlKMpUh5bJ2nc+nFpRvgEAjv8bGKKfgP9Zr5oQRH3rhOXOE/iuqtW7LjCL/p/8d
	 RrZsc8wDKJDL6YaMBypstm3tLsb9nZjO5EK9iKL4kRL3NgyCOxRbOI76M6Jkn6HAAPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793764348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/g2fOuDzTYwvHEhcFkEd8PhDWXPMHGDTGEwN2Grkr/A=;
	b=2o5aoMTt8F5cvAhVMpRu1CCl5nqDgnv4LE3qdKxO12xOiEXGMZaTdnzg46jsz5gwFtGK
	 QLI7Mp4iTHi/Eh9OMXzv8ZSgNxcTDy6w3RLXaoSqe/5bQ4QHuHrZNyaDz2CX4m/TL78Mi
	 E7rKYVtX+DHtK/jao1xc/6qZHtBdBKrSGjfYdzO+yLZDslf0t+k28fpc3oEnq4N9LaIa5
	 Bar8l+DXBvkY4Uox1ljyDSVfKjDa633d0woR/+Vn0fxDF6aQ0Tvm/ZP8MSrpLk8B2Uj6J
	 7KmL6v5ij0/MEq2yiWFVQMVV2yUjq5phQ/oGTjhtRI9pBR9XSgB31LB8NAdnCGQImgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eafGwUUQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A21A606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 03:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A21A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eafGwUUQ
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-535f598d126so98701cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 19:52:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793764346; cv=none;
        d=google.com; s=arc-20260327;
        b=ZTEvK6TH+CCgc7viAz7p3f8GFvGAolvW1JU4DaZ0RMPnGYwps1CAax9O7YAXsfwVDi
         ImNYruuDBxRllwWN9Ml1Pb75OdRtGdTHhKO4xfarYzP1+zI3i9bIBHoY6f6AMkkg2z/N
         lNnvWp70g9kE8Vsb8GtG5OlmKzXwLp3mDfR4hAhrYE87JM20K844CMCevpHndNdJeVDl
         b7mFu646McdHN1rhNPsfhUk/Jlbly6zr6+CTXL9hhv+EUk/hOWaezjNJfzJL7vNIWIsX
         QSl3a0kLfMgx96ANrtduEdR2us3WPAh3Miq1283KCIBHllkFjvSyos6/OT6U6uh3YiX2
         H3Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/g2fOuDzTYwvHEhcFkEd8PhDWXPMHGDTGEwN2Grkr/A=;
        fh=C8NJcvggtKD5TfrtuMAAiLCj/WN3tEWBClwPPBIGiEo=;
        b=QbSY5NJK1vNXeKjqnEMMmOeD0zeJB7TeRc0I4jdFeA+YjqCsRmCRRuRK1e0PHKWsX5
         B/YDbizK13W+zik/lz3667d4c0E3fnC1fetko83njd9tlN7gYXhFNGJAcf3vH+YFPQC4
         52WzqaMrwQB+PJoqJZz7Kue4PANNW20WISdgvemh5aa0l5wifn/V40Gr7oq2FigPnddG
         VFPg73vHR0vN8mHQM/lijyVb5wxETYTjsO7ec4I3C2nEo7jpz6AetAZLi/HtAreM7z/I
         lSJKcT3fYTY6nHR1cdU7DEzkENr0OBCFQykEjNJ4ydB6zoWD+0ATZMtCsBhwShTc8P/D
         yZ4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793764346; x=1794369146; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/g2fOuDzTYwvHEhcFkEd8PhDWXPMHGDTGEwN2Grkr/A=;
        b=eafGwUUQrFhEpLkjWbnoV1L0W756BjRTAxnbCJIHH6B5QpOy7wizi7SLRV1ggPRlVe
         FmoWLWWlePArboThc03i0s25BRjZUVIMGvRIh0hufaxqbZbZzHZjiXuRpnA36R7MtXxW
         /k6233OeiDqADpAJrYrjyqvMyuhq28pvKwW9U4l+ywg5YhCze45Lb2DQC65sOzB6AkkM
         1wB3ZxKztom9FztBL5DfDCemrJwNRTAIRF/CdiAZJxZtANbVLCDN0I/mMuHuyEUtY6jF
         Bi8G3K5ykli/dwkIxVsARiRcWFL21oZ4g08dbs0nXwBLlcdbujs/tFDm5AOds52Zvh1/
         REEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793764346; x=1794369146;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/g2fOuDzTYwvHEhcFkEd8PhDWXPMHGDTGEwN2Grkr/A=;
        b=X0KebdcVoaLkYYmVAp2Dc5RrQcvBQKRkM3AIve+NT2gLboYkXbScasfB2Xq8mJy4ma
         KnG/f2dfWJbozg0qs1JlPA56Xq01OMQNAQsahZloq/c2OxPQ+xFX7JpCagduiS7iRj0g
         9vGNcJ1gWFzrtwUYDSY4+hhnWu5iurRkeghTGlR+d5BbUVzX3cNOOVtLDAxHNz1mDUnN
         5RdFFyarOLTYlvv3698Gjv8pJTQoehqFsiD2bF7GJHstieX62jVR/+YKParYOGmT1RqB
         ALeg5pgpghS+F92p6FxudFkljlYnF9Bj1GS+Qvb4k0wzjbLfBQFskjrU7zbB8+Xij3Fp
         pekQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJG/ObpqnvsdO8PCJZpN1EbmPmPTfvYGsNAX2iJZDvg7zzX/qkyCvdR8iPRYmC2lRKN21svYlHAwmtprSoDzoa@vger.kernel.org
X-Gm-Message-State: APuU4Z9dd4B4jo1eam0jOvaEE6ecE68FsraweXUjJaSS65fb+Jt5qV21
	EPRdec4SJ/I3B8yx2zfBboA5fPXEizvMIDCT0QkPgX6Totxm8A3A/aZVCPtX/ilnlNaNFM94Ggc
	7r1W6PgvkzebXDqy/LsXIeS9Z0NIIjA7ZwgBGU8dA
X-Gm-Gg: AYBFou16pYVLNRuMb8Y2lx8kzGSWr0tnSxPT/Y1wxXEyT5Fh5M/J+eaDYj0q99474/N
	YpoC1VWumeWhfk5p3ArvnaRAYRvJeSrX3IF5hSWbVRCJ0LUIS+ka82DbIrnXPIAQlhr1n9mmSoM
	rceLGAhrot9v3ojpcGFD+Eu/kodDyDjR/ciXBJgajtWxBVD43jnwUGeSnDajRdXSGR6TvdSNq4u
	EQmM9CuGB5xS2jy82vzT2OQtt/2siLL+vZL2EnCXO1IPInKfkbQM4aM2jhLfpMERJuTTI+RhL6y
	IsOmBmK/0EnbpQ5ozCDbTXlwq9EkBnQ10y14AbVbTQOubCVjDLh1nOHu9JlkEOAlq5pxN7Q18Yv
	THP5Kbm3Gs9COS+GO1McmqYlO9jrxWeiBtIlfYg==
X-Received: by 2002:a05:622a:618b:b0:536:3d22:fb83 with SMTP id
 d75a77b69052e-54b869b4baamr3521871cf.13.1793764345554; Tue, 03 Nov 2026
 19:52:25 -0800 (PST)
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
In-Reply-To: <20261022204627.1813821-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 3 Nov 2026 19:52:13 -0800
X-Gm-Features: AclHuK8hlH9H6wxsJLQi9dS0KEfV63lJxJUbaBWyywfSEr5o0bpezg-oHDXNyWc
Message-ID: <CAP-5=fXh4VD5bimc-pEezOJXLRX-pYHOzx9j=sFo0VRiPgsmsQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] perf build: Support building BPF skeletons with bpf-gcc
To: irogers@google.com, acme@kernel.org, cupertino.miranda@oracle.com, 
	jose.marchesi@oracle.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, andrii@kernel.org, eddyz87@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 1:46=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Currently the perf build requires clang (>=3D 12.0.1) to compile BPF
> skeleton programs (.bpf.c -> .bpf.o). bpf-gcc (>=3D 14.0.0) also supports
> BPF CO-RE and BTF generation and is already supported in
> tools/testing/selftests/bpf/Makefile.
>
> This series updates the perf build to support both clang and bpf-gcc:
> - Patch 1 updates Makefile.config, Makefile.perf, and bpf_skel.mak to
>   prefer bpf-gcc when building perf with GCC (CC_NO_CLANG=3D1) and clang
>   when building with Clang/LLVM (CC_NO_CLANG=3D0), while respecting
>   explicit BPF_GCC=3D... or CLANG=3D... command-line overrides and fallin=
g
>   back to whichever compiler is available.
> - Patch 2 adds make_bpf_skel_clang and make_bpf_skel_bpf_gcc build-test
>   targets to tools/perf/tests/make, reuses tools/build/Makefile.feature
>   for feature detection, and verifies with
>   'perf check -q feature bpf_skeletons' that BPF skeleton support is
>   enabled (or disabled for make_no_bpf_skel) as expected.
>
> v3: Reuse tools/build/Makefile.feature and tools/scripts/utilities.mak
>     in tools/perf/tests/make rather than open-coding compiler feature
>     probes, and explicitly check for exit code 1 from 'perf check' in
>     make_no_bpf_skel so crashes are not masked by shell negation.
> v2: Pass only -dumpfullversion when querying BPF_GCC_VERSION, guard
>     against an empty version string, and fix version-ge3 / version-lt3
>     in tools/scripts/utilities.mak so empty or <3-component version
>     strings do not shift awk fields and evaluate as false in version-lt3.
>
> Ian Rogers (2):
>   perf build: Support building BPF skeletons with bpf-gcc
>   perf test make: Add BPF skeleton build tests for clang and bpf-gcc

Ping. Just to note that the 2 patches are clean with Sashiko:
https://sashiko.dev/#/patchset/20261022204627.1813821-1-irogers%40google.co=
m

Thanks,
Ian

>  tools/perf/Makefile.config     | 83 +++++++++++++++++++++++++++-------
>  tools/perf/Makefile.perf       |  8 +++-
>  tools/perf/bpf_skel.mak        | 36 ++++++++++-----
>  tools/perf/tests/make          | 71 ++++++++++++++++++++++------
>  tools/scripts/Makefile.include |  1 +
>  tools/scripts/utilities.mak    |  4 +-
>  6 files changed, 159 insertions(+), 44 deletions(-)
>
> --
> 2.56.0.307.g5fe7bd680c-goog
>
