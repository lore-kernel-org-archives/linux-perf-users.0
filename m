Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6BA26A1A4;
	Fri, 15 May 2026 01:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778806856; cv=none; b=s+iK8wa8rvI57Qf5zxdYTxXpA3iMRuJHBElwsW1D0hPVGyDFMWXonX4XhcQxHGry1uHcngxHDt40czZrGtCFOxxqCt4XpUHZnpAQaWlDyXcQIwIYQg+jPv6YIWyUk7RtC1Fw1lJ/iqUXSDnwcYdcFRKIAFQwpjq+TtWuZLRpP+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778806856; c=relaxed/simple;
	bh=VMGiXyoHi1MvvzIJPK7gP1LJEbnOTRGKJXAbGf8inso=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i3u/AVHqoVr4S7UPRJjolFJXDeHMx/DUNrmWD653uO8Z4Yiw37djWNRTPn69cMBmZ9H20rYYovEqBtLYO0hG7kdoORddVjelGTuu/hEyKkzIDtNW9FOvr5b01XA6tJO3chFKez2ChgG/fN0fIGYWVsiUgrXvg4NClcVHmmNbEBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNqpbgqO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNqpbgqO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6612C2BCB3;
	Fri, 15 May 2026 01:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778806856;
	bh=VMGiXyoHi1MvvzIJPK7gP1LJEbnOTRGKJXAbGf8inso=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=uNqpbgqOkpz5DE821NRmbPlsVy6a2lHfhNahqeC4M3ohI39neG7lSaJwPWP/nOrCy
	 1S+uUomMqagqtdXu9eFqdjo1WNqOl/kM9yPotUQBgs8iwXt7EOiB0MummEXeyDMmre
	 AhIl+++tzkJhM9pkQAItMthDBHEOO+SClMKunSz3gavlwi4qmF7SRZgArkenp46uYa
	 bnSCadtDX7K5jrPvbMzVCOoFmKXEZPqXm1355aEvr460Eev9e+WY13IlhKRb1a1fD+
	 DG3ser/316r/Z3B4LSplgYFG7a8Mpya8a9GAiJ8rQY/Hu77SzQUrqEcLqUAcKdlTMS
	 Su+Y4NUKu3KGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/17] perf pmu-events: Parallelize JSON and metric
 pre-computation in jevents.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260514163409.927816-15-irogers@google.com>
References: <20260514163409.927816-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 01:00:55 +0000
Message-Id: <20260515010055.E6612C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Pre-populating `_arch_std_events` for all architectures upfront be=
fore parallel parsing causes standard events to be overwritten by subsequen=
t architectures, breaking per-architecture scoping.
--

commit 91f4ede8d30987c122141ee70c9172917d76aef9
Author: Ian Rogers <irogers@google.com>

perf pmu-events: Parallelize JSON and metric pre-computation in jevents.py

This commit parallelizes the parsing of JSON event and metric files in
jevents.py using ProcessPoolExecutor. It introduces a worker initializer
to inherit standard event mappings, significantly reducing execution time.

> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 70a45e62f5d16..316708e32d743 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py

[ ... ]

> @@ -1459,9 +1471,25 @@ struct pmu_table_entry {
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
> +      tasks.append((item.path, get_topic(item.name)))
> +
>    for arch in archs:
>      arch_path =3D f'{_args.starting_dir}/{arch}'
>      preprocess_arch_std_files(arch_path)
> +    ftw(arch_path, [], collect_json)
> +
> +  with concurrent.futures.ProcessPoolExecutor(initializer=3D_init_worker=
, initargs=3D(_arch_std_events,)) as executor:

Does this loop overwrite standard events from earlier architectures?

In the original sequential code, _arch_std_events was populated for a
single architecture and immediately used for parsing. By hoisting
preprocess_arch_std_files into this loop for all architectures upfront,
and since _arch_std_events is a single global dictionary that is not cleared
between iterations, identically named standard events from later
architectures in the archs list will overwrite those from earlier
architectures.

When the worker processes are initialized with this completely merged state
in _init_worker, it appears they will incorrectly resolve ArchStdEvent
references using the later architecture definitions. Can this be isolated
per architecture instead?

> +    for path, topic, events in executor.map(_parallel_read_json_events, =
tasks):
> +      _json_cache[(path, topic)] =3D events
> +
> +  for arch in archs:
> +    arch_path =3D f'{_args.starting_dir}/{arch}'
>      ftw(arch_path, [], preprocess_one_file)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514163409.9278=
16-1-irogers@google.com?part=3D14
