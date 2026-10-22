Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792702172;
	b=O0/SjnYHilL+DzOUAFSLqKjhm/jtCrfJPV/FOMoqSgvXho031snYGaCiY52HMXGmMqEO
	 WHPN6T7ck/YXQ0BcUmAjiz8MDJUIfTxKGhLso/Xl8Dj0aQgKoXH6ch6ziDTb2mm36VgoH
	 yQ2e7gHIz2xamURMQqM8nuNP0dPE1N8MuBTuuy7SWXkxh6oD7dsHolJtOHFATx/Oh0OHW
	 cAWeB1rCdereur9vK1Q53fHhm8wnhiBjgzTo25iqseM/tX6sYrJ3I1ePXjuSXpXMRsqAF
	 qaUYBxYpaBBlwGObzTQgBbrELKpwyarI8l5KZo83OrbbX5IQ5V2qumVLMtr8DPfnlUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792702172;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=idx1dRwz791Pien9DzZHQgjL2OpriBfJwxagg5f0+qs=;
	b=K1C8p0+usKDCSe+qu7d3p4Flzz3GOQRe8n7AnWLMr0tkKIambOpMabIEBzvwZojRfdBi
	 l4+RVa1BlkkuJ5615BC82Hol2f56sHzFRQBRUbEF0EVhTv5WeeDRIhR6JIdN5gvfLSR0s
	 zuzPsr+zYDNoKmA7xno0EOhluVaMJxAVJXQAkOHorHkKiwo0b7yeUrms+RtKrOIyn40NU
	 qrF4/OQGsAtpxuqjYzfcU2ZGFKMjIl76ZmqgSNq1WSy9x6POdLWJ0UwCgrWu996kC2sPd
	 94fHJW5/LnqaUZlbx1YTSuuZ5O1Vxth8H599/n8XvF4Q57i7GJvshyT0fPytQs3snRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YpG7kdWh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3786606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YpG7kdWh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1C01F01825;
	Thu, 22 Oct 2026 20:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792702171;
	bh=idx1dRwz791Pien9DzZHQgjL2OpriBfJwxagg5f0+qs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YpG7kdWhqrt18P5x8aVRNK4Nmdv7nToJpnFnZgNkocN02XkS/Aj4GagWuJaS4AkLM
	 n/h4xD7yXTMEn7vjfKkHbV2G8GMwn0sX5WJLbznn9hGYtlLIu3gFpQ/1Wt0OxNkn4u
	 /yBlR145VaeO6W2Kdkijs7D6KTNwt31hKvKdjwsuMzjch5JckqKgjQA+7r4OkAwMzK
	 rNLRSim/MKj4k+hFk7KhTAdDrMnbpe8Rpi4SdutPphqYesuRR57SPIut9fSWH6r8OW
	 8zaOf133ud64iM7iJFkFApy7HTNxAdLyS29wsHgEKyhctGdVcVqmePdxa7kmxqoGiG
	 jQ59RVKmsThbQ==
Message-ID: <sashiko-outbox-182025@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/11] perf bpf-filter: Support per-process and
 semi-global locks in lock_held()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022203003.1779152-8-irogers@google.com>
References: <20261020205859.1080743-1-irogers@google.com>
 <20261022203003.1779152-1-irogers@google.com>
 <20261022203003.1779152-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:49:30 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf bpf-filter: unhandled zone_lock resolution errors in init_n=
uma_data()
--

commit f38f272294852331e8bd18c104c37ae24d5b109c
Author: Ian Rogers <irogers@google.com>

perf bpf-filter: Support per-process and semi-global locks in lock_held()

This commit extends the lock_held() BPF sample filter to support the
per-process locks mmap_lock and siglock as well as the semi-global locks
rq_lock and zone_lock. For rq_lock and zone_lock, it populates the lock_syms
BPF map at filter setup time via a raw_tp/bpf_test_finish program.

> diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> index 8797f67698f7d..f542920f914fc 100644
> --- a/tools/perf/util/bpf-filter.c
> +++ b/tools/perf/util/bpf-filter.c
> @@ -534,6 +534,54 @@ static bool parse_lock_hex_addr(const char *str, u64=
 *addr)
>  	return true;
>  }
> =20
> +static void init_numa_data(struct sample_filter_bpf *skel, struct btf *b=
tf)
> +{
> +	u64 addr =3D 0;
> +	char *buf =3D NULL, *p;
> +	size_t len;
> +	long last =3D -1;
> +	int ret;
> +
> +	if (!btf)
> +		return;
> +
> +	ret =3D btf__find_by_name_kind(btf, "zone", BTF_KIND_STRUCT);
> +	if (ret < 0)
> +		return;
> +
> +	ret =3D btf__resolve_size(btf, ret);
> +	if (ret < 0)
> +		return;
> +
> +	skel->rodata->sizeof_zone =3D ret;
> +
> +	if (find_kernel_lock_sym("contig_page_data", &addr) =3D=3D 0) {
> +		skel->rodata->contig_page_data_addr =3D addr;
> +		return;
> +	}
> +
> +	if (find_kernel_lock_sym("node_data", &addr) !=3D 0)
> +		return;
> +
> +	skel->rodata->node_data_addr =3D addr;
> +
> +	if (sysfs__read_str("devices/system/node/online", &buf, &len) >=3D 0) {
> +		p =3D buf;
> +		while (p && *p) {
> +			char *end;
> +
> +			last =3D strtol(p, &end, 0);
> +			if (end =3D=3D p)
> +				break;
> +			p =3D end;
> +			if (*p =3D=3D ',' || *p =3D=3D '-' || *p =3D=3D '\n')
> +				p++;
> +		}
> +		skel->rodata->nr_nodes =3D last + 1;
> +		free(buf);
> +	}
> +}
> +
>  static bool btf_has_func(struct btf *btf, const char *name)

[ ... ]

> @@ -657,7 +707,8 @@ static int configure_lock_progs(struct sample_filter_=
bpf *skel, struct btf *btf,
>  static void prescan_one_lock_expr(struct perf_bpf_filter_expr *expr,
>  				  bool *has_lock_filter,
>  				  unsigned int *prog_groups,
> -				  unsigned int *required_groups)
> +				  unsigned int *required_groups,
> +				  bool *needs_lock_syms)
>  {
>  	char base[128];
>  	bool has_amp;
> @@ -672,6 +723,29 @@ static void prescan_one_lock_expr(struct perf_bpf_fi=
lter_expr *expr,
>  				 sizeof(base), &has_amp, &mode) < 0 || has_amp)
>  		return;
> =20
> +	if (!strcmp(base, "mmap_lock") || !strcmp(base, "mmap_sem")) {
> +		/*
> +		 * Write ownership of mm->mmap_lock is inspected directly via
> +		 * is_rwsem_writer_owner() without tracing hooks; only reader
> +		 * tracking requires LOCK_PROG_RWSEM_READ.
> +		 */
> +		if (mode & PBF_LOCK_MODE_READ) {
> +			*prog_groups |=3D LOCK_PROG_RWSEM_READ;
> +			*required_groups |=3D LOCK_PROG_RWSEM_READ;
> +		}
> +		return;
> +	}
> +	if (!strcmp(base, "siglock")) {
> +		*prog_groups |=3D LOCK_PROG_SPIN;
> +		*required_groups |=3D LOCK_PROG_SPIN;
> +		return;
> +	}
> +	if (!strcmp(base, "rq_lock") || !strcmp(base, "zone_lock")) {
> +		*prog_groups |=3D LOCK_PROG_SPIN;
> +		*required_groups |=3D LOCK_PROG_SPIN;
> +		*needs_lock_syms =3D true;
> +		return;
> +	}

[ ... ]

> @@ -853,6 +932,53 @@ static int resolve_lock_expr(struct sample_filter_bp=
f *skel, struct btf *btf,

[ ... ]

> +	if (!strcmp(base, "zone_lock")) {
> +		if (!(mode & PBF_LOCK_MODE_WRITE)) {
> +			pr_err("Error: Lock '%s' is exclusive and does not support read/share=
d mode\n",
> +			       name);
> +			return -EINVAL;
> +		}
> +		entry->part =3D PBF_LOCK_CLASS | mode;
> +		entry->value =3D LOCK_CLASS_ZONE_LOCK;
> +		if (skel)
> +			skel->bss->has_lock_class =3D 1;
> +		return 0;
> +	}

[ ... ]

> @@ -1280,12 +1406,16 @@ int perf_bpf_filter__prepare(struct evsel *evsel,=
 struct target *target)
>  		btf =3D btf__load_vmlinux_btf();
>  		bpf_map__set_max_entries(skel->maps.held_locks, MAX_ENTRIES);
>  		bpf_map__set_max_entries(skel->maps.lock_addr_filter, MAX_FILTERS);
> +		if (needs_lock_syms) {
> +			bpf_map__set_max_entries(skel->maps.lock_syms, MAX_ENTRIES);
> +			init_numa_data(skel, btf);
> +		}

[Severity: Medium]
In perf_bpf_filter__prepare() -> prescan_lock_filters() ->
prescan_one_lock_expr(), both rq_lock and zone_lock set *needs_lock_syms =3D
true, and perf_bpf_filter__prepare() unconditionally calls
init_numa_data(skel, btf) whenever needs_lock_syms is set.

When a user only specifies lock_held(rq_lock), which resolves runqueues via
BPF BTF ksym and does not use kallsyms or NUMA zone data, init_numa_data()
still queries kallsyms for contig_page_data and node_data. If /proc/kallsyms
addresses are restricted (for instance under kptr_restrict=3D2 or when runn=
ing
with CAP_BPF without CAP_SYSLOG), find_kernel_lock_sym() prints spurious
permission error messages for NUMA symbols that rq_lock does not use. Also,
on a UMA kernel where contig_page_data exists in /proc/kallsyms with address
0, find_kernel_lock_sym("contig_page_data", &addr) prints an error and
returns -EACCES, and init_numa_data() then falls through to query node_data
as well.

Conversely, when a user specifies lock_held(zone_lock), init_numa_data()
returns void and silently ignores failures if BTF lookup or size resolution
for struct zone fails, if both find_kernel_lock_sym("contig_page_data",
&addr) and find_kernel_lock_sym("node_data", &addr) fail, or if
sysfs__read_str("devices/system/node/online", ...) fails (leaving
skel->rodata->nr_nodes as 0).

In resolve_lock_expr(), the zone_lock branch then succeeds without checking
whether skel->rodata->contig_page_data_addr or skel->rodata->node_data_addr
(with skel->rodata->nr_nodes > 0) was populated. As a result,
collect_lock_syms() runs do_collect_zone_lock() with zeroed addresses,
populates zero LOCK_CLASS_ZONE_LOCK entries in lock_syms, and attaches
kernel-wide spinlock fentry/fexit programs for a filter that can never match
any zone_lock.

Should init_numa_data() only be invoked when zone_lock is used, and should
failures to resolve the NUMA zone parameters be propagated so that
perf_bpf_filter__prepare() aborts instead of attaching a non-functional
zone_lock filter?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022203003.1779=
152-1-irogers@google.com?part=3D7
