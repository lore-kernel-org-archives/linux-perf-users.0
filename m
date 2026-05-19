Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA333DB32A
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 17:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779213438; cv=pass; b=NZ9A266zNPDUdQbAGbFNKJhrB2AwP3vOe4+N+tuw9aGn2X4TmaOZhlTEgn/V+B692UUC/ZR+aWEJwUw2R7lgyMl3+5rjqYgUJnP6tRg8361FFduiYxViuJSkCS7WkoNOGvlBKwHJJw2oCByMKVzaCrsSKYKwhbWvfDMfTz7luhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779213438; c=relaxed/simple;
	bh=ghc9voI3wKE9j2UnYaCGqKuISeLhE9SOjSJHklwqEOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ehmHzfoDjwhBT3kHsLtIBQNUS7dsNi/scUKTQwOjxE+OKnjHoCfsfcJhxWcwxZUWyQHXuiBGO4MccAOfWZN3uZ3S/+bF8vqjhoHGeO3AXqJ7c3LvkJ0rHoh+o/UwU/qY9mVAcyst7NsR8uc49tuNAEW67S1Kj80ttL0VLfhG96w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PBPAWiIT; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PBPAWiIT"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-135200bc7d2so10417685c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 10:57:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779213436; cv=none;
        d=google.com; s=arc-20240605;
        b=GJMRd2LD+o+tCUxyQm+p0r1WO4Tk9fivlPftVScOp9FZbZTiJ13aFZ5SkiwU3P9TLw
         WK3320TkcwMsbwELNB7WuELVVQI5GmCrXbbr1gUXhoNDfggmpGDZqcfn4ehW0yOTGeAx
         1Qgx0e4+m6wSKMjewRB5xZPmiQjMmFaPyGzNh5c3Q7liWlEVdr6FYdJgREIH9r/UPAd9
         pZtU5/WA1KyypNgdw/9UYjBMBJCj9hWZsoT41kc/cCEdDlN7P8tZjcyxytqW/G4QUyYv
         4DTbDTAmrCA8SZhZv/zZJEXtdAViM/nfmgdfoZjw7iEfE3FbWW61wWr7JMiRqfX9Kfd7
         mp4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Va8QSGksy98wZ9sjUE3Dd8gOEH3xbMld0hNq96lozA4=;
        fh=6f8iCice4ixFfzhMnOlP0RaUIj8fCle5tw4s8Yg8DcA=;
        b=G1DkeDp2teDMAr9uLVJn7namAIS9x/4+JuCY3WjIYRDJjKWNYCnpLhxNcvhmHDqgZl
         6GdhVfEBU6zZyjdaXxnztgXPZwJ1iBcEPZ5g+N7TIEL7suQQVcrXn8HcPnPxP7WnSN0H
         5KucWZdcFk19DLs2vnpqEYi+LbtYCxS8+jawKCZNiuPShX2iz1vTfKdywUxnbU4CL0TN
         3CKshcvu/w+5Zew8Ad5dSTMCVwts3cGl4RHKblPQKl0G7rXljg0TTs3q2+f0qXU8PuFB
         Ob5zQ9pcCqU6v099aEXVQdXWMwPYWO+dLX1cKlxzhcnKi3St7G4QKgms009xOCK9SD1J
         gqzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779213436; x=1779818236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Va8QSGksy98wZ9sjUE3Dd8gOEH3xbMld0hNq96lozA4=;
        b=PBPAWiITU9DrZFMLX2aZd4afvWkFDb2e0WHgv0wbraS6ZFQYWFS4YHrnY3MxoRHveq
         DoJywwtlYetg8qFJUFH5pFBKlQR/zZ+dgLIp1TasnFmxFbHu2wM4jPPez4GbpiMIwC9a
         skMpsilzmTBZr3qnBtnKCE4jgwLzyKUiaNUjQ5xcDdUiDHhc7APe5mqqK1ihMWN+RHKf
         uZbKvJJAItqeGIIZYXJzJlX8wxiWibN3nrCr9KUsvgSNNWt9+kpYyicfw6c6SsouspQ7
         e0Fw5gY2eFpg0IO49W6tBOZADyCm01/lYqOlJDTvJyCLCByXv1+R9Rvq9D5LA+xodRi9
         GxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779213436; x=1779818236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Va8QSGksy98wZ9sjUE3Dd8gOEH3xbMld0hNq96lozA4=;
        b=O+n+sofCAniTihw6mCvxoA1ZBdyDbdeI+lw3NPGOWwpARSdVunqvgAik7ZlO+nccHl
         vVs4nUy7TjcEuYTvA7JEUuqHBlGJJwTV22/AWHSxIp0IaV5qTVM/o19AwdLkCfjSeh1i
         QqsKl9l6V8oiquuEL+kLt6VWN+7PzUr4o6tDP+ohBmo4jNUznufh5kv0BqU+90mBn7Xl
         oZ246hQZS8lYfZTEm/Izhp6bdHzdirM7XqCOS8Yqd9Se60zbiaI7m9rv8KhWmL5OAcJP
         8XjGlSDQh29e9tO1zpobxHR2XTGQM/RvZOQ2z0Cqj1dce/CvK0HVYOvJjyriJwGD6HCN
         heyw==
X-Forwarded-Encrypted: i=1; AFNElJ8RQlHkl3tAkd0mdohM6JSVe0KHRQobqYH5eMi848P14vJxr59qpu4xcMJv31exTPuSVXMee/4vPPLpPPC0aGIK@vger.kernel.org
X-Gm-Message-State: AOJu0YwGpdrKbXt+/StT2yI3VEW5gBsEeIeqdQOQMRe5sLk6pnKcwD6A
	HQoQpZmLj3G6D4vaLrTE4yWrc4MYCLQEr1a+nkux657if+Cn6nJeBnp7ahfEVveyIlNEbDnUQjW
	nZKoUnOEhn9ImcQqyfBG0oqrUXiTuCraSG/9YgtT+
X-Gm-Gg: Acq92OFBYyebVBpldTtvdJSlmZf59vv3QTNOV45LDP7+3q6nat8ia9HcCgTsQAjoYT2
	XLlsv0JYIHm+/zhB4GQNc+3y21Fxw83cBfeCZncI4UOO67+CG7hEXtOobN1xu6u+3SA2z+VpJBb
	zYx06XShCi70/hy11jKbEGoxAMqSDqC9pWExuu3XgIT5oMOluFN5JoaFtPGUriV+i8MzSUtv/rX
	E/HKvsY78ZmtQxeol9PL7/RBUZclj/3T1jJW2iSTxgksD+WwKEgsaOkFia3gwdRLiAEKBYcIRDb
	3gV3Nq13LGH9AKSmkqsXQGLne23zS1TrKfEkv2no1IJI8emJ
X-Received: by 2002:a05:7022:ff42:b0:132:7ab5:6cb6 with SMTP id
 a92af1059eb24-1350451da55mr9113905c88.2.1779213434819; Tue, 19 May 2026
 10:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112051649.1113435-1-dapeng1.mi@linux.intel.com>
 <20260112051649.1113435-8-dapeng1.mi@linux.intel.com> <CAP-5=fXhWssLxjM9s=zai27CU1JbSpz1+GN1=6AM54YAqsqcww@mail.gmail.com>
 <fb9b5ae9-80ce-44ee-9f68-309948f59365@linux.intel.com> <CAJpZYjVrUHz=PR3qZd68i_gpRmfMSsoBVThXi4nuzryzfV_Pgw@mail.gmail.com>
In-Reply-To: <CAJpZYjVrUHz=PR3qZd68i_gpRmfMSsoBVThXi4nuzryzfV_Pgw@mail.gmail.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Tue, 19 May 2026 10:57:02 -0700
X-Gm-Features: AVHnY4Ivvi3ER1PGs1IWRrtd7wZtofVlFi3W_6sbyg6IcqIEeA5Edh5ueYgBQHM
Message-ID: <CAJpZYjWe+DSP=svkf8Boce5HvGV5Wte0WSaYg5JroVm_H+OiHw@mail.gmail.com>
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

Never mind, I found it.

On Tue, May 19, 2026 at 10:53=E2=80=AFAM Chun-Tse Shao <ctshao@google.com> =
wrote:
>
> Hi, is the "update cap_user_rdpmc" patch already on lkml?
>
> Thanks,
> CT
>
> On Mon, Mar 9, 2026 at 10:28=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.inte=
l.com> wrote:
> >
> >
> > On 3/10/2026 8:04 AM, Ian Rogers wrote:
> > > On Sun, Jan 11, 2026 at 9:20=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.i=
ntel.com> wrote:
> > >> Starting with Panther Cove, the rdpmc user disable feature is suppor=
ted.
> > >> This feature allows the perf system to disable user space rdpmc read=
s at
> > >> the counter level.
> > >>
> > >> Currently, when a global counter is active, any user with rdpmc righ=
ts
> > >> can read it, even if perf access permissions forbid it (e.g., disall=
ow
> > >> reading ring 0 counters). The rdpmc user disable feature mitigates t=
his
> > >> security concern.
> > >>
> > >> Details:
> > >>
> > >> - A new RDPMC_USR_DISABLE bit (bit 37) in each EVNTSELx MSR indicate=
s
> > >>   that the GP counter cannot be read by RDPMC in ring 3.
> > >> - New RDPMC_USR_DISABLE bits in IA32_FIXED_CTR_CTRL MSR (bits 33, 37=
,
> > >>   41, 45, etc.) for fixed counters 0, 1, 2, 3, etc.
> > >> - When calling rdpmc instruction for counter x, the following pseudo
> > >>   code demonstrates how the counter value is obtained:
> > >>         If (!CPL0 && RDPMC_USR_DISABLE[x] =3D=3D 1) ? 0 : counter_va=
lue;
> > >> - RDPMC_USR_DISABLE is enumerated by CPUID.0x23.0.EBX[2].
> > >>
> > >> This patch extends the current global user space rdpmc control logic=
 via
> > >> the sysfs interface (/sys/devices/cpu/rdpmc) as follows:
> > >>
> > >> - rdpmc =3D 0:
> > >>   Global user space rdpmc and counter-level user space rdpmc for all
> > >>   counters are both disabled.
> > >> - rdpmc =3D 1:
> > >>   Global user space rdpmc is enabled during the mmap-enabled time wi=
ndow,
> > >>   and counter-level user space rdpmc is enabled only for non-system-=
wide
> > >>   events. This prevents counter data leaks as count data is cleared
> > >>   during context switches.
> > >> - rdpmc =3D 2:
> > >>   Global user space rdpmc and counter-level user space rdpmc for all
> > >>   counters are enabled unconditionally.
> > >>
> > >> The new rdpmc settings only affect newly activated perf events; curr=
ently
> > >> active perf events remain unaffected. This simplifies and cleans up =
the
> > >> code. The default value of rdpmc remains unchanged at 1.
> > >>
> > >> For more details about rdpmc user disable, please refer to chapter 1=
5
> > >> "RDPMC USER DISABLE" in ISE documentation.
> > >>
> > >> ISE: https://www.intel.com/content/www/us/en/content-details/869288/=
intel-architecture-instruction-set-extensions-programming-reference.html
> > >>
> > >> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > >> ---
> > >>  .../sysfs-bus-event_source-devices-rdpmc      | 40 ++++++++++++++++=
+++
> > >>  arch/x86/events/core.c                        | 21 ++++++++++
> > >>  arch/x86/events/intel/core.c                  | 26 ++++++++++++
> > >>  arch/x86/events/perf_event.h                  |  6 +++
> > >>  arch/x86/include/asm/perf_event.h             |  8 +++-
> > >>  5 files changed, 99 insertions(+), 2 deletions(-)
> > >>  create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source=
-devices-rdpmc
> > >>
> > >> diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-device=
s-rdpmc b/Documentation/ABI/testing/sysfs-bus-event_source-devices-rdpmc
> > >> new file mode 100644
> > >> index 000000000000..d004527ab13e
> > >> --- /dev/null
> > >> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-rdpmc
> > >> @@ -0,0 +1,40 @@
> > >> +What:           /sys/bus/event_source/devices/cpu.../rdpmc
> > >> +Date:           November 2011
> > >> +KernelVersion:  3.10
> > >> +Contact:        Linux kernel mailing list linux-kernel@vger.kernel.=
org
> > >> +Description:    The /sys/bus/event_source/devices/cpu.../rdpmc attr=
ibute
> > >> +                is used to show/manage if rdpmc instruction can be
> > >> +                executed in user space. This attribute supports 3 n=
umbers.
> > >> +                - rdpmc =3D 0
> > >> +                user space rdpmc is globally disabled for all PMU
> > >> +                counters.
> > >> +                - rdpmc =3D 1
> > >> +                user space rdpmc is globally enabled only in event =
mmap
> > >> +                ioctl called time window. If the mmap region is unm=
apped,
> > >> +                user space rdpmc is disabled again.
> > >> +                - rdpmc =3D 2
> > >> +                user space rdpmc is globally enabled for all PMU
> > >> +                counters.
> > >> +
> > >> +                In the Intel platforms supporting counter level's u=
ser
> > >> +                space rdpmc disable feature (CPUID.23H.EBX[2] =3D 1=
), the
> > >> +                meaning of 3 numbers is extended to
> > >> +                - rdpmc =3D 0
> > >> +                global user space rdpmc and counter level's user sp=
ace
> > >> +                rdpmc of all counters are both disabled.
> > >> +                - rdpmc =3D 1
> > >> +                No changes on behavior of global user space rdpmc.
> > >> +                counter level's rdpmc of system-wide events is disa=
bled
> > >> +                but counter level's rdpmc of non-system-wide events=
 is
> > >> +                enabled.
> > >> +                - rdpmc =3D 2
> > >> +                global user space rdpmc and counter level's user sp=
ace
> > >> +                rdpmc of all counters are both enabled unconditiona=
lly.
> > >> +
> > >> +                The default value of rdpmc is 1.
> > >> +
> > >> +                Please notice global user space rdpmc's behavior wo=
uld
> > >> +                change immediately along with the rdpmc value's cha=
nge,
> > >> +                but the behavior of counter level's user space rdpm=
c
> > >> +                won't take effect immediately until the event is
> > >> +                reactivated or recreated.
> > >> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > >> index c2717cb5034f..6df73e8398cd 100644
> > >> --- a/arch/x86/events/core.c
> > >> +++ b/arch/x86/events/core.c
> > >> @@ -2616,6 +2616,27 @@ static ssize_t get_attr_rdpmc(struct device *=
cdev,
> > >>         return snprintf(buf, 40, "%d\n", x86_pmu.attr_rdpmc);
> > >>  }
> > >>
> > >> +/*
> > >> + * Behaviors of rdpmc value:
> > >> + * - rdpmc =3D 0
> > >> + *    global user space rdpmc and counter level's user space rdpmc =
of all
> > >> + *    counters are both disabled.
> > >> + * - rdpmc =3D 1
> > >> + *    global user space rdpmc is enabled in mmap enabled time windo=
w and
> > >> + *    counter level's user space rdpmc is enabled for only non syst=
em-wide
> > >> + *    events. Counter level's user space rdpmc of system-wide event=
s is
> > >> + *    still disabled by default. This won't introduce counter data =
leak for
> > >> + *    non system-wide events since their count data would be cleare=
d when
> > >> + *    context switches.
> > >> + * - rdpmc =3D 2
> > >> + *    global user space rdpmc and counter level's user space rdpmc =
of all
> > >> + *    counters are enabled unconditionally.
> > >> + *
> > >> + * Suppose the rdpmc value won't be changed frequently, don't dynam=
ically
> > >> + * reschedule events to make the new rpdmc value take effect on act=
ive perf
> > >> + * events immediately, the new rdpmc value would only impact the ne=
w
> > >> + * activated perf events. This makes code simpler and cleaner.
> > >> + */
> > >>  static ssize_t set_attr_rdpmc(struct device *cdev,
> > >>                               struct device_attribute *attr,
> > >>                               const char *buf, size_t count)
> > >> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/co=
re.c
> > >> index dd488a095f33..77cf849a1381 100644
> > >> --- a/arch/x86/events/intel/core.c
> > >> +++ b/arch/x86/events/intel/core.c
> > >> @@ -3128,6 +3128,8 @@ static void intel_pmu_enable_fixed(struct perf=
_event *event)
> > >>                 bits |=3D INTEL_FIXED_0_USER;
> > >>         if (hwc->config & ARCH_PERFMON_EVENTSEL_OS)
> > >>                 bits |=3D INTEL_FIXED_0_KERNEL;
> > >> +       if (hwc->config & ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE)
> > >> +               bits |=3D INTEL_FIXED_0_RDPMC_USER_DISABLE;
> > >>
> > >>         /*
> > >>          * ANY bit is supported in v3 and up
> > >> @@ -3263,6 +3265,26 @@ static void intel_pmu_enable_event_ext(struct=
 perf_event *event)
> > >>                 __intel_pmu_update_event_ext(hwc->idx, ext);
> > >>  }
> > >>
> > >> +static void intel_pmu_update_rdpmc_user_disable(struct perf_event *=
event)
> > >> +{
> > >> +       /*
> > >> +        * Counter scope's user-space rdpmc is disabled by default
> > >> +        * except two cases.
> > >> +        * a. rdpmc =3D 2 (user space rdpmc enabled unconditionally)
> > >> +        * b. rdpmc =3D 1 and the event is not a system-wide event.
> > >> +        *    The count of non-system-wide events would be cleared w=
hen
> > >> +        *    context switches, so no count data is leaked.
> > >> +        */
> > >> +       if (x86_pmu_has_rdpmc_user_disable(event->pmu)) {
> > >> +               if (x86_pmu.attr_rdpmc =3D=3D X86_USER_RDPMC_ALWAYS_=
ENABLE ||
> > >> +                   (x86_pmu.attr_rdpmc =3D=3D X86_USER_RDPMC_CONDIT=
IONAL_ENABLE &&
> > >> +                    event->ctx->task))
> > >> +                       event->hw.config &=3D ~ARCH_PERFMON_EVENTSEL=
_RDPMC_USER_DISABLE;
> > >> +               else
> > >> +                       event->hw.config |=3D ARCH_PERFMON_EVENTSEL_=
RDPMC_USER_DISABLE;
> > > AI code review flagged this, but I think the conditions are discussed
> > > in the comments. Posting the AI review out just in case as I'm not
> > > sure:
> > >   If x86_pmu.attr_rdpmc =3D=3D X86_USER_RDPMC_CONDITIONAL_ENABLE (1) =
and
> > > this is a system-wide event, RDPMC_USER_DISABLE is set to block rdpmc
> > > in user space. However, during x86_pmu_event_init(),
> > > PERF_EVENT_FLAG_USER_READ_CNT is set because x86_pmu.attr_rdpmc is
> > > non-zero. Since it is not cleared when RDPMC_USER_DISABLE is active,
> > > arch_perf_update_userpage() will still set cap_user_rdpmc =3D 1. Does
> > > this cause user space to mistakenly attempt rdpmc? If user space uses
> > > rdpmc for the system-wide event, the hardware will return 0 due to th=
e
> > > RDPMC_USER_DISABLE bit, which might result in user space silently
> > > reading garbage values instead of falling back to the read() syscall.
> > > Would it make sense to clear cap_user_rdpmc when RDPMC_USER_DISABLE i=
s
> > > set?
> >
> > Yes, I suppose the comment makes sense. We can further update the
> > cap_user_rdpmc  base on the RDPMC_USER_DISABLE bit. Thanks.
> >
> >
> > >
> > > Thanks,
> > > Ian
> > >
> > >> +       }
> > >> +}
> > >> +
> > >>  DEFINE_STATIC_CALL_NULL(intel_pmu_enable_event_ext, intel_pmu_enabl=
e_event_ext);
> > >>
> > >>  static void intel_pmu_enable_event(struct perf_event *event)
> > >> @@ -3271,6 +3293,8 @@ static void intel_pmu_enable_event(struct perf=
_event *event)
> > >>         struct hw_perf_event *hwc =3D &event->hw;
> > >>         int idx =3D hwc->idx;
> > >>
> > >> +       intel_pmu_update_rdpmc_user_disable(event);
> > >> +
> > >>         if (unlikely(event->attr.precise_ip))
> > >>                 static_call(x86_pmu_pebs_enable)(event);
> > >>
> > >> @@ -5863,6 +5887,8 @@ static void update_pmu_cap(struct pmu *pmu)
> > >>                 hybrid(pmu, config_mask) |=3D ARCH_PERFMON_EVENTSEL_=
UMASK2;
> > >>         if (ebx_0.split.eq)
> > >>                 hybrid(pmu, config_mask) |=3D ARCH_PERFMON_EVENTSEL_=
EQ;
> > >> +       if (ebx_0.split.rdpmc_user_disable)
> > >> +               hybrid(pmu, config_mask) |=3D ARCH_PERFMON_EVENTSEL_=
RDPMC_USER_DISABLE;
> > >>
> > >>         if (eax_0.split.cntr_subleaf) {
> > >>                 cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_=
COUNTER_LEAF,
> > >> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_eve=
nt.h
> > >> index 24a81d2916e9..cd337f3ffd01 100644
> > >> --- a/arch/x86/events/perf_event.h
> > >> +++ b/arch/x86/events/perf_event.h
> > >> @@ -1333,6 +1333,12 @@ static inline u64 x86_pmu_get_event_config(st=
ruct perf_event *event)
> > >>         return event->attr.config & hybrid(event->pmu, config_mask);
> > >>  }
> > >>
> > >> +static inline bool x86_pmu_has_rdpmc_user_disable(struct pmu *pmu)
> > >> +{
> > >> +       return !!(hybrid(pmu, config_mask) &
> > >> +                ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE);
> > >> +}
> > >> +
> > >>  extern struct event_constraint emptyconstraint;
> > >>
> > >>  extern struct event_constraint unconstrained;
> > >> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/as=
m/perf_event.h
> > >> index 0d9af4135e0a..ff5acb8b199b 100644
> > >> --- a/arch/x86/include/asm/perf_event.h
> > >> +++ b/arch/x86/include/asm/perf_event.h
> > >> @@ -33,6 +33,7 @@
> > >>  #define ARCH_PERFMON_EVENTSEL_CMASK                    0xFF000000UL=
L
> > >>  #define ARCH_PERFMON_EVENTSEL_BR_CNTR                  (1ULL << 35)
> > >>  #define ARCH_PERFMON_EVENTSEL_EQ                       (1ULL << 36)
> > >> +#define ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE       (1ULL << 37)
> > >>  #define ARCH_PERFMON_EVENTSEL_UMASK2                   (0xFFULL << =
40)
> > >>
> > >>  #define INTEL_FIXED_BITS_STRIDE                        4
> > >> @@ -40,6 +41,7 @@
> > >>  #define INTEL_FIXED_0_USER                             (1ULL << 1)
> > >>  #define INTEL_FIXED_0_ANYTHREAD                        (1ULL << 2)
> > >>  #define INTEL_FIXED_0_ENABLE_PMI                       (1ULL << 3)
> > >> +#define INTEL_FIXED_0_RDPMC_USER_DISABLE               (1ULL << 33)
> > >>  #define INTEL_FIXED_3_METRICS_CLEAR                    (1ULL << 2)
> > >>
> > >>  #define HSW_IN_TX                                      (1ULL << 32)
> > >> @@ -50,7 +52,7 @@
> > >>  #define INTEL_FIXED_BITS_MASK                                  \
> > >>         (INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER |            \
> > >>          INTEL_FIXED_0_ANYTHREAD | INTEL_FIXED_0_ENABLE_PMI |   \
> > >> -        ICL_FIXED_0_ADAPTIVE)
> > >> +        ICL_FIXED_0_ADAPTIVE | INTEL_FIXED_0_RDPMC_USER_DISABLE)
> > >>
> > >>  #define intel_fixed_bits_by_idx(_idx, _bits)                   \
> > >>         ((_bits) << ((_idx) * INTEL_FIXED_BITS_STRIDE))
> > >> @@ -226,7 +228,9 @@ union cpuid35_ebx {
> > >>                 unsigned int    umask2:1;
> > >>                 /* EQ-bit Supported */
> > >>                 unsigned int    eq:1;
> > >> -               unsigned int    reserved:30;
> > >> +               /* rdpmc user disable Supported */
> > >> +               unsigned int    rdpmc_user_disable:1;
> > >> +               unsigned int    reserved:29;
> > >>         } split;
> > >>         unsigned int            full;
> > >>  };
> > >> --
> > >> 2.34.1
> > >>
> >
