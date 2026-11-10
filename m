Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339921;
	b=AkB4T6PDKIakRHj77L2pHWeQ5zgCGfNiCA6xBsOP/fX5SOLj47A36bgFRoPawGIz5Fu6
	 +393M2aKfGa6LpE7UBb/jZ7VWVGEw3/mhZRq1e6PhkeP4GCGtgG8vA0idyjZ0HFpiNxX0
	 LE2hWBpw7zf339YVm2b/ws0sTkQRSkCegERkUhGDWzSUpMKQVsBz/Dx8BgUNiOzf2KvPc
	 nYKg43HWkMAOjXZqXs1jUQEYFeaSDQWVwdV+pWHLj6B1kOXlHhZCEQ7pn9M3xX2hg40Nj
	 /+rd6WpDQMXSusUXG69gbIigh7RfkEk08CJ5PrcTmCXUyBxyObv8Zsz7JDeNLpoV8Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339921;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3GBKYc2zOW3dj8oa1Hc52JQRwp0PgEZDFrKNRJOSpBI=;
	b=S+BThB0nJrMieZgZrDMXp3fG14aspt0nQb323ejGlUXo6Ppsf4I2Qr7wXlxIwpGpcihS
	 pqVfsRGbB8oMECZB6Boha+Apxj47NDOsdmmhjjTzwXacd2c9+XVOM6K00jz0N0wIrXgAW
	 070eZw/AQPsrJBkwJGb4Av1ia3/lGhZ4TwUdKIaE3U8pkdiudhYHSKaK5WuBUwBZtK/Xf
	 /OeYaM7HKbU946LVhM/JiKAjcXvC9YhPcWDV/hclY/MiLUDiGhTLzRYlynqOkV0ZxeeBK
	 pmNOZvSzYriNSw3itrJykCd+iGEf/MsJuAExpyyzsn4+N781w6NnXf9zAi8o177nB2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RDH+klph;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7346B606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 19:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RDH+klph
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BCE1F0089F;
	Tue, 10 Nov 2026 19:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794339921;
	bh=3GBKYc2zOW3dj8oa1Hc52JQRwp0PgEZDFrKNRJOSpBI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=RDH+klph/83YU5da57iBwoiHNHdKC85QSXbgYordppOffltMudL+uALM9/9j7yTgg
	 BdVpMX4gFIl65TSwFj1OHiYffj6NlL/eI1sMWkE+2j+TJKOThKbn+FMhAbE7NquD9V
	 DQGRZlxkA0ajJRB5d06CW7K62LYq+8lLfCN3f9MVa9bxIyM/TrmYqImSXqXlpCzt04
	 i9qDKGb2dTSgc3fcQWfcoMzHUXS0D0JVJHxFbc6xYhsUEgoLIh8LX048/2Yf3Uv3wt
	 cMMHNsrLI2chaqGmjMu5y4KyRCdFVqrbsxR/GIYijSsGTGefBOqVYi2yDCx37v9P6Q
	 yw3ByixewIdWQ==
Message-ID: <sashiko-outbox-207678@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf jevents: Check the JSON keys that jevents.py never
 reads
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261110193239.1741014-1-takano32@gmail.com>
References: <20261110193239.1741014-1-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 19:45:20 +0000
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
- [Low] perf jevents: crash in _read_json_events_impl() when MetricExpr
  is mistyped
- [Low] perf jevents: preprocess_arch_std_files() drops parse error in
  --check mode
--

commit b85ceb11b01de607fd5251f8da36bf8900130730
Author: TAKANO Mitsuhiro <takano32@gmail.com>

perf jevents: Check the JSON keys that jevents.py never reads

This commit adds a --check mode to jevents.py (and a jevents-check make
target) that tracks unread JSON keys in JsonEvent and reports keys that
closely match field names read by jevents.py.

> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 080e04b51b8c5..56859e983a4b0 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py

[ ... ]

> @@ -493,7 +653,10 @@ def preprocess_arch_std_files(archpath: str) -> None:
>          if event.metric_name:
>            _arch_std_events[event.metric_name.lower()] =3D event
>      except Exception as e:
> -        raise RuntimeError(f'Failure processing \'{item.name}\' in \'{ar=
chpath}\'') from e
> +        failure =3D RuntimeError(f'Failure processing \'{item.name}\' in=
 \'{archpath}\'')
> +        if failures is None:
> +          raise failure from e
> +        failures.append((item.path, failure))

[Severity: Low]
Does appending failure instead of e here drop the underlying parse error wh=
en
--check reports failures from preprocess_arch_std_files()?

In main(), each entry in failed is printed with str(error), which does not
follow __cause__ and only prints "Failure processing '<name>' in '<archpath=
>'"
alongside the relative path, hiding why the JSON file failed to load.

[ ... ]

> @@ -1490,12 +1660,111 @@ such as "arm/cortex-a34".''',

[ ... ]

> +    with concurrent.futures.ProcessPoolExecutor(max_workers=3D_parallel_=
worker_count(len(tasks)),
> +                                                initializer=3D_init_work=
er,
> +                                                initargs=3D(_arch_std_ev=
ents, _args.check)) as executor:
> +      for path, topic, events in executor.map(_parallel_read_json_events=
, tasks):
> +        if isinstance(events, Exception):
> +          if not _args.check:
> +            raise RuntimeError(f'Failure processing \'{path}\'') from ev=
ents
> +          failed.append((path, events))
> +        else:
> +          _json_cache[(path, topic)] =3D events

[Severity: Low]
What happens in --check mode when a metric object has a valid MetricName
(without '-') but misspells MetricExpr (for example as MetricExp)?

JsonEvent.__init__() leaves self.metric_expr as None and records the mistyp=
ed
key in self.mistyped, but _read_json_events_impl() then passes that None
expression into metric.RewriteMetricsInTermsOfOthers():

tools/perf/pmu-events/jevents.py:_read_json_events_impl() {
    ...
  for event in events:
    event.topic =3D topic
    if event.metric_name and '-' not in event.metric_name:
      metrics.append((event.pmu, event.metric_name, event.metric_expr))
  updates =3D metric.RewriteMetricsInTermsOfOthers(metrics)
    ...
}

RewriteMetricsInTermsOfOthers() raises an AttributeError on None before
_read_json_events_impl() can return events, so main() records the file in
failed instead of _json_cache and --check reports an AttributeError (exit
status 2) instead of reporting the misspelled MetricExpr key.  Checking that
event.metric_expr is not None before appending to metrics would let --check
report the misspelling.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110193239.1741=
014-1-takano32@gmail.com?part=3D1
