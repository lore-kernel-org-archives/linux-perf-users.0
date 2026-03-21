Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544441D7E41
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 23:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774134512; cv=pass; b=TnMC/cp4aS5X4V3rVqWULjm16r4gIlOwped+Wx8JSp/QXteh3zRe08j/oRSjItqSDCvtqBOpeXdeLvgEHWmXxHEOMy69JU02+9NrF+woXdIG0TTjwZCsdocdUmHQ22lI89USb17OVcvlueinuQ6XbN8rawne0moxyNvBFaeNX/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774134512; c=relaxed/simple;
	bh=wY8joydHrVweqs3ydVoiOLXyf6nSrUpvPCnt16XcKGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qgaUElwFr3QrMrJXRBLWPW9JNpHSpmU8M7f3lnUV0tugcjnPlQt+JxTDR85afpABbCngj8eEdlwTo87z+FFXTimdopRXasWalxd/n6qRuXk2yRMRqzS9zz7t80LbxpTqbV4S+OWsQYq3pD2AeZvBuxMxxtBGZx8qAH+y5BdN5ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fs8WCnv/; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fs8WCnv/"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b45bb7548so2145464f8f.1
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 16:08:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774134510; cv=none;
        d=google.com; s=arc-20240605;
        b=NIRVuzVcdYTODjfWzXHsN9IGFsYZdDcgq5jFaHn93go+AoxtpMf/luKbZ1UIyN/GMc
         MtX3DU4BsREO5B3uNDsbghmHEfDp3f1ogkDJsLoloA8nk9Oy9wHRWj1eQid0H+6KzMNa
         rEJcoQCkROYqDIOpLoq3gmLJ3xI3HP0NsMXK8YzKufjfoo3jDWyZgsKAAEVAeqQaKV2V
         VB+/8WcfRJMPFKMWecfz86n4nQDhVR2IUn7rxC/j5Rb5HyQamtobfbCu7YOLQsn8aYOc
         O1P9xaYuDAWhUa6zTTcMFVWLWzf2YsedG24bgyC7dIHN5dnu8plhR0hYnl3uv3ZK2Ui3
         0tGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DTzWZEx2kpq/j4/EmeTJxrRzdEyN9FStqQMJ6aPQhfk=;
        fh=eEHahfOdWE+MP8x8EHyTzXhXq4rJ35vMUCSbgFX9qIA=;
        b=ZzQDLAaNWna8f85C7A3+hBO4mv4JfUxVYbllKH/RVnCaae0HIfvAWWfPDoG6ruWq1p
         WN17SnwOE/5MBWRK35l38PRQ6Unf4R6J6X4HSxBMBpJIYQGdgmRj5brRbnxQfteT9Tsk
         n/NDY0ThuEo+G8sjK0XZW/RiUuYR9Yn0t7jz3YGof93H5+sCCAGNTKpi3IEXY3Lj9VNR
         Us1suiQUMOQIKTPYz8KC5TXLM0UhjQNgPOK+ZTHFbCiy+oHy06gjwbhB4XbzKVXyy2TF
         VflrPSdMoMFk7zWtFw7NniY4EVme6i1aIwpD/WgHF8Y5tzDPNhrYp/sF8bsY+8mO6t2d
         C6sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774134510; x=1774739310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTzWZEx2kpq/j4/EmeTJxrRzdEyN9FStqQMJ6aPQhfk=;
        b=fs8WCnv/cZEGn7y7tadhdNr1n40WH7rpywbgt7+6W0eqUzENemMO6YpSu6cteoK4of
         n5CeLXOkYYSqWzwrkG99FK7W5MafyECNO6sfzxQbwgBnWc6OgESqLRRnpFqJUZ/ZclM+
         V7ITBtyesbhxycnR1jPSluRnqBQB96O1A0vJLhqh1+MZCiZX80sf7tigVhNNKGTYrJ+p
         hPB407rqPKqtwQHxneU5tiYVWd89/Vju5k/I/gRU/FrjxEUDhTBH18FQgclSuvtn5YJQ
         V4hJGDOqvZn6+ayQWNqj9zLKQWNq7SjenPdOl22byOuuuw9yBne79APfUZwVRQ6hjYlw
         Qpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774134510; x=1774739310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DTzWZEx2kpq/j4/EmeTJxrRzdEyN9FStqQMJ6aPQhfk=;
        b=Cj94eGRmk46b3iZvW7joU2A8r9O8C2Pu620PuuqtJ8VSL8QOPx7YWTH/uVrR4SvnJA
         95vaPW+cS6p+jr9bJh4SMmcD4AQQEQV0ZpKdqak8+e/xvKCV/1p72IUrgBc6D2+Dc/P2
         scw1Jvx6Hc2Yqi7bBwTXjn09VDyNQoaTwJrZMGxakQWv4t1Cj3YkAcbxCvSFVeRj1Ei5
         nkwDl9bVv2t7t+x3SsnJRSMl9+nBwyR5emc65GA685AcBCO5hOqc0oBvSHOl2rMeVsBL
         jMA/E8gHaYuzvfAlOV7Yg7K9tuMVIFVaLq6pTLRJRZupdFP0mItJ16Ag9skrC3jJRMZT
         nLpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe1TWwxcWTpHzB+egLs0TWtJ/AUp5Gbn/kYMlWCQWIZG43YUE4pcBfRUYGnBvn31JsaJrqGSaBdOtOtYMgUVGp@vger.kernel.org
X-Gm-Message-State: AOJu0YxgSq0e1Y9x8dN1smEEwh0XhANftlLBZYthW51zPHOU9Rid6iNc
	QrqXSGoOp5zP5W/JXgQTcqlhpYVxV3kf5V1qaKQ1l8OPw/n2P+uQT4aRpYhf2Hv6XNOqvWQ/BEH
	tYrPXgmwwS4+bPPT/4OU6PhbQgTTAZlE=
X-Gm-Gg: ATEYQzwQW2v1ETrUxe76ss/GepLrvId9MS0KLE97wQfrGRFIJCSNF2w/Tu0NqhaGDjl
	jaRz2FIIu4BFUjFCLmCrpKtCHYysCWZa7ccIUotqF1IegZmQDgtPwuHxFsFccPa/mdjGNxYJHpk
	h6rE7dEW6LDtvM5ORb5EN82R7YDl2e/UoKj8jv9TaTxAamvsm/bbnDiiqkK+VN7awaPg1JJxENZ
	9XLDD/UOeX6hP84j3BJJY04gv3amMnWjPDSvutzAMG0+8t1Ai0HLF3DV2c45xOZwoyxNGC8PKoV
	5GezCeJqYTv+MU0cAkVQRPPcfGzoM5sL7HD0K/jm9T4g9wIa96TvthewNumImbGTGquCTicRtA2
	cicpAUm5aqCGEDcGd42jSwMzYmpv23unWKGvZ
X-Received: by 2002:a5d:5f86:0:b0:43b:4921:8743 with SMTP id
 ffacd0b85a97d-43b6428168dmr11888566f8f.42.1774134509454; Sat, 21 Mar 2026
 16:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321024446.692008-1-irogers@google.com> <20d77c80-6538-4dec-804c-156402c26534@linux.dev>
 <CAP01T76kB8BHSQXp_1+tScrHhQayVm+BhAiDqnq4NeNOS_cMQg@mail.gmail.com>
 <CAADnVQLKv6LOQw5=8_ZagRXdU7dRPYA+fxJsXiGncqJjZ2hK1w@mail.gmail.com> <CAP-5=fXhuLE5R_t1A=+WLve3Wu9N999gXcG0KjEFGVBBh4+1=Q@mail.gmail.com>
In-Reply-To: <CAP-5=fXhuLE5R_t1A=+WLve3Wu9N999gXcG0KjEFGVBBh4+1=Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 21 Mar 2026 16:08:18 -0700
X-Gm-Features: AaiRm50YejLEeFdLghBznogBMbsouYJT2jK4XNYtxycz3X_8HKLbkyv9F9l35dk
Message-ID: <CAADnVQJNt0Xmcm0L7u87fX3xFeVGyLnTxUGjPsnYcNSX4Zv5rQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] libbpf: Fix strict aliasing violations in hashmap
To: Ian Rogers <irogers@google.com>
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

On Sat, Mar 21, 2026 at 4:05=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Sat, Mar 21, 2026 at 12:49=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sat, Mar 21, 2026 at 10:37=E2=80=AFAM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Sat, 21 Mar 2026 at 16:42, Yonghong Song <yonghong.song@linux.dev>=
 wrote:
> > > >
> > > >
> > > >
> > > > On 3/20/26 7:44 PM, Ian Rogers wrote:
> > > > > The hashmap implementation contained strict aliasing violations.
> > > > > Specifically, the hashmap_cast_ptr(p) macro was casting pointers =
(such
> > > > > as void **) to long *, and these were subsequently dereferenced i=
n
> > > > > functions like hashmap_insert(), hashmap_find(), and hashmap_dele=
te().
> > > > >
> > > > > C's strict aliasing rules (C11 6.5/7) prohibit accessing an objec=
t
> > > > > through an lvalue of an incompatible type. Dereferencing a long *=
 to
> > > > > write to a void * object is a violation, even if they share the s=
ame
> > > > > size, as they are not compatible types. This can lead to undefine=
d
> > > > > behavior, especially with aggressive compiler optimizations.
> > > >
> > > > Potentially this could be a concern. Did you actually find an issue
> > > > with it?
> > > >
> > > > The linux kernel build has
> > > >     KBUILD_CFLAGS +=3D -fno-strict-aliasing
> > > >
> > > > The libbpf does not have this flag. Maybe we should add '-fno-stric=
t-aliasing'
> > > > for libbpf as well? This way, we can avoid any future potential
> > > > 'strict aliasing' issues.
> > > >
> > > > Note that bpf program (tools/testing/selftests/bpf/Makefile)
> > > > also has '-fno-strict-alaising' flag.
> > > >
> > >
> > > The change itself looks correct to me, fwiw, but as Yonghong said, we
> > > can add -fno-strict-aliasing to CFLAGS and move on. I also doubt the
> > > compiler can cause issues here, since the usage happens in hashmap.c
> > > which wouldn't be visible in other CUs where the call is made and
> > > pointers are passed in (unless compilers also do aliasing-based opts
> > > during LTO). I guess libbpf maintainers can decide what they prefer.
> >
> > Agree. I don't think compilers can misoptimize things here.
> > It's safe to ignore this.
>
> There's LTO support in the Linux tree for tools/perf with the LTO=3D1
> option [1]. My experience is that it works best with clang and ldd.
> libbpf is statically built into perf by default.
>
> A sashiko review raised the issue when perf was reverting the addition
> of -fno-strict-aliasing, the sashiko review is posted to LKML here:
> https://lore.kernel.org/lkml/CAP-5=3DfVro6E6fowmmJ7gmKX-5SN8bFU7-5KJk_wFG=
-bQuVnMHw@mail.gmail.com/
>
> -fno-strict-aliasing was added because some crypto code (copied from
> the kernel) requires it for get/put_unaligned. The fix was to use
> memcpy in the unaligned functions, which they now do [2].
>
> I'd prefer not to hamstring the compiler with -fno-strict-aliasing, we
> have sanitizers that can capture aliasing issues.

We're not going to hack libbpf source or add -fno-strict-aliasing
to Makefile because gemini found a "bug".
