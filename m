Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E769F379964
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 05:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783662854; cv=none; b=WzgVXQZ7Ga6UEfFwB9DA2fPf93c+coGuDQTrJW+Udq/vKKpUJVKq41IcGjLXeEcj8vYbM8Z2IzSlU3GW2Q0w4ghWaTeRTjRMIUukYcT0DW//MOVqOyJOkHuBXz5NOPhXs4uRYABW223a6pPnXXsuH+d67Ut1le1PDVdMrMviiW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783662854; c=relaxed/simple;
	bh=iTUqxomMDR8JSpNE+JNP7CXjTlgKgzsStulIuQdstF8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PUXxrBG4SuJQ3A7/38PWNIl28Os4R2Qc6RXTXf6N5cJRtlSl3so7KqAAsDGfQEV+PzM+JBpOEIG9sC0eSmh4e3zqsw4OdFHaNZoY3qXH6SuwLMmB8H2EQOpbEsC1chE2p0q2zdY/JZPZscnHpJSJL4o7+Mcehq1Bft1l8Df+oNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCGNccxr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCGNccxr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592111F00A3A;
	Fri, 10 Jul 2026 05:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783662852;
	bh=LGnx37L/wMHZ5YabGGxvlSMKJdxPHVOgykYzuc+qhSA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gCGNccxr9UdwOLWbmZb71+oJ+R5CPNiLZgEdu2eMDRPG/yPFPap8ivKiBkzlMNSbA
	 3ZsYkLB1vRsZC1EE6dS+Lo0y6pPcI1YMlZ4EctY92PK5o1nt6z0apTOGt5JBj5diKz
	 Ui13aHps1WJHt2/yADsTDgM5frjug/A2Vpwsv/OERskuSNw7kCtWpEqsAM3979CFPT
	 pB5bAzIyN9usX5nBnfyFWjobYTC9kBaJIk/122b2jr2xo91oT3xGLku/LCzuHhCtqX
	 9lacm3ovP0f3JsV/bQhas2nBgYrwB4Imdh1Omo87us5xgHS4hLeaPEzArjT9paZFwB
	 ez/3Ycamad+hA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/10] perf ui hists: In report UI ensure thread is
 set with reference counting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260710053628.1861645-7-irogers@google.com>
References: <20260710024952.1668911-1-irogers@google.com>
 <20260710053628.1861645-1-irogers@google.com>
 <20260710053628.1861645-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 05:54:11 +0000
Message-Id: <20260710055412.592111F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The K_ESC/K_LEFT hotkey handler assigns a raw pointer to `action=
s->ms.map` without acquiring a reference, causing an unbalanced put and pot=
ential Use-After-Free.
- [Medium] Thread zooming and script thread filtering fail entirely and are=
 prone to UAF due to missing updates to callback functions (`do_zoom_thread=
` and `do_run_script`) which still read the legacy `act->thread` field inst=
ead of `act->ms.thread`.
--

--- Patch [7]: [PATCH v5 07/10] perf ui hists: In report UI ensure thread i=
s set with reference counting ---
commit e0c9eb4c3d452d50d71fabaeaa1ebee8659f6602
Author: Ian Rogers <irogers@google.com>

perf ui hists: In report UI ensure thread is set with reference counting

Populates the map_symbol thread in the UI code to fix the e_machine
lookup for cross-platform disassembly when using the annotate action.
At the same time, refactor the UI options and actions generation to
comply with the perf subsystem's strict reference counting abstraction
requirements for 'struct map_symbol' and 'struct thread'. Introduce
explicit reference acquiring via map_symbol__copy() and thread__get() for
menu items, safely clean them up between menu iterations using a new
free_popup_actions() helper, and utilize insulated temporary action
variables for direct hotkey handler execution.

> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> index 46fb484a4dc64..6145c7878c648 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -3095,6 +3103,8 @@ static int evsel__hists_browse(struct evsel *evsel,=
 int nr_events, const char *h
> =20
>  		key =3D 0; // reset key
>  do_hotkey:		 // key came straight from options ui__popup_menu()
> +		free_popup_options(options, MAX_OPTIONS);
> +		free_popup_actions(actions, MAX_OPTIONS);
>  		choice =3D nr_options =3D 0;
>  		key =3D hist_browser__run(browser, helpline, warn_lost_event, key);

[Severity: Medium]
Will this lead to a refcount underflow when the user presses ESC?

If the user opens the hists browser, filters by a DSO, and presses ESC or L=
EFT
to zoom out, the K_ESC handler assigns the map without acquiring a referenc=
e:

evsel__hists_browse() {
    ...
    case K_ESC:
    case K_LEFT: {
        ...
        actions->ms.map =3D map;
        top =3D pstack__peek(browser->pstack);
        if (top =3D=3D &browser->hists->dso_filter) {
            do_zoom_dso(browser, actions);
        }
        continue;
    }

When the loop continues and jumps back to do_hotkey, free_popup_actions()
will call map_symbol__exit() and drop a reference on actions[0].ms.map.
Since no reference was acquired with map__get(), does this underflow the ma=
p's
reference count and potentially cause a use-after-free?

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
Because act->thread is no longer set here, do the callback functions that
process this action still read the legacy act->thread field instead of
act->ms.thread?

For instance, do_zoom_thread() and do_run_script() appear to still read the
unpopulated field:

do_zoom_thread(struct hist_browser *browser, struct popup_action *act) {
    struct thread *thread =3D act->thread;
    ...
}

do_run_script(...) {
    if (act->thread) {
        ...
    }
}

Since the actions array is zero-initialized, act->thread will be NULL and
these functions may silently fail to apply the thread parameter.

Furthermore, if there are any remaining places in evsel__hists_browse() that
assign to the legacy actions->thread field, that field is not cleared by
free_popup_actions(). Could this leave a stale pointer in the actions array
across menu loop iterations, leading to a use-after-free if do_zoom_thread()
is subsequently executed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710053628.1861=
645-1-irogers@google.com?part=3D7
