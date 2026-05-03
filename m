Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906531E1024
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777830042; cv=none; b=VeDR7fDbhf0Z1Stm7cMNJqQ3FqBWoDfjujnVneSt1Hjvq/IAdEVpsVU48zFaqHP0XhgRkYCXF1/dpuD9i/yTfEeaqB9eG0vavH0ZeeszPuX6S4Eh2lhMUuwds2cMVo9YrSSqmXoB2oZ2FFp2EPPA9PB1qHBhd2o006VpElOFqTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777830042; c=relaxed/simple;
	bh=kFfF5848dhTO9M352Sa3fp1ywfHuYy3YvVh4/1ACt6A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NyEFn9xZSObJU//bsxx3loqoJ6Jcb6HPEILMJ3xGjDPaNduWltqy/DrB/xk7LtiR6onstvWNkTe0rbI0gwWs3coC0hpwfLIgUnezgVhTnYimwSHh2HrP0HSsQ5SxIRuX22JPw6JFPa0/HF3Qbc1pK+TP+fh2m2jRAn+AlWdTFAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d58sRvBj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d58sRvBj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5A1C2BCB4;
	Sun,  3 May 2026 17:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777830042;
	bh=kFfF5848dhTO9M352Sa3fp1ywfHuYy3YvVh4/1ACt6A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=d58sRvBjTtyr+xMKBL2GRIHNQo8dbfLysjRqHqPBzuIQN87Cp8H09rXmYFkG6ek1E
	 JjrPYa/xhxQ5tZxhAw6L6/vYY4ChuNnjsOIUmwZDCgfmNJi/J0vFfxkoPTmS/ygPvN
	 n7EWXJV5mRQ/nkFsrHPZeum6bccv7nLO8UBhjs8ypEO+0952Ufe1SWe5VbkFOyFwnu
	 xUkS1SBehzUGbBjlZL8RGItaaZ3D/xs+D/TMP1ky6tZDSmfG952fUt3teWxSkQ7p7O
	 Z07t/5uX8IDjYy0C/pwDSWW93j6I2cVKxEtQdhR+HbMiPhH/RPl5xfoMYCuT9KaWYH
	 EQ6Tzu2sFjaTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/6] perf dwarf-aux: Fix libdw API contract
 violations
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260503171032.1559338-3-irogers@google.com>
References: <20260503171032.1559338-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 17:40:41 +0000
Message-Id: <20260503174042.1D5A1C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The fix for uninitialized stack variables in `die_walk_lines` un=
conditionally filters out inline functions that lack a declaration line, br=
eaking line walking for such functions.
--

commit d271d4f48f3254386be3ea2c703448a90d59f608
Author: Ian Rogers <irogers@google.com>

perf dwarf-aux: Fix libdw API contract violations

This commit adds return value checks for several libdw API functions like
dwarf_decl_line(), dwarf_getfuncs(), and dwarf_lineaddr() to prevent using
uninitialized stack variables. It gracefully handles optional dwarf_decl_li=
ne()
calls for the root DIE, adds NULL pointer protection for strcmp(), and uses
dwarf_attr_integrate() for member locations.

> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 109a166a6d19..a8ab1c30d0ac 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c

[ ... ]

> @@ -998,12 +993,11 @@ int die_walk_lines(Dwarf_Die *rt_die, line_walk_cal=
lback_t callback, void *data)
>  			if (die_find_inlinefunc(rt_die, addr, &die_mem)) {
>  				/* Call-site check */
>  				inf =3D die_get_call_file(&die_mem);
> -				if ((inf && !strcmp(inf, decf)) &&
> +				if ((inf =3D=3D decf || (inf && decf && !strcmp(inf, decf))) &&
>  				    die_get_call_lineno(&die_mem) =3D=3D lineno)
>  					goto found;
> =20
> -				dwarf_decl_line(&die_mem, &inl);
> -				if (inl !=3D decl ||
> +				if (dwarf_decl_line(&die_mem, &inl) !=3D 0 || inl !=3D decl ||
>  				    decf !=3D die_get_decl_file(&die_mem))
>  					continue;
>  			}

If the root function lacks a declaration line, could this strict check caus=
e us
to skip valid matching lines from inline instances?

The commit message notes that dwarf_decl_line() is optional for the root DIE
and its failures are handled gracefully. This leaves decl =3D 0 if the
declaration line is missing.

However, if the root function lacks a declaration line, its inline instances
will also lack one. When dwarf_decl_line(&die_mem, &inl) fails here, it now
evaluates to non-zero and forcefully continues the loop.

Should inl be safely defaulted to 0 on failure here to match the graceful
handling of the root DIE, rather than aborting the match entirely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503171032.1559=
338-1-irogers@google.com?part=3D2
