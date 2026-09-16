Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0C94D9F7D
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 18:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584407; cv=none; b=M1lF/aZiFJYdjXfgzN+XULVRTFthznSgC/0sP3NjgSZxKSgCztIxoHP65xylgVm2U7lZYtO+Ph4mX2MKqgzoT5mRPqxXy+ONcm0do1MwxLanpfqRcx8IFDNc7EjX2gcH5voA7zOzORLeBEH4KUU5uX2Rq+BGFeWcmlGPw2mPyjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584407; c=relaxed/simple;
	bh=luG2sc3j7RHaUTXQ2w99gH9J1QY/0gqIf1rfB3YwaDg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j5IYJAypyb2f99GOXq2D6wrEE10o7gTPFNP+7mpVFYdXl+OAm8uMIw9lf9FZqHXXtCeRmpUKGsU4GBUW8F/gZ1f0lyRBfHEMNmOKY7SWcjA/BKznK9C+RoU9ip1JDg9C5GjY6K4/WM67bYitAlELpZcsqmF/Cw0Q1YunEZtBHHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaRDz8o4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaRDz8o4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587571F0089E;
	Wed, 16 Sep 2026 18:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584391;
	bh=jBblzJACjGNEoeBTZ2BAIcoeYY19hhCOhELytJ/5mdU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZaRDz8o4YmIrZwuYLfPH4A6D2xASk6EeNNne2OvMsNN44vntHgOsAEyUlQdKiAiDq
	 iZC65nnQ+DpMxrINgGMgFvcPtc7hrGmgCL2CapGVX2y6KaHjUW+L40Uv2zWnYTmPTX
	 xG3KLdz+sVGjiklsFzmq45Lp1op97gS8bNlZ/jU8zmZK16lCCKuqu3g6cO1ghQwt3b
	 YaTGFrramO7HbEJkGOYJ6/hcYLdVtw/JlyOsg77XYp5qZZ2ThR7BDNHoopLKxQcU5U
	 f3FWL2Be5VswRMeiG1P7/ogwZmsrqN0thqh72yVVxLu6DArnqppvDd7uEDSRBORGtZ
	 PDWxqdora4PTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/12] perf debuginfo: Let the user skip and disable
 debuginfod fetches
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916183215.54305-5-acme@kernel.org>
References: <20260916183215.54305-1-acme@kernel.org>
 <20260916183215.54305-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 18:46:30 +0000
Message-Id: <20260916184631.587571F0089E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf debuginfo: thread-unsafe setenv and config modification in fe=
tch callback
--

commit 9924f6f0641ff8a22e081d24fa05c81be062cdf7
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf debuginfo: Let the user skip and disable debuginfod fetches

When a fetch is in progress, it prints progress and allows users to abort
it using 's' to skip the current fetch or 'd' to additionally disable
debuginfod for the rest of the session.

> diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
> --- a/tools/perf/util/debuginfo.c
> +++ b/tools/perf/util/debuginfo.c
[ ... ]
> +static void debuginfod__cancel_key(int key)
> +{
> +	if (key =3D=3D 's' || key =3D=3D 'S') {
> +		debuginfod_fetch_cancelled =3D true;
> +		debuginfod__skipped("Skipping this debuginfod fetch, this build ID wil=
l not be fetched again in this session, press 'd' to also disable it for th=
e other ones");
> +	} else if (key =3D=3D 'd' || key =3D=3D 'D') {
> +		debuginfod_fetch_cancelled =3D true;
> +		symbol_conf.debuginfod =3D false;
> +		/*
> +		 * libdwfl's own debuginfod client reads DEBUGINFOD_URLS
> +		 * in every query, so clear it to stop it as well.
> +		 */
> +		setenv("DEBUGINFOD_URLS", "", 1);
> +		if (perf_config__set_variable("core.debuginfod", "false"))

[Severity: High]
Are setenv() and perf_config__set_variable() safe to call here?

When running perf top, the background process_thread may fetch debuginfo
and invoke debuginfod_progress_fn(). If the user hits 'd' to cancel,
debuginfod__cancel_key() calls setenv() and perf_config__set_variable().

At the same time, the concurrent display_thread can call getenv() (e.g.
implicitly via libc functions) or perf_config() (e.g. via script_browse()).

This could cause a data race on environ and on the unprotected static global
parsing state variables in config.c, potentially leading to memory corrupti=
on
or a crash.

> +			debuginfod__skipped("Skipping this debuginfod fetch and disabling deb=
uginfod for this session, run 'perf config core.debuginfod=3Dfalse' to also=
 disable it permanently");
> +		else if (config_exclusive_filename)
> +			debuginfod__skipped("Skipping this debuginfod fetch and disabling deb=
uginfod for this session and in the configuration file");
> +		else
> +			debuginfod__skipped("Skipping this debuginfod fetch and disabling deb=
uginfod for this session and in ~/.perfconfig");
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916183215.5430=
5-1-acme@kernel.org?part=3D4
