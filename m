Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D10945D906
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790759727; cv=none; b=f3PDqyBtM0kpg0BiT4Q39g5pZkbDVC+I5wJCmA/0OJjTq/G+1zo12852CkpOKdN11aSMV93I3Wu/8I0xRWwZqzm17znnGXXw7OyWfflm0gf4kyC+w7el0NWar1H5nounO3z0BqKYLVHTHtlsEFiQiCnGludp+lgeqWoexUQzKYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790759727; c=relaxed/simple;
	bh=5JpKQ859Ko/GgR8/AtrPb2Beds+aCkwy0d3FTconpXg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eSNLEPcvbeBI2zp1hmDJlrTXoB6zDHOBITBZEIOdqVq8NV8r6gI6M62lmIrvO8I2k7qM/cgzjCRjf4dyabRxoBfYg9VFUkXXhZa3U+MptOVQMZxO4aCFbBx3g3Tbjtz+XO5fA21row+t3+J0Ksox+htdPJQbqSSTGzOabk22pZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJ7GKOWa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJ7GKOWa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98E41F000FF;
	Wed, 30 Sep 2026 09:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790759725;
	bh=mXuO+RZvST3c7d+Z1vehIOngP+53MRFolqYUAv0F0ks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aJ7GKOWaEn7TlQLQLGfsDsGEJrXPNUJqhqV2hKHEMnxre0jZzieo3SJ3htosQ8Zrc
	 qY2+K3VUe54kDyoP7sKnyjgI2zkTa44xSEX7AwGrtQfDnS53/M+wC3GZiY+mx4RdfY
	 UiqTaR13gW9WBmXqKG6lffj1NrAETQjgH4ViYP2q1XTFKdsPCPZpBB8kr7ioaHpbIa
	 WhdtHdVJahI/vAa7yJjGk4R7uBejgeb5YC9AWpwTuVUUwVmwk9XnS6drUquqnfdUjg
	 tVtdiZIM7IX/nT/gevmBKCrx90VUyRtJfJe+aIoAIdfa0YL9sVw8iqD7y2TanR1Moj
	 KORtxtKV2Bvcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] perf build: Build the Python extension before
 pylint consumers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930-perf_fix_pylint_errors-v1-1-f72151d8b255@arm.com>
References: <20260930-perf_fix_pylint_errors-v1-0-f72151d8b255@arm.com>
 <20260930-perf_fix_pylint_errors-v1-1-f72151d8b255@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 09:15:25 +0000
Message-Id: <20260930091525.B98E41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf build: parallel compilation serialized due to order-only depen=
dency
--

commit b4e3b80b8bd24b069f41f7f4f4f217b8194d4514
Author: Leo Yan <leo.yan@arm.com>

perf build: Build the Python extension before pylint consumers

This commit delays the perf and perf-test sub-makes until the Python
extension is built when pylint is enabled. This is intended to prevent
an import error that stops parallel builds before the extension is availabl=
e.

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 0102c3468a0b7..d350d085542c6 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -578,6 +578,12 @@ strip: $(PROGRAMS) $(OUTPUT)perf
>  	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) $(OUTPUT)perf
> =20
>  PERF_IN :=3D $(OUTPUT)perf-in.o
> +
> +ifdef PYLINT
> +# Build the Python extension before starting sub-makes that lint its use=
rs.
> +$(PERF_IN) $(LIBPERF_TEST_IN): | $(LANG_BINDINGS)

[Severity: Low]
Does this order-only dependency block the $(PERF_IN) sub-make from executing
until $(LANG_BINDINGS) and all its prerequisites (including $(LIBPERF_UTIL))
are fully built?

$(PERF_IN) launches the sub-make that compiles all builtin-*.c files.
Meanwhile, $(LANG_BINDINGS) depends on $(PERFLIBS_PY), which launches the
sub-make that compiles all util/*.c files.

Does this completely serialize the compilation of the builtin/ directory
behind the full compilation of the util/ directory and the Python extension,
impacting concurrent parallel build efficiency?

Furthermore, does it force an isolated make perf to needlessly build the
Python extension when PYLINT is enabled on the host?

> +endif
> +
>  export NO_JEVENTS

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-perf_fix_p=
ylint_errors-v1-0-f72151d8b255@arm.com?part=3D1
