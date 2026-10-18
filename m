Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D490C3D16E4
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 05:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792302684; cv=none; b=tAdc1If/r+54zyxV2xy+sLospaa5TJEjtWAkwkCoVj3+0p3IiSoNDH9jlJuhc2pw+rwEOJdBwBKqUSjlngfTwQeZ1hi5FoSdy+YDh0oRrfEpkMCnxanDcYp/mM9eDgEi9/AJt0X2Pe3hR3awGIckPn2Ro3+/YLiOJTRJ8hQY77I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792302684; c=relaxed/simple;
	bh=UxWbXvhWoU77YdjY0dbwtKEwZrLoJh/2QFrL6rnkXt8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=fEGNP785y0RI1/NqLqg0RliOXeQtd49dtR/gXZP/AjI+Cz6XTI4XGJpIuEZglQbrnb6rXR2I408ncMx+6T5f0P0VhF8tx4oAHjxaYq9JY2zoYSJpbbG5Ibx16Ot+kIMiXk/y9MB9SxIZTv3ZQQJ6CJLZZwQnE19Zg1XMhPREFHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfxNT3oq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfxNT3oq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD721F000C4;
	Sun, 18 Oct 2026 05:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792302683;
	bh=Pmkx8sWwSMqOXUiKcJOMjxhVBpJv0HvNy4pdPmYlAiY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RfxNT3oqGeLs4XhQtcz+kBqDZ1SHfcsU0tJlJbYn69hzNSg4Z8Hl8/pnU421WpZXI
	 5Kqr8ZYQ4M58TGjv/OKy+xXkp1P5o5Qa2vGfqjJUVKWzS0RV38N0kmh5WJ3w5Q9OCF
	 0RWlHD5WN2nwqHl8Y/JdAvv4DhUiFzhBw9l/X2TEOyytrqdCLCUCEBSMCZoHLecZaF
	 yIaGCmHsZi9XJ59aRE2CGLCnkR2K5A90fYUmWdNhTFcAxgaOHX48NRxsemZalX0yoN
	 KNd6hhMeLyCP3zNVmAikdz/r4LBGgXEFc4w2Bwull94WGyz3Sa780ttiv+o4VAbTc6
	 Ard8DGfe482aA==
Message-ID: <sashiko-outbox-175958@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/6] perf bpf-filter: Extend lock_held() to support
 RCU, Tasks Trace RCU, and SRCU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261018053710.2572636-5-irogers@google.com>
References: <20261017171437.2066343-1-irogers@google.com>
 <20261018053710.2572636-1-irogers@google.com>
 <20261018053710.2572636-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 05:51:22 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf bpf-filter: btf_has_task_field() misses anon struct under R=
ANDSTRUCT
--

commit 5ff446ff868169d426bb172f1b13dc459b646352
Author: Ian Rogers <irogers@google.com>

perf bpf-filter: Extend lock_held() to support RCU, Tasks Trace RCU, and SR=
CU

This commit extends the lock_held(<lock>) BPF sample filter to support RCU,
Tasks Trace RCU, and SRCU locks. For RCU and Tasks Trace RCU read-side
critical sections, it inspects task_struct nesting fields via CO-RE, while
attaching fentry/fexit hooks for SRCU and RCU synchronize/barrier waits.

> diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> index 0c133b31b5d54..4a5ef78e26900 100644
> --- a/tools/perf/util/bpf-filter.c
> +++ b/tools/perf/util/bpf-filter.c

[ ... ]

> @@ -847,16 +913,54 @@ static bool find_slab_cache(struct sample_filter_bp=
f *skel, const char *name,
>  	return false;
>  }
> =20
> +static u64 rcu_min_depth(struct evsel *evsel)
> +{
> +	if (evsel && evsel->core.attr.type =3D=3D PERF_TYPE_SOFTWARE &&
> +	    evsel->core.attr.config !=3D PERF_COUNT_SW_CPU_CLOCK &&
> +	    evsel->core.attr.config !=3D PERF_COUNT_SW_TASK_CLOCK)
> +		return 2;
> +	return 1;
> +}
> +
> +static bool btf_has_task_field(struct btf *btf, const char *field_name)
> +{
> +	const struct btf_type *t;
> +	const struct btf_member *m;
> +	s32 id;
> +	u16 i, vlen;
> +
> +	if (!btf)
> +		return false;
> +
> +	id =3D btf__find_by_name_kind(btf, "task_struct", BTF_KIND_STRUCT);
> +	if (id < 0)
> +		return false;
> +
> +	t =3D btf__type_by_id(btf, id);
> +	if (!t)
> +		return false;
> +
> +	m =3D btf_members(t);
> +	vlen =3D btf_vlen(t);
> +	for (i =3D 0; i < vlen; i++, m++) {
> +		const char *name =3D btf__name_by_offset(btf, m->name_off);
> +
> +		if (name && !strcmp(name, field_name))
> +			return true;
> +	}
> +	return false;
> +}

[Severity: Medium]
In include/linux/sched.h, both rcu_read_lock_nesting and trc_reader_nesting
are declared inside the randomized_struct_fields_start /
randomized_struct_fields_end block of struct task_struct:

include/linux/sched.h:
    struct task_struct {
        ...
        randomized_struct_fields_start
        ...
    #ifdef CONFIG_PREEMPT_RCU
        int rcu_read_lock_nesting;
        ...
    #endif
    #ifdef CONFIG_TASKS_TRACE_RCU
        int trc_reader_nesting;
        ...
    #endif
        ...
        randomized_struct_fields_end
    };

When CONFIG_RANDSTRUCT is enabled, randomized_struct_fields_start wraps tho=
se
fields inside an anonymous struct member of task_struct, which appears in
vmlinux BTF as a member with m->name_off =3D=3D 0 pointing to an inner
BTF_KIND_STRUCT.

While libbpf CO-RE in sample_filter.bpf.c recursively descends into anonymo=
us
structs and unions, btf_has_task_field() only iterates over the direct
top-level members of task_struct.

Will btf_has_task_field() return false on CONFIG_RANDSTRUCT kernels, causing
resolve_lock_expr() to reject lock_held(rcu) and lock_held(rcu-trace) with
-EOPNOTSUPP?

[ ... ]

> @@ -929,6 +1033,48 @@ static int resolve_lock_expr(struct sample_filter_b=
pf *skel,
>  		return 0;
>  	}
> =20
> +	if (!strcmp(base, "rcu_read_lock")) {
> +		if (mode =3D=3D PBF_LOCK_MODE_WRITE) {
> +			pr_err("Error: Lock '%s' only supports read/shared mode\n", name);
> +			return -EINVAL;
> +		}
> +		if (btf && !btf_has_task_field(btf, "rcu_read_lock_nesting")) {
> +			pr_err("Error: lock_held(rcu) requires CONFIG_PREEMPT_RCU\n");
> +			return -EOPNOTSUPP;
> +		}
> +		entry->part =3D PBF_LOCK_RCU | PBF_LOCK_MODE_READ;
> +		entry->target =3D rcu_min_depth(evsel);
> +		return 0;
> +	}

[ ... ]

=E2=80=94
=F0=9F=A4=96 Generated by Linux Kernel Patch Reviewer (Model: gemini-3.1-pr=
o-preview)

 Prompts used:
 - bpf.md (https://raw.githubusercontent.com/masoncl/review-prompts/main/bp=
f.md)
 - btf.md (https://raw.githubusercontent.com/masoncl/review-prompts/main/bt=
f.md)
 - inline-template.md (https://raw.githubusercontent.com/masoncl/review-pro=
mpts/main/inline-template.md)
 - libbpf.md (https://raw.githubusercontent.com/masoncl/review-prompts/main=
/libbpf.md)
 - perf.md (https://raw.githubusercontent.com/masoncl/review-prompts/main/p=
erf.md)
 - rcu.md (https://raw.githubusercontent.com/masoncl/review-prompts/main/rc=
u.md)
 - tracing.md (https://raw.githubusercontent.com/masoncl/review-prompts/mai=
n/tracing.md)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018053710.2572=
636-1-irogers@google.com?part=3D4
