Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F93472521
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789603081; cv=none; b=dZInV8CjOx6w0/jxElpQBQUndLeKHA+kXSunemw/phOkqkqtllEENGhyWIE90G2O7yORPtW6ugrtz9+OrWDy/gpJN2Wf42HmQu7hGQtmyyHDrVo6CP6jOW7hVf+iIQKTY8PZvh4x/euNnZJ1Kxf4d2hXl2X9dUeNUXQwVm5Ro+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789603081; c=relaxed/simple;
	bh=+b7ODtebdiLFmT1wglyRCSJHQ87j31WtDVRNZVeRF0c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MJmPTuNjsOqF0OpBSUnpxXcgiUc9lFHNFmkfOV8QAdCET4sUqtv97YowbmULP/jGf4t+X4+rGgcYbbRc6Gtx4Bpxb837Vsx8Sm+Ipj/wUvhphfRQNVascEMmHrzf4CRylaKhKSilpY1iBePI6w6tJlsIeA3t/33p7KKyDVnYw4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fx/P5v4R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fx/P5v4R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F22C1F000FF;
	Wed, 16 Sep 2026 23:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789603080;
	bh=dHUwsLvqp1l3XvVgso2PsxY2C7KDvuS9fQPvsfHpRLA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fx/P5v4RIx3F3qzM+cg7FWzUhe5Q4XPjvlCo60EuwNfUJwK3zbnWvh0Ld47pcy+dZ
	 pp3YSoly5qVFE1vmNXZ7BIkFLcoLlxRaba0Xl5+/peWmeQ13aA4W0+Y2OkAJNwzQcT
	 89qJW8tFBUdx71HO94G9swugJ8oCfaDeNTXf/qIQkFbxkGXwlEwQNqOx1CQmv2LWRK
	 uapiK9GkjnYdRFoEshPiXYVoZ49AuDmk08IGO+je23v/oxXA3MZiP7SLdH6u5tUgOb
	 Yg5qFjZKADoMEyLE7cQxMQnxt1EDelUBP93BytpKr0oWEmCNy7DblWpEyjdn24AMPr
	 iULC2tLciahrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/9] perf config: Add core.hybrid-merge to configure
 event merging
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916234652.439778-8-irogers@google.com>
References: <20260916065248.3153556-1-irogers@google.com>
 <20260916234652.439778-1-irogers@google.com>
 <20260916234652.439778-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 23:57:59 +0000
Message-Id: <20260916235800.5F22C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: spurious hybrid-merge warning on non-hybrid machines when =
configured globally
--

commit 8278af13a38e06a26581491ef0fd6844e19d37a9
Author: Ian Rogers <irogers@google.com>

perf config: Add core.hybrid-merge to configure event merging

This commit provides a core.hybrid-merge configuration option in
.perfconfig to enable hybrid event aggregation by default. It allows
users to avoid passing the --hybrid-merge flag on every invocation of
perf report or perf top.

> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index b2972c35c1eca..8fe43b032e9af 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
[ ... ]
> @@ -470,6 +470,16 @@ static int perf_default_core_config(const char *var,=
 const char *value)
>  	if (!strcmp(var, "core.addr2line-disable-warn"))
>  		symbol_conf.addr2line_disable_warn =3D perf_config_bool(var, value);
> =20
> +	if (!strcmp(var, "core.hybrid-merge")) {
> +		/*
> +		 * Note, this is for sampling tools like perf report and top.
> +		 * perf stat has its own merging options and the
> +		 * stat_config.hybrid_merge of "perf stat --hybrid-merge" is
> +		 * deliberately not set here.
> +		 */
> +		symbol_conf.hybrid_merge =3D perf_config_bool(var, value);
> +	}
> +
>  	/* Add other config variables here. */
>  	return 0;
>  }

[Severity: Medium]
When core.hybrid-merge is set globally to true, will this cause spurious
blocking UI warnings on non-hybrid machines?

In both __cmd_report() and __cmd_top(), there is existing code that evaluat=
es
symbol_conf.hybrid_merge. For example, in __cmd_top():

	if (symbol_conf.hybrid_merge) {
		if (evlist__can_merge_hybrid(top->evlist, /*env=3D*/NULL)) {
			evlist__merge_hybrid(top->evlist, /*env=3D*/NULL);
			evlist__merge_hists_hybrid(top->evlist, false);
		} else {
			ui__warning("--hybrid-merge: no events to merge across core PMUs\n");
		}
	}

If symbol_conf.hybrid_merge evaluates to true based on the config default,
running perf top or perf report on a non-hybrid system evaluates
evlist__can_merge_hybrid() as false and triggers this warning.=20

Because ui__warning() can create a blocking popup in TUI mode requiring user
dismissal, does this break the usability of the tool on generic systems?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916234652.4397=
78-1-irogers@google.com?part=3D7
