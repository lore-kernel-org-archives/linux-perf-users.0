Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E4B3A48E3
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 21:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965044; cv=none; b=Yj4nKKLqUsTf16A0pt5KYtYbuUJeoVtakT2Szh+Ke4jGpstsccFRN9ND1Qme6V8GA6VQgQwtD6NH7LokVuVgtw5FP3NBMDNED6vacMGRJwzX6AliV0K0yzUJLvkNJsnIgC0cm/Fus/UikOTwjeXEuyZ4HK2JfjbkSk/zkcgfocg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965044; c=relaxed/simple;
	bh=NDJKWW39TFmf8NcUH/DpEFk1Vj6NoOaLMYUTfO9jDJE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SQ3G15Dvu3VE3W6FxKK9Enr+J1DejYBHj7+raXOMpcj9hCajlRJBuvvXBg5plJMiK1WxkZEBcE6J5hECnRfTTQyHWkoUVTAi0Z2Qu75KgAH32sdCN2vQ6f29lfcRgdYa9JHlJp7+hjwsy98WVhlnWhnUKl+/YutaYvvuQsNeJ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NukUkqm1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NukUkqm1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A011F000E9;
	Wed,  5 Aug 2026 21:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785965036;
	bh=Y73QP4XKA2I4y7I/4LOTiXIBrnnz4UUBXaNDCcTvxjo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NukUkqm1986qTo8vwdot62X2sxZ8xRxUyrec7Xpq5HSjv4JKAlAldbk3K/sQlIwuN
	 vSgp3TLsux8Eh57JsILt1KAdmYageJNRHHTHiLwqjmyge32x1FoSq+2g1zc109aCDE
	 CnZsegemrHttfjvyaV/7ZdaeV5XaZ92H3KZiFlnoq5e46PiXCgUq++gIrv2kOCwkrQ
	 I3ffkvjN3utLFAIcsCXr9oUlpCMiZZPqL7AKo6i89JuUfcQbBnvG5Z1re/gAbqP6Xl
	 sf4x9wgTh2i7G2n4TpVXm2DQfp3ueIukCjgGHxR7HEpE0M7/Vmc9/516BaFz1nmSpi
	 5PteCIepDFaBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/4] perf sched: Handle missing trace samples in pipe
 mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260805210751.287746-3-atomlin@atomlin.com>
References: <20260805210751.287746-1-atomlin@atomlin.com>
 <20260805210751.287746-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 21:23:55 +0000
Message-Id: <20260805212356.03A011F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing explicit inclusion of `<string.h>` for `strcmp`.
--

--- Patch [2]: [PATCH v8 2/4] perf sched: Handle missing trace samples in p=
ipe mode ---
commit 4cf6347760b0dc1a50946397641b493e66cea7c0
Author: Aaron Tomlin <atomlin@atomlin.com>

perf sched: Handle missing trace samples in pipe mode

This commit updates perf sched to properly handle pipe mode streams by
registering missing attributes and dynamically assigning tracepoint handlers
when the evsel handler is uninitialized.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 94a323da0799a..d6b4412045e22 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c

[ ... ]

> @@ -1946,7 +1956,23 @@ static int perf_sched__process_tracepoint_sample(c=
onst struct perf_tool *tool __
>  	struct evsel *evsel =3D sample->evsel;
>  	int err =3D 0;
> =20
> -	if (evsel->handler !=3D NULL) {
> +	if (evsel->handler =3D=3D NULL) {
> +		evsel->handler =3D process_sched_ignore;
> +		for (size_t i =3D 0; i < ARRAY_SIZE(latency_handlers); i++) {
> +			if (!evsel__name_is(evsel, latency_handlers[i].name))
> +				continue;
> +
> +			if (!strcmp(latency_handlers[i].name, "sched:sched_wakeup") &&

[Severity: Low]
This isn't a bug, but are we missing an explicit include for <string.h>?

Even if the file previously omitted it, the perf subsystem guidelines
require files using POSIX libc functions like strcmp() to directly include
their respective headers. Relying on implicit inclusions can lead to
compilation failures under musl libc.

> +			    sample->evsel->evlist &&
> +			    evlist__find_tracepoint_by_name(sample->evsel->evlist, "sched:sch=
ed_waking"))
> +				break;
> +
> +			evsel->handler =3D latency_handlers[i].handler;
> +			break;
> +		}
> +	}
> +
> +	if (evsel->handler !=3D process_sched_ignore) {
>  		tracepoint_handler f =3D evsel->handler;
>  		err =3D f(tool, sample, machine);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805210751.2877=
46-1-atomlin@atomlin.com?part=3D2
