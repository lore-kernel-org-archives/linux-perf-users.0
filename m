Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5075727FD49
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 06:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787554143; cv=none; b=k186dXx6amM3QTGEYItPTAMmIdxUBp8WKvA54PT+bM1OF+n//NKZl71lsJkAYWuFcn0DGc2vMTJfGa0Tm2Yd+fdwtlXUfdd6XLYLuO59prwZImVII6AXqfRbzVd8EZhm+oEPVKCU4dwfhSF0Dx1BQ2FTayCbJE9chxANK3COdyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787554143; c=relaxed/simple;
	bh=3j+nizpTeF8N/ytQ76cnOI/8qyemo2ap9AtguObzsyo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iY/oXEWA7Guu5D//oSFfgXBBe37u0PVa/c52hDpx3ZaLaYh2sCFLh5gL2U/mT02NEAbl3cbQyQSMom1l4BCbTVCNulnkbImKLF7AwN39kQprMrPi/kHhTGEvdqPp32i72dKPaTCSi5xFBGHZrbdHx8XvvO06LniqqbMrrtFet8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJjs4Ght; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJjs4Ght"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FC51F000E9;
	Mon, 24 Aug 2026 06:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787554141;
	bh=OLTQAil93lNfpzQ+p+rFK9dd8HFtBx6oO7U2XGsgCWc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nJjs4GhtRoJ4HxXWaTTzHK9/OdChkaVB2J2MsX15l1sqBZ82wob2Hv0RCX3BXRm4+
	 JBLtSTv9nnGcRA6PyCSaxGXVGXs+FHm7VB3T1SPLVpuARR19VYC+gvsNP9Td1cgkFk
	 q30MBZePUIBnfpKVdwjaWD138n2FIfTF29Uya6q0VSTC5yL6kuSIBJkxqOaBEOfGdv
	 y3+M2purt8SbN7IEF1GNiMUb/AyJQpgOgfRp+t1PAh1ND5iA8/PQlFQSEs9jKA+p41
	 9N/F3PRIpvlzfekefFRdVPMef/MtHONqasKeiOmwTnv7B8tm6Jh1P3Uwh+ODMhxf4W
	 I6Rq70GiLp31A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/7] perf ui browsers: Implement interactive 'M'
 keystroke to toggle hybrid event merging
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824063744.1533837-4-irogers@google.com>
References: <20260813132519.4099508-1-andi@firstfloor.org>
 <20260824063744.1533837-1-irogers@google.com>
 <20260824063744.1533837-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 06:49:01 +0000
Message-Id: <20260824064901.96FC51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Toggling hybrid merging off via 'M' fails to reverse structural ch=
anges, leaving the evlist permanently merged.
- [High] If merging hybrid events results in a single event group, the 'M' =
key becomes unreachable, and pressing it causes a silent exit.
- [High] Intercepting K_RELOAD inside the UI browser breaks critical caller=
-level session reloads.
- [High] Dynamically calling `evlist__merge_hybrid` from the TUI thread mod=
ifies `evlist->core.entries` and rbtrees without locks, causing race condit=
ions.
- [Low] The newly introduced function `evsel__new_dummy()` is dead code.
--

--- Patch [3]: [PATCH v1 3/7] perf ui browsers: Implement interactive 'M' k=
eystroke to toggle hybrid event merging ---
commit 761e0204fddbaaaabd4cf218b352b3c2ddbaf235
Author: Ian Rogers <irogers@google.com>

perf ui browsers: Implement interactive 'M' keystroke to toggle hybrid even=
t merging

Map the 'M' keystroke globally across the interface to toggle boolean state
dynamically rebuilding hybrid core groups independently.
This allows cleanly separating or aggregating hybrid core histograms.

> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> index c15874a491b43..07cb06834d0f4 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c

[ ... ]

> @@ -3636,6 +3639,16 @@ static int perf_evsel_menu__run(struct evsel_menu =
*menu,
>  				goto out;
>  			case K_ESC:
>  			default:
> +				if (key =3D=3D 'M') {
> +					if (evlist__can_merge_hybrid(evlist)) {
> +						if (!symbol_conf.hybrid_merge)
> +							evlist__merge_hybrid(evlist, true);
> +						symbol_conf.hybrid_merge =3D
> +							!symbol_conf.hybrid_merge;

[Severity: High]
Does toggling hybrid merging off via 'M' fail to reverse the structural
changes?

When symbol_conf.hybrid_merge is toggled from true to false, the state is
updated and K_RELOAD is returned, but there is no call to an unmerge functi=
on.
Since evlist__merge_hybrid() irreversibly mutates pos->core.leader and the
doubly linked evlist->core.entries, wouldn't the histograms remain permanen=
tly
merged under the hood?

[Severity: High]
Is it safe to dynamically call evlist__merge_hybrid() from the TUI thread
without locks?

In perf top, a background process_thread continuously mutates evlist and its
child rbtrees while holding hists->lock. This call locklessly manipulates t=
he
doubly linked evlist->core.entries and modifies hists nodes. If the backgro=
und
thread accesses the evlist concurrently, could this cause list corruption or
crashes?

> +						ui_browser__hide(&menu->b);
> +						return K_RELOAD;
> +					}
> +				}
>  				continue;
>  			}
>  		case K_LEFT:

[ ... ]

> @@ -3720,10 +3747,14 @@ static bool evlist__single_entry(struct evlist *e=
vlist)
>  	return false;
>  }
> =20
> +
>  int evlist__tui_browse_hists(struct evlist *evlist, const char *help, st=
ruct hist_browser_timer *hbt,
>  			     float min_pcnt, struct perf_env *env, bool warn_lost_event)
>  {
>  	int nr_entries =3D evlist__nr_entries(evlist);
> +	int ret;
> +
> +retry:
> =20
>  	if (evlist__single_entry(evlist)) {
>  single_entry: {
> @@ -3747,8 +3778,13 @@ single_entry: {
>  			goto single_entry;
>  	}
> =20
> -	return __evlist__tui_browse_hists(evlist, nr_entries, help, hbt, min_pc=
nt, env,
> +	ret =3D __evlist__tui_browse_hists(evlist, nr_entries, help, hbt, min_p=
cnt, env,
>  					  warn_lost_event);
> +	if (ret =3D=3D K_RELOAD) {
> +		nr_entries =3D evlist__nr_entries(evlist);
> +		goto retry;

[Severity: High]
Does this logic trap the user if merging hybrid events results in a single
event group?

If evlist__merge_hybrid() coalesces all events into a single group, nr_entr=
ies
will evaluate to 1. On K_RELOAD, this loop goes to retry, which then jumps
directly to the single_entry block and bypasses the perf_evsel_menu__run() =
menu
loop. Since the single entry view lacks the 'M' handler, pressing 'M' again
would act as an unhandled hotkey and cause a silent exit.

[Severity: High]
Does intercepting K_RELOAD inside the UI browser break critical caller-level
session reloads?

Callers like display_thread_tui() in builtin-top.c previously relied on
receiving K_RELOAD to execute full session re-initialization (e.g., zeroing
histograms). By swallowing the signal with this goto retry loop, does this
force an internal redraw with stale structures instead of yielding control =
to
the caller?

> +	}
> +	return ret;
>  }
> =20
>  static int block_hists_browser__title(struct hist_browser *browser, char=
 *bf,

[ ... ]

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 3f56a0e6f9d65..a4760cfb7582a 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -4758,3 +4758,15 @@ void evsel__warn_user_requested_cpus(struct evsel =
*evsel, struct perf_cpu_map *u
>  	perf_cpu_map__put(intersect);
>  	perf_cpu_map__put(online);
>  }
> +
> +struct evsel *evsel__new_dummy(void)
> +{
> +	struct perf_event_attr attr =3D {
> +		.type	=3D PERF_TYPE_SOFTWARE,
> +		.config =3D PERF_COUNT_SW_DUMMY,
> +		.size	=3D sizeof(attr),
> +		.freq =3D 0,
> +		.sample_period =3D 1,
> +	};
> +	return evsel__new(&attr);
> +}

[Severity: Low]
Is this newly introduced function evsel__new_dummy() dead code?

It is defined and exported here, but it doesn't appear to be called anywher=
e in
the patch series.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824063744.1533=
837-1-irogers@google.com?part=3D3
