Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794512297;
	b=fmo3aaZI8odgJYGeHlTKmGIH2P2NFg8Ine7ocGJEMMNTSu4kk2EDgUhGMdbkLdlytLmD
	 bhRmErdXE3YBv70YKoimclD0qAGFWDBPVzJLfDITalhrQ8DzSSgQ/K0jFBE1wbMLBgXF/
	 h9xwqylagwc+9y86Cbs0+XFh5TbYEvZK/Xc3LCTJqXLjnsRLdhZgIFr+e71rWAvOaCsME
	 WjFaHM7Lqf8dCrixEStwYDSSnZEAxINhYha4Zo2qtwFu9R8Qp5lyAo2h+nlIfMtN+TR2a
	 2uzPaF3oOzK+XtbBlEj1El9DlhpYQx8HP15tDAxX/aMQ33+kd3KrNfj1flfUUWdVc4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794512297;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lJ9QgaLOzkUtMdUK63NnalxOl+sZYEKA9wkgoAmW1ys=;
	b=YOvfMaYbsvmA9C/4R9OqGSA2e6k37wmMpUBTFKxIfKkeQa5MfnE5XjllJESLW2CBiyBf
	 L/T3GPF2a3LA6IL7FTRIqs7BufdWJcGfod4xBVgNdaBNeXQIcmzOZdIPJrEsw3GV3VsvW
	 b1no99+5x9Ktlfen+6eBkZDLn/tIUuTIcLIBBuCAk9tEa+DU+TzDN0SH0aqwQZZficy5n
	 T6Zbn3R7MXZOPLu2t0ij2u1ZVLcRmvAxl3OkdwKI+TbahVrV24JxPzaKRKyYhjihy/Utr
	 1Lx3bjrsM/hcSehOXzw4MW5Qm6F//27TXnGpLa9lJNt99XLwszwFbG+a44OHO0XDnjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mSfzsfcv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C176606A321
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mSfzsfcv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38C11F000C4;
	Thu, 12 Nov 2026 19:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794512296;
	bh=lJ9QgaLOzkUtMdUK63NnalxOl+sZYEKA9wkgoAmW1ys=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mSfzsfcvSey31uMprdV1iPGkEG4SteAxFoc7gUJDgF9fnHj7KUBnvM31/dQaEjdr0
	 EX5ISAC+0sOTe++8dtH8ejTxGfKn48svVTcIMvP92Q5Spn74Q43aoJY6WZHuch73OE
	 r9SAi78WtcnEgngTIT7e3DSUlLAcfqnz31OHb8oyBXdmG/WrROSTn8l9v8q8IEWQq9
	 tM1hOLc6OiwPuxGR4U89OaVFXODWdKnUZr5k5B3dd5lEwxIPc4UdJnCPErYnu6myMb
	 OkRv7rKSCu+D0lRKZVkaYC04m9ZL1rbx6FzvrxpFKxPQMQolvfTzVe+mZcRPm/4/CO
	 bP0zffUowOZ1w==
Message-ID: <sashiko-outbox-211771@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] MIPS: perf: Add SB1 and SB1A performance counter
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <f.fainelli@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBFUkZPUk1BTkNFIEVWRU5UUyBTVUJTWVNURU0=?= <linux-perf-users@vger.kernel.org>
In-Reply-To: <20261112190916.3725141-4-f.fainelli@gmail.com>
References: <20261112190916.3725141-1-f.fainelli@gmail.com>
 <20261112190916.3725141-4-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 19:38:16 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] MIPS: perf: double hw_perf_event_destroy() call when
  validate_group() fails
- [Medium] MIPS: perf: IP7 left unmasked after irq_work_run() disables
  last SB1 event
- [Medium] MIPS: perf: mipspmu_event_init() returns -EOPNOTSUPP before
  checking attr.type
- [Low] docs: mips: sb1-pmu: heading underline too short for section
  title
--

commit 4595e65c6c56d05599f7d396b72896c6da74a174
Author: Florian Fainelli <f.fainelli@gmail.com>

MIPS: perf: Add SB1 and SB1A performance counter support

This commit adds MIPS PMU support for the four CPU-local performance
counters on SB1 and SB1A processors, along with sysfs event aliases and
documentation.

> diff --git a/Documentation/arch/mips/sb1-pmu.rst b/Documentation/arch/mip=
s/sb1-pmu.rst
> new file mode 100644
> index 0000000000000..d589a6262c65f
> --- /dev/null
> +++ b/Documentation/arch/mips/sb1-pmu.rst
> @@ -0,0 +1,162 @@

[ ... ]

> +Counter selection and mode filtering
> +-----------------------------------

[Severity: Low]
The hyphen underline here is 35 characters for a 36-character heading,
which triggers a Sphinx "Title underline too short" warning during
htmldocs builds.

> diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf=
_event_mipsxx.c
> index 196a070349b09..765cdb6f8cae3 100644
> --- a/arch/mips/kernel/perf_event_mipsxx.c
> +++ b/arch/mips/kernel/perf_event_mipsxx.c

[ ... ]

> @@ -564,6 +627,14 @@ static void mipspmu_enable(struct pmu *pmu)
>  	write_unlock(&pmuint_rwlock);
>  #endif
>  	resume_local_counters();
> +	if (is_sb1_pmu() &&
> +	    !bitmap_empty(this_cpu_ptr(&cpu_hw_events)->used_mask,
> +			  mipspmu.num_counters) &&
> +	    !irq_percpu_is_enabled(mipspmu.irq)) {
> +		/* Count/Compare shares IP7, but SiByte uses a separate timer. */
> +		write_c0_compare(read_c0_count() - 1);
> +		enable_percpu_irq(mipspmu.irq, IRQ_TYPE_NONE);
> +	}
>  }
> =20
>  /*
> @@ -579,6 +650,8 @@ static void mipspmu_enable(struct pmu *pmu)
>   */
>  static void mipspmu_disable(struct pmu *pmu)
>  {
> +	if (is_sb1_pmu() && irq_percpu_is_enabled(mipspmu.irq))
> +		disable_percpu_irq(mipspmu.irq);
>  	pause_local_counters();
>  #ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS
>  	write_lock(&pmuint_rwlock);

[Severity: Medium]
Can this leave IP7 unmasked in hardware when the last event on a CPU is
disabled from inside the PMU interrupt handler?

handle_percpu_devid_irq()
  chip->irq_ack()                    /* mask_mips_irq() masks IP7 */
  mipsxx_pmu_handle_irq()
    mipsxx_pmu_handle_shared_irq()
      handle_associated_event()
        perf_event_overflow()        /* queues pending_disable_irq */
      irq_work_run()
        perf_pending_disable()
          ...
            mipspmu_disable()
              disable_percpu_irq()   /* clears percpu_enabled, masks IP7 */
            mipspmu_del()            /* clears last bit in used_mask */
            mipspmu_enable()         /* used_mask empty, skips enable */
  chip->irq_eoi()
    unmask_mips_irq()                <-- unmasks IP7 in CP0 Status

When a sampling event with a refresh limit (PERF_EVENT_IOC_REFRESH)
overflows and auto-disables via irq_work_run(), disable_percpu_irq()
clears the CPU in desc->percpu_enabled, but handle_percpu_devid_irq()
then runs chip->irq_eoi() (unmask_mips_irq()), which sets STATUSF_IP7
again.  That leaves IP7 unmasked with no events scheduled while
irq_percpu_is_enabled() returns false, so spurious interrupts fire
whenever CP0 Count wraps past Compare and sb1_pmu_cpu_offline() will
also skip masking IP7.

[ ... ]

> @@ -657,6 +737,10 @@ static int mipspmu_event_init(struct perf_event *eve=
nt)
>  	if (has_branch_stack(event))
>  		return -EOPNOTSUPP;
> =20
> +	if (is_sb1_pmu() && (event->attr.precise_ip || event->attr.config1 ||
> +			     event->attr.config2))
> +		return -EOPNOTSUPP;
> +
>  	switch (event->attr.type) {
>  	case PERF_TYPE_RAW:
>  	case PERF_TYPE_HARDWARE:

[Severity: Medium]
Should the precise_ip, config1 and config2 check come after the
event->attr.type switch?

Checking those fields first makes mipspmu_event_init() return
-EOPNOTSUPP instead of -ENOENT for events that do not target this PMU
(for example, PERF_TYPE_BREAKPOINT where bp_addr and bp_len union with
config1 and config2, or any PMU registered after mipspmu), causing
perf_init_event() to abort its PMU list walk early.

> @@ -683,7 +767,10 @@ static int mipspmu_event_init(struct perf_event *eve=
nt)
>  	if (err)
>  		return err;
> =20
> -	return __hw_perf_event_init(event);
> +	err =3D __hw_perf_event_init(event);
> +	if (err && is_sb1_pmu() && !event->destroy)
> +		hw_perf_event_destroy(event);
> +	return err;
>  }

[Severity: High]
Does a failure in validate_group() cause hw_perf_event_destroy() to run
twice for the same event?

arch/mips/kernel/perf_event_mipsxx.c:__hw_perf_event_init() {
    ...
	if (event->group_leader !=3D event)
		err =3D validate_group(event);

	event->destroy =3D hw_perf_event_destroy;

	if (err)
		event->destroy(event);

	return err;
}

When validate_group() fails (such as when a fourth non-cycle event is
added to a group), __hw_perf_event_init() calls event->destroy(event)
and returns err with event->destroy still set to hw_perf_event_destroy.
Because perf_try_init_event() skips clearing event->destroy on
event_init() failure, perf_event_alloc()'s __free(__free_event) cleanup
calls event->destroy(event) a second time.  That decrements
active_events twice for one increment, dropping active_events to zero
while the group's earlier events are still open and resetting hardware
counters across all CPUs via on_each_cpu(reset_counters, ...).

Also, gating the !event->destroy cleanup on is_sb1_pmu() leaves
active_events leaked on non-SB1 MIPS PMUs when __hw_perf_event_init()
fails before setting event->destroy.  If __hw_perf_event_init() only
sets event->destroy after validate_group() succeeds (or clears it after
calling it), mipspmu_event_init() can handle the error cleanup in one
place.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112190916.3725=
141-1-f.fainelli@gmail.com?part=3D3
