Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367904;
	b=SsFkXIFi+4UVSjWCL5Yi1g0RN3Cfx9mFEr4SRnJdyfLxqppYZMiUiyEiPWwB3lBa6pux
	 rBIAThIj77nL/a/IhpzJxoIzqdK7aQk8gaG3gLdJHfA9pkpGNUUOOFYaBtD4xc3ewowHw
	 Agfi2DuOhEwHxHqqN2dKV8XcB6kGHhyOg0luaJbZTNa14aPA4kgAYNvy+Hbz251edg6jQ
	 cBtFBLHiZSCw7maJLri1qqs6E3rKbrvNS54N8svVe8rLZ0xMPb8XCb8IxUxkPYnAj5Gi3
	 j7I1CvCPN4oIGO/LQAuk6jd7yBz4ZgmK4WMkwFLwfQthPsa/74fUaIl3IXg40/8Zy+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367904;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dL5VlAWp2+b6jRdubTngxM2mOKElksBdch1dEzRNIKI=;
	b=LolOWH3egUrfv2TmEf7/t0Qy2Us2x9gxhFYMWk5goKiv7ZoHaB96Ut913l8GWm5ld6E1
	 TGltwvYedUGOHB4eZrphRfAFH1/FpvVEdwyW6Jvep7PKVcZOXQk6/a+fITsPf8pGc/xsD
	 XRGV3A4QR4q+uZxaAsI/CkUfmPFF3R+3rFOQX4gQ9anAesePqX0VRSpMk1LGt433yMHcd
	 aeEyIvWA+vsyIKHw75hATcqxz5/8FlTu2sAgLVnjt75WR0tDSZrdWGAUQe1sdAEn5Cht4
	 ej8ILoi8MM97diONVqEAYZnn3visGhH3grlv+NzmWa7RRj+R1PApx1QaD5l4L1aPp5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X0cK6KgW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FAD606A337
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 03:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X0cK6KgW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286151F0089F;
	Wed, 11 Nov 2026 03:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794367904;
	bh=dL5VlAWp2+b6jRdubTngxM2mOKElksBdch1dEzRNIKI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=X0cK6KgWMOm3jXlnOpSkEOq40dHIaYYk55YSRCrBu+mSmpZbAK4zGcx8rz6TcR4pI
	 uHJUqqebcpAFdFsBkfeb/KMsMJSxM5FXX77nCdeDOZQRpoaFlLKIBLbSKLrX5XZyfQ
	 pKnnm//0Ym7yeNJPaRiW8tipkWcJCa8bhQfJjqPGNuffeKuoH96+GAAxeq12/DZCis
	 hFMKilSMs+2GforDha1IENCg2kK6kV55q5aEl9KjEVnDrKUmV9yTrG0Km1g5/Yg5Mk
	 J1MMhHNhYa49eLivcK2jo4cVpZY0wCtYLdTUdJzRfPwCmEq5PJjg4q2oQHy8CKnqVy
	 qOGLQMLydzA0w==
Message-ID: <sashiko-outbox-208198@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] perf jevents: Check the JSON keys that
 jevents.py never reads
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261111023448.1970467-4-takano32@gmail.com>
References: <20261110222250.1864777-1-takano32@gmail.com>
 <20261111023448.1970467-1-takano32@gmail.com>
 <20261111023448.1970467-4-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 03:31:43 +0000
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
- [Medium] perf jevents: module-scope variable e in __main__ breaks
  pylint W0621
- [Low] perf jevents: empty tasks check in main() skips arch std errors
  and arch=3Dnone
--

commit 75a86d8bd9af5645c902739baea7b69e539c8eea
Author: TAKANO Mitsuhiro <takano32@gmail.com>

perf jevents: Check the JSON keys that jevents.py never reads

This commit adds a --check mode to jevents.py, along with a make target and
shell test, to detect unread JSON keys that look like misspellings of known
field names and metrics missing a MetricExpr.

> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 844fa82887bbf..d31f8e2fd6d3f 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py

[ ... ]

> @@ -1497,14 +1696,104 @@ model must include the implementor such as "arm/=
cortex-a34".''',
> +  if not archs and _args.arch !=3D 'none':
> +    raise IOError(f'Missing architecture directory \'{_args.arch}\'')
> +
> +  archs.sort()
> +  import concurrent.futures
> +  tasks =3D []
> +  def collect_json(parents: Sequence[str], item: os.DirEntry) -> None:
> +    if len(parents) =3D=3D 0:
> +      return
> +    if item.is_file() and item.name.endswith('.json') and not item.name.=
endswith('metricgroups.json'):
> +      tasks.append((item.path, get_topic(item.name)))
> +
> +  failed: List[Tuple[str, Exception]] =3D []
> +  try:
> +    for arch in archs:
> +      arch_path =3D f'{_args.starting_dir}/{arch}'
> +      preprocess_arch_std_files(arch_path, failed if _args.check else No=
ne)
> +      ftw(arch_path, [], collect_json)
> +
> +    if not tasks:
> +      print(f'jevents: error: no event table under \'{_args.starting_dir=
}\' '
> +            f'matched arch \'{_args.arch}\'', file=3Dsys.stderr)
> +      sys.exit(2 if _args.check else 1)

[Severity: Low]
Does exiting when tasks is empty skip reporting errors and mistyped keys
collected by preprocess_arch_std_files() in --check mode?

collect_json() only adds JSON files in subdirectories (len(parents) > 0) to
tasks, whereas preprocess_arch_std_files() reads top-level JSON files into
_json_cache and records parse errors in failed.  If an architecture directo=
ry
contains only top-level standard event files, main() exits here before
printing failed or running _report_mistyped_keys() and
_report_metrics_without_expr().  Also, in build mode with _args.arch =3D=3D
'none' on a directory without common or test subdirectories, this exits with
status 1 instead of generating the empty C tables that the _args.arch !=3D
'none' guard above allows.

[ ... ]

> @@ -1607,4 +1867,16 @@ struct pmu_table_entry {
>      _args.output_string_file.close()
> =20
>  if __name__ =3D=3D '__main__':
> -  main()
> +  try:
> +    main()
> +  except SystemExit:
> +    raise
> +  except KeyboardInterrupt:
> +    raise
> +  except BaseException as e:
> +    # A build should see the traceback; a check gives its caller a statu=
s,
> +    # and 2 is the one that says the tool could not do its job.
> +    if _args is not None and getattr(_args, 'check', False):
> +      print(f'jevents: error: {e}', file=3Dsys.stderr)
> +      sys.exit(2)
> +    raise

[Severity: Medium]
Does binding e in the module-level __main__ block break the default perf
build when pylint is enabled?

Because if __name__ =3D=3D '__main__': runs at module scope, binding e here
causes pylint to report W0621 (redefined-outer-name) on every function and
lambda in jevents.py that uses a local variable or parameter named e, such
as add_events_table_entries(), failing the pylint-pmu-events build target in
tools/perf/Makefile.perf.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111023448.1970=
467-1-takano32@gmail.com?part=3D3
