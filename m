Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24E4393DE2
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 21:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778622843; cv=none; b=e9AN9BwBj6v7deFbMNWccrd6XYz6DLqOehBbqaZqD/0nPgApx0iYtMr6gj1yFZ4pAhHp+Bq6JB6OCzo1M1k4y6Ts1m9wqemIhhXPqRGz6obaVtOAsNTyf6UNGAh2XL0mysr2FZxJkojZkonLdRMubHof3qXKGABWgDAI+/LbsPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778622843; c=relaxed/simple;
	bh=Kp5mPu7BR3oA23A/lfZm7ToAxLZOhH1v1U0aTrUJ0iU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u6ruD6uoShFJvqZCdRVwdEd960j4yavKPaopfeN9bq62ZK7RRlEjtx2jW2pqMW+LgwIg7MClDm/VqFLUPxceGfSBPT17u9zK9WysaAXU/+Id0s1dfyug0YxRIz6Pxzg1nFquiD917CUIrsvM0NYdTHTXxCcfLJ08b4f8IV1vOak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kK0IMXuQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kK0IMXuQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FFEC2BCB0;
	Tue, 12 May 2026 21:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778622842;
	bh=Kp5mPu7BR3oA23A/lfZm7ToAxLZOhH1v1U0aTrUJ0iU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=kK0IMXuQd1BRcaHtnkqG0eE1eQho0VnHKsrSgg97bDOQRyJevOvdXcfGmVAVJsUP+
	 DWj6XFiM3qoFCTvsmv1sZkHC58EBzbMw+L/Asrvl4j7Rv3SVnV8gqnUjiBiHQL9L1A
	 LUdDPvAJJbaFvBe7ypBmk384IMbGcUhFl3nR4EheHQg+Jil0uokpb0JpCLXP8krqHG
	 IMDGfVzD0yrIs837JIjCnxHdDh1Vp9wmf30WvwpJ+cDuAqqoK1pVym2h228T/H5+Df
	 mOhWLFlIsFo5IjT/sPFdD5GSDyfgQFJqmIJxxp573vGSYv2AV91cngfYarB6C5/C8k
	 OKo96F6n3Rd4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/7] perf trace: Update beautifier script for clone
 flags
Reply-To: sashiko@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260510202346.49853-8-namhyung@kernel.org>
References: <20260510202346.49853-8-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 21:54:02 +0000
Message-Id: <20260512215402.B5FFEC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Adding 64-bit flag masks introduces an undefined behavior shift =
overflow on 32-bit platforms, causing corrupt perf trace output.
- [Medium] Missing empty input handling in `xargs` generates a buggy C arra=
y entry when compiled against older kernel headers.
--

commit 0277447cb377648d9d63a42e778d841a1fdaac29
Author: Namhyung Kim <namhyung@kernel.org>
perf trace: Update beautifier script for clone flags

This commit updates the clone beautifier script to parse newer clone flags
that use the 1ULL shift pattern. It extracts 64-bit clone3 flags up to bit
37 to generate the clone_flags array.

[ ... ]
>       [ilog2(0x80000000) + 1] =3D "IO",
>       [ilog2(0x00000080) + 1] =3D "NEWTIME",
>       [32 + 1] =3D "CLEAR_SIGHAND",
>       [33 + 1] =3D "INTO_CGROUP",
>       [34 + 1] =3D "AUTOREAP",
>       [35 + 1] =3D "NNP",
>       [36 + 1] =3D "PIDFD_AUTOKILL",
>       [37 + 1] =3D "EMPTY_MNTNS",
> };

Does this cause undefined behavior on 32-bit platforms?

The generated array now includes entries for bits up to 37. When perf trace
consumes this array in strarray__scnprintf_flags(), it computes the bit
mask using an unsigned long shift:

    unsigned long bit =3D 1UL << (i - 1);

On 32-bit architectures, unsigned long is 32 bits. Shifting by 32 or more
is undefined behavior and often wraps the shift count. This could cause
standard 32-bit clone syscalls to falsely match the new 64-bit flag names
if the corresponding wrapped lower bit is set, corrupting the tool's output.

> diff --git a/tools/perf/trace/beauty/clone.sh b/tools/perf/trace/beauty/c=
lone.sh
> index 18b6c0d756937..98cb1f8d4a6ff 100755
> --- a/tools/perf/trace/beauty/clone.sh
> +++ b/tools/perf/trace/beauty/clone.sh
> @@ -14,4 +14,8 @@ regex=3D'^[[:space:]]*#[[:space:]]*define[[:space:]]+CL=
ONE_([^_]+[[:alnum:]_]+)[[:
>  grep -E $regex ${linux_sched} | \
>  	sed -r "s/$regex/\2 \1/g"	| \
>  	xargs printf "\t[ilog2(%s) + 1] =3D \"%s\",\n"
> +regex=3D'^[[:space:]]*#[[:space:]]*define[[:space:]]+CLONE_([^_]+[[:alnu=
m:]_]+)[[:space:]]+\(1ULL[[:space:]]*<<[[:space:]]*([[:digit:]]+)\)[[:space=
:]]*.*'
> +grep -E $regex ${linux_sched} | \
> +	sed -r "s/$regex/\2 \1/g"	| \
> +	xargs printf "\t[%s + 1] =3D \"%s\",\n"

Should this use xargs -r?=20

If the script is run against older kernel headers that lack the new clone3
flags using the 1ULL shift pattern, grep will yield no output. However,
xargs will still execute printf once with empty arguments.

This results in a generated entry of:

    [ + 1] =3D "",

which compiles as index 1 (mapping to bit 0) and could cause perf trace
to print confusing empty suffixes for syscalls that set bit 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260510202346.4985=
3-1-namhyung@kernel.org?part=3D7
