Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792702511;
	b=fWugTPDUt48L0bfvcUEeqReG2QptMYSTsCAEPzvHwq5exPSbVMu/ewyzwOD7fPy8DOpy
	 wdyvHsNBN0jBEViBdZewJvmVG8j5xmK+h9R7D6XNbI9gr2uEbUac7Com2fAbk+/yAJDXx
	 qttoh8NVs6603T7ZqTAIoO1GfFWeR4hC/rG0OBf6VDRLRPstKIIk0ttEEUe8+npfoNQ46
	 FFHMyJSSjzMmE7QlpqRSud47jUad7GzVMb+hsYidzlFbc3XwCcqJX2maYZn7NomuNjSq2
	 wvaDyotBBrC+5X2ust7POspMHGRv7KNg/T8ewEWgOQEa8HHrxHdupsqrFkIXPo5FURA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792702511;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rDGMwj3p5ClvblVGwpHW6Ac3SkvQgRNKqw6Is+cXMYo=;
	b=3FW57oRGuNWEpJWlpfyzb1AW0cD7Dk0S0zwymmD6zt7xiVpETXBwX2KaRCq1fJTXe5pA
	 p/pfVAHBJNO9dnxpAzFYGk0p2XhgyI1q6AJsO4DZUhemxnCAwCtZDyIGR8tZNKS1KXlqA
	 J9btVoNERNJeaCm8/bmI7WjWe9orqKmF9CtWMkvV2/eSr9tU+PdXP8gpe23xVI/3vij2h
	 bwFJ+v4UQ1zRuVzIS28nVHhGC5Ne1TlL/gk7T6VMvxqdqxF6N5u6mKV824l3xxo0G7bGC
	 rn4pyxKZ5bDRHxt/JB5JpIZcuYC7XRb7nLWEdlTRVLDSAtkypGxQ72iI6OPRQdBliyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mSVXbcEd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59A5606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mSVXbcEd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD041F01825;
	Thu, 22 Oct 2026 20:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792702510;
	bh=rDGMwj3p5ClvblVGwpHW6Ac3SkvQgRNKqw6Is+cXMYo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mSVXbcEd1osRSf/HH377yXMP7pERKqhYJjkNy5N/Za7OQS2bQSdZXvg382y6BRXFA
	 ZTew/YziPiOg4SFIM6o3ZjD3KvG0oXYoIKskyf9YxYCy0FFD7sw4Eg4lqXSoJGGkg1
	 wPS0us8VPrRsEGScohr1CLv46yyKPfLZyTigaZXBjUslU8YGOZM/Vz4UUu3kU/sRWh
	 NTY6tbiwnpWQbQFh5DxPDwSfw73PLMblBHwqmbbM9BAJEGlgmk5DsekrkiAutDJHq/
	 aVQXDABRwfcJEImPWTu6IMl8JqjDaPE0Kivd5bftxf0wAC56MRJwssU5u44e926D0G
	 L/TSe6rL7xOCg==
Message-ID: <sashiko-outbox-182029@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/11] perf bpf-filter: Extend lock_held() to other
 kernel lock types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022203003.1779152-7-irogers@google.com>
References: <20261020205859.1080743-1-irogers@google.com>
 <20261022203003.1779152-1-irogers@google.com>
 <20261022203003.1779152-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:55:09 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf bpf-filter: prescan_one_lock_expr() misses percpu_rw_semaph=
ore symbols
- [Medium] perf bpf-filter: '*_sem' rw_semaphore and percpu_rw_semaphore sy=
mbols misclassified as counting semaphores
--

commit 088eb8ec579be2bc3ffee09560153843b89f7a25
Author: Ian Rogers <irogers@google.com>

perf bpf-filter: Extend lock_held() to other kernel lock types

This commit extends the lock_held() BPF sample filter to support additional
kernel lock types, lock type flags, and hexadecimal lock addresses. It uses
direct owner inspection where possible and attaches fentry/fexit BPF hooks
to track lock acquisitions and releases in an LRU hash map otherwise.

> diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> index 639db6c031379..8797f67698f7d 100644
> --- a/tools/perf/util/bpf-filter.c
> +++ b/tools/perf/util/bpf-filter.c
[ ... ]
> @@ -301,26 +517,225 @@ static int find_kernel_lock_sym(const char *name, =
u64 *addr)
[ ... ]
>  static void prescan_one_lock_expr(struct perf_bpf_filter_expr *expr,
> -				  bool *has_lock_filter)
> +				  bool *has_lock_filter,
> +				  unsigned int *prog_groups,
> +				  unsigned int *required_groups)
>  {
> +	char base[128];
> +	bool has_amp;
> +	unsigned int mode, groups =3D 0;
> +	u64 dummy;
> +
>  	if (expr->term !=3D PBF_TERM_LOCK_HELD || !expr->lock_name)
>  		return;
> =20
>  	*has_lock_filter =3D true;
> +	if (split_lock_name_mode(expr->lock_name, expr->part, base,
> +				 sizeof(base), &has_amp, &mode) < 0 || has_amp)
> +		return;
> +
> +	if (parse_lock_type_name(base, mode, NULL, NULL, &groups)) {
> +		*prog_groups |=3D groups;
> +		*required_groups |=3D groups;
> +		return;
> +	}
> +
> +	if (parse_lock_hex_addr(base, &dummy)) {
> +		*prog_groups |=3D LOCK_PROG_ALL;
> +		return;
> +	}
> +
> +	if (str_ends_with(base, "rt_mutex") || str_ends_with(base, "rtmutex") ||
> +	    str_ends_with(base, "mutex")) {
> +		/* Inspected directly via lock->owner; no tracing hooks needed. */
> +		return;
> +	} else if (str_ends_with(base, "percpu_rwsem") ||
> +		   str_ends_with(base, "pcpu_rwsem")) {
> +		*prog_groups |=3D LOCK_PROG_PERCPU_RWSEM;
> +		*required_groups |=3D LOCK_PROG_PERCPU_RWSEM;
> +	} else if (str_ends_with(base, "rwsem")) {
> +		if (mode & PBF_LOCK_MODE_READ) {
> +			*prog_groups |=3D LOCK_PROG_RWSEM_READ;
> +			*required_groups |=3D LOCK_PROG_RWSEM_READ;
> +		}
> +		if (mode & PBF_LOCK_MODE_WRITE) {
> +			*prog_groups |=3D LOCK_PROG_RWSEM_WRITE | LOCK_PROG_PERCPU_RWSEM;
> +			*required_groups |=3D LOCK_PROG_RWSEM_WRITE;
> +		}
> +	} else if (str_ends_with(base, "spinlock")) {
> +		*prog_groups |=3D LOCK_PROG_SPIN;
> +		*required_groups |=3D LOCK_PROG_SPIN;
> +	} else if (str_ends_with(base, "sem")) {
> +		*prog_groups |=3D LOCK_PROG_SEM;
> +		*required_groups |=3D LOCK_PROG_SEM;
> +	} else if (str_ends_with(base, "rwlock")) {
> +		if (mode & PBF_LOCK_MODE_READ)
> +			groups |=3D LOCK_PROG_RWLOCK_READ;
> +		if (mode & PBF_LOCK_MODE_WRITE)
> +			groups |=3D LOCK_PROG_RWLOCK_WRITE;
> +		*prog_groups |=3D groups;
> +		*required_groups |=3D groups;
> +	} else {
> +		*prog_groups |=3D LOCK_PROG_ALL;
> +	}
>  }

[Severity: Medium]
In perf_bpf_filter__prepare(), prescan_lock_filters() calls
prescan_one_lock_expr() before btf__load_vmlinux_btf() is called:

perf_bpf_filter__prepare()
  prescan_lock_filters()
    prescan_one_lock_expr()
  ...
  btf =3D btf__load_vmlinux_btf();
  configure_lock_progs(skel, btf, prog_groups, required_groups, ...);
  sample_filter_bpf__load(skel);
  get_filter_entries(evsel, skel, btf, entry)
    resolve_lock_expr(skel, btf, ...)
      is_percpu_rwsem_sym(btf, base)

Because prescan_one_lock_expr() only checks whether base ends with
"percpu_rwsem" or "pcpu_rwsem" without calling is_percpu_rwsem_sym(),
won't percpu_rw_semaphore symbols with other suffixes be misclassified
during prescan?

For example, when filtering on dup_mmap_sem or bp_cpuinfo_sem,
prescan_one_lock_expr() matches str_ends_with(base, "sem") and only sets
LOCK_PROG_SEM. Then configure_lock_progs() disables autoload for
fexit_percpu_down_write and fentry_percpu_up_write before the skeleton is
loaded. When resolve_lock_expr() later runs and identifies the symbol via
is_percpu_rwsem_sym(btf, base), the LOCK_PROG_PERCPU_RWSEM programs were
never loaded or attached.

Similarly, for percpu_rw_semaphore symbols ending in "_rwsem" (such as
cgroup_threadgroup_rwsem) or "_lock" (such as cpu_hotplug_lock and
mem_hotplug_lock), wouldn't prescan_one_lock_expr() enable unnecessary
LOCK_PROG_RWSEM or LOCK_PROG_ALL hooks across other lock families?

> @@ -390,14 +805,42 @@ static int normalize_lock_expr_op(const struct perf=
_bpf_filter_expr *expr,
>  	return -EINVAL;
>  }
> =20
> -static int resolve_lock_expr(struct perf_bpf_filter_expr *expr,
> +static bool is_percpu_rwsem_sym(struct btf *btf, const char *name)
> +{
> +	char rc_name[160];
> +
> +	if (str_ends_with(name, "percpu_rwsem") ||
> +	    str_ends_with(name, "pcpu_rwsem"))
> +		return true;
> +
> +	if (!btf)
> +		return false;
> +
> +	snprintf(rc_name, sizeof(rc_name), "__percpu_rwsem_rc_%s", name);
> +	return btf__find_by_name_kind(btf, rc_name, BTF_KIND_VAR) > 0;
> +}
[ ... ]
> @@ -410,29 +853,79 @@ static int resolve_lock_expr(struct perf_bpf_filter=
_expr *expr,
[ ... ]
> +	ret =3D find_kernel_lock_sym(base, &addr);
> +	if (ret =3D=3D 0) {
> +		unsigned int direct_flag =3D 0;
> +		bool is_pcpu_rwsem =3D is_percpu_rwsem_sym(btf, base);
> +
> +		if (str_ends_with(base, "rt_mutex") || str_ends_with(base, "rtmutex"))
> +			direct_flag =3D PBF_LOCK_DIRECT_RTMUTEX;
> +		else if (str_ends_with(base, "mutex"))
> +			direct_flag =3D PBF_LOCK_DIRECT_MUTEX;
> +		else if (str_ends_with(base, "rwsem") && !is_pcpu_rwsem)
> +			direct_flag =3D PBF_LOCK_DIRECT_RWSEM;
> +
> +		if ((direct_flag =3D=3D PBF_LOCK_DIRECT_MUTEX ||
> +		     direct_flag =3D=3D PBF_LOCK_DIRECT_RTMUTEX ||
> +		     is_pcpu_rwsem ||
> +		     str_ends_with(base, "spinlock") ||
> +		     (str_ends_with(base, "sem") &&
> +		      !str_ends_with(base, "rwsem"))) &&
> +		    !(mode & PBF_LOCK_MODE_WRITE)) {
> +			pr_err("Error: Lock '%s' is exclusive and does not support read/share=
d mode\n",
> +			       name);
> +			return -EINVAL;
> +		}

[Severity: Medium]
How are global or static rw_semaphore locks whose names end in "_sem"
(such as namespace_sem, uts_sem, pci_bus_sem, or dev_addr_sem, defined
with DECLARE_RWSEM) handled here and in prescan_one_lock_expr()?

Because both functions classify any symbol ending in "sem" (and not
"rwsem") as a counting semaphore:

1. In resolve_lock_expr(), read-mode filters such as
   lock_held_read(namespace_sem) or lock_held(uts_sem:R) hit the
   str_ends_with(base, "sem") && !str_ends_with(base, "rwsem") check
   when !(mode & PBF_LOCK_MODE_WRITE) and are rejected with -EINVAL.

2. For write-mode or any-mode filters such as lock_held(namespace_sem)
   or lock_held_write(uts_sem), prescan_one_lock_expr() only enables
   LOCK_PROG_SEM (down/up) and resolve_lock_expr() leaves direct_flag as 0,
   so neither PBF_LOCK_DIRECT_RWSEM nor the down_read/down_write hooks are
   used.

Could BTF type inspection on the symbol (or checking whether the BTF var
type is struct rw_semaphore vs struct semaphore) be used to distinguish
rw_semaphore symbols ending in "_sem" from counting semaphores?

> +
> +		entry->part =3D PBF_LOCK_ADDR | mode | direct_flag;
> +		entry->value =3D addr;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022203003.1779=
152-1-irogers@google.com?part=3D6
