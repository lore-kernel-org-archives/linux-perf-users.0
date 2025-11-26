Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE515189F20
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Nov 2025 02:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764125770; cv=none; b=RydlT1Yg8dK8wr9vITgmI5tkgfvdK1wFG1ZL5KEmU9/8fSamXNx2KEz2oVrMPVlh0kPAJBh2kmcfmq5Kc/y6fGGYoBL2aEosqapdDjjh4nixyLTdyEoqR4HoN92B/tIbCqocLqanpJuzGI5Y7qElUzVcctyoTTeXd+mDm63+kZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764125770; c=relaxed/simple;
	bh=Bk81LNpNeWH440dGuP6I/bASy/uwnxEAJogJ/Y1pv6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OAfDIymjdHLGF1tbMCsqxQBSMYPJU3GtH2qXE52cYRQpW9+kb/FYQre+b5LXlQuF+QATslXNw+0SDY76X/x1BtFXjHP+UGAK6wYEv5Oyy2YPACKncSrZWoWI7+Bo1z8xRmaBfOaxWLIMsBtfYQhwE/NLr+wdv51/zlKUEru/Zoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skydio.com; spf=pass smtp.mailfrom=skydio.com; dkim=pass (2048-bit key) header.d=skydio.com header.i=@skydio.com header.b=2XoL/8IR; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skydio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skydio.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skydio.com header.i=@skydio.com header.b="2XoL/8IR"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7b9387df58cso9814333b3a.3
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Nov 2025 18:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google; t=1764125767; x=1764730567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Icph2i8b5FPgjEqWI79x4TmH7lh3lkX8FmROfPvQREc=;
        b=2XoL/8IRQ63g92M+zqPywYH2RCDUhZ6uokPKNJaNtbWzKWJd6v3xIytcgdgH17r4ru
         Wp85+DmuQODVNunqiXwz0Lwbr1qPHBVtrKIKMxV9p4IxR2O2ukYRSAaDS+35ZaSN8+Pv
         1pak+dYrTectMC4SgOdeqkyZC3lZVFEBfZu8Vi99Oc+jRMj8LAo9eGaYeq8EYGP7cGJ2
         diNkya9Odzmcvq5ohKZvrQbaQtGJKIwG9A6dLmQmdAZYeaN+CuqNr0Uypeu4zF3rBHX2
         5eEW4xeQcc/gpk4/1E+17Zl6mMjf+se20+Fo0hB56ZSjnvrDvKLj8Wdc1nR0JflPelco
         wfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764125767; x=1764730567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Icph2i8b5FPgjEqWI79x4TmH7lh3lkX8FmROfPvQREc=;
        b=TfnMWO7FoYLp2ZjXS6mFyhBFO/+YfOfC1hEkaLkDmJ2d7p4+P1qfHKo1Oc47O+d6tU
         iLqQQ+odT8XNt/PMM2tLnx+jFWQ7HnpeFnVxHatkfADY/BtVZEdVO6WEIf/CbFPIHUcT
         8vK2xJ5YTUTayWLGjpXkl0MjiNrB6jsHm9/7GS6bskoqM9MtoCeLnLzNREG9n5qzRn5b
         Cpg0bx+56oAAOoCOPgyU0vB2GMyIyKxi0t8+ASKYRPC57v63N0fTmK7/lJqCsHPKZdkB
         FoGckbhCDQSQHoK8ZggD7g2WF0TxInzYviTXYVZb0eA1c72gj8cxeVPyGBBM9aEfhpg7
         Nxcg==
X-Gm-Message-State: AOJu0YxRLQoW46jK3DgtG5Qf5vE56oFFLN8lioI0DSSPgN/qVDOdXhG8
	HmiwEqbbH3zYovIisxAVebxjhylga8f79ohLu8sq8FLcuFj+7Wh9H4O2VK32YKx5MBzoG5S16wY
	UfuyJGl2bX7OhnZtNeTfEcWfVDXC/wxglk1IN+Ig5Qw==
X-Gm-Gg: ASbGncvp0uaZ+aAcR7u6sUi+AtIrxJbaGZSvNLoO2QVj3unZEFiWbpKHFh8aBwbONLQ
	2A5Tk74oz4osM9Hzom4puIDRxLqHNsKjJsVUBBZ8Hx6OHQqnre5p5aQUP2q2sirKiN2aKUmEPWN
	NZEmloCN4dNgISFfgukw7UtMdhqiEkM84+s1wLekJOtxQv+rwHgLHJLPUGDRk8yJf0N//4y+eyH
	gx9O0iJlR8/2btpW2c8VY3ECQz8Pfh2JHmE2Sve5kvw2QBa1JCANImFJ8E4qCAwTl/YiugeY1Pl
	A/mmNmRswk4FG0oQDVT8GEU93XcZ
X-Google-Smtp-Source: AGHT+IEyRyW+uO5Lb5S9IPRkE9n1eUywMebsl2J5FwI1RQhiS9JH+8ND9x2oeKs//DFgjC4kqJ74HhXPTbaLKCPNkno=
X-Received: by 2002:a05:7022:f95:b0:11a:126f:ee7d with SMTP id
 a92af1059eb24-11cbba4c514mr3459487c88.35.1764125766783; Tue, 25 Nov 2025
 18:56:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK3u-5gjxsFbnimP0mMFM6GRki7TAfNe6YmY6KtJhApV45nSNw@mail.gmail.com>
 <CAP-5=fVndu7gOVSzH=jKtsNLQk=Asv_OZNaEQ8nPXoUKWE8izg@mail.gmail.com>
In-Reply-To: <CAP-5=fVndu7gOVSzH=jKtsNLQk=Asv_OZNaEQ8nPXoUKWE8izg@mail.gmail.com>
From: Shimin Guo <shimin.guo@skydio.com>
Date: Tue, 25 Nov 2025 18:55:54 -0800
X-Gm-Features: AWmQ_blo3_1xMQkC9k_9g1hF9M5x_049hsWDrea1ZqRqm3XKSBIa8PA58SnIJlo
Message-ID: <CAK3u-5gfzAR5RDicyqaUi9ddZSbD=JkYN-K--iD4wCMCqFKF=w@mail.gmail.com>
Subject: Re: [BUG] perf: libdw not working for data collected on a different
 arch than host
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 5:43=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Nov 24, 2025 at 10:39=E2=80=AFAM Shimin Guo <shimin.guo@skydio.co=
m> wrote:
> >
> > Hi,
> >
> > I see there have been patches aimed at enabling perf to unwind stacks
> > collected on a different arch than the host perf itself is running on,
> > for example, https://lore.kernel.org/all/20230606014559.21783-4-leo.yan=
@linaro.org/.
> >
> > I believe there is still one issue that prevents me from doing
> > unwinding on arm64 stacks on a x86 host. As of v6.18-rc6, I still see
> > the following in tools/perf/util/unwind-libdw.c:
> >
> > static const Dwfl_Thread_Callbacks callbacks =3D {
> >     .next_thread =3D next_thread,
> >     .memory_read =3D memory_read,
> >     .set_initial_registers =3D libdw__arch_set_initial_registers,
> > };
> >
> > libdw__arch_set_initial_registers is defined for each architecture,
> > and the version is chosen at compile time, not for the arch the data
> > is collected on. After fixing this issue, I was able to get the call
> > chains. Is my analysis correct?
>
> Hi Shimin,
>
> I think your analysis is correct. I've been trying to clean up other
> cases of this, such as with dwarf_regs:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/log/tools/perf/util/include/dwarf-regs.h?h=3Dperf-tools-next
> Or with syscalltbl:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/commit/tools/perf/util/syscalltbl.c?h=3Dperf-tools-next&id=3D1470eaa574=
870da3f78942927b15e0b75da3ffbe
>
> My belief is the arch directory is a code smell where we've most
> likely broken cross-architecture support. Were you in the process of
> putting together a patch series to fix this? My hope is to move away
> from the CPUID feature strings for things like this and just use ELF
> values like EM_X86_64.
>
> Thanks,
> Ian Rogers
>
> > Best,
> > Shimin
> >

I don't have immediate plans to put together a patch series. I'm not
familiar with the Linux development process, coding standards, and
common practices. Conceptually it's not that complicated, but whatever
I come up with is likely not the best way to do it.

-Shimin
