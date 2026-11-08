Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794105695;
	b=siDIgUjKJ/NDrnaevti1uii+2RXq9EENsAnie0XI0jDrmoqV+kVLYheCOKk5wDdwrSMo
	 gYOKnPUwegrqGZCMWfURl2OkRrrlYsiQACS21Oj3YcgKZHBGRLKNpUuq4Bpy0fff5974S
	 3Z5VVCqrN4DWli5qE8ibblhCGQH4GDrKlTqpepZXzgYh8Q0wPGvVGso8dLKBVGmooMIWE
	 GaZrGF+hT2iIGzowCORBGEA490w+DmlVv78OF+Aowq+hFMZxS0WMaJVGSTpBbrvBauI/E
	 yxmBakBZ7c5kb2jVOvvmaNrFms/8maL6MmapIPCa9KDYLjjkv/nQa8+vULoI4GtKYGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794105695;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=k3bQGxK0eIsD8Is5s6TbrJM+F/ftHRub1Y+D2W3BrRg=;
	b=W4PH23P8TsMaAxobivbS5ytLyl9NGmvEx9jxu2O9YfzYCzluu80V/jifOLvwmV5si75w
	 i4y4151NuX+9RlE0irx6s9AuHBKI7iOgPXqJrdgPP5rADhEfKzBz8CPqcNfWVirDdZm0T
	 PyKK+SX4UgO6aCxh6K1hKaG4MNJMt15hF2PN2LxzmVb8E+rkdIMQjIUUL+cjjhBMY4zO/
	 i1vYjf7Es2ki6uhENMV2VkRvT8mM4umZX8eb7BY0Xlj/ln3H9gzTQHEZQ4gkLV/EDQdJH
	 ySyYUBhoCl+HQDQrGLrZ9X2hb0j/HdRLuqVSHTqnn6XApRQzlmbGTC4j57UK6+q2wQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D7JQ8kG3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1CB606A31A
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Nov 2026 02:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D7JQ8kG3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C870B1F0089F;
	Sun,  8 Nov 2026 02:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794105694;
	bh=k3bQGxK0eIsD8Is5s6TbrJM+F/ftHRub1Y+D2W3BrRg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D7JQ8kG3YP1UfqZ8etYw4/3vP8myk+1N1XxGj4gPOZGo1NkB56TLcJlp+n8URTp6Q
	 srFETKEq4vA8UUC/Ob6bxwPITLIYv8wLa53xsdIBU1WurHwLgAb1wymFK5fNLfUypf
	 xLL3A/llQhvSK/HLzf+44j/Ot+K46MR+oaj4JFLvb4lk17erLPsSd0Z6+zz0QAtZQZ
	 y5o20a9Pl8u83Mb+TKcCG/gPWVYQPpxvtnUyS51XpsVJODKjDNSeii7sVisnZLZkEK
	 Qx1xbfd9xvWEc+6BwEbc7Ok4eITLW4qhCa4lKRR+LZyd+R5Au0+kq3yXNHGpxYHEYX
	 Ty6hjrDzrM3jA==
Message-ID: <sashiko-outbox-203522@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/8] riscv: Introduce support for hardware
 break/watchpoints
Reply-To: sashiko-reviews@lists.linux.dev
To: "Himanshu Chauhan" <himanshu.chauhan@oss.qualcomm.com>, "Paul Walmsley" <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>
Cc: "Alexandre Ghiti" <alex@ghiti.fr>, "Jesse Taube" <jtaubepe@redhat.com>, "Oleg
 Nesterov" <oleg@redhat.com>, "Kees Cook" <kees@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Namhyung
 Kim" <namhyung@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, "Jiri Olsa" <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, "Adrian Hunter" <adrian.hunter@intel.com>, "James
 Clark" <james.clark@linaro.org>, "Shuah Khan" <shuah@kernel.org>, linux-mm@kvack.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20261107023917.40606-2-himanshu.chauhan@oss.qualcomm.com>
References: <20261107023917.40606-1-himanshu.chauhan@oss.qualcomm.com>
 <20261107023917.40606-2-himanshu.chauhan@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 02:41:33 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 11 potential
issues to consider:
- [High] riscv: hw_breakpoint: unconditional overlap match and early
  exit in handler
- [High] riscv/hw_breakpoint: handle_break() runs DIE_DEBUG with IRQs
  enabled
- [High] riscv: hw_breakpoint: missing trigger step-over in
  hw_breakpoint_handler()
- [High] riscv: hw_breakpoint: invalid bp_len handling and watchpoint
  size programming
- [Medium] riscv: hw_breakpoint: NULL sbi_dbtr_shmem dereference on init
  alloc failure
- [Medium] riscv: hw_breakpoint: wrong cpuhp state ordering for SBI
  shared memory
- [Medium] riscv: hw_breakpoint: missing ecall_lock in
  arch_disable_hw_breakpoint()
- [Medium] riscv: hw_breakpoint: stale slot pointer in
  arch_uninstall_hw_breakpoint()
- [Low] riscv: Kconfig: unmet HAVE_HW_BREAKPOINT dependency for mixed
  breakpoints
- [Low] MAINTAINERS: overbroad drivers/perf/ path and missing S: tag in
  RISC-V entry
- [Low] riscv/hw_breakpoint: sparse endianness mismatch on sbi_dbtr
  shmem fields
--

commit dde98179a500199d237defeb10f1d800c10ddb91
Author: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>

riscv: Introduce support for hardware break/watchpoints

This commit introduces hardware breakpoint and watchpoint support on
RISC-V using the perf hardware breakpoint framework and the SBI debug
trigger extension (Sdtrig).

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93abbb315065d..73b69e8dcba15 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24163,6 +24163,15 @@ F:	Documentation/devicetree/bindings/power/riscv=
,rpmi-device-power.yaml
>  F:	Documentation/devicetree/bindings/power/riscv,rpmi-mpxy-device-power.=
yaml
>  F:	drivers/pmdomain/riscv/
> =20
> +RISC-V DEBUGGING
> +M:	Himanshu Chauhan <himanshu@thechauhan.dev>
> +L:	linux-riscv@lists.infradead.org
> +F:	arch/riscv/include/asm/hw_breakpoint.h
> +F:	arch/riscv/include/asm/perf_event.h
> +F:	arch/riscv/kernel/hw_breakpoint.c
> +F:	arch/riscv/kernel/perf_*
> +F:	drivers/perf/

[Severity: Low]
Should this MAINTAINERS entry drop F: drivers/perf/ (which claims the
entire multi-architecture perf driver directory already covered for RISC-V
by RISC-V PMU DRIVERS), include the required S: status tag, and be placed
in alphabetical order before RISC-V RPMI DEVICE POWER DRIVER?

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e7891a2a89da6..2cfd9f3695346 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -173,6 +173,8 @@ config RISCV
>  	select HAVE_FUNCTION_ARG_ACCESS_API
>  	select HAVE_FUNCTION_ERROR_INJECTION
>  	select HAVE_GCC_PLUGINS
> +	select HAVE_HW_BREAKPOINT if PERF_EVENTS && RISCV_SBI
> +	select HAVE_MIXED_BREAKPOINTS_REGS if PERF_EVENTS

[Severity: Low]
Does selecting HAVE_MIXED_BREAKPOINTS_REGS without gating on RISCV_SBI
cause an unmet direct dependency warning when CONFIG_PERF_EVENTS=3Dy and
CONFIG_RISCV_SBI=3Dn (such as on M-mode builds)?  In arch/Kconfig,
HAVE_MIXED_BREAKPOINTS_REGS depends on HAVE_HW_BREAKPOINT.

> diff --git a/arch/riscv/kernel/hw_breakpoint.c b/arch/riscv/kernel/hw_bre=
akpoint.c
> new file mode 100644
> index 0000000000000..421ecd8549d94
> --- /dev/null
> +++ b/arch/riscv/kernel/hw_breakpoint.c

[ ... ]

> +	if (attr->bp_type =3D=3D HW_BREAKPOINT_X) {
> +		/*
> +		 * Userspace debuggers can request execute breakpoints with
> +		 * bp_len =3D=3D 2 for compressed/non-aligned instruction
> +		 * addresses. Program execute triggers with "match any size"
> +		 * to avoid missing valid instruction fetches.
> +		 */
> +		hw->len =3D 0;
> +	} else {
> +		switch (attr->bp_len) {
> +		case HW_BREAKPOINT_LEN_1:
> +			hw->len =3D 1;
> +			tdata1 |=3D dbtr_mcontrol_size(1, 0);
> +			break;
> +		case HW_BREAKPOINT_LEN_2:
> +			hw->len =3D 2;
> +			tdata1 |=3D dbtr_mcontrol_size(2, 0);
> +			break;
> +		case HW_BREAKPOINT_LEN_4:
> +			hw->len =3D 4;
> +			tdata1 |=3D dbtr_mcontrol_size(3, 0);
> +			break;
> +#if __riscv_xlen >=3D 64
> +		case HW_BREAKPOINT_LEN_8:
> +			hw->len =3D 8;
> +			tdata1 |=3D dbtr_mcontrol_size(1, 1);
> +			break;
> +#endif
> +		/* Set to match any size */
> +		default:
> +			hw->len =3D 0;
> +			break;
> +		}
> +	}

[Severity: High]
Does programming attr->bp_len into tdata1's size field with match =3D 0 cau=
se
watchpoints in rv_init_mcontrol_trigger() and rv_init_mcontrol6_trigger()
to miss valid memory accesses?

In Sdtrig mcontrol and mcontrol6, tdata1.size filters the access width of
the load or store instruction itself, while match =3D 0 matches only the
exact address in tdata2.  A watchpoint of length N will therefore ignore
accesses of any other width as well as accesses to non-zero byte offsets
within [bp_addr, bp_addr + bp_len) (for example, a 1-byte store to offset 1
of a 2-byte watchpoint).

Also, the default branch accepts arbitrary invalid attr->bp_len values by
setting hw->len =3D 0 instead of returning -EINVAL, which causes
arch_check_bp_in_kernelspace() to check only a 1-byte range against
TASK_SIZE.

[ ... ]

> +static void dbtr_encode_update(union sbi_dbtr_shmem_entry *shmem,
> +			       unsigned long idx, unsigned long tdata1,
> +			       unsigned long tdata2, unsigned long tdata3)
> +{
> +	struct sbi_dbtr_id_msg *id =3D &shmem->id;
> +	struct sbi_dbtr_data_msg *data =3D &shmem->data;
> +
> +	/*
> +	 * SBI_EXT_DBTR_TRIG_UPDATE takes the number of entries in a0.  The
> +	 * trigger index for each entry lives in the first shared-memory word;
> +	 * that word is named tstate only when the same union is used for
> +	 * TRIG_READ replies.
> +	 */
> +	id->idx =3D cpu_to_le(idx);
> +	data->tdata1 =3D cpu_to_le(tdata1);
> +	data->tdata2 =3D cpu_to_le(tdata2);
> +	data->tdata3 =3D cpu_to_le(tdata3);
> +}

[Severity: Low]
Does converting these shared-memory fields with cpu_to_le() and le_to_cpu()
trigger sparse endianness warnings?  In arch/riscv/include/asm/sbi.h,
struct sbi_dbtr_data_msg and struct sbi_dbtr_id_msg declare idx, tstate,
and tdata1..tdata3 as unsigned long rather than __le64 / __le32, so reading
and writing them with cpu_to_le() and le_to_cpu() here, in
mc_read_and_clear_hit(), mc6_read_and_clear_hit(), and
arch_install_hw_breakpoint() mismatches restricted bitwise types.

[ ... ]

> +static int hw_breakpoint_handler(struct die_args *args)
> +{
> +	int i, bp_ret =3D NOTIFY_DONE;
> +	struct arch_hw_breakpoint *bp;
> +	struct perf_event *event;
> +
> +	for (i =3D 0; i < dbtr_total_num; i++) {
> +		event =3D this_cpu_read(pcpu_hw_bp_events[i]);
> +		if (!event)
> +			continue;
> +
> +		bp =3D counter_arch_bp(event);
> +
> +		switch (event->attr.bp_type) {
> +		/* Breakpoint */
> +		case HW_BREAKPOINT_X:
> +			{
> +				bool hit =3D bp->address =3D=3D args->regs->epc;
> +
> +				if (dbtr_type =3D=3D RISCV_DBTR_TRIG_MCONTROL)
> +					hit |=3D mc_read_and_clear_hit(i);
> +				else if (dbtr_type =3D=3D RISCV_DBTR_TRIG_MCONTROL6)
> +					hit |=3D mc6_read_and_clear_hit(i) !=3D
> +					       RISCV_DBTR_MC6_HIT_FALSE;
> +
> +				if (hit) {
> +					perf_bp_event(event, args->regs);
> +					bp_ret =3D NOTIFY_STOP;
> +					goto exit;
> +				}
> +			}
> +			break;
> +
> +		/* Watchpoint */
> +		case HW_BREAKPOINT_W:
> +		case HW_BREAKPOINT_R:
> +		case HW_BREAKPOINT_RW:
> +			{
> +				unsigned long stval =3D args->regs->badaddr;
> +				unsigned long bp_start =3D bp->address;
> +				unsigned long bp_len =3D bp->len ?: 1;
> +				bool hit =3D false;
> +
> +				/*
> +				 * Prefer tdata1.hit from SBI trigger readout whenever
> +				 * possible. Fall back to address-based matching if HIT
> +				 * isn't observed/supported.
> +				 */
> +				if (dbtr_type =3D=3D RISCV_DBTR_TRIG_MCONTROL)
> +					hit =3D mc_read_and_clear_hit(i);
> +				else if (dbtr_type =3D=3D RISCV_DBTR_TRIG_MCONTROL6)
> +					hit =3D mc6_read_and_clear_hit(i) !=3D
> +					      RISCV_DBTR_MC6_HIT_FALSE;
> +
> +				/*
> +				 * Sdtrig may report STVAL as the lowest accessed
> +				 * address while the watchpoint can match a higher byte
> +				 * in the same access.  Check for full range overlap
> +				 * rather than comparing only the two start addresses.
> +				 */
> +				hit |=3D ranges_overlap(bp_start, bp_len, stval,
> +						      sizeof(long));
> +				if (hit) {
> +					perf_bp_event(event, args->regs);
> +					bp_ret =3D NOTIFY_STOP;
> +					goto exit;
> +				}
> +			}
> +			break;

[Severity: High]
Does unconditionally ORing the hardware hit readout with software address
comparisons and jumping to exit on the first match misattribute events,
leave stale HIT bits set in higher slots, and swallow software EBREAK
traps?

When a trigger in slot j > i fires at an address within sizeof(long) bytes
of a watchpoint in slot i (or with a different access type), slot i's false
hardware hit readout is overridden by ranges_overlap(), attributing the
event to slot i.  Because the loop then jumps to exit,
mc_read_and_clear_hit(j) / mc6_read_and_clear_hit(j) never runs for slot j,
leaving its hardware HIT bit set for the next debug exception.

Furthermore, because handle_break() invokes DIE_DEBUG before checking for
kernel WARN_ON()/BUG() traps and hw_breakpoint_handler() does not check
that a hardware trigger fired or that user_mode(args->regs) matches the
trigger's privilege mode, a user watchpoint covering address 0..7 will
match stval =3D=3D 0 on a kernel WARN_ON() EBREAK and return NOTIFY_STOP
without advancing regs->epc, livelocking the CPU on the same EBREAK.

[Severity: High]
In addition, how does execution make forward progress after a breakpoint or
watchpoint hits?

Both rv_init_mcontrol_trigger() and rv_init_mcontrol6_trigger() configure
before-execution triggers (timing =3D 0), so the exception is taken before
the instruction at regs->epc retires.  Clearing the hit bit and returning
NOTIFY_STOP without stepping over the instruction or disabling the trigger
causes sret to return to the same instruction and re-trigger the exception
in an infinite loop.

Even with commit "riscv: Add software supported single stepping with mc/mc6
triggers" later in the series, when setup_singlestep() fails (such as for
CPU-wide breakpoints where event->hw.target is NULL),
disable_unhandled_singlestep() only queues asynchronous irq_work via
perf_event_disable_inatomic() without disabling or uninstalling the
hardware trigger before sret.

[ ... ]

> +	ret =3D dbtr_uninstall_trigger_locked(i);
> +
> +	if (ret.error) {
> +		pr_warn("Failed to uninstall trigger %d.\n", i);
> +		goto out;
> +	}
> +
> +	*slot =3D NULL;
> +
> + out:
> +	raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock), flags);
> +}

[Severity: Medium]
If dbtr_uninstall_trigger_locked() fails in arch_uninstall_hw_breakpoint(),
does jumping to out without clearing *slot leave a dangling perf_event
pointer in pcpu_hw_bp_events[i]?  Because arch_uninstall_hw_breakpoint()
returns void to hw_breakpoint_del(), the perf core still finishes tearing
down and freeing the perf_event, and later debug exceptions on that CPU
will dereference the freed event in hw_breakpoint_handler().

[ ... ]

> +void arch_disable_hw_breakpoint(struct perf_event *event)
> +{
> +	struct perf_event **slot;
> +	struct sbiret ret;
> +	int i;
> +
> +	for (i =3D 0; i < dbtr_total_num; i++) {
> +		slot =3D this_cpu_ptr(&pcpu_hw_bp_events[i]);
> +
> +		if (*slot =3D=3D event)
> +			break;
> +	}
> +
> +	if (i =3D=3D dbtr_total_num) {
> +		pr_warn("Breakpoint not installed.\n");
> +		return;
> +	}
> +
> +	ret =3D sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_DISABLE,
> +			i, 1, 0, 0, 0, 0);
> +
> +	if (ret.error) {
> +		pr_warn("Failed to uninstall trigger %d.\n", i);
> +		return;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(arch_disable_hw_breakpoint);

[Severity: Medium]
Should arch_disable_hw_breakpoint() acquire ecall_lock with
raw_spin_lock_irqsave() like arch_enable_hw_breakpoint() and
arch_uninstall_hw_breakpoint() do?  Without it, reading pcpu_hw_bp_events[]
and issuing the SBI_EXT_DBTR_TRIG_DISABLE ecall can migrate CPUs mid-call
or race with concurrent trigger operations on the same CPU.

Also, arch_enable_hw_breakpoint(), arch_update_hw_breakpoint(), and
arch_disable_hw_breakpoint() have no callers in the tree, and the error
messages in arch_enable_hw_breakpoint() and arch_disable_hw_breakpoint()
say "install" and "uninstall" instead of "enable" and "disable".

> +
> +void hw_breakpoint_pmu_read(struct perf_event *bp) { }
> +
> +void flush_ptrace_hw_breakpoint(struct task_struct *tsk) { }
> +
> +static int __init arch_hw_breakpoint_init(void)
> +{
> +	unsigned int cpu;
> +	int rc =3D 0;
> +
> +	for_each_possible_cpu(cpu)
> +		raw_spin_lock_init(&per_cpu(ecall_lock, cpu));
> +
> +	init_sbi_dbtr();
> +
> +	if (dbtr_total_num) {
> +		pr_info("Total number of type %d triggers: %u\n",
> +			dbtr_type, dbtr_total_num);
> +	} else {
> +		pr_info("No hardware triggers available\n");
> +		goto out;
> +	}
> +
> +	/* Allocate per-cpu shared memory */
> +	sbi_dbtr_shmem =3D __alloc_percpu(sizeof(*sbi_dbtr_shmem) * dbtr_total_=
num,
> +					PAGE_SIZE);
> +
> +	if (!sbi_dbtr_shmem) {
> +		pr_warn("Failed to allocate shared memory.\n");
> +		rc =3D -ENOMEM;
> +		goto out;
> +	}

[Severity: Medium]
If __alloc_percpu() fails here, does leaving dbtr_total_num and dbtr_type
set allow later breakpoint registrations to dereference a NULL
sbi_dbtr_shmem via this_cpu_ptr(sbi_dbtr_shmem) in
arch_install_hw_breakpoint()?

hw_breakpoint_slots() already ran earlier during perf_event_init() and
cached the non-zero slot count, and the same NULL sbi_dbtr_shmem
dereference can occur if an in-kernel caller registers a breakpoint between
perf_event_init() and arch_hw_breakpoint_init().  In addition,
init_sbi_dbtr() discards the total trigger count returned by
SBI_EXT_DBTR_NUM_TRIGGERS(0) and bounds-checks recv->idx in
arch_install_hw_breakpoint() against only the type-specific trigger count
dbtr_total_num, which will reject valid trigger indices >=3D dbtr_total_num
if triggers of other types precede them on the hart.

> +
> +	/* Hotplug handler to register/unregister shared memory with SBI */
> +	rc =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> +			       "riscv/hw_breakpoint:prepare",
> +			       arch_smp_setup_sbi_shmem,
> +			       arch_smp_teardown_sbi_shmem);

[Severity: Medium]
Does registering the SBI shared-memory callbacks at CPUHP_AP_ONLINE_DYN
disable shared memory too early during CPU hotplug teardown and enable it
too late during bringup?

In enum cpuhp_state, CPUHP_AP_ONLINE_DYN runs after CPUHP_AP_PERF_ONLINE
and CPUHP_AP_SCHED_WAIT_EMPTY on bringup, and before them on teardown.
When a CPU goes offline, arch_smp_teardown_sbi_shmem() disables SBI shared
memory while per-CPU and per-task breakpoints are still active on that CPU,
causing trigger reads, updates, or installations before
CPUHP_AP_PERF_ONLINE and CPUHP_AP_SCHED_WAIT_EMPTY to fail with
SBI_ERR_NO_SHMEM.

> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index f8292adda0999..1b9ccc0b6b8d8 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -287,6 +287,12 @@ void handle_break(struct pt_regs *regs)
>  	if (probe_breakpoint_handler(regs))
>  		return;
> =20
> +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> +	if (notify_die(DIE_DEBUG, "EBREAK", regs, 0, regs->cause, SIGTRAP)
> +	    =3D=3D NOTIFY_STOP)
> +		return;
> +#endif

[Severity: High]
Does calling notify_die(DIE_DEBUG, ...) from handle_break() invoke
hw_breakpoint_handler() and perf_bp_event() with local interrupts and
preemption enabled on user-mode traps?

do_trap_break() calls local_irq_enable() before handle_break(regs) when
user_mode(regs) is true:

arch/riscv/kernel/traps.c:do_trap_break() {
	if (user_mode(regs)) {
		irqentry_enter_from_user_mode(regs);
		local_irq_enable();

		handle_break(regs);

perf_bp_event() requires local interrupts and preemption to be disabled
(asserted via lockdep_assert_irqs_disabled() in kernel/events/core.c), and
hw_breakpoint_handler(), mc_read_and_clear_hit(), and
mc6_read_and_clear_hit() also call this_cpu_read() and this_cpu_ptr()
before acquiring ecall_lock.  Running with interrupts and preemption
enabled triggers lockdep and CONFIG_DEBUG_PREEMPT warnings and allows task
migration or cross-CPU perf IPIs to race with trigger readout and event
delivery.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107023917.4060=
6-1-himanshu.chauhan@oss.qualcomm.com?part=3D1
