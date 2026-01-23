Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A4D3093AB
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 06:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769148142; cv=pass; b=EzVR+/hdSi8ef9iX7qCSf1z8g/84SRPUNM7dx1vhw1bv8TKz2UaRLE5uNPZdjvQpKbCJS7Rk5+W+CpPwzUOocDogF+xjM4NLa8BKPBV7FTxNjsl81yt6Hfv/XjpvEaXn8VZFg6gF+5rGEkK7A5T+8dlG7oxTzDkOgFcQc32Gvkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769148142; c=relaxed/simple;
	bh=YWl2uD2aW31jtcxTiBSs9Vnfsq8ZKLdpl5XMuy+uO7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vCYag6klxojAiiKN51v5dAKV0vZW9tndQ6EE7Ylde2/AdFxtUVLT5mwMgxUOwZKZK6sbdbsWQpD/DRGEOXVq+evWSJjp4xin2dfsA3FJCZc0Nx9V5DF0zim3u+AwfqGAIzD8sCmxNhoS/hnozy1r5RtoYuuByBpnEr3Dx+MXK28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZzNxLwni; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZzNxLwni"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a0d06cfa93so68075ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 22:02:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769148126; cv=none;
        d=google.com; s=arc-20240605;
        b=ItKu0AgjTyFfprZyxci8Tx2Tx2NDMyLMYaXJr4q31xRpGxYT5sG4hGDvxs6dFIyg/X
         G3QTgMZ5kyVukHWk7aZZxIS9A0wKu9+jzYl6YzBSI3FWHU2pcbwGpL+AlUHaI7r8KJS5
         vFabAAXzivls3ebkfNlSJal1P1Tosi7pfNDJ4+HNsU9ABdCQfdAQ7774Yk7H1zqR2U2B
         22kz3dBCMZygqBUFyAq6XaOUFZRxvuZr8vHc438kbroCwlA0adXUVMTU27FUNFCUTeLN
         N3PakolXAkmC/ZoW/Ur179EgCwRXVPgEwHY0GQz/BxavP+BMBZs/NtEf3g29VkJf7Etw
         L6Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EHkMNBILaNcI5ur+wYVKyfetzKUapUCt/XX8luIsmps=;
        fh=RrIpZMuF6prEOGnDU36ijMRg268P08X/l8uwqdzOX90=;
        b=FdNue/jrQKqSzX0tGoGk2tpaCSw5sufgi+mpbvgHqDgksPxnK5ACR0aT/eT1ifL6gR
         mdvrEG5FHPiUoPh5TCxQj9kAw4O/9QYiuTmh7DaOWvozu6jwu+vz9qU6DVq1AA9qW244
         /xgoC/peGLynpbivKehm4j8paaf0gRM/1DD+prtDFLFDb1+g4sQemOE9VLovGXG9AyOL
         JaiP3DLt+yTw5bpazwLnLli3aSnSrlc0b7BchhcXCXv838+IH03F81ebggkYGT+Ha2SL
         t2zxASTwDys9i3WX3bvLLtB+O3kLpKReSQ1iQ47LguImWtl+st6SVu/Rha9B+JqQ4IPj
         HUyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769148126; x=1769752926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHkMNBILaNcI5ur+wYVKyfetzKUapUCt/XX8luIsmps=;
        b=ZzNxLwniDg5Ntf78KyQ4bLX2CJUCBlwYBVAkpmLaej8Q0l2iZ1nG1axN3009pfVI+N
         5qEagjjJxZ03mx1JquMn+soaACJfuii8bLntmCatANuaovHiSg8TUbY9RL01rGxPdtPK
         obL3VIznacOn+JNMqQmqIGTb+zSIlC8K1lA3IC8ueab1MZDIEjr856TuD6ry8RumXyvX
         P3m/bWg359pnW8SR6JAYUI7LxqADgkkJLhJEZju8TblHwU63PDY2R7bTnVx+ph0VDlyB
         FdHl7OvuiqUdOu/PAjzhASMnSjd9SV/M2O8AjPEu6YOAvn02Ipvf8H+UQEIagWgabIhy
         1Zcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769148126; x=1769752926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EHkMNBILaNcI5ur+wYVKyfetzKUapUCt/XX8luIsmps=;
        b=GpQCruDq499uVTNfjy0BEcrAo9rqaArKIm8/6V5uMtV3GdRGAq8zdN8Z5TFGgQB8gh
         cNaw0gZVta0YPoH3rC5PxIMXWcEUBCbWy/IGRAL5UXyHHJkUDbOupy2R70k4tRGVJoXZ
         MKu1jQiEKh0bXlaVG6514q0vvCJhH3+MZHfgrOc5pWK3LcBUj8kZfeJN/J4oxHLgJHjX
         /ncRqJIw0uMuOkLwagrcCcy5sUCIGzPOZbqbBxDX/3XJa4KQ45ZEia8boGvLQkX3cyre
         bvLMTP0MgPKaRTrKBNks3mhAU7HqzIUWt8a7SYHqBoCCXGWyCnICMire1/NQcjDWaBrJ
         /i+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXH/FomL0V6cmU8Iw/8uZcg4rLuKls58DLadBAgRSHn4CSJkhyROzaA5G2sZGoebbT3g4k4VZmcReX/aCZ3HjdG@vger.kernel.org
X-Gm-Message-State: AOJu0YwDPE8eWUjqAIpTPLYpfAe2RNF5X03PLa/xKILlOvjhBPiNwiou
	xjDaBECdU4ePbLWMUGHKL2fTrO2ZTTY1qS6HrjqwVbzxvZox27YI8ClWb3vlWRU4MiYdvP2BLzc
	aMBclkjAWeuwNdWAhMs5hSPaiHIB60sjzdBZMwQUE
X-Gm-Gg: AZuq6aJUitjqhj6V42vhjfLwaTucdvEfY+6pdtEfKJf3GzGKLyA2T003UoYxiR8Ruih
	mqGx0IPgjEibiELIkmOiMt1ChB1Bu0DiLfWBYhzzugwEvCXf8X+bgsw15UjZuQjeMqIFx7vEafw
	9LCspuvKTewe3eBvJGek86z2zATtKRjEXJx8CaVNmzfm1LymJ6U98NZA+208YiyOCSE64FZc6nA
	p3yzUjv+wRd8dOdvlg33l+JuE2tRxbQtgBtn37m3ovnfyWJHooPI+yth3ZRczq/KJlhAR2a5IMD
	jzShmJQ=
X-Received: by 2002:a17:902:f607:b0:2a7:7ca1:8622 with SMTP id
 d9443c01a7336-2a805d13786mr1229455ad.11.1769148125279; Thu, 22 Jan 2026
 22:02:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120090522.1193981-1-qzhao@redhat.com> <CAATMXfkYH8w7sLpDSHTf1JRGdQiK5Ey8pX6u=5t+Nsi091SXgA@mail.gmail.com>
In-Reply-To: <CAATMXfkYH8w7sLpDSHTf1JRGdQiK5Ey8pX6u=5t+Nsi091SXgA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 22 Jan 2026 22:01:54 -0800
X-Gm-Features: AZwV_QiSqZhlkOVgbn_GLWoVXvB1aolLkxoCveENOA6Qt6BwPGa56ky8V4_stvk
Message-ID: <CAP-5=fWPpeLS2D_XgsyM5OYDvWkoTapSb0XfPu-K7ue31BCTCg@mail.gmail.com>
Subject: Re: [PATCH] perf tests: mmap: skip user counter tests when runtime
 PMU access is unavailable
To: Qiao Zhao <qzhao@redhat.com>, James Clark <james.clark@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>
Cc: namhyung@kernel.org, mpetlan@redhat.com, acme@kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 7:11=E2=80=AFPM Qiao Zhao <qzhao@redhat.com> wrote:
>
> Hi Kim, Ian,
>
> Do you mind reviewing this change?
>
> On Tue, Jan 20, 2026 at 5:05=E2=80=AFPM Qiao Zhao <qzhao@redhat.com> wrot=
e:
> >
> > On some platforms (e.g. ARM systems with restricted PMU access), user s=
pace
> > PMU counters may be reported as supported but blocked at runtime. Faili=
ng
> > the mmap interface tests in this case is incorrect.
> >
> > [Test Log]
> > 124.2: User space counter reading of instructions                    : =
FAILED!
> > --- start ---
> > User space counter reading 0
> > User space counter reading for PMU armv8_pmuv3_0
> > User space counter reading for PMU armv8_pmuv3_0 [Failed unexpected uns=
upported counter access 1]
> > ---- end ----
> > 124.3: User space counter reading of cycles                          : =
FAILED!
> > --- start ---
> > User space counter reading 1
> > User space counter reading for PMU armv8_pmuv3_0
> > User space counter reading for PMU armv8_pmuv3_0 [Failed unexpected uns=
upported counter access 1]
> > ---- end ----
> > [/Test Log]
> >
> > Skip the user counter mmap tests when runtime PMU access is not availab=
le,
> > while preserving failure for genuinely inconsistent states.
> >
> > Signed-off-by: Qiao Zhao <qzhao@redhat.com>
> > ---
> >  tools/perf/tests/mmap-basic.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basi=
c.c
> > index 3313c236104e..4881a641749b 100644
> > --- a/tools/perf/tests/mmap-basic.c
> > +++ b/tools/perf/tests/mmap-basic.c
> > @@ -308,9 +308,9 @@ static int test_stat_user_read(u64 event, enum user=
_read_state enabled)
> >                 }
> >
> >                 if (!rdpmc_supported && pc->cap_user_rdpmc) {
> > -                       pr_err("User space counter reading for PMU %s [=
Failed unexpected unsupported counter access %d]\n",
> > +                       pr_debug("User space counter reading for PMU %s=
 is not supported (cap_user_rdpmc=3D%d), skipping!\n",
> >                                 pmu->name, pc->cap_user_rdpmc);
> > -                       ret =3D TEST_FAIL;
> > +                       ret =3D TEST_SKIP;

Hi Qiao,

It sounds like the ARM behavior is divergent from the Intel behavior,
but that said Intel hybrid rdpmc is known to be problematic. There's a
fix for part of that which will hopefully land [1]. One weird thing on
Intel hybrid is that the rdpmc permission file within the PMU is kind
of "shared" between all core PMUs, so disabling rdpmc on the e-core
PMU disables it on the p-core. In one iteration of this test tried to
incorporate support for this. Anyway, ARM...

So in the test we're doing:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/mmap-basic.c?h=3Dperf-tools-next#n243
```
#ifdef __aarch64__
.config1 =3D 0x2, /* Request user access */
#endif
```
So 1 question is why the perf_event_open is succeeding with a request
user access bit set in the config in a system where this is blocked?

I'm not sure on the support for the rdpmc file on ARM but it looks to
be wired up:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/drivers/perf/arm_pmuv3.c?h=3Dperf-tools-next#n324

So in the test where you've changed it we've determined that rdpmc
shouldn't be supported but the shared page is saying the
cap_uesr_rdpmc is available. So is this an ARM PMU driver bug?
I wonder if the setting of cap_user_read:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/drivers/perf/arm_pmuv3.c?h=3Dperf-tools-next#n1615
should also be testing whether support has been disabled through the
rdpmc attribute? Hmm.. but x86 doesn't do that:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/arch/x86/events/core.c?h=3Dperf-tools-next#n2753

So given that ARM and x86 look in sync, x86 doesn't have issues I'm
aware of, and it certainly looks like a failure inconsistency that the
test thinks that user rdpmc support is disabled but the page says
otherwise. I could use more details to understand this, like what's
the contents of the rdpmc file? In your commit message, is the
restricted PMU access the rdpmc file or a different capability? Could
this be a weird hybrid/BIG.little issue like on x86?

Thanks,
Ian

[1] https://lore.kernel.org/lkml/24bc287a-a3e0-45f6-a8f1-20a34e2f9af2@linux=
.intel.com/

> >                         goto cleanup;
> >                 }
> >
> > --
> > 2.49.0
> >
>
