Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F354E3CF20C
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 23:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791331144; cv=none; b=otvM+av4Jiv7bzFtctycsiNvuRCwI1OfD+etj/3gNU1oWclAnS5knBVrkGdhxxCqo1Cds3bfwcL8nDKyEhAJWy6C0rsjMUwnxXO/XOfCD7Vvs5ONiwfutBJVer1XLoTLxjhCYprMBy3ExCPO1KIJmbJu1aLdFdlOnFKBZxJA7mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791331144; c=relaxed/simple;
	bh=cSiiAhsGO9vI086v5u3Bwn08VIn/BDUExhPxyyx7qHg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Cqv+3Vj+EhPsIizMw17sUe3w7ZLkOZ+mDsdfz14Sx2BzbCKvroep7cq+0LEC5Z4TfmPVQ5xtFAAkEpT7tNvV6Qj8zXBp9K+H/QvXkkZIzW7Q1cWFgGBNHxQWwsvC8/JxmYsSzYFFKK1X3ejrQqJ054Nmuc9J5JEx43AiuG41Nug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFMaCU7E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFMaCU7E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD41B1F0089B;
	Tue,  6 Oct 2026 23:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791331143;
	bh=UXFmdJVqJmkD+0VCnJQ8ftqNOQQQhLID1/kImuqJtuc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nFMaCU7EAfklogIJC2JmTKwZTmEEwu4G2egW5n2HHYTmkIhySn8A/9s1iuK67uZ9m
	 C/5TAKZ50IDDC6FwVnwUxdZVT44pdABUgUC+uINhee5Xv+umc74hfxY713f1pmRKSQ
	 USwNQsp6B2wrk80CKvjWimjGtLB6osVR7cjq+X1p7jhRSgMbgyJT7AVuXNW6CJ7JdZ
	 2GuwVcgaURVzsRt4lnbt06FYnjQGv1N1awyOTCAU0wu52pAYZ1bkyvZ6CMcEaLNeJ/
	 o+seNhYJFGtFRJwYbP36L4DBqlN/xKm/uoghEw9A0djHhAoOTqxcRfRTe3/EwWmTt0
	 SMDPyBEs58kWA==
Message-ID: <sashiko-outbox-162544@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/10] perf test: Fix dso data tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006234315.920817-11-namhyung@kernel.org>
References: <20261006234315.920817-1-namhyung@kernel.org>
 <20261006234315.920817-11-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 23:59:03 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf test: NULL pointer dereference on dso__new() failure
- [Medium] perf: NULL pointer dereference when dso__new() fails
--

commit 2688b984099e76fca1d46c74193628a04bf63e97
Author: Namhyung Kim <namhyung@kernel.org>

perf test: Fix dso data tests

This commit fixes the dso data tests by bypassing the ELF check for binary
types so that read/write operations on the test file can proceed properly.

> diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
> index 46bc3f5972600..5a027ffab541b 100644
> --- a/tools/perf/tests/dso-data.c
> +++ b/tools/perf/tests/dso-data.c
> @@ -138,6 +138,9 @@ static int test__dso_data(struct test_suite *test __m=
aybe_unused, int subtest __
>  	dsos__init(&machine.dsos);
> =20
>  	dso =3D dso__new(file);
> +	/* override the binary type for dso data access */
> +	dso__set_binary_type(dso, DSO_BINARY_TYPE__SYSTEM_PATH_DSO);
> +	dso__set_bintype_searched(dso);

[Severity: Medium]
Will this crash if dso__new() fails?

If memory allocation fails and dso__new() returns NULL, these newly added
calls will unconditionally dereference the pointer, causing a segmentation
fault instead of allowing dsos__add() to handle the NULL safely and fail
the test gracefully.

>  	TEST_ASSERT_VAL("Failed to add dso", !dsos__add(&machine.dsos, dso));
>  	TEST_ASSERT_VAL("Failed to access to dso",
>  			dso__data_fd(dso, &machine) >=3D 0);

[ ... ]

> @@ -225,6 +228,9 @@ static int dsos__create(int cnt, int size, struct dso=
s *dsos)
> =20
>  		TEST_ASSERT_VAL("failed to get dso file", file);
>  		dso =3D dso__new(file);
> +		/* override the binary type for dso data access */
> +		dso__set_binary_type(dso, DSO_BINARY_TYPE__SYSTEM_PATH_DSO);
> +		dso__set_bintype_searched(dso);

[Severity: Medium]
Similarly, does this bypass the subsequent NULL check for dso?

By unconditionally dereferencing dso, a failure from dso__new() will cause
a crash before reaching the explicit TEST_ASSERT_VAL() check intended to sa=
fely
handle this exact allocation failure.

>  		TEST_ASSERT_VAL("failed to get dso", dso);
>  		TEST_ASSERT_VAL("failed to add dso", !dsos__add(dsos, dso));
>  		dso__put(dso);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006234315.9208=
17-1-namhyung@kernel.org?part=3D10
