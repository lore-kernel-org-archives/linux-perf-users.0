Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F4E399360
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783617032; cv=none; b=Kz60qzRRzlf1Lfl08svkly6dFm7EYKUzhlY3Qu6wyN3qmOA3OHtqxR6+AJq+eLKjpw7UKpioxAU2LWEfkobisDvVT1iorYVw5D4rSojUDRpN7iN+O5EtCijwW6owDml/qpwRdD7gR/EAtS2OiLDVUwhzcR+DetIIJtQGw0KRAjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783617032; c=relaxed/simple;
	bh=ZGZcqmzUdYI+XzuJvskggLlGFZ4TXa2K1Ybdp0o/+J4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tjsPBxcYOv70/voU5+sG8XSiuhYjoKYActQahLZs3d0/fgKHfNvnrxewR3BcPNBc23gqlKY4CboNvu8GrNyPoKVKk44DpWFOAPaYwjo/0JppUQyx8ZStmw+xAMgYjEAxjVE1gPms43Hjm7abdzB/4xgeiUAAMG2hbkc3Djkacxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rco87PT2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rco87PT2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9721F00A3A;
	Thu,  9 Jul 2026 17:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783617031;
	bh=fy7XzA4Du+ocF7FdrJDmrQUThr5px2/qXJPwmCofQ9g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rco87PT23J9HlVc7cKhejyWAwK9CQjxKR5T0xWIFUgMRjckFIM4LOkoG5F6nRCO5d
	 n9VLyJy2lwbAeDk2iDBapch4+QlBRssLpOV3zHqcK9vBTXo4M9+bprNB9GiUkusCze
	 TsZu877YYMTGEX/IHKvL4Hjrl04x5k+Py8VQlmWYAN0kHZwXF+6R+YWFzJWXBVZn53
	 tb/0ZsrjUiZ0dns7X8XdzqmHs+wbh3/qJ1+CUWx1Aj5ot31iXvMo0w4OqdYm+AMYy/
	 4/mn+ttG0P0eokiOqv/Wmoek5wJJYqZVYzMHeOBcptZ6pd21LzOE3y0fVWSfdeEBO+
	 Pa0vfV4yfIm3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] perf ui hists: Remove duplicated thread in
 popup_action
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260709165220.1411149-2-irogers@google.com>
References: <20260709033701.1117943-1-irogers@google.com>
 <20260709165220.1411149-1-irogers@google.com>
 <20260709165220.1411149-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 17:10:30 +0000
Message-Id: <20260709171030.9C9721F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Stack buffer overflow in `actions` and `options` arrays due to unb=
ounded option additions.
--

--- Patch [2]: [PATCH v3 2/4] perf ui hists: Remove duplicated thread in po=
pup_action ---
commit 72bd59b6c2f43a82a793219b81133029ab0f3b61
Author: Ian Rogers <irogers@google.com>

perf ui hists: Remove duplicated thread in popup_action

This commit removes the thread field from struct popup_action as it is
duplicated in the map_symbol structure. This ensures there is only ever
one thread associated with a popup_action.

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
>  			} else if (top =3D=3D &browser->hists->socket_filter) {
>  				do_zoom_socket(browser, actions);

[Severity: High]
This isn't a bug introduced by this patch, but looking at how the actions
array is populated in evsel__hists_browse(), is there a potential stack buf=
fer
overflow here?

The options and actions arrays are statically sized to 16 elements on the
stack:

    #define MAX_OPTIONS  16
    char *options[MAX_OPTIONS];
    struct popup_action actions[MAX_OPTIONS];

Later in the same function, under the skip_annotation label, the code
unconditionally appends menu options using a sequence of calls like:

    nr_options +=3D add_annotate_type_opt(&actions[nr_options], ...);
    nr_options +=3D add_thread_opt(browser, &actions[nr_options], ...);
    nr_options +=3D add_dso_opt(browser, &actions[nr_options], ...);

Depending on the flags and data available in the perf.data file (such as
data type annotations, threads, callchains, and time sorting), couldn't this
sequence of additions append up to 19 options, exceeding the 16-element lim=
it?

Because the options and actions arrays are allocated adjacently on the stac=
k,
could writing an asprintf string pointer past the end of the options array
directly overwrite the fn function pointer of actions[0]?=20

If the user then selects the first menu option, could this result in a cont=
rol
flow hijack when the program dereferences and jumps to the heap string poin=
ter?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709165220.1411=
149-1-irogers@google.com?part=3D2
