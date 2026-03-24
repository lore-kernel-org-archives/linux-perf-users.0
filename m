Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4202B3A168E
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Mar 2026 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774377525; cv=pass; b=M++NJeviPF7JJSMZWyXsu2GscA3AkdYqGYJDQoATkfe80MV17gNG8u0pjNuYLnSo2wXx+C0VaEic6Dl0NR6zrCKqeDgb2p69r83RGqNMYcScACMPPy1Gyj16FdCuljwupgcgQWVZVD9CzXt0d8ZnOscjNAikOSAySDSnmj6WZuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774377525; c=relaxed/simple;
	bh=6qkbfqE5//3q1tI2ovyno/YQhOFwgW1CrAHZ3oo7OPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oxfBnQDc84BlCLn2GnQPlFA0Rmxf27txH4AzKJNCbw8DvXIpEfEz/PtS5uLNs7IXE2aNG9wkb60j4XgluNFM++E2YORn3qe+U+wvDDSyuHDpdYx+rHmddwoLkM8HmuyFOtxcMR/ez2Xd92vjh5R8lj1fADdNUp9xd66S2Wh0A50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cEGJ+jQA; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cEGJ+jQA"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2aeab6ff148so13375ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Mar 2026 11:38:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774377524; cv=none;
        d=google.com; s=arc-20240605;
        b=B04dhkoCHj4EvOsSUdp8gm4bNwO/tQpXQK5n2FgRDKL7TyBRBT/K8pU475KiEtFK6+
         7lCaSVMvm5IL5VE+BKBaTKUQvgrjM30RlxfyLGRkTrBuoC+6ojNPI5HyItlV+buT37iz
         4zOtaWlCV7iCsKaM1lMBRPE7IdiyGDT9l244HCyx4bIs2FtM3yhvF4+6zdiZE1mB8cyk
         oEjUjzGK2pXUIiAr9JmnSd2r1+5KzYK1KM3zaYGYJYPY43BfWRQPvkg46vFPIK67O9r+
         xXubvBTTy8sX3FIunR2Q6KYV830fAt9TQpAKXLn5tgnUI0kEEo3AkjEKQKT5dqiZsc/h
         tEGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IEuzvgfQEmmZp9w8jdSxf+ZsUjXlK/t/bUgMJCQV4sU=;
        fh=6lXI2sNApR68Ct6NNeqf/ysdpjXJhoRSoQNsx49BWos=;
        b=Hb99Zp5Ve2XNUDNX3kRGRKlu9u9LLPvUGQBEOwS6vvBVHxjBAohMMMCEbxklF3i20D
         grNBiHhvMOQJ5JS+WZDReIMRMLovdaqsfYleqkAQWaExRClmr4yKffKsf6fjObVoyHL2
         /NSNBvgmc4ZtaGlb7avUq2Hoht1Fqijb3MYXMMe+3GqyxFAJMBBXCHG7vjBl872Bb17+
         YkJ4BdiOLrcRubrKlFV5MVrQ8/h9PLPImcmf7Z+iOfeD8Ts6yx0mFHLSpIf9h2BSD1+T
         vudRLgTl29DyiDcUfoaz+B/L1tDEjgIXNFahS1MZgeZKmhh2L2DlGObQJxMAvhQEwUjp
         T+Sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774377524; x=1774982324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEuzvgfQEmmZp9w8jdSxf+ZsUjXlK/t/bUgMJCQV4sU=;
        b=cEGJ+jQAvdrKrodavIsdSnaW1WbOpYAiMDyf0g7qjC8ntAAJt0P/7vI7waUgaO539o
         YATeUTkdLIoxfFB7H6PeW0KRf/P06YUV5cBU8ror9PhMoqioHHC2Rn1AMnWQ6juzCEqp
         nvE0kNhb8t6sJY9lHOtfTyEdrmDJXEB+xsz6ccdP2i91b6dp45gany9NOscwAHbnpB1h
         m2OzzhS0KGihpA5qDZ9DwxAO41wz9MKM3gM4GsQa7YgSFLvBwNEmNofX76XieiU2xHlJ
         //vy009llsQ1IRDbHXcnn00rYPdHFqLU++eKnusfM7XUZTKSsYEKWehkagLrRdepPXWp
         AspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774377524; x=1774982324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IEuzvgfQEmmZp9w8jdSxf+ZsUjXlK/t/bUgMJCQV4sU=;
        b=J+bs6joagbxx9bZqoh2bgjWBYGmNcqv2DxA5zKdRuRu+EAxus6gJfxcPXHOdL71Nh2
         oP8J0Y5zSvAsto0LS5NNe/h6DH/JyqmOSVdn+z2Evr6p71uiczPKQGUqPI2p6L9YWL6E
         5E8doeqF/8dyA5ZozzUbShoxVKEt1PLHkkcsB/5iZIDmFSYKVzYqOHgSrvuRhvWVBL+o
         3y2QUrf4LQ8rdB447v2gFdw3eT+8L15k89PYbgV8ySh5UlUGvTnxlZHjsUzm36Agi8aB
         RzdqrWm6P7HqBi4Nm5Y6JUrLYOjAPm7/+/N1aQAfHOrmr3lWYXPO3W8jSnk3xCn0bdNi
         llig==
X-Forwarded-Encrypted: i=1; AJvYcCVkTMTfyrJzM23IrWjY/R243NryLaZm1NAOH34Iqz/dntd53zNf2SonC9mw5W5wU7T4yvxtYE79T5Imu5a4D4ad@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk8QWigfdKlXXlGJaUTRHfQwwIbi2hc7HGnOsQCbBvBK4h7oqh
	9jQDfRsEgAxyEwxv6WVbMhktAzNsUWwvqn++qvSFF/h1CMQUnqA9vfJb4pzniT0ejrs/INLEnlk
	BTtdCHD61pDxzBkniNfpl2NFzaGxIejsn5cvlNdsQ
X-Gm-Gg: ATEYQzzF8yYWnQsJVuWoSzDsz2A6EsBTnb2rggcnze22UUBkoyrN9gg8AyxhUL8G0zU
	x15IJzrkxwUP58FSPCdB2Tz6WcYV8oLyyBOZf3rmqDLrQaaVBauUhFogR0nVWTJpdPGIJKP4Jyb
	o7m2DD9jSe8cIs1dOy7gme8wHkBMJS22dL8U3sPnCQ5GsIhmFCyteFfD7qtsbzSU7i4wVyT5XRN
	qXShrVy85U0grDuOttFnA8l5CvO3f4adFcEzlfi2pMOS7myDry2JZyXugn9XlDZTcArTXZAwHny
	B0deAL19OgqYaWfYXsyKSZp3brSFTQdREjKmlirszuqVc+po
X-Received: by 2002:a17:902:dac8:b0:2a8:ffed:4663 with SMTP id
 d9443c01a7336-2b0b15e46fbmr483285ad.12.1774377518192; Tue, 24 Mar 2026
 11:38:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fW3jcUyOOF5ikEUHbp8r=yMZE=iUPVesUhcba38T8ayZA@mail.gmail.com>
 <20260310033742.3606390-1-wangqing7171@gmail.com> <CAP-5=fXMuLx0Wy3w246tybuFrntam_ZQ9AmWh8gv=+-fxrawVw@mail.gmail.com>
In-Reply-To: <CAP-5=fXMuLx0Wy3w246tybuFrntam_ZQ9AmWh8gv=+-fxrawVw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 24 Mar 2026 11:38:25 -0700
X-Gm-Features: AaiRm52Q7jaj87aVb11A7RctSiF4N-hR8EgD_4yhxRPxiB05OvHOTUYr8sT-810
Message-ID: <CAP-5=fUJxmOLMW_TkZcpqT+bzicCd2kKnftCYwP23RdCACWR5Q@mail.gmail.com>
Subject: Re: [PATCH] perf: Fix deadlock in perf_mmap()
To: Qing Wang <wangqing7171@gmail.com>, yuhaocheng035@gmail.com, peterz@infradead.org
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org, 
	syzbot+196a82fd904572696b3c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 9:45=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Mon, Mar 9, 2026 at 8:37=E2=80=AFPM Qing Wang <wangqing7171@gmail.com>=
 wrote:
> >
> > On Tue, 10 Mar 2026 at 02:59, Ian Rogers <irogers@google.com> wrote:
> > > Hi Qing, thank you for looking into this. I proposed a similar fix:
> > > https://lore.kernel.org/lkml/CAP-5=3DfW-wHEv=3DTCULwk_HVOhWHdqRd8AZoE=
SZsU_vnhLjghUBQ@mail.gmail.com/
> > > but Haocheng noted it reintroduced the race condition the original fi=
x
> > > was targeting. Haocheng has a larger fix in:
> > > https://lore.kernel.org/lkml/20260306093616.84299-1-yuhaocheng035@gma=
il.com/
> > > that should handle both the original race condition and the deadlock.
> >
> > Oh, this fix is too large.
> >
> > > I wonder that fix may be made smaller by passing a parameter like
> > > "holds_event_mmap_mutex" to perf_mmap_close, something like:
> > > ```
> > > static void __perf_mmap_close(struct vm_area_struct *vma, struct
> > > perf_event *event, bool holds_event_mmap_lock)
> > > {
> > >    ... // code from original perf_mmap_close
> > >    if ((!holds_event_mmap_lock &&
> > > !refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
> > > ||
> > >        (holds_event_mmap_lock && !refcount_dec_and_test(&event->mmap_=
count)))
> > >      ...
> > >
> > > static void perf_mmap_close(struct vm_area_struct *vma)
> > > {
> > >        struct perf_event *event =3D vma->vm_file->private_data;
> > >        __perf_mmap_close(vma, event, /*holds_event_mmap_lock=3D*/fals=
e);
> > > }
> > >
> > > static void perf_mmap_close_locked(struct vm_area_struct *vma, struct
> > > perf_event *event)
> > > {
> > >        __perf_mmap_close(vma, event, /*holds_event_mmap_lock=3D*/true=
);
> > > }
> > > ```
> > >
> > > Thanks,
> > > Ian
> >
> > LGTM, your fix is better.
> >
> > But, can you explain why there is still race issue after applying my pa=
tch?
>
> Hi Qing,
>
> Haocheng has a complex explanation here:
> https://lore.kernel.org/lkml/CAAoXzSoYPvE-AdhT28Rhik2BtFhFuntaM6uhrMqKLUa=
DgkyiNg@mail.gmail.com/
> with the original cause, which I think stemmed from syzkaller fuzzing.
> I can follow the explanation there but I'm not familiar enough with
> the ring buffer code to know whether the race with open is benign or
> not. I'm guessing Peter Z thought not, hence the original patch
> landed.

I think no fix has landed yet and the original patch with the issue
has appeared in backports. Haocheng, did you want to see if you could
incorporate my feedback into your fix?

Thanks,
Ian

> Thanks,
> Ian
>
> > Thanks,
> > Qing
