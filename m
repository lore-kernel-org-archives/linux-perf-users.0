Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D152F34887B
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187550; cv=none; b=EwZbELaDeU87YrM2nkRYzjZHV9UB98iwbT09P9nSw59w5NdZj3urKm2NF21psuxzAijOzzjmAYf66epnK4Ij2PNx9PXQqwHDmhV06FCW5TKhmMgPKD9J5ZpdgMYrWuURW84kvKDD5uWfgrtZ+kkSTLCMAOAY8XdpQsKtLUkOetw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187550; c=relaxed/simple;
	bh=qo6dhcxoD2WFJfpfd31HFjyGqMHBCIKklR+2Ez5B2FA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QIvbEq+Cxpkl7RGQa/k+urrCUPyB1d5BV2KxR6OGCuvUDwSM6Oz1HuiqjnXfZmNd9zh76TjmJPudhG9+LTr/sw0xqX9ev0QPhvgsbTghQoG8/ryGK1ckY73XA7hZjFGx+z5mCMrLol7qMHlDs1LeA8uHN9IwV+1b/Ml5cGSzhpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SC0t1dSE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SC0t1dSE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8931F000E9;
	Thu, 16 Jul 2026 07:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784187549;
	bh=fspF+k/wmc47Fh3a62BsGRsYrwegyD6K5lDy6RZBGQk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SC0t1dSEOZQe/Wp37CWVaIQJq0J9h+wSJzozRxAbqa7Zlql7uG0EcVUC/gmAnPqUO
	 gNVVOdgmCLUryb/UKgpNu6dAsl1FFggpb6tOMaPoXKT2AMuDPDesuxNr1EFeRprV9/
	 lNasV5IRQF7x/ozMVCZ8ftr00KQXXpkcqxHsBh/zuXF+ZRU4zLyZQmIXQTNrW7pF7H
	 BDbbWNo4tThtRJGcOQ+doDmiXgrlnqlyPA3JVajnt6mhzJ0t8QzZW5zJERLMFhOYHk
	 mpc6HoiYFIBO6FUlmdrD64eOJLYzTtPdwFswBIsCBVZEWQUkrmHrtblLfR31Fc/7o+
	 M55ZJVDfNkU3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/10] perf ui hists: Fix NULL pointer array gap in
 add_script_opt()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260716072351.560311-6-irogers@google.com>
References: <20260710053628.1861645-1-irogers@google.com>
 <20260716072351.560311-1-irogers@google.com>
 <20260716072351.560311-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 07:39:08 +0000
Message-Id: <20260716073909.4A8931F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Memory leak of dynamically allocated strings for the popup menu =
in `evsel__hists_browse`.
- [Medium] NULL pointer dereference when computing script option time range=
 for an empty trace.
--

--- Patch [6]: [PATCH v6 06/10] perf ui hists: Fix NULL pointer array gap i=
n add_script_opt() ---
commit 7d70d8b9859cd9c3627530a34fb514614a33b89f
Author: Ian Rogers <irogers@google.com>

perf ui hists: Fix NULL pointer array gap in add_script_opt()

In add_script_opt(), the function unconditionally increments the optstr
and act pointers for a second optional 'time' popup action before
attempting to invoke add_script_opt_2(). If the first add_script_opt_2()
call failed, this leaves a NULL pointer gap in the options array. When
ui__popup_menu() is later displayed, it dereferences this gap and crashes.

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

[Severity: Medium]
This is a pre-existing issue, but does this dynamically allocated string le=
ak?

When repeatedly opening and closing the popup menu (pressing 'm' then 'ESC'=
),
evsel__hists_browse() resets nr_options to 0 inside the event loop.

This overwrites the options array without calling free_popup_options() to c=
lean
up the strings allocated by asprintf() in add_script_opt_2().

> =20
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
This is a pre-existing issue, but can he be NULL here leading to a crash?

If the trace is empty (e.g., all entries filtered out) and the user presses=
 'm',
evsel__hists_browse() calls add_script_opt() unconditionally, even if
hist_browser__selected_entry() returns NULL.

>  		j +=3D sprintf(tstr + j, "-");
>  		timestamp__scnprintf_usec(he->time + symbol_conf.time_quantum,
>  				          tstr + j, sizeof tstr - j);
> -		n +=3D add_script_opt_2(act, optstr, thread, sym, tstr);
> -		act->time =3D he->time;
> +		ret =3D add_script_opt_2(time_act, time_optstr, thread, sym, tstr);
> +		if (ret > 0) {
> +			time_act->time =3D he->time;
> +			n +=3D ret;
> +		}
>  	}
>  	return n;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716072351.5603=
11-1-irogers@google.com?part=3D6
