Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6EFC145
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Mar 2026 00:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773101070; cv=pass; b=DMGGcRwyelPGjOtebjAqGCmBNWoOazh5uA2pMFzU0S0tGjFc9yjqoAHLgKux3xcGv3JqdQallrloo8jFc5MZ5MvjgjTK4j8sxVQ3oWhP2+0yKJBHTxpyl5KOUHSXyYZ3KGyrmP0Y+hHMuJ6NH4asWTDh8+y4T3zZnPmqRjMumHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773101070; c=relaxed/simple;
	bh=dbasIhdVyBfgSSQe68mZjWvQHmsWt08DXqcUo6wrwt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T42uJwRbBf7WZljr8Uec9RvMsl/r5/LwdcCahZqIAh24C7J1Tfs0Cec9iDISPV1ypvqQ5tiH956SX+Lg1mebo1g8m/6VXN4ijj1NXlyQvcISa1BCS30SCxd/JyrJ7rCG64jz+pFwP+nYTtFf7aW25NPREVAqF/1i2XYtB9768TQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KHzKt659; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KHzKt659"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aea4ebb048so11825ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 17:04:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773101069; cv=none;
        d=google.com; s=arc-20240605;
        b=KOBrH1kkDXWCfgfXej2ERLcZpReD22mZXfJ+L/NNuknDK790lKRwQxlz5BeP6uOeBZ
         XQUjOwMJf2jVj1F8rJX4GL9itGPU0MzGPduGBnvwilaLAH5znbRRmBwCeKED9NvWl69u
         LC3WBFICq8TiRlTD3v1zlxnB2kQ0wZtsUMSRypUUVnUl78xQg4OtlxvPHwYzFz9FwirM
         2BblgtbRTmoL71bbEm6Zm+oGTNC9JN1U1en8GeYLkiIoBB2/+m41zPrrwzdKxAuN+NIg
         80dccZ2BXFxXA+DazA2ZUeHtYuW6xMVQFXvDHjzbw4rHrAxzjJ1s/k66dRaki5JiPd6h
         2xOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R09GUA22cCnTa2f6eno4HDE6ruIpT14MbpLjvTdlY1g=;
        fh=tb4QzbABQU5BdDw18v/Q2dcFIexew43J1g16Drm3GY4=;
        b=g9v7C5VoeZeRRRpKSIBnq27WWnQqZAUSpRHC8pa6DTT6T83yWdW6NQS+SQyv4U6gFo
         JsemO+oL7s8XOxOqzU9iaP8DrAMV7pjzlxd7c9+VyED8heZMJ1fAMGmUQ+O+Z75XWlp1
         T47AsQUwnnXnB9RvcYttCOQmfcOO4YVOsm3AQSSaPH13RVBJWRVOl63laUW+udOk/k1m
         Dmga34vDzQxUGcBUsRWAZGWXLDQVAFxBAeijnyHmYEtgLFDi8PXCVmwXwiimvzVWolY4
         n0JlqAf/+ySVvFcqOUZUPhocqXp2QDpuqBOeiZlXJeXF+6xM89vmXXmU3rXu9Seji5zB
         FLmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773101069; x=1773705869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R09GUA22cCnTa2f6eno4HDE6ruIpT14MbpLjvTdlY1g=;
        b=KHzKt659UWKRc4CM5vIvXspOWJXM74PM6ychTy5ADMLttvszogJB7IgUfIBhcr/FwF
         dLU7qXpNlN2c0OZj37YV/aHWvBYITw+Gc5OrkHMjfQuumwgCeh5tLefT3bqNn/N/XZ+H
         wGc4HZ85BYqTImA6GE4aakmq/gZPYpYSRCOtFybCB8n2On7Xap2LmlaFtmPtfmYyDP6y
         Yx8JkvtlirB1iY9203/6HqA9OPH19yq45drru3xX2qcWPh0Q+g9UJayf1Jr2dUHQqUUw
         9nqjSyhhv+7ZupLKHCY822kkuFJ5ENQQZknKwKNRCOmkRQOLeys7BkXQ3gHNmDM7wcYo
         THXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773101069; x=1773705869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R09GUA22cCnTa2f6eno4HDE6ruIpT14MbpLjvTdlY1g=;
        b=l0Uk5L3SEGCLMuetNkfU6dNHJl0jnl4J5TS8JgdMsWtm5fJR/chyr57a8K6GZ+tF4z
         yT5zhyhi24zsrzy1U2I48L3Y/szOdWoB92ucR0Ur6/V9TiC2cPHc9lj74KxZWn3top2L
         aYwCrBlbdbQ2y+I63AppTl6vG5HzTEixbSKOLXOrywC1ucoK/4QyVjKmwU6Va2pbCxIT
         1H9AZTDrLzjx3skFNtUE5Dp4U4Q8mHWHA3N0Zz3kdmR8qhwQvjGQCW3kRG48ni8H6TBX
         gthrK1/+KdRA4LWC8LQ2a4WNdUVCErOGLywnJEvKzxZGw4r0GcAv3x7zYEirgQQAmUUF
         Zp4w==
X-Forwarded-Encrypted: i=1; AJvYcCV4Q/hgcHQTzyMeZSgPrNk5iHyCYMlaCKGszzMKkg7BijvsYlJ8p6cQXrBVrnUsNvRw2B1RyE7r8zAHSa8fQ8RH@vger.kernel.org
X-Gm-Message-State: AOJu0YzDoY9HufgBTvCvqO/DoPHB+yjVQq9mJDOnje0yzuTtY+nXxBJ/
	KaTdbKXqa4B31WzankDAbrEnmB+Ap0p+bxSV2a1cjCseigTsLAZC390hBoBKDUh+udExLT5pi3v
	FvrUpW947S3lRUXDNeuJ7Xp5uwl5vmdqUyY+0ft3s
X-Gm-Gg: ATEYQzz783+yTYHRvebP5wyteWFaVNcR3N6anI7h846rEVvV6gYqapTFeG2FBWq2OMO
	z+s0uiqHnypemGbrGnvObgytPZpaSq3tsfW9rzvJBh++jTFWROYvsAraZX16BRnhp09Rfujm7du
	soAz1ShaBuk4RvaSmyNTQJt++tzCLIksYKosPxhUDDeaG08xykjFAZvtipOYpbpDtCu9lZGtaSd
	dHI+a6JkUm4wOQWsrjVpq8dVl/f4VqERpZIabC0DlVVAiAPfFF021MpDw6SnmB71YVhOzL2+oYm
	xuAL65/QBRkH05Z4hW6JlLEMHpgyg4hvo30=
X-Received: by 2002:a17:903:98f:b0:2a0:867c:60e2 with SMTP id
 d9443c01a7336-2aea458b21emr738905ad.19.1773101068335; Mon, 09 Mar 2026
 17:04:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112051649.1113435-1-dapeng1.mi@linux.intel.com> <20260112051649.1113435-8-dapeng1.mi@linux.intel.com>
In-Reply-To: <20260112051649.1113435-8-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 17:04:17 -0700
X-Gm-Features: AaiRm51CCZ5kbFquhN995BuADOfou746lNCfUcnEp8zsfiEKdqkXXLDXr5zFFEc
Message-ID: <CAP-5=fXhWssLxjM9s=zai27CU1JbSpz1+GN1=6AM54YAqsqcww@mail.gmail.com>
Subject: Re: [Patch v2 7/7] perf/x86/intel: Add support for rdpmc user disable feature
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>, 
	Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 9:20=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.intel.c=
om> wrote:
>
> Starting with Panther Cove, the rdpmc user disable feature is supported.
> This feature allows the perf system to disable user space rdpmc reads at
> the counter level.
>
> Currently, when a global counter is active, any user with rdpmc rights
> can read it, even if perf access permissions forbid it (e.g., disallow
> reading ring 0 counters). The rdpmc user disable feature mitigates this
> security concern.
>
> Details:
>
> - A new RDPMC_USR_DISABLE bit (bit 37) in each EVNTSELx MSR indicates
>   that the GP counter cannot be read by RDPMC in ring 3.
> - New RDPMC_USR_DISABLE bits in IA32_FIXED_CTR_CTRL MSR (bits 33, 37,
>   41, 45, etc.) for fixed counters 0, 1, 2, 3, etc.
> - When calling rdpmc instruction for counter x, the following pseudo
>   code demonstrates how the counter value is obtained:
>         If (!CPL0 && RDPMC_USR_DISABLE[x] =3D=3D 1) ? 0 : counter_value;
> - RDPMC_USR_DISABLE is enumerated by CPUID.0x23.0.EBX[2].
>
> This patch extends the current global user space rdpmc control logic via
> the sysfs interface (/sys/devices/cpu/rdpmc) as follows:
>
> - rdpmc =3D 0:
>   Global user space rdpmc and counter-level user space rdpmc for all
>   counters are both disabled.
> - rdpmc =3D 1:
>   Global user space rdpmc is enabled during the mmap-enabled time window,
>   and counter-level user space rdpmc is enabled only for non-system-wide
>   events. This prevents counter data leaks as count data is cleared
>   during context switches.
> - rdpmc =3D 2:
>   Global user space rdpmc and counter-level user space rdpmc for all
>   counters are enabled unconditionally.
>
> The new rdpmc settings only affect newly activated perf events; currently
> active perf events remain unaffected. This simplifies and cleans up the
> code. The default value of rdpmc remains unchanged at 1.
>
> For more details about rdpmc user disable, please refer to chapter 15
> "RDPMC USER DISABLE" in ISE documentation.
>
> ISE: https://www.intel.com/content/www/us/en/content-details/869288/intel=
-architecture-instruction-set-extensions-programming-reference.html
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  .../sysfs-bus-event_source-devices-rdpmc      | 40 +++++++++++++++++++
>  arch/x86/events/core.c                        | 21 ++++++++++
>  arch/x86/events/intel/core.c                  | 26 ++++++++++++
>  arch/x86/events/perf_event.h                  |  6 +++
>  arch/x86/include/asm/perf_event.h             |  8 +++-
>  5 files changed, 99 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devi=
ces-rdpmc
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-rdp=
mc b/Documentation/ABI/testing/sysfs-bus-event_source-devices-rdpmc
> new file mode 100644
> index 000000000000..d004527ab13e
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-rdpmc
> @@ -0,0 +1,40 @@
> +What:           /sys/bus/event_source/devices/cpu.../rdpmc
> +Date:           November 2011
> +KernelVersion:  3.10
> +Contact:        Linux kernel mailing list linux-kernel@vger.kernel.org
> +Description:    The /sys/bus/event_source/devices/cpu.../rdpmc attribute
> +                is used to show/manage if rdpmc instruction can be
> +                executed in user space. This attribute supports 3 number=
s.
> +                - rdpmc =3D 0
> +                user space rdpmc is globally disabled for all PMU
> +                counters.
> +                - rdpmc =3D 1
> +                user space rdpmc is globally enabled only in event mmap
> +                ioctl called time window. If the mmap region is unmapped=
,
> +                user space rdpmc is disabled again.
> +                - rdpmc =3D 2
> +                user space rdpmc is globally enabled for all PMU
> +                counters.
> +
> +                In the Intel platforms supporting counter level's user
> +                space rdpmc disable feature (CPUID.23H.EBX[2] =3D 1), th=
e
> +                meaning of 3 numbers is extended to
> +                - rdpmc =3D 0
> +                global user space rdpmc and counter level's user space
> +                rdpmc of all counters are both disabled.
> +                - rdpmc =3D 1
> +                No changes on behavior of global user space rdpmc.
> +                counter level's rdpmc of system-wide events is disabled
> +                but counter level's rdpmc of non-system-wide events is
> +                enabled.
> +                - rdpmc =3D 2
> +                global user space rdpmc and counter level's user space
> +                rdpmc of all counters are both enabled unconditionally.
> +
> +                The default value of rdpmc is 1.
> +
> +                Please notice global user space rdpmc's behavior would
> +                change immediately along with the rdpmc value's change,
> +                but the behavior of counter level's user space rdpmc
> +                won't take effect immediately until the event is
> +                reactivated or recreated.
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index c2717cb5034f..6df73e8398cd 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2616,6 +2616,27 @@ static ssize_t get_attr_rdpmc(struct device *cdev,
>         return snprintf(buf, 40, "%d\n", x86_pmu.attr_rdpmc);
>  }
>
> +/*
> + * Behaviors of rdpmc value:
> + * - rdpmc =3D 0
> + *    global user space rdpmc and counter level's user space rdpmc of al=
l
> + *    counters are both disabled.
> + * - rdpmc =3D 1
> + *    global user space rdpmc is enabled in mmap enabled time window and
> + *    counter level's user space rdpmc is enabled for only non system-wi=
de
> + *    events. Counter level's user space rdpmc of system-wide events is
> + *    still disabled by default. This won't introduce counter data leak =
for
> + *    non system-wide events since their count data would be cleared whe=
n
> + *    context switches.
> + * - rdpmc =3D 2
> + *    global user space rdpmc and counter level's user space rdpmc of al=
l
> + *    counters are enabled unconditionally.
> + *
> + * Suppose the rdpmc value won't be changed frequently, don't dynamicall=
y
> + * reschedule events to make the new rpdmc value take effect on active p=
erf
> + * events immediately, the new rdpmc value would only impact the new
> + * activated perf events. This makes code simpler and cleaner.
> + */
>  static ssize_t set_attr_rdpmc(struct device *cdev,
>                               struct device_attribute *attr,
>                               const char *buf, size_t count)
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index dd488a095f33..77cf849a1381 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3128,6 +3128,8 @@ static void intel_pmu_enable_fixed(struct perf_even=
t *event)
>                 bits |=3D INTEL_FIXED_0_USER;
>         if (hwc->config & ARCH_PERFMON_EVENTSEL_OS)
>                 bits |=3D INTEL_FIXED_0_KERNEL;
> +       if (hwc->config & ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE)
> +               bits |=3D INTEL_FIXED_0_RDPMC_USER_DISABLE;
>
>         /*
>          * ANY bit is supported in v3 and up
> @@ -3263,6 +3265,26 @@ static void intel_pmu_enable_event_ext(struct perf=
_event *event)
>                 __intel_pmu_update_event_ext(hwc->idx, ext);
>  }
>
> +static void intel_pmu_update_rdpmc_user_disable(struct perf_event *event=
)
> +{
> +       /*
> +        * Counter scope's user-space rdpmc is disabled by default
> +        * except two cases.
> +        * a. rdpmc =3D 2 (user space rdpmc enabled unconditionally)
> +        * b. rdpmc =3D 1 and the event is not a system-wide event.
> +        *    The count of non-system-wide events would be cleared when
> +        *    context switches, so no count data is leaked.
> +        */
> +       if (x86_pmu_has_rdpmc_user_disable(event->pmu)) {
> +               if (x86_pmu.attr_rdpmc =3D=3D X86_USER_RDPMC_ALWAYS_ENABL=
E ||
> +                   (x86_pmu.attr_rdpmc =3D=3D X86_USER_RDPMC_CONDITIONAL=
_ENABLE &&
> +                    event->ctx->task))
> +                       event->hw.config &=3D ~ARCH_PERFMON_EVENTSEL_RDPM=
C_USER_DISABLE;
> +               else
> +                       event->hw.config |=3D ARCH_PERFMON_EVENTSEL_RDPMC=
_USER_DISABLE;

AI code review flagged this, but I think the conditions are discussed
in the comments. Posting the AI review out just in case as I'm not
sure:
  If x86_pmu.attr_rdpmc =3D=3D X86_USER_RDPMC_CONDITIONAL_ENABLE (1) and
this is a system-wide event, RDPMC_USER_DISABLE is set to block rdpmc
in user space. However, during x86_pmu_event_init(),
PERF_EVENT_FLAG_USER_READ_CNT is set because x86_pmu.attr_rdpmc is
non-zero. Since it is not cleared when RDPMC_USER_DISABLE is active,
arch_perf_update_userpage() will still set cap_user_rdpmc =3D 1. Does
this cause user space to mistakenly attempt rdpmc? If user space uses
rdpmc for the system-wide event, the hardware will return 0 due to the
RDPMC_USER_DISABLE bit, which might result in user space silently
reading garbage values instead of falling back to the read() syscall.
Would it make sense to clear cap_user_rdpmc when RDPMC_USER_DISABLE is
set?

Thanks,
Ian

> +       }
> +}
> +
>  DEFINE_STATIC_CALL_NULL(intel_pmu_enable_event_ext, intel_pmu_enable_eve=
nt_ext);
>
>  static void intel_pmu_enable_event(struct perf_event *event)
> @@ -3271,6 +3293,8 @@ static void intel_pmu_enable_event(struct perf_even=
t *event)
>         struct hw_perf_event *hwc =3D &event->hw;
>         int idx =3D hwc->idx;
>
> +       intel_pmu_update_rdpmc_user_disable(event);
> +
>         if (unlikely(event->attr.precise_ip))
>                 static_call(x86_pmu_pebs_enable)(event);
>
> @@ -5863,6 +5887,8 @@ static void update_pmu_cap(struct pmu *pmu)
>                 hybrid(pmu, config_mask) |=3D ARCH_PERFMON_EVENTSEL_UMASK=
2;
>         if (ebx_0.split.eq)
>                 hybrid(pmu, config_mask) |=3D ARCH_PERFMON_EVENTSEL_EQ;
> +       if (ebx_0.split.rdpmc_user_disable)
> +               hybrid(pmu, config_mask) |=3D ARCH_PERFMON_EVENTSEL_RDPMC=
_USER_DISABLE;
>
>         if (eax_0.split.cntr_subleaf) {
>                 cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNT=
ER_LEAF,
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index 24a81d2916e9..cd337f3ffd01 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -1333,6 +1333,12 @@ static inline u64 x86_pmu_get_event_config(struct =
perf_event *event)
>         return event->attr.config & hybrid(event->pmu, config_mask);
>  }
>
> +static inline bool x86_pmu_has_rdpmc_user_disable(struct pmu *pmu)
> +{
> +       return !!(hybrid(pmu, config_mask) &
> +                ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE);
> +}
> +
>  extern struct event_constraint emptyconstraint;
>
>  extern struct event_constraint unconstrained;
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/per=
f_event.h
> index 0d9af4135e0a..ff5acb8b199b 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -33,6 +33,7 @@
>  #define ARCH_PERFMON_EVENTSEL_CMASK                    0xFF000000ULL
>  #define ARCH_PERFMON_EVENTSEL_BR_CNTR                  (1ULL << 35)
>  #define ARCH_PERFMON_EVENTSEL_EQ                       (1ULL << 36)
> +#define ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE       (1ULL << 37)
>  #define ARCH_PERFMON_EVENTSEL_UMASK2                   (0xFFULL << 40)
>
>  #define INTEL_FIXED_BITS_STRIDE                        4
> @@ -40,6 +41,7 @@
>  #define INTEL_FIXED_0_USER                             (1ULL << 1)
>  #define INTEL_FIXED_0_ANYTHREAD                        (1ULL << 2)
>  #define INTEL_FIXED_0_ENABLE_PMI                       (1ULL << 3)
> +#define INTEL_FIXED_0_RDPMC_USER_DISABLE               (1ULL << 33)
>  #define INTEL_FIXED_3_METRICS_CLEAR                    (1ULL << 2)
>
>  #define HSW_IN_TX                                      (1ULL << 32)
> @@ -50,7 +52,7 @@
>  #define INTEL_FIXED_BITS_MASK                                  \
>         (INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER |            \
>          INTEL_FIXED_0_ANYTHREAD | INTEL_FIXED_0_ENABLE_PMI |   \
> -        ICL_FIXED_0_ADAPTIVE)
> +        ICL_FIXED_0_ADAPTIVE | INTEL_FIXED_0_RDPMC_USER_DISABLE)
>
>  #define intel_fixed_bits_by_idx(_idx, _bits)                   \
>         ((_bits) << ((_idx) * INTEL_FIXED_BITS_STRIDE))
> @@ -226,7 +228,9 @@ union cpuid35_ebx {
>                 unsigned int    umask2:1;
>                 /* EQ-bit Supported */
>                 unsigned int    eq:1;
> -               unsigned int    reserved:30;
> +               /* rdpmc user disable Supported */
> +               unsigned int    rdpmc_user_disable:1;
> +               unsigned int    reserved:29;
>         } split;
>         unsigned int            full;
>  };
> --
> 2.34.1
>
