Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82FB3A6F19
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 22:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775860700; cv=none; b=D8s6J2V7jrZ1RKzA+mDg61UxrBApG8Xx9iZOJrp9qnuNXMK38itAW39A45685lTxZlqHT/+23Nxtzo/0LuELX/LsaCk2hXaG3j5WRnxPyGxM+gETkA8BDDOma9lCxOpyhGeDh/2vP5cD/o0XHV9yq3D+GJ5eVSDL9Pusbojd2Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775860700; c=relaxed/simple;
	bh=JjP1+lz6KJ1FdagWokXBHRsOPQ2egbtcYMUh8YMdtb8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=StfwUOVOWjiJjHNUsUe1BhnD56YUY+P2kcnJQZTYi1INN894VAaKVff++wEq/OcuW6i93KvDPWXpuWGi7d5RYRNb4w87bGjUmZQoiMmOJFMfArfFBlo+JwVKWYXztq94Ftuq1WVVnb+XAcPWzOv237MlsN3Fuz282K2haYiUdZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRXkei4g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRXkei4g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB18C19421;
	Fri, 10 Apr 2026 22:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775860700;
	bh=JjP1+lz6KJ1FdagWokXBHRsOPQ2egbtcYMUh8YMdtb8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=rRXkei4gfVP1YmcPQnD9qOvOdZAvJsByNVPKpow1YOXPnfFfQzpsjRq0ZpPwqg4LJ
	 3Qr8d8eg+8a4HvbsgvkmJ6/zAoTprDaLqQBzRG4FxLXrRSuSU/ZCFa8/aPRowebXE0
	 SU0860PRwzMuAkgunEKhZMz0yMJmD8E1MAi1jyu+YnDn258xEVwXyvETDxYz0xjJc0
	 PW7gLfc9Y+tfMXioGFPtV2LBeQ6bxkj2xu428ymmnHHQAngpFAxM9wqBohr7ChL8m6
	 6hCNNhkfQAn3sasfSkuCBnqmwtfXzrOgAz2BN/dJiuvRha5B61/rkTojJPd7L6xtMB
	 RPwrIC7JpLoeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/13] perf header: Sanity check HEADER_CPU_TOPOLOGY
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260410220905.200051-5-acme@kernel.org>
References: <20260410220905.200051-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Apr 2026 22:38:19 +0000
Message-Id: <20260410223820.6CB18C19421@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Regression: Freeing `env->cpu` on error paths creates a state inco=
nsistency leading to a guaranteed NULL pointer dereference.
- [High] Pre-existing: Heap out-of-bounds read and information leak due to =
missing null-termination guarantees in `do_read_string()`.
--

commit b6aa3d453035257912e7800f950abadb5a643531
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Sanity check HEADER_CPU_TOPOLOGY

This commit adds validation to process_cpu_topology() to harden against
malformed perf.data files. It bounds checks sibling counts and changes bare
returns to goto statements that free the env->cpu structure.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c

[ ... ]

> @@ -2887,7 +2898,13 @@ static int process_cpu_topology(struct feat_fd *ff=
, void *data __maybe_unused)
>  	env->sibling_cores =3D strbuf_detach(&sb, NULL);
> =20
>  	if (do_read_u32(ff, &nr))
> -		return -1;
> +		goto free_cpu;
> +
> +	if (nr > (u32)cpu_nr) {
> +		pr_err("Invalid HEADER_CPU_TOPOLOGY: nr_sibling_threads (%u) > nr_cpus=
_avail (%d)\n",
> +		       nr, cpu_nr);
> +		goto free_cpu;
> +	}

Does freeing env->cpu on error paths here create a state inconsistency?

If perf_session__read_header() ignores the return value of
perf_header__process_sections() and proceeds, env->nr_cpus_avail will still
be greater than 0, but env->cpu will be NULL because it was freed.

Later consumers like perf_env__get_socket_aggr_by_cpu() might blindly
dereference env->cpu based on nr_cpus_avail being greater than zero:

perf_env__get_socket_aggr_by_cpu()
    env->cpu[cpu.cpu].socket_id

Before this change, the partially initialized array was left intact and
safely zero-initialized, which avoided a null pointer dereference.=20

The memory leak this attempts to address appears to be safely handled alrea=
dy,
as perf_env__exit() properly frees env->cpu during session cleanup. Could
these new error paths just return directly to avoid the crash?

A check of subsequent commits in this series indicates this resulting state
inconsistency remains unaddressed.

[ ... ]

> @@ -2936,7 +2953,13 @@ static int process_cpu_topology(struct feat_fd *ff=
, void *data __maybe_unused)
>  		return 0;
> =20
>  	if (do_read_u32(ff, &nr))
> -		return -1;
> +		goto free_cpu;
> +
> +	if (nr > (u32)cpu_nr) {
> +		pr_err("Invalid HEADER_CPU_TOPOLOGY: nr_sibling_dies (%u) > nr_cpus_av=
ail (%d)\n",
> +		       nr, cpu_nr);
> +		goto free_cpu;
> +	}

This isn't a regression from this patch, but looking at the surrounding code
that processes these sibling strings:

str =3D do_read_string(ff);
if (!str)
    goto error;

if (strbuf_add(&sb, str, strlen(str) + 1) < 0)

Is it possible for do_read_string() to return a string without a null
terminator?=20

If a malformed file provides a string without a null byte, could strlen()
read past the end of the heap allocation until it finds one, potentially
leaking heap data when the topology information is dumped?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260410220905.2000=
51-1-acme@kernel.org?part=3D4
