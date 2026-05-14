Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09D71F131A;
	Thu, 14 May 2026 05:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778735203; cv=none; b=IJ9RuPCPi4njbvMLxIs8lu4t2IYhVY8AaX9RYyJWfemRUS4P8uGa0Sd4hwmKICNED5YXmjaHZiDUdq7VimfIk3RxrmGOruMsyHZgZj6rrCU8jvZxeciiDrYQOtY+vCRXCQ+snZQK7+jLPGEDXeCWU9yz0hk68z5XVSel3xLt/SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778735203; c=relaxed/simple;
	bh=nbfoyL6310jyRp82OIgjTuMmgefMV5Yo78EH6KuGkrs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kF4SfO8kbkJUNzihDK6zE8isFht0y2KWtFAnAS3fZF8ggpt0VFHwINhed7jJMKGCUFWKL+KDvy2TsSXITVkZM4luPA97BoSet65aDla6wP8Px0IZAJf8fYu4jby0VCLYmu7qKSRzG106Y4z8Y+mFZnUcm5899xMH0vTLyfSZEPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNKM/g2Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNKM/g2Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91265C2BCB7;
	Thu, 14 May 2026 05:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778735202;
	bh=nbfoyL6310jyRp82OIgjTuMmgefMV5Yo78EH6KuGkrs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=QNKM/g2Y12myS8hTpE2rWsXekU0vxrGVQpADRPFMQo469+5bEEu6NO0pZWs7hAPTW
	 FVZpPPXjlai000ac3wNGvTvPsKsK9Uo4OCtxcjek8L9rBnDApnEtOaQuNBV+d7b/Mp
	 Ct2Nwndq87Gwdxp3qmHJlu+bLb6qHfQHpgF33Vid0f3e8CVV5ZQFGSyQtRdpkC5Q8/
	 /IocgZVowzthJdel+EtM9GEcawpZNxqWzHN4dSrQtbY6iJax64z/RWFo2JYP1tltsB
	 tyji1iL0D7WXus2OuDdHaE/8pgl6PHWMGQOaDjk+UCU1ssIDm6GY3mC53SdNDB4gEJ
	 1CDRHsXf9eC3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/18] perf pmu-events: Parallelize JSON and metric
 pre-computation in jevents.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260512174638.120445-16-irogers@google.com>
References: <20260512174638.120445-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 05:06:41 +0000
Message-Id: <20260514050642.91265C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The `_init_worker` function is defined as a local function, whic=
h breaks the build under `spawn` multiprocessing semantics because it canno=
t be pickled.
- [Medium] Parallelizing the JSON parsing breaks architecture isolation, al=
lowing standard events from later architectures to overwrite those of earli=
er architectures.
- [Low] The `collect_json` callback omits the directory depth filter, leadi=
ng to redundant parsing of deeply nested JSON files.
--

commit a8c22dabeaaa676d9d6b5a7b1c0a3df0bfcd2345
Author: Ian Rogers <irogers@google.com>

perf pmu-events: Parallelize JSON and metric pre-computation in jevents.py

This commit refactors jevents.py to pre-populate its internal JSON AST cache
in parallel across all available CPU cores using ProcessPoolExecutor. It ai=
ms
to accelerate the execution time by reclaiming multi-core concurrency during
the build generation phase.

> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
[ ... ]
> @@ -1459,9 +1467,29 @@ struct pmu_table_entry {
>      raise IOError(f'Missing architecture directory \'{_args.arch}\'')
> =20
>    archs.sort()
> +  import concurrent.futures
> +  tasks =3D []
> +  def collect_json(parents: Sequence[str], item: os.DirEntry) -> None:
> +    if len(parents) =3D=3D 0:
> +      return
> +    if item.is_file() and item.name.endswith('.json') and not item.name.=
endswith('metricgroups.json'):

The commit message states the code will "apply depth filtering to prevent
redundant worker tasks".

Should there be a check on the depth of the directory structure here, to
avoid redundantly parsing deeply nested JSON files?

> +      tasks.append((item.path, get_topic(item.name)))
> +
>    for arch in archs:
>      arch_path =3D f'{_args.starting_dir}/{arch}'
>      preprocess_arch_std_files(arch_path)
> +    ftw(arch_path, [], collect_json)

By preprocessing all architecture standard files before the worker pool
evaluates the tasks, does this break architecture isolation?

Because archs.sort() evaluates architectures alphabetically, it appears that
architectures processed later might overwrite overlapping standard event
definitions of earlier architectures in the global _arch_std_events diction=
ary.

When the worker pool executes, will earlier architectures incorrectly resol=
ve
standard events against these overwritten definitions?

> +
> +  def _init_worker(std_events: dict) -> None:

Is it possible to use a local function as an initializer for
ProcessPoolExecutor when using the spawn multiprocessing start method?

The commit message notes it guarantees inheritance under spawn semantics.
However, Python's multiprocessing framework uses pickle to serialize the
initializer function for child processes, and local/nested functions cannot=
 be
pickled. Will this cause an AttributeError and crash the build?

> +    global _arch_std_events
> +    _arch_std_events =3D std_events
> +
> +  with concurrent.futures.ProcessPoolExecutor(initializer=3D_init_worker=
, initargs=3D(_arch_std_events,)) as executor:
> +    for path, topic, events in executor.map(_parallel_read_json_events, =
tasks):
> +      _json_cache[(path, topic)] =3D events

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512174638.1204=
45-1-irogers@google.com?part=3D15
