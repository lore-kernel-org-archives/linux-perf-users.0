Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3A449C4DB
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791304239; cv=none; b=NQGToeIxZhkWi2rZEnPQ6QX+tzqkB8CbuKVZd2k8r1X/bAG7kVe850SEaMKi3Ay02AC52Hq9IuViIQ8h9LltvsyFXI2iT4xMAJAgjqAKzj2qY0MWDUxFAX6VlOPLIq+1ZFEEJyYuRs8r8V/gK2q3wjhDQWBFBLGjnzY0kIUGZQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791304239; c=relaxed/simple;
	bh=dk4nZSCn8OU3cvayV/+SUXronngEmumsLhmxZt46bnY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=GbEnrA/pcw1G9XabXWxrc8FhpeFl8BmMeKwHWme3ofyqC2e1XHdVM21U1mgMRLS4K39VL+ZTScFX4v+tne+B37OliY6zlpBIWHeI+hoSU6uVH9NGDD4JwlG4LyeuH7eQWV8V3In0ip2x1rrA5hDREUwd23Hk358PRn1ZJKawc1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPYIMSjt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPYIMSjt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2201F0089C;
	Tue,  6 Oct 2026 16:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791304238;
	bh=YHa7cPy48wYfOMY1PPdaesoAcRbAIbZg3yjMv9953f0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LPYIMSjthCwfL6JRtZG3EWzf47X3/E7V8U/55dnmBvo+MpTjdpC4GAves8UepzVq/
	 vjxyGaeqKOiccmSXP6zMqGtJtOMlqWBbTXyLAlyxgKWP8uR4egJRGK4398K/rDAcDw
	 C7QMiLRbU9G/wqVmqrPlFGCdlEyUylAB1WtSbPIeSZkG6WEbI+wX7ZWqMsgC/Atpza
	 Id7I29LsjQ5zW0bAwc9LOdE6H3i9VvXSYsGDZhWv2hAGGLn5GpyO+daq/9uAAGMweh
	 bel8dj66CcVQj13qsr9jgHV6Byz1tIvthE7Z6aYxcOxUxq/xoir4Z01Tv/WRytY7RM
	 e6f+E6LUkKn8A==
Message-ID: <sashiko-outbox-162257@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] perf test attr: Fix legacy event encodings in group
 tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006161309.3078488-5-acme@kernel.org>
References: <20261006161309.3078488-1-acme@kernel.org>
 <20261006161309.3078488-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 16:30:37 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf test attr: test-record-group-sampling fails on bare cycles
- [Medium] perf: test attr fails on hybrid due to PMU type shift in legacy-=
hardware-config
--

commit 89d023b229e1044502e25f88b4301ecff3715694
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf test attr: Fix legacy event encodings in group tests

Since b1c5efbfd92eb84d ("perf parse-events: Remove hard coded legacy
hardware and cache parsing"), event names are resolved with sysfs/JSON
priority over the legacy encodings, so bare cache-misses and
instructions now become the core PMU sysfs/JSON events. This patch
requests the legacy encodings explicitly with the legacy-hardware-config
term.

> diff --git a/tools/perf/tests/shell/attr/test-record-group-sampling1 b/to=
ols/perf/tests/shell/attr/test-record-group-sampling1
> index 4748ab7bf6843..5be9a1a2a4ff0 100644
> --- a/tools/perf/tests/shell/attr/test-record-group-sampling1
> +++ b/tools/perf/tests/shell/attr/test-record-group-sampling1
> @@ -1,6 +1,6 @@
>  [config]
>  command =3D record
> -args    =3D --no-bpf-event -e '{cycles,cache-misses}:S' kill >/dev/null =
2>&1
> +args    =3D --no-bpf-event -e '{cycles,default_core/legacy-hardware-conf=
ig=3D3/}:S' kill >/dev/null 2>&1

[Severity: Medium]
Since "cycles" is left as a bare event, wouldn't this still fail the strict
type=3D0 and config=3D0 requirements later in this file?=20

If "cycles" resolves dynamically via sysfs/JSON to a core PMU event (typica=
lly
type=3D4), attr.py will read a non-zero type and fail the equality check. S=
hould
"cycles" also be updated to "default_core/legacy-hardware-config=3D0/" to m=
atch
these expectations?

>  ret     =3D 1
>  kernel_since =3D 6.12

[ ... ]

> diff --git a/tools/perf/tests/shell/attr/test-record-group-sampling2 b/to=
ols/perf/tests/shell/attr/test-record-group-sampling2
> index e0432244a0eb7..c05225167ec34 100644
> --- a/tools/perf/tests/shell/attr/test-record-group-sampling2
> +++ b/tools/perf/tests/shell/attr/test-record-group-sampling2
> @@ -1,6 +1,6 @@
>  [config]
>  command =3D record
> -args    =3D --no-bpf-event -c 10000 -e '{cycles,cache-misses}:S' kill >/=
dev/null 2>&1
> +args    =3D --no-bpf-event -c 10000 -e '{cycles,default_core/legacy-hard=
ware-config=3D3/}:S' kill >/dev/null 2>&1

[Severity: Medium]
Similarly, will leaving "cycles" as a bare event here cause a failure again=
st
the strict expectations?

>  ret     =3D 1
>  kernel_since =3D 6.12

[ ... ]

> diff --git a/tools/perf/tests/shell/attr/test-record-group1 b/tools/perf/=
tests/shell/attr/test-record-group1
> index eeb1db392bc9c..0437ea4939e88 100644
> --- a/tools/perf/tests/shell/attr/test-record-group1
> +++ b/tools/perf/tests/shell/attr/test-record-group1
> @@ -1,6 +1,6 @@
>  [config]
>  command =3D record
> -args    =3D --no-bpf-event -e '{cycles,instructions}' kill >/dev/null 2>=
&1
> +args    =3D --no-bpf-event -e '{cycles,default_core/legacy-hardware-conf=
ig=3D1/}' kill >/dev/null 2>&1

[Severity: Medium]
Will this fail on hybrid architectures like Intel Alder Lake?

On hybrid platforms, perf_pmus__supports_extended_type() evaluates to true.
This causes config_term_pmu() in tools/perf/util/parse-events.c to shift the
dynamic PMU type into the upper 32 bits of attr->config when using
legacy-hardware-config:

tools/perf/util/parse-events.c:config_term_pmu() {
	...
	attr->config =3D term->val.num;
	if (perf_pmus__supports_extended_type())
		attr->config |=3D (__u64)attr->type << PERF_PMU_TYPE_SHIFT;
	attr->type =3D PERF_TYPE_HARDWARE;
	...
}

This could yield a config value of (4 << 32) | 1 instead of 1.

Since the test script keeps the hardcoded expected attribute config=3D1 and
tools/perf/tests/shell/lib/attr.py uses strict string equality, will this
result in an unavoidable test failure?

>  ret     =3D 1
> =20
>  [event-1:base-record]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006161309.3078=
488-1-acme@kernel.org?part=3D4
