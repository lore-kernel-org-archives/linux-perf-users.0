Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FFD298CDE
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Jun 2025 10:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750070704; cv=none; b=U7ibrpvoKSyn7qlT54Lwa8+5cOvgS0DeGVIIgtD8P5yp01VFAknRDUPAXkAJ8PIpl8mktedGuQOnaqkTBnzAMKklMWIf5DA6NkHelNtciIBqZ+KEdKPHaT8ov+FtiE46Ig1+3I7GMVYY5mheFMZ2q6tCQv6TVmSiR4gzhvkhZNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750070704; c=relaxed/simple;
	bh=J6R6SWEsvDm+66dPzlD87SecGN7m0uU0XfqGXWlTaok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkNBbbv4AlG2k/63WK9OTWAPUbPrmOHtMS2omci9dsO4OZEko34hX/pO/z5EhbxpGAaYUbQFu0gCwLsGY6UjNpytijpratWfUfOqzO5Hd8MsHs+VOctavSz5fjIK5Dzdg0YHIE8OHztD/sf9TGaEdkK2jxxmZSCp5du7mX1wffk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QL2l8BCu; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QL2l8BCu"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so338685ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Jun 2025 03:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750070701; x=1750675501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6R6SWEsvDm+66dPzlD87SecGN7m0uU0XfqGXWlTaok=;
        b=QL2l8BCuuqGwweka0fNcZGQ5qz/9RCBbGooX/S6U1RIabI326JTQ5xK+3h6djPMSJq
         UT3zG4OgsvH+ZQzdoh5BNpK3oFAORbdbRPu/SIWo1aiBXT4TUPC/bVH+kTFVCD3Kk1Jl
         LU4SI78z25ymBzjV2cDW4J/lrLbh+fiTLsOCyfbXcXVleC0qQlxxYZCD9W5C45cg/kQZ
         CBxNSgIdg+moJRABEQPxJPKwqWoWy7iNC7k0KmzOozhqlHpxGiJoHIH85SdgTZ5tj//n
         iYFmVqSf3FvSFLONeW3dOXATl41GJbNZk+Mbl9CKTPvfr6wfxaI5q3SDLTYJR+DIe3UB
         h8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750070701; x=1750675501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6R6SWEsvDm+66dPzlD87SecGN7m0uU0XfqGXWlTaok=;
        b=XTFzcpRya34votnCq12+Xg+UyUAo25lNOXH2JIflRlsJMuG+zPL4pY5/varnDQq1O3
         sPw2AkNtZ3fbWKLRnz76x/Kn2c8t16NGDrsOgZhCNUVdcMaSL3QzmFcldAIk4dBAlFCv
         C2jTwIkOHliLfo6Er306lk66hZZD2bRtzygFNlM/sQAfopRLkEJno9VSZ6HSvadSTCz3
         5ZqyWXO+4ErL+8UZxu04rc1GKvYkC6ApaQ19n6xpXSNujBfF6Bi/HC5vQ/0trc1GQOeF
         hXEKMSate0RBiARbzH/iU4mhOj3mx1CoQmVt3DuMvjoS9ZSRxTTGvKy1rk60mqlplARj
         JB5w==
X-Forwarded-Encrypted: i=1; AJvYcCXfGhFMuFj4ZhXu/r82H6jNLbltD5Mi8+glWDKeLcaD2kMtcAr/sNvwSa/LCJRXCD82/wGb26lQ9U+wsAU4ga+W@vger.kernel.org
X-Gm-Message-State: AOJu0YwoteLXoMVXF0OTj3Co0PrEORijAQ6D8h5l2W5kUdTkAgFEgLuJ
	oEqXa9ww4wnJ6tPYdbiYIyiOHsV5hZJyCAenb+PDjr+LwIraYXvCpgQMBZB/Jt29gwkX2nEXLC0
	mXnDGM/ZLnEd42f+hmPG2eh8teq2VUBUjTBmqOQoH
X-Gm-Gg: ASbGncsNq56lYn3quWOMfCRKHY2XrCDLosBj2RV6DhK5c6coBJNqUtwTlexPTWofXQo
	GIb12zA8BxLfDK/oXtHfBRjRRPtvVhr8vUsDp2cxT0F61ZGTZ95vfJfbyX1z5zLTSGdnCbv3Ss+
	k+XPJ5Xws88dRquxbDiyCOQnqtWiJS5UE/WqxzIxcYNuBg
X-Google-Smtp-Source: AGHT+IGZ5j8v3Ocn8ObEJWFaqu0zHRUBhHJbRBl19pWYIGlLXaQ5CvYChKdFLMs6JM1wUgSUPI1j2DL9dy/hVkqNSNo=
X-Received: by 2002:a05:6e02:1d9b:b0:3dd:a4b7:c737 with SMTP id
 e9e14a558f8ab-3de09fc2b9emr4525975ab.19.1750070701158; Mon, 16 Jun 2025
 03:45:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
 <CAP-5=fXSwgxMc+uh=PBAFh4Zm96tL5RDyKPOJ8Q40O4s=EaArA@mail.gmail.com> <20250616102945.GA17431@willie-the-truck>
In-Reply-To: <20250616102945.GA17431@willie-the-truck>
From: Ian Rogers <irogers@google.com>
Date: Mon, 16 Jun 2025 03:44:49 -0700
X-Gm-Features: AX0GCFsxy4AselWH-HXbNdNUVS0F-38THElPX6b9gGbKXhJTBrfP3qqVF_lXcMI
Message-ID: <CAP-5=fVjJyV2eA1aDnk6cqAhJGc9FZVyHhP7-f=1OyWmzxjN8w@mail.gmail.com>
Subject: Re: [PATCH RESEND v7 00/21] drivers/perf: apple_m1: Add Apple A7-A11,
 T2 SoC support
To: Will Deacon <will@kernel.org>
Cc: Nick Chan <towinchenmi@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, Sven Peter <sven@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
	asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 3:29=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Mon, Jun 16, 2025 at 02:36:18AM -0700, Ian Rogers wrote:
> > On Sun, Jun 15, 2025 at 6:32=E2=80=AFPM Nick Chan <towinchenmi@gmail.co=
m> wrote:
> > >
> > > This series adds support for the CPU PMU in the older Apple A7-A11, T=
2
> > > SoCs. These PMUs may have a different event layout, less counters, or
> > > deliver their interrupts via IRQ instead of a FIQ. Since some of thos=
e
> > > older SoCs support 32-bit EL0, counting for 32-bit EL0 also need to
> > > be enabled by the driver where applicable.
> > >
> > > Patch 1 adds the DT bindings.
> > > Patch 2-7 prepares the driver to allow adding support for those
> > > older SoCs.
> > > Patch 8-12 adds support for the older SoCs.
> > > Patch 13-21 are the DT changes.
> > >
> > > Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> >
> > Hi Nick,
> >
> > This is substantial work and it looks good to me. Do you know why
> > there's been little progress on landing these patches? Buggy Apple ARM
> > PMU support in the kernel has led to reworking the perf tool. It seems
> > best that we can have the best drivers possible.
>
> You reworked the perf tool to support these things? Why? These changes
> are targetting chips in old iPhones afaict (as opposed to "Apple Silicon"=
).
> I think that (a) most people don't particularly care about them and (b)
> they're not fully supported _anyway_ because of crazy stuff like [1].

I was meaning that we reworked the perf tool to work around the Apple
ARM PMU driver expecting to work as if it were an uncore rather than a
core PMU driver. More context here:
"[REGRESSION] Perf (userspace) broken on big.LITTLE systems since v6.5"
https://lore.kernel.org/lkml/08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st=
/
But in general it would be nice Apple ARM PMU support were well loved.
I think we went 2 or 3 minor releases with the perf tool not working,
threats of substantial reverts to avoid the PMU driver bug being
exposed, etc.
As for which Apple ARM devices should have perf support, it seems the
more the merrier.

Thanks,
Ian

> Will
>
> [1] https://lore.kernel.org/r/20240909091425.16258-1-towinchenmi@gmail.co=
m
