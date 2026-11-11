Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406302;
	b=dxcbEh3XjNT2mx7cN8h7udacb+wP15OiPQIvKvJbxibGP1RNB0VbxwHg3h2eGHY04hu5
	 fmOU6tAiVlRlUNWak+mBYCo1eVKvGOp0xOpONsW7SnPBuFHZNsUwJq0EBxirExmQug0oz
	 lElTydotKrJK20vm/4ENlrHlS0Q6wrb6SEWvzD6qcsbaeBg0V72wiBK9qVEWfF8itbN5H
	 +KD2aiAAxCmzvExAtY4DKTs3AC2198W9HpAER5FSit/DhIrlP5OBd6O9O0NhDN0B3FkR3
	 ZAXQjY6s5+Amyitb809dpcl5TZB1RNw9C2rJvkIeUXAasDte5rmvyQyDZYajWoGJu8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406302;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=w1QGiNsrzKl2UtmezGZeieI1TMJKOF58jCZ538onXaM=;
	b=W5IKpOayLph/XhP3e743V6aaoauLvJsRKVz/HY2y/zefL1pSHeUzGQ9mDHiGiVy9BAhp
	 CCnfEYpOcPbqOzy/ca9r1+v53Jp/BdAPB0Yu02CFG0Bzjcg1cyLyZfopigNWKEMff7f1+
	 z8zVjdM2X2ZWVNEtOWpkDHQOBRTtInb/6Bkm7HobQzbD5pmX/2hlfwmtdTjxX63omHhCc
	 9ecjWnyaLcIU4E453wamL/GxWWZv2Wu5ohVWbWq90JLtx93jQvQmC8a7J9ia83e4m87Ls
	 rmaiodsKrKB1W8+JHUHdxdFaxlNWAu5t8z6dSKicZqTA6KYP6DoZLtugSfIPNrW2CiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E5ugSmsH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D462A606A324
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E5ugSmsH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454431F00A05;
	Wed, 11 Nov 2026 14:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794406302;
	bh=w1QGiNsrzKl2UtmezGZeieI1TMJKOF58jCZ538onXaM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=E5ugSmsHvrcOP1Rs5JEnmgsW0PhY6NYWIWRVMbIs4UhCZMu4AOrBrWXH+AOgIGgVL
	 Dv0Av1Q7MVflVZHxs9tMp4uL8hm69rhM4WRnozL/QXYPKJnAivXD292ribObo0YWs9
	 0bomakqMJvgNg99e5wAtiq846pNZDKuOIHReUQeZQINjZDQolJdjcUsowTRlLomNaC
	 GW4VrkjVbDy9WiFOiu/jZjMrr8boViN+z/ts+XzyqqMI9pHjTfjoP3VBRZ+5jiDZ6h
	 ie2YkGdUH+MHLr8/pfGoJfZbdZGO/jWQZ6QMsW+Va/n2CLTqxYJiHv6XVoMJmEn4sy
	 QO8gFOAkk0Fnw==
Message-ID: <sashiko-outbox-209118@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] perf jevents: Name the metric when a MetricExpr
 is missing
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261111132622.2349165-2-takano32@gmail.com>
References: <20261111041045.2031464-1-takano32@gmail.com>
 <20261111132622.2349165-1-takano32@gmail.com>
 <20261111132622.2349165-2-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 14:11:41 +0000
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
- [Low] perf jevents: missing file path in _read_json_events_impl()
  MetricExpr error
--

commit e2d62b223b86b6803d9d5c49c56d277f5acb0d3e
Author: TAKANO Mitsuhiro <takano32@gmail.com>

perf jevents: Name the metric when a MetricExpr is missing

This commit raises a RuntimeError naming the metric when a JSON event defin=
es
MetricName without MetricExpr, improves error reporting on parse failures, =
and
defers opening the output files until all tables have been parsed.

> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 080e04b51b8c5..61f778dcc1e56 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -460,11 +460,17 @@ def _read_json_events_impl(path: str, topic: str) -=
> Sequence[JsonEvent]:
>      with open(path, encoding=3D'utf-8') as f:
>        events =3D json.load(f, object_hook=3DJsonEvent)
>    except BaseException:
> -    print(f"Exception processing {path}")
> +    print(f'jevents: error: Exception processing {path}', file=3Dsys.std=
err)
>      raise
>    metrics: list[Tuple[str, str, metric.Expression]] =3D []
>    for event in events:
>      event.topic =3D topic
> +    if event.metric_name and event.metric_expr is None:
> +      # A MetricName without a MetricExpr leaves nothing to put in the
> +      # generated tables, whether or not the name has a dash, so the bui=
ld
> +      # must not go on.  Name the metric instead of letting the table pr=
inter
> +      # assert on the None.
> +      raise RuntimeError(f'Metric {event.metric_name!r} has no MetricExp=
r')

[Severity: Low]
Does raising RuntimeError outside the try/except block without path in the
message lose the offending file name?

Model and vendor JSON tables are parsed in main() via
executor.map(_parallel_read_json_events, tasks) outside ftw(), so when a
metric is missing MetricExpr, the exception escapes the worker pool without
reporting which JSON file failed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111132622.2349=
165-1-takano32@gmail.com?part=3D1
