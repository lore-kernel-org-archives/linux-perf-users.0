Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B61E3CF662
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 18:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052640; cv=none; b=T+4/nPowfUUSUN9kLMwsjb6F2jZEEG4mS8oFUWvwl3UtrW8mwbDWksEXqBpyaoTb7bOny2C1N7dtxYfLntbPkjchLkqWMF99nu7YBgtI/b8yu4+GquzABMkmXQQV5+dMlpbDzqCctlhqS8ywQgGhgN6j56PRGbHDbi40u1x1bWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052640; c=relaxed/simple;
	bh=qgEO8kaVvNfOTpgCm43Ym+tkcmO4o8OaCbpszv9tyCc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tp1HjqIURlvmiix8pBPy3KefuiDY3e341Wl7uIvBgbmwJ9+gRtvOmW3uL8v/ZScHZ6N3xKrAg+eB7L/HFlle2oUiP6pgy3v+Gn8A816066iz6UdcA+G9y7+6XK3rrSoQIjdIng9uuICC72j9SFDr8aakFP7EE3GJU6JZ2Wbyr9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTj8AVa2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTj8AVa2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80C11F000E9;
	Tue, 14 Jul 2026 18:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784052639;
	bh=+cHHHsVsaLVnS3khxW6hLkeTfwiG62Oo5uC/dR4M48Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VTj8AVa2MWN/pJ8qalEx4HeriIuPdBUBrgeolRpiCwJ59UdnRjVf/DcfQ0YnaMebZ
	 EgtCExzganoNqHMqEMRpNfN7voR2om/KczhIOLFkUEfowuMYE657FT8UTYGG6wptMh
	 A+/TxcgDMKq6qWtIGoZvJUblLqvwIrjRXgmSf2E/9stnY+qiLOp/RrxH3j7ugM5jjx
	 PwUfjCJks7v4oKdbHBhd912nTpfqbxjyEHJNfujjRqdJPSyCPLscM/eFLhoLN5DS1f
	 IMmPBIZOvORjI5TrofjEO8wv7zW347lI2K6aFzK/HG96K4ELIAil6Pn4Dnsgd3R8jI
	 j+Y4WPCqFZshQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf stat: Include PMU name and split uncore events per
 PMU in metric-only JSON output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260714174052.1826692-1-ctshao@google.com>
References: <20260714174052.1826692-1-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 18:10:38 +0000
Message-Id: <20260714181038.B80C11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Bypassing `print_metric_begin` for tool events produces invalid,=
 corrupted JSON and CSV output in `--metric-only` mode.

Pre-existing issues:
- [High] Missing bounds check on `aggr_idx` after searching `config->aggr_m=
ap` results in an out-of-bounds array read.
--

--- Patch [1]: [PATCH] perf stat: Include PMU name and split uncore events =
per PMU in metric-only JSON output ---
commit 418eb65331465e855519851f0438c3a1fe047563
Author: Chun-Tse Shao <ctshao@google.com>

perf stat: Include PMU name and split uncore events per PMU in metric-only =
JSON output

This commit modifies perf stat to include the PMU name in the metric-only J=
SON
output when running in no-aggr mode. It ensures that when an uncore event s=
pans
multiple PMU instances, each instance is printed on a separate line with the
correct PMU identifier. The JSON linting script is also updated to recognize
the new PMU key.

> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index f94f1324d24ac..d7f1feb638784 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
[ ... ]
> @@ -1146,10 +1149,24 @@ static void print_no_aggr_metric(struct perf_stat=
_config *config,
> =20
>  			os->evsel =3D counter;
>  			os->id =3D aggr_cpu_id__cpu(cpu, /*data=3D*/NULL);
> -			if (first) {
> -				print_metric_begin(config, evlist, os, aggr_idx);
> -				first =3D false;
> +
> +			if (config->metric_only) {
> +				struct perf_pmu *pmu =3D counter->pmu;
> +
> +				if (!evsel__is_tool(counter)) {

[Severity: Medium]
Does bypassing the print_metric_begin() initialization for tool events cause
invalid JSON output?

If a metric uses a tool event like duration_time as the metric leader,
skipping print_metric_begin() means the opening bracket, timestamp, and CPU=
 ID
are not printed. This can leave the metric key-value pair as a bare string,
followed by a mid-stream bracket when a subsequent hardware PMU event is
processed.

> +					if (config->json_output && line_open && pmu !=3D last_pmu) {
> +						print_metric_end(config, os);
> +						line_open =3D false;
> +					}
> +					if (!line_open) {
> +						print_metric_begin(config, evlist, os,
> +								   aggr_idx, counter);
> +						line_open =3D true;
> +						last_pmu =3D pmu;
> +					}
> +				}
>  			}
> +
>  			val =3D ps->aggr[aggr_idx].counts.val;

[Severity: High]
This is a pre-existing issue, but does this code read past the end of the
ps->aggr array if the CPU is not found in the aggregation map?

In print_no_aggr_metric(), there is a loop right before this block that
searches for the CPU:

cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
	if (config->aggr_map->map[aggr_idx].cpu.cpu =3D=3D cpu.cpu)
		break;
}

If a system lacks complete sysfs CPU topology, aggr_cpu_id__cpu() might ret=
urn
an empty ID, and the CPU may not be found in config->aggr_map.

Could the loop terminate with aggr_idx =3D=3D config->aggr_map->nr, causing=
 this
line to unconditionally read out of bounds?

>  			ena =3D ps->aggr[aggr_idx].counts.ena;
>  			run =3D ps->aggr[aggr_idx].counts.run;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714174052.1826=
692-1-ctshao@google.com?part=3D1
