Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAAC1FBEA8
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Jun 2025 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750177746; cv=none; b=FFNPTF7wLVc82tn75tT03PsAtPx4JQgGkg+878g2fSf7jXN4sDxC1wV18P1VGHNIsHfWpi+PL1uw71f9733lulHSg81BukoMMPlC8Hs0CuxVadrlJ77jj1T/gkPfXIH10eTEQCB1ABA0hCBW5npFvlJhFN66I/7C3hrZmVy/Qkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750177746; c=relaxed/simple;
	bh=NEFMnlX92eZmddj6ISOAz5HWpkBrZdvzNs6PETlF6C4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aV9Ez11cLSLZTt++CLLkCfIkDviq2IkLL5xv50ahbZxl66kc8ffgPghfPkjAA2wzXNUVLavK1m+iBEVnPEx0iIft5rpQ+9wBD/qBGusQZbTK6P6xl7gKybmkOUTb1WwE3M62UeHJFUbCvO30gkl/qBY/rAfMj1UCDxWQM2DzlFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fwXWVkx1; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fwXWVkx1"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3ddd1a3e659so154575ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Jun 2025 09:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750177744; x=1750782544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEFMnlX92eZmddj6ISOAz5HWpkBrZdvzNs6PETlF6C4=;
        b=fwXWVkx1RNWqe20fp9sDZtSmtb/Z4qds7+/Txb57ZhKwNUmYcJYuuih7p5w4su2gVE
         rh7OVKGGNa9wMr7Bsqrb6ZL0KwCLho/Q72He0mjKLbXEkQf6Fp3taiu6DNpK4Nf529C6
         bX1L8RUBvXXIpH+ZQbKAHuIMo4ShPGsJNBrVlY23250RcxtRnZmQQexd19Ygcb5kIeMe
         Tp4Py0JZAzHyZJuLVaX4z6FvTeQaeG2zLCEEAtJrTyPe8iEZ7QITDRNZOm9GOk+RfcG3
         bLR5ulD8Sq54FgymzGU2gJAgP4iMYlfK6/r7xxyY7UmBz48MzucmQwi90aklprlk8UdG
         BfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750177744; x=1750782544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEFMnlX92eZmddj6ISOAz5HWpkBrZdvzNs6PETlF6C4=;
        b=nysbnL0QggxpTmTZR/RiXz/b43nswyadB0eFW3jI0aHUaBI7YBLr9enQIq3bcCWCj0
         9DNn15iqSJ5IroUrRhQOhTvdNvpkfpTedJa9D217/Me+5HtGZbqRoXaJFoGQYe2bzhba
         PKc94ExZA7Oqia6hCFeKAUUEcad65UMDKZX0cy4M22ueIOYDDtZNhvkxC6B+rGOXqhRh
         utMwb2JlDCBFGkjOv0v//6vqIQLEkcakieZcf93byRUPuvIR5j61dzvJ556+x5CW7K7+
         fauj5gjt/AC6lEnyKh3Iy4EEdbrsXy/d4/Tj/OEraqs+27yBKyvkIpLp/PnQiUMmaPyU
         WkzA==
X-Forwarded-Encrypted: i=1; AJvYcCXOk/8BvoZorTqfTVWrhGkN9SNxSyGNm8r6jcKQGTi8rtTLoUU0DIeUFK365iP7b4soF7L00FGZQUFeSVe0Pmyr@vger.kernel.org
X-Gm-Message-State: AOJu0YxVMbjJfWpmPbh2UPOJ4iP2QqdItGPakf0/GS/iJqI8tw+ew3+w
	7cOYQ20w0MWCKC7kFZhs6zoIRSm7txjjlc1MypfZeqEer/mIupOUD/ghwELdM4nlYOhSoWMH3sZ
	EWuV08Dy0DDbZuUbd5+islllEaaBSxkwcqweK00Rb
X-Gm-Gg: ASbGncsM864PJb9JEbBmac30B3WzDSka6QbbkfwwkgHivJhI9BkI/odlhP1YPYIxcNI
	xKkxG1FvszgN9Fm1MfAox66dDE4tNgeE+Fb1q4YRrZCIsBzhZQhlyPEDqTaVMmZ7qPOCnQM2SDF
	8DrrMAHmQW43oGvOXAlbcsSewYIrEwoSzY1mFxyAifJZWKyYBB20EqOGNXu7FQAsjoFtGtRiQQ
X-Google-Smtp-Source: AGHT+IGuaQHH5RnvKvS2kE5LJtsJIfjqrig7FhB3Xp0nL8VkPKaJwzzxDGo5xtnO5/xq+BKzkzCl2ghHE6EtLjDojGk=
X-Received: by 2002:a05:6e02:1aa5:b0:3da:7c33:5099 with SMTP id
 e9e14a558f8ab-3de09fa7317mr8962435ab.13.1750177743269; Tue, 17 Jun 2025
 09:29:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
 <CAP-5=fXSwgxMc+uh=PBAFh4Zm96tL5RDyKPOJ8Q40O4s=EaArA@mail.gmail.com>
 <20250616102945.GA17431@willie-the-truck> <CAP-5=fVjJyV2eA1aDnk6cqAhJGc9FZVyHhP7-f=1OyWmzxjN8w@mail.gmail.com>
 <20250617141649.GA19021@willie-the-truck>
In-Reply-To: <20250617141649.GA19021@willie-the-truck>
From: Ian Rogers <irogers@google.com>
Date: Tue, 17 Jun 2025 09:28:51 -0700
X-Gm-Features: AX0GCFtUDjpPo9TijhacurqPBZmSpa7o8vMtplPwxsLKffdst7807Hbk9NO-1jU
Message-ID: <CAP-5=fXn_mr4k=fTYEuK7cCty4n8sofQaz1jNsrTn8U2icm_pg@mail.gmail.com>
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

On Tue, Jun 17, 2025 at 7:16=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Mon, Jun 16, 2025 at 03:44:49AM -0700, Ian Rogers wrote:
> > On Mon, Jun 16, 2025 at 3:29=E2=80=AFAM Will Deacon <will@kernel.org> w=
rote:
> > >
> > > On Mon, Jun 16, 2025 at 02:36:18AM -0700, Ian Rogers wrote:
> > > > On Sun, Jun 15, 2025 at 6:32=E2=80=AFPM Nick Chan <towinchenmi@gmai=
l.com> wrote:
> > > > >
> > > > > This series adds support for the CPU PMU in the older Apple A7-A1=
1, T2
> > > > > SoCs. These PMUs may have a different event layout, less counters=
, or
> > > > > deliver their interrupts via IRQ instead of a FIQ. Since some of =
those
> > > > > older SoCs support 32-bit EL0, counting for 32-bit EL0 also need =
to
> > > > > be enabled by the driver where applicable.
> > > > >
> > > > > Patch 1 adds the DT bindings.
> > > > > Patch 2-7 prepares the driver to allow adding support for those
> > > > > older SoCs.
> > > > > Patch 8-12 adds support for the older SoCs.
> > > > > Patch 13-21 are the DT changes.
> > > > >
> > > > > Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> > > >
> > > > Hi Nick,
> > > >
> > > > This is substantial work and it looks good to me. Do you know why
> > > > there's been little progress on landing these patches? Buggy Apple =
ARM
> > > > PMU support in the kernel has led to reworking the perf tool. It se=
ems
> > > > best that we can have the best drivers possible.
> > >
> > > You reworked the perf tool to support these things? Why? These change=
s
> > > are targetting chips in old iPhones afaict (as opposed to "Apple Sili=
con").
> > > I think that (a) most people don't particularly care about them and (=
b)
> > > they're not fully supported _anyway_ because of crazy stuff like [1].
> >
> > I was meaning that we reworked the perf tool to work around the Apple
> > ARM PMU driver expecting to work as if it were an uncore rather than a
> > core PMU driver. More context here:
> > "[REGRESSION] Perf (userspace) broken on big.LITTLE systems since v6.5"
> > https://lore.kernel.org/lkml/08f1f185-e259-4014-9ca4-6411d5c1bc65@marca=
n.st/
> > But in general it would be nice Apple ARM PMU support were well loved.
> > I think we went 2 or 3 minor releases with the perf tool not working,
> > threats of substantial reverts to avoid the PMU driver bug being
> > exposed, etc.
>
> It's unfortunate that you've had a torrid time with the Apple PMU driver,
> but I think it's important to realise that it's both unmaintained (it
> ends up with me via the catch-all for drivers/perf/) and was written
> based off whatever reverse-engineering people could be bothered to do in
> their spare time. It's frankly remarkable that it works as well as it
> does.
>
> Despite all of that, I still don't think that your concerns apply to the
> patches in _this_ series, which is about adding support for older Apple
> chips.
>
> > As for which Apple ARM devices should have perf support, it seems the
> > more the merrier.
>
> Easy to say when you don't have to maintain the driver!

Well I do send patches ([1] is based on a patch I sent and James
reworked), but yeah. It is a bit strange in this case that we have
something that is both unmaintained but not taking a patch series due
to the cost of maintenance :-) Hopefully it can land.

Thanks,
Ian

[1] https://lore.kernel.org/lkml/20230710122138.1450930-2-james.clark@arm.c=
om/

>
> Will
