Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A331DDC2B
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 00:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777768745; cv=none; b=Qf5g3McDuxgoBTTDf7z0nnNX1dP9NJjGK2x0pNnjbUGALINLZnaevZYS+WV1JvIA9OMWhFkVsT+YhFTbsAjTNN/2r45te3ej9eSGmn/FtbFyXqTJFzvoD7ww8tCwljMk5zFuo1xvT90O3ZQqkGVYCFrFyjg3MT8azfNAONMDogM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777768745; c=relaxed/simple;
	bh=yxirax09uRS6KnmZbGjihKz4IO9/sauznMSpa9O0dnM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bPHB2uujQMakiOzfcsLU+5BM9/FNQRB0Qj1ugnKianbt+X8vzpGx+B6OtLJntKO9h6HanTp9q6ntIR5J7H7lzqvrKqyO4JPNoYtNZ6xjT7LMfY4t4xD4ALDGw6MbgreIshLkIJCtyRFpGZNVDzwPHHQCJXTWzYezsp/VXrIYgbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4NoZQMq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4NoZQMq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4F7C19425;
	Sun,  3 May 2026 00:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777768745;
	bh=yxirax09uRS6KnmZbGjihKz4IO9/sauznMSpa9O0dnM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=L4NoZQMqfuDJ8HzALwBWHWFW34zfPDibsrDtjKo/FEXP3uoDjaZzuCV860BVkiJee
	 K4zoeUkDC/UWViPcDyq938B/z2P9bEXed5xemhroEzUe9tVB2kiCNaE4RkbvEKe0Gk
	 3cJwIh8+iQMkrewmRN84zijkIge1DmiwvyzJIpGgGSN9DGeTR/lD9nEbOB1wcirgE4
	 cnfVgXRxocSiH4cbtmVneabXDq++oXfTgHbzxLBCgBYkh2KewxFOS9mZjK6X2KrQcx
	 gUJLv5U+M+tV7FbD6mocs6loSypUWx1XNPlbv6JAVmx2KqK2U7+Gm1TwzCbxHeSmF+
	 KttXCSz62RtLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 03/18] perf env, dso, thread: Add _endian variants
 for e_machine helpers
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260503002248.1040791-4-irogers@google.com>
References: <20260503002248.1040791-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 00:39:04 +0000
Message-Id: <20260503003905.4B4F7C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] thread__e_machine_endian() fast-path returns successfully without =
initializing the is_big_endian output parameter.
- [High] dso__e_machine_endian() bypasses lazy evaluation of env->arch, sil=
ently falling back to the host's endianness.
- [High] perf_arch_is_big_endian() falsely categorizes standard big-endian =
architectures (e.g., MIPS, m68k) as little-endian.
- [High] read_proc_e_machine_for_pid() uses a blocking open() on user-contr=
olled /proc paths, risking an indefinite hang.
--

commit 34bedc0fb8b78f200595dbcc97e6be1af183988e
Author: Ian Rogers <irogers@google.com>

perf env, dso, thread: Add _endian variants for e_machine helpers

Add perf_arch_is_big_endian(), dso__read_e_machine_endian(),
dso__e_machine_endian(), and thread__e_machine_endian() to support
bi-endianness and cross-architecture analysis without breaking the
existing API.

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index b791e1b6b2cf..6439b2a3c898 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
[ ... ]
> @@ -1308,9 +1313,11 @@ uint16_t dso__e_machine(struct dso *dso, struct ma=
chine *machine, uint32_t *e_fl
>  	case DSO_BINARY_TYPE__BPF_IMAGE:
>  	case DSO_BINARY_TYPE__OOL:
>  	case DSO_BINARY_TYPE__JAVA_JIT:
> -		if (e_flags)
> -			*e_flags =3D EF_HOST;
> -		return EM_HOST;
> +		if (is_big_endian) {
> +			*is_big_endian =3D perf_arch_is_big_endian(
> +				machine && machine->env ? machine->env->arch : NULL);

Could this direct access to machine->env->arch read a NULL pointer if the
architecture hasn't been lazily computed yet?

The arch string inside struct perf_env is lazily populated via
perf_env__arch(env). If NULL is passed to perf_arch_is_big_endian() here, it
will default to the host's byte order.

> +		}
> +		return perf_env__e_machine(machine ? machine->env : NULL, e_flags);
>  	case DSO_BINARY_TYPE__DEBUGLINK:
[ ... ]
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 0edc67a468ab..1a4db133262b 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
[ ... ]
> @@ -339,6 +339,18 @@ int perf_env__kernel_is_64_bit(struct perf_env *env)
>  	return env->kernel_is_64_bit;
>  }
> =20
> +bool perf_arch_is_big_endian(const char *arch)
> +{
> +	if (!arch)
> +		return __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__;
> +
> +	if (str_ends_with(arch, "_be") || !strcmp(arch, "sparc") || !strcmp(arc=
h, "sparc64") ||
> +	    !strcmp(arch, "s390") || !strcmp(arch, "s390x") || !strcmp(arch, "p=
owerpc"))
> +		return true;
> +
> +	return false;
> +}

Does this check omit standard big-endian architectures like mips, m68k, and
parisc?

Because they aren't in the allowlist, cross-architecture analysis on a MIPS
kernel might return false, causing downstream consumers to be incorrectly
configured in little-endian mode.

> +
>  int perf_env__set_cmdline(struct perf_env *env, int argc, const char *ar=
gv[])
>  {
[ ... ]
> diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> index 22be77225bb0..8611293deca9 100644
> --- a/tools/perf/util/thread.c
> +++ b/tools/perf/util/thread.c
[ ... ]
> @@ -449,7 +449,7 @@ void thread__find_cpumode_addr_location(struct thread=
 *thread, u64 addr,
>  	}
>  }
> =20
> -static uint16_t read_proc_e_machine_for_pid(pid_t pid, uint32_t *e_flags)
> +static uint16_t read_proc_e_machine_for_pid(pid_t pid, uint32_t *e_flags=
, bool *is_big_endian)
>  {
>  	char path[6 /* "/proc/" */ + 11 /* max length of pid */ + 5 /* "/exe\0"=
 */];
>  	int fd;
> @@ -458,7 +458,8 @@ static uint16_t read_proc_e_machine_for_pid(pid_t pid=
, uint32_t *e_flags)
>  	snprintf(path, sizeof(path), "/proc/%d/exe", pid);
>  	fd =3D open(path, O_RDONLY);

Is it possible for this open() to hang indefinitely if the /proc/%d/exe path
points to a blocking FUSE filesystem or an unresponsive network mount?

Opening it without O_NONBLOCK risks hanging the perf daemon.

>  	if (fd >=3D 0) {
> -		e_machine =3D dso__read_e_machine(/*optional_dso=3D*/NULL, fd, e_flags=
);
> +		e_machine =3D dso__read_e_machine_endian(/*optional_dso=3D*/NULL, fd, =
e_flags,
> +						       is_big_endian);
>  		close(fd);
>  	}
[ ... ]
> @@ -491,6 +495,7 @@ uint16_t thread__e_machine(struct thread *thread, str=
uct machine *machine, uint3
>  		.machine =3D machine,
>  		.e_flags =3D 0,
>  		.e_machine =3D EM_NONE,
> +		.is_big_endian =3D false,
>  	};
> =20
>  	if (e_machine !=3D EM_NONE) {

Does this fast-path return successfully without initializing the is_big_end=
ian
output parameter?

Because struct thread does not cache the endianness, any caller relying on
is_big_endian might read uninitialized memory or a default value from their
stack.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503002248.1040=
791-1-irogers@google.com?part=3D3
