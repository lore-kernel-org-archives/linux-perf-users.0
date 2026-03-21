Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03992877C3
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 23:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774134312; cv=pass; b=hPrVr5+LV7MHsyBuZNVZq+BoCrhSDH1k9suKhv07gSIYS9jui4N+0ckmU0bRY0cnHKMfW7zVucTWBZIV3h7FOQvYIYtXSoCd8TcPrVwAx6fwMicroQzRiDFZ41At4QBoE1K4xOOsfRxdIsWfTFEMZimrNvg3dHjUEwWHqrBBg8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774134312; c=relaxed/simple;
	bh=UwRWY8WlifEVB4rrea8H3F15CcDnFu3ImTqOUY9A174=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YnwojTlVOneP5VZgRXrbWmSoDjSnOErSp1xFYDcsE7kwWxmu62Flv7FBJM40wzfVnK/4KXAbP+fsFT9+e8fvI7Qy4+t1CdXyxQUhmZ4u6QNUYeGehkThguf7bCI6tZE7zYafcHRQjlUDvlQsokLUjzQ1OgPvNu5fBRJ1dDou1yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CmjlahDr; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CmjlahDr"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so89535ad.0
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 16:05:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774134309; cv=none;
        d=google.com; s=arc-20240605;
        b=DbVH8odGxFreWmlS7A2mvnCzKcniRUJIy5jBgwXy1KVtjhmmzz6C6F1qg5gYchGXfs
         x8iOxaDEikytzF9POl3Eg33nppIK8VNqiFOZ9WQDeFK5UtgmQOU1gRI3E8XBNJtQsW/a
         D/H5XjDnQkUXICo2olmNmEvC+0omPbseKBRCxNnCCEYQ6PTv/VpOshzchXg1RgbfWcYR
         5LeHcNlRswPPThKxF4RDN9T723fiTEQ+giFbn1NmAUuPztq/F6oypXVHH/hVrgZ+YIrj
         cdwGwFinpoWdb5TG+NqOuY9Huz2QBPD7Hiyx7bbOswbWnOIOpHRHu7/EnqL+10e+q63t
         XSKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pvXWNOEW/i6yBRC1SF4eHSDHKNtrEtqOBOAA5J40AbQ=;
        fh=4DwMn5iG1y/63Vo8SpanwfEvfVW9Z4GcuWcXjM8A7J0=;
        b=a9wIvRZMJQNJEFQxs5EdkfCy2h6UvMPIpNw2yHwppv5Zi3vtNQaJ2QVw1F0cW2C5G6
         uVPe+IEW8xXxGTH6SxhtEcMeLtxmozmEAMSFiAaHHtveW6DJoBr7b+Map2NtuAWkInTN
         CGaIvgs1hB36KuedQhsLHGsMOfw1qftbv8e/jVVeH1E6QqTofl1OY/pUaSycnITbOTC6
         AENSPE399zrSp0rVYWgrzb3dVKNJkAeo769VAkZxcQy0MqFdSc9Y/h5ityadesRK8g23
         54mm0BiOCMshp1FPDo9WoEeN8QKFxbW+o+fD6joD77JxBJ3X0XCziFA+tpq86Ach3Oyw
         4z6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774134309; x=1774739109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvXWNOEW/i6yBRC1SF4eHSDHKNtrEtqOBOAA5J40AbQ=;
        b=CmjlahDrCFsU3NOH9W2oiWTjrlRrRBirhNZ9b3wZsrNVSq0r+7ATDjc69IgLaGIWUK
         hTzlJk0rHc6THh0quw/ITeTZZqOAQ7zkft2PhMZ9jVul9F8TN7h/kBy/Ospa9HR6V43j
         pzifm3dx4m0l/d+WyS755bqVAoJZ8en1MlWt7JGp0H4RLTYH2cTt4UmrqfiHy7b69YRy
         ALZ9I26HPHS2SoF9xNaBwH1jrPyPbr32dGkYiWfCb9vwRA49L5IqXv4EBrw5LykU8Y33
         FGlX0C64CJeE5aGJOslrD94lFnCBPp+lllTJEORFODd8QsQg22X5C62cPUnviaYuS2tF
         +Ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774134309; x=1774739109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pvXWNOEW/i6yBRC1SF4eHSDHKNtrEtqOBOAA5J40AbQ=;
        b=G0lqXKpOeO26sLzYY+g75HZ/3BSsM2RCok33Eqp2i59I++Lfkl9SNuKl+O3cS5qIfA
         Jbn/6SXbHkkYopQ65Nl+X537PDuG9l91xxUSqrUgVFxqOlrpYlBQYsMksCdRHTVwThhQ
         ZBc6vApjoRqpL71Mg9KhCtoxGks+vJgjzfNo4NCBOGTjeiPU9l3ViCDNM39DKbCDnSzK
         Bj1qKJzNhBcz+nyVqsL9SVhDsDCZJh8cHiBuEj2186r+ZvUXB/TxKVjoYO5Fvwtk4jPn
         BDLQU+HUlV42piH01T6C80RQuk+CN5zRPzeJE39yqFyMkiDvHJ+buC6U8K8LjVoM64hJ
         VBgw==
X-Forwarded-Encrypted: i=1; AJvYcCXaExFh1X0b3Wx4i2Yx8BOhwgXRBlnHbw4XsK8uR4meNszhEY/eY63BdTLwFE2G3A4N0CoO1m/EdwEp3zLOomSt@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo/IHAiNPVDaZNMly/gUQj6UBUfSmt1lHIoYazUscu4KRXoMD0
	P6g6HASm/y86g+kAl1Cbxa8bmjUTHmGEv1i61DnpakgwGXkeiJ9nYRnIMfoj1RInnBhrg6KdP1i
	W5JR37IsU/wDxoWhnyFrGoDAlRUEBZxaj0wykUIWY
X-Gm-Gg: ATEYQzySVWH4smxk/4S57gOKjP8p4L5Uea1IZwJKRKLPxeGmE9hgzKJOnLE9CtfdEWF
	V4DHQaAtvB9e0v2Js/l7+K3NSS3EoSKOMtcLlNJfC/xA5dP2r5ilx2gnByvoBbGFJqZb3eD7zur
	w4nU/8ViLwY26AK+RJDH2OOcJaFbdeaWaBPdwzHYC70EEAzan6FrAGVzzEidntG3gw8+o5RFqm9
	RflbAhEHlvXpfJ9ZX2AWW58+chp6DmLEv2J1eij0dRtkLS75ZzK7zEKr0TtHBRsIOG4Yu8uExWI
	bKeA9IoD
X-Received: by 2002:a17:903:1a27:b0:2ae:575b:2345 with SMTP id
 d9443c01a7336-2b08c4990f3mr1638895ad.9.1774134308521; Sat, 21 Mar 2026
 16:05:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321024446.692008-1-irogers@google.com> <20d77c80-6538-4dec-804c-156402c26534@linux.dev>
 <CAP01T76kB8BHSQXp_1+tScrHhQayVm+BhAiDqnq4NeNOS_cMQg@mail.gmail.com> <CAADnVQLKv6LOQw5=8_ZagRXdU7dRPYA+fxJsXiGncqJjZ2hK1w@mail.gmail.com>
In-Reply-To: <CAADnVQLKv6LOQw5=8_ZagRXdU7dRPYA+fxJsXiGncqJjZ2hK1w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 21 Mar 2026 16:04:57 -0700
X-Gm-Features: AaiRm52gbnQBWVlIQ5v4tgMEcNJKjU4ML7pBfqsVkt1j7XPP2DScTpH8oTgsPvU
Message-ID: <CAP-5=fXhuLE5R_t1A=+WLve3Wu9N999gXcG0KjEFGVBBh4+1=Q@mail.gmail.com>
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

On Sat, Mar 21, 2026 at 12:49=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Mar 21, 2026 at 10:37=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Sat, 21 Mar 2026 at 16:42, Yonghong Song <yonghong.song@linux.dev> w=
rote:
> > >
> > >
> > >
> > > On 3/20/26 7:44 PM, Ian Rogers wrote:
> > > > The hashmap implementation contained strict aliasing violations.
> > > > Specifically, the hashmap_cast_ptr(p) macro was casting pointers (s=
uch
> > > > as void **) to long *, and these were subsequently dereferenced in
> > > > functions like hashmap_insert(), hashmap_find(), and hashmap_delete=
().
> > > >
> > > > C's strict aliasing rules (C11 6.5/7) prohibit accessing an object
> > > > through an lvalue of an incompatible type. Dereferencing a long * t=
o
> > > > write to a void * object is a violation, even if they share the sam=
e
> > > > size, as they are not compatible types. This can lead to undefined
> > > > behavior, especially with aggressive compiler optimizations.
> > >
> > > Potentially this could be a concern. Did you actually find an issue
> > > with it?
> > >
> > > The linux kernel build has
> > >     KBUILD_CFLAGS +=3D -fno-strict-aliasing
> > >
> > > The libbpf does not have this flag. Maybe we should add '-fno-strict-=
aliasing'
> > > for libbpf as well? This way, we can avoid any future potential
> > > 'strict aliasing' issues.
> > >
> > > Note that bpf program (tools/testing/selftests/bpf/Makefile)
> > > also has '-fno-strict-alaising' flag.
> > >
> >
> > The change itself looks correct to me, fwiw, but as Yonghong said, we
> > can add -fno-strict-aliasing to CFLAGS and move on. I also doubt the
> > compiler can cause issues here, since the usage happens in hashmap.c
> > which wouldn't be visible in other CUs where the call is made and
> > pointers are passed in (unless compilers also do aliasing-based opts
> > during LTO). I guess libbpf maintainers can decide what they prefer.
>
> Agree. I don't think compilers can misoptimize things here.
> It's safe to ignore this.

There's LTO support in the Linux tree for tools/perf with the LTO=3D1
option [1]. My experience is that it works best with clang and ldd.
libbpf is statically built into perf by default.

A sashiko review raised the issue when perf was reverting the addition
of -fno-strict-aliasing, the sashiko review is posted to LKML here:
https://lore.kernel.org/lkml/CAP-5=3DfVro6E6fowmmJ7gmKX-5SN8bFU7-5KJk_wFG-b=
QuVnMHw@mail.gmail.com/

-fno-strict-aliasing was added because some crypto code (copied from
the kernel) requires it for get/put_unaligned. The fix was to use
memcpy in the unaligned functions, which they now do [2].

I'd prefer not to hamstring the compiler with -fno-strict-aliasing, we
have sanitizers that can capture aliasing issues.

Thanks,
Ian

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/Makefile.config?h=3Dperf-tools-next#n279
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/include/vdso/unaligned.h


> pw-bot: cr
