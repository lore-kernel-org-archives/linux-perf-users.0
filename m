Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1FF1C5F1B
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 17:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345463; cv=none; b=UhDn99mvL03S202S64n+dcF5FQ7EBYAD4y+vj7K5YtStpeN1LfJbTuOfY/h2YRGjybKN6rZYwREYapmhEXIOoSc9w1voz3ESPMRxIK38wtQpCqNaKo8t4VdlK1IDD0ahLIqSWoNw6pKXOfnQhkKyVboRFbtPT5hQ8x36gArEpVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345463; c=relaxed/simple;
	bh=HnnFdELwd7FfrenkwoyTOrFMKwIgENinR2A9bgiPFH0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dSMpMT/KMTs1pqSOVQZDvTXso+KnUpsQBnzy7rAqUAwHCON7GS2FI7PUnWUCxxLcEYO5GKSxp308kMahSWUTGh81fY9XPCraZjUEw9ZG+NPcYwMbnVyMyrqI61JDYe3j8SxYoeg9x9WfOQjmcx1PBJbB9RB5FVUcyYGWHUywuxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erDOgxRd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erDOgxRd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24ABB1F000E9;
	Wed, 29 Jul 2026 17:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785345462;
	bh=MCSZAUTuhrAp1hjniQTxA+QFZ+c/F8KjmsRfsa957jc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=erDOgxRdAblxuIP6o8DBosZgnY8D49uqgrUjLbpJ2dFoHfGiFQxNmdnwEt59ieXRh
	 Wn/NXitf/aUdmNE26FZMy0Tv4mqND3jm3sd2dD6WjsF3UnaW0K8et/opfc46zxui4t
	 t8kn+gt+Lb2gdE4XoQDdwd5u93R9Ndujk9joIg7JB7WIDZTvlfKVkuaWXlUp2aSzo5
	 sxA5G8AzFF5vBNzAQ7flD0PtmfAYxd0pYzPzwppWG9H3KMRXajDnWlta+CSOQic7aP
	 H8n05Ihhs1Sb/jFEFuU7WC7hgz49Hote9lePgXQkYYDuJWSPbQ0fyoT/5c3mU42dRF
	 AktGJE/xftd8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] perf stat: Include PMU name and split uncore events
 per PMU in metric-only JSON output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260729170416.41904-1-ctshao@google.com>
References: <20260729170416.41904-1-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 17:17:41 +0000
Message-Id: <20260729171742.24ABB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Flawed line-split transition logic causes spurious empty JSON ob=
jects and incorrect PMU attribution for tool events.
--

--- Patch [1]: [PATCH v3] perf stat: Include PMU name and split uncore even=
ts per PMU in metric-only JSON output ---
commit 20e3cd08fd5e415b458343262ee76bc1f5f6ce85
Author: Chun-Tse Shao <ctshao@google.com>

perf stat: Include PMU name and split uncore events per PMU in metric-only =
JSON output

This commit modifies perf stat JSON output in --metric-only and -A mode to
group metrics by PMU. It achieves this by adding a "pmu" key to the JSON
output and starting a new JSON line when the underlying PMU instance change=
s.

> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index b337cc23f4131..6785e2c442bd7 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c

[ ... ]

> @@ -1146,13 +1149,34 @@ static void print_no_aggr_metric(struct perf_stat=
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
> +
> +				if (!evsel__is_tool(counter)) {
> +					if (config->json_output && line_open &&
> +					    (!last_pmu || pmu !=3D last_pmu)) {

[Severity: Medium]
Does this line-split transition logic handle tool events correctly depending
on their order in the event list?

If a tool event is processed first, line_open becomes true, but last_pmu
remains NULL. When the next event (a PMU event) is processed, the condition
(!last_pmu || pmu !=3D last_pmu) evaluates to true. This prematurely closes
the line and creates a spurious empty JSON object for the tool event.

Conversely, if a tool event comes after a PMU event, the else-if block below
is taken because !evsel__is_tool(counter) evaluates to false. This bypasses
the line-splitting check entirely, causing the tool event to silently merge
into the preceding PMU's JSON object and incorrectly inherit its PMU
attribution.

> +						print_metric_end(config, os);
> +						line_open =3D false;
> +					}
> +					if (!line_open) {
> +						print_metric_begin(config, evlist, os,
> +								   aggr_idx, counter);
> +						line_open =3D true;
> +					}
> +					last_pmu =3D pmu;
> +				} else if (!line_open) {
> +					print_metric_begin(config, evlist, os,
> +							   aggr_idx, counter);
> +					line_open =3D true;
> +				}
>  			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729170416.4190=
4-1-ctshao@google.com?part=3D1
