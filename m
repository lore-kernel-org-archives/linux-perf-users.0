Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A2F2F2C6E;
	Fri,  4 Jul 2025 10:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751625094; cv=none; b=FbgHS0NCbR4oI37Yo8p7on2qB/X2VQdjKafdB053UgCOV8F2y9nPy6mEVOnkxYbMJfCtJAl0a2d7jX0oB48WUecsi/ZBxLd7TvYP8NEr9HaDYaMNVHvMKK08dWVkw1F8lrnP3927s+SL12L/z/GRFE/bDtfjACBPa8cdaOdTcQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751625094; c=relaxed/simple;
	bh=wP9Qj0PzhkA69kKg43kptmGrDAjSerq7qh9RYRvlzyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYURvIo6yR0fHXEt0d/an5Sq4Ef1TSow6Y8T0ZGEDtfGycq/SJnmj94i/zbiNQ4oo32rEif0uY66NMfmcVMNGls83ONmpgcYIM9ZGaA2vYpcyq51h9Dpq4uP9PQse7U06/ExYOJqSWowwAu2Yj5HG7wv599F5ptv5Dut9wpcBL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ly+ohCCE; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ly+ohCCE"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4e8110ac0f5so209143137.0;
        Fri, 04 Jul 2025 03:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751625092; x=1752229892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/xQKlBOT6P4mp+UtjZoqvRrQDEQeBJnUbiMyYywOQc=;
        b=Ly+ohCCEMt6WRK0vbiURp2L8HkSRqdzC8hu6spKqsxhu0M63lnPA1e8A06p4q65V2n
         zPF6KPVj3z5Qet1iI0RS1gLGBTADh+oyZ1qoU8u7UXF+d1XP0kMzmH6khUyY7yDl6sJj
         Q+swlpjEdKz8bjL9U8Tg47ZAOi74IoN+BDFmTeWazGb+1d1L4/dUWz/i45BoIDMeRV+V
         j3oPjqME4+pFm5AzKMZQGFhyYTlQRxWSLFScbxtIk/kfskFCDAjgN1Xhhu/iFcBWSwjt
         1SIBGuEsK3pHOglKp7+ez82VFP0HsqR8y924AetYEgZxUm/ApZ3ki1y6TiSuIq5oYJho
         X70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751625092; x=1752229892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/xQKlBOT6P4mp+UtjZoqvRrQDEQeBJnUbiMyYywOQc=;
        b=e2GDVTlN7CHO5pWnCAPlHsdLUTLIhOtzmUbzFTh21/9SYOIrb+7XawFUV7nvBCXCXf
         BDlS/jrFSxmhMdk0rlBhM70lU/BAPTzztOYKml4neWNCi8YPvc6cpRUowLVImjc1ZMHr
         r6QG3xy4E8DqNfxe9MvuuujL+dt48L8r+QEhTAKveazjrqs0oLxVouV/SjbBKIxUotyz
         9qSrbPaYUzcaCHSQt+P40dwulSp+x9rHGJFL3GRNxklFpI6DX9aRKfcbgCCytSv4qEzJ
         wrbwAOksZaGG/lTNqv3rIE4bnDEKa2YgXQI7NBzUk7Z8HF+VnW3Y2c2+miQQ8LH06M49
         H1UA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ33TrBpgOC4PM17l1Ipwzj1SLa6HaTvzebkTW0QkL4votJuix7Uvhj+A6HFpY0liGFfHQQExWVQvOBg0=@vger.kernel.org, AJvYcCXlddk5SJcnhpRjTxLgPQgAnbpLs+UX9rZ3mVtWk1h6K+sjH+KAoQ7q8Rf9iNE/rKSbCkx9V/cgT3A64eDn6OuDjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/IjP4+3BsWDe6DdnH+J2SjPcK9IL+vMbztO6jPU98Wq/gwpsq
	VEVNEWnXFuhpKdDazrcmtgloHpYJkN/oS/oivuv5w3BnkT/ZULKsFZUSEYAZ1mhsZiJqPeDl+QL
	EKJteWxeCK/YHTqB7ZapysqYLbm42AHw=
X-Gm-Gg: ASbGnctZd5ecsQHVcAsOdcBIbV2nMvTKMIAs+NUO2Mfd/HgmWGGP/Mqzxf0dTKhaNV9
	k5WVd0V7RKJhFBJBnmf087Rcg3+hdXLhc8lt4nb10OH8uggy5rUdncUXxTeM3JRhTScq+sSvDg9
	4zCX1yX54qoj6nVE8ZsiWncVY1tZUHUa7R6GvaxAZjgjQ=
X-Google-Smtp-Source: AGHT+IHlGXvGOQ2VphguWOiSSKOQc0Bs6jXMtNMB761owKR/vtv710GFY0N2XIuOKvtR5oMroxYEWMNrPRtQek1SGN8=
X-Received: by 2002:a05:6102:5a8b:b0:4e7:e5b2:f651 with SMTP id
 ada2fe7eead31-4f2f15acda9mr725020137.0.1751625092019; Fri, 04 Jul 2025
 03:31:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618215843.109941-1-usmanakinyemi202@gmail.com> <20250704102007.6354ce9f@pumpkin>
In-Reply-To: <20250704102007.6354ce9f@pumpkin>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Fri, 4 Jul 2025 16:01:21 +0530
X-Gm-Features: Ac12FXw73ZOhyBKhSbbf_4Qj4dulDh8DBNftU6kNO6qEo_c_P5vHGtCLcAhkE8k
Message-ID: <CAPSxiM_X8Ykz-kbBuFmT1vt_V3G4AkA3tE4wwbUniE-edoyJyw@mail.gmail.com>
Subject: Re: [PATCH] perf/x86: Replace strncpy() with memcpy() for vendor string
To: David Laight <david.laight.linux@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 2:50=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Thu, 19 Jun 2025 03:28:43 +0530
> Usman Akinyemi <usmanakinyemi202@gmail.com> wrote:
>
> > strncpy() is unsafe for fixed-size binary data as
> > it may not NUL-terminate and is deprecated for such
> > usage. Since we're copying raw CPUID register values,
> > memcpy() is the correct and safe choice.
> >
> > Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > ---
> >  tools/perf/arch/x86/util/header.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/ut=
il/header.c
> > index 412977f8aa83..43ba55627817 100644
> > --- a/tools/perf/arch/x86/util/header.c
> > +++ b/tools/perf/arch/x86/util/header.c
> > @@ -16,9 +16,9 @@ void get_cpuid_0(char *vendor, unsigned int *lvl)
> >       unsigned int b, c, d;
> >
> >       cpuid(0, 0, lvl, &b, &c, &d);
> > -     strncpy(&vendor[0], (char *)(&b), 4);
> > -     strncpy(&vendor[4], (char *)(&d), 4);
> > -     strncpy(&vendor[8], (char *)(&c), 4);
> > +     memcpy(&vendor[0], (char *)(&b), 4);
> > +     memcpy(&vendor[4], (char *)(&d), 4);
> > +     memcpy(&vendor[8], (char *)(&c), 4);
>
> Why not:
>         cpuid(0, 0, lvl, (void *)vendor, (void *)(vendor + 8), (void *)(v=
endor + 4));
Hello David,

This also works well. But, I think the "memcpy" is more clean and
explanatory . I can change it to this if it is prefered.

What do you think ?

Thank you.
>
>
> >       vendor[12] =3D '\0';
> >  }
> >
>
