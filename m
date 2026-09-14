Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396A9282F21
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 01:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789350632; cv=none; b=b1haPMBAUUJ7TAYISgPDEz2KT5PKlmTbKSyP8QewVAxT27ZUVVN2j9GVRHTGj1s4JmlBiW5b8zszbslwqjOlQyW3xcb5Zx6R5sdDb1Me9/UwGSM78P+QTyfjCX0mH/KnxP+57zOOmKaqAEhUbQwY5DF2MnSloNIEdAOSShB2PyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789350632; c=relaxed/simple;
	bh=2js5g3Nov7LaiGm+R0OUaHhZrtKVLTUYUBRj0oAbvdA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B6jQSWLso16VZqDN31GjBb88drKWqDdCJN1yLrtUi07ZRugudrE/SD9fCkHnqWRFfsdsh50AqShD3JP5ZU4BS1pD52MEBeYpnUIkIMQku37BwitLJuql/ebPQ9OXC+KwKdyHqFmmoCcGv6gv7u2DD+wgZiw2IwlO1ZJ/IsZUoNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGPp7/Fs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGPp7/Fs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421C21F000FF;
	Mon, 14 Sep 2026 01:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789350628;
	bh=nMyUygovBwqtz70APCqKQbF2b0EdlAhEd2I3zXm2z9c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NGPp7/FsA9SOBuRgBicBovxAyhDZKRkTr5YH1/pFuEXnhkGkLCeJDdBaw2m16pJhe
	 kSNljO5EOeYwQ+kxWIzavdrokiR81LmcmCTNvsI/B/dGz+hPFV+UUf1nkDfa7a+POM
	 Z53tRyrVj337SCu9msPdPewblNBpqemiFMCyL651ouf/DHr5iFheihYoZ+C/Hfrj1D
	 MOSL5Zeh7jXZe/HmL69WP1LtYh7LVjSMb15dGNjIO975ca6UfO7ikOrLxAO5u//ZUg
	 D9zO2m9TEQpMn+cibwVCbgzYcy6IhqwL8x9UM6S8mMFoJPCD625NJxliv9Nox5d+ej
	 tcRwZdhQgN9XA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/8] perf debuginfo: Fetch debuginfo keyed by build ID
 using debuginfod
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914013604.7702-3-acme@kernel.org>
References: <20260914013604.7702-1-acme@kernel.org>
 <20260914013604.7702-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 01:50:27 +0000
Message-Id: <20260914015028.421C21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] debuginfod__setup_urls_env() becomes a silent no-op stub when co=
mpiled with NO_LIBDW=3D1, breaking the intended debuginfod URL fallback mec=
hanism.
--

commit e2a1e9e2802762d033ca68499fb299a119d39468
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf debuginfo: Fetch debuginfo keyed by build ID using debuginfod

This commit adds the ability to fetch debuginfo files by build ID via the
debuginfod client. It also introduces a fallback helper to set up server=20
URLs from /etc/debuginfod when DEBUGINFOD_URLS isn't natively exported.

[ ... ]

> diff --git a/tools/perf/util/debuginfo.h b/tools/perf/util/debuginfo.h
> index a52d69932815c..1b301a9cc75b6 100644
> --- a/tools/perf/util/debuginfo.h
> +++ b/tools/perf/util/debuginfo.h
> @@ -54,13 +56,62 @@
>  #ifdef HAVE_DEBUGINFOD_SUPPORT
>  int get_source_from_debuginfod(const char *raw_path, const char *sbuild_=
id,
>  			       char **new_path);
> +
> +/*
> + * Finding a debuginfo file keyed by build ID uses the debuginfod client,
> + * but opening the DWARF in it needs libdw, i.e. these live in
> + * debuginfo.o, which is only built with CONFIG_LIBDW.
> + */
> +#ifdef HAVE_LIBDW_SUPPORT
> +/*
> + * Populate DEBUGINFOD_URLS from the .urls files in /etc/debuginfod when=
 it
> + * isn't set, called from symbol__init(), i.e. before any thread that can
> + * call getenv() exists: setenv() is not thread safe.
> + */
> +void debuginfod__setup_urls_env(void);
> +
> +int debuginfo__find_build_id(const struct build_id *bid, char **path);
> +struct debuginfo *debuginfo__new_build_id(const struct build_id *bid);
> +#else
> +static inline void debuginfod__setup_urls_env(void)
> +{
> +}

[Severity: Medium]
Does this code silently break the debuginfod URL fallback when perf is=20
compiled with NO_LIBDW=3D1 but with libdebuginfod support enabled?

The commit message notes that the libdebuginfod feature check is independent
of NO_LIBDW. However, because debuginfo.o is only built with CONFIG_LIBDW,
the actual implementation of debuginfod__setup_urls_env() in debuginfo.c ge=
ts
omitted from the build when NO_LIBDW=3D1 is used.

When this configuration occurs, this empty stub replaces the fallback logic.

[ ... ]

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 3587ad2431590..1d70c43bb24ee 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -2534,6 +2536,16 @@ int symbol__init(struct perf_env *env)
>  	if (symbol_conf.initialized)
>  		return 0;
> =20
> +	/*
> +	 * Have DEBUGINFOD_URLS set before the threads that can take the
> +	 * debuginfod fetch path, and that getenv() it, e.g. in the every
> +	 * debuginfod_begin() of the other debuginfod client users, are
> +	 * started: set it up here, from the .urls files in /etc/debuginfod
> +	 * when it isn't set, instead of doing it lazily from the fetch
> +	 * path itself, setenv() not being thread safe.
> +	 */
> +	debuginfod__setup_urls_env();
> +

As a result of the missing implementation, this call in symbol__init() will
silently succeed against the stub without setting DEBUGINFOD_URLS.=20

This causes dependent debuginfod_begin() calls downstream in files like
build-id.c or probe-event.c to fail to find the configured servers in
environments like cron jobs or systemd services where the variable is not
explicitly exported.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914013604.7702=
-1-acme@kernel.org?part=3D2
