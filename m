Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794522915;
	b=G7PkKZ6xy+kDQvQn8alA/x88Oi+cspOa3pRtNhVxE7zR4ZL0HZK+3+YCX5ic+U9nwZ0M
	 6uQ7V8kuRjQgDd51174zTskOTj8zmS/Zn/B7Dy727IMffSns1b+MFQ7te9O1QR64st9WD
	 rUZhO3rJZ5vkK7VBwy7k8AZwDleOFMZJD7VXbVAPZrDolb+/QtdnwRIikX8KGmzohxPnc
	 7A9n+EtV4Xlg0uWD/idk6lcK7RHIYDo4xu9JzAT6BJ7KeYG7d/I5Izqfh9AuCChGNdt9c
	 qrd7Gg2HLZQWQbd7LfzEatwziQSnkb9F3ZiDkxdJl5vC5sCNmv5+C4DlKHx7MsMqBbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794522915;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SkjpD0VTWzCclYOYS6E07cl5jyfp0DsnLe5Z2kRi5pU=;
	b=Weh1Mzpu7KqKwzlUlJ0Y1GBSovr2srCpEvb/l48q7s03MX8sgwjmhzDkdhxTbqGkA6NM
	 rTOghvNMHyGHwKZtxMtb2IMR2rJXPCeMLCmkkI4BwU59xZM0pyFJ1wvRuZupkENmH/KP2
	 pMU/8S7NJKIw/o1EmMgcBJJ8HJo03PlUH+8d6Bp+5mlWKMhtJ+9Tvn5QYurLG6iZYkOfj
	 XVNnm2gKsVBe3cXNJLkOn4PWYfxkGHJ/55C816llmcr7SdjTIW3j4HGWBQeF8BdDXg0VL
	 R/b5O7mhZK2OQ0FfE3i/B1mSmfc0y1j0qgF/QDjd7y4S3+3q1jHmDWLYrmZTdITo7Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jBUdcW1p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1361606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 22:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jBUdcW1p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0471F000C4;
	Thu, 12 Nov 2026 22:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794522914;
	bh=SkjpD0VTWzCclYOYS6E07cl5jyfp0DsnLe5Z2kRi5pU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=jBUdcW1p26xaKVTjwu5YtJ1wD+1h2rQ8byekeNHJCsSCFhyRY+uLUAKSs7d4s0ZuJ
	 07M+CjCvrQNOOu7smEosyAD1KwozQZWeJ8LrT+93mS5XnxvYZiYqd2jGlTYF5dkSJw
	 3VhIA2Sa9F3WHaQ3wbdxrlV9Hzkrwlif98+FEHdxUvk7Tgbppb1sclSr2YGhiWtiz9
	 P3/lef6wYpOcCt2zfgSzsvCV3MJ164BUbhH3tMUB/4GxLixkdiTf+H++Wrs8xj+S9h
	 PbqRSMyXqs4ueLUZG3xyvyrPn9x0VsOV9hMmjtArTTZjN7OY58Xp6rATTeHQr7E9bC
	 P3i8uiiUUZwsw==
Message-ID: <sashiko-outbox-211916@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/1] perf jevents: Check the keys of the JSON tables
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261112222526.462146-2-takano32@gmail.com>
References: <20261112173241.197996-1-takano32@gmail.com>
 <20261112222526.462146-1-takano32@gmail.com>
 <20261112222526.462146-2-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 22:35:14 +0000
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
- [Low] perf jevents: main() rejects --check=3DDIR due to exact sys.argv
  check
- [Low] perf jevents: _check_tables() silently passes nonexistent
  directories
--

commit 45e79c2a6c1a4e8e393708b7a23890578df64421
Author: TAKANO Mitsuhiro <takano32@gmail.com>

perf jevents: Check the keys of the JSON tables

This commit adds a --check option to jevents.py to validate JSON event
table keys against an allowlist and adds a shell test for it.

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

[Severity: Low]
Does _check_tables() silently succeed when given a nonexistent directory?

Although the commit message notes that a missing directory is reported
instead of passed, --check does not use type=3Ddir_path and
Path(root).rglob('*.json') yields an empty iterator when root does not
exist, so _check_tables() returns 0 without checking any files.

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

[Severity: Low]
Does the "'--check' in sys.argv" guard reject "--check=3DDIR"?

List membership checks for an exact match against "--check", so passing
"--check=3DDIR" as a single argument skips this branch and falls through to
the main ArgumentParser, which fails because the positional arguments are
missing.

> diff --git a/tools/perf/tests/shell/jevents_check.sh b/tools/perf/tests/s=
hell/jevents_check.sh
> new file mode 100755
> index 0000000000000..62ce70ef5d022
> --- /dev/null
> +++ b/tools/perf/tests/shell/jevents_check.sh
> @@ -0,0 +1,29 @@
[ ... ]
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
> +
> +exit 0

[Severity: Medium]
Should jevents_check.sh also run --check against the in-tree tables under
tools/perf/pmu-events/arch?

As written, the test only checks a synthetic file in a temporary directory
and neither the build nor perf test ever runs --check on the repository's
JSON tables, so unknown keys in tools/perf/pmu-events/arch go undetected.
Also, discarding stdout and stderr on the negative check means any crash or
import failure in jevents.py will cause that check to pass.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112222526.4621=
46-1-takano32@gmail.com?part=3D1
