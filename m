Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7901941C307
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jul 2026 18:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360908; cv=none; b=F0YJMe+YQBrAyxTIyNAZC7Fc9h7ADzH5nDC4U1tN1jM+RSk2kNTc5NHkeO5SCbonwDVhRXxWJOVKqPYlDCwa9KOWj3D67eopxw/ZodbNvTZqa5wuWOH6KjcWVX2F+6+Ry+7PRtiq5x+PuKgTodle/nx9d1u2StbZDN0+JDePObg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360908; c=relaxed/simple;
	bh=A8ALJrYClWMjBVcvu6j54pxgUI0xLBTcDvZcAU50uI0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KEuo9PcGjwCFdytd34nsskloC2AXxjWVS6N+yRL1vCCC0nWSLsceJMCNlDkzg2eThk3xBYK3UBhzuLSpoc0RNCx74TIYp/zMBDPydwXUX1JAQqZk9f+M5ZlZHA5ieD+awi3Ju9hi2vuor5UPN95rxO9we84lDIR00lqTfvi6ncE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqKniqRN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqKniqRN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25AB1F000E9;
	Mon,  6 Jul 2026 18:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783360906;
	bh=JArVimeGD0xkZVyZmDcHohghlJnjsgIcNj+8QrVv6xU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MqKniqRNxC40Vnh+Tx01PrdVxfLPjz47XBuIjW6nPYamrQfnKDExEtiDYvo4M+F9P
	 I0eiLsIlxeoV7UAPlDFq/0W7Tj++a02WIycAyhEXH//gikhndstMTMCCa5qXQZgUqr
	 7WZyba+cNVrKsnIyFPMg9Gl3nM2ZfhuCqsI4DcsZ4e+OQrgsoKkwPTcZ+Hc0IB2vXL
	 Vs0+RiSePexDmtZbSGzujNwKOeCbU2P2VsiTg/RjwUaYyyaOfrbcU6JWMrQtKsOuc0
	 Of8kMLGJd0msxdESWQ+t+O/6YS8ToZBPl+piC1VzpfyqEJALNJBE2+IicsgH/rQLce
	 YiJlSuUgbLt8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf jevents: make events order more deterministic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nazar Kazakov" <nazar.kazakov@codethink.co.uk>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260706175624.692736-1-nazar.kazakov@codethink.co.uk>
References: <20260706175624.692736-1-nazar.kazakov@codethink.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 18:01:45 +0000
Message-Id: <20260706180146.A25AB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `__lt__` method violates strict weak ordering by using flawe=
d boolean logic, breaking Python's sorting guarantees.
--

commit 1d3198ec01401252a35bb75abf7f3dc67eead5ab
Author: Nazar Kazakov <nazar.kazakov@codethink.co.uk>

perf jevents: make events order more deterministic

This commit attempts to fix a non-deterministic sorting order for events
that share the same name by including the description field in the
comparison.

> diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metr=
ic.py
> index a91ccb5977f08..b3ab78a0ecb22 100644
> --- a/tools/perf/pmu-events/metric.py
> +++ b/tools/perf/pmu-events/metric.py
> @@ -623,7 +623,7 @@ class Metric:
> =20
>    def __lt__(self, other):
>      """Sort order."""
> -    return self.name < other.name
> +    return self.name < other.name or self.description < other.description

[Severity: Medium]
Does this logic break Python's strict weak ordering requirement for sorting?

If we have two metrics A and B where A.name > B.name, but
A.description < B.description, then A < B will evaluate to True because the
second condition is met. Conversely, B < A will also evaluate to True becau=
se
B.name < A.name meets the first condition.

Since A < B and B < A can both evaluate to True, this breaks the asymmetry
requirement for sorting and can lead to inconsistent event ordering or Pyth=
on
exceptions during the perf build.

Could we compare tuples instead to ensure consistent ordering, such as:
return (self.name, self.description) < (other.name, other.description)

> =20
>    def AddToMetricGroup(self, group):
>      """Callback used when being added to a MetricGroup."""

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706175624.6927=
36-1-nazar.kazakov@codethink.co.uk?part=3D1
