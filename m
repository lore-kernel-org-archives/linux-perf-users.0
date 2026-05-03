Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A33A1D7E41
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 01:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777771115; cv=none; b=AkWUoAAywyURNNFOSpZ9MNbGa18XK1GrPQ4/VNz7tDaXTKdpoqAdSm3HDdwLz6eyAGRYxQZBqagQboozamnOQAX9RhxGaOzY5jodaDIX3bFQF/ehxlbBxDaIc6EkVwdsw44PzJ0eTT6GR1N+MeRu2okYklIXtaxj1tK+XMND4sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777771115; c=relaxed/simple;
	bh=JkP3Pl2fTHmrHT6M3bk+5KfgH8io+u/nb3hGyhDSIi0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o6Tei9qhpFKpnUa38Wg3r2duIJBC32auv1G3fM+rZbdXfwxYDWhKvVY4/jvnzLOLnteDjwenktOHokXxkD20ugukmOQ03A2x8hUCZtMpVScnOIuk372d3NC3PsSswshDQWtanL+FgUv9jWA/ARqtRoptGImzLRsB5yws1OeYk88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNe5ezOJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNe5ezOJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0082C19425;
	Sun,  3 May 2026 01:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777771114;
	bh=JkP3Pl2fTHmrHT6M3bk+5KfgH8io+u/nb3hGyhDSIi0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JNe5ezOJzplM4VKt3bmoeaql8ZjU1ESnl6uVqICvVwux84GIUJQXX5FmLBJCwhMrB
	 IIBLMn7m0imY/OZ7+ndhiMVQRfl7l6YatkApp7q+/KT4aAUKyjThKRJ8nik1cUIjC6
	 FsDJ8MeQvPqjLQynp3xvWz1Tc6pa3qxIOuM2eDld+W5K/RIVusfGXHfAkx8Hpekhd3
	 72XDjB8qQVBrdkNRbWQkMy6Og1rYM5BmEaQC55GiAJeq4QdpE8PYB6TcWvwM+AvUp2
	 KL+0N3D1yxXn5h6Zc7+10CLW4dgDn0mFQwtFTtBxu+K/z9Q1TUd8nvMGnOdvFBwvaG
	 gxn1EwqC9lBKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/6] perf libdw: Fix libdw API contract violations
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260503003552.1063540-4-irogers@google.com>
References: <20260503003552.1063540-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 01:18:34 +0000
Message-Id: <20260503011834.B0082C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Incomplete error handling makes the newly added `args.err` field=
 entirely dead code, silently swallowing inline unwinding memory errors.
- [Medium] The new bounds check `call_lineno > 0` incorrectly discards vali=
d DWARF line `0` references, leading to lost caller filenames.
- [Medium] The commit message falsely claims the patch prevents a `strdup(N=
ULL)` crash in `new_inline_sym`, justifying the change on an incorrect prem=
ise.
--

commit 5e576062601ce3a0337e76030c663f3ce42bdf61
Author: Ian Rogers <irogers@google.com>

perf libdw: Fix libdw API contract violations

This commit adds return value checks for several libdw API calls. It also
introduces an error field to propagate inline unwinding failures and
filters caller line numbers to avoid negative DWARF error codes.

> Check return values of dwfl_report_end and dwfl_module_addrdie.
> Validate dwarf_diename result before passing to new_inline_sym (avoid
> potential strdup(NULL) crash) and check die_get_call_lineno for
> errors.

This isn't a bug, but is the description of the crash risk accurate?
Looking at new_inline_sym(), it already guards against NULL pointers
by defaulting to a placeholder string:

static struct symbol *new_inline_sym(struct dso *dso,
                                     struct symbol *base_sym,
                                     const char *funcname)
{
        ...
        if (!funcname)
                funcname =3D "??";

It appears the patch changes the fallback string from "??" to "unknown"
but wouldn't actually prevent a crash since NULL is already handled nativel=
y.

> diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
> index 216977884103..e37f3b22699d 100644
> --- a/tools/perf/util/libdw.c
> +++ b/tools/perf/util/libdw.c

[ ... ]

> @@ -72,22 +76,27 @@ struct libdw_a2l_cb_args {
>  static int libdw_a2l_cb(Dwarf_Die *die, void *_args)
>  {
>  	struct libdw_a2l_cb_args *args  =3D _args;
> -	struct symbol *inline_sym =3D new_inline_sym(args->dso, args->sym, dwar=
f_diename(die));
> +	const char *name =3D dwarf_diename(die);
> +	struct symbol *inline_sym =3D new_inline_sym(args->dso, args->sym, name=
 ?: "unknown");
>  	const char *call_fname =3D die_get_call_file(die);
> +	int call_lineno =3D die_get_call_lineno(die);
>  	char *call_srcline =3D srcline__unknown;
>  	struct inline_list *ilist;
> =20
> -	if (!inline_sym)
> -		return -ENOMEM;
> +	if (!inline_sym) {
> +		args->err =3D -ENOMEM;
> +		return DWARF_CB_ABORT;
> +	}
> =20
>  	/* Assign caller information to the parent. */
> -	if (call_fname)
> -		call_srcline =3D srcline_from_fileline(call_fname, die_get_call_lineno=
(die));
> +	if (call_fname && call_lineno > 0)

Does this condition inadvertently drop valid DWARF line 0 references?

In the DWARF standard, line 0 is a valid identifier used for
compiler-generated code that lacks a specific source line, but the
associated file name remains valid. By requiring the line number to
be strictly greater than 0, it seems we might discard successfully
retrieved caller filenames for these entries.

> +		call_srcline =3D srcline_from_fileline(call_fname, call_lineno);
> =20
>  	list_for_each_entry(ilist, &args->node->val, list) {
>  		if (args->leaf_srcline =3D=3D ilist->srcline)

[ ... ]

> @@ -163,7 +172,8 @@ int libdw__addr2line(u64 addr, char **file, unsigned =
int *line_nr,
>  		};
> =20
>  		/* Walk from the parent down to the leaf. */
> -		cu_walk_functions_at(cudie, addr, libdw_a2l_cb, &args);
> +		if (cudie)
> +			cu_walk_functions_at(cudie, addr, libdw_a2l_cb, &args);
> =20
>  		if (!args.leaf_srcline_used)
>  			free(args.leaf_srcline);

Is there a missing check for args.err after this walk?

The callback libdw_a2l_cb() was updated to set args.err =3D -ENOMEM and
return DWARF_CB_ABORT on allocation failure. However,
cu_walk_functions_at() is called here without inspecting its return
value or args.err, and libdw__addr2line() eventually returns 1
(success) regardless.

This appears to leave args.err as dead code and silently swallows the
memory allocation error, returning a truncated inline callchain to
the caller.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503003552.1063=
540-1-irogers@google.com?part=3D3
