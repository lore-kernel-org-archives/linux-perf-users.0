Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9CE4534B3
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625820; cv=none; b=nuZWXBpkBnf2CrGI7t0wjCTuXxaKIrpH70sGRDZq47+yBrk46vjvs11QdkveWXw+Ia93ZXvx8asBR78qgZqgfD7noCbDRlcoNl86YfOgySeKJqZ5WDMJ//ilHh/PNAD0qDdIC/sh43xJOS3ztB4Ndw524eh78llDjugMT4rvHC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625820; c=relaxed/simple;
	bh=/oTnBi1Qv+IeyptIwOMNj5U/8bnp9ve5XmQTqbXs2Mo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DMooQEEin9Iez5LMlWIAdIgFG3KpPGkbhr+/Hx85hYV4slpVf1x2UQOGO81pz+P3hRfVGsWoyJso4/6+vsJOP1jInJ8JOr73s4c+4KpKXWmQox69K8N2PeJADeQGc9zvtjZOQ62cNTR7JubjHtjwhD9Hw6mG7P6CjrSRAIpq9XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBs5exqz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBs5exqz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501E41F00A3D;
	Tue, 16 Jun 2026 16:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781625819;
	bh=iXoHKi4vGfoFCn4ghQcfwfSXfj7fPZyrrIYGzuATN9s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eBs5exqzlrWn2XSbWn0ChDP4f20lYgnoiDmE8eLfC18zIb+vi87HArqhS/m9FJ665
	 Kommf0vSI2Ctbtrb6I6IjYyqruIW2s+qru5VHj0XKBNtv9bKLCoJcvxK1UBhiYZhxJ
	 vsz6RnvjQdw/x4RrxS+gTWGhx4Du0vCplLgDv9mXVanCcl4JdbiO3HFQJVCjPrDipx
	 XzLQk2T/gViO4yxviyylw/RJZ/Iawpjie2cWAG0m2+mWNrWvJHm72TJM5qk/tMovmE
	 L6ReSie/LSG4SJacf1axXd72a49Cwy5sQ12beApfctTWLwFVAW+gRCDj2WhsIC0bXq
	 SuFzHW6ON5nfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf evsel: Add lazy-initialized probe type
 detection helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616154446.7206-2-acme@kernel.org>
References: <20260616154446.7206-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 16:03:38 +0000
Message-Id: <20260616160339.501E41F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Calling `evsel__field()` unconditionally without a `HAVE_LIBTRACEE=
VENT` feature guard or fallback stub causes linker errors when libtraceeven=
t is omitted.
--

commit 1f0d622399b5f71c138cdc45ef059e320a38fea7
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf evsel: Add lazy-initialized probe type detection helpers

This commit adds helpers to lazily detect and cache whether an evsel is a
kprobe, uprobe, or ftrace-based dynamic probe. It introduces a 3-bit
probe_type field in struct evsel to avoid repeated PMU lookups.

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
[ ... ]
> +static void evsel__resolve_probe_type(struct evsel *evsel)
> +{
> +	const char *name =3D evsel__pmu_name(evsel);
> +
> +	if (!strcmp(name, "kprobe"))
> +		evsel->probe_type =3D PROBE__KPROBE;
> +	else if (!strcmp(name, "uprobe"))
> +		evsel->probe_type =3D PROBE__UPROBE;
> +	else if (!strcmp(name, "tracepoint") && evsel__field(evsel, "__probe_ip=
"))

[Severity: High]
Will this cause a linker error when compiling without libtraceevent?

This unconditionally calls evsel__field. The actual implementation of
evsel__field is strictly wrapped in HAVE_LIBTRACEEVENT guards. Without a
fallback stub in tools/perf/util/evsel.h that returns NULL for the
!HAVE_LIBTRACEEVENT case, omitting libtraceevent could cause an undefined
reference error during linking since evsel__is_probe prevents dead-code
elimination of this function.

> +		evsel->probe_type =3D PROBE__FTRACE;
> +	else
> +		evsel->probe_type =3D PROBE__NOPE;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616154446.7206=
-1-acme@kernel.org?part=3D1
