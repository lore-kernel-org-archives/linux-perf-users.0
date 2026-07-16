Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983332DAFA9
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187357; cv=none; b=olEywz5DZQan2H1bZtoz06RBxQLcK6l4NwbnCswsIOe/BBVYVfODIb/WzUmEXCg6xSn1kBgLXxzm4PpvDHu7FKri8A6GQqf0FT+fJMEPKOr4M4bFCePjn/YYx7SvlPP3TkTuJrGLlWPewl3yoNkyB4/Ye657I7FiaUPcEG0G8ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187357; c=relaxed/simple;
	bh=00RhobH1iNK5LL99zfCgasaJaXJnIUoHPBJJXgTFWB4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HeKugDKkpiNO4VBmzBL2K/XOTuUOMOMEuXTy6Y8XpCClaZ405tHg68KgPdbscRoj0WGGUCGUZ/TISlgbfxeozAssru7yt8XSWXZ7/tyLKmXkkmZDRmQWqve7Qw8NlmZpXKTmS4j/Lvrc3ZRD4Kzknpwaod7awMQrbgekt1Oggyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JN+mc0vg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JN+mc0vg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C93C1F000E9;
	Thu, 16 Jul 2026 07:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784187356;
	bh=yF/OSXMa7nODogv5YFlt00KUHNfYgmktqcQzoEWo47U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JN+mc0vgurce8zwTtCg2H7Z+Y/INqI6ekO9x9b20QpVYIKOmRFrQGEAWi3LTHRMLK
	 VTX6CIcaVS8+fr3Uq+s/FY8fG80hssg6jxfCDv8tDfSN2nF7AHV3hcxNKKYhNGXGX8
	 LpN0B+Undm/ehho6qb1K+QerTS0bNfJ0txN323T79sRcYyKlqJqWG1IAcZ7pOHHC+s
	 /5Mkvzhicqh1+YoPAHAztA8Fv8/8asDxmcb+8qPxu3q+vp25cJaylQnXsK1gJX7pZL
	 I9dYzB21cx404pHc1P1iELbs4oY+S3Y7HmTcxGu6USexSCHdBHNVJP1kNCaCn9VeXi
	 PrPzUdEokrHGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/10] perf ui hists: In report UI ensure thread is
 set with reference counting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260716072351.560311-7-irogers@google.com>
References: <20260710053628.1861645-1-irogers@google.com>
 <20260716072351.560311-1-irogers@google.com>
 <20260716072351.560311-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 07:35:55 +0000
Message-Id: <20260716073556.1C93C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Thread zooming and thread-specific scripting silently fail becau=
se consumer functions were not updated to read the new reference-counted `a=
ct->ms.thread` field.
- [Medium] The 'Zoom out' hotkey handler (`K_ESC` / `K_LEFT`) causes an unb=
alanced reference count decrement on a `struct map`, leading to a use-after=
-free.
--

--- Patch [7]: [PATCH v6 07/10] perf ui hists: In report UI ensure thread i=
s set with reference counting ---
commit 9d863ec6315c574f4f236ffe39082f794838058e
Author: Ian Rogers <irogers@google.com>

perf ui hists: In report UI ensure thread is set with reference counting

Populates the map_symbol thread in the UI code to fix the e_machine
lookup for cross-platform disassembly when using the annotate action.
At the same time, refactor the UI options and actions generation to
comply with the perf subsystem's strict reference counting abstraction
requirements for 'struct map_symbol' and 'struct thread'.

> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> index 46fb484a4dc64..6145c7878c648 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c

[ ... ]

> @@ -2628,7 +2636,7 @@ add_thread_opt(struct hist_browser *browser, struct=
 popup_action *act,
>  	if (ret < 0)
>  		return 0;
> =20
> -	act->thread =3D thread;
> +	act->ms.thread =3D thread__get(thread);
>  	act->fn =3D do_zoom_thread;
>  	return 1;
>  }

[Severity: Medium]
Does this change break thread zooming and thread-specific scripting?

The struct popup_action still contains the thread field, and consumer funct=
ions
like do_zoom_thread() and do_run_script() still check act->thread to append
arguments. Because act variables are zero-initialized, act->thread remains
NULL and the functions might silently abort or skip thread filtering.

For example, do_run_script() checks this field:

    if (act->thread)
        len +=3D strlen(thread__comm_str(act->thread));

Should these consumer functions be updated to read act->ms.thread instead?

[ ... ]

> @@ -3095,6 +3103,8 @@ static int evsel__hists_browse(struct evsel *evsel,=
 int nr_events, const char *h
> =20
>  		key =3D 0; // reset key
>  do_hotkey:		 // key came straight from options ui__popup_menu()
> +		free_popup_options(options, MAX_OPTIONS);
> +		free_popup_actions(actions, MAX_OPTIONS);

[Severity: Medium]
Can this free_popup_actions() call cause a use-after-free by decrementing t=
he
reference count of an unowned map?

If the user presses K_ESC or K_LEFT to zoom out, evsel__hists_browse() assi=
gns
a borrowed map reference to the first actions array element:

case K_ESC:
case K_LEFT: {
    ...
    actions->ms.map =3D map;
    top =3D pstack__peek(browser->pstack);
    ...

The loop can then continue back to the top, where free_popup_actions() is
unconditionally called. This triggers map_symbol__exit() on actions[0],
causing map__zput() to decrement the reference count of the unowned map.

>  		choice =3D nr_options =3D 0;
>  		key =3D hist_browser__run(browser, helpline, warn_lost_event, key);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716072351.5603=
11-1-irogers@google.com?part=3D7
