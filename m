Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C68535975
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 03:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783569267; cv=none; b=dUh9/6Bs/bJcVnReVpBFQr9odY/NOCuWxQYeRE/sy08DiankXVgixjUad7mubqKUuzq5VewtlqprKILQiyeZSqpYOiIO7ruppxqMVktyW5/SctzJ9xuA+r5tZ38rwxWXqSQDh6JoXKwyQkTSSCGNinRthbWLFLO/l2DNhd4kaak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783569267; c=relaxed/simple;
	bh=ImgEzAwzWw0YLO3svQhTRQLFzXeiHJwrYXPb8zKC4Q4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Al+WdD5AjCs2OvTppMSfn4ZCBmncrCNIBXl+ZVhoOiINIHH8D7l2URmaSsxUtLoQDmDn63mBO6xaj3q+s4r/L5xNhPGaAydRnhopgQh442zjWbb9Y2cjb0Qb0Wv9OF6z7E3/8Au2bpwi7BZ3CX50sRpiwdwPOT37mFg4eHz6Pkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9ulZQwp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9ulZQwp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FD91F000E9;
	Thu,  9 Jul 2026 03:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783569265;
	bh=Fdh+OiKPvjPuSc2zSaZiDTiVUlQk45wYcL5sqZDBb84=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W9ulZQwpglZM05uRnC2EZyjqXwCRJavTE9TSrWe2JcOf8mmVLxFxcACtq066R0jyK
	 o5bpXHEIwPb+ojPw4nFFQ8FHWQ50jb9Ptd8HG2EcrTOZkX58q85LvOpszUrwxuR4ic
	 HLvRp1n47KsqVgMGLIBAPtARyza01UUShwd0Hp99IILWjN5mPOX/auh78Y1I5hNclt
	 t85kfPkuQ59VgO84srcn6hw0nSQ1H5m7gf4E9VX4SpQrb3RLXI35OdQNrkDlhOst/v
	 p+rrgmFVbcDtxGsULRG9E3kQKLHdOfUIrDSiUaTOSFkf9gGhyLFL69ejJtyuvb5eMr
	 7K8opRHP8uJjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] perf ui hists: In report UI ensure thread is set
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260709033701.1117943-1-irogers@google.com>
References: <20260708234646.1040003-1-irogers@google.com>
 <20260709033701.1117943-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 03:54:25 +0000
Message-Id: <20260709035425.B7FD91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Raw pointer assignment of reference-counted `struct thread` bypasse=
s lifecycle helpers.
--

--- Patch [1]: [PATCH v2 1/4] perf ui hists: In report UI ensure thread is =
set ---
commit 62729234032d27123f3a006298cb693ab486e133
Author: Ian Rogers <irogers@google.com>

perf ui hists: In report UI ensure thread is set

This commit populates the map_symbol thread in the UI code to fix the
e_machine lookup for cross-platform disassembly when using the annotate
action.

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

[Severity: Low]
This isn't a bug, but should this assignment use the thread__get() lifecycle
helper? I noticed a raw pointer assignment for the reference-counted thread
struct here.

>  					actions->ms.map =3D bi->to.ms.map;
>  				} else {
>  					actions->ms.sym =3D symbol__new_unresolved(browser->he_selection->i=
p,
>  										 browser->selection->map);
> +					actions->ms.thread =3D browser->selection->thread;

[Severity: Low]
Should this use thread__get() as well?

>  					actions->ms.map =3D browser->selection->map;
>  				}
> =20
> @@ -3173,6 +3175,7 @@ static int evsel__hists_browse(struct evsel *evsel,=
 int nr_events, const char *h
>  					continue;
>  				}
> =20
> +				actions->ms.thread =3D browser->selection->thread;

[Severity: Low]
Should this also use thread__get() instead of a raw pointer assignment?

>  				actions->ms.map =3D browser->selection->map;
>  				actions->ms.sym =3D browser->selection->sym;
>  			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709033701.1117=
943-1-irogers@google.com?part=3D1
