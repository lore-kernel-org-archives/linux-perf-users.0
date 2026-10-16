Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0FE2D5C8E
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 00:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110385; cv=none; b=ZA/tEmO9aSjZt4WFFX24UVbIZCCOQWUo4GwJ/WLsnI8tegNT1rOjTewp2t0y/05XRJNfJuKSxZ+/OKVkgG+eTeBCY1S0cSzL12ykcYA4JDY9p7Chkh7CAaDOzUufMbW+qeHq3ai/hucej7ihMEFwqoG9uhu8w9GSqYvDwVlW9Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110385; c=relaxed/simple;
	bh=mWJYy3heEa/PgV9wxrmbo/B0lxDSgJ8W/Lo3nSwhO54=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=KBTzLSMTyP4HcYCVOtzHv6vxAGAwAc4YQySULqoh1ZpMiiZvcrR/AeHhw1rNRV51FJ1ZxOY439CZ/srhV46t9RsZz5zNKyHSEw/0n/UU1fmJOEYqSH7/8FVzBpyhm7eVDDel9S2TK+hYtD+aCUbswlntlv8KPONZVMBQBYPnWsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ad+cgpob; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ad+cgpob"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975C31F000C4;
	Fri, 16 Oct 2026 00:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792110381;
	bh=u4Wm4WzmFIgbTks8i//SoG+9skN8ql8thwwiKLy9qI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ad+cgpoboSWVakWNJtyx9gAL/zl+qnk9Ajs6YcOBnQsZ1ag+zOW6ktgLfecGmZ1uX
	 VTo7RrOtQ2JzKenuERyxZQlPW3Vjq2qRpR9xw5RcXHop7FZ34vazSN39bV4FooPJax
	 RpbBs+cFKVUBt08PNNLk4OBAlCKOXWkoQ7jGQzghpP985OPbqwdPTzuqYTU1YPvhPR
	 m52EJXvNI4vyKCKxmudZZSMpL0bMJfQjMNPMCOMBH0oJIW1XEmKEnWBGe4+sFpYcas
	 lFVW/tYyleewrU8TA/P9sBlCLOnVBiZ03hagfgaeWr8/XrMaOfAfq4UbcaomgRs3dJ
	 1t8YDPD30yBsg==
Message-ID: <sashiko-outbox-173525@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/19] perf test attr: Allow tests to require a core
 PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016001843.71978-3-acme@kernel.org>
References: <20261016001843.71978-1-acme@kernel.org>
 <20261016001843.71978-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 00:26:21 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf python: memory leak in pyrf__parse_events() on error path
--

commit 8f696c0054607fd944b69ffbf9d282950abfb382
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf test attr: Allow tests to require a core PMU

This commit introduces a 'requires' limitation for perf tests to skip
execution if a core PMU is not available. It checks for a core PMU by using
the perf python binding to parse and open the 'cycles' event.

> diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/=
lib/attr.py
> index 68f06df9565a0..2d7dd26a57377 100644
> --- a/tools/perf/tests/shell/lib/attr.py
> +++ b/tools/perf/tests/shell/lib/attr.py

[ ... ]

> @@ -28,6 +29,50 @@ def data_equal(a, b):
> =20
>      return False
> =20
> +CORE_PMU_AVAILABLE =3D None
> +
> +def core_pmu_available():

[ ... ]

> +def core_pmu_probe():
> +    """
> +    Ask perf itself, through its python binding, to parse and open 'cycl=
es':
> +    a parse failure or an ENOENT means no PMU can count it, any other er=
ror
> +    means we can't tell whether there is one.
> +    """
> +    try:
> +        import perf
> +        parse_events =3D perf.parse_events
> +    except (ImportError, AttributeError):
> +        # Nothing to ask about it, let the expectations speak.
> +        return True
> +
> +    try:
> +        evlist =3D parse_events('cycles')

[Severity: Low]
Does this trigger a memory leak when parse_events() fails?

The python C wrapper pyrf__parse_events() in tools/perf/util/python.c
appears to omit the required cleanup call on its error path:

tools/perf/util/python.c:pyrf__parse_events() {
	...
	if (parse_events(evlist, input, &err)) {
		parse_events_error__print(&err, input);
		PyErr_SetFromErrno(PyExc_OSError);
		evlist__put(evlist);
		return NULL;
	}
	...
}

While this leak was not introduced by this patch, this new core_pmu_probe()
function actively relies on and triggers this error path to detect the PMU
absence.

Could we clean up the dynamically allocated error strings within the
parse_events_error structure by calling parse_events_error__exit(&err) when
parsing fails?

> +    except OSError:
> +        # No PMU that can count it, the same as the ENOENT below.
> +        return False

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016001843.7197=
8-1-acme@kernel.org?part=3D2
