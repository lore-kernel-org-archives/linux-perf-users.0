Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085EB31D75E
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779213201; cv=pass; b=Nk7lc47TgcwI72AaprNAO8Zbh5VymLL/jjReKxwzsP2koCfIK9knV41nBNHyopKYG40nFJqyRCttj8BjuVwL5QmJ3Bu/4mWLaXzIxMatCVg8eoFMyrWbaS2wPx4hfFRsbAnNHsc9wSQT6jv5OI2N/CwOSUiFUr7OGNqbADbZV4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779213201; c=relaxed/simple;
	bh=s6kynqQapv2M8Mfw6SCbM2K2wfASor00Gklx/uJ+KW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDOeLg4lRTfuD63G2gZmxpHgBfDFms9T4MGlLR9pAUmZlv4cRUiqobRRabulfp/5khb6LT6s8iKX7LOYCMiJ7tPLDovOn4QEBEltp9RBMy/M6tiv+UgAx6OOLVk13bvL1DamytAsoXFSUWkdCzhekzZq5xYeTsz+B/QQRFmmJxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=buQfTORD; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="buQfTORD"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c1a170a50so4843341c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 10:53:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779213199; cv=none;
        d=google.com; s=arc-20240605;
        b=e/O8q6qu2U+NDZeCbft87W8TyBvdlP/OjNJEvVDB1kdnC4xK4Ks8/fNw9q/NCXQ/Aw
         iAK0PowtZK/tF21x4oJpww2MObpiGu1FEv4wt16eJ2OiNCll1XA34sgCPOoVvzG4G1xj
         bg/a5MYpip2HvCL0Ip1coR+5ErIVyZ/zfFLN3uTzNduzYtKyTftQ4cUJQhzqiqUbqrEC
         WWV3ciwQG6+wI+unTaxgxKLNs3ebTW5wVF+63n5vv+z0DqmZVsRtUIeXBQokQFKRW3Sa
         fknhRXsi5aWIxUy376pzRfZNntsZ3CyGoWE58k2pCDrcPVGPF23B84vqDcBi0CPAbb+3
         GsHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hhVSSD50ggCL5CE1DJrtTH3XIz7IjpqkhacGjs78WPM=;
        fh=RoZEeNtTJvDVTkZqc0SJ8Pob39MnAHyfWtJz/EKWpfw=;
        b=Lst0BxM1jzReUPh9JjlDrbrY/1Dp/EG6TmoPM0A2c32XOz7ewEAiggu0KXnftqILMq
         4LT/op2gio8jtSUGLjzAv0wmPUn5ia8WGeoQK8x3OaHKHJ/RAnXJbmogzMA3NvVQuT7d
         8brF4Xf2G5eoqwEiYjgrtNM31H0hjhQtEgwBbYUqZNZtfm3asqCjZV7ywNGTkgO72UsD
         Ghy5OBH7vNLW95uolwjXeXNg7zp9JVnDyrG3XT6UHVbxPFJBebsIydMk/QGiCJBHxdIv
         ZDTf4jXYYaj/A9QvGMz9VeUhBYCAyLBn1BxAqLSHoYZ12QE7dBBlBLgWXWMUuxN6Rski
         7iHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779213199; x=1779817999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhVSSD50ggCL5CE1DJrtTH3XIz7IjpqkhacGjs78WPM=;
        b=buQfTORDMSVUUjxuj7a3OAUKKR4EDQ7nin6wc3rwMWtpnpa3leuEkgUoZknmOrOrOP
         8qGbUv60loORdTMBA/geTo3afzut/UXjZLSxFuRELF7p8XuiRdVgaP0Lk/pvsnNo5xee
         ehbLtRzEJ/mPH05YaKQdfQtVNwAL+PmrRh3h+HeeHn7FKtg1rVPtnPDMbRt2dXeRhQDK
         p6K4YxAnlMDSY658vmwPO4jfOL6OJsuITH0KHtv2jXqAHQChoo34mL8mLTeyEhLowfcN
         6O3w+j7tu/bE7ScCGflId84WxyjkbSkiRnOi8EGT0zo8sV6waHcTsnCGiIPBVoBBzjiP
         jIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779213199; x=1779817999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hhVSSD50ggCL5CE1DJrtTH3XIz7IjpqkhacGjs78WPM=;
        b=NCYMqO1JNnuxIdZf8PnbpsicKpobavxDUX2MQKiuG8zKEQ8oC8dK+fJ3JomdprTryN
         pjhOhtLacTMiduCg0oOAYALmcGtJcGvGpOMnIjF98l5UeFkXDXko6+YldC0gFMcXB5Lo
         A0M9YaU+BFMTc4pdrdbuBDXvt/+QmX/nL8givdaeHH+PCjtPfqAJGU1qWvwfr7MRRrC1
         b7FYj0KQ5VTqZ/vhLY5jGcK86tM/46gFJFNl+kgVs3AeOlGBes9R7GNq4+FFBJSUYmhi
         lB4u3QhqYp4StK3Ym09YVVwcYhxtjEya17z/VWDtuBciJdeSGf0lJDJOBkZo7vL+2uoB
         ynpw==
X-Forwarded-Encrypted: i=1; AFNElJ+kS4GWmn422oxuDugaOngpPSnXOgHVVWJOriv4KMeK9baqTwkyuqqTkOVUaFHSjLHnPJUVffa+FTa+uCYCQt8H@vger.kernel.org
X-Gm-Message-State: AOJu0YwePLKHdHerW19UR6b3SDarRsMzOS+Q1JGIYMQj7bUrRV3Ebxn0
	7uPbN+5qwVVPXNtlCTXq6gaMSsyWu1/erbNv1/eWt7vOwWym6Tw8Ly340JEOsUutIy/XMgU/vMR
	7wmFVXGXPS0yRCVW8JbjKRTnsQNn04OWdlOZRsscb
X-Gm-Gg: Acq92OHFcVoX13fcUEoWzYOPX7lQzr0ncgWpC3aeQtpA/5c78a5PQC5Qx/+PQWqrSs0
	X6JiNLaSb9ODKrW3PqHNMyJ/dKbK5ib9B1EkAbhKsHZJdHyzSWmGJqEap9Q8kngi5fbdBA+neIY
	D0S4YKOtYhyjFrKvgfa9dILvd2EDrWILcumn1TrTUwwvhK9efMUZLxWPHuulDi5n6sq2bCJG6ex
	CKE84X9c1oC393LNAHu5awPkWu0+y5zmB0h0hiMBFqBPRqscmBXZuiCxUP4bXBd1MfOAA0espML
	yS5tAh2Fd67P2KiVSR6rHWZy9RBzphAhKX/Mz0FLeqqJ2CL1
X-Received: by 2002:a05:7022:4596:b0:12d:ca32:5a7 with SMTP id
 a92af1059eb24-13504417740mr9357249c88.10.1779213198150; Tue, 19 May 2026
 10:53:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112051649.1113435-1-dapeng1.mi@linux.intel.com>
 <20260112051649.1113435-8-dapeng1.mi@linux.intel.com> <CAP-5=fXhWssLxjM9s=zai27CU1JbSpz1+GN1=6AM54YAqsqcww@mail.gmail.com>
 <fb9b5ae9-80ce-44ee-9f68-309948f59365@linux.intel.com>
In-Reply-To: <fb9b5ae9-80ce-44ee-9f68-309948f59365@linux.intel.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Tue, 19 May 2026 10:53:06 -0700
X-Gm-Features: AVHnY4J3JZ1B1O6TbvWNBo3cF7Fhj2pZ1F6rTmBX1kztJdyhgtExGgjfVsXTN8A
Message-ID: <CAJpZYjVrUHz=PR3qZd68i_gpRmfMSsoBVThXi4nuzryzfV_Pgw@mail.gmail.com>
Subject: Re: [Patch v2 7/7] perf/x86/intel: Add support for rdpmc user disable feature
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>, 
	Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, is the "update cap_user_rdpmc" patch already on lkml?

Thanks,
CT

On Mon, Mar 9, 2026 at 10:28=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 3/10/2026 8:04 AM, Ian Rogers wrote:
> > On Sun, Jan 11, 2026 at 9:20=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.int=
el.com> wrote:
> >> Starting with Panther Cove, the rdpmc user disable feature is supporte=
d.
> >> This feature allows the perf system to disable user space rdpmc reads =
at
> >> the counter level.
> >>
> >> Currently, when a global counter is active, any user with rdpmc rights
> >> can read it, even if perf access permissions forbid it (e.g., disallow
> >> reading ring 0 counters). The rdpmc user disable feature mitigates thi=
s
> >> security concern.
> >>
> >> Details:
> >>
> >> - A new RDPMC_USR_DISABLE bit (bit 37) in each EVNTSELx MSR indicates
> >>   that the GP counter cannot be read by RDPMC in ring 3.
> >> - New RDPMC_USR_DISABLE bits in IA32_FIXED_CTR_CTRL MSR (bits 33, 37,
> >>   41, 45, etc.) for fixed counters 0, 1, 2, 3, etc.
> >> - When calling rdpmc instruction for counter x, the following pseudo
> >>   code demonstrates how the counter value is obtained:
> >>         If (!CPL0 && RDPMC_USR_DISABLE[x] =3D=3D 1) ? 0 : counter_valu=
e;
> >> - RDPMC_USR_DISABLE is enumerated by CPUID.0x23.0.EBX[2].
> >>
> >> This patch extends the current global user space rdpmc control logic v=
ia
> >> the sysfs interface (/sys/devices/cpu/rdpmc) as follows:
> >>
> >> - rdpmc =3D 0:
> >>   Global user space rdpmc and counter-level user space rdpmc for all
> >>   counters are both disabled.
> >> - rdpmc =3D 1:
> >>   Global user space rdpmc is enabled during the mmap-enabled time wind=
ow,
> >>   and counter-level user space rdpmc is enabled only for non-system-wi=
de
> >>   events. This prevents counter data leaks as count data is cleared
> >>   during context switches.
> >> - rdpmc =3D 2:
> >>   Global user space rdpmc and counter-level user space rdpmc for all
> >>   counters are enabled unconditionally.
> >>
> >> The new rdpmc settings only affect newly activated perf events; curren=
tly
> >> active perf events remain unaffected. This simplifies and cleans up th=
e
> >> code. The default value of rdpmc remains unchanged at 1.
> >>
> >> For more details about rdpmc user disable, please refer to chapter 15
> >> "RDPMC USER DISABLE" in ISE documentation.
> >>
> >> ISE: https://www.intel.com/content/www/us/en/content-details/869288/in=
tel-architecture-instruction-set-extensions-programming-reference.html
> >>
> >> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >> ---
> >>  .../sysfs-bus-event_source-devices-rdpmc      | 40 ++++++++++++++++++=
+
> >>  arch/x86/events/core.c                        | 21 ++++++++++
> >>  arch/x86/events/intel/core.c                  | 26 ++++++++++++
> >>  arch/x86/events/perf_event.h                  |  6 +++
> >>  arch/x86/include/asm/perf_event.h             |  8 +++-
> >>  5 files changed, 99 insertions(+), 2 deletions(-)
> >>  create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-d=
evices-rdpmc
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-=
rdpmc b/Documentation/ABI/testing/sysfs-bus-event_source-devices-rdpmc
> >> new file mode 100644
> >> index 000000000000..d004527ab13e
> >> --- /dev/null
> >> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-rdpmc
> >> @@ -0,0 +1,40 @@
> >> +What:           /sys/bus/event_source/devices/cpu.../rdpmc
> >> +Date:           November 2011
> >> +KernelVersion:  3.10
> >> +Contact:        Linux kernel mailing list linux-kernel@vger.kernel.or=
g
> >> +Description:    The /sys/bus/event_source/devices/cpu.../rdpmc attrib=
ute
> >> +                is used to show/manage if rdpmc instruction can be
> >> +                executed in user space. This attribute supports 3 num=
bers.
> >> +                - rdpmc =3D 0
> >> +                user space rdpmc is globally disabled for all PMU
> >> +                counters.
> >> +                - rdpmc =3D 1
> >> +                user space rdpmc is globally enabled only in event mm=
ap
> >> +                ioctl called time window. If the mmap region is unmap=
ped,
> >> +                user space rdpmc is disabled again.
> >> +                - rdpmc =3D 2
> >> +                user space rdpmc is globally enabled for all PMU
> >> +                counters.
> >> +
> >> +                In the Intel platforms supporting counter level's use=
r
> >> +                space rdpmc disable feature (CPUID.23H.EBX[2] =3D 1),=
 the
> >> +                meaning of 3 numbers is extended to
> >> +                - rdpmc =3D 0
> >> +                global user space rdpmc and counter level's user spac=
e
> >> +                rdpmc of all counters are both disabled.
> >> +                - rdpmc =3D 1
> >> +                No changes on behavior of global user space rdpmc.
> >> +                counter level's rdpmc of system-wide events is disabl=
ed
> >> +                but counter level's rdpmc of non-system-wide events i=
s
> >> +                enabled.
> >> +                - rdpmc =3D 2
> >> +                global user space rdpmc and counter level's user spac=
e
> >> +                rdpmc of all counters are both enabled unconditionall=
y.
> >> +
> >> +                The default value of rdpmc is 1.
> >> +
> >> +                Please notice global user space rdpmc's behavior woul=
d
> >> +                change immediately along with the rdpmc value's chang=
e,
> >> +                but the behavior of counter level's user space rdpmc
> >> +                won't take effect immediately until the event is
> >> +                reactivated or recreated.
> >> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> >> index c2717cb5034f..6df73e8398cd 100644
> >> --- a/arch/x86/events/core.c
> >> +++ b/arch/x86/events/core.c
> >> @@ -2616,6 +2616,27 @@ static ssize_t get_attr_rdpmc(struct device *cd=
ev,
> >>         return snprintf(buf, 40, "%d\n", x86_pmu.attr_rdpmc);
> >>  }
> >>
> >> +/*
> >> + * Behaviors of rdpmc value:
> >> + * - rdpmc =3D 0
> >> + *    global user space rdpmc and counter level's user space rdpmc of=
 all
> >> + *    counters are both disabled.
> >> + * - rdpmc =3D 1
> >> + *    global user space rdpmc is enabled in mmap enabled time window =
and
> >> + *    counter level's user space rdpmc is enabled for only non system=
-wide
> >> + *    events. Counter level's user space rdpmc of system-wide events =
is
> >> + *    still disabled by default. This won't introduce counter data le=
ak for
> >> + *    non system-wide events since their count data would be cleared =
when
> >> + *    context switches.
> >> + * - rdpmc =3D 2
> >> + *    global user space rdpmc and counter level's user space rdpmc of=
 all
> >> + *    counters are enabled unconditionally.
> >> + *
> >> + * Suppose the rdpmc value won't be changed frequently, don't dynamic=
ally
> >> + * reschedule events to make the new rpdmc value take effect on activ=
e perf
> >> + * events immediately, the new rdpmc value would only impact the new
> >> + * activated perf events. This makes code simpler and cleaner.
> >> + */
> >>  static ssize_t set_attr_rdpmc(struct device *cdev,
> >>                               struct device_attribute *attr,
> >>                               const char *buf, size_t count)
> >> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core=
.c
> >> index dd488a095f33..77cf849a1381 100644
> >> --- a/arch/x86/events/intel/core.c
> >> +++ b/arch/x86/events/intel/core.c
> >> @@ -3128,6 +3128,8 @@ static void intel_pmu_enable_fixed(struct perf_e=
vent *event)
> >>                 bits |=3D INTEL_FIXED_0_USER;
> >>         if (hwc->config & ARCH_PERFMON_EVENTSEL_OS)
> >>                 bits |=3D INTEL_FIXED_0_KERNEL;
> >> +       if (hwc->config & ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE)
> >> +               bits |=3D INTEL_FIXED_0_RDPMC_USER_DISABLE;
> >>
> >>         /*
> >>          * ANY bit is supported in v3 and up
> >> @@ -3263,6 +3265,26 @@ static void intel_pmu_enable_event_ext(struct p=
erf_event *event)
> >>                 __intel_pmu_update_event_ext(hwc->idx, ext);
> >>  }
> >>
> >> +static void intel_pmu_update_rdpmc_user_disable(struct perf_event *ev=
ent)
> >> +{
> >> +       /*
> >> +        * Counter scope's user-space rdpmc is disabled by default
> >> +        * except two cases.
> >> +        * a. rdpmc =3D 2 (user space rdpmc enabled unconditionally)
> >> +        * b. rdpmc =3D 1 and the event is not a system-wide event.
> >> +        *    The count of non-system-wide events would be cleared whe=
n
> >> +        *    context switches, so no count data is leaked.
> >> +        */
> >> +       if (x86_pmu_has_rdpmc_user_disable(event->pmu)) {
> >> +               if (x86_pmu.attr_rdpmc =3D=3D X86_USER_RDPMC_ALWAYS_EN=
ABLE ||
> >> +                   (x86_pmu.attr_rdpmc =3D=3D X86_USER_RDPMC_CONDITIO=
NAL_ENABLE &&
> >> +                    event->ctx->task))
> >> +                       event->hw.config &=3D ~ARCH_PERFMON_EVENTSEL_R=
DPMC_USER_DISABLE;
> >> +               else
> >> +                       event->hw.config |=3D ARCH_PERFMON_EVENTSEL_RD=
PMC_USER_DISABLE;
> > AI code review flagged this, but I think the conditions are discussed
> > in the comments. Posting the AI review out just in case as I'm not
> > sure:
> >   If x86_pmu.attr_rdpmc =3D=3D X86_USER_RDPMC_CONDITIONAL_ENABLE (1) an=
d
> > this is a system-wide event, RDPMC_USER_DISABLE is set to block rdpmc
> > in user space. However, during x86_pmu_event_init(),
> > PERF_EVENT_FLAG_USER_READ_CNT is set because x86_pmu.attr_rdpmc is
> > non-zero. Since it is not cleared when RDPMC_USER_DISABLE is active,
> > arch_perf_update_userpage() will still set cap_user_rdpmc =3D 1. Does
> > this cause user space to mistakenly attempt rdpmc? If user space uses
> > rdpmc for the system-wide event, the hardware will return 0 due to the
> > RDPMC_USER_DISABLE bit, which might result in user space silently
> > reading garbage values instead of falling back to the read() syscall.
> > Would it make sense to clear cap_user_rdpmc when RDPMC_USER_DISABLE is
> > set?
>
> Yes, I suppose the comment makes sense. We can further update the
> cap_user_rdpmc  base on the RDPMC_USER_DISABLE bit. Thanks.
>
>
> >
> > Thanks,
> > Ian
> >
> >> +       }
> >> +}
> >> +
> >>  DEFINE_STATIC_CALL_NULL(intel_pmu_enable_event_ext, intel_pmu_enable_=
event_ext);
> >>
> >>  static void intel_pmu_enable_event(struct perf_event *event)
> >> @@ -3271,6 +3293,8 @@ static void intel_pmu_enable_event(struct perf_e=
vent *event)
> >>         struct hw_perf_event *hwc =3D &event->hw;
> >>         int idx =3D hwc->idx;
> >>
> >> +       intel_pmu_update_rdpmc_user_disable(event);
> >> +
> >>         if (unlikely(event->attr.precise_ip))
> >>                 static_call(x86_pmu_pebs_enable)(event);
> >>
> >> @@ -5863,6 +5887,8 @@ static void update_pmu_cap(struct pmu *pmu)
> >>                 hybrid(pmu, config_mask) |=3D ARCH_PERFMON_EVENTSEL_UM=
ASK2;
> >>         if (ebx_0.split.eq)
> >>                 hybrid(pmu, config_mask) |=3D ARCH_PERFMON_EVENTSEL_EQ=
;
> >> +       if (ebx_0.split.rdpmc_user_disable)
> >> +               hybrid(pmu, config_mask) |=3D ARCH_PERFMON_EVENTSEL_RD=
PMC_USER_DISABLE;
> >>
> >>         if (eax_0.split.cntr_subleaf) {
> >>                 cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_CO=
UNTER_LEAF,
> >> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event=
.h
> >> index 24a81d2916e9..cd337f3ffd01 100644
> >> --- a/arch/x86/events/perf_event.h
> >> +++ b/arch/x86/events/perf_event.h
> >> @@ -1333,6 +1333,12 @@ static inline u64 x86_pmu_get_event_config(stru=
ct perf_event *event)
> >>         return event->attr.config & hybrid(event->pmu, config_mask);
> >>  }
> >>
> >> +static inline bool x86_pmu_has_rdpmc_user_disable(struct pmu *pmu)
> >> +{
> >> +       return !!(hybrid(pmu, config_mask) &
> >> +                ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE);
> >> +}
> >> +
> >>  extern struct event_constraint emptyconstraint;
> >>
> >>  extern struct event_constraint unconstrained;
> >> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/=
perf_event.h
> >> index 0d9af4135e0a..ff5acb8b199b 100644
> >> --- a/arch/x86/include/asm/perf_event.h
> >> +++ b/arch/x86/include/asm/perf_event.h
> >> @@ -33,6 +33,7 @@
> >>  #define ARCH_PERFMON_EVENTSEL_CMASK                    0xFF000000ULL
> >>  #define ARCH_PERFMON_EVENTSEL_BR_CNTR                  (1ULL << 35)
> >>  #define ARCH_PERFMON_EVENTSEL_EQ                       (1ULL << 36)
> >> +#define ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE       (1ULL << 37)
> >>  #define ARCH_PERFMON_EVENTSEL_UMASK2                   (0xFFULL << 40=
)
> >>
> >>  #define INTEL_FIXED_BITS_STRIDE                        4
> >> @@ -40,6 +41,7 @@
> >>  #define INTEL_FIXED_0_USER                             (1ULL << 1)
> >>  #define INTEL_FIXED_0_ANYTHREAD                        (1ULL << 2)
> >>  #define INTEL_FIXED_0_ENABLE_PMI                       (1ULL << 3)
> >> +#define INTEL_FIXED_0_RDPMC_USER_DISABLE               (1ULL << 33)
> >>  #define INTEL_FIXED_3_METRICS_CLEAR                    (1ULL << 2)
> >>
> >>  #define HSW_IN_TX                                      (1ULL << 32)
> >> @@ -50,7 +52,7 @@
> >>  #define INTEL_FIXED_BITS_MASK                                  \
> >>         (INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER |            \
> >>          INTEL_FIXED_0_ANYTHREAD | INTEL_FIXED_0_ENABLE_PMI |   \
> >> -        ICL_FIXED_0_ADAPTIVE)
> >> +        ICL_FIXED_0_ADAPTIVE | INTEL_FIXED_0_RDPMC_USER_DISABLE)
> >>
> >>  #define intel_fixed_bits_by_idx(_idx, _bits)                   \
> >>         ((_bits) << ((_idx) * INTEL_FIXED_BITS_STRIDE))
> >> @@ -226,7 +228,9 @@ union cpuid35_ebx {
> >>                 unsigned int    umask2:1;
> >>                 /* EQ-bit Supported */
> >>                 unsigned int    eq:1;
> >> -               unsigned int    reserved:30;
> >> +               /* rdpmc user disable Supported */
> >> +               unsigned int    rdpmc_user_disable:1;
> >> +               unsigned int    reserved:29;
> >>         } split;
> >>         unsigned int            full;
> >>  };
> >> --
> >> 2.34.1
> >>
>
