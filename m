Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA26936A033
	for <linux-perf-users@vger.kernel.org>; Sat, 15 Aug 2026 06:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786774787; cv=pass; b=AmvWrINtVqZ+YZblWa3r2dRVvZI6rw560pfXznH4VhuO2fsHij2h37oVlvtJ6XIGrOupLtedjPLh7+/dhEjxFWPmYtDL08iI89cEVj9zWDmHXusYUHh11P4OjK+9JyRJVVtCTRe7cGhPFRe9fnPOVSXwIUFdzr2MXhsFQC+rYyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786774787; c=relaxed/simple;
	bh=a0O/voIbvOl5wzY1oh/XT/6MgMgbcqMKD5avyzAXZyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqoJ9A4AOay9UDDkuNYKT2zhSWytjNgrumHMinMYGACpR5qX0wAKRBnWxKV/7Oh39lXNOklqc4a/PrXE2CWmRGKEd0f2kU/UyKmwmWzPnWgXRgJVJtPVzwQj9M3T4ajy4yNJKLqIowL9Tvh2azyUYf2d+bKeVE46tDIYPOJs6Mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JsiaQiwa; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JsiaQiwa"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c10ed63c0so403941cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 23:19:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786774785; cv=none;
        d=google.com; s=arc-20260327;
        b=QwWiM0Yw2mlDx4Yxpb5giFbQS+/dg9lOCrAYd1FJgJBA9/3UTdn/z8wtF8i1C0bmRk
         wiOy9J5NWpCm0B2l/+SQCTn2Z04n0uOE0rhAe8pm68FJK/L7LpYkO6v8Pr4p+URsnLT7
         6zWahfECDlzjgUtFuVGNT20ajb5KKIDbVukLLQ1ooeYYg39mdu5css9hrqKDl7xGGom7
         wK8ePnbcisNDRd9jbih1II+wR+3RaZvbsoUSjqlGJPoQc+xljrQgSNJE7H7eYs4KdrOA
         S3wAfuICxv4rwebqX3GuTQ1D3+0J4KYe/miT2FP3FD+6dwo/gIfziIi46ExgLEpkdZI+
         dMZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U4/rgL5TmiSafvDliAVjXLEcMVin7z50Ra+RTzNxxMQ=;
        fh=RrPdrYSkcPZ4COUiHDVT7j81jrD1JWYN06hZp802XWI=;
        b=rgQC0XaKQumsYIfeAXoKVqlB5jU79F6p8TVKjWXDIanJMgMEL1yqypc8TVMABZHUWu
         GiYTmF3YtrFOtttvQlNZ0Hq+zs6AxAIFB9eErj9qtHIquKLrWs/McKSii4eZVHyPzvaz
         4VwNKgG3Rf/f0pQ9aD21b06xNjE4qbImSkkaOUcLF0T53pjay5jsnoEz5RSRpHXb7Mbc
         1et0jSrLyjeRdtz0Bg+FIpYIRrjRNKkYcFdTWwrr0Qh1jkaOEHg6RP5ef7IeiJu5GY8t
         UQgvy30X/PBoRPOsPXHmenGn9p6TpyqgjcGZcb7NwIQzxFP4gmQSbtpq6ZgmhH3vHmtr
         E5BQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786774785; x=1787379585; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U4/rgL5TmiSafvDliAVjXLEcMVin7z50Ra+RTzNxxMQ=;
        b=JsiaQiwaCxDrkmynwMa/f/LoPucwHi7/EOJB0lLCcBIzsVAPNM7KhyHQ8MEN8vMh5Y
         T51k+9ookGSA9Z2wT8YjMKyKG3rT6GLNi7/demyp8uVD65kJXgeOCowxchohTBGl4mbB
         sUOQMM+ckrwPmwdD9n9+nWmDkiFoIzOUt50vyN4+7r/jTwDVR3lGUXD08GBIuMwTFvEC
         JNQhqgjzwTP9PCInFDvyLZi6DKnsObUaL+j+H99XGWFBBcs2Z6hXaoG3Vn+GB6IUv3Be
         QUGdTRXcdIqyDv2Knk1iWtCAiHaBpXIz7AjhXVKH9dXPnLjLucPWeeIJkVgMgg5kDgXM
         yM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786774785; x=1787379585;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U4/rgL5TmiSafvDliAVjXLEcMVin7z50Ra+RTzNxxMQ=;
        b=cG0qnVEWC56k7s/Pt2rs+96nvDmX0YZMuvC6p7z+Hu6nL4YbdcVSNzRpPY0J6IjHAU
         wr80ZKgNtieoep+oonicbpNpFb60y3qnMi5BLEVb6rYh9dSmMc4erEY82euurySizDZO
         5wgslNJ2uAAXZSvQymqn/No7o/XhTZc/570AoXyLHOzdE3HbhSGdzukBIXAxXlj96g2s
         Vfk0ek8h/ldbKKlbsmEXOh33d8is3hz4WYe+nT3KKbxJh/JpYTOjT36/NEyGHadojeet
         bZkt4Q0Drl4LoAUrAcZOWGmnrQBGPrXgYn1ihZlvnNYRUbo8kR4OKwm6fI1tStM2r01y
         SigQ==
X-Gm-Message-State: AOJu0Yxgl7m5MXcVL89SUIo6/uTtLJDILWDMUokccpIYaLgN1Yds1p8s
	mjoGrC5X/t6SQ4+yVihAQpBkSPZm0tH9s9lkXRvIqfcwhlpvWpBa9QY9avA1A95H7En4eGEVVWF
	N3Nbz5R/aPvuI9Sgw3dSe/qMgQvoK7pJbTNGTGToj
X-Gm-Gg: AR+sD11yZZKBkjOufsiQP5BIi+iqzOezL+uptMK/3D8LWBtvkW08a8dZ3x8ZjGP3b7/
	aRhtjT6Zkd64z+mNahydTCSMDwZ8qIiT2Zx2zPzyeA6PNPlASQ3kyeTGe1ct+cYZSQBbIjd5oqH
	Z9rHZJHYVJLVF2EnN1MASjC5G5u2k9kD/ObaGxJxLHhrt6ESrlgA1lBFUJx/guBEBg6ryGbtMSR
	PylylxK/4rpDtAFmzBQdZzO9JIN4P+jHl7qMeL/bcjDYnlHszgpZ7scgTA4T0RI3EqmH42La8AS
	caRJssVBsYkpKIpp3JwEjB9GYTAnyohy7Lrjib3fzWqVvg==
X-Received: by 2002:a05:622a:2597:b0:51c:ad5:93be with SMTP id
 d75a77b69052e-52d8476b6c0mr33343981cf.8.1786774784176; Fri, 14 Aug 2026
 23:19:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813064228.2799872-1-irogers@google.com> <cover.1691900000.git.irogers@google.com>
 <20260813073050.2823657-1-irogers@google.com> <700339f2-765f-4b2d-a80d-bd0a6822f91b@broadcom.com>
In-Reply-To: <700339f2-765f-4b2d-a80d-bd0a6822f91b@broadcom.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 14 Aug 2026 23:19:32 -0700
X-Gm-Features: AUfX_mxQL54J7NuX6sdmaRM-rIG6EZ-uSVfsRhTU7KLJOz2E99vKc0Kt-Qbsygc
Message-ID: <CAP-5=fUqXXRW7jFH77CCaHyOgzr09f1tmDJ+Kr2j53MOzk2vtg@mail.gmail.com>
Subject: Re: perf: Add Raspberry Pi BCM2835 AXI PMU driver
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-perf-users@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mark.rutland@arm.com, u.kleine-koenig@baylibre.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 10:31=E2=80=AFAM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> On 8/13/26 00:30, Ian Rogers wrote:
> > This commit adds a new performance monitoring driver for the Raspberry =
Pi
> > AXI bus (BCM2835/2711), exposing system-level and VideoCore PMU hardwar=
e to
> > the Linux perf subsystem.
> >
> > Note on out-of-tree macro compatibility:
> > The inclusion of #if LINUX_VERSION_CODE < KERNEL_VERSION(6, 13, 0)
> > surrounding hrtimer_setup is intentionally maintained alongside
> > this patch to guarantee seamless out-of-tree compilation fallback
> > compatibility for Raspberry Pi Long Term Support (LTS) kernel variants.
>
> Upstream does not care about that, I appreciate the thought and mention,
> but that's a backporting job to ensure it works.

I agree, with the small caveat that this compatibility is needed if
you want to build and use the module on Raspberry Pi OS which uses LTS
kernels (the current one being v6.12). I'm testing on Raspberry Pi OS
and suspect others may do so as well. When Raspberry Pi OS switches to
v6.18, or if someone were to try to land this patch, then the patch
just needs this commit comment and the #if block removing. I believe
this to be a trivial alteration to the patch, and think for now the
compatibility is more useful for people trying to experiment.

> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   drivers/perf/rpi_axi_pmu.c | 2456 +++++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 2456 insertions(+)
> >   create mode 100644 drivers/perf/rpi_axi_pmu.c
> >
> > diff --git a/drivers/perf/rpi_axi_pmu.c b/drivers/perf/rpi_axi_pmu.c
> > new file mode 100644
> > index 000000000000..d8efc8bb205f
> > --- /dev/null
> > +++ b/drivers/perf/rpi_axi_pmu.c
> > @@ -0,0 +1,2456 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +/**
> > + * DOC: Raspberry Pi AXI Bus Performance Monitoring Unit (PMU) Driver
> > + *
> > + * This driver exposes the performance monitoring hardware on Raspberr=
y Pi
> > + * System-on-Chips to the Linux perf subsystem:
> > + * - Raspberry Pi 1, 2, 3, 4, Compute Modules 1-4, Zero, Zero W (SoCs =
BCM2835/2836/2837/2711).
> > + *
> > + * Architecture Overview:
> > + * ----------------------
> > + * The Broadcom AXI performance hardware provides up to two independen=
t monitors:
> > + * 1. System Monitor (MON__SYSTEM =3D 0):
> > + *    Monitors system-level AXI traffic (ARM CPU L2/UC, DMA, V3D, ISP,=
 HVS, PCIe/RP1).
> > + *    Directly memory-mapped via ARM physical IO memory space (MMIO).
> > + *    Read latency: ~10-20 nanoseconds (fast, atomic-safe, non-blockin=
g).
> > + *
> > + * 2. VPU Monitor (MON__VPU =3D 1):
> > + *    Monitors VideoCore VPU buses (VPU0/1 Data/Instruction L2/UC, SDR=
AM, etc.).
> > + *    Accessible through VideoCore firmware mailbox IPC (RPI_FIRMWARE_=
SET/GET_PERIPH_REG).
> > + *    Read latency: ~10-100 microseconds (IPC over VPU mailbox).
> > + *
> > + * Synchronization & Concurrency Model:
> > + * ------------------------------------
> > + * - Spinlock (pmu->lock):
> > + *   Protects active event array (events[]), event generation sequence=
 counters (event_gen[]),
> > + *   bus watcher allocation/refcounting, active_vpu_events counter, an=
d MMIO register updates
> > + *   (MON__SYSTEM) against SMP race conditions and ABA pointer recycli=
ng races.
> > + *
> > + * - Mutex (pmu->vpu_mutex):
> > + *   Serializes VideoCore Mailbox IPC transactions (MON__VPU) in proce=
ss context,
> > + *   preventing concurrent mailbox buffer corruption across multiple C=
PUs.
> > + *
> > + * - Cached Async VPU Reads & Multiplexing (MON__VPU):
> > + *   Polled periodically in process context by vpu_work when active_vp=
u_events > 0.
> > + *   Uses PERF_HES_UPTODATE state flag to safely establish counter bas=
elines during
> > + *   event rotation / multiplexing. User read() syscalls return cached=
 cumulative event counter
> > + *   instantly without blocking.
> > + */
>
> The patch description needs to go into details as to why both the MMIO
> and firmware interfaces are supported. The firmware interface requires
> you to play games with sleeping/non-sleeping context, I would really
> want to avoid that and just support the MMIO path exclusively, is that
> practical? If that means ditching support for Pi 1&2, that would be
> reasonable IMHO.

I agree that an MMIO-only path would be best, and for System-level
monitoring, it is exactly what we do. However, dropping the firmware
IPC path doesn't just ditch support for the Pi 1 & 2. The VideoCore
VPU monitoring requires the firmware mailbox interface on all SoCs up
through the Raspberry Pi 4 (BCM2711). Removing the firmware polling
thread would effectively kill all VPU performance profiling for the Pi
3, Pi 4, and Compute Modules 3/4.

The downstream vendor driver
(https://github.com/raspberrypi/linux/blob/rpi-6.18.y/drivers/perf/raspberr=
ypi_axi_monitor.c#L730)
similarly relies on this mailbox IPC bridging. My code in
rpi_axi_pmu__init does fall back to MMIO if the firmware node isn't
present, but  (as I understand things) physically mapping the VPU
blocks directly via MMIO on BCM2835-2711 hardware doesn't work. As
such the workqueue latency complexity is unfortunately a requirement
to support VPU profiling on anything older than a Pi 5.

> > +
> > +#include <linux/cpuhotplug.h>
> > +#include <linux/cpumask.h>
> > +#include <linux/hrtimer.h>
> > +#include <linux/io.h>
> > +#include <linux/version.h>
> > +
> > +#if LINUX_VERSION_CODE < KERNEL_VERSION(6, 13, 0)
> > +static inline void rpi_hrtimer_setup(struct hrtimer *timer,
> > +                                  enum hrtimer_restart (*function)(str=
uct hrtimer *),
> > +                                  clockid_t clock_id, enum hrtimer_mod=
e mode)
> > +{
> > +     hrtimer_init(timer, clock_id, mode);
> > +     timer->function =3D function;
> > +}
> > +#define hrtimer_setup rpi_hrtimer_setup
>  > +#endif> +#include <linux/lockdep.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/of.h>
> > +#include <linux/perf_event.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/vmalloc.h>
> > +#include <linux/workqueue.h>
> > +
> > +#include <soc/bcm2835/raspberrypi-firmware.h>
> > +
> > +/* --- PLATFORM CONSTANTS & ENUMERATIONS --------------------------- *=
/
> > +
> > +/**
> > + * enum rpi_axi_chip - Supported Broadcom SoC generations
> > + * @CHIP_BCM2835: BCM2835 / BCM2836 / BCM2837 / BCM2711 (RPi 1-4, CM 1=
-4, Zero/W)
> > + */
> > +enum rpi_axi_chip {
> > +     CHIP_BCM2835 =3D 0,
> > +};
> > +
> > +enum monitor {
> > +     MON__SYSTEM =3D 0,
> > +     MON__VPU,
> > +     MON__MAX
> > +};
> > +
> > +/* Number of hardware bus watcher units per monitor */
> > +#define NUM_BUS_WATCHERS_PER_MONITOR 3
> > +
> > +/**
> > + * enum bcm2835_system_bus - AXI buses monitored by System Monitor on =
BCM2835-BCM2711 (RPi 1-4)
> > + * @BCM2835_SB__DMA_L2: DMA engine L2 cache interconnect bus
>
> Why the double underscore in the naming convention?

I'll change them to single underscores. In the perf tool we use double
underscores similar to how function names do, for example:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/parse-events.h#n57
But this doesn't appear to be kernel/driver style and so I'll use
single underscores.

> [snip]
>
> > +
> > +/* Hardware register offsets & control bitwise constants */
> > +#define GEN_CTRL                     0x00
> > +#define GEN_CTL_ENABLE_BIT           BIT(0)
> > +#define GEN_CTL_RESET_BIT            BIT(1)
> > +#define GEN_CTL_WATCH_BIT            BIT(2)
> > +
> > +#define BW_PITCH                     0x40
>
> Rather than pitch, maybe stride?

Done.

> > +#define BW0_CTRL                     0x40
> > +#define BW1_CTRL                     0x80
> > +#define BW2_CTRL                     0xc0
> > +
> > +#define BW_ATRANS_OFFSET             0x04
>
> That's confusing, so you are offsetting from the base of BW0_CTRL, that
> needs a comment to explain that offset choice.

Done.

> > +#define BW_ATWAIT_OFFSET             0x08
> > +#define BW_AMAX_OFFSET                       0x0c
> > +#define BW_WTRANS_OFFSET             0x10
> > +#define BW_WTWAIT_OFFSET             0x14
> > +#define BW_WMAX_OFFSET                       0x18
> > +#define BW_RTRANS_OFFSET             0x1c
> > +#define BW_RTWAIT_OFFSET             0x20
> > +#define BW_RMAX_OFFSET                       0x24
> > +
> > +#define BW_CTRL_RESET_BIT            BIT(31)
> > +#define BW_CTRL_ENABLE_BIT           BIT(30)
> > +#define BW_CTRL_ENABLE_ID_FILTER_BIT BIT(29)
> > +#define BW_CTRL_LIMIT_HALT_BIT               BIT(28)
> > +
> > +#define BW_CTRL_BUS_WATCH_SHIFT              0
> > +#define BW_CTRL_BUS_WATCH_MASK               GENMASK(5, 0)
> > +#define BW_CTRL_BUS_FILTER_SHIFT     8
> > +#define BW_CTRL_BUS_FILTER_MASK              GENMASK(12, 8)
> > +
> > +/*
> > + * RPI_AXI_PMU_TIMER_INTERVAL determines the background polling freque=
ncy
> > + * for VideoCore VPU Mailbox IPC counters.
> > + *
> > + * A balance is required:
> > + * - IPC Overhead: Polling overly fast (e.g., 10ms) generates excessiv=
e CPU
> > + *   wakeups and VideoCore IPC interrupts on older CPUs (Pi 1/2).
> > + * - Accuracy: Polling overly slow (e.g., 2000ms) causes short time-mu=
ltiplexed
> > + *   profiling sessions (under the interval) to mathematically strand =
residual
> > + *   counts since the mailbox cannot be queried synchronously inside p=
mu->read().
> > + *
> > + * 100ms (10 Hz) provides reasonably accurate profiling without heavy =
overhead.
> > + */
> > +#define RPI_AXI_PMU_TIMER_INTERVAL ms_to_ktime(100)
> > +
> > +static enum cpuhp_state rpi_axi_pmu_cpuhp_state;
> > +
> > +/* --- PMU API & CONFIG DECODING ---------------------------------- */
> > +
> > +#define PMU_NAME "rpi_axi_pmu"
> > +
> > +/**
> > + * config_to_filter() - Extracts AXI filter ID from perf event config
> > + * @config: 64-bit config value from struct perf_event_attr
> > + *
> > + * Return: Filter ID value (bits 10-14).
> > + */
> > +static int config_to_filter(__u64 config)
> > +{
> > +     return (config >> 10) & 0x1F;
>
> Can we have a definition for the shift and mask here?
>
> > +}
> > +
> > +/**
> > + * config_to_monitor() - Extracts Monitor ID from perf event config
> > + * @config: 64-bit config value from struct perf_event_attr
> > + *
> > + * Return: Monitor enum (bit 9: 0 =3D System, 1 =3D VPU).
> > + */
> > +static enum monitor config_to_monitor(__u64 config)
> > +{
> > +     return (config >> 9) & 1;
>
> Likewise.
>
> > +}
> > +
> > +/**
> > + * config_to_bus() - Extracts bus index from perf event config
> > + * @config: 64-bit config value from struct perf_event_attr
> > + *
> > + * Return: Bus index (bits 4-8).
> > + */
> > +static int config_to_bus(__u64 config)
> > +{
> > +     return (config >> 4) & 0x1F;
>
> Likewise
>
> > +}
> > +
> > +/**
> > + * config_to_counter() - Extracts metric counter type from perf event =
config
> > + * @config: 64-bit config value from struct perf_event_attr
> > + *
> > + * Return: Counter enum (bits 0-3).
> > + */
> > +static enum counter config_to_counter(__u64 config)
> > +{
> > +     return config & 0xF;
>
> And here as well.

For all, yes. Done.

> [snip]
>
> > +     for (int i =3D 0; i < MON__MAX; i++) {
> > +             rpi_axi_hw_events__init(&pmu->monitor[i].hw_events);
> > +
> > +             if (pmu->monitor[i].use_mailbox_interface) {
> > +                     struct resource *resource =3D platform_get_resour=
ce(pdev, IORESOURCE_MEM, i);
> > +
> > +                     if (!resource) {
> > +                             dev_err(dev, "Error reading mailbox resou=
rce %d\n", i);
> > +                             ret =3D -EINVAL;
> > +                             goto err_firmware_put;
> > +                     }
> > +                     pmu->monitor[i].mailbox =3D (u32)resource->start;
> > +             } else {
> > +                     struct resource *resource =3D platform_get_resour=
ce(pdev, IORESOURCE_MEM, i);
>
> Well you are fetching MMIO resources here, so you need a Device Tree
> description and you need to submit the Device Tree changes that describe
> these register ranges. Is it fair to assume only the RPi firmware path
> has been tested or did you also test with MMIO?

I tested with both, MMIO only on RPi 5 and firmware+MMIO for the
RPi400. I'm very ignorant of Device Tree YAML, but with AI help I can
generate, lint and test the file as an extra patch for the series.

> [snip]
> > +
> > +MODULE_LICENSE("GPL");
> Missing MODULE_AUTHOR() and MODULE_DESCRIPTION().

Done.

Thanks, the fixes will be incorporated into v12.
Ian

> --
> Florian
>
