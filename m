Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8F538757B
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 03:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783569167; cv=none; b=IhBZaDIAWyjNomopEamiLJwayRnPL6/aHceZ18amKLbuSgTXiX6Up9Vy5JxuggZfdjq9AhAM8r7h5KaTZh1ay8BTm9fMdL4Nu3fojGFnN4ZxqRz5hptUGD/nvUPr04KCHeq0FqdPofl872h2CS5SLyGQ+DNQLsNmeNivwDFzJbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783569167; c=relaxed/simple;
	bh=swCSDMLxjlZigE4y5T50GPC/FWOipHhURT3WOE6Dgvg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EsnWmVhswPLVPUN1prpcIh7+vV5zIO14wE+Bf6NZVHvQkZFzGLAbN564wT/IQ2g864a1kwXBBg7GynzriIezzu1ZFkC01TqIga80gzKCzby8AmZGe8QchXThI0DyCuVWyw9Mu7OaYYRkG2r/LyuCoJsTId1hMsgWWy7jJ4QFHV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGdNFyok; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGdNFyok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F131F00A3A;
	Thu,  9 Jul 2026 03:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783569166;
	bh=/4veqVcBrBsZqpkEXzMCuOifhmL3Cx/yfIviM1aWiSA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VGdNFyokdjtqVJCRFQV8++SqEjSMJcFI4a+DGYnnj9tcwYOHDHJubIqau5PAeR1rT
	 vQCmZqr44jgNyXggWiM/2QMp1i5j5fLnnIsPbYvaO8Bc5mzh6rfG7EBG9o0QiXa2Wz
	 +RKOzyUi5rnlPm/Qa2hgt1+n7eZIl9M5iPugHM5bIIQgFGaB0XpH9pWNQRmuYGvjFt
	 hYcghGnpGqH13POc7tLhsz+QnWSiRYCZsi3/Zo+C1vBLOJRNkmK7dz8TrrS2UIYr4d
	 0QkIT+UKH2VEonDI9YHEJJ8BuC75fkMS8Hcaxn2j69ujTH3glhUxO7BbVTpcQm9WXQ
	 6diBi3ZLko00Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] perf ui hists: Remove duplicated thread in
 popup_action
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260709033701.1117943-2-irogers@google.com>
References: <20260708234646.1040003-1-irogers@google.com>
 <20260709033701.1117943-1-irogers@google.com>
 <20260709033701.1117943-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 03:52:45 +0000
Message-Id: <20260709035246.35F131F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbounded addition of popup menu options leads to a stack buffer o=
verflow.
--

--- Patch [2]: [PATCH v2 2/4] perf ui hists: Remove duplicated thread in po=
pup_action ---
commit 52ae50056f9a85a49a481078d9bef28046659aff
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
> @@ -3202,7 +3201,7 @@ static int evsel__hists_browse(struct evsel *evsel,=
 int nr_events, const char *h
>  					   verbose);
>  			continue;
>  		case 't':
> -			actions->thread =3D thread;
> +			actions->ms.thread =3D thread;

[Severity: High]
This isn't a bug introduced by this patch, but is there a potential stack
buffer overflow in evsel__hists_browse() when building the popup menu?

It looks like the options and actions arrays are defined with a fixed size:

tools/perf/ui/browsers/hists.c:evsel__hists_browse() {
    #define MAX_OPTIONS  16
    char *options[MAX_OPTIONS];
    struct popup_action actions[MAX_OPTIONS];
    ...

However, when interacting with the UI on complex profiling data, various
add_*_opt functions append elements and advance nr_options without bounds
checking:

    skip_annotation:
        nr_options +=3D add_annotate_type_opt(&actions[nr_options], ...);
        nr_options +=3D add_thread_opt(browser, &actions[nr_options], ...);
        ...
        if (hists__has(hists, sym) && browser->selection->sym) {
            nr_options +=3D add_script_opt(browser, &actions[nr_options], .=
..);

Could this write out of bounds if the total number of added options exceeds=
 16?

>  			do_zoom_thread(browser, actions);
>  			continue;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709033701.1117=
943-1-irogers@google.com?part=3D2
