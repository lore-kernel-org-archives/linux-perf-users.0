Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868B339021C
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 23:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783555115; cv=none; b=AbDDJdLQSoMhICRhtXSM4F/ENsTLGOy15EybxW87sLcRP+aqR4iDJjpuQaQeiIArT3n2g8pSQ/oRC00YlmxsbyMwQGFVsdJ8F6SMaqzkypf/IPz0tSI+MpV0hl+Q4x0H/TmMuG8KWbuTMnq0faA0cDzRbbPj5Ob2qtlG7R/KrrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783555115; c=relaxed/simple;
	bh=Br+GM9lgAg5NTtd3ni9IodKiIobhiBeGdSTLawIPJLU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UcO/pEwvatAJiFuwLjCdrozrzx33J07k4ilQGIya5He4arZmdo4oufdWTUHTpSipWky7qSecNnrGe9zFJSHBB0eOpuERrP8g+ixA1NBUjosKOdGcJ8cSfzGTdM87SF+lQ2uugav8WCaxJkeA+lj+ADZu5/1YQ0KjVAdpAfEgxQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LasYYiZh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LasYYiZh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB771F00A3A;
	Wed,  8 Jul 2026 23:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783555114;
	bh=lytwGO4+qmhlv7+oBvZyU5YM9etYIFFmB7Bi2COR1aQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LasYYiZhZK5Uuw28gscmIvoFFGdMzrwntNltu3ykmfyMXuZOHHRisF0o3++dIDqsn
	 qzBUoUj9atrWUeT8HnbX42gEQaMMXuw+1kQQcJwZRTln9/l9Dh3YE+dMM9kejDuRZf
	 l5dSrNSB0ywsoV08IvHqavOSCTc+f5Wb90cFviEtB2nO/5JTbR5JaR1ZPzhwlAKeks
	 b8feWnqVauheXNPBzpYS1y3UzuS07KljN58XTBgsv0eXnhO/CpmPGEkGqZ5AhmEiSO
	 qUtaiwe+xMGgC9ej6v+RGkeCGDvHaXyMef11zPNTwzY17GJq+xuo92Kx0YGSe/Co/x
	 KbYr5uzRCyWlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/3] perf ui hists: Remove duplicated thread in
 popup_action
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260708234646.1040003-2-irogers@google.com>
References: <20260708234646.1040003-1-irogers@google.com>
 <20260708234646.1040003-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 23:58:33 +0000
Message-Id: <20260708235834.3FB771F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Stack buffer overflow due to out-of-bounds writes on `actions` and=
 `options` arrays.
--

--- Patch [2]: [PATCH v1 2/3] perf ui hists: Remove duplicated thread in po=
pup_action ---
commit 8f959fa67798b84a03f0c7cd56908afc452f4cc7
Author: Ian Rogers <irogers@google.com>

perf ui hists: Remove duplicated thread in popup_action

struct popup_action has a thread but this is duplicated in the
map_symbol. Remove the non-map_symbol version so that there's only
ever 1 thread with a popup_action.

> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> index 6353be9dba865..a93846b8dc885 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c

[ ... ]

> @@ -3305,7 +3304,7 @@ static int evsel__hists_browse(struct evsel *evsel,=
 int nr_events, const char *h
>  				 */
>  				do_zoom_dso(browser, actions);
>  			} else if (top =3D=3D &browser->hists->thread_filter) {
> -				actions->thread =3D thread;
> +				actions->ms.thread =3D thread;
>  				do_zoom_thread(browser, actions);
>  			} else if (top =3D=3D &browser->hists->socket_filter) {
>  				do_zoom_socket(browser, actions);

[Severity: High]
This is a pre-existing issue, but can this code overflow the actions[] and =
options[] stack arrays later in evsel__hists_browse()?

The arrays are statically allocated on the stack with a maximum size of 16:

tools/perf/ui/browsers/hists.c:evsel__hists_browse() {
	#define MAX_OPTIONS  16
	char *options[MAX_OPTIONS];
	struct popup_action actions[MAX_OPTIONS];
	...
}

Further down in the function, nr_options is repeatedly incremented without =
bounds checking:

tools/perf/ui/browsers/hists.c:evsel__hists_browse() {
	...
	nr_options +=3D add_annotate_opt(&actions[nr_options],
				       &options[nr_options],
				       &bi->from.ms,
				       bi->from.al_addr);
	...
}

If a user executes perf report with specific arguments on a crafted perf.da=
ta file, couldn't the number of options added exceed 16 and result in a sta=
ck buffer overflow?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708234646.1040=
003-1-irogers@google.com?part=3D2
