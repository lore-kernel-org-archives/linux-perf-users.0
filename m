Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793777278;
	b=l5z5m7zmLnC5EBHZ+fBG6HG+v5h8XC4Csmv1mJx6ykBEyIIhLceJoiPgjFg1BQJMj3aE
	 BEpxCzqczXNyZuvXoBccYl/hFNNEfIswZZS6R6dbDJWWKuwy5HfRJwfZCcqbogh37pJLa
	 FLKiQuSTDvGe860EwjX+g4RgEy4t0mT0+bbbEVrcBMyAIDRGh2qyBBlD1GP9be30UWHfm
	 DwSbaNmYQXDw4+zxP2Ry6cnBbdIs/Cba9Kj+BOcxg/cci2mdXwpmSyV3+pv1O6D80sf/7
	 kJS99hE5SSHPR4RU6oqQyZwAXQ8M71k7r59raf/UZUZxcAXY3zA39tCN5UNwTc2WmvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793777278;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pptyCmJmQPEMzSvMlHZwf3zUy4ustAl6GnS7BsuFQE0=;
	b=GhSTMqNOHFC2PUU/vlGzKWAwoeFB1Eab71/amo51rN9qSaiFPE2vOSYlqzhpiKTcewB/
	 3bK3egVxpCd+Zexb2hD7EyngxsMir+WmJtyj61tzQbiQ16ppeE0qwJpdQElF8fsn4KvDc
	 wzaRaCtuiHSW+xEolbKEQ+Ypt0EJ+OeA3Nl/TLBZNxbZ4hts2QLBySBO7G3DE7bRRjSrB
	 LMUcrt8TVTtMA5sHTUZhIqOp2Q/1KQfWXdpIeiaml7Nx7PcEoTlSmGl8PYuuSRgxsmcqu
	 N80KHzMDl/+9rzKFchcBOm4xoOE+3syyPcb+7u2H2ZGzhTQgN95NyiHHbBuO92Z+3mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KXhUlhGY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FB0606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 07:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KXhUlhGY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767B21F000C1;
	Wed,  4 Nov 2026 07:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793777277;
	bh=pptyCmJmQPEMzSvMlHZwf3zUy4ustAl6GnS7BsuFQE0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=KXhUlhGYtaC0QwfOjykJ2a/gdS24mqnPkxepqvHoC3u2Kre30sYgkBBlO87Z5bYG3
	 pJYIh0q/WoLr1SHzVqUK9W93FS5bC1Lm045kkUe6IGVR+7ZdLA7oYf16NLVQl7G/Ze
	 3Aq/xOOjiZbIjaDJfVlXu2d+uow0AqZ+lBuypRR1hO29qPvU4YwfK7HjD+jBtyBVbc
	 KajsdKPB300YRIIyr5oU0xeZZgAN+k45oPRCudWQfyhRPBz0OI42wUFqp6kcfw3zlh
	 g6wuZFhX34uE3sTfXSE4466rJVyzg3Me/mMR8HYMPimkz3AJx7rTNuqKH5tuUp1P3z
	 7Cnp9pNPonyrA==
Message-ID: <sashiko-outbox-196793@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 37/41] perf pmu: Probe user-space mmap capabilities
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-38-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-38-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 07:27:57 +0000
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
- [Medium] perf pmu: probe_mmap_caps() skips perf_user_access sysctl on RIS=
C-V
- [Medium] perf pmu: non-advancing counter check in probe_mmap_caps()
--

commit 4c52f2a70c884425ea972ad4877898e6764c69b2
Author: Ian Rogers <irogers@google.com>

perf pmu: Probe user-space mmap capabilities

This commit extends perf_pmu__probe() with probe_mmap_caps() to inspect the
perf_event_mmap_page of an opened PMU event, recording user-space counter
reading support (rdpmc/mrs/csrr), counter bit-width, and user time conversi=
on
capabilities.

> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index bc3c821153b6a..e26563342ad19 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -3820,6 +3820,106 @@ static bool probe_format_pack(const struct perf_p=
mu *pmu, struct perf_event_attr
>  	return true;
>  }
> =20
> +/*
> + * Probe user-space perf_event_mmap_page capabilities, including user-sp=
ace
> + * counter reading (rdpmc/mrs/csrr), counter bit-width, and user time fi=
elds.
> + */
> +static void probe_mmap_caps(struct perf_pmu *pmu,
> +			    const struct perf_event_attr *base_attr,
> +			    pid_t pid, int cpu, unsigned long flags)
> +{

[ ... ]

> +	/*
> +	 * On architectures such as arm64, user-space counter reading must be
> +	 * explicitly requested via format/rdpmc (e.g. config1:1).
> +	 */
> +	if (perf_pmu__has_format(pmu, "rdpmc")) {
> +		struct perf_event_attr r_attr =3D attr;
> +		int uval;
> +
> +		has_rdpmc_cap =3D true;
> +		if (pmu->probed.rdpmc_sysfs < 0 &&
> +		    sysctl__read_int("kernel/perf_user_access", &uval) =3D=3D 0)
> +			pmu->probed.rdpmc_sysfs =3D uval;
> +
> +		if (probe_format_pack(pmu, &r_attr, "rdpmc", 1))
> +			fd =3D sys_perf_event_open(&r_attr, 0, -1, -1, flags);
> +	}

[Severity: Medium]
In probe_mmap_caps(), reading kernel/perf_user_access and setting
has_rdpmc_cap are gated on perf_pmu__has_format(pmu, "rdpmc").

While arm64 PMUs expose format/rdpmc, the RISC-V SBI PMU driver in
drivers/perf/riscv_pmu_sbi.c registers the kernel/perf_user_access sysctl in
sbi_pmu_sysctl_table without exposing a per-PMU sysfs rdpmc file or a
format/rdpmc attribute in riscv_arch_formats_attr:

drivers/perf/riscv_pmu_sbi.c:
    static struct attribute *riscv_arch_formats_attr[] =3D {
        &format_attr_event.attr,
        &format_attr_firmware.attr,
        NULL,
    };

When perf_pmu__probe() -> __perf_pmu__probe() -> probe_mmap_caps() runs on a
RISC-V core PMU, won't this skip reading kernel/perf_user_access, leaving
pmu->probed.rdpmc_sysfs at -1 and leaving pmu->probed.rdpmc_available false
whenever kernel/perf_user_access is 0?

> +
> +	if (fd < 0 && !pmu->is_uncore)
> +		fd =3D sys_perf_event_open(&attr, 0, -1, -1, flags);
> +	if (fd < 0)
> +		fd =3D sys_perf_event_open(&attr, pid, cpu, -1, flags);
> +
> +	if (fd >=3D 0) {
> +		pc =3D mmap(NULL, page_sz, PROT_READ, MAP_SHARED, fd, 0);
> +		if (pc !=3D MAP_FAILED) {
> +			if (has_rdpmc_cap || pc->cap_user_rdpmc) {
> +				pmu->probed.rdpmc_available =3D true;
> +				pmu->probed.pmc_width =3D pc->pmc_width;
> +			}
> +			if (pc->cap_user_rdpmc && pc->index !=3D 0) {
> +				struct perf_mmap map =3D { .base =3D pc };
> +				struct perf_counts_values start =3D { .val =3D 0 };
> +				struct perf_counts_values end =3D { .val =3D 0 };
> +
> +				pmu->probed.can_user_rdpmc =3D true;
> +				if (perf_mmap__read_self(&map, &start) =3D=3D 0) {
> +					for (int spin =3D 0; spin < 10000; spin++)
> +						barrier();
> +					if (perf_mmap__read_self(&map, &end) =3D=3D 0 &&
> +					    end.val >=3D start.val && end.val > 0)
> +						pmu->probed.rdpmc_works =3D true;
> +				}
> +			}

[Severity: Medium]
Should the check in probe_mmap_caps() be end.val > start.val instead of
end.val >=3D start.val && end.val > 0?

When an active hardware event is opened and its perf_event_mmap_page is
mapped, the kernel's period initialization (such as x86_perf_event_set_peri=
od,
armpmu_event_set_period, and riscv_pmu_event_set_period) sets
event->hw.prev_count to (u64)-left, and perf_event_update_userpage() sets
userpg->offset to +left > 0.

In user space, perf_mmap__read_self() computes:

    cnt =3D pc->offset + evcnt;

Because pc->offset is already positive, if read_perf_counter() returns 0 (f=
or
instance via the fallback stub in tools/lib/perf/mmap.c) or if the hardware
counter does not advance across the 10,000-iteration spin loop, start.val a=
nd
end.val will both equal the same positive constant, causing end.val >=3D
start.val && end.val > 0 to evaluate to true and set pmu->probed.rdpmc_works
even when the counter did not advance.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D37
