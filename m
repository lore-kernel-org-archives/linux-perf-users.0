Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BBB388369
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 04:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784177532; cv=none; b=WaCi9Mh0wVMSTOkdqr3WpDvsyJdgBdGR/1M2SLZ/RyBOaQXE5e3hR/lPpmULVYbjhQi9koj0Lz8QvD1wCJNwWp0tpqT1aSgu7dTnc3afdfPlTN4/6eJ37Ht2TzXpLSHHp7gEYpT9nImJmm/0IxjbTrxnXEGpyfnXymr8xHF/kr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784177532; c=relaxed/simple;
	bh=X6mI6+JPHx+Z5+Mn5QE+T0HfhvRBViQH8hdh2DIAnk0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KkjlZI7/uck9v8oxDUpMNVRxU9h6qyrmxsOU66fnB57cfQ1s6K/tBi+lJkr99GM5zgBRwcNlv4vhiW6pj1dSf7sFjueLVV9P3YkNztIMALCnhNYMxkpKxHVQQ2YIiHTwfbUq068qk4ZHZyX8mrOtRaUEF8aedVhDiCKsQagZB3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMYvCS4F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMYvCS4F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194A51F000E9;
	Thu, 16 Jul 2026 04:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784177531;
	bh=8lKqYATcuYrT++avt54egGwmRHw/beOu1ZZbZZ1V4Dg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bMYvCS4Fx35JuRwq/AnmcpKI0Eh1L8jqIH9jCcmGXWOMqkMujDVLG2LBYsn+zW+Eg
	 Xiodk5FTMyR03oAIaTBHp6nkz0NyhMGykIFQ+aJFdqmF5+fy43L62ht7kMKSXJ6JKT
	 8LTkIABDi5CCgc0rpP3zGsvktGfj68/4+U9ORQFYw6QNIKxCoe7WXzPoZA8cyGiJlk
	 pnjI1uuXNqJGxePGh9yIGCzeUjoCNVz+Ti6FiIrvb993Hx0+55i+GUHdh+f8XgZ+vZ
	 I5LOr562BNg0DYkTJxdVTaIwTu6On7FQlEOLPIt9HI9hlaxmaxhwyHwqN8KU4IwSWJ
	 zHvwhoxDR7HGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/14] perf stat: Add --new support to PMU metrics
 Python validator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260716043223.388233-14-irogers@google.com>
References: <20260525231900.3527228-1-irogers@google.com>
 <20260716043223.388233-1-irogers@google.com>
 <20260716043223.388233-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 04:52:10 +0000
Message-Id: <20260716045211.194A51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] is_basic_shadow_metric() performs an unchecked strcmp() on a pot=
entially NULL mexp->metric_name.
- [Medium] Cgroup layout formatting is completely stripped from CSV, JSON, =
and STD output modes.
- [Medium] Zero-counter skipping logic was mistakenly scoped only to STD ou=
tput, breaking CSV and JSON modes with output spam.
--

--- Patch [13]: [PATCH v3 13/14] perf stat: Add --new support to PMU metric=
s Python validator ---
commit ac2ffcbd7ec0fccf19ec9629f7f74d37b92d6545
Author: Ian Rogers <irogers@google.com>

perf stat: Add --new support to PMU metrics Python validator

This patch extends the performance metrics value Python validation script
tools/perf/tests/shell/lib/perf_metric_validation.py to support a new
command-line argument -new. When set, the Validator class appends the --new
option flag to its internally spawned perf stat commands. This enables
validating Intel PMU metric mathematical values generated specifically by t=
he
decoupled, streaming JSON printing callbacks.

> diff --git a/tools/perf/tests/shell/lib/perf_metric_validation.py b/tools=
/perf/tests/shell/lib/perf_metric_validation.py
> --- a/tools/perf/tests/shell/lib/perf_metric_validation.py
> +++ b/tools/perf/tests/shell/lib/perf_metric_validation.py
[ ... ]
> @@ -379,7 +380,10 @@ class Validator:
> =20
>      def _run_perf(self, metric, workload: str):
>          tool =3D 'perf'
> -        command =3D [tool, 'stat', '--cputype', self.cputype, '-j', '-M'=
, f"{metric}", "-a"]
> +        command =3D [tool, 'stat']
> +        if self.new_print:
> +            command.append('--new')

[Severity: Medium]
While enabling this test for the new API, does the underlying --new
implementation safely handle metric evaluation?

In tools/perf/util/stat-print.c, is_basic_shadow_metric() performs an
unchecked string comparison:

tools/perf/util/stat-print.c:is_basic_shadow_metric() {
    ...
    for (i =3D 0; i < ARRAY_SIZE(basic_metrics); i++) {
        if (!strcmp(basic_metrics[i], name))
            return true;
    ...
}

If perf_stat_print_metricgroup() iterates through metric expressions and
passes a NULL mexp->metric_name (which can happen with unnamed or dynamic
metric expressions), will this strcmp trigger a segmentation fault?

[Severity: Medium]
Additionally, does the new printing API preserve cgroup aggregation
information?

When perf_stat__print_cb() traverses events in tools/perf/util/stat-print.c,
the generic callback signature omits cgroup parameters entirely:

tools/perf/util/stat-print.c:perf_stat__print_cb() {
    ...
    ret =3D cb->print_event(ctx, config, counter, 0, val, ena,
                          run, stdev_pct);
    ...
}

Will this cause a complete loss of cgroup layout formatting for CSV, JSON,
and STD output modes since the callbacks never receive the cgroup
identifiers?

[Severity: Medium]
Finally, how does the new API handle zero-counter skipping for CSV and JSON
modes? The core traversal engine perf_stat__print_cb() passes events to
callbacks without checking should_skip_zero_counter().

While the STD format callback might implement this filter locally, the CSV
and JSON callbacks do not appear to check it:

tools/perf/util/stat-print-csv.c:csv_print_event() {
    ...
    ev->val =3D val;
    ev->ena =3D ena;
    ev->run =3D run;
    ...
}

Could this result in CSV and JSON outputs being flooded with zero-valued
ghost events, such as uncore PMU events on non-leader CPUs, causing
incorrect statistical exports and output spam?

> +        command.extend(['--cputype', self.cputype, '-j', '-M', f"{metric=
}", "-a"])
>          wl =3D workload.split()
>          command.extend(wl)
>          print(" ".join(command))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716043223.3882=
33-1-irogers@google.com?part=3D13
