Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CC03546F4
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789968424; cv=none; b=oZtS1JSWcADpBI19YB7ZHJOg9g+gaX3iXfq610Zfx+tPUSyaiQUqvdGv+Jk9INPyBFo36PE2C5M4pujYQCsbaLaJVfsC09oS651tB6fC/vhPaAOxtqYYD7p26+b85Cb+dRj0Y02ac7KH1MvV8eyHjmV44Vt6x4u45Z/I1DadQHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789968424; c=relaxed/simple;
	bh=UDKLfnzCpvjHyuTlnqxqnApT6o50m1I1v+nzPOccrdg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fPE82q09AOwfhsQTUQxkm4lp+rKESTrvyCoaop3b+nPkgYXfvus+OyyARq0e/riugu/gZ8b3xMlhDz3zdYomn+AuIwlY1SLRHZkmiZEWofmnDA2Y+U4mMZcmeqUfZ3W83/mxKCypaSWly7YRNUTOKjeukQm0fF7kk3rHJzWgVCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5mScdfI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5mScdfI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5F71F000FF;
	Mon, 21 Sep 2026 05:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789968419;
	bh=k0wSdLI9n+rKmrj4AitWTMdGFmQ2Y11NxsI0UPFTlDQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X5mScdfITwbM+c+2n/Ew+WsD/xYMyFMfyGohT6E2T18bdbsxzTh/fqRsGqhxy6/A9
	 o+Uz1wP+SBo53Rj7S8AjTmaRBrGBPoe/RW7B/ktmZ8IOJD5SusXUQG+4yurXZ0TLbQ
	 iv1S9iGwxK6uKlKIIf6tGO7Qo+p1kXD438muuaCimR5Pg18Io42GXNY1ghyU0rMPCo
	 UZiUHP/IGMtNGKv7LPbBoSnirCUeebm0lCLPJ2/jkkTp0gp2lQkaP3LkqnXdvwSUIs
	 iV+slKxDnJHw6AQX6oDt0SLKJ7By6ojx2uRd3nk7XHzt+9uttmaFmbTeqZOPennoWX
	 0oky+fUeBvvjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/49] perf pmu-events: Clean up mypy and pylint
 issues
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <b6b829bfc40d1478a0ab73c69018c33e49221718.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <b6b829bfc40d1478a0ab73c69018c33e49221718.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:26:59 +0000
Message-Id: <20260921052659.9C5F71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Clean up mypy type errors and pylint warnings across the pmu-events Python
> scripts (amd_metrics.py, intel_metrics.py, jevents.py,
> make_legacy_cache.py,
> and metric.py) in preparation for making MYPY and PYLINT build tests
> opt-out.
>=20
> In addition to type annotations and unused import/variable cleanups, fix
> three bugs in intel_metrics.py exposed by static analysis:
> - Fix references to undefined 'args.model' (instead of '_args.model')
>   inside
>   try/except blocks in IntelL2() and UncoreMemBw(), which previously threw
>   NameError and silently disabled Skylake/CascadeLake L2 silent eviction
>   adjustments and uncore memory bandwidth JSON loading.
> - Define DC_WB_U and DC_WB_D before their first use in IntelL2(), fixing
>   an UnboundLocalError that silently dropped the l2_out_rate, wbn, and isd
>   metrics.
> - Fix Event-to-string comparison and addition in IntelFp() by comparing
>   and modifying 'f_assist.name' instead of the Event object 'f_assist'.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D11

