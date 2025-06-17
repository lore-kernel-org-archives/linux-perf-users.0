Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF54CA4B
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Jun 2025 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750179238; cv=none; b=Y+zv2CzrHmyZX+CnmtxikdTmYQdyxaXGLji2vZzJrLlT1cMCXHCHXDxMde4lHemLDm64Z7WaskinuqjLwPgsrWRnpuY6hocQ+9b/M56ezXOrisPun1shUMya6+AquheUkLfnCE/KZhNMubOReVOOa2pMM6u7W9dkEFkUvNpvfP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750179238; c=relaxed/simple;
	bh=sBlsNW8rrToWOrhajHMtR7bPZcZNRFXKCV4kuxSCtGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R20FKNcrzu8Qd4IOdA50ldzLNTZAHKGQGUtI/Y5vSgLdRUZpKt0HHW2wqGDTtd7/585y9Yk/zscijFy9vryjWjVHrhXlBlL+lhcEqLg8K7JfwB+GgYzRDga6oy8tpBG/HAHDja9KlN1ztK9LNG3abtm3tWg2NXQ6ZtE54cX0MOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JsjqHIS6; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JsjqHIS6"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so10795ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Jun 2025 09:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750179236; x=1750784036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYJnE0bLpXfGXAhOdoPj9sjJfon5avZzMzwtb4GEZQ8=;
        b=JsjqHIS6SrWvTtPqEamX+rE8oY28eN10IhMp96WR+Tk6jtltlVBUQjtWjeUwbofjp/
         wvwQxo/ENAGIKRzmacn3b794E36sHE7jvFc6uSq2qatRzCa+3HMSWXYLtGU94hLfQTHd
         4snu3DkcsFAPwEpaPkJe0uDWD5aPJqEJUUE5Tk3kDteSFvP/BNeLAGPnKaRL8IyjeExb
         l7Q5DlioBpMPt7uL0PvotRD09ijzSuyRVZkfKrLB6LxUk5kcO8zcuK41S5Tp5Nb1wFW9
         3Sin0djqSVY7FSeKtRkMOHz4vpupA0H/XYBqQmZRFrDVwjraHkfFUTWA8T79H8oPsJHt
         MhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750179236; x=1750784036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYJnE0bLpXfGXAhOdoPj9sjJfon5avZzMzwtb4GEZQ8=;
        b=oK9JPUvl5NZZMLH0WghXs+zh38EDS/VplLXlPMRTnhElTDaUvUSq+2WfyF42kGFr7u
         B8xNVnTNQG4Kjstm6MPByvea7wRiOTM+lJlauyh1KxmI2mKrKpYxzSnJW4tZlhqMJxFE
         lvnk/jY8gBaMWuqcFIua0g12g4fc/PlENMaZ9WLmL8UcgAp2F6r323WQ2OJPL4iSaR0T
         ww8GCqepRfX28qeQSHOlfULjFxhpX0BCxJEBaLT0XDlXJhvL2fw5qSCk7W1TOPwdoovP
         QhRE579jfN33OYXHRq0LpiZ7uaA1rz4dnTLCmsIptF2OHpC1R2TvS0igMcrHLEGBVCzP
         fuuA==
X-Forwarded-Encrypted: i=1; AJvYcCVDgVgeOOt3/8dOfuPNuyxCRE+bPvUI1y+w2IyHP+4ySXVka57vNO9Ia4VvaeXgVX6QgqG3Zwg0crDUrKPQmznK@vger.kernel.org
X-Gm-Message-State: AOJu0YyGsC2TFllhTaKELcAsf89hrJ6pcWqogf6j2YLhTToIILVJQTm+
	SqiO0Qwimw4EocHH4t/azG1AT8QLAadr7tzqMGGLHQ6llXrQFmSXoh6dHPic4psjuwutehSd1JO
	sE7QqZrBBsO4Td5ehYQZUIrJVGyghfopz4dujrwQO
X-Gm-Gg: ASbGncvVfZtrefZApPOXBgNSz3urF5EKSppiXcqc92YF/TzxdQkz5AUKank9CgvZATM
	F02pcfbSwlgkYwu0HsUWittkjW1ti23Svj0WJBAcr20Vd0QJd2AV5GcYWpeGgTtNwhkUjMIgGBP
	TDkLVM178HkrSSGJFyoYqSgHs6W9hEst6zfjSQ8wVymLKZ1MVOQbIvGOP98LwLNz1tmfuhqAra
X-Google-Smtp-Source: AGHT+IFxzIYnRwPkTPGsw15J0FvFqBPucLmLVdUh15Kwq1Q2Op1ssWJY8RG0XKYKAwujDL/N2ht0/4WAcdskUuxdyGc=
X-Received: by 2002:a05:6e02:4819:b0:3de:20ec:5c71 with SMTP id
 e9e14a558f8ab-3de20ec5f19mr5234075ab.6.1750179235473; Tue, 17 Jun 2025
 09:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
 <CAP-5=fXSwgxMc+uh=PBAFh4Zm96tL5RDyKPOJ8Q40O4s=EaArA@mail.gmail.com>
 <20250616102945.GA17431@willie-the-truck> <CAP-5=fVjJyV2eA1aDnk6cqAhJGc9FZVyHhP7-f=1OyWmzxjN8w@mail.gmail.com>
 <20250617141649.GA19021@willie-the-truck> <86msa6co21.wl-maz@kernel.org>
In-Reply-To: <86msa6co21.wl-maz@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 17 Jun 2025 09:53:44 -0700
X-Gm-Features: AX0GCFugvPzuB-Difn5EDUPVkKbvplUqcVBXc7z721G-mrMOHZ8e5lOvCFsdSTo
Message-ID: <CAP-5=fW51G0Wc227K1o0T==wF_3DN-UhBrU1VzncwmfPcWP3fw@mail.gmail.com>
Subject: Re: [PATCH RESEND v7 00/21] drivers/perf: apple_m1: Add Apple A7-A11,
 T2 SoC support
To: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>, Nick Chan <towinchenmi@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, Sven Peter <sven@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	devicetree@vger.kernel.org, asahi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 9:47=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Tue, 17 Jun 2025 15:16:50 +0100,
> Will Deacon <will@kernel.org> wrote:
> >
> > On Mon, Jun 16, 2025 at 03:44:49AM -0700, Ian Rogers wrote:
> > > On Mon, Jun 16, 2025 at 3:29=E2=80=AFAM Will Deacon <will@kernel.org>=
 wrote:
> > > >
> > > > On Mon, Jun 16, 2025 at 02:36:18AM -0700, Ian Rogers wrote:
> > > > > On Sun, Jun 15, 2025 at 6:32=E2=80=AFPM Nick Chan <towinchenmi@gm=
ail.com> wrote:
> > > > > >
> > > > > > This series adds support for the CPU PMU in the older Apple A7-=
A11, T2
> > > > > > SoCs. These PMUs may have a different event layout, less counte=
rs, or
> > > > > > deliver their interrupts via IRQ instead of a FIQ. Since some o=
f those
> > > > > > older SoCs support 32-bit EL0, counting for 32-bit EL0 also nee=
d to
> > > > > > be enabled by the driver where applicable.
> > > > > >
> > > > > > Patch 1 adds the DT bindings.
> > > > > > Patch 2-7 prepares the driver to allow adding support for those
> > > > > > older SoCs.
> > > > > > Patch 8-12 adds support for the older SoCs.
> > > > > > Patch 13-21 are the DT changes.
> > > > > >
> > > > > > Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> > > > >
> > > > > Hi Nick,
> > > > >
> > > > > This is substantial work and it looks good to me. Do you know why
> > > > > there's been little progress on landing these patches? Buggy Appl=
e ARM
> > > > > PMU support in the kernel has led to reworking the perf tool. It =
seems
> > > > > best that we can have the best drivers possible.
> > > >
> > > > You reworked the perf tool to support these things? Why? These chan=
ges
> > > > are targetting chips in old iPhones afaict (as opposed to "Apple Si=
licon").
> > > > I think that (a) most people don't particularly care about them and=
 (b)
> > > > they're not fully supported _anyway_ because of crazy stuff like [1=
].
> > >
> > > I was meaning that we reworked the perf tool to work around the Apple
> > > ARM PMU driver expecting to work as if it were an uncore rather than =
a
> > > core PMU driver. More context here:
> > > "[REGRESSION] Perf (userspace) broken on big.LITTLE systems since v6.=
5"
> > > https://lore.kernel.org/lkml/08f1f185-e259-4014-9ca4-6411d5c1bc65@mar=
can.st/
> > > But in general it would be nice Apple ARM PMU support were well loved=
.
> > > I think we went 2 or 3 minor releases with the perf tool not working,
> > > threats of substantial reverts to avoid the PMU driver bug being
> > > exposed, etc.
> >
> > It's unfortunate that you've had a torrid time with the Apple PMU drive=
r,
> > but I think it's important to realise that it's both unmaintained (it
> > ends up with me via the catch-all for drivers/perf/) and was written
> > based off whatever reverse-engineering people could be bothered to do i=
n
> > their spare time. It's frankly remarkable that it works as well as it
> > does.
>
> Also, the "broken" driver actually works as expected. Ian blames the
> userspace breakage on that driver, but that's only because the way we
> deal with PMUs on ARM doesn't match his mental model. Oh well.

I'm not sure what this is in reference to or what you mean by my
mental model. The linked patch was that legacy events didn't support
the extended type bits added by Intel for hybrid. Prior to this legacy
events were broken on ARM BIG.little PMUs and would select an
arbitrary PMU - not good by anybody's mental model.

I'm happy to chat with whatever issues you think I'm creating. I think
you are making reference to situations where I've cleaned up a mess
with Intel hybrid and then cleaned up a mess on ARM. I continue to try
to clean up a mess for RISC-V. Sorry this makes you think I'm a bad
guy.

Ian

>         M.
>
> --
> Without deviation from the norm, progress is not possible.
