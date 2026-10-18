Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE0F342146
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 02:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792291530; cv=none; b=EPtcT/qe0flKFUwaUg8LFbC7w0jMg2LkRo01XBbyZn9Opy/3wbd2vspBg8ZL4zuQn/PCfhjNIu8dYrEwcobP5RqlIZ2cX16xkb4ZqgaCQ9xRxl81oO3C2G+OXPZL02LkCxjsK53rSd7Oc/KqQlmkMdBGJOyhYNFvNyT7vg8eg6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792291530; c=relaxed/simple;
	bh=dXTvM+w6KqSarfZQrcLL8O2O7+lfWE1VxG1SE7HXUFw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=aPJ9LTmMEOKWAyxIi1zRbJxfEwswCJAnTZObRfBcVCiCLJevzD3b4aRqMYFVSnK2Q9YtwQtkJhJj2TfRfa/6AbsTkb5y7cjDw/UBSd2PC1AAV4qz+jmq4omABCcPLSS0R64BiXgIrpZ0El+r9v4AE0FC62wnzep9huTfgxnmZas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEVJSCeM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEVJSCeM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7A81F000C4;
	Sun, 18 Oct 2026 02:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792291529;
	bh=dtCtAtEyCyFFQkErcP1+mrIKXR/vBcJVlf7pW2WIHTQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SEVJSCeMOPqsFDun8jLQlGZWE+n/fQIazosIeoZD2ly4PYruvV9L6RVL0N2eH5pnW
	 b413XTrkXIPt5fooNhE+w0wXo7gUIOwYfGYBeLFKGM7vqUSAuLShhn4Vq4OaO7G3XA
	 D5zFw3ns+fAON7KRZ9gBRgdcYjoaiNC03e6bTIhl1NpwUgX69o7sgTz8CiZcmmPlRO
	 c5aydaIP/Ldkef+PYIY5jqUHe3K9idzrs/Q6L1I+AeoTfedoNmVNwt6LHQtgISLwOg
	 1GC0MiEhwsoc8CrCVrbVYLzRIiGNsyqbHs0BnYn26Oz0DsfP+xiEh+z0yMpDwY0q3A
	 C73AdgPyjG5qA==
Message-ID: <sashiko-outbox-175888@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v8 3/6] perf symbol: Introduce
 vmlinux_path__find() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261018023753.584873-4-atomlin@atomlin.com>
References: <20261018023753.584873-1-atomlin@atomlin.com>
 <20261018023753.584873-4-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 02:45:28 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf symbol: heap overflow in vmlinux_path__init() after vmlinux=
_path__find()
--

commit 075bbaee1dd0bb499313531ce795ad3e9b4f107b
Author: Aaron Tomlin <atomlin@atomlin.com>

perf symbol: Introduce vmlinux_path__find() helper

This commit introduces vmlinux_path__find() to search through the configured
vmlinux_path entries (or symbol_conf.vmlinux_name if set) and return the pa=
th
to the first readable vmlinux file.

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index b61a574ce9a30..a0fc430be13ae 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -2372,6 +2372,36 @@ static int vmlinux_path__init(struct perf_env *env)
>  	return -1;
>  }
> =20
> +/**
> + * vmlinux_path__find - Locate the first accessible vmlinux file
> + *
> + * Check symbol_conf.vmlinux_name first if set, then search through the
> + * initialized paths in vmlinux_path.
> + *
> + * Return: A pointer to the path of the first readable vmlinux file, or =
NULL if
> + * none is accessible.
> + */
> +const char *vmlinux_path__find(void)
> +{
> +	int i;
> +
> +	if (symbol_conf.vmlinux_name && access(symbol_conf.vmlinux_name, R_OK) =
=3D=3D 0)
> +		return symbol_conf.vmlinux_name;
> +
> +	if (!vmlinux_path) {
> +		symbol_conf.try_vmlinux_path =3D true;
> +		if (vmlinux_path__init(NULL) < 0)
> +			return NULL;
> +	}

[Severity: Medium]
Can calling vmlinux_path__find() before symbol__init() cause
vmlinux_path__init() to overflow vmlinux_path[] and leak memory?

When vmlinux_path__find() is called prior to symbol__init(), vmlinux_path is
NULL and symbol_conf.initialized is false. vmlinux_path__find() sets
symbol_conf.try_vmlinux_path =3D true and calls vmlinux_path__init(NULL), w=
hich
allocates the 7-entry vmlinux_path array and populates it via
vmlinux_path__add(), advancing vmlinux_path__nr_entries to 7 (or 2 if
symbol_conf.symfs[0] !=3D 0):

tools/perf/util/symbol.c:vmlinux_path__add() {
	vmlinux_path[vmlinux_path__nr_entries] =3D strdup(new_entry);
	if (vmlinux_path[vmlinux_path__nr_entries] =3D=3D NULL)
		return -1;
	++vmlinux_path__nr_entries;

	return 0;
}

When symbol__init() is subsequently called, symbol_conf.initialized is still
false and symbol_conf.try_vmlinux_path is true, so symbol__init() invokes
vmlinux_path__init(env) a second time:

tools/perf/util/symbol.c:symbol__init() {
	...
	if (symbol_conf.try_vmlinux_path && vmlinux_path__init(env) < 0)
		return -1;
	...
}

Because vmlinux_path__init() neither frees an existing vmlinux_path nor
resets vmlinux_path__nr_entries to 0:

tools/perf/util/symbol.c:vmlinux_path__init() {
	...
	vmlinux_path =3D malloc(sizeof(char *) * (ARRAY_SIZE(vmlinux_paths) +
			      ARRAY_SIZE(vmlinux_paths_upd)));
	if (vmlinux_path =3D=3D NULL)
		return -1;

	for (i =3D 0; i < ARRAY_SIZE(vmlinux_paths); i++)
		if (vmlinux_path__add(vmlinux_paths[i]) < 0)
			goto out_fail;
	...
}

Doesn't the second call overwrite vmlinux_path with a new 7-entry buffer
(leaking the initial array and its strdup() strings) and then write the new
strdup() pointers starting at vmlinux_path[7] (or vmlinux_path[2]),
overflowing the heap buffer while leaving vmlinux_path[0..6] uninitialized
for dso__load_vmlinux_path() and vmlinux_path__exit()?

Additionally, if a caller invokes vmlinux_path__find() and skips
symbol__init(), symbol_conf.initialized remains false, so symbol__exit() wi=
ll
return early without calling vmlinux_path__exit() to free vmlinux_path:

tools/perf/util/symbol.c:symbol__exit() {
	if (!symbol_conf.initialized)
		return;
	...
	vmlinux_path__exit();
	...
}

> +
> +	for (i =3D 0; i < vmlinux_path__nr_entries; ++i) {
> +		if (access(vmlinux_path[i], R_OK) =3D=3D 0)
> +			return vmlinux_path[i];
> +	}
> +
> +	return NULL;
> +}

[ ... ]

>
> --=20
> 2.51.2
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018023753.5848=
73-1-atomlin@atomlin.com?part=3D3
