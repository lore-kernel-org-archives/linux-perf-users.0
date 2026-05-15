Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ADE282F1A;
	Fri, 15 May 2026 20:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778876566; cv=none; b=LPYzmBijQOdUWNc+pt9qQi7W8IbIx9mVQ4dBGp37kN0AfB2JkMC5cVbrhoWuPTW5iMUUV47clPk17XAOWEYkVJqUMzpgPVPQPkROVpzdu5FxzhpiWq5NsvkhIIo+BhBmcziFoaJX4s4WnLe+98lLfblNHirEMysnMVGHRax7vOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778876566; c=relaxed/simple;
	bh=UsyuQzbTJXFipCJT25o0rf77vznEaQ64hROf0jehclw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ar41ZXojzGIoNehOuHnKERrThQ58q0tsOWz2CCW8LIwkl0a7VjkvTdtHinmBwhKxpxM4rB6IH70Ar30M35gRik5oXSt4top4fXXaqIyw9XzdvUasCDgbTkUkVzxv9898qFC6A+QLTNmvY2m70yFSIF/VdNDfX3nIamRnGGhtzR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqNlQZ/y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqNlQZ/y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBD6C2BCB0;
	Fri, 15 May 2026 20:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778876565;
	bh=UsyuQzbTJXFipCJT25o0rf77vznEaQ64hROf0jehclw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=jqNlQZ/yN8atv3vo1hsxjOv/zCArRJurWys4eIC+OpH12FCliJ23PNXAni+5yOlU5
	 JxdvCtYnZsV9TWIdH0Op45DfGVLGu+aDfFbjtXCFlgc1a7RMb+Vqs66P/LSOUQlh54
	 u3+O/Ndd+1lkEmprIBT40KbXO6PC5OMzc/nN10o6I2WdQn5vhw/2EzOgDOi8hK3PkA
	 78V0apKqFH1xpS+jV/cPHUlZuT0E0wb+PYlpJlYllZZRBiRmgW++PJ2r2bcnEShCaV
	 wGUWZkcmtbHLcPs6kUBuCpkBd8AUt3DIsK20H6vq77UqDxG4Kdn5ctV27pRqseF5YA
	 pMgHN51xQbmCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/14] perf pmu-events: Parallelize JSON and metric
 pre-computation in jevents.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260515193314.1593560-12-irogers@google.com>
References: <20260515193314.1593560-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 20:22:44 +0000
Message-Id: <20260515202245.6EBD6C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unconditional use of ProcessPoolExecutor bypasses the Kbuild job=
server limits, causing severe CPU oversubscription during the build.
--

commit 3ed526c623f5b05d6418cda5b990edc4c0a3a462
Author: Ian Rogers <irogers@google.com>

perf pmu-events: Parallelize JSON and metric pre-computation in jevents.py

This commit refactors jevents.py to use ProcessPoolExecutor to parse JSON
event and metric files in parallel. This accelerates execution by caching t=
he
JSON AST across available CPU cores.

> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index db55954579790..0f35b558f45db 100755
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

Does this bypass the Kbuild jobserver limits?

By default, instantiating ProcessPoolExecutor without explicitly configuring
max_workers will spawn os.cpu_count() child processes.

Since the kernel build system uses Make's jobserver to carefully coordinate
parallelism across the tree, ignoring the user-specified resource limits
(such as make -j8) could lead to massive process thrashing and potential
out-of-memory conditions on high-core machines.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515193314.1593=
560-1-irogers@google.com?part=3D11
