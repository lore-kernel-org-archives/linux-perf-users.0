Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D777C26CE2D
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 05:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781240704; cv=none; b=Rr242IYyFWp78cmIqFQlmtTmCvEAcQ/pfhNgWmbG/9nvre/ayAhZC/uggpkQjwMqERLteFf2R928zvqN0USXGd4v58cAsiJb0tT/UORKFAskREb1ZSONuhRbyanAaeT3uU8TSP+kPjoXIWG5fz30TeEZuO69piPGXuzeG9NER7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781240704; c=relaxed/simple;
	bh=rnP0qcf0c6Bk8EjYRhrkPZK6ji/n3M5/MX323r91E7I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jwAyEngGy1J6uRhk3ZsYwjW+PklJWoKlP5j+91vbx1JlWZ8lZGcHJ19HbWwx/IRh90xerilBA9RFoXavVxurW0QS41W2JY7kQu/a0GmYv9cdV2udQ3vMjV22x5zPwqIIL7d/u1/ageduPrxPt02Au3AsuYLbBUeI1+OQ+cJkK7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBcKZA1G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBcKZA1G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D16E1F000E9;
	Fri, 12 Jun 2026 05:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781240703;
	bh=xThxOZey2FRTr/KSOTMwdjKu8iGo08HuA3Le3j13Jiw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kBcKZA1GeClEQ5cnQ1kJNxg1O2XPNwYuODh4qBfVeOxJmSZsz3HZrK3N0uJJYZAWd
	 96E5c0APOlGxWZ1MSD+wuDoHRM/4hQnJV51X7N2t9DEBaEjBTL9BPedMqq2ZF64cQa
	 k9Hbl4zpQdvBSXEaRfxLO3f6TFHK3FQrZR8ZOaSXZRNWdovBD3dM4qTwBCzsDNw73/
	 bjUKkiNy1ZzlQQwkbyZvlsURso/BeFz08MYuLnOSOELn97th0yyNbhcTjE2j+G8J5Z
	 uqIg3RG99aZf8omugPTOIS0/W+6rn6EVEdw1L2gnknOgMfZomkTj0SSluO4nIOQBc3
	 stpRDx8nM10ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 06/19] perf evsel: Add reference count
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611224455.201994-7-irogers@google.com>
References: <20260611224455.201994-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 05:05:02 +0000
Message-Id: <20260612050503.1D16E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `tracking` property setter evaluates booleans incorrectly us=
ing `Py_IsTrue()`, breaking existing Python scripts.
--

commit 84216c0be5b4bb895023fdb2edefdf586bdc6228
Author: Ian Rogers <irogers@google.com>

perf evsel: Add reference count

This commit introduces a reference count for the evsel structure, initializ=
ed
to 1 at allocation. It updates the Python bindings to use get and put
helpers instead of cloning evsels, adding explicit getter and setter functi=
ons
for the members to maintain the existing Python API.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> +static int pyrf_evsel__set_tracking(PyObject *self, PyObject *val, void =
*/*closure*/)
> +{
> +	struct pyrf_evsel *pevsel =3D (void *)self;
> +
> +	CHECK_INITIALIZED_INT(pevsel->evsel, "evsel");
> +
> +	pevsel->evsel->tracking =3D Py_IsTrue(val) ? true : false;

[Severity: Medium]
Will this strictly check identity against the Py_True singleton instead of
evaluating general Python truthiness?

Prior to this patch, the tracking attribute was exposed via a T_BOOL member
definition, which uses PyObject_IsTrue under the hood to evaluate any truthy
Python object (such as 1 or "yes"). Using Py_IsTrue here means that assigni=
ng
a truthy integer like evsel.tracking =3D 1 will now evaluate to false and
disable tracking without raising an error.

Could this silently break existing userspace Python scripts that rely on
assigning non-boolean truthy values to this property?

> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611224455.2019=
94-1-irogers@google.com?part=3D6
