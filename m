Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5570E3A1E6A
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Mar 2026 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773416522; cv=pass; b=uSZBjbQL0pUv0KyF6QtBr0TJrMmXbCI254Oa1CB+LbGLAJsDgjEicOM9JP3V9Ofsy7VgnUcOQBeFPBsMCN7f9MlFnVBishbjGT9Dddi8/3jhb67owG+HpqWLxfqR74OomSm/DfuzXuRiHZe7smISR7RJx3of2/FO1HP6jivG2lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773416522; c=relaxed/simple;
	bh=MqKWbF1K9prpiKRFMJUDv6RSKOW1kYhKyzjN906N8Ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7bjYZ1zQFuAaG16u6UKCLO/wmDK7TkZi6dWrxZUI6TGhuzPtpbhoMJRU6oTvqgoM/i6x8tVF4a9jhS42zkf0nqe4UavDc0gCSSs9GDk2clCOIMeoXaeIlnQElnTMTZBehl7xj2sBW2ttj/BcMeqcxq3H3pRE3T9ahbaumzm0KU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iaGYXV2i; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iaGYXV2i"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ae3f822163so107075ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Mar 2026 08:42:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773416520; cv=none;
        d=google.com; s=arc-20240605;
        b=i6gTURt1WvqyeQu2aF6Z7pxm6vEZde0mBTecBTilWdlrBaIcV2uFr2r9k8TNU4H7Mp
         FxNGSCr0Snc/jwK1OzzeAyJqVKSmrlf63hgFH5DZqRenra9aVon7bqc2CPPKMzCmoOQq
         TG55l9QeY/Cv4338wjF+1Xr5H6M9+ijCVwegTHH5onCUHldLxp6/ynOOZuzuXi6QpiI7
         h8eoncb669s62jkkfmvcY614WP7E9cwp3LO4QJ62W9ordUOPc4PjrhTM3tQ0cB55wX39
         Rj3VSjsQXkjuYVwmIhY78XaxUFasgoM3Jxo/rXwSn3ObjIzkkoG1J4DDyBMbdrWXy96+
         x6NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q07G+OAbpZKijxP5AiBDLkTD9FE4MgVyIhOUrj6YrXU=;
        fh=EEu9jOGS8DkWWjdt5iWdr7DMyWuuoSqsD2ccay8Q1kE=;
        b=NpRHId5qjIC9NGnC2/gk1Sy0N4Gy/YBAADldmxiztZY92ktD4e7stwhPyuUGPqRzQP
         mRF3OiJnJnFr0QGE5PjahLaRl/vZmFsEtWM877+j+t/AqKzcwrg8DujbMT8caUVK/+FL
         4TBDsoqvH/XKllkfkvIJcJ+i4LBkOKV8LqhCsOeQ/0aA8LbcSYOXzYQhAZVTflmNPjM5
         H7qpipwlRdnsQ4mgXDrCgyOBHYZjhW8mLo+I7JFDtq6oi9VgA5TI3u+3hpeeUFabOGmx
         CSfW+kFbFPryFHvBl2H38ZGViwGE9zQ/8LKp81SWCfssUvAe0W2J1UiCRIi9u7ZnYDW7
         THCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773416520; x=1774021320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q07G+OAbpZKijxP5AiBDLkTD9FE4MgVyIhOUrj6YrXU=;
        b=iaGYXV2ilZGyglbFo8PG5iK78pZuf1VyFKey0BcoKTisrBeeTvSycmsK0w0jDTlqr0
         qsIsnzDP0sQ0xKjSKBcllr3MwZIEOIstdzeu19sZOIGVyTe02B/WjrThwRvOrLfBCuTI
         FrUf89IP9Mq6vBqtFQAOQyEr38wZXZb+vH0vwJtaYZp8XtKKdywz8Cak6cYvIdE/DSuV
         B/rSWsYtZjfU6kTqEHWOX4H6guXoGJ9k9FJ2q94Q2epCLTtNJ3zNqK2PxIe5MgSn7349
         M+Q0/EjvZzTABR1am5NyrHSxRFbqMd0i7mj/bUcMPNbk768DlWD55CWXWHC67kZ0cnn3
         vFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773416520; x=1774021320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q07G+OAbpZKijxP5AiBDLkTD9FE4MgVyIhOUrj6YrXU=;
        b=jmWzCFJkqz1V8IlGbFZYWOcKwcX7SE6cZa++AQJJOnsb9y3DhYf92K7kyADkx5TJkM
         7CgrSwE9RD1mpe572PMEpJb6pnp35f/I7jz2RXNFSK0hbXB917AVFJ9F6O7ifh+mg8vC
         X/0lxhvhKzSa2A54t650tUqeon8bDxIp1xtslMcvAuhpnN/KghwnsyTQ2a0ccw0N9yc8
         saIU7/tDGJ4EQpAntKRGe6cYQdXz7ZyhowrhYSTV8yMX89y4AZwvO68vpjI2efKeDHjN
         SCIOeuY1O7+hODPh/D9Ensw2BaGVU7wr14grxvmEcpVtAY8rYUPKtVeIxaKLwr4IgPC+
         PHpg==
X-Forwarded-Encrypted: i=1; AJvYcCUc/dTbYn/YmAC/YdBkgugOWer5FCWerPAkY6FYwhPrQHgmFImHoyVzEtIf/4K0lgHP9XnHea6/iFxqu3HQ/gyq@vger.kernel.org
X-Gm-Message-State: AOJu0YyBLSNxMRYcLrlku2pl2RHYjcvWmQSn+JiYWzBM/DfyOAXQKC/4
	S+MWtsJw9vWeSX14z/mtVpIXSoZarMEGgPxC5vtuw9bEq+s3oYcGV/qwi3+l1MMYykAVwgn5uzY
	GGXK3d0EZyHr6ZHaCOeuCOM3eFJBc+E7CZ88AqB2u
X-Gm-Gg: ATEYQzyXqFCQ9gGa0iJg1pBvRpmIAOJf8tIppfdmOvoLAGxUxVZOomcTZ7yjjQI0PaS
	TG7+gc9E5bvb1fwoQmx8lGXJJVc5CmC4l+0khGrOFjmMn4vW+RI3LykuJlLspYp3Gv3cRWSMEba
	Ujt9v1elq34NtegjIGBjQZx8o0WDADAExrYUSIVaOgE2VptjPjgtYuorFyk+X+Sq0+TmFmOCv0F
	cMgBOwhKB7LLUY9rZBfIxtpgCE89hOnfbbIvw/Zd+NMCLuI7z3bLGQBTbLAv0L/OY0b23Jj5Q+U
	rIIp9kSag8QmAbYN1itwcMDGp+coYV9RfqsX
X-Received: by 2002:a17:902:ce0d:b0:2ae:7d03:c911 with SMTP id
 d9443c01a7336-2aecd56f0b2mr2506745ad.1.1773416519929; Fri, 13 Mar 2026
 08:41:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66d0366b-8690-4bde-aba4-1d51f278dfa1@linux.ibm.com> <abQq79_ajs8zFeEI@x1>
In-Reply-To: <abQq79_ajs8zFeEI@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 13 Mar 2026 08:41:48 -0700
X-Gm-Features: AaiRm50WOdm4Ean_Pw7iGJt7N5hem3D2oEZRWovZca76GeSqp8bhm-jnnjispcs
Message-ID: <CAP-5=fWG0Q-xNGn_-_KGCopaNsWG5rUN3pYNLEh3K7+xE0OwVQ@mail.gmail.com>
Subject: Re: perf stat issue with 7.0.0rc3
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, Jan Polensky <japo@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 8:19=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, Mar 13, 2026 at 02:13:18PM +0100, Thomas Richter wrote:
> > Ian,
> >
> > I just discovered a strange behavior on linux 7.0.0rc3.
> >
> > I run these commands on my x86 virtual machine:
> >
> > bash-5.3# uname -m
> > x86_64
> > bash-5.3# perf -v
> > perf version 6.18.13-200.fc43.x86_64
> > bash-5.3# perf stat -- true
> >
> >  Performance counter stats for 'true':
> >
> >          1.108.929      task-clock                       #    0,437 CPU=
s utilized
> >                  0      context-switches                 #    0,000 /se=
c
> >                  0      cpu-migrations                   #    0,000 /se=
c
> >                 55      page-faults                      #   49,597 K/s=
ec
> >    <not supported>      cycles
> >
> >        0,002536439 seconds time elapsed
> >
> >        0,001363000 seconds user
> >        0,001393000 seconds sys
> >
> > bash-5.3#
> >
> > This is the epected output, however when I use the perf version 7.0.0rc=
3:
> >
> > bash-5.3# ./perf -v
> > perf version 7.0.rc3.g1f318b96cc84
> > bash-5.3# ./perf stat -- true
> > Error:
> > No supported events found.
> > trace.args_alignment
>
> And this last line is even stranger, in my case I get something else,
> also on x86_64:
>
> root@number:~#  perf stat -- true
> Error:
> No supported events found.
> addr2line.style
> root@number:~#
>
> On an ARM machine:
>
> acme@raspberrypi:~/git/perf-tools $ perf stat -- true
> Error:
> No supported events found.
>
> acme@raspberrypi:~/git/perf-tools $ uname -a
> Linux raspberrypi 6.12.62+rpt-rpi-2712 #1 SMP PREEMPT Debian 1:6.12.62-1+=
rpt1 (2025-12-18) aarch64 GNU/Linux
> acme@raspberrypi:~/git/perf-tools $
>
> I'll try to bisect this later, thanks for the report!

Hi Arnaldo,

Leo has pointed at the fix:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/commit/tools/perf/util/metricgroup.c?h=3Dperf-tools-next&id=3Dc5a244bf17c=
af2de22f9e100832b75f72b31d3e6
This also showed up as missing for the LTS backports:
https://lore.kernel.org/lkml/ad95d781-7eb2-4c0c-a9e9-aaabae8eb602@kernel.or=
g/
so I thought it was flagged as a fix for the next PR. I don't see it in the=
re:
https://lore.kernel.org/lkml/20260313151434.1695228-1-acme@kernel.org/
Could we get it in?

Thanks,
Ian



> - Arnaldo
>
> > bash-5.3#
> >
> > Same happens on my s390 systems (LPAR and z/VM).
> > Is this a known already?
> > I guess this is a perf tool issue, same result when you execute this on=
 a 7.0.0rc3
> > kernel.
> >
> > Any ideas where to start debugging
> > --
> > Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germ=
any
> > --
> > IBM Deutschland Research & Development GmbH
> >
> > Vorsitzender des Aufsichtsrats: Wolfgang Wendt
> >
> > Gesch=C3=A4ftsf=C3=BChrung: David Faller
> >
> > Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht St=
uttgart, HRB 243294
> >
