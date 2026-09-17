Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D306C3F4122
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 05:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621351; cv=none; b=ADvH+VghG2sTSVffjeDUuX94fWApPTLfwEn2+OdNCB6rMBp6d+WopfPCpnmOkqX7JYpztbTfKR+MHuyAqqT5uneYPNJ8sZ1ofAjdllzW5hfjQmpv5BNRr/f9rQfsEguAgORYRcCDkdisd6OXQp5I/B2U9uMiHxl14XiOIjTp1fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621351; c=relaxed/simple;
	bh=4d2LrQrXceGJMR3fmtosYIjsur7lsktg3LeXYo+ATmA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IgwlVOcYao56iNkxIS1NrkFiCQuDl1bRwIevBYZCraE5BpdEWN240wcD7718E6NSwyO2d7cWJZ1PEwxyHaR38G8dXMh/ZDucaoVzc3kPW0fnylPQSj5rtMYU0GYvHWFULECzuoeMmV23THzoAso+say2LGo1A32IbPhwiPxobxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APqRvjhY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APqRvjhY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506CD1F000FF;
	Thu, 17 Sep 2026 05:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789621349;
	bh=2eTzlbuipePSTK2PkP2S7pe+l41HZJCOyGEbKOSW0kU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=APqRvjhYX/ZfXRC2DdKqhziCZR2c4Y3sR37vQ4wFU8SujPz02RPt/xIoM6wj5/Mfp
	 8GWEhEAcO8sARWewfzB1F9P8exE5MTrxCVr+tadj8d8rt5JaFipavRzMCsDPWlCh4x
	 tRm3svU0/2rPrin6NDwRY3ZEoPX5nrc0O6hu7o4CMnY4fdHrbfqRE9lBnDbAlMUAe3
	 ZZMeVv53xoXyJBMSVPoph35JcEuUnRCN7XdZqwrdE8nQtI9FzNvmeqOUMrIPUJ09QB
	 eLA7LjEWtlcHzwnTU3hFsyPy7bHXcO14eNVCZKMx73pfFX+okF3Jl/PRzgWksUhbZC
	 xhoQ9Szls9eBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 11/11] perf mem: missing standard POSIX headers in
 builtin-mem.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917045326.63601-11-irogers@google.com>
References: <20260917045326.63601-1-irogers@google.com>
 <20260917045326.63601-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 05:02:28 +0000
Message-Id: <20260917050229.506CD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Sashiko reported:
>=20
>   When compiling the perf tool with musl libc, the build fails in
>   tools/perf/builtin-mem.c due to missing explicit include directives
>   for standard POSIX headers.
>=20
>   The source file directly invokes standard libc functions, including
>   calloc() and free() (from stdlib.h), strcmp() and strdup() (from
>   string.h), and printf-family functions (from stdio.h). While glibc
>   often provides these declarations implicitly by pulling them
>   transitively through other headers like <unistd.h>, musl libc
>   strictly enforces POSIX namespace boundaries and does not expose
>   them implicitly.
>=20
>   Because tools/perf/builtin-mem.c lacks explicit #include directives
>   for <stdlib.h>, <string.h>, and <stdio.h>, compiling against musl
>   libc results in undeclared identifier and implicit function
>   declaration errors for these standard library routines, causing a
>   fatal build failure.
>=20
> Add the header files and use git clang-format to sort.
>=20
> Reported-by: sashiko-bot@kernel.org
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917045326.6360=
1-1-irogers@google.com?part=3D11

