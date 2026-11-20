Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795138829;
	b=p5nAuCQfeAYju+pyACWj97v2TVTV0MPQw5RW8ltza/U6SU3oNG9rWFcRZNlqRxH7n/Gy
	 54o+mPycA+gZ0KoCTszs+cWdQhhS64USZrifE0nDGSBExRfy4SU6ngWxJr+Qr4Ssq96t9
	 CFN8v6L+/XV93n3p/6jbAMXZLOQRRimy5eLYvTDnBAKS2iFV4GlhtM0iDDQIO97+EXuD4
	 PDWb0MMcnkeSmGQ9Q//1sy0T/dIq0eSq05tmW9MBDuJDPN9RSdoINWnlfGQy5rU0wfYKx
	 +Us9MN0tCq+JT2ikXz5B33ywX1LT+pwBT4fwdMJuMUX9rLhbXFHoVerJxHGgWUdopiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795138829;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SBaqe1bKliiT540/DmKe2YUbjLcUBAGOXICka7u+D/k=;
	b=owJxwVVJTACHeFQhMDi67+IVXcbsxEXhEeLpl9/d9h2u6nhMv03oUbX7JGQyzz+GtKDg
	 cfD5g0bD0SqtgNw9uiZOh0JTKfPi01IBC+I+wnawryeGZlIs8BfyLDUwP01G62eBqMuSo
	 smiJj8xYgddJHhSHs0mwfjJ5ZhYxld+eJ0fvCe3UPwt4ksTd5yk9VvoY5eh1uAgulwmrp
	 +tevJdZvhb2b7Bl94AC0A6cW4Qy/b4irXgxQ+sfL4j8/fNc0htNBQJSnae1LUbad0KTCC
	 A9omfxuDbtBExyNQ2rZ+fveN6lp6NbfC/h/+ioaRLlFBWw3rlQ3DZXnpxreQsdGtWKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="F/lCTcsq";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8F2606A325
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F/lCTcsq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB201F000C4;
	Fri, 20 Nov 2026 01:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795138829;
	bh=SBaqe1bKliiT540/DmKe2YUbjLcUBAGOXICka7u+D/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F/lCTcsqHpXTAPZsQhnjsUpjFW0Tsntzkd/PI3GzIxdxccMQ6KDyj9VNbm9IWhcnf
	 EC2aMGDmaeVq/Zl5+n/V/iSj88QlhQjrU2CJb2BGEsFznEU/GLvcj51ogoA34LFJaB
	 CNgLT2MPftFapbpmMSSKsl5996rwmmVMMyJsKH0gLE9xrcOCF+41fNybIvXM1Eqgln
	 owAIVNL4kJG+3TiEnVo7TDMGqWfexyqzMchrhxa1BFVq5+kJ+lGnJG12lOcTRgBE0r
	 6TePMqEedXwqpsoES7wfBgS2avj1WvxiD8reS0ikV/4CupY99CxIoDC5cOqWXTZKBb
	 zCKxKCkm6sgxQ==
Message-ID: <sashiko-outbox-224334@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 02/13] perf scripts: Add a coverage harness for perf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261120013211.1510-3-acme@kernel.org>
References: <20261120013211.1510-1-acme@kernel.org>
 <20261120013211.1510-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 01:40:28 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] perf scripts: focus_path() fails to strip leading perf/ prefix
  for -f paths
--

commit 5debccd739d02a3ebc2b5b2486b3cc102c514507
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf scripts: Add a coverage harness for perf

This commit adds a clang source-based coverage script for perf along with
Makefile targets to build an instrumented perf, run the test suite, and
report line and function coverage.

> diff --git a/tools/perf/scripts/coverage.sh b/tools/perf/scripts/coverage=
.sh
> new file mode 100755
> index 0000000000000..bfaaa9a00e248
> --- /dev/null
> +++ b/tools/perf/scripts/coverage.sh
> @@ -0,0 +1,1153 @@

[ ... ]

> +AWK_PERF=3D'
> +function perf_relpath(p) {
> +	sub(/^.*tools\/perf\//, "", p)
> +	sub(/^perf\//, "", p)
> +	return p
> +}
> +function generated(p) {
> +	return build !=3D "" && index(perf_relpath(p), build "/") =3D=3D 1
> +}
> +'
> +
> +# Line coverage of a full report for one file: "lines missed cover fn%".
> +# Match the requested path as a suffix: a build outside the source tree
> +# gives ".../tools/perf/...", one inside it "tools/perf/...", and one
> +# inside tools/ makes llvm-cov strip the "<srctree>/tools/" prefix shared
> +# by every reported file, giving "perf/...".
> +#
> +# -f takes the path as it shows in the report, or a tools/perf/ relative=
 one.
> +focus_path()
> +{
> +	case "$1" in
> +	*tools/perf/*) printf '%s\n' "${1#*tools/perf/}" ;;
> +	*) printf '%s\n' "$1" ;;
> +	esac
> +}

[Severity: Low]
Should focus_path() also strip a leading perf/ prefix, like perf_relpath()
does?

When -f is passed a perf/... path from a report built under tools/,
focus_path() leaves the leading perf/ intact, causing print_uncovered() to
check for $PERF_DIR/perf/<file>, warn that the file was not found, and skip
printing its uncovered lines.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120013211.1510=
-1-acme@kernel.org?part=3D2
