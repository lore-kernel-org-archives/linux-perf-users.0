Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E683CF673
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 06:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781591087; cv=none; b=ZZRcx0G2lf+NmAkdGapLSQKOzYk/K/ViQkZcx+pC0JHt9vDeKUONywMrH7M/Bfkfdvu8H057oS1Taxvnuum5+1JjOkbGGprP3OXxYoal6dVv/y+yXExojH5fZx/9jVgOiMi4fLFDoIugZ8VdgieRIANu6zBJlPWTADMTAiNkoyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781591087; c=relaxed/simple;
	bh=8yGGt86qWfqeBMQ6SDWjpPbT+RnM4Oy1ArlJgOyVG6I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SERmUMcCvSEeHBqORKuZK7UtAO8D1QL/BG5X0Q5CcNb8eAh1on8lknVqiQjDtQ3p/bKoow+ZZF6XGoiiq2RJktFvIWPND1QRV9Vl8y7Xw2I/bvSsHGY6D9QeuGHuod+SYIVa41J7+hTA8jIufzUWizFwGKjX6uvw6JeqKPGEE6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4EnMrH/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4EnMrH/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583041F000E9;
	Tue, 16 Jun 2026 06:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781591086;
	bh=VPPNuudFATsgNfDUsL71DNMU54jNR3q85gEEzFc0EW4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m4EnMrH/62hJEoiEirFqLoohZ25A4nuTDlvpyubIpx/BF0fvSUs8nmsi2pFcJCD/c
	 vF7fIBUOMioqarje7IPH4kMOhUEDQJVu6fWDyYJwlaLEhKMZscxyVvyJ8E2HdA/wLm
	 8S9KHiJb0pqC4Yfb+TefPoBdbugAxCozFt1OXVdIiuAL/Ah9+D2LDEFBXWzIYCm0aB
	 C/v+RFURhcccUoQ17ga17086mhgE+pC3fc0WRL+r8J7FZxQhEbrJAtp7pJZgsaL6XZ
	 6RJe5Q3jW6Wn/bogDwOl3zR/+jfBMCi/9BgVlzCMEgeRFDB9kY6KWstuYYkz7yU/B3
	 H45oNl6pXZItg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/12] perf test: Truncate test description to fit
 terminal width
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616061404.41929-3-irogers@google.com>
References: <20260616061404.41929-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 06:24:45 +0000
Message-Id: <20260616062446.583041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incorrect File Descriptor Check for Terminal Width
--

commit f74a2825a5f95152494bcb0ab5c482df7aacb93e
Author: Ian Rogers <irogers@google.com>

perf test: Truncate test description to fit terminal width

This commit dynamically queries the terminal width to truncate printed test
descriptions. This prevents output corruption caused by long descriptions
wrapping around and breaking the carriage return delete sequences used in
the parallel test harness.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
[ ... ]
> @@ -413,19 +417,64 @@ static char *xml_escape(const char *str)
>  	return res ? res : strdup("");
>  }
> =20
> +static int get_term_width(void)
> +{
> +	struct winsize ws;
> +	int cols =3D 80;
> +	int term_width;
> +
> +	if (!isatty(1))

[Severity: Medium]
Is isatty(1) the correct file descriptor to check here?

The test progress and results are printed to stderr via pr_info() and expli=
cit
color_fprintf(stderr, ...) calls.

If a user runs perf test > /dev/null, stdout is redirected but stderr remai=
ns a
TTY. This check would return false and bypass truncation, causing the long
descriptions to wrap and corrupt the terminal display.

Conversely, if a user redirects stderr to a log file but leaves stdout as a
terminal (perf test 2> log.txt), this check evaluates to true and unnecessa=
rily
truncates the log file output, destroying diagnostic information.

Should this check isatty(2) instead, since the output is sent to stderr?

> +		return 10000;
> +
> +	get_term_dimensions(&ws);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616061404.4192=
9-1-irogers@google.com?part=3D2
