Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAF52367D3
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 02:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775962258; cv=none; b=IIPYIB3A9M3IfaDwsz5bVn3sIkde41lEa3Lf4763rIMazTPyDQvydohYXADV3kA39a4e8YQyukLrtX1D78S2MwflXUEiPAAgci/Oat2VmRHu95bdJpsa4VpWStgC68ZvISDwfQbivjihBIICuZ2xVGhhdg1fwhxvhDwet6O5Irc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775962258; c=relaxed/simple;
	bh=epKLVvkoQPukck1qDmr4CihEWozcgUAEZ/WDu1glXio=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jprpt1NvQn1NUBDli49mU1Dbs1lFEetjW108Iksfdpv1bHN6xe65OBJj+0/5teM85l4LQ8tVqILa+135RB66a7HlPIVw8JK6rY8b2FcoGFHYnaWlxcRY3AHCYrwijMmUrUHP+1Qvj4oY4C99rjB0J7Hk4UuYKUON2RYNSvyp0UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcPmAQso; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcPmAQso"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF96DC116C6;
	Sun, 12 Apr 2026 02:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775962258;
	bh=epKLVvkoQPukck1qDmr4CihEWozcgUAEZ/WDu1glXio=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=RcPmAQsoa1wygjC62Rf941M4NULpZ0zghxwvMRE4HHAV+1sttVBP0vNwyMENHmAMJ
	 3uV+gHI5QVad9chJYcVg3bcPokn9gEGJ4liegmkXy0hQLxfXZrlPBAfrFMg9+gynJM
	 9BjxmzmJtUsuPZTzbiK/Uv22xuJpP+PeH2GtT4lNfolT82JoeQktAXeetdVB9xqDhr
	 9lHjbUqiLGPmUF0k72P577g1lPjMZX0hUNlOCIf1+sNR1yVFNv8B0p7vCc9I7SQl8C
	 qFs6pPNM9aBlItDl7RpWLxjV/tGofqAYheHM1Q6akZPb3M5Ang1PNRYOBkEnQAgcPQ
	 zZQSI9UpHVkVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 26/29] perf timechart: Bounds check CPU
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260412020833.641177-27-irogers@google.com>
References: <20260412020833.641177-27-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Apr 2026 02:50:57 +0000
Message-Id: <20260412025057.DF96DC116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] The bounds check for CPU IDs fails to protect the dynamically allo=
cated `topology_map` array, allowing out-of-bounds heap reads during SVG re=
ndering.
--

commit 6083479d6ab93bb66bdea31d29ed3a4768c300e7
Author: Ian Rogers <irogers@google.com>

perf timechart: Bounds check CPU

This commit ensures the CPU ID is within expected bounds when processing
samples. It aims to prevent out-of-bounds memory accesses in arrays
tracking CPU state by bounding the CPU ID to MAX_CPUS.

> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechar=
t.c
> index 64f69bd67c6b7..64903b54e8a73 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c
[ ... ]
> @@ -1517,6 +1544,8 @@ static int process_header(struct perf_file_section =
*section __maybe_unused,
>  	switch (feat) {
>  	case HEADER_NRCPUS:
>  		tchart->numcpus =3D ph->env.nr_cpus_avail;
> +		if (tchart->numcpus > MAX_CPUS)
> +			tchart->numcpus =3D MAX_CPUS;

Does this bounds check fully protect the dynamically allocated topology_map
array?

While this limits tchart->numcpus to MAX_CPUS, topology_map is dynamically
allocated in svg_build_topology_map() with a size based on
env->nr_cpus_online.

Because nr_cpus_avail can be larger than nr_cpus_online on systems with
offline CPUs, and trace events can have CPU IDs up to MAX_CPUS - 1, could
CPU indices exceed the bounds of topology_map?

When perf timechart --topology is used, cpu2y() indexes into
topology_map[cpu], which might still result in an out-of-bounds heap read
during SVG rendering.

>  		break;
> =20
>  	case HEADER_CPU_TOPOLOGY:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260412020833.6411=
77-1-irogers@google.com?part=3D26
