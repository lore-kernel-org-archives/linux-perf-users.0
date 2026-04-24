Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEF62BDC26
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052857; cv=none; b=DZy7HUCxHM24VGqfWUVErfk8Cdanual6h16tg4j0XfR3uySRZjde/bE25Te8pnbzFtExR40aatq3Vma6tsKVXiLl3EuWQ2VsX+DKeHVhhBr9nGIR3+QSYLN9+tcGUdGOx8Ncla+VOr1LIedMp1tjt2N8GDLEL6DE0jhbGrdRUvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052857; c=relaxed/simple;
	bh=aIRJiqM/ULw/j5cWbfRyR1NcjWyKNycINB4pdPt3t/I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qbE7GU7ufRImx6enwFEemVZtUSdNyqVWGh1a7yl30dObuGV1HcmVOFAmj5NvHYP2DujzqNIBfRMtfpgbf/mwT2VZoT3f3n9y5KMzDSfxFqN4QX49Pg1+b4nOlgAnOi9z0N01Z8mdlEpndWpiErnEXOn3qfUmpdf02LX7Az3X2hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cICG3EXJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cICG3EXJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817B7C19425;
	Fri, 24 Apr 2026 17:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777052856;
	bh=aIRJiqM/ULw/j5cWbfRyR1NcjWyKNycINB4pdPt3t/I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cICG3EXJf25B06/vAMLD1+TWpCEqHnNWAVFCvxDS+ExU08oe2brLRJxYf5LnCKMJS
	 agBSZyvV/1X/U+YgINtkcX4OiAF8fCfFYEa1hS3kU7PZjgojV7ggXUaxd5Xtld4Ru2
	 dNgzArAuTBvdMIddnQfQrpAihRclGqk1+xGbmt/5/DE84y3Tw5tplGsqCa/c6bWRNI
	 BqTaN+JOMJe6SZNP2YAJUL7ebs6QAHv3uj3nGHioJVGBFXm4eSPWHoer99Z9IcPn1k
	 NYdkfFluCq0AxX/AreQDU8Wk6hXN8DR1MaerDrePnkwPcq7sCCf6t31GKjxC26T9HY
	 XzH15whHwm9vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 53/58] perf: Remove libperl support, legacy Perl
 scripts and tests
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-54-irogers@google.com>
References: <20260424164721.2229025-54-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:47:35 +0000
Message-Id: <20260424174736.817B7C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Critical] A stack buffer overflow occurs in `check_ev_match()` when pars=
ing an event name from a script's `-record` file.
- [Critical] Improper size calculations and missing bounds checks lead to a=
n exploitable heap buffer overflow in `find_scripts()` when extracting scri=
pt names.
--

commit 573b39340e3ff8ff394b5f6ed03e2d363a352ad4
Author: Ian Rogers <irogers@google.com>

perf: Remove libperl support, legacy Perl scripts and tests

This commit removes embedded Perl interpreter support from perf, as all
legacy Perl scripts have been ported to Python or are no longer needed.
The changes include removing libperl feature detection, build rules,
and the scripts themselves.

[ ... ]

> diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/sc=
ripts.c
> index 1e8c2c2f952d42..27a099af2135e3 100644
> --- a/tools/perf/ui/browsers/scripts.c
> +++ b/tools/perf/ui/browsers/scripts.c
> @@ -200,14 +200,13 @@ static int find_scripts(char **scripts_array, char =
**scripts_path_array, int num
>  		if (!strcmp(lang_dirent->d_name, ".") || !strcmp(lang_dirent->d_name, =
".."))
>  			continue;
> =20
> -#ifndef HAVE_LIBPERL_SUPPORT
> -		if (strstr(lang_dirent->d_name, "perl"))
> -			continue;
> -#endif
> +
>  #ifndef HAVE_LIBPYTHON_SUPPORT
>  		if (strstr(lang_dirent->d_name, "python"))
>  			continue;
>  #endif
> +		if (strstr(lang_dirent->d_name, "perl"))
> +			continue;
> =20
>  		lang_dir_fd =3D openat(scripts_dir_fd, lang_dirent->d_name, O_DIRECTOR=
Y);
>  		if (lang_dir_fd =3D=3D -1)

These aren't regressions introduced by this patch, but while reviewing this
area I noticed two pre-existing issues nearby that could lead to buffer
overflows.

First, does the extraction of script names in find_scripts() have a bounds
checking issue?

The size passed to snprintf() is derived from the input filename's length
rather than the destination buffer's fixed size:

tools/perf/ui/browsers/scripts.c:find_scripts() {
    ...
		while ((script_dirent =3D readdir(lang_dir)) !=3D NULL) {
            ...
			temp =3D strchr(script_dirent->d_name, '.');
			snprintf(scripts_array[i],
				(temp - script_dirent->d_name) + 1,
				"%s", script_dirent->d_name);
    ...
}

If a script filename exceeds 127 characters, snprintf() will write past the
128-byte boundary of scripts_array[i] and overwrite the adjacent
scripts_path_array[i] buffer, leading to a heap buffer overflow.

Additionally, if the filename lacks a dot, temp evaluates to NULL, which
causes an integer underflow that disables snprintf()'s truncation entirely.

Second, does check_ev_match() overflow the event name buffer when parsing a
script's -record file?

The length of the event name is calculated and then directly passed to
snprintf() with a fixed 128-byte stack array:

tools/perf/ui/browsers/scripts.c:check_ev_match() {
    ...
		while (strlen(p)) {
            ...
			char evname[128];

			p =3D strstr(p, "-e");
            ...
			p +=3D 2;
			p =3D skip_spaces(p);
			len =3D strcspn(p, " \t");
            ...
			snprintf(evname, len + 1, "%s", p);
    ...
}

If the event name in the -record file exceeds 127 characters, snprintf() wi=
ll
write beyond the bounds of the array, resulting in a stack buffer overflow.
An attacker could exploit this by placing a maliciously crafted -record file
in the script directory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D53
