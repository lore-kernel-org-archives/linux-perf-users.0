Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3053B38B8
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 06:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792217382; cv=none; b=uJr8bOxGkvR3mHJA2YR+bAE6BIAoJ6ic4XIvg5EJlOlm2dPMtnV8ZY9wZn2HcJGzmR8QCNWICOBegyaLeXhGKbIYrRVkHU64aA7OP7iCiZiqiAZQlyDLUh/bhG8FsSS6NBizPYcAh1EjGG4EiMnlKOE53V3Qc9Vbb4R6RzIT8Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792217382; c=relaxed/simple;
	bh=qM0cfhNK0mDt51opK2oPAXh5CkDFWEqcP4feWc0PhCI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=OlaYi97CBSpbCuISkDbsWZgRRfDDdvH9pXMdohEcuNrrnlalzJgF6Jzx17PdXidlGlWtCZiNP72KN6lFeI0+K9YbibKeyeSsw4MCqHOWwt+DYetzGYCZmy3ICM/Yhmg+zcF0VU+5Ks67rJeCYHpA9Adv/3l2B7JW0+eJgMH6V0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T88+OaZK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T88+OaZK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005E91F000C4;
	Sat, 17 Oct 2026 06:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792217380;
	bh=2bHBZMVNBef0hXYbShT6LejKpQ1JCSZVVXHBEKWT+lo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T88+OaZKHxZ2dMNK2XrigJbKJ9WB0yptMt4RU4mninY+GrVWoO7U1CXA+8S8r5Q1i
	 dE0ckgGmuoAMZO/p5hI9rQ0xZlCzw70zl1IYzTnGOxm327ORoN19mvaCQI0H6Ln3Xg
	 3izonRIZt6G8YzxXGdWjVstyYGjQuSW5B6YOZbwRvCg+X7ZQp8sa3blBZhaO/cuUWZ
	 v9t7Tqc97iQi3tMaTib4dzGoVeyFlTTv9kru3ijpIH0Ax1atdg/ceF7jAp0tJxgnKb
	 QO4OFa+U2XYC5hNKSP7de9XlJeyaY3vWfY0mxJqJ+pm2f9XlZjXEdm1hJg8c/0B7l1
	 3GIM22LxqC4+w==
Message-ID: <sashiko-outbox-175331@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/5] perf bpf-filter: Add lock_held() sample filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261017054555.1655407-3-irogers@google.com>
References: <20261017054555.1655407-1-irogers@google.com>
 <20261017054555.1655407-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 06:09:39 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Medium] perf bpf-filter: held_locks leak and count corruption in fexit_d=
owngrade_write()
- [Medium] perf bpf-filter: prescan_one_lock_expr() misses percpu_rw_semaph=
ore symbols
- [Medium] perf bpf-filter: configure_lock_progs() ignores missing inlined =
spin/rwlock unlocks
- [Medium] perf bpf-filter: missing CONFIG_DEBUG_LOCK_ALLOC mutex hooks in =
lock_progs
- [Medium] perf bpf-filter: unguarded mutex->owner read in is_direct_lock_o=
wner() on RT
--

commit 362a7c2a8d1d1d0355b0ac1b022fdffe73aae6c0
Author: Ian Rogers <irogers@google.com>

perf bpf-filter: Add lock_held() sample filter

This commit adds BPF sample filter predicates lock_held(), lock_held_read(),
lock_held_shared(), lock_held_write(), and lock_held_exclusive() to record
perf event samples only when a specified kernel lock is held. It uses direct
kernel lock owner inspection where possible and falls back to a held_locks
BPF hash map populated by fentry/fexit hooks on kernel lock and unlock
functions.

> diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> index 72e83ac1d6a4b..35d6f7c638684 100644
> --- a/tools/perf/util/bpf-filter.c
> +++ b/tools/perf/util/bpf-filter.c

[ ... ]

> +static const struct lock_prog_desc lock_progs[] =3D {
> +	/* Mutex */
> +	LOCK_FPROG(fexit_mutex_lock, "mutex_lock", LOCK_PROG_MUTEX),
> +	LOCK_FPROG(fexit_mutex_lock_nested, "mutex_lock_nested", LOCK_PROG_MUTE=
X),
> +	LOCK_FPROG(fexit_mutex_lock_io, "mutex_lock_io", LOCK_PROG_MUTEX),
> +	LOCK_FPROG(fexit_mutex_lock_io_nested, "mutex_lock_io_nested", LOCK_PRO=
G_MUTEX),
> +	LOCK_FPROG(fexit_mutex_lock_interruptible, "mutex_lock_interruptible", =
LOCK_PROG_MUTEX),
> +	LOCK_FPROG(fexit_mutex_lock_interruptible_nested, "mutex_lock_interrupt=
ible_nested",
> +		   LOCK_PROG_MUTEX),
> +	LOCK_FPROG(fexit_mutex_lock_killable, "mutex_lock_killable", LOCK_PROG_=
MUTEX),
> +	LOCK_FPROG(fexit_mutex_trylock, "mutex_trylock", LOCK_PROG_MUTEX),
> +	LOCK_FPROG(fentry_mutex_unlock, "mutex_unlock", LOCK_PROG_MUTEX),

[Severity: Medium]
On kernels built with CONFIG_DEBUG_LOCK_ALLOC=3Dy, will mutex acquisitions =
via
mutex_lock_killable(), mutex_trylock(), and mutex_lock_nest_lock() be missed
by the held_locks map?

In include/linux/mutex.h, when CONFIG_DEBUG_LOCK_ALLOC=3Dy, those functions=
 are
macros that expand to different underlying entry points:

  #define mutex_lock(lock) mutex_lock_nested(lock, 0)
  #define mutex_lock_interruptible(lock) mutex_lock_interruptible_nested(lo=
ck, 0)
  #define mutex_lock_killable(lock) _mutex_lock_killable(lock, 0, NULL)
  #define mutex_lock_io(lock) mutex_lock_io_nested(lock, 0)
  #define mutex_lock_nest_lock(lock, nest_lock) _mutex_lock_nest_lock(lock,=
 &(nest_lock)->dep_map)
  #define mutex_trylock(lock) _mutex_trylock_nest_lock(lock, NULL)

While lock_progs[] and sample_filter.bpf.c hook mutex_lock_nested,
mutex_lock_interruptible_nested, and mutex_lock_io_nested, they only hook
mutex_lock_killable and mutex_trylock rather than _mutex_lock_killable,
_mutex_trylock_nest_lock, and _mutex_lock_nest_lock.

For filters that rely on held_locks rather than direct owner inspection (su=
ch
as PBF_LOCK_SLAB and PBF_LOCK_TYPE), wouldn't mutexes acquired via
mutex_lock_killable() or mutex_trylock() go untracked on lockdep-enabled
kernels?

[ ... ]

> +static int configure_lock_progs(struct sample_filter_bpf *skel, struct b=
tf *btf,
> +				unsigned int needed_groups, bool needs_lock_syms,
> +				bool needs_slab_iter)
> +{
> +	unsigned int enabled_progs =3D 0;
> +
> +	for (size_t i =3D 0; i < ARRAY_SIZE(lock_progs); i++) {
> +		struct bpf_program **progp =3D (void *)skel + lock_progs[i].prog_offse=
t;
> +		struct bpf_program *prog =3D *progp;
> +		bool enable =3D false;
> +
> +		if ((needed_groups & lock_progs[i].group) && btf &&
> +		    lock_progs[i].btf_func) {
> +			if (btf__find_by_name_kind(btf, lock_progs[i].btf_func,
> +						   BTF_KIND_FUNC) > 0)
> +				enable =3D true;
> +		}
> +
> +		if (enable)
> +			enabled_progs++;
> +		bpf_program__set_autoload(prog, enable);
> +	}
> +
> +	bpf_program__set_autoload(skel->progs.collect_lock_syms, needs_lock_sym=
s);
> +	if (needs_slab_iter && btf &&
> +	    btf__find_by_name_kind(btf, "bpf_iter__kmem_cache", BTF_KIND_STRUCT=
) > 0) {
> +		bpf_program__set_autoload(skel->progs.slab_cache_iter, true);
> +	} else {
> +		bpf_program__set_autoload(skel->progs.slab_cache_iter, false);
> +	}
> +
> +	if (needed_groups && !enabled_progs) {
> +		pr_err("Error: Kernel BTF lacks required lock tracing entry points\n");
> +		return -ENOTSUP;
> +	}
> +	return 0;
> +}

[Severity: Medium]
What happens on kernels where spinlock and rwlock unlock functions are
inlined?

In kernel/Kconfig.locks, when !CONFIG_PREEMPTION && !CONFIG_DEBUG_SPINLOCK
(for example CONFIG_PREEMPT_NONE or CONFIG_PREEMPT_VOLUNTARY without
CONFIG_PREEMPT_DYNAMIC), CONFIG_UNINLINE_SPIN_UNLOCK is not set and
CONFIG_INLINE_SPIN_UNLOCK_IRQ, CONFIG_INLINE_READ_UNLOCK,
CONFIG_INLINE_READ_UNLOCK_IRQ, CONFIG_INLINE_WRITE_UNLOCK, and
CONFIG_INLINE_WRITE_UNLOCK_IRQ are enabled.

In that configuration, _raw_spin_unlock, _raw_spin_unlock_irq,
_raw_read_unlock, _raw_read_unlock_irq, _raw_write_unlock, and
_raw_write_unlock_irq are inlined and absent from vmlinux BTF, while the
acquire functions and *_unlock_irqrestore / *_unlock_bh remain out-of-line
in BTF.

Because configure_lock_progs() enables each program individually if its BTF
function exists and only fails when enabled_progs =3D=3D 0, it will attach =
the
spinlock and rwlock acquire hooks without the corresponding unlock hooks.
Wouldn't any spinlock or rwlock released via an inlined unlock (including
rq_lock, zone_lock, and siglock) remain permanently recorded as held in
held_locks?

> +/*
> + * Pre-scan a single filter expression prior to loading the BPF skeleton=
 in
> + * order to determine which BPF maps need to be sized and which lock tra=
cing
> + * program groups need to be autoloaded.
> + */
> +static void prescan_one_lock_expr(struct perf_bpf_filter_expr *expr,
> +				  bool *has_lock_filter,
> +				  unsigned int *prog_groups,
> +				  bool *needs_lock_syms,
> +				  bool *needs_slab_iter)
> +{

[ ... ]

> +	if (strtailcmp(base, "rt_mutex") =3D=3D 0 || strtailcmp(base, "rtmutex"=
) =3D=3D 0) {
> +		*prog_groups |=3D LOCK_PROG_RTMUTEX;
> +	} else if (strtailcmp(base, "mutex") =3D=3D 0) {
> +		*prog_groups |=3D LOCK_PROG_MUTEX;
> +	} else if (strtailcmp(base, "percpu_rwsem") =3D=3D 0 ||
> +		   strtailcmp(base, "pcpu_rwsem") =3D=3D 0) {
> +		*prog_groups |=3D LOCK_PROG_PERCPU_RWSEM;
> +	} else if (strtailcmp(base, "rwsem") =3D=3D 0) {
> +		if (mode & PBF_LOCK_MODE_READ)
> +			*prog_groups |=3D LOCK_PROG_RWSEM_READ;
> +		if (mode & PBF_LOCK_MODE_WRITE)
> +			*prog_groups |=3D LOCK_PROG_RWSEM_WRITE;

[Severity: Medium]
Can prescan_one_lock_expr() misclassify kernel struct percpu_rw_semaphore
symbols as regular rwsems?

Kernel percpu_rw_semaphore locks defined with DEFINE_PERCPU_RWSEM or
DEFINE_STATIC_PERCPU_RWSEM typically end in _rwsem rather than _percpu_rwsem
(for example cgroup_threadgroup_rwsem, file_rwsem, or scx_fork_rwsem).

In prescan_one_lock_expr(), those symbols match strtailcmp(base, "rwsem") =
=3D=3D 0
and only enable LOCK_PROG_RWSEM_READ and/or LOCK_PROG_RWSEM_WRITE, leaving
LOCK_PROG_PERCPU_RWSEM (fexit_percpu_down_write and fentry_percpu_up_write)
disabled. Since is_direct_lock_owner() only inspects struct mutex, struct
rw_semaphore, and struct rt_mutex_base, won't filtering on a
percpu_rw_semaphore symbol like cgroup_threadgroup_rwsem always evaluate to=
 0?

[ ... ]

> diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/ut=
il/bpf_skel/sample_filter.bpf.c
> index e5666d4c17228..fbd2e51815d75 100644
> --- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
> +++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c

[ ... ]

> +static __always_inline bool is_direct_lock_owner(__u64 lock_addr, __u64 =
curr)
> +{
> +	if (!curr)
> +		return false;
> +
> +	return (__u64)get_lock_owner(lock_addr, LCB_F_MUTEX) =3D=3D curr ||
> +	       (__u64)get_lock_owner(lock_addr, LCB_F_WRITE) =3D=3D curr ||
> +	       (__u64)get_lock_owner(lock_addr, LCB_F_RT) =3D=3D curr;
> +}

[Severity: Medium]
Will calling get_lock_owner(lock_addr, LCB_F_MUTEX) from
is_direct_lock_owner() break loading sample_filter_bpf on CONFIG_PREEMPT_RT=
=3Dy
kernels?

perf_sample_filter() inlines perf_get_sample() -> check_lock_held() ->
is_direct_lock_owner(), which calls get_lock_owner(lock_addr, LCB_F_MUTEX) =
in
tools/perf/util/bpf_skel/lock_data.h:

  if (flags & LCB_F_MUTEX) {
          struct mutex *mutex =3D (void *)lock;

          owner =3D BPF_CORE_READ(mutex, owner.counter);
          if (owner & 0x4UL)
                  return NULL;
  }

On CONFIG_PREEMPT_RT=3Dy kernels, struct mutex wraps struct rt_mutex_base
rtmutex and does not have an owner field. Because get_lock_owner() does not
guard BPF_CORE_READ(mutex, owner.counter) with bpf_core_field_exists(),
wouldn't libbpf poison the instruction during CO-RE relocation and cause the
BPF verifier to reject perf_sample_filter on PREEMPT_RT kernels even when
lock_held() is not used?

[ ... ]

> +static __always_inline int record_lock_released_addr(__u64 lock_addr, __=
u32 flags)
> +{
> +	__u32 owner_id =3D get_lock_owner_id(flags);
> +	struct held_lock_key addr_key =3D {
> +		.addr_or_id =3D lock_addr,
> +		.owner_id =3D owner_id,
> +		.kind =3D PBF_LOCK_ADDR,
> +	};
> +	struct held_lock_val *existing;
> +	__u32 type_flag =3D flags & LCB_F_TYPE_MASK;
> +	bool is_read =3D (flags & LCB_F_READ) !=3D 0;
> +
> +	if (!lock_enabled || !lock_addr)
> +		return 0;
> +
> +	existing =3D bpf_map_lookup_elem(&held_locks, &addr_key);
> +	if (!existing)
> +		return 0;
> +
> +	if (is_read) {
> +		if (existing->read_count <=3D 1 && existing->write_count =3D=3D 0)
> +			bpf_map_delete_elem(&held_locks, &addr_key);
> +		else if (existing->read_count > 0)
> +			__sync_fetch_and_add(&existing->read_count, -1);
> +	} else {
> +		if (existing->write_count =3D=3D 0 && existing->read_count =3D=3D 0)
> +			bpf_map_delete_elem(&held_locks, &addr_key);
> +		else if (existing->read_count =3D=3D 0)
> +			bpf_map_delete_elem(&held_locks, &addr_key);
> +		else
> +			existing->write_count =3D 0;
> +	}

[ ... ]

> +SEC("fexit/downgrade_write")
> +int BPF_PROG(fexit_downgrade_write, void *sem)
> +{
> +	record_lock_acquired(ctx, LCB_F_READ);
> +	return record_lock_released(ctx, LCB_F_WRITE);
> +}

[Severity: Medium]
Can fexit_downgrade_write() leak held_locks map entries under write-only rw=
sem
filters and corrupt PBF_LOCK_SLAB / PBF_LOCK_TYPE write counts?

First, in lock_progs[], fexit_downgrade_write has group LOCK_PROG_RWSEM
(LOCK_PROG_RWSEM_READ | LOCK_PROG_RWSEM_WRITE), while fentry_up_read has gr=
oup
LOCK_PROG_RWSEM_READ:

  LOCK_FPROG(fexit_downgrade_write, "downgrade_write", LOCK_PROG_RWSEM),
  LOCK_FPROG(fentry_up_read, "up_read", LOCK_PROG_RWSEM_READ),
  LOCK_FPROG(fentry_up_write, "up_write", LOCK_PROG_RWSEM_WRITE),

When a write-only filter such as lock_held_write(&mmap_lock) is used,
prescan_one_lock_expr() sets only LOCK_PROG_RWSEM_WRITE. Because
(needed_groups & lock_progs[i].group) is non-zero for LOCK_PROG_RWSEM,
configure_lock_progs() enables fexit_downgrade_write while leaving
fentry_up_read disabled.

When the kernel calls downgrade_write() (for example mmap_write_downgrade()=
),
fexit_downgrade_write() calls record_lock_acquired(ctx, LCB_F_READ), setting
existing->read_count =3D 1, and then calls record_lock_released(ctx,
LCB_F_WRITE), which sees existing->read_count !=3D 0 and sets
existing->write_count =3D 0 instead of deleting addr_key. Since fentry_up_r=
ead
is not attached, up_read() never decrements read_count, leaking the held_lo=
cks
entry (and any PBF_LOCK_SLAB read_count).

Second, because fexit_downgrade_write() calls record_lock_acquired(ctx,
LCB_F_READ) before record_lock_released(ctx, LCB_F_WRITE), if downgrade_wri=
te()
is called on an rwsem whose initial down_write() was not recorded in
held_locks (such as under a read-only filter where LOCK_PROG_RWSEM_WRITE is
disabled, or when acquired before lock_enabled =3D 1), record_lock_acquired=
(ctx,
LCB_F_READ) creates addr_key with read_count =3D 1 and write_count =3D 0. T=
he
subsequent record_lock_released(ctx, LCB_F_WRITE) then finds existing !=3D =
NULL
even though existing->write_count =3D=3D 0, and proceeds to decrement write=
_count
for PBF_LOCK_SLAB and PBF_LOCK_TYPE.

Should fexit_downgrade_write release LCB_F_WRITE before acquiring LCB_F_READ
(and only record LCB_F_READ when LOCK_PROG_RWSEM_READ is active), and should
record_lock_released_addr() verify that the corresponding read_count or
write_count was non-zero before decrementing the aggregate slab/type counts?

[ ... ]

=E5=AE=8C=E7=BE=8E=EF=BC=81 Let's double check all rules:
- No markdown headers, no backticks, no ALL CAPS shouting (except inside qu=
oted code or config/macro names that are literally in code). Wait: `CONFIG_=
DEBUG_LOCK_ALLOC=3Dy`, `PBF_LOCK_SLAB`, `PBF_LOCK_TYPE`, `CONFIG_PREEMPT_RT=
=3Dy`, `LOCK_PROG_RWSEM` are exact code identifiers. Let's make sure there =
are no non-code ALL CAPS words.
- No line numbers mentioned anywhere.
- Ends with a blank line.
- Severity tags `[Severity: Medium]` on their own line right above each inl=
ine comment block.
- All 5 findings included.

Everything is clean and strictly follows instructions. I'm ready to output.=
=E5=AE=8C=E7=BE=8E! Let's emit the final response.commit 362a7c2a8d1d1d0355=
b0ac1b022fdffe73aae6c0
Author: Ian Rogers <irogers@google.com>

perf bpf-filter: Add lock_held() sample filter

This commit adds BPF sample filter predicates lock_held(), lock_held_read(),
lock_held_shared(), lock_held_write(), and lock_held_exclusive() to record
perf event samples only when a specified kernel lock is held. It uses direct
kernel lock owner inspection where possible and falls back to a held_locks
BPF hash map populated by fentry/fexit hooks on kernel lock and unlock
functions.

> diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> index 72e83ac1d6a4b..35d6f7c638684 100644
> --- a/tools/perf/util/bpf-filter.c
> +++ b/tools/perf/util/bpf-filter.c

[ ... ]

> +static const struct lock_prog_desc lock_progs[] =3D {
> +	/* Mutex */
> +	LOCK_FPROG(fexit_mutex_lock, "mutex_lock", LOCK_PROG_MUTEX),
> +	LOCK_FPROG(fexit_mutex_lock_nested, "mutex_lock_nested", LOCK_PROG_MUTE=
X),
> +	LOCK_FPROG(fexit_mutex_lock_io, "mutex_lock_io", LOCK_PROG_MUTEX),
> +	LOCK_FPROG(fexit_mutex_lock_io_nested, "mutex_lock_io_nested", LOCK_PRO=
G_MUTEX),
> +	LOCK_FPROG(fexit_mutex_lock_interruptible, "mutex_lock_interruptible", =
LOCK_PROG_MUTEX),
> +	LOCK_FPROG(fexit_mutex_lock_interruptible_nested, "mutex_lock_interrupt=
ible_nested",
> +		   LOCK_PROG_MUTEX),
> +	LOCK_FPROG(fexit_mutex_lock_killable, "mutex_lock_killable", LOCK_PROG_=
MUTEX),
> +	LOCK_FPROG(fexit_mutex_trylock, "mutex_trylock", LOCK_PROG_MUTEX),
> +	LOCK_FPROG(fentry_mutex_unlock, "mutex_unlock", LOCK_PROG_MUTEX),

[Severity: Medium]
On kernels built with CONFIG_DEBUG_LOCK_ALLOC=3Dy, will mutex acquisitions =
via
mutex_lock_killable(), mutex_trylock(), and mutex_lock_nest_lock() be missed
by the held_locks map?

In include/linux/mutex.h, when CONFIG_DEBUG_LOCK_ALLOC=3Dy, those functions=
 are
macros that expand to different underlying entry points:

  #define mutex_lock(lock) mutex_lock_nested(lock, 0)
  #define mutex_lock_interruptible(lock) mutex_lock_interruptible_nested(lo=
ck, 0)
  #define mutex_lock_killable(lock) _mutex_lock_killable(lock, 0, NULL)
  #define mutex_lock_io(lock) mutex_lock_io_nested(lock, 0)
  #define mutex_lock_nest_lock(lock, nest_lock) _mutex_lock_nest_lock(lock,=
 &(nest_lock)->dep_map)
  #define mutex_trylock(lock) _mutex_trylock_nest_lock(lock, NULL)

While lock_progs[] and sample_filter.bpf.c hook mutex_lock_nested,
mutex_lock_interruptible_nested, and mutex_lock_io_nested, they only hook
mutex_lock_killable and mutex_trylock rather than _mutex_lock_killable,
_mutex_trylock_nest_lock, and _mutex_lock_nest_lock.

For filters that rely on held_locks rather than direct owner inspection (su=
ch
as PBF_LOCK_SLAB and PBF_LOCK_TYPE), wouldn't mutexes acquired via
mutex_lock_killable() or mutex_trylock() go untracked on lockdep-enabled
kernels?

[ ... ]

> +static int configure_lock_progs(struct sample_filter_bpf *skel, struct b=
tf *btf,
> +				unsigned int needed_groups, bool needs_lock_syms,
> +				bool needs_slab_iter)
> +{
> +	unsigned int enabled_progs =3D 0;
> +
> +	for (size_t i =3D 0; i < ARRAY_SIZE(lock_progs); i++) {
> +		struct bpf_program **progp =3D (void *)skel + lock_progs[i].prog_offse=
t;
> +		struct bpf_program *prog =3D *progp;
> +		bool enable =3D false;
> +
> +		if ((needed_groups & lock_progs[i].group) && btf &&
> +		    lock_progs[i].btf_func) {
> +			if (btf__find_by_name_kind(btf, lock_progs[i].btf_func,
> +						   BTF_KIND_FUNC) > 0)
> +				enable =3D true;
> +		}
> +
> +		if (enable)
> +			enabled_progs++;
> +		bpf_program__set_autoload(prog, enable);
> +	}
> +
> +	bpf_program__set_autoload(skel->progs.collect_lock_syms, needs_lock_sym=
s);
> +	if (needs_slab_iter && btf &&
> +	    btf__find_by_name_kind(btf, "bpf_iter__kmem_cache", BTF_KIND_STRUCT=
) > 0) {
> +		bpf_program__set_autoload(skel->progs.slab_cache_iter, true);
> +	} else {
> +		bpf_program__set_autoload(skel->progs.slab_cache_iter, false);
> +	}
> +
> +	if (needed_groups && !enabled_progs) {
> +		pr_err("Error: Kernel BTF lacks required lock tracing entry points\n");
> +		return -ENOTSUP;
> +	}
> +	return 0;
> +}

[Severity: Medium]
What happens on kernels where spinlock and rwlock unlock functions are
inlined?

In kernel/Kconfig.locks, when !CONFIG_PREEMPTION && !CONFIG_DEBUG_SPINLOCK
(for example CONFIG_PREEMPT_NONE or CONFIG_PREEMPT_VOLUNTARY without
CONFIG_PREEMPT_DYNAMIC), CONFIG_UNINLINE_SPIN_UNLOCK is not set and
CONFIG_INLINE_SPIN_UNLOCK_IRQ, CONFIG_INLINE_READ_UNLOCK,
CONFIG_INLINE_READ_UNLOCK_IRQ, CONFIG_INLINE_WRITE_UNLOCK, and
CONFIG_INLINE_WRITE_UNLOCK_IRQ are enabled.

In that configuration, _raw_spin_unlock, _raw_spin_unlock_irq,
_raw_read_unlock, _raw_read_unlock_irq, _raw_write_unlock, and
_raw_write_unlock_irq are inlined and absent from vmlinux BTF, while the
acquire functions and *_unlock_irqrestore / *_unlock_bh remain out-of-line
in BTF.

Because configure_lock_progs() enables each program individually if its BTF
function exists and only fails when enabled_progs =3D=3D 0, it will attach =
the
spinlock and rwlock acquire hooks without the corresponding unlock hooks.
Wouldn't any spinlock or rwlock released via an inlined unlock (including
rq_lock, zone_lock, and siglock) remain permanently recorded as held in
held_locks?

> +/*
> + * Pre-scan a single filter expression prior to loading the BPF skeleton=
 in
> + * order to determine which BPF maps need to be sized and which lock tra=
cing
> + * program groups need to be autoloaded.
> + */
> +static void prescan_one_lock_expr(struct perf_bpf_filter_expr *expr,
> +				  bool *has_lock_filter,
> +				  unsigned int *prog_groups,
> +				  bool *needs_lock_syms,
> +				  bool *needs_slab_iter)
> +{

[ ... ]

> +	if (strtailcmp(base, "rt_mutex") =3D=3D 0 || strtailcmp(base, "rtmutex"=
) =3D=3D 0) {
> +		*prog_groups |=3D LOCK_PROG_RTMUTEX;
> +	} else if (strtailcmp(base, "mutex") =3D=3D 0) {
> +		*prog_groups |=3D LOCK_PROG_MUTEX;
> +	} else if (strtailcmp(base, "percpu_rwsem") =3D=3D 0 ||
> +		   strtailcmp(base, "pcpu_rwsem") =3D=3D 0) {
> +		*prog_groups |=3D LOCK_PROG_PERCPU_RWSEM;
> +	} else if (strtailcmp(base, "rwsem") =3D=3D 0) {
> +		if (mode & PBF_LOCK_MODE_READ)
> +			*prog_groups |=3D LOCK_PROG_RWSEM_READ;
> +		if (mode & PBF_LOCK_MODE_WRITE)
> +			*prog_groups |=3D LOCK_PROG_RWSEM_WRITE;

[Severity: Medium]
Can prescan_one_lock_expr() misclassify kernel struct percpu_rw_semaphore
symbols as regular rwsems?

Kernel percpu_rw_semaphore locks defined with DEFINE_PERCPU_RWSEM or
DEFINE_STATIC_PERCPU_RWSEM typically end in _rwsem rather than _percpu_rwsem
(for example cgroup_threadgroup_rwsem, file_rwsem, or scx_fork_rwsem).

In prescan_one_lock_expr(), those symbols match strtailcmp(base, "rwsem") =
=3D=3D 0
and only enable LOCK_PROG_RWSEM_READ and/or LOCK_PROG_RWSEM_WRITE, leaving
LOCK_PROG_PERCPU_RWSEM (fexit_percpu_down_write and fentry_percpu_up_write)
disabled. Since is_direct_lock_owner() only inspects struct mutex, struct
rw_semaphore, and struct rt_mutex_base, won't filtering on a
percpu_rw_semaphore symbol like cgroup_threadgroup_rwsem always evaluate to=
 0?

[ ... ]

> diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/ut=
il/bpf_skel/sample_filter.bpf.c
> index e5666d4c17228..fbd2e51815d75 100644
> --- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
> +++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c

[ ... ]

> +static __always_inline bool is_direct_lock_owner(__u64 lock_addr, __u64 =
curr)
> +{
> +	if (!curr)
> +		return false;
> +
> +	return (__u64)get_lock_owner(lock_addr, LCB_F_MUTEX) =3D=3D curr ||
> +	       (__u64)get_lock_owner(lock_addr, LCB_F_WRITE) =3D=3D curr ||
> +	       (__u64)get_lock_owner(lock_addr, LCB_F_RT) =3D=3D curr;
> +}

[Severity: Medium]
Will calling get_lock_owner(lock_addr, LCB_F_MUTEX) from
is_direct_lock_owner() break loading sample_filter_bpf on CONFIG_PREEMPT_RT=
=3Dy
kernels?

perf_sample_filter() inlines perf_get_sample() -> check_lock_held() ->
is_direct_lock_owner(), which calls get_lock_owner(lock_addr, LCB_F_MUTEX) =
in
tools/perf/util/bpf_skel/lock_data.h:

  if (flags & LCB_F_MUTEX) {
          struct mutex *mutex =3D (void *)lock;

          owner =3D BPF_CORE_READ(mutex, owner.counter);
          if (owner & 0x4UL)
                  return NULL;
  }

On CONFIG_PREEMPT_RT=3Dy kernels, struct mutex wraps struct rt_mutex_base
rtmutex and does not have an owner field. Because get_lock_owner() does not
guard BPF_CORE_READ(mutex, owner.counter) with bpf_core_field_exists(),
wouldn't libbpf poison the instruction during CO-RE relocation and cause the
BPF verifier to reject perf_sample_filter on PREEMPT_RT kernels even when
lock_held() is not used?

[ ... ]

> +static __always_inline int record_lock_released_addr(__u64 lock_addr, __=
u32 flags)
> +{
> +	__u32 owner_id =3D get_lock_owner_id(flags);
> +	struct held_lock_key addr_key =3D {
> +		.addr_or_id =3D lock_addr,
> +		.owner_id =3D owner_id,
> +		.kind =3D PBF_LOCK_ADDR,
> +	};
> +	struct held_lock_val *existing;
> +	__u32 type_flag =3D flags & LCB_F_TYPE_MASK;
> +	bool is_read =3D (flags & LCB_F_READ) !=3D 0;
> +
> +	if (!lock_enabled || !lock_addr)
> +		return 0;
> +
> +	existing =3D bpf_map_lookup_elem(&held_locks, &addr_key);
> +	if (!existing)
> +		return 0;
> +
> +	if (is_read) {
> +		if (existing->read_count <=3D 1 && existing->write_count =3D=3D 0)
> +			bpf_map_delete_elem(&held_locks, &addr_key);
> +		else if (existing->read_count > 0)
> +			__sync_fetch_and_add(&existing->read_count, -1);
> +	} else {
> +		if (existing->write_count =3D=3D 0 && existing->read_count =3D=3D 0)
> +			bpf_map_delete_elem(&held_locks, &addr_key);
> +		else if (existing->read_count =3D=3D 0)
> +			bpf_map_delete_elem(&held_locks, &addr_key);
> +		else
> +			existing->write_count =3D 0;
> +	}

[ ... ]

> +SEC("fexit/downgrade_write")
> +int BPF_PROG(fexit_downgrade_write, void *sem)
> +{
> +	record_lock_acquired(ctx, LCB_F_READ);
> +	return record_lock_released(ctx, LCB_F_WRITE);
> +}

[Severity: Medium]
Can fexit_downgrade_write() leak held_locks map entries under write-only rw=
sem
filters and corrupt PBF_LOCK_SLAB / PBF_LOCK_TYPE write counts?

First, in lock_progs[], fexit_downgrade_write has group LOCK_PROG_RWSEM
(LOCK_PROG_RWSEM_READ | LOCK_PROG_RWSEM_WRITE), while fentry_up_read has gr=
oup
LOCK_PROG_RWSEM_READ:

  LOCK_FPROG(fexit_downgrade_write, "downgrade_write", LOCK_PROG_RWSEM),
  LOCK_FPROG(fentry_up_read, "up_read", LOCK_PROG_RWSEM_READ),
  LOCK_FPROG(fentry_up_write, "up_write", LOCK_PROG_RWSEM_WRITE),

When a write-only filter such as lock_held_write(&mmap_lock) is used,
prescan_one_lock_expr() sets only LOCK_PROG_RWSEM_WRITE. Because
(needed_groups & lock_progs[i].group) is non-zero for LOCK_PROG_RWSEM,
configure_lock_progs() enables fexit_downgrade_write while leaving
fentry_up_read disabled.

When the kernel calls downgrade_write() (for example mmap_write_downgrade()=
),
fexit_downgrade_write() calls record_lock_acquired(ctx, LCB_F_READ), setting
existing->read_count =3D 1, and then calls record_lock_released(ctx,
LCB_F_WRITE), which sees existing->read_count !=3D 0 and sets
existing->write_count =3D 0 instead of deleting addr_key. Since fentry_up_r=
ead
is not attached, up_read() never decrements read_count, leaking the held_lo=
cks
entry (and any PBF_LOCK_SLAB read_count).

Second, because fexit_downgrade_write() calls record_lock_acquired(ctx,
LCB_F_READ) before record_lock_released(ctx, LCB_F_WRITE), if downgrade_wri=
te()
is called on an rwsem whose initial down_write() was not recorded in
held_locks (such as under a read-only filter where LOCK_PROG_RWSEM_WRITE is
disabled, or when acquired before lock_enabled =3D 1), record_lock_acquired=
(ctx,
LCB_F_READ) creates addr_key with read_count =3D 1 and write_count =3D 0. T=
he
subsequent record_lock_released(ctx, LCB_F_WRITE) then finds existing !=3D =
NULL
even though existing->write_count =3D=3D 0, and proceeds to decrement write=
_count
for PBF_LOCK_SLAB and PBF_LOCK_TYPE.

Should fexit_downgrade_write release LCB_F_WRITE before acquiring LCB_F_READ
(and only record LCB_F_READ when LOCK_PROG_RWSEM_READ is active), and should
record_lock_released_addr() verify that the corresponding read_count or
write_count was non-zero before decrementing the aggregate slab/type counts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017054555.1655=
407-1-irogers@google.com?part=3D2
