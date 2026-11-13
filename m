Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794613878;
	b=4KL+hDe1F7IKvL1ZebglKJFSXwzjuBe+ESCcXGcWVFMhNnmFxkL8NIQVWZU4E3Yd7uSz
	 QAclndQMo/VTUREml6X8R/PHx3nqT7vTAQTiJQbLq5UQLQGxhHntY6spnRK0c+62LGX2s
	 PT14bruEitaufnSR4/bbgFdQOxAmbRe/SBf7Z4dHMNzycpjUYVbx66sUN63RY+GgLX41V
	 68pHKSLpyzFBqHAoL0bQMTa/9HINKpQNhmfq/YKJvL8B2jKs8b2a8O0Iq93mthLztDU5j
	 +KDhMirsULxv1ONv2wVZAIeFYDITfpO1IXFCMCqCrKOPJyhKgIwsZSU7682h1UyZXvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794613878;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JZE82SorX5wKf9ST70NnHAM+Xy7XtcjUGny7SrII8Q4=;
	b=vN2l3yTCZHJX/dwbA26EiKAwlntR8UDD27vPO8XVsDzMoZxUHE+eW9NXvmaCr7+0smzG
	 pXGMzag0UhSrpXa/eia9M8a/nUxoxEmDEwshzFRqOs3dmqagq9YfeTQmYcwccBS1qmGBq
	 fXOD8IrXJ9Mey4VIscBTf5u4XLd6ZGH8yCQlyal1HCo2IgSOhKC3b9RCVcUpKaj/a0OYH
	 rcEzIOYG9/RlgKkBgXwu+w9zdpKKL0+IT0MblBVS2bL6kXjCFq7Fj9JTVj5rBSmOmqzK0
	 iIqbV5CSmlNC9wuLJKEk6kpksy71Nkh6BlkAlYxN2kQTogZrXfVLWD9iMCj2D42/hPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MJlPjD0l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE73606A323
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 23:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MJlPjD0l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1011F000C4;
	Fri, 13 Nov 2026 23:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794613878;
	bh=JZE82SorX5wKf9ST70NnHAM+Xy7XtcjUGny7SrII8Q4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=MJlPjD0l5vsNZyyKmIvzMlbXTIFLtgT0J6cO3nwpMvW86Jr65/re2siOQKaLKnkVE
	 20o6YGOh94csAPdojYcZWQ1g/UWE8OV4m4QRS6u3MiBtabN3Hgh9dMhXZN2V+u82+V
	 GpMbfZIulm1wn7za5+rm45XIfxZXKvXezy7vxHPQLToGhgtOMmMy+p7PfxGEp+7mfY
	 XA2VbrE81bis/JKoR4xZeq4ABdh5X1JB+kVY5SE/uulSFWMNjNNit1mQ97uK9/c8Lt
	 vAvrpou57BJSvBU/o7vW71V6peofWnU1lylb85cw1PCV2pN6+5o5g7Q13givrNxmbz
	 dSySnVIweLjgg==
Message-ID: <sashiko-outbox-213878@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] perf tool_pmu: Add schedstat events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261113233739.3626499-4-irogers@google.com>
References: <20261113233739.3626499-1-irogers@google.com>
 <20261113233739.3626499-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 23:51:17 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add per-CPU tool PMU events backed by /proc/schedstat runqueue
> statistics:
> - schedstat_yield: Calls to sched_yield().
> - schedstat_schedule: Calls to schedule().
> - schedstat_schedule_idle: Calls to schedule() leaving the CPU idle.
> - schedstat_wake: Calls to try_to_wake_up().
> - schedstat_wake_local: Calls to try_to_wake_up() for the local CPU.
> - schedstat_runtime: Task runtime on this CPU in nanoseconds.
> - schedstat_wait: Task runqueue wait time on this CPU in nanoseconds.
> - schedstat_timeslices: Number of timeslices run on this CPU.
>=20
> Because /proc/schedstat reports per-CPU runqueue counters, reject
> per-process and cgroup modes, exclude schedstat events from
> perf_pmu__reads_only_on_cpu_idx0(), and update should_skip_zero_counter()
> so zero-valued per-CPU tool events are not suppressed on CPUs > 0. Track
> [ ... ]
>   CPU1                3,535      tool/schedstat_timeslices/
>=20
>          0.101808548 seconds time elapsed
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113233739.3626=
499-1-irogers@google.com?part=3D3

