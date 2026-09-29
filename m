Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1598F402436
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790722020; cv=none; b=EipzI6THH/sxpoPa+k/JEximbqsRFu680EUIG3wEaAMGB6ogi9McCWQkhPqiIflb6kmSdSYJzXhfi1klvcgpTKDNbRrVEY1g6I12EHBnUVX4pNm/l4Q8m1AKg19cZchwPaxTG1Lw+N3vBT9k6tGhMkg4CSfN1Jd6q8sCdSKsy3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790722020; c=relaxed/simple;
	bh=ScEvV3+sCczWpA2s81KQkS874xNuSVg+Wnsk5HeoX3w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AD8xavXg2N6VU+ei5tn/w4aIpLKdpiR2a4teLFGkwBhqIFOJR+aFq0fnQope+f3T9cz6eOka1VrsoESd5KVAyjyWzcDszrWjPM2BE0rmt6tFT2rcat2HyMbs/msQr4W+daWj3rYLC1DclFvOkiyLmlkaNP8bCqXD4MJTiX9tYnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gX94Cnou; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gX94Cnou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A15E1F000FF;
	Tue, 29 Sep 2026 22:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790722018;
	bh=exArMXcav+vIirQdLJB417i7DHZmmg8wdbRmKjnuiIU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gX94CnoumbIhjQ0BZQ3oG7muk8jZNOBNoIy/YQ5lT5VET10OFkF2bdNBMA1H0Ug/4
	 24YLR4ARdKm1rBJm8WhW55Cml785Vlb337+Ydjueb1RbFD1eZ3e4MpMsTCIdoiuD+B
	 //p0d1EUvqhpoA68b7VIaqC32kFkpJ7Rkvt5SHwIsFwErnaKUsLFnXkbuh5Pl1OKpB
	 AMH8XobgVsMHzpVrYuKXiaYT7sR71cuN0eFy9DOppZrJChQzMqETzspkrAs4L46Rah
	 AkPPliZxUhzYkqvmlQMZE5fREN9TeeF6ATmbhZpYPe1vZPf7jMJn1Qs0UsoaJCTxmQ
	 KqNQYPW+moBbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/arm-cmn: Allow userspace to select the PMU's CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haris Okanovic" <harisokn@amazon.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929223244.2411400-1-harisokn@amazon.com>
References: <20260929223244.2411400-1-harisokn@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 22:46:58 +0000
Message-Id: <20260929224658.7A15E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf/arm-cmn: PMU context split data race via sysfs cpumask write
--

commit cd1fc8e509238a5fe44eb8583d42c30948f80fe1
Author: Haris Okanovic <harisokn@amazon.com>
Subject: perf/arm-cmn: Allow userspace to select the PMU's CPU

This commit allows userspace to migrate the PMU's CPU by making the 'cpumas=
k'
sysfs attribute writable. It uses the existing arm_cmn_migrate() function to
move the PMU context and interrupts to the newly selected CPU, allowing
administrators to move background work away from latency-sensitive CPUs.

> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index b162de3d9d169..77eed6dbb1bdb 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c

[ ... ]

> @@ -1519,8 +1523,42 @@ static ssize_t arm_cmn_cpumask_show(struct device =
*dev,
>  	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(cmn->cpu))=
);
>  }
> =20
> +static ssize_t arm_cmn_cpumask_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	static DEFINE_MUTEX(cpumask_mutex);
> +
> +	struct arm_cmn *cmn =3D to_cmn(dev_get_drvdata(dev));
> +	unsigned int cpu;
> +	int err;
> +
> +	err =3D kstrtouint(buf, 0, &cpu);
> +	if (err)
> +		return err;
> +
> +	if (cpu >=3D nr_cpu_ids)
> +		return -EINVAL;
> +
> +	/* Serialises multiple writers against each other */
> +	mutex_lock(&cpumask_mutex);
> +	/* Blocks hotplug during write */
> +	cpus_read_lock();
> +
> +	if (!cpu_online(cpu))
> +		err =3D -EINVAL;
> +	else if (cpu !=3D cmn->cpu)
> +		arm_cmn_migrate(cmn, cpu);

[Severity: High]
Is there a race condition here with concurrent perf_event_open() calls?

If a process calls perf_event_open() concurrently, arm_cmn_event_init() rea=
ds
cmn->cpu locklessly:

drivers/perf/arm-cmn.c:arm_cmn_event_init() {
	...
	event->cpu =3D cmn->cpu;
	if (event->cpu < 0)
		return -EINVAL;
	...
}

If this sysfs write changes cmn->cpu and migrates existing PMU contexts
to the new CPU right after arm_cmn_event_init() reads the old CPU,
the new event will be installed on the old CPU.

Since the old CPU remains fully online (unlike a true CPU hotplug event),
this splits the PMU context across multiple CPUs. PMU callbacks like
arm_cmn_event_add() can then execute simultaneously on different CPUs:

drivers/perf/arm-cmn.c:arm_cmn_event_add() {
	...
	while (dtm->pmu_config_low & CMN__PMEVCNT_PAIRED(dtm_idx))
	...
}

Could this lead to concurrent read-modify-writes to shared PMU hardware sta=
te
and array structures without locking?

> +
> +	cpus_read_unlock();
> +	mutex_unlock(&cpumask_mutex);
> +
> +	return err ?: count;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929223244.2411=
400-1-harisokn@amazon.com?part=3D1
