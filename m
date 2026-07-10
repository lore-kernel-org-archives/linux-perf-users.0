Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C771F3955D0
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 05:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783662964; cv=none; b=qmT+1WUrpul8hRJLUzV7peGGV2EyBhWK1U5e609I0puhBfbkxeGKdrkS82Mth/ClfKhAGsd3zHfvcWCU4rfCkKP2VTWTBZHFR8+1+EYmxAhu7ysXXYPoh0AK7IY7bp6JD2sM9JCZpxKlj20Ke5u4bVELbLghSlPF0rmXknw5/5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783662964; c=relaxed/simple;
	bh=e2hxNy6ZZ/Q/MlOdWCktQv4XITlMzT7rs8t19NU7LyM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RoL9fTyjHVAUtP+qgxaRV03HKOhmYTtEdKckgDlZIZzqKXu9orT+i4DTYAbu18umRVODhQIj9/tI5uIxbB6NJeiBtQS4DLIJeWI7l3N3yxmUq6sF2hF1AKP3d/9WIU+bWR9dDj8wMNtRVM9y/36enapqXQyKjkNUEagbI+YerGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5bU0Q2O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5bU0Q2O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8161F00A3A;
	Fri, 10 Jul 2026 05:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783662963;
	bh=kde4BefcInUBZYRE77UsNEoDgeTa+fKzgcUwUYBnaV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L5bU0Q2Oj8gIFOxkFmQCh7iunDhJ7YSG8usFH46GV2HVRU/g+Fkhaco8KUZhb5P83
	 x1qQOuLHfKm85hCuXPj6nPRmqh04meI1NI1an0sYZzDOesYsftbGnPNVWzzGgC3NZd
	 0+wfGPkFXJcIh2+fAdVUtNJgxmeqmckDkDlLKyPU6XCblqwe+HWAY+/agh1S3bcidI
	 2zrfpeJfcclHgxzMVnsYlPWXdH0osFVk1QyflaM8i4zVhHHcpS1tvI5uT8h9mHPMgh
	 DpD1iNxbSV7/4JuzgYjibicZe1n9lydA+EcJHLbHG82J1MOzwqAlv6wRvj5EhhiXwV
	 6N1T340jstAIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/10] perf ui hists: Fix NULL pointer array gap in
 add_script_opt()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260710053628.1861645-6-irogers@google.com>
References: <20260710024952.1668911-1-irogers@google.com>
 <20260710053628.1861645-1-irogers@google.com>
 <20260710053628.1861645-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 05:56:02 +0000
Message-Id: <20260710055603.4D8161F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Unchecked dereference of `he->time` when no histogram entry is s=
elected and `sort_order` contains 'time'.
- [Medium] Memory leak of dynamically allocated menu option strings across =
iterations of the UI event loop.
--

--- Patch [6]: [PATCH v5 06/10] perf ui hists: Fix NULL pointer array gap i=
n add_script_opt() ---
commit 6121a2411240f6a0186b5b6f8441d4151e6fa32d
Author: Ian Rogers <irogers@google.com>

perf ui hists: Fix NULL pointer array gap in add_script_opt()

This commit fixes a crash in ui__popup_menu() caused by an unconditional
pointer increment for an optional 'time' popup action. It correctly
advances the optstr and act pointers only if the first script addition
succeeds.

> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> index 4282ef1b81f75..46fb484a4dc64 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -2811,7 +2811,7 @@ add_script_opt(struct hist_browser *browser,
>  	       struct popup_action *act, char **optstr,
>  	       struct thread *thread, struct symbol *sym)
>  {
> -	int n, j;
> +	int n, j, ret;
>  	struct hist_entry *he;
> =20
>  	n =3D add_script_opt_2(act, optstr, thread, sym, "");
> @@ -2819,17 +2819,24 @@ add_script_opt(struct hist_browser *browser,
>  	he =3D hist_browser__selected_entry(browser);
>  	if (sort_order && strstr(sort_order, "time")) {
>  		char tstr[128];
> +		struct popup_action *time_act =3D act;
> +		char **time_optstr =3D optstr;
> =20
> -		optstr++;
> -		act++;
> +		if (n > 0) {
> +			time_optstr++;
> +			time_act++;
> +		}
>  		j =3D sprintf(tstr, " in ");
>  		j +=3D timestamp__scnprintf_usec(he->time, tstr + j,
>  					       sizeof tstr - j);

[Severity: Medium]
This is a pre-existing issue, but can this lead to a NULL pointer dereferen=
ce
if the histogram browser has no selected entry?

If a user interacts with an empty view and sort_order contains "time",
evsel__hists_browse() will call add_script_opt() when no entry is selected.
The call to hist_browser__selected_entry(browser) above will return NULL,
causing a crash when he->time is accessed here.

>  		j +=3D sprintf(tstr + j, "-");
>  		timestamp__scnprintf_usec(he->time + symbol_conf.time_quantum,
>  				          tstr + j, sizeof tstr - j);
> -		n +=3D add_script_opt_2(act, optstr, thread, sym, tstr);
> -		act->time =3D he->time;
> +		ret =3D add_script_opt_2(time_act, time_optstr, thread, sym, tstr);

[Severity: Medium]
This is a pre-existing issue, but does this leak memory when the popup menu
is repeatedly opened and closed?

The add_script_opt_2() function dynamically allocates strings into the opti=
ons
array using asprintf(). In evsel__hists_browse(), the main event loop resets
the option count:

tools/perf/ui/browsers/hists.c:evsel__hists_browse() {
    ...
    choice =3D nr_options =3D 0;
    ...
}

Subsequent calls to functions like add_script_opt_2() will then overwrite
these string pointers in the options array without freeing the previously
allocated strings.

> +		if (ret > 0) {
> +			time_act->time =3D he->time;
> +			n +=3D ret;
> +		}
>  	}
>  	return n;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710053628.1861=
645-1-irogers@google.com?part=3D6
