Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BEB150997
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 00:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775779910; cv=none; b=R6gW2y6NK29F8kZgDj5Y2Ck7cNFP5YJQDT0ARlhNh4taGiOQUboFCMo0ZHYWx22zDImfi/r0xIrdOpyU2Zg5vxrnL8bqD5tj6nZIzl4bi/6UUn+2f0z/Oo0PDe0mkODRyMB5CdTmu+K1eqp9vEzcntFoCaHJNrK95ACRD/0/SRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775779910; c=relaxed/simple;
	bh=y2jfLJktb+e+s/Ad982nXFwUMdIecgcIzz0a72U8m/w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uu+Y2gRsCpLPRmA7q9qFOxNva38r38/xnJgDnWog9xVCaiEZ5LoLpA+2KHmCnGwkWHBSZqYL2XQyIOEsw+wbpJialkO/qz5SD3ZJbOTNQK6A8gEDbDcAhq+j7Cst7KpwJXQ9riszwluQKZ1XK0FbCzVMZUQj0cYQ0c4/m3vfDxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJbwY4L1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJbwY4L1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC0CC4CEF7;
	Fri, 10 Apr 2026 00:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775779910;
	bh=y2jfLJktb+e+s/Ad982nXFwUMdIecgcIzz0a72U8m/w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=LJbwY4L1nmFLtSC4U3NijORID/dcxygVgpA7laU3nCcQiV67LCvhwloelyDK80d+3
	 6UHCysUb3nhmYdKRhn5PV+oVijAeHTdjwYNDqvAl58rLixpYsih9yQCHbWSoe/NXeW
	 QJBTKb9JdNoRRuZS5KEHHehGzB4nwFMKH784tZ0PlTDlh516r0AkOLdzk6LZgwFQgL
	 NdLU8l5DYmgXuHBJ/wUPhedsBuLSpGGQ5FvUCDTdW8f/zJ7IxclFtNkau9JOMnoHKG
	 +t4VVJi5pbxblI+xRRkoUJgFyMt5ctcX3F5ZC0EMZRDc38Sf0I4XmZcpsGPUhGq8Ye
	 TSyiiin1xzMuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/3] perf symbol: Lazily compute idle and use the
 perf_env
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260409230620.4176210-4-irogers@google.com>
References: <20260409230620.4176210-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Apr 2026 00:11:49 +0000
Message-Id: <20260410001149.DEC0CC4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Data race and undefined behavior due to unsynchronized bitfield up=
dates in `struct symbol`.
--

commit 2ee008011b6949869303359cb5ce16b0c47431af
Author: Ian Rogers <irogers@google.com>
Subject: perf symbol: Lazily compute idle and use the perf_env

This commit defers computing whether a symbol is an idle function to a lazy
evaluation using symbol__is_idle. It modifies struct symbol to cache this
lazily computed value using an idle:2 bitfield, checking architectural and
kernel versions using the perf_env.

Link: https://lore.kernel.org/lkml/20260219113850.354271-1-tmricht@linux.ib=
m.com/
Link: https://lore.kernel.org/lkml/20260323085255.98173-1-jameshongleiwang@=
126.com/

> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index bd6eb90c86683..7e0036f801858 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
[ ... ]
> @@ -58,8 +65,8 @@ struct symbol {
>  	u8		type:4;
>  	/** ELF binding type as defined for st_info. E.g. STB_WEAK or STB_GLOBA=
L. */
>  	u8		binding:4;
> -	/** Set true for kernel symbols of idle routines. */
> -	u8		idle:1;
> +	/** Cache for symbol__is_idle holding enum symbol_idle_kind values. */
> +	u8		idle:2;
>  	/** Resolvable but tools ignore it (e.g. idle routines). */
>  	u8		ignore:1;
>  	/** Symbol for an inlined function. */

Could this lazy update of the idle bitfield cause a data race?

Because idle is a bitfield sharing a byte with ignore, inlined, annotate2,
and ifunc_alias, writing to it performs a non-atomic read-modify-write on
the entire byte.

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index fd332db561575..482fd47bead24 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
[ ... ]
> +bool symbol__is_idle(struct symbol *sym, const struct dso *dso, struct p=
erf_env *env)
>  {
[ ... ]
> +	if (bsearch(name, idle_symbols, ARRAY_SIZE(idle_symbols),
> +		    sizeof(idle_symbols[0]), sym_name_cmp)) {
> +		sym->idle =3D SYMBOL_IDLE__IDLE;
> +		return true;
> +	}

In perf top, sample processing runs continuously in a background thread,
calling symbol__is_idle() and writing to sym->idle:

Thread 1 (Sample processing):
    sym->idle =3D SYMBOL_IDLE__IDLE;

Concurrently, the TUI thread processes user interactions and can set flags
like annotate2:

Thread 2 (TUI / User Interaction):
    sym->annotate2 =3D 1;

If these threads access the same symbol simultaneously, could one thread's
write overwrite the other's modifications, silently corrupting the symbol
state and causing features like UI annotation to break?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260409230620.4176=
210-1-irogers@google.com?part=3D3
