Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBED63438B5
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 23:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779493630; cv=none; b=tMeayhF+JcuZZm2TMQuwMqix7awxpIb/4EwUa6e2fa1UK15ZTpH9ByUIp+oYZ/Q9/8MRNfUx2OsACPxtUSyhFpSYnOrvyFikBPYX8LBLfGyRZccDNfWwG9rzf9Iw7pQV+k1YxyzJuD+GqR0JBNYwZNDzoc7zs7TL05WZoG1ONyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779493630; c=relaxed/simple;
	bh=DdGlpVBPdjQMubRhGzhmUnnVdhULx7CSs7z5E8sjH+o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KOZdW5/BL0E6I16Tl+TTjZTX+JGDXDgAukNUkcoJyvH75j1HVbyIa9R6qo5b9u6FPvrFZ0ZT3ectq744+tu4tydF7F4+eIEUB8/5QXYuHT+Z5rALjDt5/y7UZyFh+2b8j8LvITMdrygGgVLz4Zc3Wt291uk17pzbkC0KEVztCec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbSIQjEs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbSIQjEs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F381F000E9;
	Fri, 22 May 2026 23:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779493629;
	bh=Xzr29D/48sQrPSgdMDSDwx1qhufAcuilfL/is22cVoU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TbSIQjEsw175kQK4C34iXvEW9qCFKg6XIkaPQSOXYIUm49ZS5saqWQJBfaQHdRpqe
	 vz0bByP3wyauJkSiA6bD75obzCeMiLTeysBuesQMLFIgszMVL0dZfqJPZIFFNM25Gt
	 0MAdcBeqagSweFWcxsXt/As/rCJGutC4LidZNFo1f/FKKiH9KpYrVApRrTxUrVBbP3
	 kljthfG1IPf8FBdkg9G6U7Om5DEKfd7ROIY5zN3+huGEq/ihpK4fIkm2uJT8UKAdQx
	 6JedC8t0NqIw/GlmsjBlS6yQVo/64GF0lyC4QWXuslKoYQ+iTMfiVRxW4vUPZBYQ1q
	 pMo7y1mfgVy4Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 01/14] perf stat: Introduce core generic print
 traversal engine and header stubs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260522223342.2393553-2-irogers@google.com>
References: <20260522223342.2393553-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 23:47:08 +0000
Message-Id: <20260522234709.41F381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unconditional invocation of `cb->print_metric` without verifying=
 the callback pointer.
--

commit 90d8e5db3452e883fc9b511756f3c3b819d1ad40
Author: Ian Rogers <irogers@google.com>

perf stat: Introduce core generic print traversal engine and header stubs

This commit introduces the initial infrastructure for decoupling the perf s=
tat
printing API. It declares the struct perf_stat_print_callbacks interface and
implements the core traversal driver perf_stat__print_cb().

> diff --git a/tools/perf/util/stat-print.c b/tools/perf/util/stat-print.c
> index 0000000000000..3a634396c7c63
> --- /dev/null
> +++ b/tools/perf/util/stat-print.c
[ ... ]
> +static int calculate_and_print_metric(const struct perf_stat_config *con=
fig,
> +				      const struct perf_stat_print_callbacks *cb, void *outer_ctx,
> +				      struct metric_expr *mexp, struct evsel *evsel, int aggr_idx)
> +{
[ ... ]
> +	if (!metric_events[i]) {
> +		if (expr__parse(&ratio, pctx, metric_expr) =3D=3D 0) {
> +			char *unit;
> +
> +			if (metric_threshold &&
> +			    expr__parse(&threshold, pctx, metric_threshold) =3D=3D 0 &&
> +			    !isnan(threshold)) {
> +				thresh =3D fpclassify(threshold) =3D=3D FP_ZERO ? METRIC_THRESHOLD_G=
OOD :
> +									    METRIC_THRESHOLD_BAD;
> +			}
> +
> +			if (metric_unit && metric_name) {
> +				if (perf_pmu__convert_scale(metric_unit, &unit, &scale) >=3D 0) {
> +					ratio *=3D scale;
> +				}
> +				ret =3D cb->print_metric(outer_ctx, config, evsel, aggr_idx,
> +						       metric_name, unit, ratio, thresh);
> +			} else {
> +				ret =3D cb->print_metric(outer_ctx, config, evsel, aggr_idx,
> +						       metric_name ?: (evsel->name ?: ""), NULL,
> +						       ratio, thresh);
> +			}

[Severity: Medium]
Could this cause a NULL pointer dereference if a caller implements the new =
API
but omits the print_metric callback?

Looking at perf_stat__print_cb(), callbacks like print_start, print_event,
and print_end are explicitly checked before invocation, which implies that
the callback pointers are treated as optional:

> +int perf_stat__print_cb(struct evlist *evlist, const struct perf_stat_co=
nfig *config,
[ ... ]
> +	if (cb->print_start) {
> +		ret =3D cb->print_start(ctx, config);
> +		if (ret)
> +			return ret;
> +	}
[ ... ]
> +					if (cb->print_event) {
> +						double stdev_pct =3D 0.0;
[ ... ]
> +						ret =3D cb->print_event(ctx, config, counter,
> +								      aggr_idx, val, ena, run,
> +								      stdev_pct);

Should print_metric be conditionally checked in calculate_and_print_metric(=
) as
well to ensure safety if it is left unpopulated?

> +		}
> +	}
> +
> +	expr__ctx_free(pctx);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522223342.2393=
553-1-irogers@google.com?part=3D1
