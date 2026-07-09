Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9442F8EAD
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 17:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783616926; cv=none; b=j65+UYaw1/ZcEi0GZP1nWhjSMqTlXNutNf+V9VuDw5St33gpKiq0iCAF80hjacazTKK4cb1NiFPH5yAFamTOTa/oBzcd6x4tgVkVUI+GoftkTwli9jmrTEwkvqWiY7p+AoTmNjz+op0DfKaiCfp96XWpV1dyT/Ju0asD0Ea5m/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783616926; c=relaxed/simple;
	bh=3Fv+DR3GORz8ovW6SqvxK5KAt0oX2CpHYHA0uJw3kKk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a3oavl7OYjXEqMeH3Ec2IJvqCfUyX+OE4rvNfJent625ifC23QYGQ9pwbLulK9IktpbNCKEhyuHy82DsX/cDgBK1LlYLKema3qQlMoE/Q5mHrJH+2J09PLipaK8QlbjYNEqOipGzjNcYulHP+45EEuyw/0y+fIAC5zU5gPZ7FP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbWKHTMO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbWKHTMO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39651F000E9;
	Thu,  9 Jul 2026 17:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783616925;
	bh=GqLTqF4MRMPemOqStanOkoq+aepqf3dXmhJ74Laavog=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TbWKHTMOj8E1KRs0GaJkPO6U+gR7StwkhtSWUdrHZUSIkyDLXMCheadcJgFvjja0L
	 K8OM+oYSJlYKVsHtTKyHDy49wPtL3uBBK6WD6Wdknh2B3R0aRqpd3QcwghLZBJ14yl
	 JSJVLKuwp6A8SUTHKbN4jfHdirrPfTbf5AKu59oJgqyW1n2zHqdfZwEsWGlVabrdNW
	 wuoG0o3EcIbUHw0QnKlegc1qHaU/iSU78KlqFwbResDnKQaRsvwDSHJTA4u0yl1anU
	 xXZhaAKKDfOxp61rJtfsRMTOjzCk6rHBDUavgm75c80iFcUfIoGk6r8bqWHPvf1Irm
	 W+M91MxPAdrMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] perf ui hists: In report UI ensure thread is set
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260709165220.1411149-1-irogers@google.com>
References: <20260709033701.1117943-1-irogers@google.com>
 <20260709165220.1411149-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 17:08:44 +0000
Message-Id: <20260709170844.F39651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Stack buffer overflow in `evsel__hists_browse()` due to unboun=
ded popup menu options
--

--- Patch [1]: [PATCH v3 1/4] perf ui hists: In report UI ensure thread is =
set ---
commit 6b0cc8c7dd2c933b2c9f1bf775218027677c766a
Author: Ian Rogers <irogers@google.com>

perf ui hists: In report UI ensure thread is set

This commit populates the thread field in map_symbol within the hists brows=
er
UI to fix cross-platform disassembly. It intentionally uses raw pointers for
thread and map to avoid reference counting issues tied to the bounded lifec=
ycle
of the actions array.

> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -3155,10 +3155,12 @@ static int evsel__hists_browse(struct evsel *evse=
l, int nr_events, const char *h
>  						continue;
> =20
>  					actions->ms.sym =3D symbol__new_unresolved(bi->to.al_addr, bi->to.m=
s.map);
> +					actions->ms.thread =3D bi->to.ms.thread;
>  					actions->ms.map =3D bi->to.ms.map;
>  				} else {
>  					actions->ms.sym =3D symbol__new_unresolved(browser->he_selection->i=
p,
>  										 browser->selection->map);
> +					actions->ms.thread =3D browser->selection->thread;
>  					actions->ms.map =3D browser->selection->map;
>  				}
> =20
> @@ -3173,6 +3175,7 @@ static int evsel__hists_browse(struct evsel *evsel,=
 int nr_events, const char *h
>  					continue;
>  				}
> =20
> +				actions->ms.thread =3D browser->selection->thread;

[Severity: Critical]
This is a pre-existing issue, but does the unbounded accumulation of options
risk overflowing the actions[] and options[] arrays on the stack?

Looking at evsel__hists_browse(), the arrays are fixed to MAX_OPTIONS (16):

tools/perf/ui/browsers/hists.c:evsel__hists_browse() {
    ...
#define MAX_OPTIONS  16
    char *options[MAX_OPTIONS];
    struct popup_action actions[MAX_OPTIONS];
    int nr_options =3D 0;

Later in the function when building the popup menu, there is a long sequence
of add_*_opt() calls without any bounds checking on nr_options:

    nr_options +=3D add_annotate_opt(&actions[nr_options], ...);
    ...
    nr_options +=3D add_annotate_type_opt(&actions[nr_options], ...);
    nr_options +=3D add_thread_opt(browser, &actions[nr_options], ...);
    nr_options +=3D add_dso_opt(browser, &actions[nr_options], ...);
    nr_options +=3D add_callchain_toggle_opt(browser, &actions[nr_options],=
 ...);
    nr_options +=3D add_map_opt(browser, &actions[nr_options], ...);
    nr_options +=3D add_socket_opt(browser, &actions[nr_options], ...);

If enough of these conditions are met simultaneously (e.g. branch annotatio=
ns,
type, thread, DSO, callchain, map, socket, and multiple scripts), couldn't
nr_options exceed 16 and corrupt the stack?

>  				actions->ms.map =3D browser->selection->map;
>  				actions->ms.sym =3D browser->selection->sym;
>  			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709165220.1411=
149-1-irogers@google.com?part=3D1
