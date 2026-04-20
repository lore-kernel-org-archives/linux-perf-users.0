Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F2C212D7C
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 23:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776729310; cv=none; b=BlnKJHmQkBf/ZaBf+6Fj6Xyv9qiXEeYHoLAQz0GXdaP8jdNbbcOf0W7HKj76JzEItnibk19T2IuxDV8xh/KpE6EIBUrmz2u8UjXgxU2dYDhopTtslVsiUwDJDva6hKNpnzSwm0dhwe0qSf77RFl62VuePbCzxko8FFk6xRL872c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776729310; c=relaxed/simple;
	bh=VzEQZCoCQPNbs4nT0sS1llVNPtMpmdE5YzSXSXdwmxU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C1L3wGoVbAFF+XNiF+n0DZdf9etLmbJSOfGhcrROkERDCydFOiqVQBDTuIRFtNIDhTNNl1/GD8KFrw4XgRBd1T1ZqIdct5nCXlBpf/++GkPQhfEcX55AH/hX3nkpCOFr4zaonOoQoZ3ksO03ApNdJvpuJlHhoKm9qPRDyg9GnbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqnihT4N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqnihT4N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBF2C19425;
	Mon, 20 Apr 2026 23:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776729310;
	bh=VzEQZCoCQPNbs4nT0sS1llVNPtMpmdE5YzSXSXdwmxU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=oqnihT4N4ZuXZZKMLk7rROdunpEDsXgE0nYmEEwrai1Mr/u7jo0BUmjJHUx1mXZDh
	 srciR/oL35TUFI+AejzCJk0S3FJEPsNGyDsuhOpwJn9kRpylt/6tFZdUbd0/uDRBoF
	 8E8MtYySG5WRkmiq/3QRIxMgUgM+fwyUncdOrAHBTYdoIwI+jX8vBnqsnHzJtqgerc
	 CBQpq4TOFCt2IqDFaKgwfwx2XNGF9+a8XEHS3CCobcdGcYJ05RiUeyzMxttz3ujW/L
	 hSD6JAx4K3VdugtpC5oBtuVWzUsyeBV28TFESqKyyMwt6YuJP6VqamSPX02mNzDOFX
	 mluImy9jf8l3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y] Revert "perf unwind-libdw: Fix invalid reference
 counts"
Reply-To: sashiko@lists.linux.dev
To: "Kenta Akagi" <k@mgml.me>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260420163222.23517-1-k@mgml.me>
References: <20260420163222.23517-1-k@mgml.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 23:55:09 +0000
Message-Id: <20260420235510.4EBF2C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Reverting a valid bug fix to resolve a backport build failure re=
introduces a use-after-free vulnerability in perf's libdw unwinder.
--

commit 476f57f8f24801b0104204e756b3e024069b04e7
Author: Kenta Akagi <k@mgml.me>

Revert "perf unwind-libdw: Fix invalid reference counts"

This commit reverts a backport to resolve a build failure in v6.6.y caused
by the absence of map_symbol__exit().

> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libd=
w.c
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
> @@ -133,8 +133,8 @@ static int entry(u64 ip, struct unwind_info *ui)
>  	}
> =20
>  	e->ip	  =3D ip;
> -	e->ms.maps =3D maps__get(al.maps);
> -	e->ms.map =3D map__get(al.map);
> +	e->ms.maps =3D al.maps;
> +	e->ms.map =3D al.map;
>  	e->ms.sym =3D al.sym;
> =20
>  	pr_debug("unwind: %s:ip =3D 0x%" PRIx64 " (0x%" PRIx64 ")\n",

Does removing these reference increments reintroduce a use-after-free
regression?

Directly after these assignments, entry() calls addr_location__exit():

tools/perf/util/unwind-libdw.c:entry() {
        ...
        addr_location__exit(&al);
        return 0;
}

This drops the references held by al. If these were the last references,
the map and maps objects will be freed.=20

The e->ms.maps and e->ms.map pointers are later accessed in
unwind__get_entries() when it invokes the callback, potentially using
memory that has already been freed:

tools/perf/util/unwind-libdw.c:unwind__get_entries() {
        ...
        err =3D ui->entries[j].ip ? ui->cb(&ui->entries[j], ui->arg) : 0;
        ...
}

[ ... ]

> @@ -319,9 +319,6 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *a=
rg,
>  	if (err)
>  		pr_debug("unwind: failed with '%s'\n", dwfl_errmsg(-1));
> =20
> -	for (i =3D 0; i < ui->idx; i++)
> -		map_symbol__exit(&ui->entries[i].ms);
> -
>  	dwfl_end(ui->dwfl);
>  	free(ui);
>  	return 0;

Instead of reverting the fix entirely because map_symbol__exit() is absent =
in
v6.6.y, would it be safer to retain the map__get() and maps__get() calls in
entry() and replace this loop with manual decrements using map__zput() and
maps__zput() here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420163222.2351=
7-1-k@mgml.me?part=3D1
