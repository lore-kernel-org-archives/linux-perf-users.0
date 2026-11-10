Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794350965;
	b=wMnyaxH1WbUzynlGnXg1Ie9lc1q1Mf/EKILbjMeOMcFdDzW5oUTrz/a9ciGJJvXpb5j1
	 jwQPevXj7p6baDSMX14xyx4mkepoJxjYsI1gCRV1cgXTZQaAuAkXzzcufxsdpI69UsgWt
	 LjQx80Ct3InQu1lHz1LQgrvPgTH3QzZy1BY3GJAvauMaOwil9k0od7AfeGA2gvHwOl3ZS
	 k5UWN4ccHCyLcuzrMDHeP7RF2VHVULuJs5XTjnX1xW40eWnI4SYErDLEpLs29Phvt/FMl
	 XI/9ACCnD7EB13P9TBtsRV89nooqhiLzbqTr1miGAc39wj4h5OgFav1k0rtRDwXc/2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794350965;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=g57zvHuyCy46cWUvkTwpuC5RAKyzUsNOEvClmYrGExw=;
	b=ytsRun7F+JkmG4ZipDsugPVud0EVeUzSBr36gaIy5MkpsEKNYbA+kyAXNVvgy4RjF1hF
	 9yT05D6AB+BegKJpP07zXsypy1fSobkoYCVUSipLk+p5ALZUeBIHx4iRbFyjDCmk/Bmih
	 CRuQ1e6RZzBmeG392Nit/J6BWZCnjFwgj3sW+w747kdsYYQglvNu9VTqYovNDZzCZi/os
	 n5qlCqpeLA4MJhQOemTOuEASMZHWb0cZDT7BJzZ17VrsvCz43OPrvsZ4ijZXLMKAAzm8J
	 lne8wkHcOLpKhlYFVcHjo7ZEk9150UKbR/eZqWEGl4ZTKM5G2QKxL5D8DsDKuqzJTeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GX/tv/8a";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97539606A320
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GX/tv/8a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4091F0093C;
	Tue, 10 Nov 2026 22:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794350965;
	bh=g57zvHuyCy46cWUvkTwpuC5RAKyzUsNOEvClmYrGExw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=GX/tv/8aIPXbM5Y9I7GKz7g7I3oX/+7y99iTkhNEKTT133OWSuRIuxcm3afDHxlxN
	 a965kQAVJnNxWatRVQWCM0HpT2/Lz1Zwk/5CZGLFSZ+KkRTHeXqcsnfsRCu7tOKeHl
	 +HmlPkaBUQ1XQHolkM4IyVfADcjs1qoshfNle0dZkyGHAnYNt1rumT+kEKlMMbv1Jo
	 NByepaWK/l2wP+ZTYcseudA3XThAQqOxupuJtkSe/G8DrO1z0k9UODigvp3WDus4Vl
	 1tVscl3AfPu9zzRS8f37c/FceH3dcYqz11xHcwz09if7tPqYRRKVQcgJZ9E2Y2Dwxn
	 iWEqre6sFAjUQ==
Message-ID: <sashiko-outbox-207848@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] perf jevents: Check the JSON keys that jevents.py
 never reads
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261110222250.1864777-4-takano32@gmail.com>
References: <20261110222250.1864777-1-takano32@gmail.com>
 <20261110222250.1864777-4-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 22:49:24 +0000
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
- [Low] perf jevents: JsonEvent.__init__() suppresses mistyped keys
  matching a sibling hint
--

commit 618a7a7e812ef95bd110f0becbecdb78f73a1397
Author: TAKANO Mitsuhiro <takano32@gmail.com>

perf jevents: Check the JSON keys that jevents.py never reads

This commit adds a --check mode to jevents.py, a jevents-check make target,
and a shell test to report unread JSON keys that are near misses for keys
read by jevents.py, as well as metrics missing a MetricExpr.

> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 844fa82887bbf..3063282599a00 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
[ ... ]
> @@ -416,6 +484,42 @@ class JsonEvent:
>          raise argparse.ArgumentTypeError('Cannot find arch std event:', =
arch_std)
> =20
>      self.event =3D real_event(self.name, event)
> +    # Keys of the JSON object that no code above looked at, set last so =
that
> +    # the copy of an architecture standard event above does not overwrit=
e it.
> +    # A name that is a near miss for one the code reads, and whose name =
the
> +    # object does not carry with the same text, is almost certainly a
> +    # misspelling of it: the object lost the field the reader was lookin=
g for.
> +    # A name that is not a near miss is left alone, because a table is f=
ree to
> +    # carry metadata jevents.py has no use for.
> +    self.mistyped: Optional[Dict[str, Tuple[str, ...]]] =3D None
> +    if not _track:
> +      return
> +    assert isinstance(jd, _JsonObject)
> +    unread =3D jd.unread
> +    if unread:
> +      found =3D {}
> +      for key in unread:
> +        if key not in _hints:
> +          lowered =3D {name.lower(): name for name in _read_keys}
> +          # Two names can be equally close - RetirementLatencyMax and it=
s Min -
> +          # and naming one of them would be a coin toss presented as an =
answer.
> +          match =3D difflib.get_close_matches(key.lower(), sorted(lowere=
d), n=3D2, cutoff=3D0.8)
> +          _hints[key] =3D tuple(lowered[m] for m in match)
> +        hints =3D _hints[key]
> +        if not hints:
> +          continue
> +        # Nothing was lost if the object carries one of those names with=
 the
> +        # same text: that is a table with the field twice, not a misspel=
ling.
> +        # dict.__contains__ so that the look is not recorded as a read.
> +        lost =3D True
> +        for name in hints:
> +          if dict.__contains__(jd, name) and dict.get(jd, key) =3D=3D di=
ct.get(jd, name):
> +            lost =3D False
> +            break

[Severity: Low]
Does setting lost =3D False when any name in hints has the same value in jd
hide mistyped sibling keys?

Because get_close_matches() collects up to two matches (n=3D2), hints for a
typo in a closely-named sibling field (such as RetirementLatencyMax alongsi=
de
RetirementLatencyMin) contains both sibling names.  If both fields have the
same value on an event object and one key is mistyped, the other valid
sibling in hints matches in jd, setting lost =3D False so --check silently
misses the typo even though that field was dropped from the generated event.

In addition, json.load() already collapses identically-spelled duplicate JS=
ON
keys into a single dictionary entry that is removed from jd.unread when rea=
d,
so any key remaining in jd.unread is spelled differently from every key
jevents.py reads and suppresses a misspelled duplicate key whenever the val=
id
key has the same value.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110222250.1864=
777-1-takano32@gmail.com?part=3D3
