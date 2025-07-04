Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA45D285CAF;
	Fri,  4 Jul 2025 12:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751633255; cv=none; b=BXVjtP5akRnGKI4GS5YzE8c9vQz9Z8U7jb96PZcBOAsmf7JgL8kdZThDy5Qkc223KLGlrLdhvWlwFXBABiYkQZ+HQddRWFoWl5nv99Ihi5fumtUjG2q9NVhWxLwXIx6kT/QkUQYImdtiWywbCez3rai7UjtI8EwsuQdFj94rFoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751633255; c=relaxed/simple;
	bh=6jP9D9616ela9JZEfLO4DfalddDJ+mCTmT8T39jD33Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKcpZ2ANUNS7c9l/W9E84nU/r5XBfjHGJ+tMv1ObSV/hlLDp51o9H5f5CAKddCvxwKvV1NLoEuGPx3hCsUxaadUcQPgpSdTatP9Jxu5j10rEGLF0ZQqfxpyCwFYJhDw1FCpeLQsCavckplFX+pyywOypjRGCgpX+cW1eo30wnAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+UmKBcB; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+UmKBcB"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4e9c3d752a8so561908137.2;
        Fri, 04 Jul 2025 05:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751633252; x=1752238052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmkC/J54lBcE9vTJQ/eqQ53eT1txKtJeKwM2czVAqok=;
        b=j+UmKBcBUi42r0flEc3G6XD/wE5f3bnjtJisy+6FICT7O/z2wh1SzoJGvIxyTXpenv
         ikiw88imqDBIPXb9pj+wtVj4wkqy9ID4H6j5RIFGg6mEGHlW/XgHPELwVb8uDr3BwxQF
         BPwybF6qadp5A7bGutuszeTzTR1maDOenweog0yF2EQyceS/iCyJw3prWfCrxIWbkmkH
         BhO6G+1ZNmDp6bLoXqlfMsIrAcFZPQPF9ZaW2zedrWcwxkbu0zzHQVqF+CJpFzYhnGiy
         NkWqTNV22K/xZYMH+++eJH80Jvzs68qDjbgFEw8JpPKNFVyczSP4Q6L8PbFl5Mw+wDGH
         juDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751633252; x=1752238052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmkC/J54lBcE9vTJQ/eqQ53eT1txKtJeKwM2czVAqok=;
        b=OTep7z8SGw5CtT+VvO3Xu99u5Qvp0DtEGVejWatWfehkFQJnGAhIQN4RNBwhKgYEHL
         ILa8gwIsAE9uTugjfw3GPo0+Mj3EjdO7/S+ujoKmuVAJnI1k2ZqyUS5tnbUdi4T6TRyJ
         2+bLdtGU9lBIqaWkTThRubuW2uyI9ZcgD9CQ0nSUIOBQNPOG+lJcTVcPH+In/lgs71AJ
         ri+c+iLFGfsasV6zbPNH/Oc/p1Rp89eOkr7mJfriTFIFfywa+Mhq0kDbCfWR2CCX8qPP
         52fXaQwS5lyzetuhdOHTwsPQfR3RAHzXoyeEdZazV9Ux56jeNJJ1GccrswPrZ5B0AbUb
         z9hA==
X-Forwarded-Encrypted: i=1; AJvYcCV8vcuM/5khRwSeT7nHSrlvYT3+QeelGtwoiYwA1QfxnsdokWmwQGiRf4Fone2BerLaArPd2vpvl2SgwCI=@vger.kernel.org, AJvYcCX4OKongHI9LX3LSU3cqS/N7/WD+oofzaM901afS88nI8AZY3ttmGUJ4BD/EgpZTyD6yHZUHX/1N753pJuLyPaCsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPm7Bl0OAjuO7kcN9m4lsnTaJiREmLiunNyszE/1eLdVBRqvls
	VfPkWgGvCEswgVYlWA8gqqpKqr5JSGTmKWg6IdN45SZyeNW6tkBjYZpE+FDf5bUwln2OsRZf3Un
	kcTs7auWamHpN8aBOC4mEjbDVUZSQtDw=
X-Gm-Gg: ASbGncsjcse2+L68p03KNclKijoRrYgunjNi3aO5myA+TZYDNuQgBXcSda3hbIWJjqF
	ttjJKYOWQHoR23J4xjmJPfsjeT8ikUE6+BXSIJm0xiQYUigWQ3jOMmtzSViBm53thr8IgUjR7zZ
	q7WBQonKxm1ySnrYJ47ckA83EFBkV30oTTXGLY8oY3ut38A/FuyeM0Mg==
X-Google-Smtp-Source: AGHT+IHawTsrx4WDbFlRPlxlZcwpJ9SQEb2goe8AMjagYDS4e6sLzohPm0ltLUpjuFrfN802O/n2TCqX5jwiMAcEvq0=
X-Received: by 2002:a05:6102:1613:b0:4e7:7146:a9e with SMTP id
 ada2fe7eead31-4f2f1785dcdmr1076295137.6.1751633252563; Fri, 04 Jul 2025
 05:47:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618215843.109941-1-usmanakinyemi202@gmail.com>
 <20250704102007.6354ce9f@pumpkin> <9c59d1b1-a483-49d9-b57a-c86e3e020234@linaro.org>
In-Reply-To: <9c59d1b1-a483-49d9-b57a-c86e3e020234@linaro.org>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Fri, 4 Jul 2025 18:17:20 +0530
X-Gm-Features: Ac12FXzG0zByMCB0ae0k2YgqZqwpOgNB1rpA4c239EAnHokHVO5eYPlU3-XxRjA
Message-ID: <CAPSxiM9AHNrAhRjJKe9fHZ9s7VAQBF9c4S2_HWj2qu1A48hh+g@mail.gmail.com>
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

On Fri, Jul 4, 2025 at 4:40=E2=80=AFPM James Clark <james.clark@linaro.org>=
 wrote:
>
>
>
> On 04/07/2025 10:20 am, David Laight wrote:
> > On Thu, 19 Jun 2025 03:28:43 +0530
> > Usman Akinyemi <usmanakinyemi202@gmail.com> wrote:
> >
> >> strncpy() is unsafe for fixed-size binary data as
> >> it may not NUL-terminate and is deprecated for such
>
> But memcpy doesn't null terminate after the 4 chars either so I don't
> think that's a good justification. Surely you don't want null
> termination, because char *vendor is supposed to be a single string
> without extra nulls in the middle. It specifically adds a null at the
> end of the function.
>
> >> usage. Since we're copying raw CPUID register values,
> >> memcpy() is the correct and safe choice.
> >>
>
> There should be a fixes: tag here if it actually fixes something. But in
> this use case strncpy seems to behave identically to memcpy so I don't
> think we should change it. Except maybe if b,c,d have NULLs in them then
> strncpy will give you uninitialized parts where memcpy won't. But that's
> not mentioned in the commit message and presumably it doesn't happen?

Hi James,

Thanks for the review.

What you said is true, strncpy and memcpy seem to behave identically.

I should have rephrased the commit message in a different way.
While strncpy seems to work here, firstly, it is an interface that has
been deprecated.
See -> https://github.com/KSPP/linux/issues/90.
Also, memcpy is semantically correct for copying raw data compared to
strncpy which is for string.

I am not sure if the b, c, d can have a null byte, I think using the
semantically correct function (memcpy) improves the robustness even in
cases where b, c, d have null byte.

What do you think?

Thank you.
>
> >> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> >> ---
> >>   tools/perf/arch/x86/util/header.c | 6 +++---
> >>   1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/u=
til/header.c
> >> index 412977f8aa83..43ba55627817 100644
> >> --- a/tools/perf/arch/x86/util/header.c
> >> +++ b/tools/perf/arch/x86/util/header.c
> >> @@ -16,9 +16,9 @@ void get_cpuid_0(char *vendor, unsigned int *lvl)
> >>      unsigned int b, c, d;
> >>
> >>      cpuid(0, 0, lvl, &b, &c, &d);
> >> -    strncpy(&vendor[0], (char *)(&b), 4);
> >> -    strncpy(&vendor[4], (char *)(&d), 4);
> >> -    strncpy(&vendor[8], (char *)(&c), 4);
> >> +    memcpy(&vendor[0], (char *)(&b), 4);
> >> +    memcpy(&vendor[4], (char *)(&d), 4);
> >> +    memcpy(&vendor[8], (char *)(&c), 4);
> >
> > Why not:
> >       cpuid(0, 0, lvl, (void *)vendor, (void *)(vendor + 8), (void *)(v=
endor + 4));
> >
> >
> >>      vendor[12] =3D '\0';
> >>   }
> >>
> >
>
