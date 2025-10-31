Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DA42DCF5B
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 08:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899084; cv=none; b=mG2eHMq3ehmh+pUs3bDEBC922aB2ioW2+p9xPzUNol198FIeZNKjPuEXnkx0/iJ2uZBlX8wXHUa+r76hw7igEWgRXWCUArZOEzMNk/v07UcpGMafuQ4hyUVBje2+4I1wNLasb/GoBB+k5ZCxZLdtBg+Av8G+cvrhosEJIXspJC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899084; c=relaxed/simple;
	bh=QBdLgXepaoyusDzfPuWF7W5gVFX3pzRYvpA7qsRLNtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKaSYoLR8RdcT0LQCkJUlWS1noF8isUseXciAVPsB9mMU4r0qeImVzJxW79EFr7DtfZ7rehtj9yF/WQposnun7CDLfiUrCKPlfI1epPt9xWAWNfzjm48OZKjj4U+tBm5UKth3esvAmjYbXJE0QXsdlss2z+BWhYkZOHQNnC3f+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5d613937df1so1774375137.3
        for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 01:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761899082; x=1762503882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSmGt9VWfBQJDvvEyJ8bQzSLcQfsQHCg2enix3hl0bA=;
        b=hNOHKuo1LthfsYEUOSyGvZMbQbi6gCtzX1gQgD0jLznOqwQ+Xm9AKfg6tYaAExf0IG
         cLrpoHLMaF271EtKQWVDG0Mqq90DG+90cVTAxAj77kLpuWiK/+VKxznqtaS+IprVPeKv
         ohpL0eY1u+ZPm4NG3lHCzoYM9Ns2+byIG5S3eDLUf7PAt78gGLbys22Wn7v7t4wdCAmy
         QQANrHI5wbAtaXkKB59N54ykYtk7vQoFX1bkN1h8mHbCoN7I0q5RhNNRs3liABgXiQcU
         MlyhCdLB1n6Qi4VP1sS6BH1kZwsdDW5sR3XpishvHPWa+MQCWg/epWnKVu9clTBZElpT
         S+4g==
X-Forwarded-Encrypted: i=1; AJvYcCUPkI6anUQd3qmb4GtL/Sy9yLMkHT2bfw/qi3oXabJE9OQg03BU3LXaJ8OHpEoT2/vxtvLJpjuNNhZwYfM8DqAd@vger.kernel.org
X-Gm-Message-State: AOJu0YyTyfH91rwgjJnClhexl8xCMNiG7QSffz/MvjvYc5L9f4bPqjkY
	s+ZrTnVPG3LJn2VKOxtluz05Wfu0TfqJtslHZwkHhQv+f+t0oyXTCL1I+zopDw==
X-Gm-Gg: ASbGncvnDYruBp4062lgefVP0pY+aVsBLFD8kUtdQ3OzSMJ9sr4wC1xOnEvEmBmsRJc
	4ejgrwAvK7HjJYlyOY14s7TUTJew2VmvcW0mvclY7GuNVM1Ju/cSxrkQBvjrjZJz9CREskiTbMJ
	L/cjdn8cgdZp+sBjZJ9F6y1+zKkRMfklnCAaP1/mbz8TZ0HlhINq23mKHQLf20pVZ1IWgOnmWjl
	6Xq4sLT/Rp5ieiXkW0197yy8SSPHDFEygUBD471jb7WBbl+Ocyodw+Y70EszTQksqlm85P17mgu
	M++kCQZihRjowyZutlEQKybZ+AWPNGB8czA3EJzaioIYv4HieVZpBXBI8iWMEtoBT9LzTGfkYPk
	aPVKExYBgbK0RhvlenfdeD7yqzirfbkvyrddXLsS0z39ohKvczOj6yW8obcxtacwOmwP0ICKNoh
	JrNzX8l/ckQ7CySKpWf5eqOep7OzRrtyARc9eZ28nI
X-Google-Smtp-Source: AGHT+IGHGHKh+nYYat2AbeCfqL5244kp8Ih3mb4nwwOX21MaI6khBJsw7UoIPDSmNZuKluWfVG9yOA==
X-Received: by 2002:a05:6102:30c9:10b0:5db:b804:dcc8 with SMTP id ada2fe7eead31-5dbb804e215mr160112137.0.1761899081669;
        Fri, 31 Oct 2025 01:24:41 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93512a554f5sm432563241.5.2025.10.31.01.24.41
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 01:24:41 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5db2593c063so1499061137.2
        for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 01:24:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXyW6vPW29xY+0ZgJmEfyvZt1G/SYGoc/znKctgA5mN74tNc+51Onxap48LJF8lmCVURP7JwuuuK2Hyr1j7Ez5U@vger.kernel.org
X-Received: by 2002:a05:6102:508e:b0:5be:d04d:d2c6 with SMTP id
 ada2fe7eead31-5dbb1204032mr790145137.9.1761899080804; Fri, 31 Oct 2025
 01:24:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
 <20251030102626.GR3245006@noisy.programming.kicks-ass.net>
 <87zf982s52.fsf@linux.intel.com> <bdda89a7-ff60-46b0-8ce3-28ffec1fac2a@sirena.org.uk>
 <aQOvCugzYe/2DcNW@firstfloor.org> <baf2665c-49aa-4b8a-be26-69dc23876bee@sirena.org.uk>
In-Reply-To: <baf2665c-49aa-4b8a-be26-69dc23876bee@sirena.org.uk>
From: Fangrui Song <maskray@sourceware.org>
Date: Fri, 31 Oct 2025 01:24:52 -0700
X-Gmail-Original-Message-ID: <CAN30aBEVdhju7CG4Tato-D1uof5p+dhTM6nJtjXX_SiYH7fU+Q@mail.gmail.com>
X-Gm-Features: AWmQ_bkGkpQQsklzLvHTWsBZ_xTryR-WgcL-38L2MiIPvb0SEfuMwf6pZKrIbe4
Message-ID: <CAN30aBEVdhju7CG4Tato-D1uof5p+dhTM6nJtjXX_SiYH7fU+Q@mail.gmail.com>
Subject: Re: Concerns about SFrame viability for userspace stack walking
To: Mark Brown <broonie@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>, Peter Zijlstra <peterz@infradead.org>, 
	Fangrui Song <maskray@sourceware.org>, linux-toolchains@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 11:45=E2=80=AFAM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Thu, Oct 30, 2025 at 11:31:38AM -0700, Andi Kleen wrote:
> > On Thu, Oct 30, 2025 at 06:07:49PM +0000, Mark Brown wrote:
>
> > > It's going to take a *considerable* time for the hardware support to
> > > become standard.
>
> > Optimizing for the past instead of the future?
>
> On arm64 no currently available hardware has shadow stack support, and
> once systems start becoming available it'll take a very long time for
> that to filter down to even being all newly shipping systems, let alone
> all systems that people care about running new software on.
>
> > Not on x86 at least. All my x86 systems have it, except for a few old
> > skylakes.
>
> My experience trying to find a system to test changes on was somewhat
> different :(  I did eventually get something.

I=E2=80=99ve chatted with mobile toolchain developers at the LLVM Dev Mtg, =
who
emphasized that size concerns are especially critical for AArch64,
which is heavily deployed on mobile phones.
I think Arm ABI makers are unlikely to want a format known not to work
with mobile Linux to coexist with a future, more widely adopted
compact format with callee-saved register, LSDA, and personality
support. I chatted with Peter Smith, who seems to think so, but I
don't want to put the word into his mouth:)

---

Intel=E2=80=99s 11th Gen and AMD Zen 3 support hardware shadow stack.
A software-only stack walking approach (and remains unvetted for
AArch64-see above) that doesn=E2=80=99t replace .eh_frame would quickly bec=
ome
obsolete.
Shadow stack can be enabled per process, providing flexibility to
balance performance overhead / memory consumption with profiling
needs, even for users who don=E2=80=99t prioritize the security hardening
aspect.
