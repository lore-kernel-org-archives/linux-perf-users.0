Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BE221D596
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 01:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777770005; cv=none; b=hsr5v1LhKjxeOtgypD1BbvwHJr+eSlN2Mu3aI71cEH4bCKgFkpVULCZG3e94PFBR/v+UOkXGfmeU7xfttaBs48YX8aehMZnZZYlr+edurglGc1UcK8vSwywAC1oBZ/rJLNSG7SUOfFUnM8dzIEP3A6YDtCgickMorSbCHPAWIPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777770005; c=relaxed/simple;
	bh=DZn2uChAsjL1ZCvViTEnDPQu8AKn45D8XM5orKTz8EE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G19LugU1a5yLFLMz2vFG5zm7BLHvQGiOvzF8IzF0ytz/5GUfABWtam+OVsNP/P+gXt7Pjt1K4QJ1e0T0EM3yS8TZ0OILh5T/X7bvA4B1F/ix39qpbLmkYU6RnXfPS/gR7m8j627ruuPr+fyZdMpwNkLDgHb9jVUtlEoHRQZTm14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKqxBRpc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKqxBRpc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEE1C19425;
	Sun,  3 May 2026 01:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777770004;
	bh=DZn2uChAsjL1ZCvViTEnDPQu8AKn45D8XM5orKTz8EE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=tKqxBRpcuX/aLuXproVWhsmulB1vU2z6EcXHh+gkPX42ndTqebH4AP/9Oo+JPVdeA
	 mxw6zp4PLhWj/vTpvQfaKKg01DBh1Wxh5+2yCtw2BUGi77/isAVtYckd6oj2m56LfD
	 pddO/LH5psdWAPZYFXDxLwZKcSjNE2zkUIGdcqsMzkxrsv7DZ+bTPo9j4rjRYPr8GB
	 gQWHL7eXdMePZbAexIVO3qJ8zNRh9yeM3KmZW7kLE0Kz/Dh4UwPZGQJRJuLN/2lB0L
	 90E0I/Ur6R0ApGTikxDLPl7xSfx3xhmABI80+4R9HC+JDd2J3saI4Y82wzbS1Mm2Et
	 pm9DoVddsjymA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 07/18] perf machine: Use perf_env e_machine rather
 than arch
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260503002248.1040791-8-irogers@google.com>
References: <20260503002248.1040791-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 01:00:03 +0000
Message-Id: <20260503010004.8CEE1C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] machine__is() incorrectly falls back to the compile-time host arch=
itecture when the machine's environment is NULL, breaking non-x86_64 guest =
kernel memory map handling.
- [High] get_leaf_frame_caller() delegates to thread__e_machine(), which un=
conditionally falls back to the host architecture if maps fail, breaking of=
fline cross-architecture callchain analysis.
--

commit e3337f1222c33fd5dc5c1fda6cc5b1ac0b73b28e
Author: Ian Rogers <irogers@google.com>

perf machine: Use perf_env e_machine rather than arch

This commit modifies perf's machine parsing to use ELF machine constants
instead of architecture strings. This is intended to provide more precise
comparisons by using the thread's e_machine and avoids issues with normaliz=
ed
architecture strings.

> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index e76f8c86e62a..6d32d3cb5cb7 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1611,10 +1611,15 @@ static bool machine__uses_kcore(struct machine *m=
achine)
>  	return dsos__for_each_dso(&machine->dsos, machine__uses_kcore_cb, NULL)=
 !=3D 0 ? true : false;
>  }
> =20
> +static bool machine__is(struct machine *machine, uint16_t e_machine)
> +{
> +	return machine && perf_env__e_machine(machine->env, NULL) =3D=3D e_mach=
ine;
> +}

Could this fallback to the host architecture when dealing with guest machin=
es
that don't have their environment populated?

Guest machines initialized via machines__add do not have their machine->env
populated (machine->env =3D=3D NULL). Previously, machine__is(..., "x86_64"=
) used
perf_env__raw_arch(NULL), which returned "unknown", safely evaluating to
false.

The new implementation uses perf_env__e_machine(NULL, NULL), which evaluates
to perf_env__e_machine_nocache() and unconditionally returns EM_HOST (the
architecture the perf binary was compiled for).

When analyzing non-x86_64 guests on an x86_64 host, machine__is(guest,
EM_X86_64) evaluates to true.

[ ... ]

> @@ -2770,7 +2775,7 @@ static int find_prev_cpumode(struct ip_callchain *c=
hain, struct thread *thread,
>  static u64 get_leaf_frame_caller(struct perf_sample *sample,
>  		struct thread *thread, int usr_idx)
>  {
> -	if (machine__normalized_is(maps__machine(thread__maps(thread)), "arm64"=
))
> +	if (thread__e_machine(thread, /*machine=3D*/NULL, /*e_flags=3D*/NULL) =
=3D=3D EM_AARCH64)
>  		return get_leaf_frame_caller_aarch64(sample, thread, usr_idx);
>  	else
>  		return 0;

Will this break offline cross-architecture callchain analysis for AArch64?

Previously, get_leaf_frame_caller() used machine__normalized_is(), which
correctly checked the session's recorded perf_env (derived from the perf.da=
ta
header) to determine the architecture.

The new code relies on thread__e_machine() returning EM_AARCH64. If
thread__e_machine() cannot determine the architecture from the thread's
DSOs (for example, due to stripped binaries, kernel threads, or JIT code),
it falls back to read_proc_e_machine_for_pid().

Since offline perf.data files are not part of a live session, this bypasses
/proc reads and unconditionally defaults to EM_HOST (the compile-time
architecture of the perf binary). As a result, analyzing an AArch64 perf.da=
ta
file on an x86_64 host will silently fall back to EM_X86_64, bypassing
get_leaf_frame_caller_aarch64() and preventing leaf frame unwinding.

[ ... ]

> @@ -3181,7 +3172,7 @@ int machine__get_kernel_start(struct machine *machi=
ne)
>  		 * start of kernel text, but still above 2^63. So leave
>  		 * kernel_start =3D 1ULL << 63 for x86_64.
>  		 */
> -		if (!err && !machine__is(machine, "x86_64"))
> +		if (!err && !machine__is(machine, EM_X86_64))
>  			machine->kernel_start =3D map__start(map);
>  	}
>  	return err;

If machine__is() erroneously returns true for non-x86_64 guests (as noted
above), could this leave machine->kernel_start at 1ULL << 63 and corrupt
kernel address resolution for cross-architecture guest analysis?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503002248.1040=
791-1-irogers@google.com?part=3D7
