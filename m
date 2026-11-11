Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794369550;
	b=c0eTcaYMB96DWaBHvU4ISBlfgefQ5G1Xa9hJ70Bku+2tJYDykjYHQkPV2Faz3xzFL9rE
	 Olc752PbQpopCxosUFNhwX4rK4sRR9mEQtm845dB68vBbhJqSY6YkqH1xj1Cq5TPOVUIk
	 izp+M9o9qUEyBhqorfWl77VGxUvzo+DBFPKolIWJyWp/gK+FKrFdPA4R2EEYWPqI2WLld
	 cIqGOtZrQDT5Ok6ryjZwxW1HSb++PkHregBRlt2LMGRakoMTLHwVwiZDQRqSmIgOe32zd
	 YJTp4tp4tYD+TEz06d9EX3j88vRQRN50IIEmm4qG21JslefkeVNjs8mlklAtNpDvqCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794369550;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ygiQmbpfdlQahaaycC0sMisue8HBwGToWSUR05Opm+E=;
	b=PKS6DKNkVz9MufGcAbOIh59BXnfSs9p47xhR1pg96Mn3vz+4AGrog9Bfq9eOJlpVbyow
	 MFjmalHVJULt/Chx9f6MYYBMLA8qNmKjT+kVKI6dlQrZdfYOcyQ6tp+KWgR5CZB4Px29J
	 lN9ryk/loQ9Vvlt5rX8IzR+/WoopHsHkRAjUtSH8bRMfRAMry2o0uu+IdxkJr+I2ZDFJz
	 qD581afL4V2S+iSXQPtF2p06EB4UvLkynmycZFllbiArqAcMm/DDb4Twbrw3Tt2BwKNzS
	 brTepcckXBkc9+Vtnm4ysrHQhezIlNQZNSELAmi9zvFacCxW37NlHknKk4vzcBclydA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nyoLpQ/d";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D353D606A320
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 03:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nyoLpQ/d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399D51F00A00;
	Wed, 11 Nov 2026 03:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794369550;
	bh=ygiQmbpfdlQahaaycC0sMisue8HBwGToWSUR05Opm+E=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=nyoLpQ/dnr3kHLlMibr6ob6jC+92nRAtUlEYZBZz8B/GH9ZlcaT5EQf3PgY8Rz73C
	 NtJL0K6j9fckCSr//PE9o++IvWXpd5IGWWfzwxmRLITTxPqiSqDIWf2DFsEnjmzXUX
	 jAdPnYtvzJUMHPD7Q6pE5a4gz39PDTZfvrNbJR2LJ0CPBJM1Xr8zZDT40YvUFrTOyd
	 kQszdfMWf4nEjWuI8ayWbZpe/FsazetVa+mSAo6/53WlRbJDzvDo+E7Fv64PkhpDcu
	 XUusiizluXeTmx+AVuoQTLBDxCHetH2UtLcHvFgh58eNqLjkvFwCqvD6GO0UNbTBAH
	 DnmkEVvTMc4og==
Message-ID: <sashiko-outbox-208247@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] perf jevents: Check the JSON keys that
 jevents.py never reads
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261111034333.2019831-4-takano32@gmail.com>
References: <20261111023448.1970467-1-takano32@gmail.com>
 <20261111034333.2019831-1-takano32@gmail.com>
 <20261111034333.2019831-4-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 03:59:09 +0000
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

commit aee0fc441ea63dcedc64e1197848c350782988c1
Author: TAKANO Mitsuhiro <takano32@gmail.com>

perf jevents: Check the JSON keys that jevents.py never reads

This commit adds a --check mode to jevents.py (along with a jevents-check
make target and shell test) to report unread JSON keys that closely match
known key names and metrics missing a MetricExpr.

> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index f4dca47eb49b2..3381ade201fd9 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py

[ ... ]

> @@ -1510,7 +1729,12 @@ model must include the implementor such as "arm/co=
rtex-a34".''',
>      if item.name =3D=3D _args.arch or _args.arch =3D=3D 'all' or item.na=
me =3D=3D 'test' or item.name =3D=3D 'common':
>        archs.append(item.name)
> =20
> -  if len(archs) < 2 and _args.arch !=3D 'none':
> +  if _args.check and _args.arch not in ('all', 'none') and _args.arch no=
t in [
> +      item.name for item in os.scandir(_args.starting_dir) if item.is_di=
r()]:
> +    print(f'jevents: error: no architecture directory named \'{_args.arc=
h}\' '
> +          f'under \'{_args.starting_dir}\'', file=3Dsys.stderr)
> +    sys.exit(2)
> +  if not archs and _args.arch !=3D 'none':
>      raise IOError(f'Missing architecture directory \'{_args.arch}\'')
> =20
>    archs.sort()
> @@ -1522,16 +1746,51 @@ model must include the implementor such as "arm/c=
ortex-a34".''',
>      if item.is_file() and item.name.endswith('.json') and not item.name.=
endswith('metricgroups.json'):
>        tasks.append((item.path, get_topic(item.name)))
> =20
> -  for arch in archs:
> -    arch_path =3D f'{_args.starting_dir}/{arch}'
> -    preprocess_arch_std_files(arch_path)
> -    ftw(arch_path, [], collect_json)
> -
> -  with concurrent.futures.ProcessPoolExecutor(max_workers=3D_parallel_wo=
rker_count(len(tasks)),
> -                                              initializer=3D_init_worker,
> -                                              initargs=3D(_arch_std_even=
ts,)) as executor:
> -    for path, topic, events in executor.map(_parallel_read_json_events, =
tasks):
> -      _json_cache[(path, topic)] =3D events
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
Does exiting early when tasks is empty discard errors and mistyped keys
already collected from architecture standard files, and break arch=3D'none'
builds?

collect_json() only queues JSON files in subdirectories (len(parents) > 0).
If an architecture directory only contains top-level arch std JSON files,
exiting here in --check mode skips reporting any parse failures in failed
or mistyped keys in _json_cache from preprocess_arch_std_files().  In build
mode, when _args.arch =3D=3D 'none' is used on a directory without common or
test subdirectories, this exits with status 1 instead of generating empty C
tables as the _args.arch !=3D 'none' check above allows.

[ ... ]

> @@ -1608,4 +1869,16 @@ struct pmu_table_entry {
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
Does binding e in the top-level __main__ block break the perf build when
pylint is enabled?

Because if __name__ =3D=3D '__main__': runs at module scope, binding e here
causes pylint to report W0621 (redefined-outer-name) on every function and
lambda in jevents.py that uses a local variable or argument named e, such as
add_events_table_entries():

tools/perf/pmu-events/jevents.py:add_events_table_entries() {
    ...
  for e in read_json_events(item.path, topic):
    ...
}

The default perf build runs pylint on jevents.py with E and W enabled
whenever pylint >=3D 2.16.0 is installed, so these W0621 warnings fail the
pylint-pmu-events build target.  Moving this try/except inside main() or
using a distinct name like _err avoids shadowing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111034333.2019=
831-1-takano32@gmail.com?part=3D3
