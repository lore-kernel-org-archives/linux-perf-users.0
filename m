Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1F6224B1E
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 02:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790649060; cv=none; b=NYmUMnsNEFhxwKPHdqvchUC/ouPMELbpBWHIeV4QLyau0S6sd6r84hAatzkoLCc6/73aLZwzXUQ4/ZzybiWvcCksmdNy4+7fTWkbjJOrvOR+Ai9ouKyGvnekjLs4lgoI4eFevhdHhrjbRO0waWuF1kunw23YrzqquEUig+R4XAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790649060; c=relaxed/simple;
	bh=IAswiVz0NV4Qeq9fhxm2rtjr9zcjhEnnd5kqZ77YODg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ce/aPY0m1NyNVF3GJgQbqd8sjs1k2h7iQfXZzpc1nIU1AMPCFRMk9FfPm/VAANgHRh8ajFo2KoupcZiD0qRnweDyz2GYpkJXl1HT4RCFm+nFuJeMKD2OfCS5GGSOgmAbacuh6wOrxcu7js0SP4tgXP3Q6qvRUPW6QEiUuf7jydc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oe6eSTcp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oe6eSTcp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3A21F000FF;
	Tue, 29 Sep 2026 02:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790649054;
	bh=TRnWJ1zhAlGz1r+7QJGzuUvLxNYVpMAfy2k0yIGjnm0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Oe6eSTcp1ZSQr9K74ZM2OWln2oBxzWL2WPEBaGyFH4145tm+8/hUU0H9UoMWtZI8n
	 ulZd37gIQHr0DmbQU6/smU4BDNaL8ZhasMt20Sb1vqNEozOY1StEn1eUaI6ReUBmay
	 cYbQ8tNQbGcAEIk8DD8MWwINmulbrzuC90ApTXh/4WaID4bwFFEZ8FFofVoI1ICyJC
	 BJ3dlZ9Fdk+h8D5S15TMiyWEXVegnG1vhimS7wCEx5PjiszJN8NwY00uXWjX79Gq33
	 gZ3JJa2JF7vZB0DI1QmoBbp9BU5aCiA0RdYv46Ku1z5q9auA4hk4+OJr0MlOJcOZgX
	 zNge6wg5wOAMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/9] perf python sctop: Fix offline interval printing
 and test flakiness
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929021913.56010-3-irogers@google.com>
References: <20260929021913.56010-1-irogers@google.com>
 <20260929021913.56010-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 02:30:54 +0000
Message-Id: <20260929023054.BA3A21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf python: sctop offline interval bucketting broken by comm fi=
lter
--

commit b0674a2bbd03e3e74148a12d9d8a3c74b4f35ce5
Author: Ian Rogers <irogers@google.com>

perf python sctop: Fix offline interval printing and test flakiness

This commit addresses sctop offline interval printing by only advancing the
logical clock on non-skipped samples. It also reorders e_machine
initialization and updates the shell test with retries and different
recording parameters.

> diff --git a/tools/perf/python/sctop.py b/tools/perf/python/sctop.py
> index 42e95ecfffad7..c524e08e64405 100755
> --- a/tools/perf/python/sctop.py
> +++ b/tools/perf/python/sctop.py

[ ... ]

> @@ -127,7 +128,7 @@ class SCTopAnalyzer:
>              if not skip and is_enter and 0 <=3D (syscall_id & ~0x4000000=
0) <=3D 0xffff:
>                  self.syscalls[syscall_id] +=3D 1
> =20
> -        if self.offline and hasattr(sample, "sample_time"):
> +        if not skip and self.offline and hasattr(sample, "sample_time"):

[Severity: Medium]
Does adding 'not skip' to this condition in sctop.py's
SCTopAnalyzer.process_event() introduce a regression by blocking the
offline clock from advancing during periods where the target process is
idle?

By ignoring the sample_time of non-matching events, the script's internal
logical clock fails to advance. This prevents the current interval bucket
from flushing until the target comm executes another syscall, merging
events from multiple intervals into a single bucket and resulting in
incorrect interval sums.

Does this also cause the script to miss printing periodic empty tables
during idle periods, breaking consistency with live mode?

>              interval_ns =3D self.interval * (10 ** 9)
>              if self.last_print_time is None:
>                  self.last_print_time =3D sample.sample_time

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929021913.5601=
0-1-irogers@google.com?part=3D2
