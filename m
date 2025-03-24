Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768F925E823
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742831450; cv=none; b=B6nrV4KkhNMKJwtHzMwow8N+H2sruIrFAfGKnZnUBHVnsrvoGj1rpD2EYhYcZ0EQ34I/0lXlegf+tOk5Dv74HuBCioqSGUg87ht8s6PEXXCn8Oij7ki2TlYHjvMhVCVcuPFXgqHTWRAj0OiGE+j6uFJR8kPyWtAWkGqQ+s23+TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742831450; c=relaxed/simple;
	bh=iC7dfpUdHfAvWLxMF1a4lZ6q0xl4Aagkf2KHFMc1yQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T2Hd/GShqraCJCtE8Rn5llaD/g4QthHTT2pfKC7sXKMhyXSBMu1ukuGUcg0w5B3LA4716o7sgoeEJZH2aO3KpAdXCFwxmybcuFxU8mbaj1E7zsOwfxgsNVtmeWsbBqUioW1oIsIdUDRLZFG5Kpr5lcyZlPE44wPaH6BnH6qfIn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rg5dx8Zw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rg5dx8Zw"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2242ac37caeso383365ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 08:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742831448; x=1743436248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvP8eWaYqIznmmYZkIkwVCH6qx4RfXMKSXMvsdyGlPc=;
        b=rg5dx8ZwvOpHWpDBltf3XmmCma5wVBVWmjd9EBG5OhhgnUJUexMaQ9NQ64fRC2VrW+
         vF6/M3e+G2k8quIdG32xPIXDxe7FFRLFVShWKuINTiJjbvIo5zwQWwEqkERHHZdS34RL
         hMZm/6zKYIP1dpXmQKI/qso4xxpD6IAeHo2lBrehFhdhQkEjq+ORUlpWJDgx/i9dyFCQ
         o0qTIo1LzPoD+qpu8FBt5gAdEqm8EDXVRg5pew6HQAXG5yxBpXiBLExyb8+AVNB/wvgI
         zzG8Sb4L/nv5rtmjr2V7GxHe0hUiuCboyntMfqJsIKSo7Rndyzdv7w7jtBn0zeM219TT
         9UaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742831448; x=1743436248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvP8eWaYqIznmmYZkIkwVCH6qx4RfXMKSXMvsdyGlPc=;
        b=fXrP0fj6KLOd2hvbL5QrL20gDeRwfrwV9nKAWpPxOR4DBdIgC3JAMdydK3t3OdHEod
         Fcqk8HUgvbsPbdogcwV+5ZQVFt/hXJU7c/Z66R/kJIlST1Grbm40TnjMIzjB+9j7JM9f
         y4vIAdYVG0Ykv7AqQ56UeAiraKRaDXMwr+3nDG0Kh5VyZsNe6GlxnRc7nnZ2gvooGz+s
         PF3vv+yd00Dp6ACJF8mPyHG5Yf7KMY7XLPW7TCCsNEssu3DhWP0oTpqTZU8IWBSvWsVr
         EVLke2nACvzHusRRRpXyBOFv10AgE9qhQtdPwENtpBKapbj32sjpVFsdtzK6oyco6aAP
         pwyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWKUWN2oZxdhgGfJB20UP5QHlqYw9BtcbT+S/gbrWRnAuUoh7F5krgfX1UXcB1NQv4nniTD3UzMtN8a53OTX/m@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9aeLpEEv2755OWMoFJHfjq7593iqV+KSwzLYP1qESkiL007ek
	/lYvsvVPzwX0LxxjgrgytkR4Qq9h20PDOBRxo35+CBi+w7vwbzYeXeES2Y3kmBpeF0kWgCh9R2z
	G4WFh17mCgwAMwwkOvXWf9mVHxjIovkksPKa3
X-Gm-Gg: ASbGncuLUGocnAnhCL6tOTDkO7U20WM+8HT0PJGUPysjdEmdX1D/uRE/Fgm2jMZsqMS
	OIWU1pU95ZskryKMKvh6RnM5/uldrhvG2MkPZ/i6jJK3qMZSdwwWNVCFzqUqnIPsNPlJ6/qYssF
	7VdLmnKIRCr3xqTXYadSs3s06Dsz99gLGMdbh52A2ZHiMr99ydjS231HV+GDI8GxOqKg==
X-Google-Smtp-Source: AGHT+IEkqLjkjkKV0BoryNLZCKYsJZuoARtK320e+r0SizuUym1WHCy1JsYihCnG35nWDbqzuoSwrGMxS3kMcOx8ipg=
X-Received: by 2002:a17:902:f707:b0:21f:40e8:6398 with SMTP id
 d9443c01a7336-22798319d4emr5412215ad.26.1742831447311; Mon, 24 Mar 2025
 08:50:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324152756.3879571-1-tmricht@linux.ibm.com> <CAP-5=fXPgoocDSRxzYpkzcLsPwKsp9b80b1KPDWv-obkmiX-fA@mail.gmail.com>
In-Reply-To: <CAP-5=fXPgoocDSRxzYpkzcLsPwKsp9b80b1KPDWv-obkmiX-fA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 24 Mar 2025 08:50:36 -0700
X-Gm-Features: AQ5f1JoLnJ6gBw7l0R3pxQ2BDt_h9unn7xjMEHDp0sSAorOpWJxUv0zpcHKd3tU
Message-ID: <CAP-5=fU+9EQKT2fOuBQ5ds6s4Bh6rWrvco1ow6B-CQ92XuO1kQ@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Fix wrong size to bpf_map__update_elem call
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	james.clark@linaro.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 8:38=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Mar 24, 2025 at 8:28=E2=80=AFAM Thomas Richter <tmricht@linux.ibm=
.com> wrote:
> >
> > In linux-next
> > commit c760174401f6 ("perf cpumap: Reduce cpu size from int to int16_t"=
)
> > causes the perf tests 100 126 to fail on s390:
> >
> > Output before:
> >  # ./perf test 100
> >  100: perf trace BTF general tests         : FAILED!
> >  #
> >
> > The root cause is the change from int to int16_t for the
> > cpu maps. The size of the CPU key value pair changes from
> > four bytes to two bytes. However a two byte key size is
> > not supported for bpf_map__update_elem().
>
> Nice catch!
>
> > Note: validate_map_op() in libbpf.c emits warning
> >  libbpf: map '__augmented_syscalls__': \
> >          unexpected key size 2 provided, expected 4
> > when key size is set to int16_t.
>
> Wow, weird.

Ah, I guess it is a mismatch with the declaration in
tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c?h=3Dperf-tools=
-next#n31
```
/* bpf-output associated map */
struct __augmented_syscalls__ {
       __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
       __type(key, int);
       __type(value, __u32);
       __uint(max_entries, MAX_CPUS);
} __augmented_syscalls__ SEC(".maps");
```
but this looks wrong. The values are file descriptors, so should be
ints. I think it should be:
```
struct __augmented_syscalls__ {
       __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
       __type(key, int16_t);
       __type(value, int);
       __uint(max_entries, MAX_CPUS);
} __augmented_syscalls__ SEC(".maps");
```
I'm not sure if max_entries can be a uint16_t too. I suspect this may
well interfere with BPF_MAP_TYPE_PERF_EVENT_ARRAY and its use by
bpf_perf_event_output. Probably best to keep things in the BPF code as
they are and do your builtin-trace.c fix. Perhaps someone else can
clean this up.

Thanks,
Ian

> > Therefore change to variable size back to 4 bytes for
> > invocation of bpf_map__update_elem().
> >
> > Output after:
> >  # ./perf test 100
> >  100: perf trace BTF general tests         : Ok
> >  #
> >
> > Fixes: c760174401f6 ("perf cpumap: Reduce cpu size from int to int16_t"=
)
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: James Clark <james.clark@linaro.org>
> > ---
> >  tools/perf/builtin-trace.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 092c5f6404ba..464c97a11852 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -4375,10 +4375,12 @@ static int trace__run(struct trace *trace, int =
argc, const char **argv)
> >                  * CPU the bpf-output event's file descriptor.
> >                  */
> >                 perf_cpu_map__for_each_cpu(cpu, i, trace->syscalls.even=
ts.bpf_output->core.cpus) {
> > +                       int mycpu =3D cpu.cpu;
> > +
> >                         bpf_map__update_elem(trace->skel->maps.__augmen=
ted_syscalls__,
> > -                                       &cpu.cpu, sizeof(int),
> > +                                       &mycpu, sizeof(int),
>
> nit: It is usually preferred to do "sizeof(mycpu)" to avoid the
> problems like the one this fix is fixing. And I'm blamed for the bad
> code in:
> 5e6da6be3082 perf trace: Migrate BPF augmentation to use a skeleton
>
> Reviewed-by: Ian Rogers <irogers@google.com>
>
> Thanks for the fixes!
> Ian
>
> >                                         xyarray__entry(trace->syscalls.=
events.bpf_output->core.fd,
> > -                                                      cpu.cpu, 0),
> > +                                                      mycpu, 0),
> >                                         sizeof(__u32), BPF_ANY);
> >                 }
> >         }
> > --
> > 2.48.1
> >
