Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF53A1E5207
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779490747; cv=none; b=OtZdSmF4r26quzoRjpHjuRWEAqN3TFc56PX2L67IASUgrFV093RlL2w0nbXBDijPkIn6dQvofIvwbOmDSsx71fvLAggDNhI8r6oHksV5hzkFnYINaQlBRVvZuTkyyD2eF6im6ThK2Hi7mt4S/1ty+gea52mat4iZdMxREdVtfh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779490747; c=relaxed/simple;
	bh=eEmEcTAjFZ5+xsJYM/eK+iHedD8qmrbpYa49/C2eMJU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uRkWVpb1113y9BxxrJFvOHDmyEyr27ylvAe32/ZCINcnvFd/kDcv6jJxbCSVtRSb2olriOCoO+YiMWxv7AN1h3KSceE0RDCmtAWg9nvVU/BLTBHEpJjaHJDwpN71KXOyNBtgR0jjXsd6anRPaytIGwP/VCNxSKuuLhW2C9RvlPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9YhA+up; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9YhA+up"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774281F000E9;
	Fri, 22 May 2026 22:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779490742;
	bh=U4qBV2TqmdJu60dxjCxWQlqkliQJGpEHCgaFzHk8Q2M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X9YhA+upI4QOsvyQLnB/EfF5Cc0eGnkjmbrc3wCZjmUDpWGAR/3Stcyd7+RoQBUW+
	 4Z8/SmKVXSewuvdFSrz2oB1NPKt3FpftxwuyrqlOHBEZP5R/ZjHxG4ozLfYjAJ2k5a
	 2tg115rqHFuCdD46KtyHWpgwu/TeA2uEViJE70j07dfkIesbCHAeAduDSZ2+vQsC5j
	 1mTUXWJgdD/o9uMzHyiqWFmPz0lsUGWJvYlTmLpSac0JoiUg6iE5E2SbcCFz5tfe2f
	 SMsaHT+41i0Y+GHUZXysqAjueepxuJrg3gkxvBuldGswISVcOjnBOibar83EeGA5X6
	 pfpM93wWyGvDA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 08/14] perf stat: Extend CSV output linter to
 test core aggregation checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260522223342.2393553-9-irogers@google.com>
References: <20260522223342.2393553-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 22:59:02 +0000
Message-Id: <20260522225902.774281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The metric-only CSV formatter uses literal hardware IDs (via pri=
nt_aggr_id_csv) instead of static labels for CSV column headers.
- [Medium] The metric-only CSV formatter unconditionally prints column head=
ers on every invocation, breaking interval mode CSV structure.
--

commit c6d9dbeb2224e7612eda5e12a83ebd10d5ea2210
Author: Ian Rogers <irogers@google.com>

perf stat: Extend CSV output linter to test core aggregation checks

This patch extends tools/perf/tests/shell/stat+csv_output.sh to run all
basic and core aggregation linter checks a second time under the --new
CSV print flag. This guarantees that CSV outputs produced by the decoupled
printing engine are formally verified and column-valid.

> diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests=
/shell/stat+csv_output.sh
> index cd6fff5970911..e4153a03d7164 100755
> --- a/tools/perf/tests/shell/stat+csv_output.sh
> +++ b/tools/perf/tests/shell/stat+csv_output.sh
> @@ -88,5 +88,21 @@ then
>  else
>  	echo "[Skip] Skipping tests for system_wide_no_aggr, per_core, per_die =
and per_socket since socket id exposed via topology is invalid"
>  fi
> +# New API CSV checks
> +perf_cmd=3D"--new -x$csv_sep -o ${stat_output}"
> +check_no_args "CSV (New API)" "$perf_cmd"
> +check_system_wide "CSV (New API)" "$perf_cmd"

[Severity: Medium]
Will this script also test the metric-only mode for CSV output?

When running the new CSV formatter with --metric-only, the column header
literally contains the data values of the first hardware group instead of
static column labels like 'core,cpus'.

In csv_metric_only_print_end(), the code calls print_aggr_id_csv() to gener=
ate
the aggregation prefix for the header row:

tools/perf/util/stat-print-csv.c:csv_metric_only_print_end() {
    ...
	/* Print aggregation prefix header in CSV metric-only mode */
	if (config->aggr_map && first_aggr >=3D 0) {
		struct aggr_cpu_id id =3D config->aggr_map->map[first_aggr];
        ...
		print_aggr_id_csv(config, output, mock_evsel, id, aggr_nr);
	}
    ...
}

Because print_aggr_id_csv() resolves and prints the runtime value of the
first aggregation group (e.g., S0-D0-C0), this produces a malformed CSV
where the header row contains specific hardware IDs rather than labels.

Should we use static labels for the metric-only CSV header?

> +check_interval "CSV (New API)" "$perf_cmd"

[Severity: Medium]
Does the interval mode work correctly when --metric-only is used?

When running perf stat in interval mode with --metric-only,
perf_stat__print_csv() is invoked periodically. Each invocation instantiates
a fresh csv_metric_only_print_state context and calls
csv_metric_only_print_end():

tools/perf/util/stat-print-csv.c:perf_stat__print_csv() {
	if (config->metric_only) {
		struct csv_metric_only_print_state ps =3D {
			.fp =3D config->output,
            ...
		};
        ...
		return perf_stat__print_cb(evlist, config, target, ts, argc, argv,
					   &csv_metric_only_print_callbacks, &ps);
    ...
}

Inside csv_metric_only_print_end(), it unconditionally iterates over
ps->queued_metrics to print the column headers before printing the values.

Because there is no state tracking across intervals, the CSV output will
contain interleaved header and data rows across intervals, breaking the CSV
structure which requires exactly one header row.

Is it intended to print headers repeatedly in interval mode, or should we
add state tracking to print the header only once?

> +check_event "CSV (New API)" "$perf_cmd"
> +check_per_thread "CSV (New API)" "$perf_cmd"
> +check_per_node "CSV (New API)" "$perf_cmd"
> +if [ $skip_test -ne 1 ]
> +then
> +	check_system_wide_no_aggr "CSV (New API)" "$perf_cmd"
> +	check_per_core "CSV (New API)" "$perf_cmd"
> +	check_per_die "CSV (New API)" "$perf_cmd"
> +	check_per_socket "CSV (New API)" "$perf_cmd"
> +fi
> +
>  cleanup
>  exit 0

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522223342.2393=
553-1-irogers@google.com?part=3D8
