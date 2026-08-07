Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55077284896
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786112142; cv=pass; b=uYEN6EkhrqaTMh3nZ5EN5JusA5l/TALDXIXb+/jnELf9cJN4K5B5qS/EYyPSW3uqrt5w0XdSMPWh5jM7N6hrjNvr2P0YA15MXrPuGqzUFg5aH3bfOJT+qv2YIaC300J2EL5CFeWhjEofnv4ISTn++64OkpFj9LZkLSfQ7eopLFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786112142; c=relaxed/simple;
	bh=8nIgFryYz2DrargIZD0GNMzp+E0YqW98PtHpUo3w5m4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sTgoRg9JEfcjLIFd8NraV38O/QhoW/zmV7ns/FGProf96K0o2WpdYnYSFLqOh8larE9kpZnTHiFxu4teOS286qafyf6UcnZXQUQa67pCtZs/JEbdtjs6ZPOsdVdgCnUgWSHQhwQyQmki2F3m7DMmEuGOkxli7P39dSWSdLgjhkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vxqrp1H3; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vxqrp1H3"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c20755e8295so210748166b.0
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Aug 2026 07:15:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786112135; cv=none;
        d=google.com; s=arc-20260327;
        b=iIVnuklRn/T1iBhPBInEMtGqlLG9dwU6RcLNgO6n5UPhIRTM/g6qugW3M9T2sS/bmS
         FMgSEXbIKOelpRFMCA9WxXx21Uob7B6QjM6DVRgarG6QfiTyITB86n+6bEtVri01PX7W
         qQ5b44KkXhuTqwHyqa1n5NTTgoMh4jXgqTuf0rYQ6mQSAqZBH7jeTR8005QjEgGuCiQI
         MD+FwkeCtgOYy7wJWAUE7HhawSkySM2C763m2IBLfU7ncCux2WkhtuliKSI41FRyqTX/
         LNm+l00dD1kzBF5ccpB2+6hP7Ibgt52fqedGvvMwgluU0/5D5exjku/kUrPOJ+Ob6arM
         kHTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MzS5XFrgTuiPjNnu38gbVxPmnnD5h/HbpvqKJVfoMMI=;
        fh=I/hWcP3TO5H23DRRSuGowXEpNHBReuG7YwYSnaP4Pf0=;
        b=giuMWP6yA0RCmPbRau3ZK+2fyqtZej07eyD28gbVl6EHiS9xLFV5LYFGwMVTQFdJJk
         9V0mJH4eMoP8mmpeZd1RHn4I2k2Ce4bASflXyXadcoTB2c4zRsWEup49bQu3UyQxG4bB
         87nNmP0LMXH0ne6hw5fMbsEiD+MpOJ5VKFxyFPQ4CXJay2h1ElMk8GvfZ19Fo2Kgp8FJ
         sc2TD3pAJhcpaGglqfamL0jhntNoGV+BmHMw0kbiAeBEyhlM9vT8JhVmKrJ6EAG0qF4y
         vPspjhOaroi4WsZS5co0g1K1l+cN/qhpaXGtDO8X3U393wBrQ+q3zqZYEM7HeeaX2qX9
         Pf2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786112135; x=1786716935; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MzS5XFrgTuiPjNnu38gbVxPmnnD5h/HbpvqKJVfoMMI=;
        b=Vxqrp1H3W7lDss+3/JdOl8YpDjax42CqChmA8tp84UAvP5jrpNRTVzvrdklCi3hlq9
         aqdkIGC0jMlPRwyEWktr1QlsqhR7bbCnQ3XGjsHSuJ77RKohnyUc9ObKajFp2lfPCsw7
         YuhAhTDZ8TE6CljHcBlNLz32EgW2YC0Tl1hnYSNy1rN++3RbYydMCWbirw6ljPTyKZJV
         t8ypbtuzfC9mvLl4fIhCi26bmqcrgfeBVNqhPzLsNDMQ/cO1klvovGlN5OuGenmtJanj
         Jm32TEx1fxBT5u3Ow7EGRB023C+B//BkstwuClXXIZHCZ/H4RMJJw1dZ7CfPdxRizZIV
         LAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786112135; x=1786716935;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MzS5XFrgTuiPjNnu38gbVxPmnnD5h/HbpvqKJVfoMMI=;
        b=YeKiq+OPabmDznw6NG+KOmBKJEOdTQRhCed1TMy6XL+v+LTDIx6FKp7qbLpg5g0U47
         cDFCf4AkxwkjZwzkHK9NfUuLYGwRkcC4At6u2QIf1fpw2SSY/Xu9bfHvXv6LYgqb1aM4
         eH3RbeokaFJ86RpJ912B41AuPTqeWaGMz7Qr7iBWUvcedv9sq1r1pTX1Nn6vIflYHBSw
         cIyBdQA4BJ3ImvmX2GZKmE4iqLSbpqoJUqaN+tpgHw/Xl8R4rkSC6Aw0A3D8hwIuEZQX
         tjhPNW2pB69pXAH87BDtP/hA2HvR/ogwGmuQK987bY2/hn3KDIY/U33uUfg7H94zvM1N
         l60A==
X-Forwarded-Encrypted: i=1; AHgh+RpwqzwB4yycqdoLcpxpZAkrmnOAayLO/7xxkJ9s1ruy45g7ut+MUkp+RneYU/T+QZDPrkOhJb3T5q25oxc21U+I@vger.kernel.org
X-Gm-Message-State: AOJu0YxZnUZWFoVjLhGiC123jxwAtRpecO+B4jZDQJr9O2URy9NBim+h
	08JCtOcgchbfyldzDMSvQ5OdOSsV3DhhaKSikFcyFaXz/PmlB8VhZAgcVseo5iWGjw3KUHQix8j
	FHlL90lNfYAyopjlRQnr6AQBbRi/wR94=
X-Gm-Gg: AR+sD12C0UX/Acy4R8x950XIKs7+upMgrmlboe8ts2OCGLbp3D0LdukeuJhCjm2mX1K
	6cuzgDzN2RjEb1G+x6I+5R46uIpLUzei3HmqH8IOBBKJ+bzRR/1OoZMIZEaOHcLDcduP237/rZR
	Ade01fNhaiuhhpOEDU4HSH/dM9KMZMUUC44IGH+Bvty7Ewu+14VtnkdbAzuj5G/Ch4WDy0cPrGN
	kewp5FEPgGpwMyRR841XzTHFblDmgYVit1AM9Um4GOjUuOVOSsjS53ftnKWSZCyJRi6lnQmhxJZ
	9vjqwplHDrxJAqPMQOT6sq7aqtZzkYieIBWEr8Uh7KfKjceGL+Wmnm/nJsoC
X-Received: by 2002:a17:907:a606:b0:c1f:df40:1d83 with SMTP id
 a640c23a62f3a-c2057e093demr807232966b.5.1786112134646; Fri, 07 Aug 2026
 07:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806135224.3267890-1-puranjay@kernel.org> <20260806135224.3267890-2-puranjay@kernel.org>
 <20260807093951.GS776954@noisy.programming.kicks-ass.net>
In-Reply-To: <20260807093951.GS776954@noisy.programming.kicks-ass.net>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 7 Aug 2026 15:15:21 +0100
X-Gm-Features: AUfX_mwZEiydqK_HU1_ia3MF27eq51puWHtYC7ZlluNhh2_0hfgI6nV6cPYk91Q
Message-ID: <CANk7y0hq3w+bRNmuT1PWvhZb=ob=6Y5keN7-25vRSbx5nxakNA@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] perf/core: Fix NULL pmu_ctx passed to pmu->sched_task()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Usama Arif <usama.arif@linux.dev>, 
	Will Deacon <will@kernel.org>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 10:40=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Aug 06, 2026 at 06:52:21AM -0700, Puranjay Mohan wrote:
> > perf_pmu_sched_task() returns early when cpuctx->task_ctx is set, and
> > cpc->task_epc is only non-NULL while a task context is scheduled in on
> > this CPU. __perf_pmu_sched_task() therefore always passes NULL:
> >
> >   Unable to handle kernel NULL pointer dereference at virtual address 0=
0
> >   pc : armv8pmu_sched_task+0x14/0x50
> >   Call trace:
> >    armv8pmu_sched_task+0x14/0x50 (P)
> >    perf_pmu_sched_task+0xac/0x108
> >    __perf_event_task_sched_out+0x6c/0xe0
> >
> > Pass &cpc->epc instead. __perf_init_event_pmu_context() sets its ->pmu
> > when the PMU is registered; ->ctx stays NULL until a CPU-wide event
> > attaches. That is enough here because armv8pmu_sched_task() is the only
> > in-tree implementation that dereferences the argument at all, and it
> > only reads ->pmu. The oops therefore needs BRBE, which arrived in v6.17=
.
> >
> > Fixes: bd2756811766 ("perf: Rewrite core context handling")
> > Cc: stable@vger.kernel.org
> > Acked-by: Usama Arif <usama.arif@linux.dev>
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  kernel/events/core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index b282de3e7d7ca..9815894b67e77 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -3907,7 +3907,8 @@ static void __perf_pmu_sched_task(struct perf_cpu=
_pmu_context *cpc,
> >       perf_ctx_lock(cpuctx, cpuctx->task_ctx);
> >       perf_pmu_disable(pmu);
> >
> > -     pmu->sched_task(cpc->task_epc, task, sched_in);
> > +     pmu->sched_task(cpc->task_epc ? cpc->task_epc : &cpc->epc,
> > +                     task, sched_in);
>
> This can be written like: cpc->task_epc ?: &cpc->epc.
>
> However, if cpc-task_epc is always NULL, then this all seems like an
> overly complicated way of writing: &cpc->epc. What gives?

Nothing, you're right, it should just be &cpc->epc.

I wrote the ternary expecting patch 2 to make cpc->task_epc reachable
here, but it does not.

Will fix it in v7.

Thanks,
Puranjay
