Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9C326E6E1
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 23:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779490980; cv=none; b=c5xlWrBX7xz4MW3ry/PwJS0UuGdPiN6EjNqweu08LAAf8me9Fjbm3ul9Y8DgwI8W4feGcReIhwIxnzuncnLMNUHgu7y8cZKGAxzFRInOljKj8ZgKGTOk49G+0Bo+Av6qwzuwPjl05JT1eD0APhqI4iUGxYhEqV6BE/HHePSuCEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779490980; c=relaxed/simple;
	bh=ZFFzmy77F8c/+YMEvItrxM8EX/0z3Em/n1K12LYzCJ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=goJ0mRRvE+HZQr5SOzx8gkSnDqbsThUL3QlBer0ajKgP0Uv56u89iwzou+HjvfrY4bZ7oVWktncB72SmMHc3BC4vXJf5uetNSv86X791DgZOb0CFkcDxpsfbBHegBxEhMgLxGH0aVoI33dkRMt+Y1wQp78mEk0DdWd9YF5Y6i+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSxvF63N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSxvF63N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932091F000E9;
	Fri, 22 May 2026 23:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779490978;
	bh=6Vdg0dirCWF2OLAINRLlVLpzIVSwJzOQVqsdKW4LhKw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fSxvF63NUQ9XYndxGdWGiIE1V+Xrm89w1r8eVc5dfG/ijU+gVwvtSxWnRapq07nxL
	 ZUoHkMWQEg06bO+po5Ef90Ob7/eMw+ocl1WaZLtiwWmM+Hk7P+FWdR7Hkk6f152NKI
	 XYBhO9tSInisXBrqpIRzgEoxVjrBegMBvyCTu0mNN7/maoKK4taCeD6pLhILD0yWCi
	 gpr6b61RHpfOH/fPOtuYKWBy2qAUpOb7MZyptDd4SaPmJY4FgjLkU5Lr7meEP8sIJc
	 w5l30E2CqKDn6KiftGZdV1mF2uUV+AMKP6VjXwZNnOKjKOCzyhD7q198zSk8sj0KRW
	 LDnHlN5ZQfycA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 10/14] perf stat: Implement streaming JSON
 formatting callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260522223342.2393553-11-irogers@google.com>
References: <20260522223342.2393553-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 23:02:58 +0000
Message-Id: <20260522230258.932091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The JSON metric output permanently drops the metric unit string, i=
mproperly placing the metric name inside the 'metric-unit' field.
- [Medium] Dynamic memory allocation in `json_metric_only_print_metric` con=
tradicts the commit's 'zero-allocation' claim and introduces unnecessary ov=
erhead.
--

commit 739e10b4f20e27c02302af087d48ca22809c20c9
Author: Ian Rogers <irogers@google.com>

perf stat: Implement streaming JSON formatting callbacks

This patch implements streaming JSON formatting callbacks inside
util/stat-print-json.c, replacing previous empty stubs. It bypasses
dynamic queue events and metric lists entirely, formatting JSON objects
directly onto the output file descriptor.

> Delivers a highly optimized, zero-allocation, and 100% streaming print en=
gine
> for JSON normal and metric-only modes. It bypasses dynamic queue events a=
nd
> metric lists entirely, formatting and streaming JSON objects directly ont=
o the
> output file descriptor.

[ ... ]

> --- a/tools/perf/util/stat-print-json.c
> +++ b/tools/perf/util/stat-print-json.c

[ ... ]

> +static int json_print_metric(void *ctx, const struct perf_stat_config *c=
onfig, struct evsel *evsel,
> +			     int aggr_idx, const char *name, const char *unit __maybe_unused,
> +			     double val, enum metric_threshold_classify thresh)
> +{

[ ... ]

> +	fprintf(output, ", \"metric-value\" : \"%f\"", val);
> +	if (name && name[0])
> +		fprintf(output, ", \"metric-unit\" : \"%s\"", name);

[Severity: High]
Does this inadvertently drop the metric unit string?

The unit argument is marked __maybe_unused, and the name argument is printed
in the "metric-unit" JSON field instead. This seems like it might break
downstream JSON parsers that expect the actual unit string.

[ ... ]

> +static int json_metric_only_print_metric(void *ctx,
> +					 const struct perf_stat_config *config __maybe_unused,
> +					 struct evsel *evsel __maybe_unused, int aggr_idx,
> +					 const char *name, const char *unit, double val,
> +					 enum metric_threshold_classify thresh __maybe_unused)
> +{
> +	struct json_metric_only_print_state *ps =3D ctx;
> +	FILE *output =3D ps->fp;
> +	char *header_name;
> +	int err;

[ ... ]

> +	if (unit && unit[0]) {
> +		err =3D asprintf(&header_name, "%s  %s", unit, name);
> +	} else {
> +		header_name =3D strdup(name);
> +		err =3D header_name ? 0 : -1;
> +	}
> +	if (err < 0)
> +		return -ENOMEM;
> +
> +	fprintf(output, "\"%s\" : \"%.1f\"", header_name, val);
> +	free(header_name);
> +	return 0;
> +}

[Severity: Medium]
The commit message states this delivers a "zero-allocation" print engine,
but memory is dynamically allocated here using asprintf() and strdup() on
every invocation.

Could these allocations be avoided to prevent a potential -ENOMEM failure on
the fast path? It looks like the combined string could be formatted directly
into the stream without intermediate allocations.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522223342.2393=
553-1-irogers@google.com?part=3D10
