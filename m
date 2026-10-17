Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B22391E51
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 19:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792264697; cv=none; b=JNtSSRQeNeroY6nXgUVGYoRQAEb5kp5emsDwb28y0N+REwu8M5bbeA/92ACXNrnUUSKYK7Lftv0gCh2wjHQrpKuz0uovtNIEmmqVMdHDK9dstoI4fxlO3vLYkDhK8Q8y5igOCWhBzWrOmTkWvJVAh5pk7NoxBinkbFUljH4C/T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792264697; c=relaxed/simple;
	bh=EZSz/0y9hrDzc/K8DQFl2ftERlg/2x+wB773U9Yw6Rs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=jLHa/PY58aorJhi181L8+LT15BaSOPS8sauzc9A2tAHrnUxc8XoljV8AZMJtA+Ptn9/7Qutp3mf1HwrKPjK78pfWXGkC0Lgp6yJY2FZxjO9uoIxrzOdmX63Onf+5v+APl5uzPr9pHr46oOxmSGXmb1tjdVqPSYaQKcKF2+/JuN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2YTHJDV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2YTHJDV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA05B1F000C4;
	Sat, 17 Oct 2026 19:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792264696;
	bh=1gSSiCN2KZAcgZEwx0zhEQXXLvbTYJVmZ4gB5NV3ir4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L2YTHJDV5tO2qW/vK3xODlguND5Pzo4TkiEYiXGAwxpXGRVxn8smaAS0byeanWIFW
	 CY5dvSnrADcyMBdsUYl+TeRvSF5ADBYdBzhFW8F3D+5ojOiZewIJCw3Dn/dYr/IdnF
	 atU2daKeiLaoIKxOH2jmfFgHLTqHQ4zdGaOYVYGFRm47ZK0lsJxruLLrQCMDJJhygf
	 4CtUf3+yw4WsdMtHQtLnzNS1vzUt/y9p041auL2jRHeJUGNzGL56jpbY6pDMX/sqly
	 yjY0qTebwMbuPSwCqJROoRDesVeTgfGE5Cc7UK1Lbd5S+hDgizUljjHDMVob0tvrCC
	 KhFBByEnlWCaQ==
Message-ID: <sashiko-outbox-175776@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 5/9] perf pmu: Add perf_pmu__probe() for live
 capability probing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261017185442.2137623-6-irogers@google.com>
References: <20261016213258.945737-1-irogers@google.com>
 <20261017185442.2137623-1-irogers@google.com>
 <20261017185442.2137623-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 19:18:15 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf pmu: select_probe_cpu() ignores task CPU affinity mask
--

commit a706bded05059ea05d5c1e851935d2f599c67616
Author: Ian Rogers <irogers@google.com>

perf pmu: Add perf_pmu__probe() for live capability probing

This commit adds struct perf_pmu::probed and perf_pmu__probe() to actively
probe live PMU capabilities via perf_event_open(), covering counting and
sampling modes, precise_ip levels, sample formats, privilege exclusion
modifiers, execution features, and event group size limits.

> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index cd8211f872911..83c8d6f392ba9 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c

[ ... ]

> @@ -2832,9 +2847,1219 @@ void perf_pmu__delete(struct perf_pmu *pmu)

[ ... ]

> +static int select_probe_cpu(const struct perf_pmu *pmu)
> +{
> +	struct perf_cpu_map *online =3D perf_cpu_map__new_online_cpus();
> +	int cpu =3D 0;
> +
> +	if (pmu->cpus && !perf_cpu_map__is_empty(pmu->cpus)) {
> +		int nr =3D perf_cpu_map__nr(pmu->cpus);
> +
> +		cpu =3D perf_cpu_map__cpu(pmu->cpus, 0).cpu;
> +		if (online) {
> +			for (int i =3D 0; i < nr; i++) {
> +				struct perf_cpu c =3D perf_cpu_map__cpu(pmu->cpus, i);
> +
> +				if (perf_cpu_map__has(online, c)) {
> +					cpu =3D c.cpu;
> +					break;
> +				}
> +			}
> +		}
> +	} else if (online && !perf_cpu_map__is_empty(online)) {
> +		cpu =3D perf_cpu_map__cpu(online, 0).cpu;
> +	}
> +
> +	perf_cpu_map__put(online);
> +	return cpu >=3D 0 ? cpu : 0;
> +}

[ ... ]

> +static void probe_group_limits(const struct perf_event_attr *attrs, size=
_t nr_attrs,
> +			       pid_t pid, int cpu, unsigned long flags,
> +			       int *max_open, bool *open_capped,
> +			       int *max_active, bool *active_capped)
> +{
> +	struct perf_event_attr leader_attr;
> +	int leader_fd;
> +	int fds[MAX_PROBE_GROUP_SIZE];
> +	int nr_followers =3D 0;
> +	bool has_time_read =3D true;
> +	bool active_ok =3D true;
> +	enum rlimit_action set_rlimit =3D NO_CHANGE;
> +	cpu_set_t saved_affinity, probe_affinity;
> +	bool affinity_changed =3D false;
> +
> +	*max_open =3D 0;
> +	*open_capped =3D false;
> +	*max_active =3D 0;
> +	*active_capped =3D false;
> +
> +	if (!attrs || nr_attrs =3D=3D 0)
> +		return;
> +
> +	if (pid =3D=3D 0 && cpu >=3D 0 && cpu < CPU_SETSIZE) {
> +		CPU_ZERO(&saved_affinity);
> +		if (sched_getaffinity(0, sizeof(saved_affinity), &saved_affinity) =3D=
=3D 0) {
> +			CPU_ZERO(&probe_affinity);
> +			CPU_SET(cpu, &probe_affinity);
> +			if (sched_setaffinity(0, sizeof(probe_affinity), &probe_affinity) =3D=
=3D 0)
> +				affinity_changed =3D true;
> +		}
> +	}

[Severity: Medium]
What happens in probe_group_limits() when perf runs inside a cgroup cpuset
(such as a container or a systemd unit with AllowedCPUs=3D) that excludes t=
he
first online CPU of a PMU?

In select_probe_cpu(), the probe CPU is chosen as the first online CPU in
pmu->cpus (or online) without checking whether that CPU is in the calling
thread's allowed affinity mask via sched_getaffinity().

For non-uncore PMUs, try_open_attr_variants() opens events with pid =3D 0 a=
nd
cpu =3D pmu_cpu, which sys_perf_event_open() allows even when pmu_cpu is
outside the task's cpuset. However, when probe_group_limits() then tries to
pin the calling thread to cpu with sched_setaffinity(), it fails with -EINV=
AL.

When check_group_active() subsequently enables the (pid =3D 0, cpu =3D pmu_=
cpu)
group via PERF_EVENT_IOC_ENABLE and spins in userspace on a different CPU,
the kernel sets the event to PERF_EVENT_STATE_INACTIVE (incrementing
TOTAL_TIME_ENABLED), while event_filter_match() prevents scheduling it onto
the PMU because event->cpu !=3D smp_processor_id(). As a result,
TOTAL_TIME_RUNNING stays 0 (delta_run !=3D delta_ena), check_group_active()
returns false even for a single event, and max_active_group_size and
max_active_gp_group_size are reported as 0.

Should select_probe_cpu() prefer an online CPU that is also present in the
calling thread's sched_getaffinity() mask when available?

[ ... ]

> +	leader_attr =3D attrs[0];
> +	leader_attr.disabled =3D 1;
> +	leader_attr.read_format =3D PERF_FORMAT_TOTAL_TIME_ENABLED | PERF_FORMA=
T_TOTAL_TIME_RUNNING;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017185442.2137=
623-1-irogers@google.com?part=3D5
