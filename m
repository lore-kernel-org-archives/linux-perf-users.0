Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EB5429833
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 22:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777500930; cv=pass; b=qrIg7hDsU/5XrcxrGcKd+sR2nPygSRQdJ2qpnbpwn81GsfuvkJ5ACv8bgET4kRCLHXHDmdvDlesR5ymHZHhscgdN1oiNcLhRFOuBV5Ijh/bRZMWYhtCiFKtVZvytJqLCwA0btKXQ9GZTE0ytk3ACol2qYLxLAVfcT4MKf3l0NU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777500930; c=relaxed/simple;
	bh=m83IizEOwwGKM+aHir3tx/yvJGN31WrRGDPv56uM4tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e2nzCnyOU/9mx6cWSt2zIfoUcgNvvBY5p13eRUGppfNqX86hj8ZoZ1zjSsgl+vVyjgjZU7AZe8WmZdgOa9tbVuyrHHBD1MRnd38velN3aPOB/w/BC4Z17/JmH08M/gI3l01kNOj2XC5I8JbHY9BLdiTFRW6O5BDf67G+9NgyuFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s0nF05aS; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s0nF05aS"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-126ea4e9697so2300c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 15:15:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777500928; cv=none;
        d=google.com; s=arc-20240605;
        b=lGf00SwF67UdJJBg4M0o9TWbB3bXC0vB32TZtQ0EANj/iShxqY9Yxf/FhyW8dVM0B4
         sXdHJ11AZBAqXTfnM+Mzl+xQRWAKvBozvvZELzemQ2elUw9zQ9Tkt8gN8HXGLUeAOvRb
         /3lSR9Zd7G1Q8d1o/XxtDq3HHI2pPKcjla1ZsmnYyJgIlub08hiw4dV8zUL4h+WZnoV4
         dunePkgd9rm1xZ9X3EDOT4Odg59P/1v+rS3Zk/MwUCf9TMiaAbfrvlrzf2wiTouq19bl
         DZTZYJuHxeg2GB88aSjCCzRBYK2u0/5zJqiQPuIpF1SJmazkAwnbGAcKwu40wdq3UM4l
         SAUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HRbTbvakHZziSVVZIYW/VVFsigOa7O79j5hW663J3fM=;
        fh=/iBR1TStOI1RFYA/FagE2qBiAjP+9v8xD82O1DL1Jcc=;
        b=FPq2OkUDakfsjhCX3OzIkr1ce8pABDYlkbP3OOIlDO9jWe1RqR8Ytr1P+ZkvqbrvZ9
         n4ZHG/shQBuKopdm43pbNOjamsFhHa6Gsab+FGOzpKsSyOxL0aAXiyxeiH5xc/BVz1YM
         nPGJ7VCOmq3WPow0iMvhtD9eMfxUEkNcfchpttQtJhU8ngOhQy4Qzci870HkR+X9kHUW
         WXK7UmBgWmJctkk5RJwh7FvPGGdz3BVKMa8sTycoTCXlVsKFLXL3sSAkOE7+ZgN5/oZm
         E5izEplCQtLtIsssBI2fpySOM2r8mYO7er0tihpL6TvaV7eK7cagHCJ8INRD5l6bepC9
         LtkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777500928; x=1778105728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRbTbvakHZziSVVZIYW/VVFsigOa7O79j5hW663J3fM=;
        b=s0nF05aSCQmzmtONKFitDVWk9BWPV67z/+wyk1mMH5rTyrGOBkxTs6DRztaVIdpOgp
         Asezh8UuARtTwh7mu16wgflCpOQp/dXFs5EzqQyzNpXwZByxGMTxtz+7Sii0pD0lYRRV
         V1RflCY046+6uKDnI6Q/4+6om2T2GIT3wk0PuwZtgJDuPKJ2WxsPQQGt/ik5xGEdTj20
         ynNAJLRnKQurJKzzzFGP/D02Ab1KjPCgfPhYHm0LpfQXZaFTYzp9neJvROmGiPt0Nuly
         mPeYAUw4yFwdH0ExIr9DDq82NI5KeYY8YtaByivKg/LgMv6yYCeIGxmb91/ojICkR0I7
         +ZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777500928; x=1778105728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HRbTbvakHZziSVVZIYW/VVFsigOa7O79j5hW663J3fM=;
        b=j6kgNxplr439Oe905gZMnV+4n/YtqYOfKdJGfnKpnVCHnEQtD5eWY87kZcfCqnJhp/
         Tw0LppsHy/uTYSyeyx2ePorCEhEt4CubapyCltfuHN7puhUBFmPHzpvpScszbviir21Y
         22ipv+cJ9GtBFBB5pPdzQ8GLeAsy7fQdEhI0JsVLVzKaKUHTg12pzJgYo7RsHrEgyru7
         r1RXD7t1keK8UUGVy4pOnyHMBSN//FvM709CZ1cw9Fefu8ELqYROFXHCilK+7E/6LSbD
         ezoTp6HZygErUoCIdBFb3iRHdGWbGJJJ5/yyqbBYrlIXUMaRRntGzLzUZFkr9PX3neT4
         iSMA==
X-Forwarded-Encrypted: i=1; AFNElJ+H+HMm4k2HmvITcV1bqhH1k77fumbuJ4Q95nPmh9DVFaFU4ths6pDZIA7XoV/kiMSDFik19Z6xL+1hH5LpKgMC@vger.kernel.org
X-Gm-Message-State: AOJu0YyCuIea+beZ8JcremNK4NWkB6QyCcsXXLZoeZjNLomEu4KkUZbY
	7/wAYhd80Jg/9TNOhXj1ChSMSPyoJdxc7xqPar0FCdWc4T8RhkJuzi0+L8ze0ZXxwbcKfsYEzAX
	jWMQRYzoYc3+SMiFc+XoQkdCfQ+dkYAawjskKkZkL
X-Gm-Gg: AeBDietwynxHl7Q6b3qcCukPo0PQ8Ghpif1uYvubhQeXn9CxGLUSIihujTh0b3TNK0t
	8paVQ/MND6+Dly0l3ZdT23sIkxBR6Veg8f0j/l8VbsnO0NW+UvAGxhKqZrE7HCGm8BY2nICLSay
	U8Gzft4lCJAPFxxItcZF3V35olpHVzAKvJqSF+YGxFY0kQe1p7S3Pfkf/GUEXQfzetuwkdPA+q3
	x1HrTK0Ft3HsImlyVd1J+D4a7zu+2siMSP5/30Dd1CxaqaFRYRkd0k/2HW1nkBExLONWKMYxqqx
	KY8lzVhIOrqo5r+0EPE3WY4zgkzRsSh2IdFPs2jNF9pAnoPzVqCGUBUNijg=
X-Received: by 2002:a05:7022:497:b0:12c:8f55:cd0d with SMTP id
 a92af1059eb24-12de9e25c39mr124783c88.8.1777500927567; Wed, 29 Apr 2026
 15:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777483573.git.calvin@wbinvd.org> <33d87384aa5f96af76949d1399476779dd4f4fce.1777483573.git.calvin@wbinvd.org>
 <afKBd87b4AKbCYuL@mozart.vkv.me>
In-Reply-To: <afKBd87b4AKbCYuL@mozart.vkv.me>
From: Ian Rogers <irogers@google.com>
Date: Wed, 29 Apr 2026 15:15:15 -0700
X-Gm-Features: AVHnY4LD4U3hnJzUV5c516BO-hUn9YxzrhObIrDeXmzI_7me3FVhC2OFhEf_PGk
Message-ID: <CAP-5=fU14AN8XA5CMWGpi0=9wDV7Ev3AA=ouO2DhA5AHH2wU2g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf: Don't throttle based on NMI watchdog events
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 3:09=E2=80=AFPM Calvin Owens <calvin@wbinvd.org> wr=
ote:
>
> On Wednesday 04/29 at 20:38 +0000, sashiko-bot@kernel.org wrote:
> > > @@ -636,6 +639,19 @@ void perf_sample_event_took(u64 sample_len_ns)
> > >     if (avg_len <=3D max_len)
> > >             return;
> > >
> > > +   /*
> > > +    * Very infrequent events like the perf counter hard watchdog
> > > +    * can trigger spurious throttling: skip throttling if the prior
> > > +    * NMI got here more than one second before this NMI began. But
> > > +    * never skip throttling if NMIs are nesting, or if any NMI runs
> > > +    * for longer than one second.
> > > +    */
> > > +   now =3D local_clock();
> > > +   last =3D __this_cpu_read(last_throttle_clock);
> > > +   if (__this_cpu_cmpxchg(last_throttle_clock, last, now) =3D=3D las=
t &&
> >
> > On 32-bit architectures, is it safe to use __this_cpu_cmpxchg() on a 64=
-bit
> > value in NMI context?
> >
> > For architectures like 32-bit x86, the generic fallback implementation
> > achieves atomicity by disabling interrupts, which does not mask NMIs. I=
f a
> > nested NMI interrupts the sequence halfway through reading or writing t=
he
> > 32-bit halves of the u64, could this result in a torn read or write?
> >
> > A corrupted timestamp could cause a massive wrap-around in the time gap
> > calculation, perpetually satisfying the > NSEC_PER_SEC bypass condition=
 and
> > silently disabling PMU throttling for all events on that CPU.
> >
> > > +       now - last > NSEC_PER_SEC && sample_len_ns < NSEC_PER_SEC)
>
> If this is a problem, isn't it also a problem for the 64-bit store after
> updating the EWMA just above this?
>
> I guess last_throttle_clock could be a u32 and use the low clock bits,
> that's sufficient with the one second limit... but I would appreciate a
> real human opinion :)
>
> > The comment indicates the intent is to skip throttling if the prior NMI
> > occurred more than one second before this NMI began.
>
> My comment is not very clear, I suppose. It should say:
>
>     "...skip throttling if the prior attempt to throttle occurred more
>     than one second ago, and the current NMI runtime was less than one
>     second. But never skip throttling if NMIs are nesting."
>
> > However, local_clock() is sampled at the end of the current NMI, so now
> > includes the current NMI's duration.
> >
> > If an NMI takes a very long time (e.g., 900ms) but started only 200ms a=
fter
> > the previous NMI ended, the true gap before it began is 200ms. Because =
now
> > includes the 900ms duration, now - last evaluates to 1100ms, which bypa=
sses
> > the throttling.
> >
> > Could this artificially inflate the time gap for long-running NMIs,
> > directly defeating the throttling mechanism?
>
> I think it's just saying "the code doesn't do what the comment says",
> which is true. But what it is describing is sort of addressed below too.
>
> > Additionally, is it possible for user-defined PMU events with expensive
> > overhead (like heavy eBPF programs attached to slow tracepoints) to exp=
loit
> > this hardcoded frequency bypass?
>
> No, I don't think ebpf programs run in NMI context?

Unfortunately Sashiko isn't currently reading replied emails, but you
could copy-paste this feedback into an AI.

BPF programs can run in the NMI context, which means they can
introduce delays. I'm not familiar with all the side-effects of and
restrictions on this.

Thanks,
Ian

> > If an event triggers slower than 1Hz but takes a very long time to exec=
ute
> > (e.g., 999ms), both now - last > NSEC_PER_SEC and sample_len_ns <
> > NSEC_PER_SEC will be true.
> >
> > Such an event would bypass the moving average calculation and never be
> > throttled, allowing it to consume nearly 100% of the CPU while it runs =
and
> > violating the default 25% CPU time limit set by
> > sysctl_perf_cpu_time_max_percent.
>
> No matter where the limit is defined, NMIs firing at just under that
> limit will skip throttling. But I guess it could be something like:
>
>     now - last > NSEC_PER_SEC && sample_len_ns < NSEC_PER_MSEC
>
> ...to sort of costrain the worst case.
>
> But this all feels really arbitrary. I thought about using the watchdog
> interval sysctl minus some padding as the upper bound, but that seemed
> unnecessarily complicated.
>
> Maybe this second patch is just more trouble than its worth...
> especially if, as Andi noted earlier, the PMU watchdog is not long for
> this world...
>
> Thanks,
> Calvin
>
> > --
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.177748357=
3.git.calvin@wbinvd.org?part=3D2
