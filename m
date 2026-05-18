Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6D21EB5C2
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 23:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147893; cv=none; b=OyfcS7+ya91LhzOABHc5tiVUSkVLLfPYAnO2e16u8Sj7poV6U4z3I2IvrZ59xtqjyjoMHTmMk+TZmTThUTyW2xLzUdaRLLwQ4JQCcDre92FJpH1XM8rMyvRLTksKtBzOexerqLM/UnLyHudL6Pjce6BE5WWRI3oA6En/NypCxWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147893; c=relaxed/simple;
	bh=dVm4ls54X6gK83lblIbboF5GoDSX32r/HDDxRA5ShaQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X2CW704ipRx3066MmW2BXNAtuR2IJbwSJQUvr/gEiSeHn7T4TKHpR2t+uVtO5J4cdZi/MGSLRxx8OIws1qJp4yYOpA0E7VBregg2LgDLf53dc0l0phpIMjlcbGk10I6ggdpd9CZ+8Q8qaWe9TV1QP30fP3AJlR4E6+1wCfcH6Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFcEY4kP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFcEY4kP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAEFC2BCB7;
	Mon, 18 May 2026 23:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779147893;
	bh=dVm4ls54X6gK83lblIbboF5GoDSX32r/HDDxRA5ShaQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gFcEY4kPGfmJYKVbwdbyd47GvGqxUwp5BDSwAEtBKb2ZaGscubqi4c/6Zv1YNDoSt
	 C6pKqElMCrnrpK++ccykYCLJSoMI/L/PAd9TWLek+vydpSE+GjV4krlCFxasvp9Dnx
	 9CT9K54+StbEocKpX063S32VBkFPVzq34LDyyR5ZC7u2MA54ZDqZvKi3N+3UqnltrN
	 Vej2mVvpejtp8rgvEGYoGQIo5RKPp6FX4cEXmVW969/63D2zuIrV4G9xSeksneGQwJ
	 J/tjuSBHHQzIy8KxWIrNUj7LaK2riVBat9VeMjf24OzRAS9o5U4S1rel+JjyUsdoKo
	 bUTvedI0g/Qlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf stat: Fix uncore metric scaling bug across sockets
 and nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260518231150.1252420-1-ctshao@google.com>
References: <20260518231150.1252420-1-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 23:44:51 +0000
Message-Id: <20260518234452.DEAEFC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch codifies a mathematical scaling error across all aggre=
gation modes for uncore metrics by changing `source_count` to `aggr->nr` wi=
thout removing `#num_packages` from the JSON formulas.
--

commit 1c2296ec7fca6ef588c3a63c6bd68377de82335f
Author: Chun-Tse Shao <ctshao@google.com>

perf stat: Fix uncore metric scaling bug across sockets and nodes

This commit changes how source_count is determined for uncore metrics.
Instead of using the static PMU count via evsel__source_count(), it
dynamically assigns aggr->nr from the metric's leader event to handle
various aggregation modes.

> Before the fix:
>   perf stat -M lpm_miss_lat --per-socket --metric-only -a -j -- sleep 1
>   {"socket" : "S0", "counters" : 28, "ns  lpm_miss_lat_rem" : "163.4", "n=
s  lpm_miss_lat_loc" : "27.5"}
>   {"socket" : "S1", "counters" : 28, "ns  lpm_miss_lat_rem" : "170.5", "n=
s  lpm_miss_lat_loc" : "25.5"}
>   perf stat -M lpm_miss_lat --metric-only -a -j -- sleep 1
>   {"ns  lpm_miss_lat_rem" : "90.4", "ns  lpm_miss_lat_loc" : "12.6"}
> `lpm_miss_lat` on global aggr is 0.5x the actual value.

Does this misdiagnose the correct baseline? Existing uncore metrics like
lpm_miss_lat are defined in JSON formulas as dividing by
(source_count(TICKS) * #num_packages).

Before this patch, evsel__source_count() returned the static PMU count per
package (e.g., 28 CHAs). In global aggregation, dividing the global sum of =
56
CHAs by (28 * 2) =3D 56 yields the correct average of ~90.4ns.

The --per-socket mode yielded an incorrectly scaled value because it divided
the sum of 28 CHAs by (28 * 2) =3D 56 instead of 28.

> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c

[ ... ]

> @@ -103,7 +103,7 @@ static int prepare_metric(struct perf_stat_config *co=
nfig,
>  					val *=3D 1e-9;
>  				}
>  				if (!source_count)
> -					source_count =3D evsel__source_count(metric_events[i]);
> +					source_count =3D aggr->nr;
>  			}
>  		}

Does changing source_count to aggr->nr break global mode calculations witho=
ut
updating the JSON metric formulas?

In global mode, aggr->nr dynamically evaluates to 56 instead of 28. Because=
 the
JSON formula still multiplies by #num_packages, the metric divides the glob=
al
sum of 56 CHAs by (56 * 2) =3D 112. This scales the true average incorrectl=
y,
causing the global mode to output the doubled latency value of ~174.5ns.

Similarly, in --per-socket mode, aggr->nr evaluates to 28, and the formula
still divides the sum of 28 CHAs by (28 * 2) =3D 56, retaining the original
scaling error in per-socket mode.

Should the #num_packages multiplier be removed from the JSON formulas when
making source_count dynamically scale with the aggregation mode?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518231150.1252=
420-1-ctshao@google.com?part=3D1
