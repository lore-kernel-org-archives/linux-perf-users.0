Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABA842C51D
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 23:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786490300; cv=none; b=DEjB66WH0L4u9VaAQYZi5Mvg+Xdq9Hp+nCPBxkHiDkjVzs13p9IevoTi6lkLNt/iJMN34VfdT5L3I/uKUer3uMmZ8tcQMZKT7+kJUHg4QF0UELxYDx8BhtKEylrT/T3QzZg7ujShP/6PYLbjKNkw6RTIb2yGOxRaITFTjEP1Ifs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786490300; c=relaxed/simple;
	bh=T+VHsIGxwAn3jb/eO29txToRdmx9wAMZ2VlQZieQDmw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ih7+rDQiliDr1OGgx4/uxw1DefdkTTzS8MOF4BI84FdGGXQ4zDzWXF3UXuRIMaWRVWXYCu5jxuRG7jQnQ6/l7KyLpoBTqcbHZzGoREcxcoQL6AHTtSgUgs7/D9UvncC7zx2sZwuMWeIUVG7hF06MetQjsnWBtznuZdAXc7STmuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNJuT/hs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNJuT/hs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB181F000E9;
	Tue, 11 Aug 2026 23:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786490298;
	bh=HUGmmaF26hrSJS0plOryGN+P500IC+gwWkZcPnBOPEI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XNJuT/hsSips7iGYjV2bBkS0Y5/0Ccxw+WH5DQLpMnqCYKFRlybFw6+KuwhrAM8QM
	 NPKxMArBnFd0g8oX61vHGYJPQwHttSigMgLEVdKA1o441lKHoN/FwQTzhEJmU8rVnB
	 U7TkcIqlhrd192UcTojVqNBQ8HCjW5TwfgcAOPnqgk15lgnaq7sjZYVKti8S9920oa
	 quky+/UaWEA4fgqil+sdCPvd1GJHCHa4/Z9XRpFh+oUQM0QLdBKBsekGudxIRl3s/X
	 98ZK2yK+h/Xf9GXcq+uV71Gy4wcmx3Cal6sQSMzT8+xRKMhxDksejAjlsuUGtMUj92
	 rN0z3RGOfZvkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] perf stat: Include PMU name and split uncore events
 per PMU in metric-only JSON output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260811230518.3360-2-ctshao@google.com>
References: <20260811230518.3360-2-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 23:18:18 +0000
Message-Id: <20260811231818.9BB181F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Bypassing line initialization and termination for tool events in=
 '--metric-only' mode corrupts JSON, CSV, and standard formatting when thos=
e events evaluate to metrics.
--

--- Patch [1]: [PATCH v5] perf stat: Include PMU name and split uncore even=
ts per PMU in metric-only JSON output ---
commit f2dfadb52a27c2891ce164d2b06f57924949dd1d
Author: Chun-Tse Shao <ctshao@google.com>

perf stat: Include PMU name and split uncore events per PMU in metric-only =
JSON output

This commit updates perf stat JSON output to include the PMU name for uncore
events in metric-only mode and split output lines when transitioning between
PMUs. It bypasses line initialization for tool events to avoid creating
spurious empty JSON objects.

> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c

[ ... ]

> @@ -1146,12 +1151,42 @@ static void print_no_aggr_metric(struct perf_stat=
_config *config,
>  				if (config->aggr_map->map[aggr_idx].cpu.cpu =3D=3D cpu.cpu)
>  					break;
>  			}
> +			if (aggr_idx >=3D config->aggr_map->nr)
> +				continue;
> =20
>  			os->evsel =3D counter;
>  			os->id =3D aggr_cpu_id__cpu(cpu, /*data=3D*/NULL);
> -			if (first) {
> -				print_metric_begin(config, evlist, os, aggr_idx);
> -				first =3D false;
> +
> +			if (config->metric_only) {
> +				struct perf_pmu *pmu =3D counter->pmu;
> +				bool is_tool =3D evsel__is_tool(counter);
> +
> +				if (!is_tool && pmu) {

[Severity: Medium]
Does bypassing line initialization for tool events corrupt the output
formatting if the tool event evaluates to a metric?

If a tool event has an associated metric (e.g., from a custom metric using
duration_time), it will fail the !is_tool check and skip calling
print_metric_begin().

The event still proceeds to printout() down below:

        uval =3D val * counter->scale;
        printout(config, os, uval, run, ena, 1.0, aggr_idx);

If printout() outputs the metric directly, won't this lack the necessary JS=
ON
or CSV preamble (such as { "interval"... ) because print_metric_begin() was
skipped?

Furthermore, since line_open remains false, print_metric_end() is also
bypassed at the end of the loop, leaving the JSON object unclosed.

> +					bool pmu_changed =3D false;
> +
> +					if (line_open && last_pmu) {
> +						bool non_core =3D !pmu->is_core ||
> +								evsel__is_hybrid(counter) ||
> +								!last_pmu->is_core ||
> +								evsel__is_hybrid(last_evsel);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811230518.3360=
-2-ctshao@google.com?part=3D1
