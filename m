Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779CA393DE2
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 21:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778622842; cv=none; b=TybSVC9nnSBt5jpInXOX70MjmYhjdJfl4GjG6SDgj54FMdXUm7ISnJkh/TW1fHBuFRt9BkxOrGJXiYr1DmSs+F2iEJw2uO3nljiMwLpRM0b44IOkE+J1ObmmAYhMjkurqbqa2Y2BQ4KGK8jx0UEwc0nc0y5ICoB/Q4sVi9/eo2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778622842; c=relaxed/simple;
	bh=zYAnn2DwIBa/ERzhdLEC0sflLe1f9Dt14Zg6x50Sswg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=at74FMOINwfsBcgnVg2tEpcQCpdzG/fW46UD25Vwk9ve/Qauiysw/go5FGA96LsBt8ym5iR9iYZZUC2PLxFz+EdLew/MWCzkn+3iSQbZve3I3muxaDJiemyXECWBomsZx5XdXa1Gpj35gKDSc7TtUWTHVK2iHC223Kh2WJnNaMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjJiQaDt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjJiQaDt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFE5C2BCB0;
	Tue, 12 May 2026 21:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778622842;
	bh=zYAnn2DwIBa/ERzhdLEC0sflLe1f9Dt14Zg6x50Sswg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=LjJiQaDtwtBJx9sWrElpHw4Igktqr1Pd1sYq/rPrgnhpHO2MZVKQSpbhCUyJplMRZ
	 Ifn22IQqXSDJOMrGBbb5cXXPvQ1EujJNoDGmCx73nsRdF+b/rPnRGYqb3wbKlpGEJd
	 2WguwZmllg2MpylU10cDLQQVaOmCta2YNQ5xk0fVs+f7yxfEc4s4iQYOIgyNHLXhg+
	 jUm26hM8Oxqdu45AZ765HsiaaWuofWp9anv3TdEr/+uSnHLN0aO4VgoT/6XeqTV18N
	 gLvDzPmduv0nGGWHQsqeD9IHlOThoprRKaiXB0KKYH3cGnVaw0dKwukFk9O/2hNtVU
	 6NEQruKDIWqiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/7] perf trace: Add beautifier script for fsmount
 flags
Reply-To: sashiko@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260510202346.49853-7-namhyung@kernel.org>
References: <20260510202346.49853-7-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 21:54:01 +0000
Message-Id: <20260512215402.0CFE5C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] NULL pointer dereference when parsing string filters for the `fs=
mount` syscall flags in `perf trace`.
--

commit f130ece1ce49e8a473ebf43d62d18d2a42d44946
Author: Namhyung Kim <namhyung@kernel.org>

perf trace: Add beautifier script for fsmount flags

This commit introduces a beautifier script to generate fsmount_flags[] from
mount.h, moving the existing array to fsmount_attr.sh.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
[ ... ]
> @@ -1202,7 +1197,9 @@ static const struct syscall_fmt syscall_fmts[] =3D {
>  	{ .name     =3D "fsconfig",
>  	  .arg =3D { [1] =3D STRARRAY(cmd, fsconfig_cmds), }, },
>  	{ .name     =3D "fsmount",
> -	  .arg =3D { [1] =3D STRARRAY_FLAGS(flags, fsmount_flags),
> +	  .arg =3D { [1] =3D { .scnprintf =3D SCA_FSMOUNT_FLAGS, /* fsmount_fla=
gs */
> +			   .strtoul   =3D STUL_STRARRAYS,
> +			   .show_zero =3D true, },

Could this cause a NULL pointer dereference when parsing string filters?

Because .parm is omitted here, it defaults to NULL. If a user runs a trace
command with a string filter like perf trace -e 'fsmount(flags=3D=3DCLOEXEC=
)',
the STUL_STRARRAYS parser will pass this NULL .parm to strarrays__strtoul(),
which will unconditionally dereference sas->nr_entries.

Also, does STUL_STRARRAYS expect a struct strarrays rather than a struct
strarray? Since fsmount flags are bitmasks, should this use
STUL_STRARRAY_FLAGS along with an exported strarray instead?

>  		   [2] =3D { .scnprintf =3D SCA_FSMOUNT_ATTR_FLAGS, /* attr_flags */ }=
, }, },
>  	{ .name     =3D "fspick",
>  	  .arg =3D { [0] =3D { .scnprintf =3D SCA_FDAT,	  /* dfd */ },

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260510202346.4985=
3-1-namhyung@kernel.org?part=3D6
