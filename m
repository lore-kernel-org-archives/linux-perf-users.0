Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD7F30F55E
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Jan 2026 13:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769780926; cv=pass; b=qRAgr+8ECL44cwNAVKo4e9iI7Ii5a5yo9CjsBN969p9IjCTKP644q1cnyS895ibAcJxlWXaxKIgZykDtkf5pSjfe9YAkDveqCO7dBZllAnsnxU429XNwdXJluiexbgMTxc3ImBlcSrlBm5u3iTieZxPdCZSBRbUfAJOvf6d+UJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769780926; c=relaxed/simple;
	bh=ROd4JvIi94xKwEf/x8CiLfaTb/Q0mMGzyJoU0t99LKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j3/kVohHFHn8peklzaW+SGervsuMNO6H4FuoGWc8bwQnbGDqt7kEPZ2hnZokLxDkmmOKn3mpyS9f8R6BEzYlTk27vSjiqEzmp8SKq61zwtjk/ZZpkz6PVtvLHi3BT5V4Ol7JCNzOA0frDjL9/Huh8NfWHIYg2O7bskt64eV2x+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=TC3WCDPg; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="TC3WCDPg"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-352f00d0e83so1025164a91.2
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jan 2026 05:48:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769780921; cv=none;
        d=google.com; s=arc-20240605;
        b=aC5cRRptR0Zur7hBh0dErbyQlDxzTE1DpU5IKkV3PByqndzCpwyCstfDfpmetRt/OR
         TyD9fh88W719RdKZ5mOjfJDqbPQQUdK8zoqJUGf/nk9+WYeZLyH1cdkdNhh+QCwm8xCZ
         KGu/bbyQDRX1EXA2dY9tguQwA74GUqA0eky+xjVjoJVXW9bhrHMplNseJB9urHx6a4zu
         Ji2o/nrIW9sq7dQvB27KIjWx5qGpFp/yY+1O/cma/bXYTKKhmdcbGpSN5iSbww4Td4Hk
         SfM+RVJ3C96O4vzDCbIvyodA45DhtX7YEmLM0Cip4YgVndjSHooh51zUYy0hUPJMoijc
         7T7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cJE2HGNayNXuJcYfTf/Dlr7rMPC4aRqGvmLDgSYtmJA=;
        fh=Vxus6aaFzgMV3fbiEViRSaDu70K2jAleV+enq4UX0oo=;
        b=ZoWooxixYbLi0Sfau3PYb8k5ya8NGDqTD6JwkpE2t4sb3x57eKKwsxkdst67myqTVF
         QMKN48PIx94WxQ1OUbDmupxMz0vwR4imFeRU51KIqxbgUGYcQSLeq0CUsP7pKShgtPh8
         iYVcSK8ggt2gDR0fANr/w85TtFVsAmtE5G7wdUXLod3Ojlo5gV5B79m0p+tadKmslijf
         93ujeHNs5f3rW42gykb1HDi7DFlDfQPBtszEpgnzOo62pRPcTWueH4jfzclewqEon/zc
         GCxqEAO3/y+19cKguKsvf/PUPCtBMdObBqMARb9kgavazigCUJJrvXmQB2KCXdBmgFEG
         okfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1769780921; x=1770385721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJE2HGNayNXuJcYfTf/Dlr7rMPC4aRqGvmLDgSYtmJA=;
        b=TC3WCDPgXv3M8hszR94RPzAvJNCjvLN3EgfgbME0EvpPyjQA0QUpoaMTuLgS56tCpM
         KHlcysJYOUTmq96vk7L3mrsgxKQ/MhJ3xsToGMpR7aMpCXiKlnWscsCSWeXWDl2LI1TC
         v08HocBPCGQ7iJmOG5HZ0pivpl4TejalBsHGkMUa1njdjgN4xitEYhRIeD67FRwm8GVZ
         naz2QqUSe8va1JWv+9VG+FGkINMRngS9TuxKn10+gC8SkUexpHIpopq9W7lqqCNqmkab
         vc06S2dRBF7XxuGD9apa1+6DJvy6k2yn5PlutV/djnpjvzR1gbkBZprqtTnq+2u8arVi
         KTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769780921; x=1770385721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cJE2HGNayNXuJcYfTf/Dlr7rMPC4aRqGvmLDgSYtmJA=;
        b=Nbff35dby2h4eFjpwx3h5oGqK2t0jsn3WRcxmfT6Wpu7AEjlY17ZvUF7f1/NpcyIFe
         J2VoNgrJlq/OuZ4H2u6UaoFvYIfxEyQ6ThG5Wt7+OGkIeoJY31VIt679dafzw7XPtFRj
         UL7oxRIye24e+a5cVDj6gAsrXL4ref5E1Mnn4gWBXKlFULxswLHEuVjgLtSYmQJGbU8t
         wfsZElm9U/UeS39meXiE8XOrmPTDoklSzNfDz0vpR3SNWdzLcwYuGojJCxJOFKQnPus/
         KnPGkzj/wcTcsNqIRFLebfoQIcOd+/F2K2vEJsfCaZCPAAfFkKBsd2ZPkElIr4AcLf3i
         ZYZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVctzqwkTO2QFKtPFeCjgehLPBJPDLdGQnqyrJAxEgCLEcPkPWAU9TxIBlk7Qq2PTuwyTEZFfs7eSurK7yz6cUe@vger.kernel.org
X-Gm-Message-State: AOJu0Yy00m+2T8fIy9p9yHfXBTgmqPUs0ij2GInWhzlZZtOzaEY3HL0g
	GL18bPEnQZhm2K1YO1GUYuy8ByRbvETgZRtebpx0Ymy9kOJzzTNvgkQRUOjX8Bdu2tlJo89lAtv
	r9uwEI+sm8e1FdrmMWUGDmpPNZjXpOk0wAVTdCNbtfg==
X-Gm-Gg: AZuq6aLkan6//ID2HHrQvQNl7SN+KbSVJEYgHz4dx4okLlzCZXPX7uyyZ/9looyZAL6
	Wxo2V7SEJClVNVPe16/aM0SIxhcssKP68yVd/zwLi1oKgtl8FyKNwlpNRORl1/Fsx8tKET8uDsW
	Qc6xW7Do0ZlTJzeiIpvP6bH3jCgLV+LF4RA7aSzqnB9cLcq2nJ76CetXXEDCRqwHTvJnILsjO6q
	wqJQCELeNtIYODV/kGahb31N6d/qf0oGNdQpYFBz6VfIOyZUB6gc4lbkwrKvjGRX1pTjXDspguV
	n9axTDBvscrs6DYBXXckssyv5bWi4E6Dyj5nqWmL
X-Received: by 2002:a17:90b:3d4f:b0:34c:3501:d118 with SMTP id
 98e67ed59e1d1-3543b2f2d96mr3113852a91.1.1769780920584; Fri, 30 Jan 2026
 05:48:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127023618.1469937-1-zeri@umich.edu> <20260130102300.GA171111@noisy.programming.kicks-ass.net>
In-Reply-To: <20260130102300.GA171111@noisy.programming.kicks-ass.net>
From: Henry Zhang <zeri@umich.edu>
Date: Fri, 30 Jan 2026 08:48:29 -0500
X-Gm-Features: AZwV_QhDCCRKA33GQr_-fvEk2fmVfkjdkL6jIKEEr7e0vACvjYRSnjEqHYnPXKI
Message-ID: <CACkPEmn+WES-yQNW37Y=w1k127LYHygYQJXHPxzB++Wdo1krnQ@mail.gmail.com>
Subject: Re: [PATCH] perf: Fix data race in perf_event_set_bpf_handler()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Henry Zhang <henryzhangjcle@gmail.com>, mingo@redhat.com, acme@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, 
	syzbot+2a077cb788749964cf68@syzkaller.appspotmail.com, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 5:23=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Jan 26, 2026 at 09:36:18PM -0500, Henry Zhang wrote:
> > KCSAN reported a data race where perf_event_set_bpf_handler() writes
> > event->prog while __perf_event_overflow() reads it concurrently from
> > interrupt context:
> >
> > BUG: KCSAN: data-race in __perf_event_overflow / __perf_event_set_bpf_p=
rog
> >
> > write to 0xffff88811b219168 of 8 bytes by task 13065 on cpu 0:
> >  perf_event_set_bpf_handler kernel/events/core.c:10352 [inline]
> >  __perf_event_set_bpf_prog+0x418/0x470 kernel/events/core.c:11303
> > ...
> >
> > read to 0xffff88811b219168 of 8 bytes by interrupt on cpu 1:
> >  __perf_event_overflow+0x252/0x920 kernel/events/core.c:10410
> > ...
> >
> > Annotate event->prog access with WRITE_ONCE/READ_ONCE.
> >
> > Reported-by: syzbot+2a077cb788749964cf68@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D2a077cb788749964cf68
> > Signed-off-by: Henry Zhang <zeri@umich.edu>
> > ---
> >  kernel/events/core.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index a0fa488bce84..1f3ed9e87507 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -10349,7 +10349,7 @@ static inline int perf_event_set_bpf_handler(st=
ruct perf_event *event,
> >               return -EPROTO;
> >       }
> >
> > -     event->prog =3D prog;
> > +     WRITE_ONCE(event->prog, prog);
> >       event->bpf_cookie =3D bpf_cookie;
>
> What about that cookie thing? The consumer seems to be a bpf function
> (bpf_get_attach_cookie_pe) which can equally run concurrently, no?
>
> Also, there seems to be a coherency issue here, if prog runs, it expects
> cookie to be present and all that.
>
> Would that not suggest something like:
>
>         WRITE_ONCE(event->bpf_cookie, bpf_cookie);
>         smp_store_release(&event->prog, prog);
>
> >       return 0;
> >  }
> > @@ -10407,7 +10407,9 @@ static int __perf_event_overflow(struct perf_ev=
ent *event,
> >       if (event->attr.aux_pause)
> >               perf_event_aux_pause(event->aux_event, true);
> >
> > -     if (event->prog && event->prog->type =3D=3D BPF_PROG_TYPE_PERF_EV=
ENT &&
> > +     struct bpf_prog *prog =3D READ_ONCE(event->prog);
>
> smp_load_acquire(&event->prog);
>
> > +
> > +     if (prog && prog->type =3D=3D BPF_PROG_TYPE_PERF_EVENT &&
> >           !bpf_overflow_handler(event, data, regs))
> >               goto out;
> >
>
> Hmm?

Thanks for the feedback. I'll send a v2 later in the day.

--
Henry
