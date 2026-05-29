Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4BB39184A
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076740; cv=pass; b=cbQBjCOd5tWK8HkC9sea5JUAp+33V2Pxq/szu9rqmAgbySj4+qxjqHUby66iCvZDzg1ixDuCICwXror8WffLwXt4a92Kwc1kWC/4uzehndffrqz2saLa/oY+KK50Ntc8yl+TWJuGDcpJh62quKYsoK/LWJAbhZC0XYz4coXJ4J0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076740; c=relaxed/simple;
	bh=fQswMPrU/Rn/WAapiKJ6CbEylbnL8bQEKzUreQSEJog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4tWW7OVMwNffHcX9g5XiBC99+lWrPVhvNxfqxPwEDWUwv9qjFAFyiVbTOVfbyqe58+w1hcY5S8tanVL20toKmX4yayfWlc6YcgC+v7ZoO9Po6wI3DAV9/8QUAd/xeZDPK+RbWBpG6bh0UwNEn2vyEjp0QCb9X8LWV0GTsrm5UE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ay01qsFD; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ay01qsFD"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bf2911f93cso805ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 10:45:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780076738; cv=none;
        d=google.com; s=arc-20240605;
        b=WLffeI7IQLtiSaXIc8DZYoBRJ3FvxxoImHdr+43GCTWKEWvOaDwLjOkMrDRZCa8uAm
         OkyimsT8eI+cZGCvTrVe5gnQphU1qR0rNu7c460xyrzgmBvIEGwgpd4DJINbNCoMKrfI
         HEnOnHkGgas8VBuI+8Wi6Dvh/kXjlALoXoAfYkJOPrdVY1WBd0IPd3LwxJ1C7LzlsTeA
         ldTjp2FCnWyYL6ZofP2Rdy2PY7kOiPIOAX7jfn4a43gxinWGeOvhxtmkq79JbIQwVQy7
         05bTXWtG9WYjNmybrMXkUeYkaz3f4CxJAD0LHylZfjU1R85haAwO13a+RRJOKtNhyp0g
         rg3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r+MpgGplHrYx6awYXebTwFhUJcPlo+AhzCegKXoq6tg=;
        fh=3VSC1fc2b8jul9U0kX1WLkJWP6Ia85/RSZGJgCh+MYo=;
        b=CBYBAL6i/9vbhMOTm6emfs6n/veVKq63VMw0af8yJsfOb7ncabpfg7uBXAqKU1j4d4
         mfX9V23E6FqluiT7PwWjlHmeNsSTx5TbEXn4B/ufbyBRAjJEZbiuKuwtfqHYcSmBx8VC
         2CG8IqO6bSns4gbVzZxsyFCFsS83VjkcYyPgMzsWgH8eCL4P/F/SliuqZnRVKZRUvbdf
         xTpCKcSAZVhlxAPHoWLrGMTTf299Pvn+g3J4cthcW4+BUgUaEkryE/Hd1u1KeUfjJwRd
         XphHFDwuc2925lPCmUYPFWcRY5ncrPnWJ7gT5NriSSjESYaeDBJsMbn+CjldK585neKm
         fGGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780076738; x=1780681538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+MpgGplHrYx6awYXebTwFhUJcPlo+AhzCegKXoq6tg=;
        b=Ay01qsFD0L2eFuFqb8u/g4XNHAnTDYNiuCQL2vDL3iOSl8rz7f8h9m286wcggezhqA
         2TfClJIh52h/uuGk79zNyf05WKQD1+Cirwrix4Dk/ayivsMS4WuyimCcMrqAG/j8Vxfr
         8BVmgL8+aooo2IHFPIK3zlKxFUuf0YXfZ4ajbe4vdrqfNbqB2SH+xa7a6sVGfIAWR5YV
         NxM1SQlcl/85hEqBRUPfjJgA4SHC1dInsvAOH6esS3/VFhEOVWvp0Q2UnBN4HT0dMLew
         s6RPJ41WoxSoiL4pS+0dx7T2eP7j2FOdD6NHqu28SRrlvyqYDxnxArk9XCc3C5fWgY4Z
         QGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780076738; x=1780681538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r+MpgGplHrYx6awYXebTwFhUJcPlo+AhzCegKXoq6tg=;
        b=iy6+qHxD7xooIJPglI45Kk19f8vW713Lbf1GZfuA0WxH+ql2N9QN5XWFrPHkd1A9bh
         mq7lMzp29kI7H0fPqpcP6Ku+Nk27+aQAX52YC1kSKuyiqvz1M2XAQ+AaNkmWJ3PJGIrf
         sHX2l8Y1ZdVDuI87RvqopbO1RV9qIWg8evLKenQTxijYHPlNFK3MH4eAA9zO7UjzTwzg
         raUU7BeTbestZ6SK7RXKyzDcFG1hObzaRSMrDIhIBSHviiQY55vZLIktCzKEkEMqqMle
         LvsQRyfoOxW8NUtTQYSxeEcOKdzHn9KI80wMbjDWkex3peed9ejRqh4MPH7Y0NGih2nJ
         IrTQ==
X-Forwarded-Encrypted: i=1; AFNElJ/UxpNHeH6Fg6x5nZHIsbIHUqbCUTD/fnwjFBc6yZ+XgSAUVjqy0BbcnRUfd3aVQWf6K+ssbxCrqJ82WnI4DIk7@vger.kernel.org
X-Gm-Message-State: AOJu0YxiKBh8MkOXGbM/tLQyQwooZyjo9rpcZf3Ma9iSxZgwZlmxIQWH
	oaW0HB9BoSNp+31ZOwaXO9VmD0VlvZmoTgSRhUzDkBs1Q0QnjqVyEdvqHWtiy1WSturhS4kthFf
	3qNEON/XKUTUgHSya+7mHrQlXPfOnbswRMkS4La+Lafnfk8gMIH3D4z+98qE=
X-Gm-Gg: Acq92OEf0s7iO2UYaXYNLURWTKSJ4DHhJx+ySzu2LJPLMXBdawAq+MvfVLrrZR0VX1j
	Saf9CfgSGlVizjLgCEXCbozyMNS/4l+JwrmS1Pi/sC7yompSVjd0fBYX7NFbfAPKZd5ZEhNXTwI
	MKY5nYeD5canwaZVdspjgNsNalLAsUjP0xFRkDrx3sx5Ty8LwlO3Y0IPZ6jz4FvwdUq8+FQRMCa
	veKfmZStbpaku20NdN0Gc+YoUBxYhBgFSXK/JCp07bjzqaQCI1djez35uVOYP18l4o9ZaibfJ+5
	nps+o39P5CL+UsUGvM6x4zHFGcVgWDfCfrs+ZVjj9/Gyo0M4xFu3x17tvgU=
X-Received: by 2002:a17:902:ebcd:b0:2bd:6dad:3dfb with SMTP id
 d9443c01a7336-2bfa9f0da37mr148655ad.25.1780076737154; Fri, 29 May 2026
 10:45:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529082451.591783-5-dapeng1.mi@linux.intel.com> <20260529112332.140E61F00893@smtp.kernel.org>
In-Reply-To: <20260529112332.140E61F00893@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 29 May 2026 10:45:25 -0700
X-Gm-Features: AVHnY4IvKd19TeYoJtgBEdRWldpmFvC1WDoPSHx7TM7k5DWVNsGaY7u2fT2RBuE
Message-ID: <CAP-5=fXrjHohqOkq+gnxT2DwKMZ=aiEh0rT4FH6bnXFP5hrnhw@mail.gmail.com>
Subject: Re: [Patch v8 4/5] perf regs: Enable dumping of SIMD registers
To: sashiko-reviews@lists.linux.dev
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 4:23=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> New issues:
> - [Low] Misleading post-increment of `idx` in `simd_regs_dump__printf` in=
ner loop.
>
> Pre-existing issues:
> - [High] Integer underflow in manual `sample_size` calculation in `perf_e=
vent__convert_sample_callchain` corrupts the event stream if registers are =
missing.
> --
>
> commit 7e4b22be95dca28326d1271ce91f25c99e231f74
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf regs: Enable dumping of SIMD registers
>
> This patch adds support for dumping SIMD registers using the new
> PERF_SAMPLE_REGS_ABI_SIMD ABI.
>
> > diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> > --- a/tools/perf/builtin-inject.c
> > +++ b/tools/perf/builtin-inject.c
> > @@ -457,8 +457,13 @@ static int perf_event__convert_sample_callchain(co=
nst struct perf_tool *tool,
> >       /* adjust sample size for stack and regs */
> >       sample_size -=3D sample->user_stack.size;
> >       sample_size -=3D (hweight64(evsel->core.attr.sample_regs_user) + =
1) * sizeof(u64);
>
> [Severity: High]
> This is a pre-existing issue, but does unconditionally subtracting the fu=
ll
> expected size of the register mask cause an integer underflow if the perf
> sample didn't capture user registers?
>
> If the sample didn't capture user registers (e.g., when sampling a kernel
> thread), the ABI is PERF_SAMPLE_REGS_ABI_NONE (0). It seems subtracting t=
he
> full mask size would underflow sample_size (a u32), resulting in a massiv=
e
> size being written to event_copy->header.size.
>
> Could this corrupt the event stream or cause out-of-bounds reads when
> perf_event__repipe_synth writes to the pipe?

So this should never happen, because if we don't sample the stack
pointer how are we going to unwind through memory? It may be worth
adding an assert with a comment to capture this though.

> > -     if (sample->user_regs && sample->user_regs->abi & PERF_SAMPLE_REG=
S_ABI_SIMD)
> > -             sample_size -=3D 4 * sizeof(u64); /* Reduce SIMD regs hea=
der size */
> > +     if (sample->user_regs && sample->user_regs->abi & PERF_SAMPLE_REG=
S_ABI_SIMD) {
> > +             sample_size -=3D 4 * sizeof(u64);
> > +             sample_size -=3D (sample->user_regs->nr_vectors *
> > +                             sample->user_regs->vector_qwords +
> > +                             sample->user_regs->nr_pred *
> > +                             sample->user_regs->pred_qwords) * sizeof(=
u64);
> > +     }
> >       sample_size +=3D (sample->callchain->nr + 1) * sizeof(u64);
>
> [ ... ]
>
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
>
> [ ... ]
>
> > +     for (i =3D 0; i < regs->nr_vectors; i++) {
> > +             for (j =3D 0; j < regs->vector_qwords; j++) {
> > +                     idx =3D i * regs->vector_qwords + j;
> > +                     if (regs->vector_qwords > 1) {
> > +                             printf(".... %3s[%d][%d] 0x%016" PRIx64 "=
\n",
> > +                                    name, i, j, regs->simd_data[idx++]=
);
>
> [Severity: Low]
> Is the post-increment of idx necessary here?
>
> Since idx is re-initialized at the start of each inner loop iteration
> (idx =3D i * regs->vector_qwords + j), the incremented value seems to be
> discarded on the next iteration.

Yeah, we can drop the dead "++" I think.

Thanks,
Ian

> > +                     } else {
> > +                             printf(".... %3s[%d] 0x%016" PRIx64 "\n",
> > +                                    name, i, regs->simd_data[idx++]);
> > +                     }
> > +             }
> > +     }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529082451.59=
1783-1-dapeng1.mi@linux.intel.com?part=3D4
>
