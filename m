Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501516;
	b=Kzy/mQZqjS0zh9Gs/0y4rFytaS/X1ZgPzy7vtUhQW/vN1KNVqoTWA/ReV4bqSmKDNfjq
	 xoSSpcY902QAGXgsUPfOHklpw7fikqDIzPWmKjAlOVGGioo/g9Xau0tQDiSynZ6blRMIu
	 WfB/4ajgiVX0qglihZfF+pxhp/po+Yqp5shZFuYXa7frcUBsD/o6WH63Q//6seMIw5lMs
	 xvO3Z86DxTV0LGQntCBnXxnXhtI6BpPpvt0D4U7lnuJzI1fHAIGSSgXWduMjj0Sm5UyrI
	 hFyE3jkJ7kx4MXtwSwrCiZYDVnB1sgmQTaebCj8Yu6nDATxBcvRhe8Jzer1T5VTU0jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501516;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XaFQrq2mo3nSbWLXQ1KmzVQMJ8goAKSwZDQ8OZkdvKc=;
	b=Yue5uUUXcDscYliDfZZgKic2xZ0TGg6/oTxkjGE66NNNVqI3OZeS6mQ9OGkWXHk/M91N
	 kWl2QVjwXxPxLYoof1fmwEoThRp1B5BlH+X6sUtGbGLzUzbMlXv1e20GxK0EbvAjEOUcE
	 5XME6WmUW9SVCtiEYmZZd4YOfEN5Xcw8fHtEA3zck3AmWvxjXsReXfLV8ukHvVb56jxcM
	 IXV8kRmC95Xpfh9jUI9nLjvjX3o1XQ4MHOdjsDu+xxKuVQ6GxqKOmdmVSAN5Mo8HJ/b7r
	 8+mPIStJY2GBgmYD+zpjrrVTIDrEaqk54tmQ9jSiqvGmAzrpguASGDMNLIsqgwTwJaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DtVSm5ko;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA3760A3830
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DtVSm5ko
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90701F000D2;
	Thu, 12 Nov 2026 16:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794501516;
	bh=XaFQrq2mo3nSbWLXQ1KmzVQMJ8goAKSwZDQ8OZkdvKc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DtVSm5kogtc3zj2xYWozZGVHI4CjbdYg9RaJXKyg/97Md0jC1pZ3Fmm5KZbZBIO2N
	 p0myf2etxhIdWRa/bpTx35fI9pd+LUxSQiNuZptIk50XVLgbxrhQTaLPbkWOuOOnqe
	 VW+Id25/pdcoBvDOs4sa+d2jg00mELmB5+yIll2xlBk0zbMEGLtVw94MclkYc8aKNP
	 gJaJKo+Oe0GabT7b+lLg2OweswDMydyVPpJtTdj48MjimIbatQMnKxZo0u4RpE4jvJ
	 HIj8L1Ikk4nqWbSBOUHDgGQvwFws4T+VUmbE3pXnx9gvmMX66QDZcDKOWaXjnjyODI
	 T9jwXpNz6J8NQ==
Message-ID: <sashiko-outbox-211512@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/1] perf jevents: Check the keys of the JSON tables
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261112162823.139419-2-takano32@gmail.com>
References: <20261111150920.2383157-1-takano32@gmail.com>
 <20261112162823.139419-1-takano32@gmail.com>
 <20261112162823.139419-2-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 16:38:35 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] perf test: jevents_check.sh never checks in-tree PMU JSON
  tables
- [Low] perf jevents: _check_tables() ignores mandatory arch and model
  arguments
- [Low] perf test: jevents_check.sh hardcodes python3 without
  availability check
--

commit 59714c85104e0be8e44b8587ef592e9df4d4a604
Author: TAKANO Mitsuhiro <takano32@gmail.com>

perf jevents: Check the keys of the JSON tables

This commit adds a --check option to jevents.py to report JSON event table
keys not in _TABLE_KEYS, along with a shell test for the option.

> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 080e04b51b8c5..397b4fc977497 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
[ ... ]
> @@ -1450,6 +1451,38 @@ def _init_worker(std_events: dict) -> None:
[ ... ]
> +def _check_tables(root: str) -> int:
> +  """Report the keys in the tables under root that a table may not carry=
."""
> +  bad =3D 0
> +  for path in sorted(Path(root).rglob('*.json')):
> +    if path.name.endswith('metricgroups.json'):
> +      # A dictionary keyed by metric group name, not a list of events.
> +      continue
> +    for obj in json.loads(path.read_text(encoding=3D'utf-8')):
> +      if extra :=3D set(obj) - _TABLE_KEYS:
> +        print(f'{path}: {sorted(extra)}')
> +        bad +=3D 1
> +  return 1 if bad else 0
> +
>  def main() -> None:
>    global _args
> =20
> @@ -1494,8 +1527,13 @@ such as "arm/cortex-a34".''',
>        'output_file', type=3Dargparse.FileType('w', encoding=3D'utf-8'), =
nargs=3D'?', default=3Dsys.stdout)
>    ap.add_argument(
>        'output_string_file', type=3Dargparse.FileType('w', encoding=3D'ut=
f-8'), nargs=3D'?', default=3DNone)
> +  ap.add_argument('--check', action=3D'store_true',
> +                  help=3D'check the keys of the tables under starting_di=
r and exit')
>    _args =3D ap.parse_args()
> =20
> +  if _args.check:
> +    sys.exit(_check_tables(_args.starting_dir))

[Severity: Low]
Why does --check still require positional arch and model arguments on the
command line if _check_tables() ignores _args.arch and _args.model and walks
every JSON file under starting_dir?  Callers such as jevents_check.sh have
to pass dummy values like "x86 all" before starting_dir that have no effect
on the check.

> diff --git a/tools/perf/tests/shell/jevents_check.sh b/tools/perf/tests/s=
hell/jevents_check.sh
> new file mode 100755
> index 0000000000000..eb3125e1486ab
> --- /dev/null
> +++ b/tools/perf/tests/shell/jevents_check.sh
> @@ -0,0 +1,24 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# jevents_check: an unknown key in a table is reported (no_mlock)
> +#
> +# A key that is spelled differently is dropped without a word, so the ke=
ys of
> +# the tables are checked against the list jevents.py reads.
> +
> +jevents=3D$(dirname "$0")/../../pmu-events/jevents.py
> +[ -r "${jevents}" ] || exit 2
> +
> +tmp=3D$(mktemp -d)
> +trap 'rm -rf "${tmp}"' EXIT
> +tables=3D"${tmp}/arch/x86/model"
> +mkdir -p "${tables}"
> +
> +# Known keys pass.
> +printf '[{"EventName": "a", "EventCode": "0x1"}]\n' > "${tables}/events.=
json"
> +python3 "${jevents}" x86 all "${tmp}/arch" --check > /dev/null || exit 1

[Severity: Low]
Will jevents_check.sh fail with exit code 1 instead of skipping with exit
code 2 on systems where python3 is not installed or where a custom
interpreter is configured via PYTHON?  Sourcing lib/setup_python.sh and
invoking $PYTHON would skip cleanly when Python is unavailable.

> +
> +# A key the generator does not read is reported.
> +printf '[{"EventName": "a", "NotAKey": "x"}]\n' > "${tables}/events.json"
> +python3 "${jevents}" x86 all "${tmp}/arch" --check > /dev/null && exit 1

[Severity: Medium]
Does jevents_check.sh ever run jevents.py --check against the in-tree JSON
tables under tools/perf/pmu-events/arch?  The script only tests two
synthetic one-line files in ${tmp}/arch, so neither the build nor perf test
validates the repository's PMU event tables or checks that _TABLE_KEYS stays
in sync with them.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112162823.1394=
19-1-takano32@gmail.com?part=3D1
