Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21A22DCF57
	for <linux-perf-users@vger.kernel.org>; Sat,  2 May 2026 07:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777707880; cv=none; b=lLd/SfwfLflE9EZAfEHXsMD7G2mJ3A75mj43qTlUblEfJ8I0rYTIxVjD7duNbLVS5iM95S4bZPr3JNvwTJgv/10um8W2JLzF/9Z01Bhpu8jDSKgvhinf1qXtDHhFYqRR9PHWtMNWchrvbCxsAfS3DmqnvfY70mi0ESkANK6ZV6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777707880; c=relaxed/simple;
	bh=yZy6xcQMxEOcfapBJZCRey0ddeDL1JhEvtc2wBeBw58=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k0J+71m7V17Qfs81kzbQ7qXHI/jtjX8bWdxN2WbaiKT88uI+72jxt28m3o09akrYoDX2tfP0ozh9Zv4PlzMtrxA9JERPuZMd9tx6cFiOzsVRNTGS1siqt3rzzUaXXuVUdUpEeFOlK33V2zI4dNwcxioOgaUnMnNuN5TqoY5UiXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9UZ8tA/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9UZ8tA/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580A4C19425;
	Sat,  2 May 2026 07:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777707880;
	bh=yZy6xcQMxEOcfapBJZCRey0ddeDL1JhEvtc2wBeBw58=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=I9UZ8tA/3cBs5gGBoPgq0c/ElEMsS85V2HY1HiRbIpeNdj6FcefEPfwKvj0nrv3f5
	 eOr/dfNDXegcj0m0V4xvuY6AV/bdMvQLm8ATnwhwKTTnJvFla4TUmOcLfW8FYfOU94
	 PkyV+p7kq/BHOrJ4PbSY0lemTDmzXWj4/jqtGoSOgalSdg5+pvLfCG/7LGxSjki3IZ
	 oFoq7XmNnJ1RNO6Q3Vl5mJcjV75BBLo0bt+QlpOGpdB6TtSXveLwtbSGMen/XPU3B/
	 espQ6PVWATFTfPXJWdB3iphJqMxOqMmShj2K4YPq8r/aWvbOndT4EvPBR9FJYpcpOU
	 9BpPIOGJxJM4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 11/17] perf c2c: Use perf_env e_machine rather than
 arch
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260502065935.291960-12-irogers@google.com>
References: <20260502065935.291960-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 02 May 2026 07:44:39 +0000
Message-Id: <20260502074440.580A4C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Build failure on older toolchains due to missing fallback definitio=
n for `EM_AARCH64`.
--

commit 5745fb586646dd63f1bc0598424b6a0b707af964
Author: Ian Rogers <irogers@google.com>

perf c2c: Use perf_env e_machine rather than arch
   =20
This commit updates perf c2c to use the e_machine value from the perf_env
environment instead of performing string matching on the architecture name
for AARCH64 detection.

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 72a7802775ee..09c8352a922c 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -3202,7 +3202,7 @@ static int perf_c2c__report(int argc, const char **=
argv)
>  	 * default display type.
>  	 */
>  	if (!display) {
> -		if (!strcmp(perf_env__arch(env), "arm64"))
> +		if (perf_env__e_machine(env, /*e_flags=3D*/NULL) =3D=3D EM_AARCH64)

Will this cause a build failure on older toolchains where the system <elf.h>
does not yet define EM_AARCH64?

On older systems (for example, those with glibc earlier than 2.17),
EM_AARCH64 might not be declared. Other files in the perf codebase provide
a manual fallback definition for it, but builtin-c2c.c does not appear to
include one.

>  			display =3D "peer";
>  		else
>  			display =3D "tot";

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260502065935.2919=
60-1-irogers@google.com?part=3D11
