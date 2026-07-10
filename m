Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4BA157487
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 06:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783663714; cv=none; b=S1LwV/DHkiw3BS3e7DW4VH/dPCYKLC7nZ+kPxAvktKLze1aVGyTCHVrWfNkLEdxCt2Dz04LJiWotzx+32f4Fw4oe7gxWMbX3smcFazGQiuwOrJOrR18KFeQFNJ0nNhOSC3Ejq/WQZZ3fGnquAwas+7p+sZdPoJXnrPaeZLAEv9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783663714; c=relaxed/simple;
	bh=nMom2KTHVUI9EleRQ0ZBuAOELx/FLMvqIRoPM51XU8w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MYte7BoTD9xF1fEz9fGtyX17orBVTJHj7ZQmxi/MxCyOdHNq/CTSRjK9Zyr+/UoRpYOrGm5h08U0VsfUAYA6Lhavg0v20FcYbnSjh4f/xjgOCNjkICRRGlI0/aYIMxi7HoZeZO8pWuWt1QDQ7C021cSFPMrhKgP4M2bkTD8JsmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZLvNmgw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZLvNmgw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A621F000E9;
	Fri, 10 Jul 2026 06:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783663713;
	bh=lvnCnkaMtyviC4MmFjI3WiKCFbJ9B7g6TD3yDlJnlOg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dZLvNmgwrBix5umh3jrHIgawEk4On+1/ELLj/SYyGw+bwtZhe3S4kn5wwD4NlcpQV
	 bspN04Yc9hJAuuQPAVn+6NPapikKBW6DN43+WAjD7ohRHLJ1QZQzD/VjdQzH25bcIU
	 Mj1vjpfOfC7hZ5E4SlFFEUurSb9wKxZxnS8fCae65nH6mFiFtnPZ+GdnjL5NMbfc1q
	 x234Y7tPK6MeubsMVOupBDfvUkhz5xXHnXb8P+qI9HpVgm9i/4BSHvHH7umBcUir90
	 ns0t857ZkT+i7u3SBVrgoZoSQ4gqXIA/GKLV7XQYWGfgm6D0bYI60KEpXdOWUMpRXV
	 wiwnNQvE0Li+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/10] perf annotate: Be robust to annotating without
 a thread
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260710053628.1861645-10-irogers@google.com>
References: <20260710024952.1668911-1-irogers@google.com>
 <20260710053628.1861645-1-irogers@google.com>
 <20260710053628.1861645-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 06:08:32 +0000
Message-Id: <20260710060833.20A621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Double-put of the `map` struct leading to a use-after-free when =
zooming out via the K_ESC/K_LEFT hotkeys.
--

--- Patch [10]: [PATCH v5 10/10] perf annotate: Be robust to annotating wit=
hout a thread ---
commit 380963af7e8bad2a7eee6ec6e6e6656a899a7aa7
Author: Ian Rogers <irogers@google.com>

perf annotate: Be robust to annotating without a thread

This commit makes perf annotate more robust by trying harder to determine
the architecture for disassembly when a thread isn't given. It introduces
map_symbol__get_arch() to replace the now removed thread__get_arch() and
safely handles map_symbol fallbacks.

> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> index e0ef756d95367..aee3d2c4e1867 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
[ ... ]
> @@ -3341,14 +3341,16 @@ static int evsel__hists_browse(struct evsel *evse=
l, int nr_events, const char *h
>  			actions->ms.map =3D map;

[Severity: Medium]
Could this assignment to actions->ms.map lead to a use-after-free?

When zooming out via the K_ESC or K_LEFT hotkeys, actions->ms.map is assign=
ed
the current map pointer without acquiring a reference via map__get().

The loop then continues to the top, where free_popup_actions() is called on
the actions array.=20

Does free_popup_actions() systematically call map_symbol__exit(), causing it
to improperly drop a reference on actions[0].ms.map? This could lead to a
reference count underflow and use-after-free of the map.

>  			top =3D pstack__peek(browser->pstack);
>  			if (top =3D=3D &browser->hists->dso_filter) {
>  				/*
>  				 * No need to set actions->dso here since
>  				 * it's just to remove the current filter.
>  				 */
>  				do_zoom_dso(browser, actions);
>  			} else if (top =3D=3D &browser->hists->thread_filter) {
> -				actions->thread =3D thread;
> -				do_zoom_thread(browser, actions);
> +				memset(&hotkey_act, 0, sizeof(hotkey_act));
> +				hotkey_act.ms.thread =3D thread__get(thread);
> +				do_zoom_thread(browser, &hotkey_act);
> +				map_symbol__exit(&hotkey_act.ms);
>  			} else if (top =3D=3D &browser->hists->socket_filter) {
>  				do_zoom_socket(browser, actions);
>  			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710053628.1861=
645-1-irogers@google.com?part=3D10
