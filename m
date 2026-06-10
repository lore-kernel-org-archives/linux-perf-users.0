Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C8F390221
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 20:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121955; cv=none; b=hNkQcX+ZjFNYH5KxJpsggVQy0UGkMk6v2Wvli8/PgmeUKTRETMnHiRb0yzIk0t78RaG4f7WJ5lY79kzAXODSircvoSgR6+ARSSilLPh8mqetQU0AQRNEjiok1BDlPoT7Q+T1xDH7XjQIv3ymhnE2Thx2wLmTZrFC4MKeUjsFo9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121955; c=relaxed/simple;
	bh=0QW7JDuGPytYlNNEq74JDdLO0im58eRRy6Le4Pke4xU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uG0UOsPphs3mKx0JMdy+9fm8mIcZYJevMVBb78nstlUCrULNguuVVJ8Cad5ukng+xGvciWupodNomtL8RaroEAilQN1RuO23P16kWPytfvG9JixM/h4WrI/s2N8kJMRyvM+sXYC9xtrxwBry5PeTj1E/OWK9ypjVEz3p8PQKTug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrHVuJPR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrHVuJPR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9E81F00893;
	Wed, 10 Jun 2026 20:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121948;
	bh=X+UjtobkzPj7C81zmx6mmo7BWVc0p/6vEYvyQmt6alQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WrHVuJPRsb9juuooz+JlHErWk96Q1a7KLdbCpFuPN5H28fb/SqWWh6pfio6fvQ1ip
	 bzBm3i2bsIXzHQqXEJL/JgZhWc9gB/dTeVNDFyhisbEYchBqTtQL7ejwIpwnVPgB38
	 SQc3Vc9wmiMGhhwKfjXs2o6VxBGWoZvbh3S/4HspyFgq9cVa2EGbJeqYExzOdmH4nQ
	 cc8OhNKEfb6vwXp2c/AC7wcYdbeMG/HdmRCWR7bVDZ3O89xZVS+6jMsyt2RMVd+s+r
	 yesvQkfYnD8aB49M/RjfB7+QWRBs7zMQvILmIWG5VnSGWVdKKMsphcnCWPhv4W4J5e
	 hMTVPwMSbHfKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/23] perf pmu: Use scnprintf() in format_alias()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260610195157.2091137-16-acme@kernel.org>
References: <20260610195157.2091137-16-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 20:05:47 +0000
Message-Id: <20260610200547.EA9E81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing stack buffer overflow in `perf_pmu__for_each_event` d=
ue to unchecked `snprintf` return values.
--

commit 7b55c41b9ee2781220a71c8d96e4e7a17ebb8cf5
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf pmu: Use scnprintf() in format_alias()

format_alias() accumulates strings into a caller-provided buffer using
snprintf(). On truncation, snprintf() returns the would-have-written
count, which can exceed the buffer size. Switch to scnprintf() which
returns the actual number of bytes written, keeping used within bounds.

> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 4ddccc863727d..2fce38140eb8a 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -2155,11 +2155,11 @@ static char *format_alias(char *buf, int len, con=
st struct perf_pmu *pmu,
[ ... ]
> -	used =3D snprintf(buf, len, "%.*s/%s", (int)pmu_name_len, pmu->name, al=
ias->name);
> +	used =3D scnprintf(buf, len, "%.*s/%s", (int)pmu_name_len, pmu->name, a=
lias->name);
> =20
>  	list_for_each_entry(term, &terms.terms, list) {
>  		if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_STR)
> -			used +=3D snprintf(buf + used, sub_non_neg(len, used),
> +			used +=3D scnprintf(buf + used, sub_non_neg(len, used),
>  					",%s=3D%s", term->config,
>  					term->val.str);
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a similar issue in
perf_pmu__for_each_event() in the same file:

tools/perf/util/pmu.c:perf_pmu__for_each_event()
		if (strlen(event->unit) || event->scale !=3D 1.0) {
			info.scale_unit =3D buf + buf_used;
			buf_used +=3D snprintf(buf + buf_used, sizeof(buf) - buf_used,
					"%G%s", event->scale, event->unit) + 1;
		}
		info.desc =3D event->desc;
		info.long_desc =3D event->long_desc;
		info.encoding_desc =3D buf + buf_used;
		buf_used +=3D snprintf(buf + buf_used, sizeof(buf) - buf_used,
				"%.*s/%s/", (int)pmu_name_len, info.pmu_name, event->terms) + 1;

Does this code also need to use scnprintf() instead of snprintf() for the
event unit, scale, and terms?

Since buf_used accumulates the return values of snprintf(), can it exceed
sizeof(buf) if the event properties are sufficiently long?

If that happens, the unsigned subtraction sizeof(buf) - buf_used would unde=
rflow
to a very large value.=20

Could this disable bounds checking on subsequent calls and allow snprintf()=
 to
write past the end of the buf[] stack buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610195157.2091=
137-1-acme@kernel.org?part=3D15
