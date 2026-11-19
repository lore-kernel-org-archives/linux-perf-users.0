Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795046829;
	b=an8CqB3GU1CBouD74fBcuNknyVrfnxsykaeOW3OUkWH9tPJj3Ny6TOJA0IBxEkDLrW1B
	 msZAQP9MUymAB8p3Nhqdg0WNsA1vI7G/6+/5kHDiaYeGZxPE/sdner8ce+jO99a3Fq2h/
	 BXXAXYqfKxk8ZfH5tbheTUTeDobr3lmL8wBdS8FNad0Vkl7WN5JOWocznoGF7o+xoaiwv
	 9nqlQl0LijmXuj9ozgvBOp0EjAw2YNsn1tly0cbPJYpQoHgWAY64RJh0uY5nGRrB4WeB6
	 aAN6CJGb4mR4+35pMl/HOx/yxVUFucvz74e8oOIWXS+KfMn4Bxe/zDFhBNhqDvyLHNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795046829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=EWi8bkR9h3tHXm8j7DxgMM6UdzZIdJvfItB6nSFm4tY=;
	b=N7OS1BPhzLvf89jhma4ga+XgE1CbOXPPgGmX8BG4AloyiIfomCwYHrN9kUW2Jf0LCtbT
	 LbWvT+MfEDjWAAi/gQQ6zoyNRHVZa8OQaiXGxfm/gtvJtT/VqdOic81XePVqk+qOHiMRg
	 14EL16sGuXwr4yB+RZn5QfTX8QY/dQkGqcLJrN5iAn38o4S8hG/zIOxFgQITYz0fGcSwS
	 Jo+v4Yh/bJqZqEsYMh1EYmU9prrXxglzV92K9+OjldPy9udSub+55GKqER7vJgZ070SG3
	 6iUCZZeIVDk1L5ZUZzC0vjv24K1KZFNFwasND8kIlPHfD8qlNGR3SeOdXi8iJc5hcLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cP9p8f46;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8428606A332
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 00:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8428606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cP9p8f46
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-49465892f7bso1244766f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:07:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795046826; cv=none;
        d=google.com; s=arc-20260327;
        b=sTpEl++o6e9jPrny2eNOdBYiAZO8NKx4CNeOp3sxdaULzHDeDU6+fge56+DCxt1Esz
         iXEM2o7zhiWSzCCLPCvnaK9RPHYboTm2zaEh35eTb1eaLGqB4d4ZDx2vcMzGpXOnxxoa
         wHWThx3vF4XRBCIOZPUNJDqV/yTF2KChxmuX26Me2ps0b+hKrBM/WIXk9TkaFBLEbaEv
         +20Wd1Kwn9En4yXETNP0hE4m4NvlkviJK84C1eXfaxXQF3xORElk/LDvCwEU+318sDPx
         IqTSlcxrgnYQBhyqyUCAJK0H+Uc1Am6QRu0xC6QPz97/Nu5CrqQhtp54voOShCtHVQ8N
         CqPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EWi8bkR9h3tHXm8j7DxgMM6UdzZIdJvfItB6nSFm4tY=;
        fh=3iZq4UNu+PLxQDBuVGHONcILXuC3H2s2028Ms/d8y/c=;
        b=CuFQvx/y21d/8kg32Zb1uYn+DaO4ZaI1j430qn+7XJkGQzRBI2m+/CwcvEpu/Gc5FO
         cTyF+QfO/X+gL8fav1I5j5E/j5CUcEdGzW/9+sL0C9JKXWAWZK35j+050NxlPXkvNd2I
         7YXaC8CXtu5ojlF3r8uJs4jjR/fnj9juYuc5EmFp+OwCYSHmEj1U3IGlWU6d2fgLNKS3
         IYa+N21B9W7phRQDOo0iJ9hgk5Bd13/5q1l0+vLS7ISSB/EvD9MvUa/RQbGhFfW+8CgQ
         f1dUmjC0TA7qecZi7gl+ukdCoU3b/6z1JIPIe4vFDi63g88irrTvzmX2zzpw8fBaj2td
         BmmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795046826; x=1795651626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EWi8bkR9h3tHXm8j7DxgMM6UdzZIdJvfItB6nSFm4tY=;
        b=cP9p8f46PWAzvIwsal+Oj/JMpU7RCpSeHhsiOV8GbRs14hBLT3UDPNgmzghKA1f3VO
         aBvC0BHG76DlFMTY/ByIoGmL9yUqTGSD5OqHLDUxXFKB6drwrKN3PMGhzNzM9azOdsIk
         71V2W+QrflObnpqCmyAdMmNbQXVvbWurS2v1dCxda2JQ9jkDOeVm1NUmaHzBxI6V4lmy
         nrlzzyKCpLjUf4FJHGPsgWOwBMpGR1h5PNu0HwDchTqdHngaI8cwf1qo6YmNJ2mMhYoC
         /EILkvbnJpXvZ1CzlWJy/PL3sJAssRwFETE0NazzRYwTzFYSmLD+GwW4h1tc+hVoo6+1
         ECvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795046826; x=1795651626;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EWi8bkR9h3tHXm8j7DxgMM6UdzZIdJvfItB6nSFm4tY=;
        b=zbg+K31AAz8QecEWoWyJS1cCF2LMNSG8E+YBEUiNdWq2O1wrtHhwykERXeI/hgEh5T
         OcDJHLYJ5OO2Ra+aSDbmRys6rEXxK1tLDVer7ITsrF93OicACTpG1Rg0DzNT1JW+9FOZ
         4WAkx7YMUZwmdgtLfOOIBDjdl8yuU4QWLPx6KIME11NSC1gtZPNpoZs8aHKGg0DhkCn3
         a4e2ugOVPBYsaO857LSVlzrakkpnm2pOXX43MPm0AZxhgrP3dSREzYSL8/RM1JEart1w
         kIqTPfVOihyznpkxxeVSPzPXLA1F0QHeh5jya9YM09/+PlDBArMvNtuo0oWm1yL73aC4
         8XXw==
X-Forwarded-Encrypted: i=1; AL+hErEiSABVFjrc2Oh6+Sr2ALnkcEQ/R0ksJEfLZlZgFeHgbm/4T1Ldk325DQ6S0v9H3tIoGcaEBUpdQme+rd9G1toN@vger.kernel.org
X-Gm-Message-State: APuU4Z+m/Z6K1CS2YuqKe6y0p8zWAQc8Tb14Yp98fFP6x1av/2cNgtKA
	HjFATCkPD7GUtejPhRlL99Z/EEGt4iLf9l8CbSK3mHq0Rs4wyGFIwYsi0CrQsZJaIZIiR0fj6H6
	dt9UcQv4dL2J/K1K1XIUEP0ssZ9ClO7k=
X-Gm-Gg: AZFdTZdayCmIj+p4KGI7ICS6+hJRu2Le40/1YEXIbYp3kme2XdCmSW/eV08dA+PNQFR
	U8WU7yxnHalq/YtGkwEIRpC30yv1NbcPiNSCYJiKLguzUChV5TxrIF0VJVbTqj2yiZEts4yzu2A
	If11YuOfVrrQnBMibLjDXGAh7zHzRHYMNyVFIgagFVLIQBrdz82quV/8mYUxKU5L77yYAj3O8wC
	P5j+6lfI/t6dogyfAWgB33Z1GeQsAZrOGbiH33PASQ6KZ9wIs+6YRf/IAKe5b/QRcXa1PRQJYx8
	7zE5DlIclid3jlv+Yg8fqqEvsLainGOI7A3aqhfYF20c+RgCh9GuS5fTNI8KhiflrPvsECXFrEE
	to4GSeKttAfESUHJGcsjiwmRYWROMmhNCEc189bC0GzPx2psMnymHzirM2obSl6RIxSebxORMkd
	aIv75vaRpSE1FplsGPCBc=
X-Received: by 2002:a05:6000:26c4:b0:4a4:1267:350a with SMTP id
 ffacd0b85a97d-4a6331c6d5fmr10036299f8f.5.1795046826107; Wed, 18 Nov 2026
 16:07:06 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114001846.873499-1-andrii@kernel.org> <20261114001846.873499-2-andrii@kernel.org>
 <avxJjTWOp250aDYC@willie-the-truck>
In-Reply-To: <avxJjTWOp250aDYC@willie-the-truck>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 18 Nov 2026 16:06:55 -0800
X-Gm-Features: Aa3M54ohy-eIhH22eDuxovMjFXOGOFVwvlzmEgw11hhd4u67Vz7wgMvDgsfWW0g
Message-ID: <CAEf4BzY7bs2y70tb7cSFrWiTZuhNkfqqVOiTL2WnawMxCFnn3A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] arm64: perf: Don't report the caller twice
 in caller-regs callchains
To: Will Deacon <will@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, linux-perf-users@vger.kernel.org, peterz@infradead.org, 
	jolsa@kernel.org, rostedt@goodmis.org, ardb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 4:33=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Fri, Nov 13, 2026 at 04:18:44PM -0800, Andrii Nakryiko wrote:
> > perf_arch_fetch_caller_regs() sets regs->pc to the return address of
> > the function it is used in (CALLER_ADDR0), but points regs->regs[29]
> > at that function's own frame record, whose saved LR is that same
> > return address. perf_callchain_kernel() reports regs->pc and then
> > unwinds from the frame record at x29, so the caller shows up twice at
> > the top of every kernel callchain built from perf_fetch_caller_regs():
> > tracepoint events, software events emitted by __perf_sw_event_sched()
> > (context-switches, cgroup-switches, cpu-migrations), and
> > bpf_get_stack() and bpf_get_stackid() in tracepoint, raw tracepoint,
> > tp_btf and fentry/fexit programs. E.g., for a tracepoint program
> > attached to sched_process_fork:
> >
> >   __traceiter_sched_process_fork+0x44
> >   __traceiter_sched_process_fork+0x44
> >   kernel_clone+0x250
> >   ...
> >
> > Use __builtin_frame_address(1), the caller's frame record, the same
> > way kunwind_init_from_caller() does, so that pc and x29 describe the
> > same frame.
> >
> > x86 had the same duplicate entry, fixed by commit 6d08340d1e35
> > ("Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"")=
.
> >
> > Fixes: 5b09a094f2fb ("arm64: perf: Fix callchain parse error with kerne=
l tracepoint events")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  arch/arm64/include/asm/perf_event.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/a=
sm/perf_event.h
> > index ee45b4e77347..13efb46f0fe8 100644
> > --- a/arch/arm64/include/asm/perf_event.h
> > +++ b/arch/arm64/include/asm/perf_event.h
> > @@ -15,7 +15,7 @@
> >
> >  #define perf_arch_fetch_caller_regs(regs, __ip) { \
> >       (regs)->pc =3D (__ip);    \
> > -     (regs)->regs[29] =3D (unsigned long) __builtin_frame_address(0); =
\
> > +     (regs)->regs[29] =3D (unsigned long) __builtin_frame_address(1); =
\
> >       (regs)->sp =3D current_stack_pointer; \
> >       (regs)->pstate =3D PSR_MODE_EL1h; \
>
> This doesn't look right to me. Presumably, the compiler is now going to
> emit the first step of the unwind, but it has no idea about the different
> stacks that we have, the meta frames or the invariants that the walker
> in arch/arm64/kernel/stacktrace.c takes care of.
>
> So we should continue to unwind from the current frame, but then perf
> can discard the duplicate leaf entry if we don't want it. After all,
> it's perf that's passing in CALLER_ADDR0 for __ip.

Thanks for feedback! I just sent v2 which follows (conceptually) what
x86-64 does, please take a look when you get a chance. I'm not sure
about PSR_MODE_EL1h vs PSR_MODE_EL1t hackery, but that's what my AI
suggested and it promised it's fine :)

>
> Will
