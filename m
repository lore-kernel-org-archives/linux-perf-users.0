Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490281F91D6
	for <linux-perf-users@vger.kernel.org>; Sat,  2 May 2026 07:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777708520; cv=none; b=rZV8s+XnY5AU4H9LJEwx5Y2WuDfmBxshVFGfmn78ujVw9QHvMLPbQ5X7kxs45ymfqtXnTA0js+L/QKQV39RwOpgU/QiumZQA6uf/NPRqhxbbdkjo2zpvAdxQY+kGAqvigII2feyS3Rj5Y5ZiygxTPsO1kFOztmXu2zHQAydyCDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777708520; c=relaxed/simple;
	bh=qTCsy7Ad4BcuRYaS+8/seGd+5w73tWGmiboX/U0GThE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O3TMsESiBAUYpafVcIROFaHzAoUkjgMIITH8PKLHS2u+/tB93J5hbI1IgRojZYDCvSpNsbi3ooSWxUo561aGozG8wlbPIA6EkP+A/9+doKx75bufe/Ol5EmZgsQEcpOPlkeAskepz1KzQ6nYPiTJtzsb5vKH0ZEHf+TRNZ0IlMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKZx/Pld; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKZx/Pld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC583C19425;
	Sat,  2 May 2026 07:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777708519;
	bh=qTCsy7Ad4BcuRYaS+8/seGd+5w73tWGmiboX/U0GThE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=eKZx/Pld89A6xdURalW3Wq9GHZOuoE70so/tkcyLC1Wcuzr2l6HNM0lD0QX4Kn9w8
	 bl27GrWwqi4YkAiYVlo1kAclxCq3t716cn1lodVkDtXXjaoeq5j1dhA3S2tUrWGOE7
	 kKJVh0HE1T9+zaK7DmHe9Q6RyalWjwwR4xAUX2ZdXgpHOXoLNbfE8/G6PaE7+JNrqm
	 xc9EUCopbNe8kTZestsLVwl2AJpjhmI2eD+M+fWk+DkVG4TRSm8sQKcPS2IUQaSqt9
	 kj63XoO0chl1JK6/iJZWnEpnhB/iGT9j0xcffciSg2ks45ZrwuGMknK4FPBUCKclYZ
	 +E/zo+KtTqVdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 16/17] perf symbol: Add setters for bitfields sharing
 a byte to avoid concurrent update issues
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260502065935.291960-17-irogers@google.com>
References: <20260502065935.291960-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 02 May 2026 07:55:19 +0000
Message-Id: <20260502075519.CC583C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Unconditional acquisition of a global mutex in high-frequency per-=
sample fast paths causes severe performance regression.
- [High] Unlocked reads of bitfields concurrent with locked writes cause da=
ta races and undefined behavior.
- [Medium] The `symbol_bits_lock` mutex is leaked and potentially re-initia=
lized if `symbol__init()` fails.
--

commit 587302f6555ca9ddcc54f4761c10004005eaa78f
Author: Ian Rogers <irogers@google.com>

perf symbol: Add setters for bitfields sharing a byte to avoid concurrent u=
pdate issues

This commit introduces a global symbol_bits_lock and helper functions
to serialize updates to the ignore and annotate2 bitfields in struct symbol.
This aims to prevent lost updates caused by concurrent modifications to
bitfields sharing the same byte.

> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> index 9d3a4c779a41..7337ee956dc9 100644
> --- a/tools/perf/builtin-kwork.c
> +++ b/tools/perf/builtin-kwork.c
[ ... ]
> @@ -725,7 +725,7 @@ static void timehist_save_callchain(struct perf_kwork=
 *kwork,
>  		if (sym) {
>  			if (!strcmp(sym->name, "__softirqentry_text_start") ||
>  			    !strcmp(sym->name, "__do_softirq"))
> -				sym->ignore =3D 1;
> +				symbol__set_ignore(sym, true);
>  		}
> =20
>  		callchain_cursor_advance(cursor);

Since timehist_save_callchain is a per-sample fast path that can be called
millions of times per run, could this unconditional acquisition of a global
mutex cause severe lock contention and performance regression?

Would it be better to add a lockless check like if (!sym->ignore) to bypass
the lock once the flag is already set?

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 555247568e7a..655e95f660c2 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
[ ... ]
> @@ -2371,7 +2371,7 @@ static void save_task_callchain(struct perf_sched *=
sched,
>  			if (!strcmp(sym->name, "schedule") ||
>  			    !strcmp(sym->name, "__schedule") ||
>  			    !strcmp(sym->name, "preempt_schedule"))
> -				sym->ignore =3D 1;
> +				symbol__set_ignore(sym, true);
>  		}

Could the same fast-path lock contention happen here during
save_task_callchain?

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index a70066d17729..1238a0d6ce6e 100644
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
> +
> +void symbol__set_annotate2(struct symbol *sym, bool annotate2)
> +{
> +	mutex_lock(&symbol_bits_lock);
> +	sym->annotate2 =3D annotate2;
> +	mutex_unlock(&symbol_bits_lock);
> +}

While the new symbol_bits_lock serializes writes to these bitfields, readers
of sym->ignore and sym->annotate2 remain unlocked throughout the codebase.

In C, adjacent bitfields share the same underlying memory location. Under t=
he
C11 memory model, does reading a bitfield without synchronization while ano=
ther
thread performs a read-modify-write on that same memory location constitute=
 a
data race?

Could this lead to torn reads or undefined behavior during concurrent acces=
s?

> @@ -2415,6 +2432,8 @@ int symbol__init(struct perf_env *env)
>  	if (symbol_conf.initialized)
>  		return 0;
> =20
> +	mutex_init(&symbol_bits_lock);
> +
>  	symbol_conf.priv_size =3D PERF_ALIGN(symbol_conf.priv_size, sizeof(u64)=
);
> =20
>  	symbol__elf_init();

If a subsequent initialization step fails, like setup_parallelism_bitmap,
this function returns -1 without calling mutex_destroy on the error paths.

Because symbol_conf.initialized remains false, a subsequent call to
symbol__exit will also return early and fail to clean the mutex up.

Additionally, if a caller attempts to retry symbol__init after a failure,
could this cause mutex_init to be invoked on an already-initialized mutex?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260502065935.2919=
60-1-irogers@google.com?part=3D16
