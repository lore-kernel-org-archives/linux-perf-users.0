Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FE02DF13F
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 23:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774134642; cv=pass; b=ty4wtJJ0SA7NhbRU4RgaJv7RQASMsP6WgajZORpa7MA3JOzT8UUfdFe3G7VvPj/RmgFOF5+N4ob0dDUHH/TNUWmI6osyyJPCixjOD3mvOkYriZwZO89bNmkJA9UcPQDtskXwT1LLd3/WJNSfhtfUpL3xqtOEN4DivdysdbAdMyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774134642; c=relaxed/simple;
	bh=DKhBnYuFq7B+Ka2fMjz8uQe4g1obMrfJOQUL6QN6XG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pj99pPVvWxvg/5ZwUJJf7zpaqKsDAEbRQpJG6OIMijkjiE60QH9vDaBaDfXP7dyXB56pomKom4EYvZs1lljl1zps/SNpZopFOXhZMmmqoETwWMP4KZfTeQsp43MPuOx4iQdDgs37luUR7OBjdqyJnNcDJDXCxJus2OUyzFi7mv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MYfgPIas; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MYfgPIas"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aeab6ff148so80245ad.1
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 16:10:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774134641; cv=none;
        d=google.com; s=arc-20240605;
        b=g1MLqfLC5fz1+w+8I4O1djS2v2Ob6ZWtiNzmt+PrBy46QBDG0UpMZTJWbWfDPCC4e3
         XTEzW5MCLsjsQKBDmikWIVZuuqQrphFmpt8LOt0WgwERVhJPfH9g4r+zliNJg7Wt+iK5
         olRxBMxtR/UG0cd3XtKtbppgVtzLSk+OogGmIz5OaGuK1d+SEsd5/FCGXei8L/eYzmee
         E6mc6b080CksLwlNnaKMqYqZityEs74GXZ95JKSTF5rlutiyOgzDNGiTSjLSHFhl7K7+
         V9O8e5PugC1RH7XKJXhgCtd7uaocCQvEsbjDiEXgQxoX4IOWQGPOg3y3xgJvND87BMsF
         +pjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gskRpbF7e3HZE20lexLZJJLsX9C51g5JYA8B2ClPVts=;
        fh=JTmq2GMfBH/oF1kTnbaHosOFLVUwOGih7vk7Fm+bOG0=;
        b=QkDQVk4A9MNa/w3QnuWY7Q5mQ6cyAGGOL4KWK9oMAfW1P/1MARnJMZBJ5nkvjzsIlP
         M+7gBC2Kn82jxqfz5HT/mUFFokDX8AW4eUGIzcxBT5i4gdro7bcMWaGpp9Kv9++WVgFG
         8waOE0mhmoZOVGWs58wmGPjMlBGBOb0gr/0ESswmivNU+lVIheqxBM5NqtBEephsLaIe
         rzbngYYhl8AFO28mpYLkzoczxrwwlpky2JvBZ4/9mA50FmFvpewkpKdbfnUucLN7RhJT
         z+AbKHRbVcPp9VCIdICXL6Tbg6bjAKN6dt4UexFtM3KzqwyFaZGre59Ywkse6DzaCHo4
         qkXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774134641; x=1774739441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gskRpbF7e3HZE20lexLZJJLsX9C51g5JYA8B2ClPVts=;
        b=MYfgPIascI1phgtGwZG98lanVj51czVbubvnoiQ7JpDg5qlcYhw1h7HiTVOSCAt02a
         0CpGwD+AyltGAUB1ycpGwm7KmchyDdC7tFe/oZFO4nOGahVxYQAvcqFLdxjpsU7my/JO
         GmkI+aJTaZhByORflSgYuX7UH9756XF3g+lEadGixKWP7h+APXrx73Dc+mjEdYQcvbtE
         dXjuLJzqAU26dPoFJFVJaolUbMJiX8+8DS1JhvTkbRft05vjn/gPNz4Ib6lY8KibeyoP
         vJCbPLuyp3nay+iGoZ6eLZ0C8pAT+yxWwxWS4AcZPIBWJm56FniCb4GEBWEfw/OFnaJD
         zySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774134641; x=1774739441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gskRpbF7e3HZE20lexLZJJLsX9C51g5JYA8B2ClPVts=;
        b=h7IxWhRCewIzHoEeyhHzGcCcku0lNRXX9tWI9oyHEPyaL5CfIKI1HKE01kEE1bKQ8V
         OZzL90aQaLCWH9u8tqiZmiBYpewHaNQj+QCUCSuZJYhMqToFu0qvSdTjO4It+yg4Hkxn
         l3O5A1ghFNgNnF8LUxSWy9ve8viY/F+QUn2GPZECbd6pA1fBQldF/dVbd7K2FwaElsFV
         K7ZgJra3uFOHh9vOmZhvsupODFDv0fHsBimDK8dXO9Z6iH4z3Tdte+B3d5S3wTApwiPP
         hNsmqKnKs5OADdjzG0sasgYMyheiQS7zhqrtVd9njLDoun1EH1za1VgbZMQ2SGfAyGSp
         amCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjKx5GMtx8cegiNxbpcApDQuq9oi1vlGP11bFK3bxKuQQ/3QGYWvjbWAyLpweelgSOOIiSuAWveep7fHpReDQs@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd0/mjFtAN902TozAQ6A5AGrzRig8L5NgaWj0usypgtgLb4Gpx
	CZ2Y8qJLEGyPxelqITRzaeM0e5ZgUI++JuIHD8RqPuqKhgCqLV3VUgjjn1NBwPtUw6t5/GiVxyI
	uJWjbNb80hjKO2+ahn7ronKKNsNf3KRCwSZKNEQup
X-Gm-Gg: ATEYQzx6VHyRBVPJUxBpf+6rKsKCEyvqPLKDpYj+K5mwKp3cTRcKbgB4zlN2urW81E3
	osZD/21A2ZEH7BMxQnFg18pWN5xvzv0CcHoXqMfz3F73GIaCVGtrN6IRNIb/2WaCWH3cOK/BscR
	46E0EHNlZylOD+hHIaOrGd0yWJZN1b6VcdHvnBZFsaTco70c5Fy7EPe319NHk6nQfU2VMBfTIUJ
	8ffj3JrSITKdzn7HuWAAfTWKy8ATmdGCQYnIST7d+bCYJrQVg2aOAtbSP+I+3qW3QkNI1U1nUIK
	qasRkdkv
X-Received: by 2002:a17:903:17cc:b0:2a7:87c2:fcde with SMTP id
 d9443c01a7336-2b08c4e8ebbmr1788085ad.15.1774134640638; Sat, 21 Mar 2026
 16:10:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321024446.692008-1-irogers@google.com> <20d77c80-6538-4dec-804c-156402c26534@linux.dev>
 <CAP01T76kB8BHSQXp_1+tScrHhQayVm+BhAiDqnq4NeNOS_cMQg@mail.gmail.com>
 <CAADnVQLKv6LOQw5=8_ZagRXdU7dRPYA+fxJsXiGncqJjZ2hK1w@mail.gmail.com>
 <CAP-5=fXhuLE5R_t1A=+WLve3Wu9N999gXcG0KjEFGVBBh4+1=Q@mail.gmail.com> <CAADnVQJNt0Xmcm0L7u87fX3xFeVGyLnTxUGjPsnYcNSX4Zv5rQ@mail.gmail.com>
In-Reply-To: <CAADnVQJNt0Xmcm0L7u87fX3xFeVGyLnTxUGjPsnYcNSX4Zv5rQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 21 Mar 2026 16:10:29 -0700
X-Gm-Features: AaiRm52CSCEKDzXzsvi00SkOJjBGfxApqGPpCOtGJuq_kvVV8r02qX7BNyoTiF4
Message-ID: <CAP-5=fUsaORbZuCtUxFgzMT-Cn2jVDLYfcYGSkXC7TdtyfnatQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] libbpf: Fix strict aliasing violations in hashmap
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 4:08=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Mar 21, 2026 at 4:05=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Sat, Mar 21, 2026 at 12:49=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Sat, Mar 21, 2026 at 10:37=E2=80=AFAM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > > On Sat, 21 Mar 2026 at 16:42, Yonghong Song <yonghong.song@linux.de=
v> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 3/20/26 7:44 PM, Ian Rogers wrote:
> > > > > > The hashmap implementation contained strict aliasing violations=
.
> > > > > > Specifically, the hashmap_cast_ptr(p) macro was casting pointer=
s (such
> > > > > > as void **) to long *, and these were subsequently dereferenced=
 in
> > > > > > functions like hashmap_insert(), hashmap_find(), and hashmap_de=
lete().
> > > > > >
> > > > > > C's strict aliasing rules (C11 6.5/7) prohibit accessing an obj=
ect
> > > > > > through an lvalue of an incompatible type. Dereferencing a long=
 * to
> > > > > > write to a void * object is a violation, even if they share the=
 same
> > > > > > size, as they are not compatible types. This can lead to undefi=
ned
> > > > > > behavior, especially with aggressive compiler optimizations.
> > > > >
> > > > > Potentially this could be a concern. Did you actually find an iss=
ue
> > > > > with it?
> > > > >
> > > > > The linux kernel build has
> > > > >     KBUILD_CFLAGS +=3D -fno-strict-aliasing
> > > > >
> > > > > The libbpf does not have this flag. Maybe we should add '-fno-str=
ict-aliasing'
> > > > > for libbpf as well? This way, we can avoid any future potential
> > > > > 'strict aliasing' issues.
> > > > >
> > > > > Note that bpf program (tools/testing/selftests/bpf/Makefile)
> > > > > also has '-fno-strict-alaising' flag.
> > > > >
> > > >
> > > > The change itself looks correct to me, fwiw, but as Yonghong said, =
we
> > > > can add -fno-strict-aliasing to CFLAGS and move on. I also doubt th=
e
> > > > compiler can cause issues here, since the usage happens in hashmap.=
c
> > > > which wouldn't be visible in other CUs where the call is made and
> > > > pointers are passed in (unless compilers also do aliasing-based opt=
s
> > > > during LTO). I guess libbpf maintainers can decide what they prefer=
.
> > >
> > > Agree. I don't think compilers can misoptimize things here.
> > > It's safe to ignore this.
> >
> > There's LTO support in the Linux tree for tools/perf with the LTO=3D1
> > option [1]. My experience is that it works best with clang and ldd.
> > libbpf is statically built into perf by default.
> >
> > A sashiko review raised the issue when perf was reverting the addition
> > of -fno-strict-aliasing, the sashiko review is posted to LKML here:
> > https://lore.kernel.org/lkml/CAP-5=3DfVro6E6fowmmJ7gmKX-5SN8bFU7-5KJk_w=
FG-bQuVnMHw@mail.gmail.com/
> >
> > -fno-strict-aliasing was added because some crypto code (copied from
> > the kernel) requires it for get/put_unaligned. The fix was to use
> > memcpy in the unaligned functions, which they now do [2].
> >
> > I'd prefer not to hamstring the compiler with -fno-strict-aliasing, we
> > have sanitizers that can capture aliasing issues.
>
> We're not going to hack libbpf source or add -fno-strict-aliasing
> to Makefile because gemini found a "bug".

No worries, I think the best approach is to fork the hashmap copy in
tools/perf/util and apply the fixes there.

Thanks for being as useful as ever,
Ian
