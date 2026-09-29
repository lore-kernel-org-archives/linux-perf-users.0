Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17C75519A9
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790713465; cv=none; b=IWxBMRwsnz+NzPaoEYq4jPHpm6XRRK10m9Mwz9D5tDBcHR5OvrZYWHHLfvpv1YAOid2+0Lk4IQsMuYZknJcSTsTmguTGQsEt5BI18TpisP3yNQQjRwxHyFpGWGqep3fTCQyPFf0SiX/kuEn6Dm6Aw6jCRFVG8+XI6oVOMY/gfwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790713465; c=relaxed/simple;
	bh=yhpUFlNJlDUc8KQ0TLb7JbtlOA5rTgmwCc/cufw+kZU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JCbhmkK4cZJrEELohHGLpsf4aJDIMQec7b0r+3lMBDvLL+ONkc34SIGOztmKRIyg8Q8L6f5kwD5XZCKkLr0+d3rmuKfhlIYszC49zl+1pj/82jq2Unhqj/NQvH0YVcVPs/nO7eXvD75F/D0vKnHulIZfdV3/VanqOAqOvoyM8mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcxiXnkY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcxiXnkY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B84F1F000FF;
	Tue, 29 Sep 2026 20:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790713463;
	bh=v3tmQdEgkAnSGVvKyzq7TKyXfx86IIrIjILpFihoh+s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OcxiXnkYyiEFTW5FpyPUNcfUhzFQurQPgxMVJAvVZuzMFy7EmHRNJwDV+1D7kbM/i
	 KWUoS6AxwmaRuFtzt/BnNPfAdsBcKMwPIx+ArwqJ/XL5zOKHyYYYS6w9Mz+dVI2hV1
	 JWgZLZQNUpTeTSYycqNIPQ7BvCspdyBP2MCVZr4lDBu3hHu1y8DXCSJvwKCXSZbOvS
	 Ib0QzmO9uD2iiIx2gKtnmUuvxWPcTNSlx+uofbj7t0Xgd8wRZHL9YA/TFlT2fzT8zG
	 dNYVWyokIFp2a6hw3JJutPx8N8QJxxVMdc40ffS2LKF7OhlalF0NJLydecKGsm9B0d
	 q029Cq6ADmdpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] perf report: Add --no-progress option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929201524.2507733-4-acme@kernel.org>
References: <20260929201524.2507733-1-acme@kernel.org>
 <20260929201524.2507733-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 20:24:22 +0000
Message-Id: <20260929202423.4B84F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf report: --no-progress option is shadowed by auto-negation o=
f --progress
--

commit d8af0ed78a2918166c6bac5d18a4149df64706aa
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf report: Add --no-progress option

This patch adds a --no-progress option to perf report to disable progress
information while processing the perf.data file. This takes precedence over
--progress and also turns off the default progress displays in the TUI and
GTK browsers.

> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 963808b561e54..e334556af62f9 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c

[ ... ]

> @@ -1387,6 +1388,8 @@ int cmd_report(int argc, const char **argv)
>  			"Show or hide weight columns in annotation. Default show if non-zero.=
"),
>  	OPT_BOOLEAN(0, "progress", &report.progress,
>  		    "Show progress while processing the perf.data file"),
> +	OPT_BOOLEAN(0, "no-progress", &report.no_progress,
> +		    "Do not show progress while processing the perf.data file"),
>  	OPT_BOOLEAN(0, "header", &report.header, "Show data header."),

[Severity: Medium]
Since the "progress" option precedes "no-progress" in cmd_report(), does the
parse-options engine intercept the command line flag --no-progress as an
auto-negation of the earlier progress option?

If so, this would shadow the explicitly defined no-progress option, leaving
report.no_progress always unset.

[ ... ]

> @@ -1798,7 +1801,9 @@ int cmd_report(int argc, const char **argv)
>  	 * processed so far for each processing phase.  --quiet asks for no
>  	 * messages at all, so it leaves the phases uncounted.
>  	 */
> -	if (report.progress && !quiet && use_browser =3D=3D 0)
> +	if (report.no_progress)
> +		ui_progress__noop_init();
> +	else if (report.progress && !quiet && use_browser =3D=3D 0)
>  		stdio_progress__init();

[Severity: Medium]
If report.no_progress can never be true due to the parse-options shadowing
mentioned above, does this become dead code? This would prevent
ui_progress__noop_init() from executing and leave UI progress enabled despi=
te
the flag being passed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929201524.2507=
733-1-acme@kernel.org?part=3D3
