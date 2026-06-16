Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767E01A6803
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573888; cv=none; b=K4ntnsnWSTE75ReF1JPZsWYdcw4B5O+InxzN6LHvXivWEtOjrdzQpy9rTw54zz3Hcd8zy1CrTBVGVnNEfCi6bIM8cnLb2X9sAy6DOHlCXpUNs4WXfe+vVzn1+6A3Uepg9f8rRLrnT7SieMo+vfZ0MESeJ3+eZCdaBgEAzm3f1HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573888; c=relaxed/simple;
	bh=IgiuBEpVkGYMcm+i1W11gXjaSDumdKKxGvldgGh9qfs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GmnrfuleqIao3s10wQjCQ1Rlzp9DUE8BTtZVlcFkkmWj9Br7f4voD8OvvLN+1yBqXlgjD3rqGO6GH1xyDU1GP2kkJmuf1/sT3Vn/Vxwv11I8JCF+sNo25K0Kk8WpoksRZiiFjTMLowfTPKy79UXoALJ5PaJqpJRP1x8J6nh+gnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcSMgAdc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcSMgAdc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073841F000E9;
	Tue, 16 Jun 2026 01:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781573887;
	bh=m314c328ZXChfPXxDrCRk9v4RnWjv3Aa20CoZZKs65c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kcSMgAdcN+A/BIdSgMWOUlsiPMJA+2QQPnHQ6i6aSHi8L1rg9m4EX9yXwF2QUC+h2
	 plhYLZsNYjSp1oCHUKCxTRsXmmyCG/12ie7BqCASDFOT81vup1kxiAsmXcMAily2Gc
	 wUxJqt99CcIBTpnYo80mbCDE6GUmruQ+0TmPLuJOXmr8cOIFEuM+9BTjhy/+BLLCCK
	 B77QzL1mRqJLTSTQgYUjkeSG7drQLxpvC4E/2gHMc1YVIV7OSguW+HW9AsYecTNPha
	 sLsSIzdVigbtW4xC4ZlopNALq2FIP6xbvYRhgFs8coy3ya0C4IiE+Kg1XbgdxAho61
	 XZrDWbOLBJkmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 02/12] perf test: Truncate test description to fit
 terminal width
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616012744.4049193-3-irogers@google.com>
References: <20260616012744.4049193-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 01:38:06 +0000
Message-Id: <20260616013807.073841F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Subtest descriptions are unnecessarily truncated because the ali=
gnment padding width (`subw`) is incorrectly used as the maximum string pre=
cision.
- [Medium] Test descriptions are unconditionally truncated to 45 characters=
 when the output is redirected to a file or pipe, degrading standard log ou=
tputs.
--

commit 4e5040303fa86a90233f1836bc00692228c7e994
Author: Ian Rogers <irogers@google.com>

perf test: Truncate test description to fit terminal width

This commit dynamically queries the terminal width to truncate printed test
descriptions. This prevents long names from wrapping around the terminal
and corrupting the parallel test harness's progress lines.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index afc06cec49546..51484e84d7c15 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
[ ... ]
> @@ -413,19 +417,52 @@ static char *xml_escape(const char *str)
>  	return res ? res : strdup("");
>  }
> =20
> +static int get_max_desc_width(int width)
> +{
> +	struct winsize ws;
> +	int cols =3D 80;
> +	int max_desc_width;
> +
> +	get_term_dimensions(&ws);
> +	if (ws.ws_col > 0)
> +		cols =3D ws.ws_col;
> +
> +	/*
> +	 * Limit description width to fit on a single line. We subtract 35
> +	 * columns of headroom to allocate space for:
> +	 * - The suite index prefix: e.g. " 10.100:" (9 characters).
> +	 * - The colon separator and spaces: " : " (3 characters).
> +	 * - The longest status results: e.g. "Skip (some metrics failed)" (26 =
characters)
> +	 *   or "Running (XX active)" (20 characters).
> +	 *
> +	 * A minimum description width of 10 is enforced to ensure names are
> +	 * legible even on very narrow consoles.
> +	 */
> +	max_desc_width =3D cols - 35;
> +	if (max_desc_width < 10)
> +		max_desc_width =3D 10;
> +
> +	return width > max_desc_width ? max_desc_width : width;
> +}
> +
>  static int print_test_result(struct test_suite *t, int curr_suite, int c=
urr_test_case,
>  			     int result, int width, int running,
>  			     const char *err_output, double elapsed)
>  {
> +	width =3D get_max_desc_width(width);

[Severity: Medium]
Will this unconditionally truncate test descriptions to 45 characters when
output is redirected to a file or pipe?

When a TTY isn't present, get_term_dimensions() fails and cols defaults to
80, making max_desc_width evaluate to 45. Is it intended to enforce this
truncation on non-interactive text logs where line wrapping isn't an issue?

> +
>  	if (test_suite__num_test_cases(t) > 1) {
>  		char prefix[32];
>  		int len =3D snprintf(prefix, sizeof(prefix), "%3d.%1d:",
>  				   curr_suite + 1, curr_test_case + 1);
>  		int subw =3D len >=3D 4 ? width + 4 - len : width;
> =20
> -		pr_info("%s %-*s:", prefix, subw, test_description(t, curr_test_case));
> -	} else
> -		pr_info("%3d: %-*s:", curr_suite + 1, width, test_description(t, curr_=
test_case));
> +		pr_info("%s %-*.*s:", prefix, subw, subw,
> +			test_description(t, curr_test_case));

[Severity: Medium]
Does using subw as the string precision here cause subtest descriptions to
be unnecessarily truncated?

subw is calculated as width + 4 - len, which makes it slightly smaller than
the global width to accommodate the longer subtest prefix. If a subtest
description length is close to the maximum test description length, it
appears this format will forcefully chop off the end of the description,
even on wide terminals where plenty of space exists.

> +	} else {
> +		pr_info("%3d: %-*.*s:", curr_suite + 1, width, width,
> +			test_description(t, curr_test_case));
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616012744.4049=
193-1-irogers@google.com?part=3D2
