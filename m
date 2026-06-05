Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950452E975E
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780663434; cv=none; b=LMBi4KOWenf7o3ue5aKgVppBEj+KX/LzmWMvlx2/xZUxqy+28CmXJLKNcNQTUTYdkXHqo0WmUWNJgJShL4lkUxYzbS16FLD+PezbhbDQ8W+yRYBrNc3omsMxN+HcuACrzdmH2M0KIbvmPrpLv7NQCZQtqjW1g5M5P3dF49jAWT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780663434; c=relaxed/simple;
	bh=HgX19Jzh/D4z2RxC0Yw3Kx+LdfLGFPIDo0qRiyZdn2E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mti8gFmFUBdKKUU+AtyZEDmcSzVrgza8H4oAAWGyjFftC7r2NKfpwYlCtkkVaGKCjApdlew5M9u1ofVnuB/fP5BLzSDdOQJAMn1ctbg6teK0r1yBlq8rbQO5hT19tCLqBbNw4Dtr1Fhp8SuvV57ltx9w09iGiD9sbnbNCZXVPvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBMTogB1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBMTogB1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9591F00893;
	Fri,  5 Jun 2026 12:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780663433;
	bh=+94h9uqwBa4o1SVHypE8p9uQQeLlp3VhIbX5rJ1YbzQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fBMTogB12Qlmt9awwJc6ETECcLKImaB0A1kJRv0ZoxPZ4D1WcMOWkn8stfuw766gA
	 rhm0zcSbFN5ogOLENd3lRn0TcpjXlku1tNXXQQIxA4D9aCW+YoyGUA6P6i5iFYfz35
	 NY9bC5epNeUwDeNgjCBDEFU9VIvOSGq6d3EOc8anAjfMNm47Y8ehtA0UOwBpi5JQQA
	 bQpOOZ+z47ftLwQEKsaHv6/+zX5g5ZZSzUURaSks6xOoSMFYJM/4Kyd0GsxMvQO08V
	 qGy/2yV5wllQeHReCyoM/A9e9Idh+wObiBELFsnNg99U07u2JPq1Z5DOocM4UFlek9
	 2jut5HrKdhycA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] perf sched: Cap max_cpu at MAX_CPUS in timehist
 sample processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605121515.1725549-5-acme@kernel.org>
References: <20260605121515.1725549-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 12:43:52 +0000
Message-Id: <20260605124353.1B9591F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] perf_sched__timehist omits the .feature tool callback, breaking pe=
rf_env population in pipe mode.
- [High] Leaked callchain nodes and violation of reference counting rules d=
uring idle threads teardown.
--

commit fa7c274dda31324797cc9c2df04b0e7a2f0a40d2
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf sched: Cap max_cpu at MAX_CPUS in timehist sample processing

This commit adds bounds checking to sched->max_cpu updates from the
sample CPU. It caps env->nr_cpus_online initialization of max_cpu to
MAX_CPUS to prevent out-of-bounds array accesses on large systems or
recordings with high CPU IDs.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 7bd61028327b3..87a1f4cf8760e 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c

[ ... ]

> @@ -3385,8 +3387,8 @@ static int perf_sched__timehist(struct perf_sched *=
sched)
>  		perf_session__set_tracepoints_handlers(session, migrate_handlers))
>  		goto out;
> =20
> -	/* pre-allocate struct for per-CPU idle stats */
> -	sched->max_cpu.cpu =3D env->nr_cpus_online;
> +	/* pre-allocate struct for per-CPU idle stats; cap to array bounds */
> +	sched->max_cpu.cpu =3D min(env->nr_cpus_online, MAX_CPUS);

[Severity: High]
This is a pre-existing issue, but does perf_sched__timehist() correctly
populate perf_env in pipe mode?

Looking at perf_sched__timehist() in tools/perf/builtin-sched.c, the tool
callbacks are initialized without a .feature callback:

    sched->tool.sample       =3D perf_timehist__process_sample;
    sched->tool.mmap         =3D perf_event__process_mmap;
    ...
    sched->tool.build_id     =3D perf_event__process_build_id;

Without registering perf_event__process_feature, piped perf.data streams
might silently drop non-seekable PERF_RECORD_HEADER_FEATURE events.

Does this leave perf_env uninitialized and break environment metadata looku=
ps
like the env->nr_cpus_online field accessed here?

[Severity: High]
This is another pre-existing issue, but is there a reference counting leak
during teardown in free_idle_threads()?

When cleaning up the idle threads array created below by init_idle_threads(=
),
the cleanup code uses the internal destructor instead of the lifecycle help=
er:

    free_idle_threads() {
        ...
        thread__delete(idle);
    }

Since reference handles allocated via thread__new() must be strictly paired
with thread__put(), does calling thread__delete() directly bypass the
reference wrapper lifecycle and leak the pointer handle, triggering
REFCNT_CHECKING traps?=20

Also, does destroying the thread without proper cleanup leak the dynamically
allocated nodes inside itr->callchain?

>  	if (sched->max_cpu.cpu =3D=3D 0)
>  		sched->max_cpu.cpu =3D 4;
>  	if (init_idle_threads(sched->max_cpu.cpu))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605121515.1725=
549-1-acme@kernel.org?part=3D4
