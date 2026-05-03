Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829E219004A
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 01:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777770172; cv=none; b=KL//iXmjCfDz3FjizVxV2CdQWLIlzndkmzxfASqC+EnjXvUaoLqaOMBIvx//23Ovmz8UorptePeqkUiTqtt6nCZ2cWEgcHzIw0q0qY2MYWkiuH/j89TJcXGEG2J5f+fmX9kCt0Yt/xOCfbzGU9X0MEFmqIUYAKpn19FqL7Zs7aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777770172; c=relaxed/simple;
	bh=eCN+r5kHSSwWMK10sXfZGO47/aVV8qG2yq4Nole7Y1k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N8zJfWYPlV11T3dN5CKdM65yXCAjOv+eaVpEmBXO/omc7zWXQYi3Vtm6sUYVNxv/9kO0VWXKxKOtJbadLCCnsJpMcQC7KLFUxVEKr8B1mgCYUvm6JNzqIKMjQQRSGF63ZD0Ht4RvZT5aHERSOuQqgYIH6VH0IFbfzPG1Pq/5jwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4wZr+tS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4wZr+tS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050CBC19425;
	Sun,  3 May 2026 01:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777770172;
	bh=eCN+r5kHSSwWMK10sXfZGO47/aVV8qG2yq4Nole7Y1k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=A4wZr+tSqrjWXAqXnU8FbhlooFRxfpa0XkMIgXZ2myWBFTJmfEgQyPeB+4gUOLZso
	 F0l7DEhUrpAEC+6yChnXCNTj3a5rbBsEFnS5+xGnRVM2sol3K55WMUuMzgnzyTieeI
	 +BHc2y0MI5skiQ1sci9WNcMvI8EDZlZezWq1R6xg+PhvGvLqhYy6SaFHSNuY4cFuXS
	 H02biB304UTKMmkiLGrgT6oFFDIjjtJtJaQzpaQWRwe3Yq7oCCpTzaRdjd584m4cQS
	 3WAvr7btm9+ahjJtLLvALdIxT8CNLAXY2poCLFlStqKuS0DpkA2Jpk6mWI0s/C9syN
	 nd6hroLy1OsAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/6] perf dwarf-aux: Fix libdw API contract
 violations
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260503003552.1063540-3-irogers@google.com>
References: <20260503003552.1063540-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 01:02:51 +0000
Message-Id: <20260503010252.050CBC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Returning `-EINVAL` when `dwarf_decl_line` fails for the root DI=
E breaks line walking for valid functions.
--

commit c967da2fa8dfee2321c45ab4e1d42344eca760b5
Author: Ian Rogers <irogers@google.com>

perf dwarf-aux: Fix libdw API contract violations

This commit adds return value checks to dwarf_decl_line, dwarf_getfuncs,
and dwarf_lineaddr across dwarf-aux.c. It aims to prevent the use of
uninitialized stack variables or incorrectly reporting success on failure.

> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 8e83cb2d565e..1168e69a9292 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
[ ... ]
> @@ -949,7 +949,11 @@ int die_walk_lines(Dwarf_Die *rt_die, line_walk_call=
back_t callback, void *data)
>  	/* Get the CU die */
>  	if (dwarf_tag(rt_die) !=3D DW_TAG_compile_unit) {
>  		cu_die =3D dwarf_diecu(rt_die, &die_mem, NULL, NULL);
> -		dwarf_decl_line(rt_die, &decl);
> +		if (dwarf_decl_line(rt_die, &decl) !=3D 0) {
> +			pr_debug2("Failed to get the declared line number of %s\n",
> +				  dwarf_diename(rt_die));
> +			return -EINVAL;
> +		}

Does returning -EINVAL here break line walking for valid functions that
omit the declaration line attribute?

DWARF attributes like DW_AT_decl_line and DW_AT_decl_file are optional and
frequently omitted by compilers for assembly functions, artificial function=
s,
or compiler-generated thunks.

Before this change, if dwarf_decl_line() failed, decl remained 0 and
the function continued gracefully. Aborting with -EINVAL might prevent
tools like perf probe from working on valid functions.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503003552.1063=
540-1-irogers@google.com?part=3D2
