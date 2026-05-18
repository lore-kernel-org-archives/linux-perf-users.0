Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551C12DC767
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 19:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779132401; cv=none; b=O51kvcXWnkPaHeAZGq4vSWI/Bfn+l0dZOU5/X1L8kFFsAXyz+B8ojK7c6HIAM+a1nMMkPijL8bCkvcrOkECrlsnzStSMo+StY926op31S+DfWJeX3TcrGLLM/BA0GKBqvr6QGSa9OVWlHSXBXKBIg6WBG3Rx/Vqj9ZyNZSRb4Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779132401; c=relaxed/simple;
	bh=6PwWVpZ/9cMCffWCpGgDs1wdN+7AhcFgAe42NxgPf6k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SLGqYw0PJcj4Bd5NrbnIBOmmQoDlGOpBYC/sK6lfd/KZfk05NOmv2B1jnyobsesqZGnuSGm1xKfCOHscxaNkNSxATJUqswZ9LHMlsWwkWfcPiFN7GLazH6gserYno9tvFFVLHPl3hYbpWl8rbere2domRk41qDvF4JjtDU8FOfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YS9/0rS8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YS9/0rS8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDFAC2BCB7;
	Mon, 18 May 2026 19:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779132401;
	bh=6PwWVpZ/9cMCffWCpGgDs1wdN+7AhcFgAe42NxgPf6k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=YS9/0rS80q31mgzDk9QSSpY95vBfN+v2Y6259Pt4iKu69mtSrG2pjO55maQCjqrWG
	 /CACCex5V14MBS8tW+c3c14fyKMdddn01OcrvaBNY7Npdeg88ZzONRWPY9VAjUkHV+
	 UQrB57NdYXAp8uQ6C2/E8bdlgxRbYHf4E54xHtUx057hf16AxYf8atrsc+fcTRWBaE
	 x7EEA0iCDlOknwwxWyfvlFyDO/h2mDE8cvImE159a6iE9Xc2Z+pTfMdAz0KL1ZxXrB
	 ufSJcxhixKPAyt4/Q4kf70uhPGL+v+N8JMdgrIs30TTPJOrPE2zSBg5bvJ6J4oP+ys
	 tXz+sQsBWww0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] perf tool_pmu: Make tool PMU events respect
 enable/disable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260518183920.2894502-2-irogers@google.com>
References: <20260518183920.2894502-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 19:26:40 +0000
Message-Id: <20260518192640.BFDFAC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Tool PMU events configured as members of an event group are never =
enabled and will incorrectly report zero.
- [Medium] The high-level `evsel__enable()` and `evsel__disable()` API func=
tions bypass the tool PMU logic, causing `-ENOTTY` failures.
- [Medium] Silent error masking in `evsel__tool_pmu_enable_cpu` can lead to=
 massive time calculation errors.
- [Low] Incorrect parameter ordering in `lseek` call within `tool_pmu__read=
_stat()`.
--

commit 859669b871dfb5dac6379e7cd2030d7d210d68ac
Author: Ian Rogers <irogers@google.com>

perf tool_pmu: Make tool PMU events respect enable/disable

Tool PMU events (duration_time, user_time, system_time) currently
count from when the event is opened to when it is read. This causes
issues with features like the delay option (-D) or control fd, where
events are opened but should not start counting immediately.

Make these events behave more like regular counters by implementing
proper enable and disable support.

Link: https://lore.kernel.org/linux-perf-users/20260517093650.2540920-1-nig=
ro.fra@gmail.com/

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 2ee87fd84d3ea..3646156500f6e 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
[ ... ]
> @@ -1795,6 +1798,8 @@ int evsel__append_addr_filter(struct evsel *evsel, =
const char *filter)
>  /* Caller has to clear disabled after going through all CPUs. */
>  int evsel__enable_cpu(struct evsel *evsel, int cpu_map_idx)
>  {
> +	if (evsel__is_tool(evsel))
> +		return evsel__tool_pmu_enable_cpu(evsel, cpu_map_idx);
>  	return perf_evsel__enable_cpu(&evsel->core, cpu_map_idx);
>  }
> =20
> @@ -1810,6 +1815,8 @@ int evsel__enable(struct evsel *evsel)

Does evsel__enable() also need to be updated to handle tool PMUs?

The per-CPU functions are updated here, but the batch functions
evsel__enable() and evsel__disable() directly call perf_evsel__enable().

Since perf_evsel__enable() executes an ioctl(fd, PERF_EVENT_IOC_ENABLE)
and tool events use plain text files like /proc/stat, won't this result in
an -ENOTTY failure and leave the batch-enabled events disabled?

>  /* Caller has to set disabled after going through all CPUs. */
>  int evsel__disable_cpu(struct evsel *evsel, int cpu_map_idx)
>  {
> +	if (evsel__is_tool(evsel))
> +		return evsel__tool_pmu_disable_cpu(evsel, cpu_map_idx);
>  	return perf_evsel__disable_cpu(&evsel->core, cpu_map_idx);
>  }
[ ... ]
> diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
> index 6a9df3dc0e076..cfefd97cb95bc 100644
> --- a/tools/perf/util/tool_pmu.c
> +++ b/tools/perf/util/tool_pmu.c
[ ... ]
> +static int tool_pmu__read_stat(struct evsel *evsel, int cpu_map_idx, int=
 thread, __u64 *val)
> +{
> +	enum tool_pmu_event ev =3D evsel__tool_event(evsel);
> +	bool system =3D ev =3D=3D TOOL_PMU__EVENT_SYSTEM_TIME;
> +	int fd =3D FD(evsel, cpu_map_idx, thread);
> +	int err =3D 0;
> +
> +	if (fd < 0) {
> +		*val =3D 0;
> +		return 0;
> +	}
> +
> +	lseek(fd, SEEK_SET, 0);

This isn't a bug, but are the offset and whence arguments to lseek swapped
here?=20

The POSIX prototype expects lseek(fd, offset, whence). This happens to
work because SEEK_SET is 0, but it misuses the API.

> +	if (evsel->pid_stat) {
> +		if (cpu_map_idx =3D=3D 0)
> +			err =3D read_pid_stat_field(fd, system ? 15 : 14, val);
[ ... ]
> @@ -467,10 +512,79 @@ static void perf_counts__update(struct perf_counts_=
values *count,
>  		count->lost =3D 0;
>  	}
>  }
> +int evsel__tool_pmu_enable_cpu(struct evsel *evsel, int cpu_map_idx)
> +{

Will tool PMU events configured as members of an event group be successfully
enabled?

In the core event iteration logic like __evlist__enable(), the code
explicitly skips processing any event that is not a group leader. For kernel
PMU events, the kernel automatically enables the entire group when the lead=
er
is enabled.

Since the kernel has no concept of synthetic userspace tool PMU events, if a
tool PMU event is grouped as a non-leader (e.g.=20
perf stat -e '{cycles,duration_time}'), doesn't userspace skip it, leaving
evsel__tool_pmu_enable_cpu() uncalled and the event erroneously reporting 0?

> +	enum tool_pmu_event ev =3D evsel__tool_event(evsel);
> +	int thread, nthreads;
> +
> +	if (!evsel->disabled)
> +		return 0;
> +
> +	if (ev =3D=3D TOOL_PMU__EVENT_DURATION_TIME) {
> +		if (cpu_map_idx =3D=3D 0) {
> +			evsel->duration_time.start_time =3D rdclock();
> +			evsel->disabled =3D false;
> +		}
> +		return 0;
> +	}
> +
> +	if (ev =3D=3D TOOL_PMU__EVENT_USER_TIME || ev =3D=3D TOOL_PMU__EVENT_SY=
STEM_TIME) {
> +		nthreads =3D xyarray__max_y(evsel->process_time.start_times);
> +		for (thread =3D 0; thread < nthreads; thread++) {
> +			__u64 *start_time =3D xyarray__entry(evsel->process_time.start_times,
> +							   cpu_map_idx, thread);
> +			__u64 val;
> +			int err;
> +
> +			err =3D tool_pmu__read_stat(evsel, cpu_map_idx, thread, &val);
> +			if (!err)
> +				*start_time =3D val;

What happens if tool_pmu__read_stat() fails here?

If reading /proc/<pid>/stat fails because the monitored process just exited,
the error is ignored and *start_time remains 0.

If a subsequent read in evsel__tool_pmu_read() succeeds, could this cause t=
he
delta calculation to subtract the stale 0 start time from the current system
time, incorrectly accumulating massive values and breaking the counter?

> +		}
> +	}
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518183920.2894=
502-1-irogers@google.com?part=3D1
