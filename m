Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AF9277C88
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 03:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783652703; cv=none; b=Sl7HEcq5zzlD25eeDv7tmZG/Hpf2LCsP5+ShdjAk5whlWVOvghw4t1rP5DonTDvXdZIiRNQR0IJNbi7EUYxNrIyGFZnw0ZuwujbEYWChE2VU7ZSFigpZjdABXgcyRjgPQPCJ1jyps73X8ixfz4rMdnUHi01fm233orE0YyddEB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783652703; c=relaxed/simple;
	bh=lp3fbqTPmwpRxenRUXpYALFbzzGUD4jvtexwzoJoNHc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mVYAT7AN8GdDanqzozpii2NTchI4z708k6XUYb31ndQzSB2WRlGoiBJveE1xkBRLaLHADesklgrY9BdVKvAoyFmy3+4WM0kGF+cG5I/59p839S8b5XGpB/SLzXKJSEHRlprgtiQgkA6BO+ILgaFlNv2qi5QgRQ0lQwG0baB9UnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSHPUV6V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSHPUV6V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64D81F000E9;
	Fri, 10 Jul 2026 03:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783652702;
	bh=MPPgVC3Ko+9p88mKPILHubiNPsMcGNvQQ+5LPxKxpNc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SSHPUV6V+M9n7/4h0Xu/AYrfRjxhL5AxJcEPICXZ9zpWfaymeEQJEXO4W93jK7p9+
	 AVcqYm3nKFVNZtOzgrWIdtgS/TLlkvAdQ9Auc4CuH11+Gx2sFsyMAD/BoVegoh4+8y
	 tVnjwqD2c5F4G6c/d/Lf0spQVjPotDBoQ1HFn1uciRI+pexSLbXYSQ6VAeZqXo6bM2
	 ml6IXVsm8xmnjd4iFnT6YeQq191oYH5gN6NLSgV8PNiNCFbBkU79qttZWZiImFuKQH
	 62p7FlXmqdvb2GlZOFDNce84nwq0N0PxulUDjC2RpLxa/Zr4jD6M+Esg/tUioYS8nD
	 R0eJ+koFxIEBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/9] perf ui hists: In report UI ensure thread is set
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260710024952.1668911-2-irogers@google.com>
References: <20260709165220.1411149-1-irogers@google.com>
 <20260710024952.1668911-1-irogers@google.com>
 <20260710024952.1668911-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 03:05:01 +0000
Message-Id: <20260710030501.E64D81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit intentionally uses raw pointer assignments for refere=
nce-counted structs, violating the subsystem's explicit lifecycle guideline=
s.
--

--- Patch [2]: [PATCH v4 2/9] perf ui hists: In report UI ensure thread is =
set ---
commit bd1f6d1690697868f7f32902eeee4100a0837b56
Author: Ian Rogers <irogers@google.com>

perf ui hists: In report UI ensure thread is set

This commit populates the map_symbol thread in the UI code to fix the
e_machine lookup for cross-platform disassembly when using the annotate
action.

> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> index 671961946d56c..c6cfbcc580617 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -3155,10 +3155,12 @@ static int evsel__hists_browse(struct evsel *evse=
l, int nr_events, const char *h
>  						continue;
> =20
>  					actions->ms.sym =3D symbol__new_unresolved(bi->to.al_addr, bi->to.m=
s.map);
> +					actions->ms.thread =3D bi->to.ms.thread;
> +					actions->ms.map =3D bi->to.ms.map;

[Severity: Medium]
The commit message notes the intentional use of raw pointers to avoid having
to clean up references. However, does this violate the perf subsystem
guidelines which strictly require using explicit thread__get() and
thread__put() lifecycle helpers for reference-counted structs like thread
and map?=20

Could bypassing the reference counting abstraction here make the code more
fragile to use-after-free defects if the lifecycle of actions->ms.thread is
modified in the future?

>  				} else {
>  					actions->ms.sym =3D symbol__new_unresolved(browser->he_selection->i=
p,
>  										 browser->selection->map);
> +					actions->ms.thread =3D browser->selection->thread;
> +					actions->ms.map =3D browser->selection->map;
>  				}

[ ... ]

> @@ -3173,6 +3175,7 @@ static int evsel__hists_browse(struct evsel *evsel,=
 int nr_events, const char *h
>  					continue;
>  				}
> =20
> +				actions->ms.thread =3D browser->selection->thread;
>  				actions->ms.map =3D browser->selection->map;
>  				actions->ms.sym =3D browser->selection->sym;
>  			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710024952.1668=
911-1-irogers@google.com?part=3D2
