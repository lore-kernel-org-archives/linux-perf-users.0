Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773150;
	b=RLpBU/Nxqqb/G0Rp3/twta27aCl5Ko12Y6vsepAKADYmAyBtGB2GWW4IJjRXZ2f6+dGw
	 MfgqjVxKxHQtHOWUyrw8HwfAAoSoO+y8+4sr+/bMwuKAZ6LRXrVRUF+bDIWVa8Ae5f4Tz
	 gfCbkALmRF9Z57LN7pIut7tcZM9TEPLBm+7f40TMAnOhRQqRgJqtIzvWvzAryENmyjCVG
	 97gqRfttpavgODsApgw1BM422bfuMRjR3e3rrmtRxVX2jWn/JFGw7eHSKJjTfxS3fA40W
	 9YyK6Dhls6Id1OkK70pxoHPcVqokH5xY8mPk3b6YceAPex3aVCbGKS5bUejnf3silHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773150;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=n5sT6rwFmovLzWg/OzDRfZoyvG91NWkTIqIg3I2+WjE=;
	b=AmB6gt9fDlB2PAPedx/vMSEwKJjDVwWoZ3MDK2ujjQf63IGFPh6ND0+i7VXZlMgS2Xfy
	 mKv6807U5unNaDXstr75T4kKjyGWeAKdAB7bY22mUpFL52MS5+hwig7oBXBM/OqrKxvuy
	 m8e65lhL3LkEWPT164jjyZcs/BgEr4bhz4i4wIbNhhQuaZw188UJdE3mKBfv0COmEYoCF
	 LKQR2PUWbmwjixgjWJMfuilN8s1y/te3cla62+FGPBLT/Rn3VJjtzaPo4aNTuvFtcWN9V
	 LBgO1d9kGGKemJ3pumNDuZivkCAyWHQPlfKcVn3uSiLqq4qdEj0wUayqb6aFYCx7z0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mt4M+BpH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316A1606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 06:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mt4M+BpH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F6B1F00919;
	Wed,  4 Nov 2026 06:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793773149;
	bh=n5sT6rwFmovLzWg/OzDRfZoyvG91NWkTIqIg3I2+WjE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Mt4M+BpHU7keGl+dd7B5BpvUjRTHBlZsv8hlBtuWmnC5SUuXk4hH9xKLOUdTNRD/u
	 fzFBHLZeE9aXi4uTW50r0Tgh8+lttxr3uIUsWPgCzLsJsuvz5dUvWXsenoDgFYJJ/e
	 leWEGJd+SpIb8KaLI+Oikhst2G/ugWM6Ze0GI7Cn5F3ny4IEBRn7s+QJjyt5cd1NqE
	 7kYKYt8IVT/0kiZRYuXxt1azVXvsyHn0nXRGqR4K5aD+GMAa3ZmOck6Gob1fmgOVLN
	 HB9HYxEtvXIsb36BA4dCpk2SaRtvjUEQCnz7smvHqcTFy3N3MWAHFNPvPCFN9axJOC
	 fP99EW2HEF5GA==
Message-ID: <sashiko-outbox-196752@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 32/41] perf pmu: Probe execution and AUX area
 features
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-33-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-33-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 06:19:09 +0000
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
- [Medium] perf pmu: false can_inherit on CPU-wide PMUs in __perf_pmu__prob=
e()
- [Medium] perf pmu: unclamped sample_freq=3D4000 in __perf_pmu__probe() fr=
eq probe
--

commit 6dd54e3c43c6f5454547c748099797fce6fa163c
Author: Ian Rogers <irogers@google.com>

perf pmu: Probe execution and AUX area features

This commit extends perf_pmu__probe() to probe event execution, grouping,
auto-counter reload, and AUX area features via perf_event_open() and
ioctl(PERF_EVENT_IOC_ENABLE).

> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index a1e27e678ccfc..e7e05e29b695d 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c

[ ... ]

> @@ -3576,6 +3659,256 @@ static void __perf_pmu__probe(struct perf_pmu *pm=
u, int pmu_cpu)

[ ... ]

> +	{
> +		struct perf_event_attr inh_attr =3D base_attr;
> +		int fd;
> +
> +		inh_attr.disabled =3D 1;
> +		inh_attr.inherit =3D 1;
> +		fd =3D sys_perf_event_open(&inh_attr, pid, cpu, -1, flags);
> +		if (fd >=3D 0) {
> +			close(fd);
> +			pmu->probed.can_inherit =3D true;
> +		}
> +	}

[Severity: Medium]
Will this falsely set pmu->probed.can_inherit to true on uncore and
CPU-wide-only PMUs?

Earlier in __perf_pmu__probe()->try_open_attr_variants(), pid is set to -1
first for uncore PMUs and as a fallback for any PMU that rejects per-task
events:

tools/perf/util/pmu.c:try_open_attr_variants() {
	if (is_uncore) {
		pids[0] =3D -1;
		pids[1] =3D 0;
	} else {
		pids[0] =3D 0;
		pids[1] =3D -1;
	}
}

In the kernel, when pid is -1, task is NULL. perf_event_alloc() only
rejects perf_invalid_context PMUs when task is non-NULL (or cgroup_fd !=3D =
-1)
and ignores attr.inherit =3D 1 on CPU-wide events:

kernel/events/core.c:perf_event_alloc() {
	if (pmu->task_ctx_nr =3D=3D perf_invalid_context && (task || cgroup_fd !=
=3D -1))
		return ERR_PTR(-EINVAL);
}

As a result, calling sys_perf_event_open(&inh_attr, pid, cpu, -1, flags)
with pid =3D=3D -1 succeeds on uncore and CPU-wide-only PMUs even though th=
ose
PMUs cannot monitor tasks or inherit events across child tasks. Should the
can_inherit probe explicitly pass pid =3D 0 instead of pid?

> +
> +	if (pmu->probed.can_sample) {
> +		struct perf_event_attr freq_attr =3D base_attr;
> +		int fd;
> +
> +		freq_attr.disabled =3D 1;
> +		freq_attr.freq =3D 1;
> +		freq_attr.sample_freq =3D 4000;
> +		freq_attr.sample_type =3D PERF_SAMPLE_IP;
> +		fd =3D sys_perf_event_open(&freq_attr, pid, cpu, -1, flags);
> +		if (fd >=3D 0) {
> +			close(fd);
> +			pmu->probed.can_freq =3D true;
> +		}
> +	}

[Severity: Medium]
Can hardcoding sample_freq =3D 4000 here cause pmu->probed.can_freq to be
falsely reported as false when kernel.perf_event_max_sample_rate has been
lowered?

In SYSCALL_DEFINE5(perf_event_open), the kernel rejects frequency mode
events when attr.sample_freq exceeds sysctl_perf_event_sample_rate:

kernel/events/core.c:SYSCALL_DEFINE5(perf_event_open) {
	if (attr.freq) {
		if (attr.sample_freq > sysctl_perf_event_sample_rate)
			return -EINVAL;
	}
}

Because perf_sample_event_took() dynamically throttles
sysctl_perf_event_sample_rate down to as low as 1 * HZ when PMIs take too
long (or an administrator may configure a limit below 4000), should this
probe use a minimal value like sample_freq =3D 1 (or clamp to
kernel/perf_event_max_sample_rate like record_opts__config_freq() does)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D32
