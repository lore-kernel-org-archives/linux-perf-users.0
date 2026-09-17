Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4931C4F4D07
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661276; cv=none; b=Oh4N1Q4ptlN4Vf1Yfh76aRN3ixuEDm1SX2EzL7kNtjbPxfKW6caXCPTd257koVOrOrixmjOY1jdeFIhDnqiZZw8xERYKhJt+9FIXbQZzmtEDJe5nSHy0NK/JKGloK7TfLI9EwR+L6VUhixQkr0dRjcGIMXLjpI7IYzPH9fFTQT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661276; c=relaxed/simple;
	bh=nk5F4g+dKCxD5uwYB9QxeLpdt0pTNTsqzSzhSnC+tHw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jBJI4RDhrT6Ezyp1L0fmNOmYDSs/gw3cIR6GWAt3KbcvX5x/wBwpiy+GMc+EscTmTWppdrYEWwxKu/roshe3pKa3/hPqui9BHRh2pqsmGQLFqm93491gMjSSLMC4Wb6S1L6Q4/AzUmyk7RU7tdoBND7ZQnO/KY0MrnKXN5pEF4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxP1vKPa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxP1vKPa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6ECD1F00898;
	Thu, 17 Sep 2026 16:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789661275;
	bh=aQcxOXZ8egGuaPRC+t0xXYbLcU+RD8JT8UOSVJ1I9kw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BxP1vKPawthkmsEn1iBOvFmsR5obcAbT4vhCLCGQTAh9nTQloR/a+kZODnkv/k4DB
	 1CbwHQEhUgyvMuop4UPZUiANQwhj4MH+a84v8hzh4e/ijHcJIcXL/P5Kay5C6PbGtm
	 EKt31+9eYq10d8HcZWxWRJ9xLJvG21RrdGg6DOpgMXUDbDpr9Wnjh9UioXVAKH7NEq
	 eSf0pW6TN+b9LWkrSLeDUCQm/u3q7CIFDrYTY+tLc7Kfju2ovmIZFYUAmnqfcKYgFB
	 L31IFkZHMZGT/EWP9Gw7jI6SHI6FlGbicMUvcduoSK0v+GpQ/MwKYPUdiSLnhLyI0g
	 vkctllag/pvng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/15] perf debuginfo: Set DEBUGINFOD_URLS from
 /etc/debuginfod when unset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917155528.62607-3-acme@kernel.org>
References: <20260917155528.62607-1-acme@kernel.org>
 <20260917155528.62607-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:07:54 +0000
Message-Id: <20260917160754.D6ECD1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf debuginfo: bypass of /etc/debuginfod fallback for record/bu=
ildid-cache
--

commit abf1731695e2130d2a1cbc46b0ed7ae8527966ac
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf debuginfo: Set DEBUGINFOD_URLS from /etc/debuginfod when unset

This commit allows perf to read DEBUGINFOD_URLS from the .urls files in
/etc/debuginfod during early setup if the environment variable is not alrea=
dy
configured. This aims to resolve debuginfod failures in environments like
cron jobs, systemd services, or CI pipelines where distro setup scripts
might not populate the environment.

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
[ ... ]
>  void perf_debuginfod_setup(struct perf_debuginfod *di)
>  {
[ ... ]
> -	if (!di->set)
> -		setenv("DEBUGINFOD_URLS", "", 1);
> -	else if (di->urls && strcmp(di->urls, "system"))
> -		setenv("DEBUGINFOD_URLS", di->urls, 1);
> +	if (!di->set) {
> +		debuginfod__set_urls_env("");
> +	} else if (di->urls =3D=3D NULL || !strcmp(di->urls, "system")) {
> +		const char *urls =3D getenv(DEBUGINFOD_URLS_ENV);
> +
> +		if (urls !=3D NULL)
> +			debuginfod__set_urls_env(urls);
> +	} else {
> +		debuginfod__set_urls_env(di->urls);
> +	}
> =20
> -	pr_debug("DEBUGINFOD_URLS=3D%s\n", getenv("DEBUGINFOD_URLS"));
> +	debuginfod__urls_set_by_tool =3D true;

[Severity: Medium]
When perf tools request debuginfod support with the default "system" URLs,
and the environment variable is unset (urls =3D=3D NULL), does unconditiona=
lly
setting debuginfod__urls_set_by_tool to true here unintentionally lock out
the fallback mechanism?

[ ... ]
> +#ifdef HAVE_DEBUGINFOD_SUPPORT
> +/*
> + * The debuginfod client checks its local cache only as part of the
[ ... ]
> +void debuginfod__setup_urls_env(void)
> +{
> +	const char *env_urls;
> +	char *urls =3D NULL;
> +	DIR *dir;
> +	struct dirent *dent;
> +
> +	/*
> +	 * Tools that set DEBUGINFOD_URLS themselves already made their choice,
> +	 * leave it alone.
> +	 */
> +	if (debuginfod__urls_set_by_tool)
> +		return;

[Severity: Medium]
Because debuginfod__urls_set_by_tool is flagged to true earlier in
perf_debuginfod_setup(), will tools like perf record and perf buildid-cache
that run with --debuginfod exit early here?

It looks like this sequence causes these tools to entirely bypass the new
/etc/debuginfod fallback logic when DEBUGINFOD_URLS is unset, which seems
to defeat the purpose of the patch for these subcommands.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917155528.6260=
7-1-acme@kernel.org?part=3D2
