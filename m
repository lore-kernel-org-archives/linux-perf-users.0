Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7B63EBF21
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185418; cv=pass; b=qBQaSRO6O/KGrfb/K2QEVpAfWdiT5nHYMAN0C/EFv1dmULoNw9wM1zqtYNUy4nLQJpcSwOiWMBw6EWeaGgQAeeTJsg9cDuQ7F+5RPIMI4iphEGKU9kkEoCrlhZb7jf8BhYn3VCV8Ce/jUPu3/BJ4Ap1PtkfdCNMDnnelHrUc82g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185418; c=relaxed/simple;
	bh=ViNjwM0/Tdf0mSKEjaK/akLoxYeSPLv8fqm3ebe4H/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMtH7J6pePdJxsMgBm+QvNCWhP5OVzpcYesxgM6haY4Y5AR0/kTnBMZs/qgwYFrhyMvJ3uVItnE9YwWHTNTIgXJ6GX1tyQOGUEVehI4abPEI571Ai0VLe0r73qhfZG3rd0UKy1QSOB8plp/MipXQ8M1ri6ZQdE92ldMqugFirxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oBIHVQSp; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oBIHVQSp"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a0d06cfa93so110055ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 08:23:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769185416; cv=none;
        d=google.com; s=arc-20240605;
        b=cMiGV8uPbrVaDr9nKXoGNDzw7kP5vx6FpwJ9g7GGfCUS4gYyX6LoZ5ngLG4MimfT3H
         s9nCXRp3c6AF39cWs4D5upz8v4b+cxjC4A/OXvfZpmClF0nwjiX4/L8uw0rKj2XA2cel
         mfA0a5NCIFqgeX7TIWErlfTVNh6CoOhRn2aEEwnz9rlP4YVLOpI4iqL2IXQGutWcDtoa
         LQCf1xLpgUC2r73F7P7+4r22wo3ezrSdRfOzgEGj/CPzY/J+vzsxeUGGTkoidC2GBKiX
         YNeWHLp2Q4kuNu6mVUTLzc7/soTNuaY4qd2BXeCYpMfjMB+Mw+m9xeDh5Y5+TqhLjKEe
         U5nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S2hn3fdJj6eNxHPuoNl7wVgTy9Qr/3XI1JI4auV0yxQ=;
        fh=XC7aAmW5ifx9EF7uhrtWQatvsL2x8wOV/NX8SnqKYvw=;
        b=j1qIqR2t2tn0P27TeXfd72QlKbJ/s2coSOYR9upu9AGHfBDS5LVeL/hzIDpewruWm7
         ctUn+wDY98h+oKwXNaE8Z1gIOd6aorrnaO6xD6vD1wi9Yof+K/1lO7lGX6YsxPNNAnxr
         rmIniDM22jgLna1oeFxuGV29zsMYhwAAhbtweKzRTM13AFNh84bSqyW7kLuyEb4lal+S
         oDxJ4k0Oo9aURNPMA4owENcVYGTCRJWgE3VWlYstsHRP9JeBN1UljEZ8Zk2w8aNTQErC
         Y2SFqmA1XaFM2TTGr612jldb+yY+9EMZ12V1xas2VOqghDHPa8j+FuweEneLi4J2tb8y
         JIBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769185416; x=1769790216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2hn3fdJj6eNxHPuoNl7wVgTy9Qr/3XI1JI4auV0yxQ=;
        b=oBIHVQSpvxS+eCwVSNu2JDC34KUu78sO8LW9bgnSTj1xFCcELv/h7Bb6GZa9v6sBG0
         njVxFO65P481aukrqWWoj0ZKrA2aM/8cxVT+2YhJ4OZkHYWoLo6EbPhDRfbFo3jb71oE
         y9BhkK57Yx1xmb+5VIRo1ENbT8CJjQhhrUUG7R6Ahp8MFhZzDjp3BqCX1brWPqXuseyj
         KtGVHZavPZwHy8EYibo8OqIVkxLbgEUYJz/N7QzZd2FwHmkTvvtGGHKMLLu+oyE7YPBN
         9In/rxw246dyjCTzmlkLkt2C65R+5bX/NAyR/zMP1VjkuGbPUo43f3gXU5H9pU4VgicQ
         xL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769185416; x=1769790216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S2hn3fdJj6eNxHPuoNl7wVgTy9Qr/3XI1JI4auV0yxQ=;
        b=Mz6QZc3g3NKHRnTxOnLSkDQxQtWtn3afYSDPpl9cq+0JNN0UHY7vmtmz5uYNR+TZbk
         k6Kd87t1xK6JHLED8RMdkNrNcVYhFy5hzL5WqgyrvYIcOSav7YYhIKzJRp/2gDZxEbQH
         roczQ94ilN8mtjMAWVhwI2k545kFBx+xndjoMAKF8gWW1EtD8DjiCHEo8IFzW+Yi3L2c
         ML/+tHUGbMjiB8vU4ohp8fdI9+xHtU9FyoPI1c73c+AF1FbTMcU5ZfZJg9glwK13S0Du
         rdGYwriOCM+wmA878OFKCOX3AZqUEWKUjCp04Y+HmmI9YHTB/OD9Gd9scwAvlBZ12I3C
         i7Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWXb1JyaXAD5VTWVaUioZlHzQwco+hoB3SbEBXi6ZK2TrpyGS57kOeWEb6hfsA1ZniLH//O6gxGyep9nTwbjxqG@vger.kernel.org
X-Gm-Message-State: AOJu0YxaMqiidFdMsdLTdR5zESQxBzbVZ7yeniryMPScB3pO37Nt2E7U
	cb/ICYQhAo49eIL8NIXONySvmU3m0oAHJ4vzox1WjTVyIw4RkVmVHqdixKi+PuorltFQLgK0/V+
	0Kln01fYh8D0npuWpu6PsSN79ZB+2LTf2KqNv24OD
X-Gm-Gg: AZuq6aKk9Qdbk0jg5hXdbu5KD2FnvxYU0Oyh0oc+pbMaaDRL48gEdAfrFqCqeaDhqzf
	g63DHNAkGaSMXB/0TvNtGm+sxZgNw/X8GYAsQW089hXnFBpc1vzEfZNSmKTx7fFnMNoqclKke46
	8t7FVymgBghSLScr4D17PAJi4UQUxQ5vN4bO6XlMHC0iLILse7z+LKlLayDdPPcN5COO2OqdPlC
	E+FNtg8Png6diDZcJFBWr9m2sWtfyqlXJckm+YuM5FeKVO6Tl0hCg6V7aMnXWkV9P3u27zrRqq3
	SHQeeBrCdVHYAFThW1B6dmuUgw==
X-Received: by 2002:a17:903:1a0b:b0:295:5405:46be with SMTP id
 d9443c01a7336-2a805c8d8f1mr3209455ad.1.1769185415383; Fri, 23 Jan 2026
 08:23:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120090522.1193981-1-qzhao@redhat.com> <CAATMXfkYH8w7sLpDSHTf1JRGdQiK5Ey8pX6u=5t+Nsi091SXgA@mail.gmail.com>
 <CAP-5=fWPpeLS2D_XgsyM5OYDvWkoTapSb0XfPu-K7ue31BCTCg@mail.gmail.com> <CAATMXfmz2BCAoRXFOgSMyLK+FEF=ac5g_ZabY2a8ie+ZYfHtrA@mail.gmail.com>
In-Reply-To: <CAATMXfmz2BCAoRXFOgSMyLK+FEF=ac5g_ZabY2a8ie+ZYfHtrA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 23 Jan 2026 08:23:24 -0800
X-Gm-Features: AZwV_QjUUvXwcEhIhc4XLDpJT6sxFHURcv-1CXTylPH-jJ_iU1haj1cnjtUmgeg
Message-ID: <CAP-5=fXUsY7vypQ13d_ohcX35txfVf7sMu6KN8Rbz8=UUEA4bQ@mail.gmail.com>
Subject: Re: [PATCH] perf tests: mmap: skip user counter tests when runtime
 PMU access is unavailable
To: Qiao Zhao <qzhao@redhat.com>, James Clark <james.clark@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>
Cc: namhyung@kernel.org, mpetlan@redhat.com, acme@kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 12:29=E2=80=AFAM Qiao Zhao <qzhao@redhat.com> wrote=
:
>
> Hi Ian,
>
> Thanks for the follow-up questions. I've gathered some additional data
> from the affected ARM systems.
> Environment:
> - Architecture: ARM (aarch64)
> - CPU: Ampere(R) Altra(R) Processor Q80-30
> - Tested on both bare-metal and ARM KVM guests
> - Observed behavior is identical on bare-metal and KVM
> - This is not a heterogeneous / big.LITTLE system
> - perf version: 6.19.rc6.g053966c344db
>
> rdpmc sysfs:
> On these systems, there is no rdpmc attribute exposed under the PMU devic=
es:
> # grep . /sys/bus/event_source/devices/*/rdpmc
> grep: /sys/bus/event_source/devices/*/rdpmc: No such file or directory
>
> So the =E2=80=9Crestricted PMU access=E2=80=9D I referred to is not due t=
o toggling a
> visible rdpmc sysfs knob.
> From a user-space perspective, there is simply no rdpmc control file avai=
lable.
>
> PMU devices:
> The core PMU present is:
> # grep . /sys/bus/event_source/devices/*/type | grep armv8
> /sys/bus/event_source/devices/armv8_pmuv3_0/type:10
> (Other devices are DSU/CMN/DMC PMUs.)
>
> Virtualization:
> The same rdpmc behavior is observed when running under ARM KVM,
> so this does not appear to be virtualization-specific.
>
> Observed inconsistency:
> Even though perf_event_open() succeeds with .config1=3D0x2 on aarch64,
> and the mmap page report
> cap_user_rdpmc=3D1, user-space rdpmc access fails at runtime, which is
> what causes the test to treat
> rdpmc as unsupported.
>
> At this point, I agree the key issue seems to be the mismatch between
> the reported capability (cap_user_rdpmc)
> and the actual runtime behavior, rather than perf_event_open()
> failing. I don't yet have enough insight to say
> whether this is an ARM PMU driver capability-reporting issue or an
> incorrect test assumption, but hopefully the
> above data helps narrow it down.
>
> Please let me know if more details would be useful.

That's pretty much every detail I could think to gather :-) I looked
on an Ampere machine and also noticed the rdpmc file is missing from
the  armv8_pmuv3_0 device. Perhaps James and Leo know about this?

In the test we care about the values of rdpmc_supported and
pc->cap_user_rdpmc. The rdpmc_supported value comes from:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/mmap-basic.c?h=3Dperf-tools-next#n298
```
if (saved_user_read_state =3D=3D USER_READ_UNKNOWN)
rdpmc_supported =3D pc->cap_user_rdpmc && pc->index;
else
rdpmc_supported =3D (enabled =3D=3D USER_READ_ENABLED);
```
In the test in the commit message I believe enabled is
USER_READ_ENABLED and as the rdpmc file is missing I think
saved_user_read_state is USER_READ_UNKNOWN. That confuses me then as
"if (!rdpmc_supported && pc->cap_user_rdpmc) {" being true means that
rdpmc_supported should be false.

Could you do me a favor and step through the test in gdb just to see
why rdpmc_supported is false?

Thanks,
Ian

 > Thanks,
> Qiao
>
> On Fri, Jan 23, 2026 at 2:02=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Thu, Jan 22, 2026 at 7:11=E2=80=AFPM Qiao Zhao <qzhao@redhat.com> wr=
ote:
> > >
> > > Hi Kim, Ian,
> > >
> > > Do you mind reviewing this change?
> > >
> > > On Tue, Jan 20, 2026 at 5:05=E2=80=AFPM Qiao Zhao <qzhao@redhat.com> =
wrote:
> > > >
> > > > On some platforms (e.g. ARM systems with restricted PMU access), us=
er space
> > > > PMU counters may be reported as supported but blocked at runtime. F=
ailing
> > > > the mmap interface tests in this case is incorrect.
> > > >
> > > > [Test Log]
> > > > 124.2: User space counter reading of instructions                  =
  : FAILED!
> > > > --- start ---
> > > > User space counter reading 0
> > > > User space counter reading for PMU armv8_pmuv3_0
> > > > User space counter reading for PMU armv8_pmuv3_0 [Failed unexpected=
 unsupported counter access 1]
> > > > ---- end ----
> > > > 124.3: User space counter reading of cycles                        =
  : FAILED!
> > > > --- start ---
> > > > User space counter reading 1
> > > > User space counter reading for PMU armv8_pmuv3_0
> > > > User space counter reading for PMU armv8_pmuv3_0 [Failed unexpected=
 unsupported counter access 1]
> > > > ---- end ----
> > > > [/Test Log]
> > > >
> > > > Skip the user counter mmap tests when runtime PMU access is not ava=
ilable,
> > > > while preserving failure for genuinely inconsistent states.
> > > >
> > > > Signed-off-by: Qiao Zhao <qzhao@redhat.com>
> > > > ---
> > > >  tools/perf/tests/mmap-basic.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-=
basic.c
> > > > index 3313c236104e..4881a641749b 100644
> > > > --- a/tools/perf/tests/mmap-basic.c
> > > > +++ b/tools/perf/tests/mmap-basic.c
> > > > @@ -308,9 +308,9 @@ static int test_stat_user_read(u64 event, enum =
user_read_state enabled)
> > > >                 }
> > > >
> > > >                 if (!rdpmc_supported && pc->cap_user_rdpmc) {
> > > > -                       pr_err("User space counter reading for PMU =
%s [Failed unexpected unsupported counter access %d]\n",
> > > > +                       pr_debug("User space counter reading for PM=
U %s is not supported (cap_user_rdpmc=3D%d), skipping!\n",
> > > >                                 pmu->name, pc->cap_user_rdpmc);
> > > > -                       ret =3D TEST_FAIL;
> > > > +                       ret =3D TEST_SKIP;
> >
> > Hi Qiao,
> >
> > It sounds like the ARM behavior is divergent from the Intel behavior,
> > but that said Intel hybrid rdpmc is known to be problematic. There's a
> > fix for part of that which will hopefully land [1]. One weird thing on
> > Intel hybrid is that the rdpmc permission file within the PMU is kind
> > of "shared" between all core PMUs, so disabling rdpmc on the e-core
> > PMU disables it on the p-core. In one iteration of this test tried to
> > incorporate support for this. Anyway, ARM...
> >
> > So in the test we're doing:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/tests/mmap-basic.c?h=3Dperf-tools-next#n243
> > ```
> > #ifdef __aarch64__
> > .config1 =3D 0x2, /* Request user access */
> > #endif
> > ```
> > So 1 question is why the perf_event_open is succeeding with a request
> > user access bit set in the config in a system where this is blocked?
> >
> > I'm not sure on the support for the rdpmc file on ARM but it looks to
> > be wired up:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/drivers/perf/arm_pmuv3.c?h=3Dperf-tools-next#n324
> >
> > So in the test where you've changed it we've determined that rdpmc
> > shouldn't be supported but the shared page is saying the
> > cap_uesr_rdpmc is available. So is this an ARM PMU driver bug?
> > I wonder if the setting of cap_user_read:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/drivers/perf/arm_pmuv3.c?h=3Dperf-tools-next#n1615
> > should also be testing whether support has been disabled through the
> > rdpmc attribute? Hmm.. but x86 doesn't do that:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/arch/x86/events/core.c?h=3Dperf-tools-next#n2753
> >
> > So given that ARM and x86 look in sync, x86 doesn't have issues I'm
> > aware of, and it certainly looks like a failure inconsistency that the
> > test thinks that user rdpmc support is disabled but the page says
> > otherwise. I could use more details to understand this, like what's
> > the contents of the rdpmc file? In your commit message, is the
> > restricted PMU access the rdpmc file or a different capability? Could
> > this be a weird hybrid/BIG.little issue like on x86?
> >
> > Thanks,
> > Ian
> >
> > [1] https://lore.kernel.org/lkml/24bc287a-a3e0-45f6-a8f1-20a34e2f9af2@l=
inux.intel.com/
> >
> > > >                         goto cleanup;
> > > >                 }
> > > >
> > > > --
> > > > 2.49.0
> > > >
> > >
> >
>
