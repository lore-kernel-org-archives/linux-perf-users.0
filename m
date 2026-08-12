Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4F139E18E
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 23:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786576052; cv=pass; b=kDuDnE+ApS+FqA9ve6/4qcb+KTNTterOM92v7bWgYEjisDo6LI86I/ztM2mopzuJT5eEHXXRs3pZgW1JZcnf8jMitghs1eTGm1JGz0vvnl4qs7SiN+kBKeViE+zMUL9LjzZaZPw8VXmCTKdY9Zmt02XsC1mK40kzWa5Y0COnzFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786576052; c=relaxed/simple;
	bh=6Ehmlq/D4DOy3TOG1WHmSvUBrL03NzbG/3Hl3B7GNLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISiWfkvequ7Q2xCZ7rOyojOph/tXLN6NAvkKkbyamKTyoEEK8dNhQKK9VdLslBvtUw1Q/2D7zE9NM7AKhpbqVlN/+MU26Tro5g03TrtNYUZy1il+NYFyrjrOodbvS4neRUC4xBVDuNeRPHxDpOhZ126OgQZFFXYtCf9seCz2cQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PUn3HWIr; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PUn3HWIr"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c15a5b265so50811cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 16:07:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786576049; cv=none;
        d=google.com; s=arc-20260327;
        b=DBlYcmukeMjxfgmL4vyIRtSFMBMKlHjuVGBME9VMT3i0lRyHZUYNjOig8GA2L4xm8D
         BSISJHooAxqfzjlHI4VMKua1FhQmGbN8ivecsfeLwsL9WXDBkXKj1THmkIhXNgZwIOob
         B+/Z54U9TmwrNN6t5PZPWSy4Xbi3Tpc7HaizBqL6fYfsI/EwwQ0m4HSDPRG/xY0QtOnK
         t9PDs3//eZ5y3tpNUFnuw/P7imyKR1BvlCnYjilFyGQbLftYFesJxvCt1TVkyaD+KpwR
         tgzyBRPMbDVmej9xcQ+RaggQ9mZqVmeNuvv28XgeV7QaStIzqfHool3WXikrDCaI2Zs2
         yOhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SFcodwmDIy+Gd4R7lV09KRPKxABL9MdXCvTTH0eN1Cc=;
        fh=twF4UoIb2d1ocSbS1rh7YhnFbsO2YoxhK93Cc/LMqXY=;
        b=XYIpDck3iriN9G3vzCAXw0QRvSJG63ndHeChZHRozLFTQJXQZUaaLQpvX1D9h7bqeG
         bnSTtXD931y2fxtvDcBK7MspEvX4OxKYSQeu+bF4nxag38RyHPB0EZLeTIBhzmifh2k5
         Ovna5Rus3q6v8X5r6kYViVaxr7dil/vXEVS5xdTieYGoKPt+90pJ4W6mWCTIBGNlxDVg
         qhB4V31jbI2OBNJ++Ccy4u+narvLJAB++AYnjEiiVV0XSmJBQJsI+N/sRXU3+yFxYmXR
         jNUKYl7C555/yPVyEOacGUR8U+ees7x0gEsCl0tikHWa3ipX6TSPLIweUI1zAql552eo
         oSJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786576049; x=1787180849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SFcodwmDIy+Gd4R7lV09KRPKxABL9MdXCvTTH0eN1Cc=;
        b=PUn3HWIrhUEa3LVchjC47XJ8p2vY1/ihd6cTy9oEKXV1+yEXA4ftauQF5pyPNX0fB5
         9h4QgDlBNL2f6vMnsPRhD6Q9gcm1ZfigS5Uu2VvF7T3lJSDTOmoetHLwEChKFkTM9zfI
         9r+Hn7FPey5sbwvQY0FkjxV3635bfiU3edyyDX1pUJiBpcMiTK73xEf1DbeOLMVHQO3F
         AVUQXV3ejHow+DbKgvxMH4N6P8sQ5vG87iLKxneXtRTU6PJ8YrfZnHN9OqhQdeXN3rVE
         wTgKrElUEDkFkVMmp6HavjbNboqD9lU//pzwxGJbjhnOMqLm1XMnikFc2y/7ejU1A9iP
         iZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786576049; x=1787180849;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SFcodwmDIy+Gd4R7lV09KRPKxABL9MdXCvTTH0eN1Cc=;
        b=D/57RNa6xw19c1ULCviOsNthhcMAxZkhkSVS6sPCpw77ZC6cTlCI6iIVs8Fbwb3Hc/
         BbbN7J9xop3+lItSsrFtRWuBBlnECTp/soUl30r+rEILpBub8nztEKxki4RShnHDwLtb
         3sWw20CcMrERfntFK+ENIJEQHU1fFQqbgwKOoR5CuUhPvf53Jm1KCSrh4kvb5n8Fd+3i
         gXW91+Z6EVDMo6zSGpXX0uE9OjpUtbNn/x7dxFUkjOnbvuxnbJz9G7nedcz9jjqW1JOG
         gY8zQfF+DYP3w5xoUrYu8/MgO0GhAvaUdOcWhI3bx7h+opk0dxjs9vUXLIKLfY8kS092
         3vtg==
X-Forwarded-Encrypted: i=1; AHgh+Rr+wCoPilrccs9BdxSGi+86HUe8MXsxqRN4eqVRApYwDAEjGKvycUG/oSurNClDQkCkcihO8YUMMwXdQU+LxcYI@vger.kernel.org
X-Gm-Message-State: AOJu0YxwD0l5H3q/Uqrr6Sf2rUrrnSV5EMPzwrZzvMcnZtM5tCsygA9c
	8p+O+vXNPOcNiA0r4pz9OxM387paArl1+Fgk5T+fFcmTnEJDsGh9qUqPzLkF8Smh1Mt35lcFsZ+
	vc0oQMIOAeuC0yFW2oqyohV201+qLeSE2u5hK8MI9
X-Gm-Gg: AR+sD11gB5sIuiExBRWFfFucDGD8CC6W8xzeH6erl3YTovQolB8mB1fBNKVnebr0GNZ
	aKccwVYVmsefcgE/OaIp8vxXMzq84a2j+Oe+zIW7z85oARBauDkXSw9f+RXuHKXZe6R7b4z0AaX
	WNRhgpUkVEPZdvDIlyN7+0lgnGKSvWVWleI+PB3zdRItT8TcwtnunXHwRZiUpOg289AtZP9SyW/
	khPBlb5jSejvx8qb5iHL+j7MFN+9DiMYnBpWEijg+xpFBHP0ZJx4aXw5XPN+BvT7GS9bfpbZ4xw
	p0l6DzAt1Upidm9MP8yVgSSWNXWpdVcBTQBbPo1zHw+UqQ==
X-Received: by 2002:a05:622a:8309:b0:516:3f51:81cb with SMTP id
 d75a77b69052e-52d76e23471mr1528471cf.13.1786576048670; Wed, 12 Aug 2026
 16:07:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812052417.2361040-1-irogers@google.com> <20260812230145.2644281-1-irogers@google.com>
In-Reply-To: <20260812230145.2644281-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Aug 2026 16:07:17 -0700
X-Gm-Features: AUfX_myXsv2K8Mqlk39c54O9OerfvDcM6ed2LHp_euFxlKHIDMHz8JbC7OpreR0
Message-ID: <CAP-5=fX_zxDai0A1mSEX-Q6os4drJLLh92o32rbdZsJ=C3YZoQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] perf: Add Raspberry Pi AXI PMU driver
To: irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mark.rutland@arm.com, u.kleine-koenig@baylibre.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 4:01=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> This patch series adds an uncore Performance Monitoring Unit (PMU) driver
> for Broadcom AXI system and VideoCore VPU performance monitors found on
> Raspberry Pi SoCs (BCM2835 through BCM2712 / Raspberry Pi 1 through 5).
>
> Motivation & Background
> ------------------------
> Currently, Linux lacks a standard perf-API compatible driver for the
> Broadcom AXI performance counter blocks on Raspberry Pi platforms. Prior
> out-of-tree vendor solutions relied on custom debugfs nodes and ad-hoc
> kthreads, preventing integration with standard Linux perf tooling (`perf =
stat`,
> `perf list`, etc.).
>
> This driver implements standard `struct pmu` hardware uncore callbacks
> under `drivers/perf/`, exposing human-readable sysfs event aliases, unit
> scaling (`Bytes`), and bus filtering directly to user space.
>
> Key Architectural Improvements & Features
> ------------------------------------------
> 1. Standard Linux Perf Integration:
>    - Exposes uncore AXI interconnect events via `/sys/bus/event_source/de=
vices/rpi_axi_pmu/`.
>    - Supports event sampling and hardware counter accumulation (`local64_=
add`),
>      automatically managing 31-bit hardware counter wraparound across hig=
h-bandwidth
>      interconnect transfers.
>
> 2. CPU Hotplug Support (`cpuhp`):
>    - Registers dynamic CPU hotplug notifiers (`CPUHP_AP_ONLINE_DYN`).
>    - Automatically migrates PMU context (`perf_pmu_migrate_context`) to a=
n online
>      CPU core when a designated CPU goes offline, avoiding stale uncore s=
tate.
>
> 3. Hybrid Memory-Mapped & Mailbox Work Queue Architecture:
>    - System Monitor (MMIO): Performs fast atomic-safe memory reads (~15ns=
)
>      directly mapped over ARM physical memory space (`MON__SYSTEM`).
>    - VPU Monitor (Mailbox IPC): For Broadcom BCM2835-BCM2711 platforms (R=
Pi 1-4),
>      VideoCore VPU monitor IPC calls are offloaded to process context via=
 a dedicated
>      workqueue (`vpu_work`) and serialized under `vpu_mutex`. This avoids=
 atomic
>      sleeps or blocking in timer/interrupt context.
>
> 4. PREEMPT_RT & Safety Hardening:
>    - Uses HRTIMER_MODE_REL_SOFT for timer callbacks to execute in softirq=
 context,
>      ensuring spinlock acquisitions are 100% PREEMPT_RT safe.
>    - Sets suppress_bind_attrs =3D true to prevent unsafe manual sysfs unb=
inding while
>      active perf events exist.
>
> 5. SoC Generation Support:
>    - Patch 1 adds core driver support for Broadcom BCM2835-BCM2711 (RPi 1=
-4).
>    - Patch 2 expands support for Broadcom BCM2712 (Raspberry Pi 5), addin=
g PCIe RP1
>      Southbridge links, HEVC decoder, HVS display engine, and Cortex-A76 =
DSU L3
>      interconnect monitoring.
>
> Hardware Validation
> -------------------
> The driver has been validated on real hardware across multiple SoC genera=
tions:
> - Raspberry Pi 400 (BCM2711): Validated System L2, ARM CPU, and VideoCore=
 VPU
>   firmware mailbox IPC performance counters.
> - Raspberry Pi 5 (BCM2712): Validated live byte throughput across HVS dis=
play
>   refresh cycles, Cortex-A76 DSU L3 interconnect memory traffic, and PCIe=
 RP1
>   Southbridge transfers.
>
> Changes in v5
> -------------
> - Teardown UAF/Orphaning Fix: Reversed module exit logic, calling cpuhp_s=
tate_remove_instance()
>   *before* perf_pmu_unregister() to prevent accessing an unregistered PMU=
 in the offline
>   CPU handler during device removal, and to prevent event orphaning races=
 during hotplug.
> - VPU Hardware Watcher Leak Fix: In rpi_axi_pmu_del(), hardware disableme=
nt operations for VPU
>   bus watchers are now properly deferred to the vpu_work workqueue to avo=
id silently leaking
>   running hardware counters when the VPU monitor is no longer in use.
> - Grouped Event Start Bug Fix: Deprecated reliance on num_monitored =3D=
=3D 1 to initialize
>   the global bus watcher. Instead, use a dedicated monitor_running flag c=
orrectly to
>   start the global monitor when the first bus watcher gets enabled, mitig=
ating bugs when
>   adding grouped PMU events.
> - IPC Phantom Spikes Zero Fallback Fix: Modified rpi_axi_pmu_read_counter=
() to return U32_MAX
>   on IPC or MMIO hardware read failures, gracefully ignoring the delta ca=
lculation returning.
>   This fixes unsigned 31-bit huge spikes where delta (0 - old_count) & 0x=
7FFFFFFF occurred.
> - Code Comments: Added doc block comments inside rpi_axi_pmu_read(), rpi_=
axi_pmu_vpu_work_handler(),
>   and everywhere U32_MAX returns occur to document the explicit justifica=
tion for why U32_MAX indicates
>   failure (valid counters are 31-bit) and why the driver drops the sample=
 to avoid artificial spikes.
> - VPU Data Race Lockdep Fix: Rewrote locking hierarchy inside vpu_work_ha=
ndler(). PMU spinlock
>   is now correctly held across rpi_axi_pmu_enable_bus_watcher() unconditi=
onally since the function
>   touches active monitor registers directly via MMIO, dropping it purely =
for mailbox IPC reads.
> - Hrtimer Add/Del Forward Concurrency Warning Fix: rpi_axi_pmu_timer_hand=
ler() now executes
>   hrtimer_forward_now() *before* releasing the PMU spinlock, fully mitiga=
ting timer enqueue races
>   resulting from a simultaneous parallel pmu->add()/pmu->del().
> - VPU Start Asynchronous Latency: Added explicit schedule_work(&pmu->vpu_=
work) call inside
>   rpi_axi_pmu_start() when starting VPU-tracked events so they begin imme=
diately instead of
>   waiting for a 2-second timer interrupt period for short workloads.
> - Event Stop Read-Modify-Write Spinlock Protection: Moved event->hw.state=
 modifications inside
>   rpi_axi_pmu_stop() under the local CPU PMU irqsave spinlock to safeguar=
d atomic bitwise flags
>   against the timer handler or workqueue updates.
> - BCM2712 Pre-probe Initializer UAF race: Shifted perf_pmu_register() to =
the very end of
>   rpi_axi_pmu__init() to ensure all hardware structures and CPU HP bindin=
gs securely exist prior to
>   exposing the PMU to userspace tools preventing devres unregistration me=
mory faults.
> - BCM2712 ARM CPU L2 Event Correction: Corrected the bus index for the Co=
rtex-A76 Cores PMU event
>   aliases to bus=3D14 (BCM2712_SB__CPU_L2) to match architectural routing=
 specifications on the RPi 5.
> - BCM2712 JPEG Bus Monitor Visibility: Stopped improperly hiding the lega=
cy JPEG bus aliases in the
>   is_visible() callback on BCM2712 chips.
> - BCM2712 Custom Event Replacements: Created specific BCM2712 equivalents=
 for peripheral_rtrans/wtrans
>   and cpu_uc_rtrans/wtrans since raw bus mappings shifted structurally on=
 VideoCore VII.

Sorry, inadvertently added TAG=3Dagy. Will resend with this removed.

Thanks,
Ian

> Ian Rogers (2):
>   perf: Add Raspberry Pi BCM2835 AXI PMU driver
>   perf: Add Raspberry Pi 5 (BCM2712) AXI PMU support
>
>  drivers/perf/Kconfig       |   10 +
>  drivers/perf/Makefile      |    1 +
>  drivers/perf/rpi_axi_pmu.c | 2078 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 2089 insertions(+)
>  create mode 100644 drivers/perf/rpi_axi_pmu.c
>
> --
> 2.55.0.679.g6767b8d81c-goog
