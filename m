Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FC147B409
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784055042; cv=none; b=PFvNNqAeY7OjHren1NLebROLj/dFmgQ+3vY2vO2GRb+O1lPByCK4vBEZVFfTf/tVvBmDj4GToU26hBt5oPDOyTsTuwhyo5DoMLlVNtbb5GbHNttLyMn3JTNGMk2dtVPjIEeNlGMTzFnLh03+ZLAaU0r53zZ64ETKJktS7jvZzso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784055042; c=relaxed/simple;
	bh=jbrlEcG69Oeu0leq+d6IQhS4qERp6mGPgJXw21R0M6Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jV+WWIg7yIutKF9e2i44EWZu9buDRYyTVVHc4AEKj6CBR4eYXRKLIaFwd0OdESPYycuXTn6t4QGHbO+q96U8tmcrfZhsUho2LqwcIGUFLY8QW67lgxKt4rNPwmkr0RdUP3GttHecyw2Lkz+SE506ka0D490ETmyavbFLegeRkyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XS3gN7/t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XS3gN7/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8EA1F00A3A;
	Tue, 14 Jul 2026 18:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784055036;
	bh=LaJo4ELk2wm/c4Hh/LjL1x4EvEBKWwEl4hOb/cZYGlo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XS3gN7/tVdUt1Bjyw3AECxeLAeN7+j84A466QVIovgkFjGYhbpNen9UYlsSnuZLgg
	 vd/qiFZiFmJAcpbap/SPRkupHYb1WMRz6F7PlIAuC3uC0ifVitPx22XCvxT90zpXSO
	 glNw1y/XsmglW/RE6fvD83Qi2pdFzPuuW95DEzcAdx/N4QAhVRajUw75rH1R5z5xWS
	 G9xdvBGfjDCaXevGfz85Dy75wIbCNq24kRHIVovEsDTaZ0X7JVClPCcCaKC7XxZADG
	 ONByW2Z+vvM0g8XGvklLf4KXzpyYObshqZ19uHCmwf2mZfQdTLbZ8MBMDuE28Sn55g
	 YtpqlH42gKzqA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 08/13] mm/kwatch: add hardware breakpoint backend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinchao Wang" <wangjinchao600@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260714183206.12688-1-wangjinchao600@gmail.com>
References: <20260714182243.10687-1-wangjinchao600@gmail.com>
 <20260714183206.12688-1-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 18:50:35 +0000
Message-Id: <20260714185036.6C8EA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [Critical] Repeated calls to `kwatch_hwbp_prealloc` write out of bounds o=
f the `kwatch_wp_slots` array, leading to a heap buffer overflow.
- [High] CPU hotplug online callback overwrites active watchpoints with the=
 dummy address, breaking them on newly onlined CPUs.
- [High] A static global per-CPU rate limit in `kwatch_hwbp_arm` silently d=
rops arming requests, causing independent watchpoints to fail.
- [High] Missing IPI completion tracking for arm requests allows `csd_arm` =
to be reused while still pending, causing subsequent arm requests to silent=
ly fail.
- [High] `kwatch_hwbp_get` locklessly accesses `kwatch_wp_slots` while `kwa=
tch_hwbp_free` frees it without synchronization.
- [Medium] Uninitialized kernel memory leaked to the trace ring buffer when=
 the stack depth is less than KWATCH_STACK_DEPTH.
- [Medium] Function calls with side effects in `TP_printk` arguments cause =
trace buffer corruption.
- [Medium] `kwatch_hwbp_handler` logs the globally shared address instead o=
f the local address, recording incorrect data during concurrent updates.
- [Low] 64-bit division in tracepoint printk causes linker errors on 32-bit=
 architectures.
--

--- Patch [8]: [RFC PATCH 08/13] mm/kwatch: add hardware breakpoint backend=
 ---
commit e30fa607776b2ca60d90cdf9ad4735ab9b2801f7
Author: Jinchao Wang <wangjinchao600@gmail.com>

mm/kwatch: add hardware breakpoint backend

Manage a preallocated pool of wide (per-CPU) perf hardware breakpoints.
All breakpoints are registered up front against a dummy address; arming
a watchpoint only re-points an already-registered event, so the arm path
can run from a kprobe handler.

> diff --git a/include/trace/events/kwatch.h b/include/trace/events/kwatch.h
> new file mode 100644
> index 0000000000000..edb95405c3869
> --- /dev/null
> +++ b/include/trace/events/kwatch.h
[ ... ]
> +	TP_fast_assign(
> +		unsigned int i;
> +
> +		__entry->ip =3D ip;
> +		__entry->sp =3D sp;
> +		__entry->addr =3D addr;
> +		__entry->time_ns =3D time_ns;
> +		__entry->stack_nr =3D min_t(unsigned int, stack_nr,
> +					  KWATCH_STACK_DEPTH);
> +		for (i =3D 0; i < __entry->stack_nr; i++)
> +			__entry->stack[i] =3D stack_entries[i];
> +	),

[Severity: Medium]
Will this leave the remaining elements in __entry->stack uninitialized when
stack_nr is less than KWATCH_STACK_DEPTH?

Because this memory comes from the tracing ring buffer, leaking uninitializ=
ed
kernel data might allow userspace to read stale kernel trace records.

> +
> +	TP_printk("KWatch HIT: time=3D%llu.%06lu ip=3D%pS addr=3D0x%lx%s",
> +		  __entry->time_ns / 1000000000ULL,
> +		  (unsigned long)((__entry->time_ns / 1000ULL) % 1000000ULL),

[Severity: Low]
Is it safe to use 64-bit division and modulo operators here?

Native 64-bit division on __entry->time_ns can cause build failures due to
unresolved __udivdi3 symbols on 32-bit architectures. Could div64_u64() or
do_div() be used instead?

> +		  (void *)__entry->ip, __entry->addr,
> +		  kwatch_trace_print_stack(p, __entry->stack,
> +					   __entry->stack_nr))
> +);

[Severity: Medium]
Can executing kwatch_trace_print_stack() as an argument to TP_printk()
corrupt the trace output buffer?

Due to argument evaluation order, kwatch_trace_print_stack() could evaluate
before trace_seq_printf(). Since it writes directly to the shared trace_seq
buffer and inserts a null byte:

    trace_seq_putc(p, 0);

trace_seq_printf() would append the main event string after the null byte.
When userspace reads the trace, it stops at the null byte, resulting in a
mangled or truncated trace log.

> diff --git a/mm/kwatch/hwbp.c b/mm/kwatch/hwbp.c
> new file mode 100644
> index 0000000000000..19498ba038260
> --- /dev/null
> +++ b/mm/kwatch/hwbp.c
[ ... ]
> +static void kwatch_hwbp_handler(struct perf_event *bp,
> +				struct perf_sample_data *data,
> +				struct pt_regs *regs)
> +{
> +	struct kwatch_watchpoint *wp =3D bp->overflow_handler_context;
> +	unsigned long stack_entries[KWATCH_STACK_DEPTH];
> +	unsigned int stack_nr;
> +
> +	if (!kwatch_probe_validate_hit(regs, wp->arm_tsk))
> +		return;
> +
> +	stack_nr =3D stack_trace_save_regs(regs, stack_entries, KWATCH_STACK_DE=
PTH, 2);
> +	trace_kwatch_hit(instruction_pointer(regs), kernel_stack_pointer(regs),
> +			 wp->attr.bp_addr, local_clock(),
> +			 stack_entries, stack_nr);
> +}

[Severity: Medium]
Could this tracepoint log the wrong address during a concurrent update?

If another CPU changes the watchpoint address, it updates the global
wp->attr.bp_addr and sends IPIs. If a hit on the old hardware breakpoint
triggers here before the IPI is received, it will log the newly updated
global wp->attr.bp_addr instead of the local perf event's configured
address (bp->attr.bp_addr).

[ ... ]
> +static int kwatch_hwbp_cpu_online(unsigned int cpu)
> +{
> +	struct perf_event_attr attr;
> +	struct kwatch_watchpoint *wp;
> +	struct perf_event *bp;
> +
> +	mutex_lock(&kwatch_all_wp_mutex);
> +	list_for_each_entry(wp, &kwatch_all_wp_list, list) {
> +		attr =3D wp->attr;
> +		attr.bp_addr =3D (unsigned long)&kwatch_dummy_holder;

[Severity: High]
Does this accidentally force newly onlined CPUs to monitor the dummy address
instead of the active watchpoint address?

If a CPU is onlined on a system with active watchpoints, they will silently
fail to trigger on the new CPU because it explicitly configures the hardware
breakpoint for kwatch_dummy_holder instead of the active wp->attr.bp_addr.

[ ... ]
> +int kwatch_hwbp_get(struct kwatch_watchpoint **out_wp)
> +{
> +	struct kwatch_watchpoint *wp;
> +	int i;
> +
> +	/*
> +	 * Per-slot cmpxchg claim: safe for concurrent consumers on any CPU,
> +	 * unlike llist_del_first() which requires a single consumer.
> +	 */
> +	for (i =3D 0; i < kwatch_wp_nr; i++) {
> +		wp =3D kwatch_wp_slots[i];

[Severity: High]
Is it safe to access kwatch_wp_slots here without holding a lock or
using RCU?

If an error occurs during preallocation or a module unload triggers
kwatch_hwbp_free(), the array can be freed:

    kwatch_wp_nr =3D 0;
    kfree(kwatch_wp_slots);

If kwatch_hwbp_get() reads kwatch_wp_nr before it is zeroed and dereferences
the array after it is freed, it could lead to a use-after-free.

[ ... ]
> +void kwatch_hwbp_arm(struct kwatch_watchpoint *wp, unsigned long addr, u=
16 len)
> +{
> +	static DEFINE_PER_CPU(u64, last_ipi_time);
> +	int cur_cpu;
> +	call_single_data_t *csd;
> +	int cpu;
> +	bool is_disarm =3D (addr =3D=3D (unsigned long)&kwatch_dummy_holder);
> +
> +	wp->attr.bp_addr =3D addr;
> +	wp->attr.bp_len =3D len;
> +
> +	if (!is_disarm)
> +		wp->arm_tsk =3D current;
> +
> +	/* ensure attr update visible to other cpu before sending IPI */
> +	smp_wmb();
> +
> +	atomic_set(&wp->pending_ipis, 1);
> +	cur_cpu =3D get_cpu();
> +
> +	if (!is_disarm) {
> +		u64 now =3D local_clock();
> +		u64 last =3D this_cpu_read(last_ipi_time);
> +
> +		if (now - last < 1000000ULL) {
> +			put_cpu();
> +			return;
> +		}

[Severity: High]
Could this static global per-CPU rate limit silently break watchpoints?

If two distinct watchpoints are armed on the same CPU within 1 millisecond,
the second request will return early here. However, this happens after the
global wp->attr.bp_addr and wp->arm_tsk have already been modified.

This leaves the hardware monitoring the old address while the metadata clai=
ms
it is armed, causing the new watchpoint to miss events.

> +		this_cpu_write(last_ipi_time, now);
> +	}
> +	for_each_online_cpu(cpu) {
> +		if (cpu =3D=3D cur_cpu)
> +			continue;
> +
> +		if (is_disarm)
> +			atomic_inc(&wp->pending_ipis);
> +
> +		csd =3D per_cpu_ptr(is_disarm ? wp->csd_disarm : wp->csd_arm,
> +				  cpu);
> +		if (smp_call_function_single_async(cpu, csd) && is_disarm)
> +			kwatch_hwbp_try_recycle(wp);
> +	}

[Severity: High]
Should arm requests also handle the case where the IPI fails with -EBUSY?

If a watchpoint is rapidly toggled, the second arm attempt can try to queue
csd_arm while the remote CPU is still processing the first one. This causes
smp_call_function_single_async() to return -EBUSY.

Because the error is only checked for disarm requests (the && is_disarm
check), the failure to arm is silently ignored, and the new address is never
programmed on the busy CPU.

[ ... ]
> +int kwatch_hwbp_prealloc(u16 max_watch, enum kwatch_access_type access_t=
ype)
> +{
[ ... ]
> +	kwatch_wp_slots =3D kcalloc(success, sizeof(*kwatch_wp_slots),
> +				  GFP_KERNEL);
> +	if (!kwatch_wp_slots) {
> +		kwatch_hwbp_free();
> +		return -ENOMEM;
> +	}
> +	mutex_lock(&kwatch_all_wp_mutex);
> +	list_for_each_entry(wp, &kwatch_all_wp_list, list)
> +		kwatch_wp_slots[kwatch_wp_nr++] =3D wp;

[Severity: Critical]
Will subsequent calls to kwatch_hwbp_prealloc() cause a heap buffer
overflow?

If this function is called more than once, it allocates a new
kwatch_wp_slots array sized only for the new success count. However, the
static kwatch_all_wp_list retains elements from prior calls, and the static
kwatch_wp_nr is never reset.

Iterating the accumulated global list and writing elements via
kwatch_wp_slots[kwatch_wp_nr++] will write out of bounds of the newly
allocated array.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714182243.1068=
7-1-wangjinchao600@gmail.com?part=3D8
