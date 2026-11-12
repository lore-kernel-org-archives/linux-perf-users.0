Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505565;
	b=edIQ8f0rWCnmCnb8dlHcEHKWu5le87KDgdcACTpVxwCK6yXSPAk/FA/njtIC8yist39N
	 GfN6px1YqhmhLXEaNX4IH2ZaNVs2xue36gFwzlXHHLp+atN2OYMAA4fAojaNTsufAowev
	 ORg0+8mwAjjFWNWY0dcFhPyqT3pqNsPqVuCw5oCBdh6S0MYJvmHFWfscn8aNHUwBp0zg0
	 yt9PpKkoKWkgV9PhuOLZcuc/saxYHmXH10kC0kn49Unj/HdsGRzPiWvEVtsNB9pa5gmaz
	 8B90rL1ZVuSmfpjPy0qT+CcJDlCQtt+BIekh3feY6OvKkDla9YhrkURfO+i+4WHggOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505565;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=C86U8RloTglgsszDzhJdbgMg/rffmA12FYMFxG8eadk=;
	b=saBQSWZCrigWv6VYEoV2Lrl79XEk8a5QFyOgDADKKWFBhxz7qfyMdht7N8i20RuFWbcr
	 7GriZCWDB3pejP/Ezj5TfMj9fSpL+QP0pYEIpzo2Rm7EsjHhxre+rKkY7lmHx0eizrm6n
	 G4fmUpfQ3aJWXGIvdmrAAg0ZUTkaApc/mfiYnYaQpx/fVvR/00L/3Zs9t6OiswPlGoDX+
	 oukVWTV9i7kzJOXeHUdMoRDYTVS+iiZEKqC68Sb2FB5JOMvno0q+yruzFtLv+7P+FaihZ
	 /Hwq4wGyQWIxKbGNQpqTHJj5hhhfil88dV+Cs0Hv88jY0O5GjYcA69pVA7NupvqXq9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l1KeHlPw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819E7606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l1KeHlPw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC421F000C4;
	Thu, 12 Nov 2026 17:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794505564;
	bh=C86U8RloTglgsszDzhJdbgMg/rffmA12FYMFxG8eadk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=l1KeHlPwErMwmEUUaS3k3iVYv76SuHLyD/E8gICkR73ZhiCopN10voycNjZ95z1wu
	 aTsZ3fZZkxMLZZL7Q42ubG9O43P+9xUumvaZhMZyKTD0fuuGvzTHKRkQ6P2YKT8Uqf
	 pri030PhBa7hf3ZroKBhB91zcRRpt0veuA164TtqAr61VComBpSyUI+X0oCZ3HFEGO
	 G1MuLhv2x3b18RiVao/RGoRnfup/R8jQBkf2SymebRF1aXMT7YoxpW92FUhHU+KF/Y
	 hOoqoaYGFKwcCjsw579NqJYr85H07rKaXKhIXS8Xi/iaUsiQrGAlta3oMILYtFjaNu
	 7VU9YXyxhJkzw==
Message-ID: <sashiko-outbox-211625@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/1] perf jevents: Check the keys of the JSON tables
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261112173241.197996-2-takano32@gmail.com>
References: <20261112162823.139419-1-takano32@gmail.com>
 <20261112173241.197996-1-takano32@gmail.com>
 <20261112173241.197996-2-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 17:46:04 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] perf test: jevents_check.sh never checks in-tree PMU JSON
  tables
- [Low] perf jevents: --check exits 0 on missing dir and rejects
  --check=3DDIR
--

commit 36d55c52d8c667ed37678b7b12c79a3614fd5c56
Author: TAKANO Mitsuhiro <takano32@gmail.com>

perf jevents: Check the keys of the JSON tables

This commit adds a --check option to jevents.py to report unrecognized JSON
object keys in PMU event tables and adds a shell test exercising that optio=
n.

> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 080e04b51b8c5..5daf92527573e 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
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
> +  # --check takes the directory to check and needs nothing else, so it i=
s read
> +  # before the parser below asks for the three positional arguments.
> +  if '--check' in sys.argv:
> +    ap =3D argparse.ArgumentParser()
> +    ap.add_argument('--check', metavar=3D'DIR', required=3DTrue,
> +                    help=3D'report the keys of the tables under DIR and =
exit')
> +    sys.exit(_check_tables(ap.parse_args().check))
> +
>    def dir_path(path: str) -> str:
>      """Validate path is a directory for argparse."""
>      if os.path.isdir(path):

[Severity: Low]
Does _check_tables() exit with status 0 when given a nonexistent or
non-directory path?  Unlike starting_dir below, --check does not validate i=
ts
argument with type=3Ddir_path, and Path(root).rglob('*.json') yields an emp=
ty
iterator when root does not exist, so a misspelled directory silently passes
with zero files checked.

Also, checking "'--check' in sys.argv" misses the single-token "--check=3DD=
IR"
form, which falls through to the main parser and fails with missing positio=
nal
arguments.

> diff --git a/tools/perf/tests/shell/jevents_check.sh b/tools/perf/tests/s=
hell/jevents_check.sh
> new file mode 100755
> index 0000000000000..62ce70ef5d022
> --- /dev/null
> +++ b/tools/perf/tests/shell/jevents_check.sh
> @@ -0,0 +1,29 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# jevents_check: an unknown key in a table is reported (no_mlock)
> +#
> +# A key that is spelled differently is dropped without a word, so the ke=
ys of
> +# the tables are checked against the list jevents.py reads.
> +
> +jevents=3D$(dirname "$0")/../../pmu-events/jevents.py
> +python=3D${PYTHON:-python3}
> +
> +# An installed perf has the test but not the generator, and a python that
> +# cannot run the generator is not a failure of the check.
> +[ -r "${jevents}" ] || exit 2
> +command -v "${python}" > /dev/null || exit 2
> +
> +tmp=3D$(mktemp -d)
> +trap 'rm -rf "${tmp}"' EXIT
> +tables=3D"${tmp}/arch/x86/model"
> +mkdir -p "${tables}"
> +
> +# Known keys pass.
> +printf '[{"EventName": "a", "EventCode": "0x1"}]\n' > "${tables}/events.=
json"
> +"${python}" "${jevents}" --check "${tmp}/arch" > /dev/null || exit 1
> +
> +# A key the generator does not read is reported.
> +printf '[{"EventName": "a", "NotAKey": "x"}]\n' > "${tables}/events.json"
> +"${python}" "${jevents}" --check "${tmp}/arch" > /dev/null && exit 1

[Severity: Medium]
Does jevents_check.sh ever run jevents.py --check on the in-tree JSON tables
under tools/perf/pmu-events/arch?

The commit message and file header state that the table key check runs as a
perf test, and _TABLE_KEYS and _check_tables() include exceptions for unused
keys and metricgroups.json in the tree.  However, this script only tests a
synthetic two-key file in ${tmp}/arch, and nothing in the build or test sui=
te
invokes --check on tools/perf/pmu-events/arch, so neither existing nor futu=
re
key typos in the repository's PMU tables are caught by perf test.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112173241.1979=
96-1-takano32@gmail.com?part=3D1
