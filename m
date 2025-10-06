Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30291DB12E
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Oct 2025 20:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759782131; cv=none; b=FEUN+jfbGrrD5oIAh7vW9nqs0eXdAdgwA51ZZCebHXS9Gu+HPd8ALpBib2h14YX9zGSawDENty0K7C1axv4kMxIvLWvuMVZ/M3HR0Dno+rFzGq0Lo5/yiTWuCs4agD5Tg7DPHD9kPb1z7s9s1mcNK62nz0ksVNhqaVYXUJSdqjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759782131; c=relaxed/simple;
	bh=mZM1Xn5JzqNdx8PftFwZgA/rtD9tl1Yh1zasby46P9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AgVwYea98GvS/toY2TOYhz6Dmv93bdfz9JaDXzHPj/LSE8ynfSwKODwbxQ11hyE1I06YiPs8r01Wa17cK71tErlBeM4K463cyXcL14mxQhN1eeWHsqQ+Pl8FmjAJ3jd7TyUmUcgAwnXXuYtEo7TdF3a43bvAxI7mZIMScTbzt34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kXlODcK5; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kXlODcK5"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3322e63602eso7034683a91.0
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Oct 2025 13:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759782125; x=1760386925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQJdZyQhMwY/lhMG4TcQTIvMno90NamMQAcddd5OC2Q=;
        b=kXlODcK5ooneTjI5DuwbVJ/BAoha0IIT8qLzh6l2b56KPquYxGx0QNXGXh8+hFDtuf
         YIfI2rtN87A8tLLaeVJ4VBcATaYni0ULSEpylWzUqtgL8mg4ND2R5rYdz8N+f0Qo+IkZ
         YNJiRrsgzo6ZH0uKmNOLUjuID57yo4j8cz2ZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759782125; x=1760386925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQJdZyQhMwY/lhMG4TcQTIvMno90NamMQAcddd5OC2Q=;
        b=pI9MQrIKiJ9DRS7UxCtkHg1ANXAivwVwhIajxy61ZzwYvWmiyrNZlbU3Sa2G7+QsIF
         ea2q3flhD6IEHjJOtZbdGsUVV4iRBcYCebFVDV5D2YiZk9dMay0qWnpBNUT0TaG48hfb
         J4gLY2ZYKz2O3mC2hshZ5ia3EhimOgRHOp9bJ/Y8dRv+SALu9d8qZWxZWSY7FIWrvZs/
         UkM+KhVxv2Eps5i1uRkODLAyG2WChP0SrsQ4+NZg1/tEcQw9CdKFPiJIplPdu6nKX56v
         Rvs0DCqh3cayxq5JRO9PR5mAMEYwTofJSN5sF6cgzYBUQCS057K4fqTNwEUi1yMN1fU/
         lLdA==
X-Forwarded-Encrypted: i=1; AJvYcCV2dzqZSa64uqoeiWpDjd2fKgT/01REAguyXU5/+C4CTiIvtry00j4PcWKjACIqB0hyw4NbEqE6eDcuJKe0C/3S@vger.kernel.org
X-Gm-Message-State: AOJu0YzvgwK4cqXWaW8X1Z7WUmk3D8dfnoMCvnfza86kx9jSZaLuuEUm
	8Fndu165yHvTdCvhm2QmUzGLP9D+kDwljrzjqj8Dg0VHWg1S3mqJAIAPgWBocAUPhSmNmIHWqsj
	pIuc=
X-Gm-Gg: ASbGnctvDM/1ExWPrgqOOl8pmqZ1sI8DyfAVcrVw05iNO+W3Cd53jPJ0xxVAIAqa/kU
	Caked3s/EiS05uvfoPcFqmUfn3bzMPLrsSbyQC9as3xBEiWg0YNwnM03HaEM88PtY5VU/yU7h9S
	RmKm+xigEvSje5rgYWzKe9TpViW/g/tLDDA8gV1aJ9RevD5wFw+yUfH2nA4qxbTXeHiuSv+0wP3
	H9YzqOW5Wom1I+FPv8gBwDy4tgNQIoGB2P9Y9h/bWz5nYQosx1Ev7G72PWPsxU6n5nIefW0eZV6
	L2CqjOgbsJXbAc+P+chjNIJolDmOQ4bk4naEt6W4j6T3IL6DKCgDEmrsHpmXiXqAanI32OuibJ7
	dRWpFjDDYq3rO7KQXgRPFBt/nPIiFYdTmrdKCSFak4Bs1XbJ1PBzvRakfqsezAZEe48cNVcbQrs
	XifdxbhvMRoeKpBA==
X-Google-Smtp-Source: AGHT+IEbByCq2GlH0QXC6hcQVHIUAdk7NC/wI01BXsoULTPb8/Xj/tgy2Gdoyu/EooF1h5jwl/I6HQ==
X-Received: by 2002:a17:90b:1c04:b0:329:ca48:7090 with SMTP id 98e67ed59e1d1-339c27d2763mr18346553a91.37.1759782125127;
        Mon, 06 Oct 2025 13:22:05 -0700 (PDT)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com. [209.85.210.181])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ff27fbsm16943127a91.14.2025.10.06.13.22.04
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 13:22:04 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7800ff158d5so4567197b3a.1
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Oct 2025 13:22:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU292SjAp7et1n3LP0QoHJaRM4SqJqCkNX45W3eZAbg3XX+pEgMKwfNyyn2FSzyRgnun5Io7GCRL6FkeamgZKc4@vger.kernel.org
X-Received: by 2002:a17:902:da8b:b0:268:f83a:835a with SMTP id
 d9443c01a7336-28e9a6d01c7mr166290125ad.60.1759781642366; Mon, 06 Oct 2025
 13:14:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916145122.416128-1-wangjinchao600@gmail.com>
 <f932d6da-cd9c-4307-8877-eeb947a5c1a6@csgroup.eu> <aMpbOSN4DH09IPgD@mdev>
In-Reply-To: <aMpbOSN4DH09IPgD@mdev>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 6 Oct 2025 13:13:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WttSbhpct2bhwF+EHgisSZ2G+6G6chNebosmAUtmv9Hw@mail.gmail.com>
X-Gm-Features: AS18NWAjS9eb65vMivsZK8Ihu7dGX2eBE91P457m_KL2WK6DeqCInpBXFl0HmzQ
Message-ID: <CAD=FV=WttSbhpct2bhwF+EHgisSZ2G+6G6chNebosmAUtmv9Hw@mail.gmail.com>
Subject: Re: [RFC PATCH V1] watchdog: Add boot-time selection for hard lockup detector
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Peter Zijlstra <peterz@infradead.org>, 
	Will Deacon <will@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>, akpm@linux-foundation.org, 
	catalin.marinas@arm.com, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	kees@kernel.org, masahiroy@kernel.org, aliceryhl@google.com, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, xur@google.com, ruanjinjie@huawei.com, 
	gshan@redhat.com, maz@kernel.org, suzuki.poulose@arm.com, 
	zhanjie9@hisilicon.com, yangyicong@hisilicon.com, gautam@linux.ibm.com, 
	arnd@arndb.de, zhao.xichao@vivo.com, rppt@kernel.org, lihuafei1@huawei.com, 
	coxu@redhat.com, jpoimboe@kernel.org, yaozhenguo1@gmail.com, 
	luogengkun@huaweicloud.com, max.kellermann@ionos.com, tj@kernel.org, 
	yury.norov@gmail.com, thorsten.blum@linux.dev, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 16, 2025 at 11:55=E2=80=AFPM Jinchao Wang <wangjinchao600@gmail=
.com> wrote:
>
> On Wed, Sep 17, 2025 at 08:08:57AM +0200, Christophe Leroy wrote:
> >
> >
> > Le 16/09/2025 =C3=A0 16:50, Jinchao Wang a =C3=A9crit :
> > > Currently, the hard lockup detector is selected at compile time via
> > > Kconfig, which requires a kernel rebuild to switch implementations.
> > > This is inflexible, especially on systems where a perf event may not
> > > be available or may be needed for other tasks.
> > >
> > > This commit refactors the hard lockup detector to replace a rigid
> > > compile-time choice with a flexible build-time and boot-time solution=
.
> > > The patch supports building the kernel with either detector
> > > independently, or with both. When both are built, a new boot paramete=
r
> > > `hardlockup_detector=3D"perf|buddy"` allows the selection at boot tim=
e.
> > > This is a more robust and user-friendly design.
> > >
> > > This patch is a follow-up to the discussion on the kernel mailing lis=
t
> > > regarding the preference and future of the hard lockup detectors. It
> > > implements a flexible solution that addresses the community's need to
> > > select an appropriate detector at boot time.
> > >
> > > The core changes are:
> > > - The `perf` and `buddy` watchdog implementations are separated into
> > >    distinct functions (e.g., `watchdog_perf_hardlockup_enable`).
> > > - Global function pointers are introduced (`watchdog_hardlockup_enabl=
e_ptr`)
> > >    to serve as a single API for the entire feature.
> > > - A new `hardlockup_detector=3D` boot parameter is added to allow the
> > >    user to select the desired detector at boot time.
> > > - The Kconfig options are simplified by removing the complex
> > >    `HARDLOCKUP_DETECTOR_PREFER_BUDDY` and allowing both detectors to =
be
> > >    built without mutual exclusion.
> > > - The weak stubs are updated to call the new function pointers,
> > >    centralizing the watchdog logic.
> > >
> > > Link: https://lore.kernel.org/all/20250915035355.10846-1-cuiyunhui@by=
tedance.com/
> > > Link: https://lore.kernel.org/all/CAD=3DFV=3DWWUiCi6bZCs_gseFpDDWNkuJ=
MoL6XCftEo6W7q6jRCkg@mail.gmail.com/
> > >
> > > Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> > > ---
> > >   .../admin-guide/kernel-parameters.txt         |  7 +++
> > >   include/linux/nmi.h                           |  6 +++
> > >   kernel/watchdog.c                             | 46 ++++++++++++++++=
++-
> > >   kernel/watchdog_buddy.c                       |  7 +--
> > >   kernel/watchdog_perf.c                        | 10 ++--
> > >   lib/Kconfig.debug                             | 37 +++++++--------
> > >   6 files changed, 85 insertions(+), 28 deletions(-)
> > >
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Docume=
ntation/admin-guide/kernel-parameters.txt
> > > index 5a7a83c411e9..0af214ee566c 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -1828,6 +1828,13 @@
> > >                     backtraces on all cpus.
> > >                     Format: 0 | 1
> > > +   hardlockup_detector=3D
> > > +                   [perf, buddy] Selects the hard lockup detector to=
 use at
> > > +                   boot time.
> > > +                   Format: <string>
> > > +                   - "perf": Use the perf-based detector.
> > > +                   - "buddy": Use the buddy-based detector.
> > > +
> > >     hash_pointers=3D
> > >                     [KNL,EARLY]
> > >                     By default, when pointers are printed to the cons=
ole
> > > diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> > > index cf3c6ab408aa..9298980ce572 100644
> > > --- a/include/linux/nmi.h
> > > +++ b/include/linux/nmi.h
> > > @@ -100,6 +100,9 @@ void watchdog_hardlockup_check(unsigned int cpu, =
struct pt_regs *regs);
> > >   #endif
> > >   #if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
> > > +void watchdog_perf_hardlockup_enable(unsigned int cpu);
> > > +void watchdog_perf_hardlockup_disable(unsigned int cpu);
> > > +extern int watchdog_perf_hardlockup_probe(void);
> >
> > No 'extern' on function prototypes, this is pointless.
> Got it.
> >
> > >   extern void hardlockup_detector_perf_stop(void);
> > >   extern void hardlockup_detector_perf_restart(void);
> > >   extern void hardlockup_config_perf_event(const char *str);
> > > @@ -120,6 +123,9 @@ void watchdog_hardlockup_disable(unsigned int cpu=
);
> > >   void lockup_detector_reconfigure(void);
> > >   #ifdef CONFIG_HARDLOCKUP_DETECTOR_BUDDY
> > > +void watchdog_buddy_hardlockup_enable(unsigned int cpu);
> > > +void watchdog_buddy_hardlockup_disable(unsigned int cpu);
> > > +int watchdog_buddy_hardlockup_probe(void);
> > >   void watchdog_buddy_check_hardlockup(int hrtimer_interrupts);
> > >   #else
> > >   static inline void watchdog_buddy_check_hardlockup(int hrtimer_inte=
rrupts) {}
> > > diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> > > index 80b56c002c7f..85451d24a77d 100644
> > > --- a/kernel/watchdog.c
> > > +++ b/kernel/watchdog.c
> > > @@ -55,6 +55,37 @@ unsigned long *watchdog_cpumask_bits =3D cpumask_b=
its(&watchdog_cpumask);
> > >   #ifdef CONFIG_HARDLOCKUP_DETECTOR
> > > +#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
> > > +/* The global function pointers */
> > > +void (*watchdog_hardlockup_enable_ptr)(unsigned int cpu) =3D watchdo=
g_perf_hardlockup_enable;
> > > +void (*watchdog_hardlockup_disable_ptr)(unsigned int cpu) =3D watchd=
og_perf_hardlockup_disable;
> > > +int (*watchdog_hardlockup_probe_ptr)(void) =3D watchdog_perf_hardloc=
kup_probe;
> >
> > As this is set only once at startup, can we use static_call instead of
> > function pointers ?
> >
> > Also, can it me made __ro_after_init ?
> Not really, this is just an RFC patch, and there is no consensus yet.
> If it is included in the final consensus, I will handle it in the next ve=
rsion.
> >
> > > +#elif defined(CONFIG_HARDLOCKUP_DETECTOR_BUDDY)
> > > +void (*watchdog_hardlockup_enable_ptr)(unsigned int cpu) =3D watchdo=
g_buddy_hardlockup_enable;
> > > +void (*watchdog_hardlockup_disable_ptr)(unsigned int cpu) =3D watchd=
og_buddy_hardlockup_disable;
> > > +int (*watchdog_hardlockup_probe_ptr)(void) =3D watchdog_buddy_hardlo=
ckup_probe;
> > > +#endif
> > > +
> > > +#ifdef CONFIG_HARDLOCKUP_DETECTOR_MULTIPLE
> > > +static char *hardlockup_detector_type =3D "perf"; /* Default to perf=
 */

I'd still at least hope that "buddy" could be the default. While
"perf" can still be useful to catch some things that "buddy" can't,
"buddy" can also catch some things that perf can't so picking the
lower-overhead one as the default is perhaps better?


> I think we should first resolve the consensus issue:
> - Should we keep both perf and buddy watchdogs? (probably yes already)

Sounds like people want to keep perf, so "yes".


> - Should the watchdog type be changeable at boot time?

Seems like a good start.


> - Should the watchdog type be changeable at runtime?

If it was easy/possible then sure, but I don't think it's a giant deal
to have something like this only changeable at boot time, like your
patch does. The fact that your patch is pretty simple is definitely a
big win.


IMO it would be worth sending it out as a real patch.

-Doug
