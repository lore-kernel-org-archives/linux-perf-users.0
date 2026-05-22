Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8BA331A57;
	Fri, 22 May 2026 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779468063; cv=none; b=L5NH807jodz2MUCF/PakAFmRgxhXx2Fc+tcXP/+fxx66J6xpGpugtalM7IYpnUcLtlkNt6C84uQl/0eujzjXQI3g60ZueVYuBiTleyKp4bBqN+u0np8Tdtdp5U6/Zd0CEJN+xMGieCq798t9fW5/EpXLDE5S9nzKtRuBR76EDso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779468063; c=relaxed/simple;
	bh=haSuWwP8C9BC6WWJ0jKiey9smerX8UhlwDcUUBEB1RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeZAkR6w6UW5AyCGCjuItbd35jbSYC09iGGmEBEndjytIGNFmvRS9soQDR1kZy0VbOKavfu4X1VYDc5Oc6JbgkLnyM05mpp6eAY1iRGWHZUB/CyQR1s2bb0soOOv7l0N2DRPjfCJg7M7eDa2+UcY5NwVohP/dsTbg+rlgqmLXGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmkoLCsX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmkoLCsX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031011F000E9;
	Fri, 22 May 2026 16:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779468062;
	bh=FuWcL06181FPZd13yfBndZOpmIjPmrvb9DONpWiPWOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cmkoLCsXFxNISymu++pMPnkWg1DydAxh1i9xCD3TPL6Cnh2bUJ5bJxRKKGAyNDy0L
	 Z1uuYDWfTcKl5L2KRBank6QTLLtCnC4uYrvqfPkdwDc7R2ADlXbVBaLfmsWZwe9TAu
	 fM52AFW6XoczYsM0NFSEbiCArcjFgDFqHjE+S5+gctSAwmef594L2w5EopCdWX9gFP
	 kiq0/h0EQYZxk5i3fUGb2iGSORB7+VXSb6XNNPZcfshy8RtxmBowKIW0ewbh2ZFyfU
	 FjTs2nWXVkOeCo7/iTThD9Tl61Kcmy1EATbrPmDo6gxvIcWqnZt44py3pvDvh8ks/C
	 kE5fInLAYyl8g==
Date: Fri, 22 May 2026 17:40:58 +0100
From: Conor Dooley <conor@kernel.org>
To: sashiko@lists.linux.dev
Cc: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>,
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v9 3/5] drivers: firmware: add riscv SSE support
Message-ID: <20260522-gala-whacky-9aa54fbfb958@spud>
References: <7d86cbd47688700fbdfc27e530e824a6bec0548c.1778331862.3.git.zhangzhanpeng.jasper@bytedance.com>
 <20260509143818.B170EC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VnWZGohPBEbrtc2y"
Content-Disposition: inline
In-Reply-To: <20260509143818.B170EC2BCB2@smtp.kernel.org>


--VnWZGohPBEbrtc2y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 09, 2026 at 02:38:15PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 12 potential iss=
ue(s) to consider:
> - [Critical] Missing braces around `scoped_guard(cpus_read_lock)` in `sse=
_event_unregister` releases lock prematurely, leading to a race condition a=
nd use-after-free.
> - [High] Event registration rollback uses the wrong revert function, leak=
ing firmware registrations and causing use-after-free.
> - [High] Missing validation of `riscv_hartid_to_cpuid` return value leads=
 to out-of-bounds array access.
> - [High] `sse_cpu_teardown` causes out-of-bounds array access on single-C=
PU teardown and fails to unregister global events across reboots.
> - [High] 64-bit physical addresses are silently truncated to 32 bits on R=
V32.
> - [High] CPU hotplug unconditionally enables local events, ignoring drive=
r-defined disabled states.
> - [High] Early release of `cpus_read_lock` in `sse_event_register` causes=
 missed event registration on hotplugged CPUs.
> - [High] `sse_event_alloc_global` calls `smp_processor_id()` in a preempt=
ible context.
> - [High] Missing synchronization in `sse_event_unregister()` leads to use=
-after-free with concurrently executing hardware event handlers.
> - [Medium] `sse_event_set_target_cpu_nolock` silently ignores attribute w=
rite failures.
> - [Medium] Mixing `goto` error handling with `guard()` and `scoped_guard(=
)` declarations violates subsystem cleanup guidelines.
> - [Medium] The commit message claims clients can 'complete SSE events', b=
ut no such API exists.

FWIW, I would like to see some responses to these sashiko reports, they
look pretty numerous, so there's a good chance one of them is valid!

The 2nd medium one looks valid, can probably hit it with a DEFINE_FREE()
for sse_event_free(event) and just return?

The critical one I think deserves a comment in the code if what's there
is okay.

Cheers,
Conor.

> --
>=20
> commit 1f43f4083e7681521e63a564e1ff80519c1569f5
> Author: Cl=E9ment L=E9ger <cleger@rivosinc.com>
> Subject: drivers: firmware: add riscv SSE support
>=20
> This commit adds a driver-level interface for RISC-V SSE support, allowing
> Linux clients to register handlers and manage SSE events. It supports both
> local and global events and handles CPU hotplug and PM transitions.
>=20
> >     Add a driver-level interface for RISC-V SSE support.  The interface=
 lets
> >     Linux clients register handlers and enable, disable and complete SSE
> >     events.  It will be used by PMU and GHES drivers.
>=20
> The commit message states the interface lets clients complete SSE events.
> However, there does not appear to be any API provided to complete an even=
t.
>=20
> Could the commit message be updated to reflect the actual implementation?
>=20
> > diff --git a/drivers/firmware/riscv/riscv_sbi_sse.c b/drivers/firmware/=
riscv/riscv_sbi_sse.c
> > new file mode 100644
> > index 0000000000000..830011ddd33f7
> > --- /dev/null
> > +++ b/drivers/firmware/riscv/riscv_sbi_sse.c
> > @@ -0,0 +1,694 @@
> [ ... ]
> > +static int sse_event_attr_get_no_lock(struct sse_registered_event *reg=
_evt,
> > +				      unsigned long attr_id, unsigned long *val)
> > +{
> > +	struct sbiret sret;
> > +	u32 evt =3D reg_evt->event->evt_id;
> > +	unsigned long phys;
> > +
> > +	phys =3D sse_event_get_attr_phys(reg_evt);
>=20
> Can this physical address be truncated on RV32 systems?
>=20
> When CONFIG_ARCH_PHYS_ADDR_T_64BIT is enabled, physical addresses are 64 =
bits,
> but unsigned long is 32 bits. Will the firmware receive a corrupted 32-bit
> physical address since the ABI expects 64-bit values to be passed in two
> registers on RV32?
>=20
> [ ... ]
> > +static int sse_event_attr_set_nolock(struct sse_registered_event *reg_=
evt,
> > +				     unsigned long attr_id, unsigned long val)
> > +{
> > +	struct sbiret sret;
> > +	u32 evt =3D reg_evt->event->evt_id;
> > +	unsigned long phys;
> > +
> > +	reg_evt->attr =3D val;
> > +	phys =3D sse_event_get_attr_phys(reg_evt);
>=20
> Is this subject to the same RV32 physical address truncation mentioned ab=
ove?
>=20
> [ ... ]
> > +static int sse_event_set_target_cpu_nolock(struct sse_event *event,
> > +					   unsigned int cpu)
> > +{
> > +	unsigned long hart_id =3D cpuid_to_hartid_map(cpu);
> > +	struct sse_registered_event *reg_evt =3D event->global;
> > +	u32 evt =3D event->evt_id;
> > +	bool was_enabled;
> > +	int ret;
> > +
> > +	if (!sse_event_is_global(evt))
> > +		return -EINVAL;
> > +
> > +	was_enabled =3D reg_evt->is_enabled;
> > +	if (was_enabled)
> > +		sse_event_disable_local(event);
> > +
> > +	ret =3D sse_event_attr_set_nolock(reg_evt, SBI_SSE_ATTR_PREFERRED_HAR=
T,
> > +					hart_id);
> > +	if (ret =3D=3D 0)
> > +		sse_global_event_update_cpu(event, cpu);
> > +
> > +	if (was_enabled)
> > +		sse_event_enable_local(event);
> > +
> > +	return 0;
> > +}
>=20
> Should this function return the error code instead of unconditionally ret=
urning 0?
>=20
> If the SBI call to set the preferred hart fails, the error is masked from=
 the
> caller, leaving the kernel thinking the migration succeeded while the fir=
mware
> state is out of sync.
>=20
> [ ... ]
> > +static int sse_event_alloc_global(struct sse_event *event)
> > +{
> > +	int err;
> > +	struct sse_registered_event *reg_evt;
> > +
> > +	reg_evt =3D kzalloc_obj(*reg_evt, GFP_KERNEL);
> > +	if (!reg_evt)
> > +		return -ENOMEM;
> > +
> > +	event->global =3D reg_evt;
> > +	err =3D sse_event_init_registered(smp_processor_id(), reg_evt, event);
>=20
> Is it safe to call smp_processor_id() here?
>=20
> sse_event_alloc_global() is invoked from sse_event_register(), which only
> holds a mutex and runs with preemption enabled. Could this trigger a warn=
ing
> if CONFIG_DEBUG_PREEMPT is enabled, or allow the thread to migrate
> immediately after, yielding an invalid CPU ID?
>=20
> [ ... ]
> > +struct sse_event *sse_event_register(u32 evt, u32 priority,
> > +				     sse_event_handler_fn *handler, void *arg)
> > +{
> > +	struct sse_event *event;
> > +	int cpu;
> > +	int ret =3D 0;
> > +
> > +	if (!sse_available)
> > +		return ERR_PTR(-EOPNOTSUPP);
> > +
> > +	guard(mutex)(&sse_mutex);
>=20
> This isn't a bug, but is it intended to mix goto-based error handling with
> scope-based guard declarations in the same function?
>=20
> The cleanup subsystem documentation recommends against this pattern as it=
 can
> create confusing ownership semantics.
>=20
> > +	if (sse_event_get(evt))
> > +		return ERR_PTR(-EEXIST);
> > +
> > +	event =3D sse_event_alloc(evt, priority, handler, arg);
> > +	if (IS_ERR(event))
> > +		return event;
> > +
> > +	scoped_guard(cpus_read_lock) {
> > +		if (sse_event_is_global(evt)) {
> > +			unsigned long preferred_hart;
> > +
> > +			ret =3D sse_event_attr_get_no_lock(event->global,
> > +							 SBI_SSE_ATTR_PREFERRED_HART,
> > +							 &preferred_hart);
> > +			if (ret)
> > +				goto err_event_free;
> > +
> > +			cpu =3D riscv_hartid_to_cpuid(preferred_hart);
>=20
> Can riscv_hartid_to_cpuid() return -ENOENT here?
>=20
> If the firmware returns an unknown or unmapped hart ID, it appears the
> negative value is passed to sse_global_event_update_cpu(), which uses it =
to
> index the logical hart array via cpuid_to_hartid_map(), potentially causi=
ng
> an out-of-bounds memory read.
>=20
> > +			sse_global_event_update_cpu(event, cpu);
> > +
> > +			ret =3D sse_sbi_register_event(event, event->global);
> > +			if (ret)
> > +				goto err_event_free;
> > +
> > +		} else {
> > +			ret =3D sse_on_each_cpu(event, SBI_SSE_EVENT_REGISTER,
> > +					      SBI_SSE_EVENT_DISABLE);
>=20
> Should the revert function be SBI_SSE_EVENT_UNREGISTER instead of
> SBI_SSE_EVENT_DISABLE?
>=20
> Disabling an event merely masks it without unregistering it from the firm=
ware.
> If registration fails on any CPU, does this leave the firmware holding an
> active registration pointing to freed memory after the error path frees t=
he
> event structures?
>=20
> > +			if (ret)
> > +				goto err_event_free;
> > +		}
> > +	}
> > +
> > +	scoped_guard(spinlock, &events_list_lock)
> > +		list_add(&event->list, &events);
>=20
> Because the cpus_read_lock is released before acquiring events_list_lock =
to
> add the event to the global list, could a CPU hotplug operation occur in
> this window?
>=20
> If so, sse_cpu_online() would iterate over the list and miss the new even=
t,
> resulting in the event not being registered on the new CPU.
>=20
> > +
> > +	return event;
> > +
> > +err_event_free:
> > +	sse_event_free(event);
> > +
> > +	return ERR_PTR(ret);
> > +}
> [ ... ]
> > +void sse_event_unregister(struct sse_event *event)
> > +{
> > +	scoped_guard(mutex, &sse_mutex) {
> > +		scoped_guard(cpus_read_lock)
> > +			sse_event_unregister_nolock(event);
>=20
> Is there a missing compound block around the cpus_read_lock guard?
>=20
> Without braces, the lock is dropped before acquiring events_list_lock. Co=
uld a
> concurrent CPU hotplug operation acquire the list lock, find the partially
> unregistered event still in the list, and erroneously register and enable
> it in the firmware for the new CPU?
>=20
> > +
> > +		scoped_guard(spinlock, &events_list_lock)
> > +			list_del(&event->list);
> > +
> > +		sse_event_free(event);
>=20
> Since SBI events are delivered as NMI-like notifications, could an event =
have
> just fired and its handler be actively executing on another CPU?
>=20
> Without synchronization like waiting for active handlers or RCU grace per=
iods,
> it seems sse_handle_event() might dereference evt->handler and
> evt->handler_arg after the memory has been freed.
>=20
> > +	}
> > +}
> [ ... ]
> > +static int sse_cpu_online(unsigned int cpu)
> > +{
> > +	struct sse_event *event;
> > +
> > +	scoped_guard(spinlock, &events_list_lock) {
> > +		list_for_each_entry(event, &events, list) {
> > +			if (sse_event_is_global(event->evt_id))
> > +				continue;
> > +
> > +			sse_event_register_local(event);
> > +			if (sse_get_reg_evt(event))
> > +				sse_event_enable_local(event);
>=20
> Should this check reg_evt->is_enabled before unconditionally enabling the=
 event?
>=20
> If a driver registers an event but intentionally leaves it disabled, it l=
ooks
> like it will unexpectedly become enabled on the newly hotplugged CPU.
>=20
> > +		}
> > +	}
> > +
> > +	/* Ready to handle events. Unmask SSE. */
> > +	return sse_events_unmask();
> > +}
> > +
> > +static int sse_cpu_teardown(unsigned int cpu)
> > +{
> > +	int ret =3D 0;
> > +	unsigned int next_cpu;
> > +	struct sse_event *event;
> > +	struct sse_registered_event *reg_evt;
> > +
> > +	/* Mask the sse events */
> > +	ret =3D sse_events_mask();
> > +	if (ret)
> > +		return ret;
> > +
> > +	scoped_guard(spinlock, &events_list_lock) {
> > +		list_for_each_entry(event, &events, list) {
> > +			/* Disable local event on current cpu */
> > +			if (!sse_event_is_global(event->evt_id)) {
> > +				reg_evt =3D sse_get_reg_evt(event);
> > +				if (reg_evt->is_enabled)
> > +					sse_event_disable_local(event);
> > +
> > +				sse_sbi_unregister_event(event);
> > +				continue;
> > +			}
> > +
> > +			if (event->cpu !=3D smp_processor_id())
> > +				continue;
> > +
> > +			/* Update destination hart for global event */
> > +			next_cpu =3D cpumask_any_but(cpu_online_mask, cpu);
> > +			ret =3D sse_event_set_target_cpu_nolock(event, next_cpu);
>=20
> What happens if there are no other CPUs online during teardown?
>=20
> If cpumask_any_but() returns a value greater than or equal to nr_cpu_ids,
> passing it to sse_event_set_target_cpu_nolock() might result in an
> out-of-bounds array read in cpuid_to_hartid_map().
>=20
> Furthermore, by migrating rather than unregistering global events on rebo=
ot,
> does this break kexec by leaving the event actively registered for the ne=
xt
> kernel?
>=20
> > +		}
> > +	}
> > +
> > +	return ret;
> > +}
>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/cover.1778331862.git=
=2Ezhangzhanpeng.jasper@bytedance.com?part=3D3

--VnWZGohPBEbrtc2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCahCHGgAKCRB4tDGHoIJi
0o9QAP9Qn4XnM9BjrA2zaCDTOzuEX0fWl1cZoHFZq3tzt7J7RwD+NTYxsPP7V4nv
pNk45zI4/X7URCcQE72Q4wWvL1jQzAE=
=2CvW
-----END PGP SIGNATURE-----

--VnWZGohPBEbrtc2y--
