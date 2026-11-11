Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366336;
	b=T4C2lLx9lrR2z14wgYXcSQpobiGOMKoS+Bs1Es3louT2BKvbsIYimXgAJ6dVnCm3rHKp
	 2gjz/VEAEUOHHbAJRpBby4xrWbEZUWAFfL1Ca4gYDab2VISL5tGh+PtMGdiM6TiNnhI02
	 Lca4nwWSITg82rUQhMbBywcOrU3lqVAxhFewnEQVaPWR6mIiMM/+tOQbrTrbJAjOgJ3jI
	 9fj4D9o3tDNuf+ogh5jict7pQ96SznPTmVdYpc9h6YpqA+O133dYZFHWhSLG6acC7PPwk
	 n3BoYLoVRHJjLfgA17kuDChN/PIjoCMhz52mRUXagwjKhr7EDVpLpxlVOtC3q3XseDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366336;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DMeG9C0ZlQRuQxT5NqMY4ouWdZI99BhXKK01ybQOjGQ=;
	b=JjOZWFqbylPEx2T/S7AI+uh99Y6tN2RLu/YyQdPAP9gf8OOljlvk9xW3FEVQiakbqQ4r
	 o9WRIU/GCAPBVxd+nXMYsxYWNl0Y0SolrdG05gv0afiknzGoqcKAWIwgxQQazyWs6QJks
	 O3Ed9R1jpDYojWCfC6FvCLxIKLWnsFmDgwQ9qimapzFCkPkrulMl0/NgrkO8YbOlNCXPq
	 pVRVzEwu20V7c4MxJCoKanqeK1TqiOIDCnzPlGMo+TC28wGlgXShDZQOR+f5I64DM6UUu
	 waHgMVob8OXSpuBMWpTBUv66TBl6r/y5G+uAjSNJSB3z3EwI4tL31heaXMLVN7ArKBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DCI7qJoY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D36606A320
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 03:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DCI7qJoY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD661F0089F;
	Wed, 11 Nov 2026 03:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794366335;
	bh=DMeG9C0ZlQRuQxT5NqMY4ouWdZI99BhXKK01ybQOjGQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DCI7qJoY3yqLxui4bjPp6ziAuxFjE8ILyovT6zpMS+qsGDSv3Wje4AlGxvHJFNkCo
	 oU4jG7nquhWpR0NYfQ9mFP7ToiVLeZlOlo7pJGd83wbRIui7jwoyPLqFFhYKWWoMi8
	 vm2viilm6zR8gHpV8jkkiLoMNt7Y9fwe8ihy3u+rAcDqVpC578A3+98VX9tVM12j4Y
	 gf7YyAAXX61xFLvyxeifi7w86gTNJ78mRPF6eT8knR2ll2ueGrYkkUGUMszbx5Ca8q
	 lNoGYMVMkwK9U41S8mebgZYIXsf/u0H233Sagz4htv5QryqLZq0zwbzfBLNPCg03IJ
	 Fw4ui2wzlqARw==
Message-ID: <sashiko-outbox-208156@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] perf jevents: Name the metric when a MetricExpr
 is missing
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261111023448.1970467-2-takano32@gmail.com>
References: <20261110222250.1864777-1-takano32@gmail.com>
 <20261111023448.1970467-1-takano32@gmail.com>
 <20261111023448.1970467-2-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 03:05:35 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] perf jevents: output files opened before reading tables in
  main()
--

commit e40b6a0ff5427b090df6921a9048cd1849e4b0f0
Author: TAKANO Mitsuhiro <takano32@gmail.com>

perf jevents: Name the metric when a MetricExpr is missing

This commit raises a RuntimeError naming the metric when a JSON metric is
missing its MetricExpr, improves error reporting when parsing JSON tables,
and replaces argparse.FileType with explicit open() calls for output files.

> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 080e04b51b8c5..86060a228b755 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
[ ... ]
> @@ -1490,12 +1496,29 @@ such as "arm/cortex-a34".''',
>        type=3Ddir_path,
>        help=3D'Root of tree containing architecture directories containin=
g json files'
>    )
> -  ap.add_argument(
> -      'output_file', type=3Dargparse.FileType('w', encoding=3D'utf-8'), =
nargs=3D'?', default=3Dsys.stdout)
> -  ap.add_argument(
> -      'output_string_file', type=3Dargparse.FileType('w', encoding=3D'ut=
f-8'), nargs=3D'?', default=3DNone)
> +  ap.add_argument('output_file', nargs=3D'?', default=3DNone,
> +                  help=3D'file to write the tables to, default standard =
output')
> +  ap.add_argument('output_string_file', nargs=3D'?', default=3DNone,
> +                  help=3D'file to write big_c_string to when it is to be=
 kept '
> +                       'apart from the tables')
>    _args =3D ap.parse_args()
> =20
> +  # Opened here, and not by argparse, so that a failure before the table=
s are
> +  # written cannot empty a file the caller named.
> +  if _args.output_file in (None, '-'):
> +    _args.output_file =3D sys.stdout
> +  else:
> +    try:
> +      _args.output_file =3D open(_args.output_file, 'w', encoding=3D'utf=
-8')
> +    except OSError as e:
> +      ap.error(f'argument output_file: {e}')
> +  if _args.output_string_file =3D=3D '-':
> +    _args.output_string_file =3D sys.stdout
> +  elif _args.output_string_file is not None:
> +    try:
> +      _args.output_string_file =3D open(_args.output_string_file, 'w', e=
ncoding=3D'utf-8')
> +    except OSError as e:
> +      ap.error(f'argument output_string_file: {e}')
>    _args.output_file.write(f"""/* SPDX-License-Identifier: GPL-2.0 */
>  /* THIS FILE WAS AUTOGENERATED BY `jevents.py arch=3D{_args.arch} model=
=3D{_args.model}` ! */
>  """)

[Severity: Low]
Does opening _args.output_file and _args.output_string_file immediately
after ap.parse_args() still truncate existing output files when reading a
JSON table fails?

preprocess_arch_std_files(), _parallel_read_json_events(), and
preprocess_one_file() all run later in main(), after the files are opened
with 'w' and the header is written:

tools/perf/pmu-events/jevents.py:main() {
    ...
  for arch in archs:
    arch_path =3D f'{_args.starting_dir}/{arch}'
    preprocess_arch_std_files(arch_path)
    ftw(arch_path, [], collect_json)

  with concurrent.futures.ProcessPoolExecutor(max_workers=3D_parallel_worke=
r_count(len(tasks)),
                                              initializer=3D_init_worker,
                                              initargs=3D(_arch_std_events,=
)) as executor:
    for path, topic, events in executor.map(_parallel_read_json_events, tas=
ks):
      _json_cache[(path, topic)] =3D events

  for arch in archs:
    arch_path =3D f'{_args.starting_dir}/{arch}'
    ftw(arch_path, [], preprocess_one_file)
    ...
}

Any exception while parsing the tables (such as the new RuntimeError for a
missing MetricExpr) will still leave _args.output_file truncated to the
header and _args.output_string_file empty, contradicting the comment and
commit message.  Commit "perf jevents: Check the JSON keys that jevents.py
never reads" later in the series moves preprocess_arch_std_files() and
_parallel_read_json_events() above the open() calls, though
preprocess_one_file() (which parses metricgroups.json) and _bcs.compute()
still run after the files are truncated.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111023448.1970=
467-1-takano32@gmail.com?part=3D1
