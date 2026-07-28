Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF3731E852;
	Tue, 28 Jul 2026 21:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785274313; cv=none; b=XzDeOancwVR39d+4Dwf2s4pbF8PUtXWYswSQ3xufEmoJHs3GlyS26TLLZ2B1pO5FIJv9YEDA0qmH2PCL6cWGT24enugB4Zm7nXJJ3lFjgNn0A6iHW7tAdioxcaoMgQ+pijAN5LZA4iyuPApn1/9r9WM7sJ6rjotV9TvA2N83XHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785274313; c=relaxed/simple;
	bh=yKpt2ubkQ0ORgLVfOR4kriA/86bk7MAc09QHEsJ0KtA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ssehjF1er1OHKrKId0LCqRh2CPmJbsdlaBHQIA7KvCmY+9qCfJNXyQFlbklGWq5Ypr31f3Yz14bWxMKiRQuLeAt6h8xdNIAO4eYSi2CeRia8OpqpyKf8BbAo9cDIK07r9PikLX9Zq8vmjpQReUTpQGHdC4Q22bnDgsU3cdwJ4PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoG41n8S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoG41n8S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF401F000E9;
	Tue, 28 Jul 2026 21:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785274311;
	bh=nMK8q2uKH/EPsUfI6SWJA3crRfRdW4PT9sXekboIyk0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hoG41n8SzH9K3DYU6HYVxSvlXQPh5fS7A9ETZ+IAJze24we2bRpabucMCOVNO3JDK
	 vr+0veWfHq/EeHBtN1PUZ5yzNcFgP/J9J78HBnVfKYGf+SHvJQHa1wt0TlR0Jl7Y3C
	 iQI1Me4Jz6lBSNiy6ve6NBxGlsjxLXE2bpH7IeoYJuS+I+RFOyQch6tUi7ON1jFGm2
	 nn6O64UM8HBIbABXjYxz2hJIIaZC4rdnH1kcJfsV5ySkLqmTGkWTCUHtZrKYjNm1Up
	 LowKKPvVmqhRikoHYMTdMd4/S6PH2e5nkVxMGopDDt2P4qir/bGZa1sBYAPzY1BRz7
	 UuWW4Zyt3HMyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 9/9] perf/cxl: Avoid cpumask_of(-1) when no CPU is
 assigned
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260728210551.2449093-10-dave.jiang@intel.com>
References: <20260728210551.2449093-1-dave.jiang@intel.com>
 <20260728210551.2449093-10-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 21:31:50 +0000
Message-Id: <20260728213151.3AF401F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fixes an out-of-bounds pointer dereference in `cpumask_s=
how()` caused by `info->on_cpu =3D=3D -1`, but fails to fix the exact same =
condition in `cxl_pmu_event_init()`. This omission allows `event->cpu` to b=
ecome `-1`, leading to an out-of-bounds array read and a wild pointer deref=
erence in the perf core.
--

--- Patch [9]: [PATCH 9/9] perf/cxl: Avoid cpumask_of(-1) when no CPU is as=
signed ---
commit 94b991fd5de15c6e9d3fde196012a4cea806254d
Author: Dave Jiang <dave.jiang@intel.com>

perf/cxl: Avoid cpumask_of(-1) when no CPU is assigned

This patch fixes an out-of-bounds pointer dereference in cpumask_show()
by checking if info->on_cpu is -1. When no CPU is assigned, it emits
an empty mask instead of performing invalid pointer arithmetic.

Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolab=
s.net?part=3D1

> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index f1110c5029d6a..80145e85fe36b 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -501,8 +501,17 @@ static ssize_t cpumask_show(struct device *dev, stru=
ct device_attribute *attr,
>  			    char *buf)
>  {
>  	struct cxl_pmu_info *info =3D dev_get_drvdata(dev);
> +	int cpu =3D READ_ONCE(info->on_cpu);
> =20
> -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(info->on_cpu));
> +	/*
> +	 * on_cpu is -1 before the first online callback and transiently during
> +	 * cxl_pmu_offline_cpu(). cpumask_of(-1) computes an out-of-bounds
> +	 * pointer, so report an empty mask instead.
> +	 */
> +	if (cpu < 0)
> +		return sysfs_emit(buf, "\n");
> +
> +	return cpumap_print_to_pagebuf(true, buf, cpumask_of(cpu));
>  }

[Severity: High]
This is a pre-existing issue, but since info->on_cpu can be -1 during
cxl_pmu_offline_cpu(), does this same out-of-bounds issue happen in
cxl_pmu_event_init()?

cxl_pmu_event_init() unconditionally assigns info->on_cpu to event->cpu:

drivers/perf/cxl_pmu.c:cxl_pmu_event_init() {
    ...
    event->cpu =3D info->on_cpu;
    ...
}

If a user calls perf_event_open() concurrently with cxl_pmu_offline_cpu(),
this bypasses the perf core's initial validation of the cpu argument.

The perf core will then use the -1 value:

kernel/events/core.c:find_get_context() {
    ...
    cpuctx =3D per_cpu_ptr(&perf_cpu_context, event->cpu);
    ...
}

Could this lead to an out-of-bounds array read and wild pointer dereference
in the perf core? Should cxl_pmu_event_init() also validate that
info->on_cpu is not -1 before assignment?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728210551.2449=
093-1-dave.jiang@intel.com?part=3D9
