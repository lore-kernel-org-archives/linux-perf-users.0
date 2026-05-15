Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6FC3E16B3;
	Fri, 15 May 2026 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869933; cv=none; b=CTklUnt64zOt+EcC2zECCfQ95nMRgzQIwvBxeBi9SXBWHavMccxDNd8R++dwexEPHoof+H95BpNFV8r3Y1ytCs6xQAlg/UhInguqPI4IHIu/tk7qlC8DDU26pfgzhZtimNRn6CqHx6TtRNCMrmOEhuRZOMhuVt8zTSy8euZNrUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869933; c=relaxed/simple;
	bh=awaLQz5sSF7hcywI3IMk/jmuuDFq4pXfe36tjHj59PY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y8DtVtzruOX4B2C8pheEKGa1tXJtciPW+02rD03A7gOTn+Gkfvv96iwTrgqJsjZDY5rQbtX1P7KSdUJpkaGKFo6OfZ1HAuUQIng7NnT8xaqQlKr3/XmY65iEO3WXTffajf1M5kKnf2v1IKdvICS4Ru+178Q8P1RhmyYRV2iI1rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLRkhbpy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLRkhbpy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36305C2BCB0;
	Fri, 15 May 2026 18:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778869932;
	bh=awaLQz5sSF7hcywI3IMk/jmuuDFq4pXfe36tjHj59PY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=QLRkhbpy9n9QACSc5C9FzR/o3q7/pIh0FMT2gki/tAIKHTk/x7tErrO3KDf1OmbYi
	 8m64VIBBxQOrIZac2wUqi3fU/iQPIiCHJEoH4cF9c+B3yfsoHpkrzFLgcd4nUJzqTd
	 tUKnZp1F+MaqCVeISRdoqW95fw60xGQeoIGYdpXTG9xgZ6gi2BpAgJ5AJz+N2+Bq8+
	 zJtrGJu7z3BA0AJywZ5eAAQ5EioDObwAdmRNbmYx20o0guNt8gvJXgRL4CT4ipGgMf
	 SOxYgHdqJGNFSFWAcIj/dYpzGwj4eRcDMCP4E5JtQqf6T4JDISjmAGCFUMtg+ggKWQ
	 wWxxNjucxzS1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/14] perf pmu-events: Parallelize JSON and metric
 pre-computation in jevents.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260515173852.1378571-12-irogers@google.com>
References: <20260515173852.1378571-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 18:32:11 +0000
Message-Id: <20260515183212.36305C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The use of `ProcessPoolExecutor` without a `max_workers` limit vio=
lates GNU Make's jobserver concurrency constraints, causing system oversubs=
cription.
--

commit 09eba7d34c7e309d0f6449fe513b92dfbec5e85c
Author: Ian Rogers <irogers@google.com>

perf pmu-events: Parallelize JSON and metric pre-computation in jevents.py

This commit refactors jevents.py to pre-populate its internal JSON AST cache
in parallel across available CPU cores using ProcessPoolExecutor, reducing
build generation time.

> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
[ ... ]
> @@ -1459,9 +1471,25 @@ struct pmu_table_entry {
[ ... ]
>    for arch in archs:
>      arch_path =3D f'{_args.starting_dir}/{arch}'
>      preprocess_arch_std_files(arch_path)
> +    ftw(arch_path, [], collect_json)
> +
> +  with concurrent.futures.ProcessPoolExecutor(initializer=3D_init_worker=
, initargs=3D(_arch_std_events,)) as executor:

Does this bypass GNU Make's jobserver concurrency constraints? By
instantiating ProcessPoolExecutor without a max_workers limit, it will
default to spawning workers for all available CPU cores.

If a user explicitly requests a restricted build with make -j1, or if this
runs alongside numerous other compilation jobs, could it lead to extreme
CPU contention and potential out-of-memory failures?

> +    for path, topic, events in executor.map(_parallel_read_json_events, =
tasks):
> +      _json_cache[(path, topic)] =3D events
> +
> +  for arch in archs:
> +    arch_path =3D f'{_args.starting_dir}/{arch}'
>      ftw(arch_path, [], preprocess_one_file)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515173852.1378=
571-1-irogers@google.com?part=3D11
