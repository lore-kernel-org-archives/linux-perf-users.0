Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25662E974D
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 03:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783652857; cv=none; b=UyCOlVxiuYGtPhU/G/YIGKN8YlfEsjxTxF4Rpn02PMAShHXZ2vPdlOjgkVIYpnFgZsj9DyBtbzKC2m8TMfHQ+I1phMwWAWiqwwgJ/sCB2hCz8+tgXwpDgbT4JR43znA6s0RvglGpMlVLQ1gNI3yXam5JMH1SFVja8sTK+N579J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783652857; c=relaxed/simple;
	bh=yJQKr37wuBl3zA6VcGn+FZFc5fnyG5QsKDqMcStI+FE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kIH2bXiV+df+PL4Tqw6xElI4/dtbZmSxp8MOyUri+1Qde85QA6IVVu2AxjTIM/FATGMPLFgpOlEDVyQG0JCRJt7xz3OWDFfSNLA16aaQON/jDzKQ8lf9S35vzc3621BKxzkWE/pE+H9wbMC1RREh0wp1DCJ42XmNwEz5pDaHH5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOOA+WH6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOOA+WH6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504241F000E9;
	Fri, 10 Jul 2026 03:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783652856;
	bh=t25+bRbrUZ1WBam2xjsCJHzne9pvIlDgtAwWxCHa4HA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aOOA+WH6EOEZDu5kXyjsD35jWhjr0e+/U2UJmVHndQU0QFLztyB0OPbLgljlVcmv7
	 P9VFT1BlZX3UIUNwV7uBPSoxKwJDHTdkZNYcsCEGkTiZ+UAQsUKWQbO26eKCTV3WJZ
	 sfuN/AQDcYdUC44r46DTUHncnmkFeXYcz24O1TNl+L/sXlkwaGveUE66pjRxr5UW2Y
	 A+zbGR1SGnJ4mBf/8BZI+P1j9Tm5uipZDEqbiFL0OyPicSmcOLp8d/Jxome5VuclP7
	 1pc9NDF3oa4UXsQoGWCQ8HtiVppJZvjmqmwjsIUUuGrpoFYmi4iB1BerUI/4iHdqOp
	 CHiPEKK/I1VDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/9] perf ui hists: Fix dso_filter reference leak and
 exit cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260710024952.1668911-6-irogers@google.com>
References: <20260709165220.1411149-1-irogers@google.com>
 <20260710024952.1668911-1-irogers@google.com>
 <20260710024952.1668911-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 03:07:35 +0000
Message-Id: <20260710030736.504241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Clearing filter pointers on browser exit without reverting the cor=
responding filter state permanently corrupts the UI and histogram entries.

Pre-existing issues:
- [High] The `hists->symbol_filter_str` pointer is dangerously assigned to =
a local stack array `buf`, resulting in a dangling pointer when the functio=
n returns.
--

--- Patch [6]: [PATCH v4 6/9] perf ui hists: Fix dso_filter reference leak =
and exit cleanup ---
commit 817d491dc7ee2892f5d2ddca3b8801a25555bb12
Author: Ian Rogers <irogers@google.com>
Subject: perf ui hists: Fix dso_filter reference leak and exit cleanup

This commit aims to fix a potential use-after-free defect and reference
leak in the perf hists browser. It ensures dso_filter references are
properly acquired and released, and safely clears filters upon exiting
the browser.

Closes: https://lore.kernel.org/linux-perf-users/20260709170834.52F1A1F000E=
9@smtp.kernel.org/

> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
[ ... ]
> 				hists->symbol_filter_str =3D *buf ? buf : NULL;

[Severity: High]
This is a pre-existing issue, but might assigning the long-lived
hists->symbol_filter_str pointer directly to a local stack array (buf)
cause a use-after-return bug?

If the browser is re-entered, or in perf top where a background thread
continuously processes new samples and re-evaluates filters via
hists__filter_entry_by_symbol(), it will call strstr() on garbage
stack memory.

Could this lead to random filtering behavior, information leaks, or
crashes?

[ ... ]
> @@ -3450,6 +3451,9 @@ static int evsel__hists_browse(struct evsel *evsel,=
 int nr_events, const char *h
>  	}
>  out_free_stack:
>  	pstack__delete(browser->pstack);
> +	thread__zput(hists->thread_filter);
> +	dso__put((struct dso *)hists->dso_filter);
> +	hists->dso_filter =3D NULL;

[Severity: High]
Will clearing these filter pointers without reverting the corresponding
filter state leave the interface in a corrupted state?

When a user zooms into a dso or thread and exits the browser, the active
filters are nullified here but the histogram entries remain filtered
(he->filtered) and columns remain elided (perf_hpp__set_elide).

When the user re-enters the browser, they are presented with a filtered
view but have no way to 'Zoom out' because the filter pointers are now
null, replacing the 'Zoom out' menu options with 'Zoom in'.

Could this permanently break the browser functionality and corrupt the
persistent state of the hists object across browser sessions?

>  out:
>  	hist_browser__delete(browser);
>  	free_popup_options(options, MAX_OPTIONS);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710024952.1668=
911-1-irogers@google.com?part=3D6
