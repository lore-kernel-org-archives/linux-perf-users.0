Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C46E547041
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 00:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110499; cv=none; b=pSwb69OIL+w1nQOSeq0V9kKM/lPRaTkpBW2zodQisCX4pAmfrAW6a6MfuPsMqOY/kbrW3QCtmSxSyNNi7Reajq7gNo1rAlXxPpVm5KX3I8IXOKkPbO66/baKXHfN56QAqH24pTNqSC7ffiE8uGoYgzybNVRyDNzaAglDgn4IMh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110499; c=relaxed/simple;
	bh=D7uoL+GtnvZZIIDqhAwvJtjQKUVmoBwKmRkmE1BdpJI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gDRDVo5kkeaKC88uEDwkaPk1mwPKJ/zTJIQphaHcj1p4tNDOTrYSOaAgfcBhsB81QhWjdzv9u7+4Tf8SxFoAavwaRkFe7UPRdIJrr2xFhbIQx6fpuhd2AF1nXHf6gAUN5+ahI1ubKpN1pzU3e7FOYMYtZtUnBE3sOZIEwGoDkzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1P8Dzw+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1P8Dzw+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8461F000C4;
	Fri, 16 Oct 2026 00:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792110498;
	bh=Idre/mCQ5iVkPhk8M1k4+RkjhAnNWYNdV/9zIGSEDMY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N1P8Dzw+ibXvk2FZxcXR0OdlA6vAVoRxcuxhHv9iKLh9fYddhNM+pMeRgSL8xEZBw
	 ZyhGUcKELVhSdMT470OChTGf+vAUDM0yHVCw0t/haEeb7IyunQR2gjMTdbkMPk3IoN
	 g3ZxfdJWIvmgjaChy1UD6079KtQZ0SgDaXNr27tnePTNeJ5H5PiwLERl8GKM70DKQL
	 7JPafWOIU05N1KIr1K7GK0kgdmqEpiCIWQdkmNZKQfg5GSPo3ue/RlQvDycwTPedg6
	 mxsJu87qG2jB6VBWDX08aY9V07NQIEJkcAV4frJaSWJbHxG0k48m9k0744EvSyoyEI
	 tw5PLdzlwUhHw==
Message-ID: <sashiko-outbox-173528@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/19] perf test attr: Accept either sample id bit
 perf asks for
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016001843.71978-11-acme@kernel.org>
References: <20261016001843.71978-1-acme@kernel.org>
 <20261016001843.71978-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 00:28:17 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf test: Event.equal() compares event against itself for unrec=
orded events
- [Medium] perf: false attr test failures from asymmetric config masking
--

commit 26200ca4070ba6631a880adb369c9b57d611baf6
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf test attr: Accept either sample id bit perf asks for

evlist__config() asks for a way to tell the samples apart,
PERF_SAMPLE_IDENTIFIER where available, PERF_SAMPLE_ID otherwise. This patch
updates perf test attr to accept either sample id bit when comparing expect=
ed
and recorded events by tracking which side is the recorded event.

> diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/=
lib/attr.py
> index ee55fbe6f07bd..da4614068772e 100644
> --- a/tools/perf/tests/shell/lib/attr.py
> +++ b/tools/perf/tests/shell/lib/attr.py
[ ... ]
> @@ -198,13 +243,33 @@ class Event(dict):
[ ... ]
>      def equal(self, other):
>          for t in Event.terms:
>              log.debug("      [%s] %s %s", t, self[t], other[t])
>              if t not in self or t not in other:
>                  return False
> -            exp =3D self.hide_core_pmu_type(t, self[t], other)
> -            got =3D self.hide_core_pmu_type(t, other[t], other)
> +            recorded =3D self.recorded_side(other)
> +            expected =3D other if recorded is self else self
> +            exp =3D self.hide_core_pmu_type(t, expected[t], recorded or =
expected)
> +            got =3D self.hide_core_pmu_type(t, (recorded or self)[t], ex=
pected)

[Severity: Medium]
When neither self nor other has the recorded attribute set,
recorded_side(other) will return None. In this case, expected evaluates
to self and got extracts its term from (recorded or self)[t], which is
also self[t].

Does this cause both exp and got to extract from self, ignoring other
entirely and causing the equality check to falsely succeed when comparing t=
wo
distinct unrecorded events?

[Severity: Medium]
For got, the third argument passed to hide_core_pmu_type() is hardcoded to
expected.

When self is an expected wildcard event and other is a recorded legacy
PMU event, does this pass (expected, expected) to the masking logic? If so,
could this completely ignore the recorded event's type, resulting in asymme=
tric
masking of the config field and false test failures?

> +            if recorded is not None:
> +                exp, got =3D self.hide_event_count_dependent_terms(t, ex=
p, got)
>              if not data_equal(exp, got):
>                  return False
>          return True
> @@ -218,10 +283,15 @@ class Event(dict):
>          for t in Event.terms:
>              if t not in self or t not in other:
>                  continue
> -            exp =3D self.hide_core_pmu_type(t, self[t], other)
> -            got =3D self.hide_core_pmu_type(t, other[t], other)
> +            recorded =3D self.recorded_side(other)
> +            expected =3D other if recorded is self else self
> +            exp =3D self.hide_core_pmu_type(t, expected[t], recorded or =
expected)
> +            got =3D self.hide_core_pmu_type(t, (recorded or self)[t], ex=
pected)

[Severity: Medium]
The same fallback logic appears to be present in Event.diff() as well. Does
passing None for recorded here break the diff logic for unrecorded events by
causing it to diff self against self?

[Severity: Medium]
The third argument for got is again hardcoded to expected instead of
checking the recorded event. Could this asymmetric masking lead to misleadi=
ng
error logs that report false mismatches for valid legacy PMU configurations?

> +            if recorded is not None:
> +                exp, got =3D self.hide_event_count_dependent_terms(t, ex=
p, got)
>              if not data_equal(exp, got):
> -                log.warning("expected %s=3D%s, got %s", t, self[t], othe=
r[t])
> +                log.warning("expected %s=3D%s, got %s", t, expected[t],
> +                            (recorded or self)[t])

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016001843.7197=
8-1-acme@kernel.org?part=3D10
