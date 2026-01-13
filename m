Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B369265629
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Jan 2026 01:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768268989; cv=pass; b=AzQBpkvCOuBqHlmpa8dK4KioTt5uWK8YDVYXOyWcr0QLb53ophnS+kRy3h3l9a9BgfMQ//ltGNDHbnq/f1iNPy9LyYd5ybL4gseftcqMgA/IiqaqKobN+ViQBvN70/Bo603RSt+7QWc4foMnp0b4ZpJ7ffolarAMADrrEtGR7Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768268989; c=relaxed/simple;
	bh=l7ypb4LN1kYp3j48j0jW/Evr3bEoOTPX2k48qxf5Srs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWMb4Rb86iH7Q3LHhWRSLCGcxGEXfp7bUo/w8ucWxgw1aZTj5axBDGLBFWkiAAEy/t+t/87UaXXwKnPEiqsLKCi4kYAkCKJaKTJDBkm9B27AzDfAyeFtuvqE+F6hLTiMU/HjPE4r9v4bYDMff66BbA1Y+7WP3ml4ELGkxCsw6vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3VpVJPTb; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3VpVJPTb"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-11a247de834so3516c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jan 2026 17:49:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768268985; cv=none;
        d=google.com; s=arc-20240605;
        b=creL7QHUV99PPOIVHG6uZaDlj7yn4U/LMISSRFgjs1Rc1C/mDkgXKFYcFC36Ww5Kio
         c9QuFbpTTaLVYCn8mtNRU/EBSPqnfw09/934s3kaTJ83/JyDywm67H9xn8FmZK8dHyzb
         FlFYV5FZl/c9gsr9rm1w5pLN9JvcSLcawMfi3lxHSmnbDggNTnzV/CewDXPGANPSDT0s
         XqiHueQMXlUZ6Or/iiRRcQUTD4s5G2Ya49p+7efp2gdIONcjeZDbWKVFaoq6EzW0wmhd
         RtHtUrjor5cAAj4Cjb59K5Df2HAHRRyUHTNli2gxmPbKArjOPvWYia1fVIPWzN35hHUU
         HrPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=phjYjURh/YEilOlco0PwQPqJ7bBAHsIswFJueWFjrBc=;
        fh=or742PenA0N3n/K0tP3ZOFUvKW5zpfS4a6xC6oKSHHA=;
        b=JBonk0ae9WrJoRRZDV/ujrVxj/dO+kuXf2gJj1ICRboPBRdfWceWWMk1MDo5rtSFIo
         nCK/abvcQ8fF3h+UG0tFTCLLBlQi+3+a0bpGveRWev2W2EzGXNxhvQVowX8NP63bL7E6
         7zMzAmxHFY0NQ8I/aey23hu1zlfygNLbeUCsP35d0TWCLVbFy6GA48hS29iNuucEJW77
         GvA9gXESVa7WwcuEFTwia8QbRUEO6LZnoAy6qJlAcEZbuxNqa36MGHjbx5/aTRP/55VD
         UcLs3OMV5S+5W3bcBakYFKpMZiQ6fOMq4xe+giyDdUBVJknRDm1Y4f98L8VYIokoTU7d
         Llrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768268985; x=1768873785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phjYjURh/YEilOlco0PwQPqJ7bBAHsIswFJueWFjrBc=;
        b=3VpVJPTbAp90cv+moohekZFtFbqNu7voewnXr6o+/7NgMtpjnmtlFdzxt093XrTD2F
         k3EeS6a24fFsZ5xdm6KZ4qeKY4EnIj+/ktXT3VCZoS7pADsVaHsHOTENZniUq0lx+MOw
         N8d/xQdogQDJy7bfzik/nwoGddbltZrE7dnbbPDut5qBxZ31bRU9SlX9bGyl1QVuryTm
         GM+kdspTGAvmV5LVNv2I76oQ5G0Q1Po+ytjktXsxDTGoo0l+l2z81cSV7LhM6J3XVJjI
         xnsN6hJppmM3Y3Y+P+LCCbkmVxaxXRMvxZoFysOO93GGLRgX33CMO8CDXHD2uRp6W6GU
         9rDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768268985; x=1768873785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=phjYjURh/YEilOlco0PwQPqJ7bBAHsIswFJueWFjrBc=;
        b=gL2OhsemSONuC0l2Sb3mcnsJ2RLnP+knYKtA6B2xIxbF5fQP152LXr5rTY2moiNao2
         sscM28Bjj4Vj+/xSMMWz5bIamn8Irb0z+8ICeSsCRxHpb02hFP/yf8Jf0J7aliudsbwd
         TX3/G0+VePWpvTWbwmHwTdBpCz9VrXGTJKB3Grqb1JO3ScAj77T1UPRhzSvaD+36ccXP
         8PMct2lTKrV/TfWiedsX2yOrz5b93K78LNEdCoM4jpiaqbihw2n4/KMnwLhQjF7WS0bh
         tYOJAYAe/LkiN6AG+6fOo/VEGEGJfVYCxkH2jzVjixd8q98ZyzutP+vaa8HFUR1xbcBZ
         ulcA==
X-Forwarded-Encrypted: i=1; AJvYcCUPnA/py8Acs7R4rv8EAbuTXntg97IbsvEuHawksECCYBV5oAkTFQbI6ThHqvAT5qyvEDrT10mdWFSM1UGkTy8m@vger.kernel.org
X-Gm-Message-State: AOJu0YyCYiPVBVtpMEMA6OeScsQcNFmvjSbMmlENi2+ABl9LVWvHKUnw
	QfXUmxzxrL6+zY8ay/a4l9icr0vXRIpi6Qc0f+GJndDAZzLbZTG6X0xE0bVxdeZksQUlijFzWup
	pj57W3eCD5mP+0Rrr+6/m7Z2PyHEhYb1HcL8sbV3q
X-Gm-Gg: AY/fxX7/5QOqlqY1FCGI10yclXDV5PB247JicTSDrHTsiDjqp1t4UTOGIBB3M6ZRq5F
	Jw2xvrsB992yybPpgsRqmBhxlMyqeDPX6nCBV5O10pSB9U+wqJN5TclvOYu0r4QHxsahFXLiun5
	qulrF3tIH8CXd0ZS39hi+XsmOEuhQO6perbD552XbXs1PHuMH61mcqZYMCuk1AP6XN59Sb5Ntog
	9MX0zo97KEP2LeHOQYoO8fbMrew7fThRlNGR6icD7bV/vV9LNbEt7oBhojHC+wWFgt/rpL9
X-Received: by 2002:a05:7022:2525:b0:120:5719:1852 with SMTP id
 a92af1059eb24-1232bed55b8mr49504c88.16.1768268984856; Mon, 12 Jan 2026
 17:49:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112051649.1113435-1-dapeng1.mi@linux.intel.com> <20260112051649.1113435-8-dapeng1.mi@linux.intel.com>
In-Reply-To: <20260112051649.1113435-8-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Jan 2026 17:49:33 -0800
X-Gm-Features: AZwV_QgpnfnXpUPHIn53AjxEeMhJYmrGbZDL2dTHnRMs6UWEOIUdC9qvw7oJbwA
Message-ID: <CAP-5=fXE02soq4z0ZjuPYQZTH9bkfrMXqe1nT9A7EcgG0cH6yw@mail.gmail.com>
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

Fwiw, I found it surprising in the test:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/mmap-basic.c?h=3Dperf-tools-next#n375
that the enable/disable of rdpmc on cpu_atom affected cpu_core and
vice-versa. Perhaps the docs could mention this.

Also fwiw, I remember Peter's proposal to improve rdpmc so that
restartable sequences or CPU affinities aren't necessary on hybrid
machines by handling faults in the kernel:
https://lore.kernel.org/linux-perf-users/20250618084522.GE1613376@noisy.pro=
gramming.kicks-ass.net/
which imo would be a welcome addition. Perhaps without that fix we can
document the affinity/rseq needs.

Thanks,
Ian

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
