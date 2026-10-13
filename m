Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F1653C3BB
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 19:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791918504; cv=none; b=ZlD/pxdvH+8keSql5n6oz++/NYH+D05fInch3NHh9O+NgvlBBT/+qPanx4fiGzxAiLzWrVUUBPKUY6Mq0YlD2tZFhwmFckKZ5PsbT+5uti58/xmY+/QlDkhT7hQsLDtpw/TEVZbmCEfR9wgNMrA9GCy3mQSBNS6Nq+gneZYgPiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791918504; c=relaxed/simple;
	bh=BbBycKbOc+Vj00IVZATKzROXRv7v31J77/x9ZDk6/hs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QusFkcgeNC3wkIVBSmYps1yTl19fnR0Wetf4++S8HqevG4MBVpdURp08JsMJ+A6oeqVwk+xL/JtL+J1qtx5eOzSmHTz+F/Tgt9j5EXf43ZxYZ5JzEGHbC8sd6W/m57kVvwN/rL6J8fGAGQSRXkgl0pzce/RFUtiyjuJDvzZ/VeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e06xwkvl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e06xwkvl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC001F000FF;
	Tue, 13 Oct 2026 19:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791918502;
	bh=9Veuk/PbeN6W1SvQRGYdWqHl4EM2G3ze0SIM2rbtPj0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e06xwkvlym/pWF1gvfaa9MH7VJv53q0TgAjf+1FGoi2cL/MWCcm6xCLGmjCX6HPjt
	 k3LpdScnZIJtrbZfA/FnzF65EPbqZiEpgFUWLeNBrNSluOVlgv+0M48+ljJuEcwFjC
	 ati81XnBpb54JbEGykEQ8CK/+FxA4+5gQVwpH8K+d9HsA88+QQUUrZeHuRKIHHv32M
	 6CyA37DPaSxpxDlqHI6H4vlZAMwdHZCF4YWi/cMoFM7zkUwd2vPpPcz/eE61aB15+B
	 UcFEuMQ5kzlqnWj9hjfYUkY7Zj+otgZyXWTEf+HMRaMcQhUmOFuA6ntCriAUwdAU/6
	 o9MYZuJnkc/nA==
Message-ID: <sashiko-outbox-170380@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] perf/core: Allow userspace to select a device PMU's
 CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haris Okanovic" <harisokn@amazon.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013185603.1347265-4-harisokn@amazon.com>
References: <20261013185603.1347265-1-harisokn@amazon.com>
 <20261013185603.1347265-4-harisokn@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 19:08:21 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf/core: AB-BA deadlock between pmus_lock and sysfs active refer=
ence
--

commit ad9a1746e052ae447d4db3655e5a566ce9de63d5
Author: Haris Okanovic <harisokn@amazon.com>

perf/core: Allow userspace to select a device PMU's CPU

Allow userspace to select the CPU a device PMU is counted on by making the
'cpumask' sysfs attribute writable. This enables rebinding PMU devices
outside of hotplug events by writing an arbitrary CPU set.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c

[ ... ]

> +/*
> + * Move a device PMU to one of the CPUs written here. The PMU gets the f=
inal
> + * say: the write fails if it cannot be counted on any of them.
> + */
> +static ssize_t cpumask_store(struct device *dev, struct device_attribute=
 *attr,
> +			     const char *buf, size_t count)
> +{
> +	struct pmu *pmu =3D dev_get_drvdata(dev);
> +	cpumask_var_t requested;
> +	ssize_t ret;
> +
> +	if (pmu->scope !=3D PERF_PMU_SCOPE_DEVICE)
> +		return -EOPNOTSUPP;
> +
> +	if (!zalloc_cpumask_var(&requested, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	ret =3D cpulist_parse(buf, requested);
> +	if (ret)
> +		goto out;
> +
> +	mutex_lock(&pmus_lock);
> +	ret =3D perf_pmu_set_cpu(pmu, requested);
> +	mutex_unlock(&pmus_lock);
> +
> +	if (!ret)
> +		ret =3D count;
> +out:
> +	free_cpumask_var(requested);
> +
> +	return ret;
> +}
> +
> +static DEVICE_ATTR_RW(cpumask);

[Severity: High]
Could this result in an AB-BA deadlock between pmus_lock and the sysfs acti=
ve
reference?

Since cpumask_store() is called from a sysfs store operation, it implicitly
holds a kernfs active reference while waiting for pmus_lock.

However, perf_pmu_register() holds pmus_lock while calling pmu_dev_alloc():

kernel/events/core.c:perf_pmu_register() {
    ...
    guard(mutex)(&pmus_lock);
    ...
    if (pmu_bus_running && !pmu->dev) {
        int ret =3D pmu_dev_alloc(pmu);
        if (ret)
            return ret;
    }
    ...
}

Inside pmu_dev_alloc(), if sysfs_update_groups() fails after device_add() h=
as
exposed the sysfs attributes, the error path calls device_del():

kernel/events/core.c:pmu_dev_alloc() {
    ...
    ret =3D device_add(pmu->dev);
    if (ret)
        goto free_dev;

    if (pmu->attr_update) {
        ret =3D sysfs_update_groups(&pmu->dev->kobj, pmu->attr_update);
        if (ret)
            goto del_dev;
    }
    ...
del_dev:
    device_del(pmu->dev);
    ...
}

Because device_del() waits for all active sysfs references to drain, if a
concurrent userspace write is executing cpumask_store() and blocking on
pmus_lock, would device_del() wait indefinitely for the active reference to=
 be
released, resulting in an AB-BA deadlock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013185603.1347=
265-1-harisokn@amazon.com?part=3D3
