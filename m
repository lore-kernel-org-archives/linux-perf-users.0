Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B108372B3B
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 04:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784176723; cv=none; b=eZOKXQqKQ0dk8qwE1pPR6iIxfvT69CnZ9ePcMo8CP/gpHSLhKxa92mQ6cUXW6gH80T5+Rm4+5GWDTHymNkslu1W3zi2NEdWKnB5wtyo8xkiU/FLVkJQNSxtFo00lsH4dE04FRifijGljmGC+iAfP+q0/AXm+ebHOj2VAHFfqbG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784176723; c=relaxed/simple;
	bh=YFRIf2d9euR5YDIq79R5RHFWoOWLRPan6rhszwuY7l4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kdwlSzB4tbYSJHdqsTvcv6mMkl3yr8KUoUUewwS6NL6H40LxRfRrdXtrbhpJdxYz8W3gbtqhC/j3om9KTn43tClj+Clb3NIyreoSfY4LQjWARVmjqUSChrIRh3GE6/RgvH3U3Kr5nbyhX9JIqKCh2nTr79h6JGifg5ccdE6VpZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVd++SZO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVd++SZO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787BA1F000E9;
	Thu, 16 Jul 2026 04:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784176721;
	bh=zs+x3xjv6hIzcAupSI99Io5mlG3H0/OGHJ+ruPi6nYs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RVd++SZOzdVtOPVaFCi4SZbFZiS9xnI6aCkHvpp+uuDF5mRFn+WQU8I5l13lICn40
	 yAAyKfXZFtre9zFVOw4nqZnNf6fru6wWeLlCdvfexEedm6Iu3lEbRO8ugYZeU65SEp
	 m8UU65r/DZZtL6rgAAN/OH+nSk+dGRe+Y4yybsfv+wukY2HcF8z5CytUWzsqrXrxYx
	 8D4MwZzpxh4y18lfXSm738v2Zou0Ii6b17rljRNEMLMXY9ChRqdYz37OkACyf14gyc
	 oM+3wUD858EUsgJYJz1qaVkGd7YHPEn+xkDlh4kCQQD9iSBxiGpPTUExsB6EqMPB5b
	 DohW63UG/j6Hg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/14] perf stat: Extend STD output linter to test
 core aggregation checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260716043223.388233-5-irogers@google.com>
References: <20260525231900.3527228-1-irogers@google.com>
 <20260716043223.388233-1-irogers@google.com>
 <20260716043223.388233-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 04:38:41 +0000
Message-Id: <20260716043841.787BA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch omits tests for the `--per-cache` and `--per-cluster` =
aggregation modes in the new API checks, leaving these modes untested for t=
he new generic print traversal engine.
--

--- Patch [4]: [PATCH v3 04/14] perf stat: Extend STD output linter to test=
 core aggregation checks ---
commit 47016446b8ab80533915b228d12dbc7e4f1bf6a4
Author: Ian Rogers <irogers@google.com>

perf stat: Extend STD output linter to test core aggregation checks
   =20
This commit extends the stat+std_output.sh script to run standard CPU and=20
thread aggregation checks under the --new print flag. It aims to verify the=
=20
standard console outputs produced by the decoupled printing engine across=20
core CPU-aggregation modes.

> diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests=
/shell/stat+std_output.sh
> index 233e0a50eb33c..8dee005a72816 100755
> --- a/tools/perf/tests/shell/stat+std_output.sh
> +++ b/tools/perf/tests/shell/stat+std_output.sh
> @@ -121,6 +121,17 @@ fi
>  # New API basic checks
>  perf_cmd=3D"--new -o ${stat_output}"
>  check_no_args "STD (New API)" "$perf_cmd"
> +check_system_wide "STD (New API)" "$perf_cmd"
> +check_interval "STD (New API)" "$perf_cmd"
> +check_per_thread "STD (New API)" "$perf_cmd"
> +check_per_node "STD (New API)" "$perf_cmd"
> +if [ $skip_test -ne 1 ]
> +then
> +	check_system_wide_no_aggr "STD (New API)" "$perf_cmd"
> +	check_per_core "STD (New API)" "$perf_cmd"
> +	check_per_die "STD (New API)" "$perf_cmd"
> +	check_per_socket "STD (New API)" "$perf_cmd"

[Severity: Medium]
Should check_per_cache_instance and check_per_cluster also be included in t=
his
block?

The commit message mentions extending tests for all standard CPU aggregation
checks, but it appears the --per-cache and --per-cluster aggregation modes
were omitted here compared to the older API testing blocks, leaving these
modes untested for the new generic print traversal engine.

> +fi
> =20
>  cleanup
>  exit 0

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716043223.3882=
33-1-irogers@google.com?part=3D4
