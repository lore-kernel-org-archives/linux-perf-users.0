Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4562FE071
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 23:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779753200; cv=none; b=EkDPRJjdaK79HCIuBguf+pfqX9+pfeNQNGDY6x8fnQ98wl1Fnx8kgw97g+fjALqlgmv+kBdtFnZBeZ8fRGKY3mm5wq/OH3LtsbKGnXgbvx4nuIAvUgZLrisXNvV/rw7OL9/VEnhSqeTezQj1lWApP4q1CmutTlwf1UZk8KXTTis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779753200; c=relaxed/simple;
	bh=QHwKwEpg8Jk/NvHU9cHmYiawwvFT6P1yw3ud9MlWJNg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uI2pk8lTg0AxtVCAGULoxZOhGbXe53mCeilNK0HAs7JYtQ+6xvChlDbFXXO9Gffc5mk9EnUC03IKtUwyGYJfcAhvBXluB9VCDHrfhVD59DX3NGjKBVNmEXqnHzJzxc6WfXZmirBZ8XRTraaYL2x3mThT+28rRQLMUkCBAH+mPu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMkVPFFc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMkVPFFc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C663D1F000E9;
	Mon, 25 May 2026 23:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779753198;
	bh=Uln6DS8HAuJ/RVuY+GwAuTzQBtVNKGUAzEom7iCO+x8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BMkVPFFcu9Eyl1/hpYdIF5NJBEqZsW5FIGSYP8jRbLHbeU5PlAik3iUErglwGO3O3
	 YLd/z+xoh89rjUUIOaSDf+RBUslRZRFDPhuTMbk/M7M8wvVwLLDguXeTYy8BSM+Ljq
	 VuVE0mtp/r0/rezlRSCbk8VhnNeGVSiquNPFmkuy3DKbR5E6+BT2N2GUcnfpCTgTi/
	 kjlXd3B44zUq0zZFlcR4yMyK95evQUkHTO/20sko/naWhPRSrNx4ugizTUuWdjjM63
	 IE/GvWooJnNr3YI7nhJIJdbz/vBbL0l7uYVzrmOCwy0OHCTYrvQUsnvMbdPdYjUwDP
	 yt+9HcH8p1YqA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 02/14] perf stat: Implement standard console
 (STD) formatting callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260525231900.3527228-3-irogers@google.com>
References: <20260525231900.3527228-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 23:53:18 +0000
Message-Id: <20260525235318.C663D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing trailing newline for interval output in metric-only mode.
--

commit 7c6854720d44b02ec256a0c56e408fbe8b0ead8f
Author: Ian Rogers <irogers@google.com>

perf stat: Implement standard console (STD) formatting callbacks

This commit implements standard console formatting callbacks inside
util/stat-print-std.c. It replaces the empty stubs by buffering
traversal streams using format-private DOM nodes and unified aggregation
helpers.

> diff --git a/tools/perf/util/stat-print-std.c b/tools/perf/util/stat-prin=
t-std.c
> index 83987e97c8895..aa4a083bb85ab 100644
> --- a/tools/perf/util/stat-print-std.c
> +++ b/tools/perf/util/stat-print-std.c

[ ... ]

> +static void print_footer_std(const struct perf_stat_config *config)
> +{
> +	double avg =3D avg_stats(config->walltime_nsecs_stats) / NSEC_PER_SEC;
> +	FILE *output =3D config->output;
> +
> +	if (config->interval)
> +		return;

[ ... ]

> +static int std_metric_only_print_end(void *ctx, const struct perf_stat_c=
onfig *config)
> +{

[ ... ]

> +	/* Print values */
> +	list_for_each_entry_safe(b, tmp, &ps->queued_metrics, list) {
> +		if (b->aggr_idx !=3D current_aggr) {
> +			if (current_aggr !=3D -2)
> +				fprintf(out, "\n");

[ ... ]

> +		fprintf(out, "%*s ", mlen, str);
> +		free(str);
> +
> +		list_del(&b->list);
> +		free(b->name);
> +		free(b->unit);
> +		free(b);
> +	}
> +	print_footer_std(config);

[Severity: Low]
Will this omit a trailing newline when running perf stat in interval mode?

It looks like the traversal over queued_metrics prints newlines between
aggregation blocks, but relies on print_footer_std() to close out the
final line.

However, as shown above, print_footer_std() returns early if
config->interval is true:

static void print_footer_std(const struct perf_stat_config *config)
{
    ...
    if (config->interval)
        return;

Could this cause the output for successive intervals to be concatenated
directly onto the same line without separation?

> +	return 0;
> +
> +cleanup:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525231900.3527=
228-1-irogers@google.com?part=3D2
