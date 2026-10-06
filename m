Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC1D8834
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 23:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791329710; cv=none; b=clDX5VA8f6zgG9Aj5Tt95Sf4UfGEaQi1wKoPVwbmhs8ApdrggjHbdggZmfPhRvR1qZkhVgDSSn/yr+B//VzpxxEl5e+g/ZpD3ocLYs+RzMhehS9xcBYlW/FDUUairwef1Bzs/A4aZzMhdJPiW1KrHp9UmQnHOxxHQ1rIrlyq9s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791329710; c=relaxed/simple;
	bh=72T51Pnyfg7HFs5fqYkFvbCTZRMLpVoLJ+h/KffYvaA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=OlxbsmmLF6m+n0kZtYgkZxZcns1T9wLkik/s5g87w6iQrsI3yUoAfXmCkVuPq/ZEIw8T6DVU+1Q9Hvy81o+9F0/pScphEP3pV7nuYHVCOZ8ka8t8ljncUkRgjyJYsmRPHfDydFcH2YW2pPH8KzpY3EO2kwXrT69kozWl9xm13zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqsOoa/8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqsOoa/8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE551F0089B;
	Tue,  6 Oct 2026 23:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791329709;
	bh=vZ3Bc455tcf63IIctkEMRiXS4OFmdZHcs8jAcC9McPg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VqsOoa/8XCA8zJzyXRg6TMw42L36ModBFbrsyGji0l++CMlxX6ZAsQvF5/JimD/nn
	 xC/Lzg07+OOTFR1UCaL5I9JGyhfUuHmEjCzII57iMqQEcen9B2jJvnNCEXJylU6B96
	 BGuiTNHS+2/RAJI0JQ5jmOD+HE7reN0V4cPVYI+QT+jM2TU2A/M2pR1JmDf9g8UJkF
	 mBiNK/om0Dxe8nbDItg8rNtKcxLHq+1/BjbQX9MXIqO29OiaIpITXYY3TgAObZedXP
	 rAa4S7R6tNxq5uwKf++KxTm9kE2bmmch5Q56rjAqLjl1c0MKQt0MqIhH7ZEo2Bi6X3
	 zROdwAqY2eo0A==
Message-ID: <sashiko-outbox-162512@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v2 4/4] perf ftrace: Support omitting
 execution duration in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006232756.65620-5-atomlin@atomlin.com>
References: <20261006232756.65620-1-atomlin@atomlin.com>
 <20261006232756.65620-5-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 23:35:08 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf ftrace: --graph-opts duration silently clobbers noduration
--

commit e23672676ea60d48741ccc720b34c8778668c668
Author: Aaron Tomlin <atomlin@atomlin.com>

    perf ftrace: Support omitting execution duration in function graph trac=
er
   =20
    The Linux kernel's function graph tracer displays the execution duration
    of completed functions by default via the funcgraph-duration trace
    option. Introduce support for omitting function duration by exposing the
    noduration sub-option under --graph-opts (and conversely duration=3D[0|=
1]).

> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index e11418e619378..88df6b09d9b0d 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
[ ... ]
> @@ -1754,6 +1772,8 @@ static int parse_graph_tracer_opts(const struct opt=
ion *opt,
>  		{ .name =3D "retaddr",		.value_ptr =3D &ftrace->graph_retaddr },
>  		{ .name =3D "nosleep-time",	.value_ptr =3D &ftrace->graph_nosleep_time=
 },
>  		{ .name =3D "noirqs",		.value_ptr =3D &ftrace->graph_noirqs },
> +		{ .name =3D "noduration",		.value_ptr =3D &ftrace->graph_noduration },
> +		{ .name =3D "duration",		.value_ptr =3D &duration },
>  		{ .name =3D "verbose",		.value_ptr =3D &ftrace->graph_verbose },
>  		{ .name =3D "thresh",		.value_ptr =3D &ftrace->graph_thresh },
>  		{ .name =3D "depth",		.value_ptr =3D &ftrace->graph_depth },
> @@ -1769,6 +1789,9 @@ static int parse_graph_tracer_opts(const struct opt=
ion *opt,
>  	if (ret)
>  		return ret;
> =20
> +	if (duration !=3D -1)
> +		ftrace->graph_noduration =3D !duration;
> +

[Severity: Medium]
Does this logic unconditionally overwrite the noduration parameter?

If a user executes perf ftrace with --graph-opts duration=3D1,noduration, t=
he
token parsing loop in perf_parse_sublevel_options() correctly processes them
sequentially. It sets duration to 1 and ftrace->graph_noduration to 1.

However, since duration !=3D -1 is evaluated after the loop, it overwrites
ftrace->graph_noduration with !1 (which is 0). This causes the duration
parameter to always clobber the noduration parameter, regardless of their
order in the comma-separated list.

Would it be possible to parse both directives strictly in the order they are
specified without unconditionally overriding one after the loop?

>  	if (filter_retaddr !=3D -1) {
>  		ftrace->filter_retaddr =3D (filter_retaddr !=3D 0);
>  		ftrace->filter_retaddr_set =3D true;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006232756.6562=
0-1-atomlin@atomlin.com?part=3D4
