Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794598855;
	b=dBAE62EDmLXoDV0MgcUNxgvwJ0Pun9pPyBUpLwquBdOOkQV9sW9nVmSQX+pIFfRsboIk
	 SwHVh7ySsvevWDgjA7OvbPmefTcnDTWo1d4XTTbNGsmF/FIxinGOa7E+5TeNu0dH/FSkq
	 12D8MB8xg+7L+jzoxHfHpEo2qRYTthFo+E8Lli5WPTIq8D2uOxhiBX/TSxGgvJHYNXCDC
	 quiywsp/Kew3WbudfWDEdz8dAb2W7IThG10n34LBXJPD5kIVXLOCJVXxXKL+pQ+8xUEHz
	 af1xj5LPkB42khAAlYdhRF0AgaiGooiJGjrbyaSZGkxlXVVuGTRjGUT++zMvjq5iomA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598855;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AQwi/effThSliBhF6fsw5Ok9qQ4ujy7ppAm36/REpa4=;
	b=UUHqwmcldJWehJvx4WO226CmcBQldIszs6NFBNDZHmmKXOMOnSdqmIiqYGnV10i7maUa
	 85bTxJr3ZJB5AU/LDRT9gh7h0pf2SuBabHrIRnuxOya4WsHr6TGt8cPKbRDn7BGHTZqlm
	 ZOeJICVGgsZ0aOjqR16NOuFA7MFi2WNhMcwqLHl18qbZWNPWg/5cGOkQxbKxQt0CLB78r
	 WrpKtWn4nzH89o5CF+rxpPZMFNBB+SQ5AgY7vFidr7ajgxNdxmrQQnR3Dn1PPmdXe8vAA
	 KMmxhixbqwl5gGcQ/Bc71+T5y4BKD53b25N56aMcdpd4gxbziuVKu8OsUGnPoQHS/dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hXUuZR13;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C5E606A338
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hXUuZR13
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C231F000C4;
	Fri, 13 Nov 2026 19:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794598855;
	bh=AQwi/effThSliBhF6fsw5Ok9qQ4ujy7ppAm36/REpa4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hXUuZR13ADB22lXSBgLtUjiG0qgBItqIOjTuRkIQ7i6vXtxRGWZSLNyZOFRvVGjWd
	 dcCemth0RcCA46Di97Og+hb5xFtBlGlVL4k54+mK+eHKtL+OhDLWx2FpbmLKIjBkvM
	 lMywE9psgue6XAojI2GQDmrqKBuYO1UnCyr+HvwTyMTo5iHEdU6Gn6wSsHcw4ukGRz
	 +zOeZhTSBizGffZQ+42IqnuXFzZHO70hJcldfQxJnoaHkFBWhZy4jhrOz4/XTkcdbJ
	 LKE24AhGf0N1VwK68Qm1cM7kIDLxAhZ1Uv71NtSdUYp+dYFbjXJNgGRj2lX3snVMs3
	 vjZchVWTPs/OQ==
Message-ID: <sashiko-outbox-213562@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] perf pmu: Implement tool-provided NVMe PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-nvme@lists.infradead.org
In-Reply-To: <20261113191234.2509964-3-irogers@google.com>
References: <20261113191234.2509964-1-irogers@google.com>
 <20261113191234.2509964-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:40:54 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] perf pmu: missing errno and err_thread handling in
  evsel__nvme_pmu_open()
- [Medium] perf evsel: PERF_EVENT_IOC_ENABLE/DISABLE ioctls issued on
  NVMe device fds
--

commit 1cca3c688611b8ef7867f412d383cb3ae7a315e1
Author: Ian Rogers <irogers@google.com>

perf pmu: Implement tool-provided NVMe PMU

This commit adds a tool-provided PMU for NVMe controllers using libnvme,
exposing metrics from standard NVMe log pages under nvme_<ctrl> PMUs.

> diff --git a/tools/perf/util/nvme_pmu.c b/tools/perf/util/nvme_pmu.c
> new file mode 100644
> index 0000000000000..3ee967505dec6
> --- /dev/null
> +++ b/tools/perf/util/nvme_pmu.c

[ ... ]

> +static int nvme_pmu__read_val(int fd, uint64_t config, uint64_t *val)
> +{

[ ... ]

> +	if (ret < 0)
> +		return -errno ?: -EIO;
> +	if (ret > 0)
> +		return -EOPNOTSUPP;

[ ... ]

> +int evsel__nvme_pmu_open(struct evsel *evsel,
> +			 struct perf_thread_map *threads,
> +			 int start_cpu_map_idx, int end_cpu_map_idx)
> +{
> +	struct nvme_pmu *nvm =3D container_of(evsel->pmu, struct nvme_pmu, pmu);
> +	int idx =3D start_cpu_map_idx, thread =3D 0, nthreads, err =3D 0;
> +	int max_cpus, max_threads;
> +	char path[PATH_MAX];
> +
> +	if (evsel->core.attr.sample_period || !evsel->core.fd)
> +		return -EINVAL;
> +
> +	snprintf(path, sizeof(path), "/dev/%s", nvm->dev_name);

[ ... ]

> +	for (idx =3D start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
> +		for (thread =3D 0; thread < nthreads; thread++) {
> +			uint64_t *initial_val;
> +			int fd =3D open(path, O_RDONLY | O_CLOEXEC);
> +
> +			FD(evsel, idx, thread) =3D fd;

[Severity: Medium]
Does storing a /dev/nvmeX file descriptor in evsel->core.fd cause
evsel__enable_cpu(), evsel__enable(), evsel__disable_cpu() and
evsel__disable() to fail with -ENOTTY?

Those functions only special-case evsel__is_tool(evsel) and otherwise call
 into libperf:

tools/perf/util/evsel.c:evsel__enable_cpu() {
	if (evsel__is_tool(evsel))
		err =3D evsel__tool_pmu_enable_cpu(evsel, cpu_map_idx);
	else
		err =3D perf_evsel__enable_cpu(&evsel->core, cpu_map_idx);

	if (!err && evsel__is_group_leader(evsel)) {
    ...
}

perf_evsel__enable_cpu() and its enable/disable counterparts issue
PERF_EVENT_IOC_ENABLE and PERF_EVENT_IOC_DISABLE on every fd in
evsel->core.fd, which the NVMe character device rejects with -ENOTTY.
That leaves evsel->disabled stale and aborts the group loop before
userspace members such as duration_time, user_time or system_time are
enabled or disabled in mixed groups.

> +			if (fd < 0) {
> +				err =3D -errno;
> +				goto out_close;
> +			}
> +			initial_val =3D xyarray__entry(evsel->nvme.initial_values, idx, threa=
d);
> +			err =3D nvme_pmu__read_val(fd, evsel->core.attr.config, initial_val);
> +			if (err) {
> +				close(fd);
> +				FD(evsel, idx, thread) =3D -1;
> +				goto out_close;
> +			}
> +		}
> +	}
> +	return 0;
> +out_close:
> +	if (err)
> +		threads->err_thread =3D thread;
> +
> +	do {
> +		while (--thread >=3D 0) {
> +			if (FD(evsel, idx, thread) >=3D 0)
> +				close(FD(evsel, idx, thread));
> +			FD(evsel, idx, thread) =3D -1;
> +		}
> +		thread =3D nthreads;
> +	} while (--idx >=3D start_cpu_map_idx);
> +	return err;
> +}

[Severity: Medium]
Does evsel__nvme_pmu_open() leave errno unset or clobbered on failure while
also setting threads->err_thread for a controller-wide device?

Callers of evsel__open() and evsel__open_per_cpu_and_thread() such as
__run_perf_stat(), record__open() and __cmd_top() read errno after a
negative return.  When a controller does not support an optional log page
(such as FDP, ZNS or Endurance Group), libnvme returns a positive NVMe
status code without setting errno, and nvme_pmu__read_val() returns
-EOPNOTSUPP with errno still 0 (or clobbered by close()).  The -EINVAL and
!HAVE_LIBNVME_SUPPORT error returns likewise do not set errno.

In addition, setting threads->err_thread =3D thread causes
stat_handle_error() in perf stat --per-thread mode to treat a controller
open or log error as a dead thread, removing every thread from the thread
map in a retry loop until nthreads reaches 0 and evsel__nvme_pmu_open()
returns 0 with no descriptors opened.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113191234.2509=
964-1-irogers@google.com?part=3D2
