Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B28431BCAE
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 03:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783652998; cv=none; b=Vv0sY84KioPfCppKV7AAmFVaKuaHueY1aTwpiDkF4wQqmga+lxFXhCts+aHzdZrPKGqdDZP3io+VTpS6IzoGR6swHzG6d3RFFyoELfUdXS5/uw58LK6TT0Hr7/CgHyX5PCHiBAX4ZicXyB5CcOd0RxSR7IySSndpuv757eMKMtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783652998; c=relaxed/simple;
	bh=X3vfG/P15QOJLnrnV/453Q/srtko3AbJ11VAuLeem2o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TJ9esZSaU11GdzfSZeJK371dKpZ/X4DOme0oliLDnDkcNc2k5ClI6rLlydU24VCnbI8l8rrBU+syjnZhTvZ6TY6j0l9GaJNS4rVuaEHK/7pVywywFI2A20NJS5dQQC3ZAKZCOaAMlVzrmlaJh3N8BgwRbH05C4ZWiqUzbpWXQ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzGsX3Jv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzGsX3Jv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024021F000E9;
	Fri, 10 Jul 2026 03:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783652997;
	bh=WdNfvH3wgS6K5wnjtgBs9esRJ7wstc0rxDtNpqYobkM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bzGsX3JvcB0C4saTkS3ocrWpMen7jWSzGJdgktNppqIZn9/SXnq9oB/6ZGqy7y8An
	 dnCvM5bUDokYm5qYIZgwiMIy5rCZfMdHFLp8Mb8jNA6DS5fjEqB8WPkY1k41AKdmDo
	 psvv+OgPX98g+AQniqbm40deT0Gk9E95qFz8e9IoB+jNergRmg5bVpAA+YpKQ9DKfz
	 Fx6dCDh34Ij/lklsZscPombC0q5CaezX06DuyGrwYCl5hA95N1xBByCIhAcKJ5iWpp
	 kVNSyNBQwOJsMxCpOzoi+YzDf50Srzj628lQDaIGPvuH+k4oiN2gpzB+2lE7uEydFa
	 V5GYQMoyDkKYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 8/9] perf ui hists: Remove duplicated thread in
 popup_action
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260710024952.1668911-8-irogers@google.com>
References: <20260709165220.1411149-1-irogers@google.com>
 <20260710024952.1668911-1-irogers@google.com>
 <20260710024952.1668911-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 03:09:56 +0000
Message-Id: <20260710030957.024021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Low] Missing `<limits.h>` inclusion causes a musl libc build failure due=
 to `PATH_MAX` usage.
--

--- Patch [8]: [PATCH v4 8/9] perf ui hists: Remove duplicated thread in po=
pup_action ---
commit cf81872962e43b7c33b75762f7881111734c277c
Author: Ian Rogers <irogers@google.com>

perf ui hists: Remove duplicated thread in popup_action

struct popup_action has a thread but this is duplicated in the
map_symbol. Remove the non-map_symbol version so that there's only ever
1 thread with a popup_action.

> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> index d61ebe4f6a6a4..0713e3ddcf1f0 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -2455,7 +2455,6 @@ static int switch_data_file(void)

[Severity: Low]
This isn't a bug introduced by this patch, but should limits.h be explicitly
included at the top of tools/perf/ui/browsers/hists.c?

Looking at switch_data_file(), it uses the POSIX constant PATH_MAX:

static int switch_data_file(void)
{
        char path[PATH_MAX];
        ...

Does omitting the explicit inclusion of limits.h cause build failures on mu=
sl
libc systems, which do not implicitly include headers in the same way glibc
does?

> =20
>  struct popup_action {
>  	unsigned long		time;
> -	struct thread 		*thread;
>  	int (*fn)(struct hist_browser *browser, struct popup_action *act);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710024952.1668=
911-1-irogers@google.com?part=3D8
