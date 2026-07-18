Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01B3305E32;
	Sat, 18 Jul 2026 05:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784353138; cv=none; b=rrxNYnhfxcz6O6Gr2LAoor9X0N5yNoajVs39+RcLujSy+yNwSK/zCX7uegIHf/hUbd+/2xafdtqtwl1YZ3hsZWSb5rktqLQDlwXGALe7MQMOkmpvOs3CHxPbjxOTAzfSBGGmsfmu4w5k658X5++yeARVP5DYq5UUEA/U4UNrDig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784353138; c=relaxed/simple;
	bh=f/auU1sLUSmjRcM56684IB6M/B565j4C9rHnEmJV8QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7AMAgmUvUbOcIzqVBtQTTfqo6aE1w6b3z6zLPKwEdSTFtp9CJgFRmK8ulByhla44PPoX/+7XVx5dsF9cyBAG4XgLNP4OAwU/9vNeQs8hxdWuYZnsbQWBG2Y4pe9fBzUseF16xBDWXRomOABOe54yc23ECRUfFZfXdRG4SOY+Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y25DGUgS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y25DGUgS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0841F000E9;
	Sat, 18 Jul 2026 05:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784353136;
	bh=ciuMwKRA9gRoRCTgj/gmZ+7142E2Ydcj+uCYfNC/kIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y25DGUgSwP9/+v6c/XMiEh/AskKW0wiVc6HYlDWlEBiDgL7pxG8LhDjYr0g8KH27W
	 5XkCiqX1utv0djTs2ZANGTd687U6uDpYuwf9njIaVmK6bVI9msl6WqTwdkZ/iHy/Xr
	 Cx85cgmEgTlYlyqoJbN6Yi+iHoapYN4S3gfRIJ+YacG2XmUGAC37ckXfG04k+efgw0
	 JAKMXEVSuQnS4+MbA/DxlmUBusCWkbACNyFO+/DNpXkAzy6WFSMFEd40mqzXVTMLBZ
	 cpOYWf6y+3PQpF/UfLtfiTuEXKO8iUMSxDXSMUDoPTIHiYvw8dbcfUty6OjR+xyvu5
	 UKzFKcH5j6VMA==
Date: Fri, 17 Jul 2026 22:38:54 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v6 08/10] perf ui hists: Remove duplicated thread in
 popup_action
Message-ID: <alsRbqrQagNFdflR@google.com>
References: <20260710053628.1861645-1-irogers@google.com>
 <20260716072351.560311-1-irogers@google.com>
 <20260716072351.560311-8-irogers@google.com>
 <20260716073751.40C301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260716073751.40C301F000E9@smtp.kernel.org>

On Thu, Jul 16, 2026 at 07:37:50AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Assigning a raw pointer to `actions->ms.map` without taking a reference, followed by `free_popup_actions()` dropping the reference, causes a refcount underflow.
> - [Low] The commit removes the `thread` member from `struct popup_action` but leaves multiple read and write accesses to it intact, breaking the build.
> --
> 
> --- Patch [8]: [PATCH v6 08/10] perf ui hists: Remove duplicated thread in popup_action ---
> commit 1a6678f7f83293dd5e22da61354ad80c36378c0a
> Author: Ian Rogers <irogers@google.com>
> 
> perf ui hists: Remove duplicated thread in popup_action
> 
> This commit removes the thread member from struct popup_action since it is
> duplicated in the map_symbol structure. It aims to ensure there is only ever
> one thread associated with a popup_action.
> 
> > diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> > index 6145c7878c648..89c3d3dc69a27 100644
> > --- a/tools/perf/ui/browsers/hists.c
> > +++ b/tools/perf/ui/browsers/hists.c
> > @@ -2359,7 +2359,6 @@ static int hists_browser__scnprintf_title(struct hist_browser *browser, char *bf
> >  
> >  struct popup_action {
> >  	unsigned long		time;
> > -	struct thread		*thread;
> 
> [Severity: Low]
> Does this removal cause a build regression?

Right, this should be the last patch in the series.

Thanks,
Namhyung

> 
> There are still accesses to act->thread and actions->thread in several places
> that will no longer compile:
> 
> tools/perf/ui/browsers/hists.c:do_zoom_thread() {
>     struct thread *thread = act->thread;
> ...
> }
> 
> tools/perf/ui/browsers/hists.c:do_run_script() {
> ...
>     if (act->thread)
>         len += strlen(thread__comm_str(act->thread));
> ...
> }
> 
> tools/perf/ui/browsers/hists.c:evsel__hists_browse() {
> ...
>         } else if (top == &browser->hists->thread_filter) {
>             actions->thread = thread;
>             do_zoom_thread(browser, actions);
>         }
> ...
> }
> 
> [Severity: Medium]
> Can this code cause a refcount underflow regression?
> 
> In evsel__hists_browse(), when handling K_ESC or K_LEFT, actions->ms.map is
> assigned directly without taking a reference:
> 
> tools/perf/ui/browsers/hists.c:evsel__hists_browse() {
> ...
>         case K_ESC:
>         case K_LEFT: {
>             ...
>             actions->ms.map = map;
>             ...
>             continue;
>         }
> ...
> }
> 
> The loop then hits continue, and at the do_hotkey label, free_popup_actions()
> drops the reference, which can cause an underflow when map_symbol__exit()
> calls map__zput():
> 
> tools/perf/ui/browsers/hists.c:evsel__hists_browse() {
> ...
> do_hotkey:
>         free_popup_options(options, MAX_OPTIONS);
>         free_popup_actions(actions, MAX_OPTIONS);
> ...
> }
> 
> >  	int (*fn)(struct hist_browser *browser, struct popup_action *act);
> >  	struct map_symbol	ms;
> >  	int			socket;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260716072351.560311-1-irogers@google.com?part=8
