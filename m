Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE0C38D016;
	Wed, 13 May 2026 22:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778710704; cv=none; b=TTBwuyM5RgdyoJZOPdNY8E/d9LQzIpCfh2IZyDJ9OmwZu84QW9COZPJrOb2UHURp6d7oGnHax8H46jGDspQtgyAiwR7O1/R8kx5SyXeh96QZgNMbzqCcn3oZilN9pYZwjUSAyDLH9N5MP3tgkieYA+UyQsevrLOtV6PS6/wZGm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778710704; c=relaxed/simple;
	bh=jAH5trAGjcAHUkecqgGL2PY7cPqAzuJcaRVc2i7ta4A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ebPmewOwBbad2NQpo3FA9FSJEhuL6ac3SwJCQeloBvRaaBHLwsBOlY5+GqHbNpxDswUaqFj6QEmWW4iV8LtmWmq2gZH1ePHXjopcc4z1+nKFTYY5xS9WroOoXbuTBsZkZE2yKLaPpMASXU3fb/3+5Gsp/Lf1gUqTwbNWWdtaKUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeQP0DA4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeQP0DA4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0368C19425;
	Wed, 13 May 2026 22:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778710704;
	bh=jAH5trAGjcAHUkecqgGL2PY7cPqAzuJcaRVc2i7ta4A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=LeQP0DA4Qf4xFdsDddALL/Yyi1Pfhkdy9lBdYpJzTOTBHPKr6gAfDcedpi5UeN3gW
	 rIbn7OGOO9Gmvc2xtikn7dxj7DymmvCll2xj5GVzpBM3a5DnFq/tQ9glilpStCk4JE
	 4p2OPXYAZ9/nvfK0pVR6tNyfkp0LJsbaXnKD5AYiZGaqR/LcrS+XPtKb7Ms7I7nUz8
	 vNZlRx3mufjL167LuI4pp3+qswzPtqmMxKqNU3Zg4jKNIkTB+z8aVVqu0Q/M77A8Di
	 J80h7dj7rqXjjPVCeAs6p9XaLyVSlMS/Yl3lFx1U/ap9hlBj6+vZ40fvhcvwH9Sjvs
	 HJYminJ50iIsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 13/14] perf pmu-events: Parallelize JSON and metric
 pre-computation in jevents.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260512053539.3410189-14-irogers@google.com>
References: <20260512053539.3410189-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 22:18:23 +0000
Message-Id: <20260513221823.D0368C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The nested `_init_worker` function causes a fatal `PicklingError` =
under `spawn` multiprocessing semantics.
- [High] Parallelizing the JSON parsing breaks architecture isolation for s=
tandard events, leading to state contamination across architectures.
- [Medium] The depth filtering logic is missing from the `collect_json` cal=
lback, causing redundant parallel parsing of deeply nested files.
--

commit 90db323cf161fc6e18235c0d700851677b283082
Author: Ian Rogers <irogers@google.com>

perf pmu-events: Parallelize JSON and metric pre-computation in jevents.py

This commit refactors jevents.py to pre-populate its internal JSON AST cache
in parallel using ProcessPoolExecutor. It aims to accelerate execution by
parallelizing the parsing of JSON event and metric files across available
cores.

> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 70a45e62f5d16..eb72c154f946e 100755
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
> +      tasks.append((item.path, get_topic(item.name)))

Is the depth filtering logic missing from collect_json()?

The commit message mentions applying depth filtering to prevent redundant
worker tasks. However, collect_json does not seem to limit the directory
depth.

This could cause the main thread to queue worker tasks for deeply nested
files, which are fully parsed by the worker pool but subsequently ignored
during the actual generation phase.

> +
>    for arch in archs:
>      arch_path =3D f'{_args.starting_dir}/{arch}'
>      preprocess_arch_std_files(arch_path)
> +    ftw(arch_path, [], collect_json)

Does this loop break architecture isolation for standard events?

By looping over all architectures to populate a single global _arch_std_eve=
nts
dictionary before parsing the JSON files, standard events with identical
names from later architectures might overwrite definitions from earlier
architectures.

When the parallel worker processes evaluate the earlier architecture JSON
files, they may use this polluted global dictionary and inherit fields from
the later architectures, leading to incorrect PMU tables.

> +
> +  def _init_worker(std_events: dict) -> None:
> +    global _arch_std_events
> +    _arch_std_events =3D std_events
> +
> +  with concurrent.futures.ProcessPoolExecutor(initializer=3D_init_worker=
, initargs=3D(_arch_std_events,)) as executor:

Could defining _init_worker locally cause a pickling error under spawn
multiprocessing semantics?

_init_worker is defined as a local function inside main(). Under spawn
multiprocessing semantics, Python uses pickle to serialize objects to child
processes, but pickle cannot serialize local functions.

This regression might result in an attribute error when initializing the
executor, which seems to contradict the commit message's claim of supporting
spawn semantics.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512053539.3410=
189-1-irogers@google.com?part=3D13
