Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90DF387374
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 04:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784176948; cv=none; b=GlGZKgeTA9SkPM6+e26HChT4/M+Ma0MuZU+q7ngDl66cx4RQhWvqJKmnLZvZCWy2ftsVCett4Ijk/lIPBY9duk1aPuwb4mzLOkGmeaGzYPbSJWR0U5KQpjgsrpI4ZYbUFJOc2zgTBzw5NatXhM5nC3dY71NaWPpSbf9RiPC112s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784176948; c=relaxed/simple;
	bh=WK7pVciXqZbPkFFCmgcsIXVMIUyt2+cxqTCHLfLEM1g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aoObFFtdXiMgFjLHccJCg0wBMsr8RagroH9xh3AtuG+YIB9q6IcKCzBj6Z15tdQuw0uhCq/cOgs/c70IglNfyCFmquxS6Nsg2ajTQPiIEniycpUteER9e9va7FH30uWSxQfElZpkSK0Ro22IPTf2iZudUkyKWYSzhmJS/y3hM68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOEJSszH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOEJSszH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBD81F000E9;
	Thu, 16 Jul 2026 04:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784176946;
	bh=CGEQtmwZhL/QDVcdeogS/qkYdSBAwpyR0SB/twzHBc0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oOEJSszHlEU4110ZiQbTDAJ6cvttMX4ZtQuR6vAmaDJ7o39uFxeu82mDfNxeUjXzR
	 Sa525wG1y2L8QSNc0fW1/BBdgK6wlWbiCjYKuYJr+BENHaMgo0NS/7sZlkqUtKVola
	 CV2T4qF6ggytAGHFQ9NBHDbCHjH95ZOgmi7uQFh65VR5nE9J33/dnJddOX3jxr+cFs
	 0zHcqU9cBq9R8/7nkp7nHtBxmmkM8c2inRplnhs5YgpSZx8pVzyaB6HVZUcFdcwEAM
	 lXGyyerDDWDZ+ozfF9UpcAm5BLxILJfHDfiQfyZEDQpSnEf7o5Sy7YNHtsPSqVe1v7
	 /EfUT+gmD3N2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/14] perf stat: Extend JSON output linter to test
 core aggregation checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260716043223.388233-12-irogers@google.com>
References: <20260525231900.3527228-1-irogers@google.com>
 <20260716043223.388233-1-irogers@google.com>
 <20260716043223.388233-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 04:42:25 +0000
Message-Id: <20260716044225.CEBD81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch omits `check_metric_only`, `check_per_cache_instance`,=
 and `check_per_cluster` from the `--new` API test batch for JSON output.
--

--- Patch [11]: [PATCH v3 11/14] perf stat: Extend JSON output linter to te=
st core aggregation checks ---
commit f2ce77eea150cec3c0f150510510cdbfab125f9f
Author: Ian Rogers <irogers@google.com>

perf stat: Extend JSON output linter to test core aggregation checks

This patch extends the perf stat JSON output tests to run basic and standard
CPU/thread aggregation checks under the --new JSON print flag.

> diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/test=
s/shell/stat+json_output.sh
> --- a/tools/perf/tests/shell/stat+json_output.sh
> +++ b/tools/perf/tests/shell/stat+json_output.sh

[ ... ]

> @@ -232,5 +234,22 @@ then
>  else
>  	echo "[Skip] Skipping tests for system_wide_no_aggr, per_core, per_die =
and per_socket since socket id exposed via topology is invalid"
>  fi
> +# Run New API JSON basic and standard aggregation checks
> +perf_new_opt=3D"--new"
> +api_label=3D"json (New API)"
> +check_no_args
> +check_system_wide
> +check_interval
> +check_event
> +check_per_thread
> +check_per_node
> +if [ $skip_test -ne 1 ]
> +then
> +	check_system_wide_no_aggr
> +	check_per_core
> +	check_per_die
> +	check_per_socket
> +fi

[Severity: Medium]
Are check_metric_only, check_per_cache_instance, and check_per_cluster
missing from this new API test block?

While the patch title correctly scopes the changes to core aggregation
checks, this appears to leave the JSON format test coverage incomplete
for the new streaming API.

Unlike the STD and CSV formats which received dedicated follow-up patches
for advanced PMU and metric-only checks, it looks like these checks are
left out for the --new JSON format. Could these be added to ensure the new
JSON output mode is fully covered?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716043223.3882=
33-1-irogers@google.com?part=3D11
