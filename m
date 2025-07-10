Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1EA259C83;
	Thu, 10 Jul 2025 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154403; cv=none; b=qhj6PTH37mZR+q63UFE1b7iiH9eFlYVdWCrBURzXd7crqv591d7lF9JrYG+fTrEd2Z337WY3BgLzL9FI8781bYu0CSR60CVhd61f2NOzO0V7A1gUPtwSnfaXBtnh7i3iJ0Fz8NIPuQHbn5fPnlsjNCDcCgNKqFCwv1PR3f7Wm4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154403; c=relaxed/simple;
	bh=nfK/s+MDeAYPnclkJutwa89fLOtQFfFfkJwoIm0MldU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iu90PMNmwzWsxbXT0d/ND1yI8O6+SIGg8S6ZVGiDiXgA8kheuAH6ELdQmJF3IOCKQ/rAwcBDxfYEWPU8Qktb4Tcg1QAdLYQPUoxiKdVxzpruI10yTdJ/XCnEtRfJdCld+SN4vswGHZVbVS0oatt7yFcAZ6bqsIhR48GYvsrsZAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzVTmlyD; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzVTmlyD"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-881114808e4so524248241.3;
        Thu, 10 Jul 2025 06:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752154400; x=1752759200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okRj10ybyFEKvbIUZoyobNaWGhdkXbHXR79UDV6Xmac=;
        b=XzVTmlyDmQeFk6xhe8lX0Xq0pDvjzxb0TO6KGrIHxFHvbP+AH7SmB6X1Mq/5/Sp7m7
         j6jVDp8QyTyEUwZczaTN65etHwIAjEaLRgSvwRS/1LWnSlxdY8r+bm1AsvYGjEQEPnLh
         ac+QluyQK9g8nw0Far0QAdZORQ1IEFPZIos3aGg+bCPNK8AmY86x09+lwlKpz5xyVNzp
         0jAuAy+tNP/xaKaj4c2UdltpvKISd84K8wJRhvaRoApDRbdvT0b5tuwNTLOgsYsHMbqE
         3UFISX9H3dZrTxlx6NOxNmfkvA9BmOD2L3YR+8XHRvLCnTjbiR9s5iP2LTJh38fKDoE3
         G1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752154400; x=1752759200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okRj10ybyFEKvbIUZoyobNaWGhdkXbHXR79UDV6Xmac=;
        b=PHEMkSZOPJupUUb9yCJv8+mwomieQTVes/AQRkwGcOHB3aQgRFWM5omAv2+qmjVDTY
         AKYJMotHNrPtcPRmtXUyc1F9beQ6TkhhqY27XgVh5zAHBa2Aym3q1e5QkCRbEoBGsOs4
         xZb75ZMQW2jMU1M3XvPwXg7HnZPx748AfXSZppNQwCfL6vtSuKIAHfjnfWOLwa2h4Tm7
         0RgyKhTW7DXcK2+8Zn5BI9Kmtlazjhm59OAj4V4nvmUw0a5azMXsHatEl2K+H9jOPJpA
         v1noG+F3Ix8dvdkf4mh0Gp8c6IHyTsIufgqwIRTbMTStuKHgzj7mSu8HkC2gltAFwe5q
         WGrw==
X-Forwarded-Encrypted: i=1; AJvYcCXEDP0WYJ7ZwFWWAIarQZnKhk9bCOFKMUcvbGqFzR916Z4DPzvTz5AcLLuF52Xi4DvO9sIz83IgCcQ8mZo=@vger.kernel.org, AJvYcCXbuiYm0aHcGD8kAEUQdvjcGdeUA1cpo1AjY0Y2AsGsrsaqLd2Ia5ETV1rMKsSxxK8qhYpdT13OpcEitfDat5nldg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwL/IfVgQBgMmyA633wRa+eaYKMpTeUtQG5w2QJe7tO9CZXd4Jf
	vZAQCONrkpgMlZsIH+CE6fFHuZCgGMNFUcEkJImB/kfUeDrOLCYUgmZ/tftA7TwTf+1OEhL9xQe
	ptYnFAAtmixV2qSkrBnVhk1iFOK8eEBw=
X-Gm-Gg: ASbGncsHDJQFaVOlJdBrc5ExXF2ogQhWKAuJ56TxPNhAp2UHOhTXNaIlDGaeNnuD8MT
	YY37ocvTd6LBeWvzwvvnY2RgCAFXI/JFQ5qpA9ljMes7JoHqzFJF2fmZ3939VdGFKd+tFnZb2uj
	c1l4tfVic3QDPhDj3ZZ5BDXWgtsLXeb7wFapsI5eb/Tvc=
X-Google-Smtp-Source: AGHT+IEUhipK8BpFIh0L4sG9itYETsTSsy89yM5cpmb8XEFU3fZM3fuGJBmhOPNVBh8q308LdjUHfnWtxkKgT25ywgY=
X-Received: by 2002:a05:6122:2187:b0:531:2f51:7676 with SMTP id
 71dfb90a1353d-535d73c920bmr5063528e0c.9.1752154398939; Thu, 10 Jul 2025
 06:33:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618215843.109941-1-usmanakinyemi202@gmail.com>
 <20250704102007.6354ce9f@pumpkin> <9c59d1b1-a483-49d9-b57a-c86e3e020234@linaro.org>
 <CAPSxiM9AHNrAhRjJKe9fHZ9s7VAQBF9c4S2_HWj2qu1A48hh+g@mail.gmail.com>
In-Reply-To: <CAPSxiM9AHNrAhRjJKe9fHZ9s7VAQBF9c4S2_HWj2qu1A48hh+g@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Thu, 10 Jul 2025 19:03:07 +0530
X-Gm-Features: Ac12FXxTfmie9LGNZsXqRlfH_jKYoN7Yl1MYSUGdY_NjH8KL2bq5qU-PsDRLaX0
Message-ID: <CAPSxiM9-tZjnssZMA_59ib8Ur+4VNWk4RYOsoFiWHC_Eq+drXA@mail.gmail.com>
Subject: Re: [PATCH] perf/x86: Replace strncpy() with memcpy() for vendor string
To: James Clark <james.clark@linaro.org>
Cc: David Laight <david.laight.linux@gmail.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 6:17=E2=80=AFPM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
>
> On Fri, Jul 4, 2025 at 4:40=E2=80=AFPM James Clark <james.clark@linaro.or=
g> wrote:
> >
> >
> >
> > On 04/07/2025 10:20 am, David Laight wrote:
> > > On Thu, 19 Jun 2025 03:28:43 +0530
> > > Usman Akinyemi <usmanakinyemi202@gmail.com> wrote:
> > >
> > >> strncpy() is unsafe for fixed-size binary data as
> > >> it may not NUL-terminate and is deprecated for such
> >
> > But memcpy doesn't null terminate after the 4 chars either so I don't
> > think that's a good justification. Surely you don't want null
> > termination, because char *vendor is supposed to be a single string
> > without extra nulls in the middle. It specifically adds a null at the
> > end of the function.
> >
> > >> usage. Since we're copying raw CPUID register values,
> > >> memcpy() is the correct and safe choice.
> > >>
> >
> > There should be a fixes: tag here if it actually fixes something. But i=
n
> > this use case strncpy seems to behave identically to memcpy so I don't
> > think we should change it. Except maybe if b,c,d have NULLs in them the=
n
> > strncpy will give you uninitialized parts where memcpy won't. But that'=
s
> > not mentioned in the commit message and presumably it doesn't happen?
>
> Hi James,
>
> Thanks for the review.
>
> What you said is true, strncpy and memcpy seem to behave identically.
>
> I should have rephrased the commit message in a different way.
> While strncpy seems to work here, firstly, it is an interface that has
> been deprecated.
> See -> https://github.com/KSPP/linux/issues/90.
> Also, memcpy is semantically correct for copying raw data compared to
> strncpy which is for string.
>
> I am not sure if the b, c, d can have a null byte, I think using the
> semantically correct function (memcpy) improves the robustness even in
> cases where b, c, d have null byte.
>
> What do you think?
Hello,

This is a gentle follow-up on this patch.

I would like to know if I can send the updated patch series with the
correct commit message.

Thanks and Regards
>
> Thank you.
> >
> > >> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > >> ---
> > >>   tools/perf/arch/x86/util/header.c | 6 +++---
> > >>   1 file changed, 3 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86=
/util/header.c
> > >> index 412977f8aa83..43ba55627817 100644
> > >> --- a/tools/perf/arch/x86/util/header.c
> > >> +++ b/tools/perf/arch/x86/util/header.c
> > >> @@ -16,9 +16,9 @@ void get_cpuid_0(char *vendor, unsigned int *lvl)
> > >>      unsigned int b, c, d;
> > >>
> > >>      cpuid(0, 0, lvl, &b, &c, &d);
> > >> -    strncpy(&vendor[0], (char *)(&b), 4);
> > >> -    strncpy(&vendor[4], (char *)(&d), 4);
> > >> -    strncpy(&vendor[8], (char *)(&c), 4);
> > >> +    memcpy(&vendor[0], (char *)(&b), 4);
> > >> +    memcpy(&vendor[4], (char *)(&d), 4);
> > >> +    memcpy(&vendor[8], (char *)(&c), 4);
> > >
> > > Why not:
> > >       cpuid(0, 0, lvl, (void *)vendor, (void *)(vendor + 8), (void *)=
(vendor + 4));
> > >
> > >
> > >>      vendor[12] =3D '\0';
> > >>   }
> > >>
> > >
> >
