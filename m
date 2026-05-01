Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54792C21E8
	for <linux-perf-users@vger.kernel.org>; Fri,  1 May 2026 19:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777664569; cv=none; b=QhVvFTA4LgxFr1X+AmUoA7fBll+y+DZ53n3V1gWLSK8d897w9E5ty7zyT7Yg4ghyG7VzzH62RhFn4U620/hoDTSd/ayYJFxwo4iEuSs+Z7gudRSPESHnW649vr/xupPZkZR6ekO6YCl3cBSXKY4qFUzZWemFw6mmyB9E1c3Qn3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777664569; c=relaxed/simple;
	bh=NFmR8Ck4qnqYPJnuZo9Mrxhvadc7TlV0/juKC7CrRq4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qZygZCwunUx95ZchRERq0c2cvhbXfSaNNyUV7fFiGLPk9GidZY07k8M1TxFRN6AVrjnKgBWwnn7y7hKdiBc/nLYJHdTKV+av3BLw9S0HhuDVIFQFqnpNUUkYSdkT3ejmbkdvjBJUcrS3zoon2kURDjrMGuMW0RdxyGFL0bMlE1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlkGZbNJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlkGZbNJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03148C2BCB4;
	Fri,  1 May 2026 19:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777664569;
	bh=NFmR8Ck4qnqYPJnuZo9Mrxhvadc7TlV0/juKC7CrRq4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=LlkGZbNJW7FSB8hRiULqff5KMYFkXdnUmshblKR1wBkEFGUkYOUMaM2IKBAunS5xn
	 brFUelmOoyXKj25R59wJdA4zRelW6D4SjbKS/7c941CfeVOuX19BMAA7MgRlOGwHI1
	 U6HcnxAue6Wb+E38WerpusN8UsvotZk4dWbfmnMXueN9pNpP60Bt+Sdr6+fbTsj7TH
	 wxnMI2ORRATvj+tiuUaiykjveC04fwpOsWx6Vh7/c3acw0rYtxh5PPl1JavO9EMj04
	 bVlSH/MUa6+ROWS/i9sxth5WoLjFN5jIX8aUE4DN8je+w4XCTMvMFG4NCFGkBfnuvh
	 U1y44Ho/pRqIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/4] perf symbol: Add setters for bitfields sharing a
 byte to avoid concurrent update issues
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260501182021.3651851-4-irogers@google.com>
References: <20260501182021.3651851-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 May 2026 19:42:47 +0000
Message-Id: <20260501194249.03148C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Data Race / UB on concurrent reads of bitfields
- [High] Architectural flaw and severe performance regression due to uncond=
itional global lock
- [High] Subsystem rule violation: Event handler completeness missing in bu=
iltin-sched.c
- [Medium] Unbalanced lifecycle and resource leak on error paths in symbol_=
_init()
--

commit eaf96d025426eab89c805716fc26dd2399ff6394
Author: Ian Rogers <irogers@google.com>

perf symbol: Add setters for bitfields sharing a byte to avoid concurrent u=
pdate issues

This commit introduces a global mutex to serialize modifications to bitfiel=
ds
within the symbol structure. Helper functions are provided to update these
fields safely across concurrent threads.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 555247568e7a6..655e95f660c2f 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c

This isn't a bug in the current changes, but while reviewing builtin-sched.=
c,
it appears the sched tool registers the .mmap handler but misses .mmap2.

When a subcommand registers .mmap but not .mmap2, modern kernels generating
mmap2 events will have those events silently dropped. Is it possible this l=
eaves
the machine vmlinux maps and process memory maps incomplete or null?

[ ... ]

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index fd332db561575..e6a1f23634ec3 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
[ ... ]
> @@ -345,6 +348,20 @@ void symbol__delete(struct symbol *sym)
>  	free(((void *)sym) - symbol_conf.priv_size);
>  }
> =20
> +void symbol__set_ignore(struct symbol *sym, bool ignore)
> +{
> +	mutex_lock(&symbol_bits_lock);
> +	sym->ignore =3D ignore;
> +	mutex_unlock(&symbol_bits_lock);
> +}

Are concurrent reads left unprotected by this implementation?

While the lock protects the read-modify-write cycle of the bitfield updates
here, existing readers access these fields without holding the lock.
For example:

builtin-sched.c:save_task_callchain() {
    ...
    if (sym->ignore)
        ...
}

Under the C11 memory model, reading a bitfield while another thread
concurrently modifies an adjacent bitfield in the same byte constitutes
a data race. Could this result in torn reads and undefined behavior?

Additionally, is a global lock necessary for these updates?

Unconditional acquisition of a global lock on hot paths like
timehist_save_callchain() and save_task_callchain() might cause a performan=
ce
regression, especially since it is acquired even if the flag is already tru=
e.

On 64-bit systems, struct symbol has 3 bytes of internal padding before
the dso pointer. Converting the bitfields to separate bool or u8 fields
would allow them to occupy this padding. This layout would ensure each field
resides in a separate byte, allowing hardware byte-level atomicity to
eliminate false sharing and the need for locking entirely.

[ ... ]
> @@ -2398,6 +2415,8 @@ int symbol__init(struct perf_env *env)
>  	if (symbol_conf.initialized)
>  		return 0;
> =20
> +	mutex_init(&symbol_bits_lock);
> +
>  	symbol_conf.priv_size =3D PERF_ALIGN(symbol_conf.priv_size, sizeof(u64)=
);

Could this skip destroying the mutex on error paths?

If setup_list() or other initializations fail later in symbol__init(),
the function returns -1 or jumps to error labels without calling
mutex_destroy(). If the caller retries initialization, calling mutex_init()
on an already-initialized mutex can result in undefined behavior.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260501182021.3651=
851-1-irogers@google.com?part=3D3
