Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C81D31E852
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 01:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792027217; cv=none; b=GmjdiYPhyqmmlXcbwwi3vy4cKv2LjQALa/LDbO9bXnJEdjLHHEkWhyCr7EYVV6s+esXGbGSuBp6GkVZoMApnLTmdKrfGRd7S9hWkIHzSOCdczDYCcmz+pzuckF4u5/dW3RwPMBtnnfw8wMtXxeg33R/wxsDEatCYG4MITqjC1bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792027217; c=relaxed/simple;
	bh=PQmsLacpbo/B4n3Vvk7Oh5c7gsFMVBMoKeOVKpDUxyI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=JKAaPr+6QQdze8H4Imv2yrZ1BI2N8XOlC587oNmITqwnukLzIIvibq+P+8bNAu0kdC9MnkkU3gMaTyEp5wR0wFbjYO+UFF4RKNBvMavk2zNOuvOvOiNTdeRRPiM3/NRGrqMYk3jT0SGBCvvcY5eiGF/dS0W5dh4ChgLNgCLA9tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a07DfpSE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a07DfpSE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69F91F000C4;
	Thu, 15 Oct 2026 01:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792027216;
	bh=bO0uGaMR4ig2aZGAvQHscxlByaIXN2yALeGwOuy9SiQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a07DfpSEogtWY9eMvgOPQg94+aupE3Hynk4IvNw50ULkd2JknN2JEDnXyYgRVje/N
	 EFP4El/pksCR74zKuxV2oT4lNW3ryHk3EgtJ4rYhMcJrQDBhqJKzg0bckmRHfH7zcs
	 59if8xivYKurEFIgc5/JbPVYHqUt3iPR6xIaf4LHVZI7SzDDyy/8iAmq9D9yhCQNA7
	 8Is56O7N/BnJeUM6SY02n3+yEOEN2yFsESF4rMoLC7ZdK6qcJqwja/yc4jX7ZOwqf2
	 6N+Ps1AKk27ENFVI+cvxAUOfh1DmCsfp/EdrM4QCNB7CGL6KDD1iV763JL38gbqg7M
	 Bf4ergOEb34fw==
Message-ID: <sashiko-outbox-172085@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v5 1/5] perf ftrace: Optimise
 __cmd_ftrace() stack frame with strbuf streaming
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261015011155.414667-2-atomlin@atomlin.com>
References: <20261015011155.414667-1-atomlin@atomlin.com>
 <20261015011155.414667-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 01:20:15 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf: missing explicit inclusion of <stdio.h> for POSIX stdio strea=
ms
--

commit 84dafb5e4aabd0b60e918d9f85e26ec8e27d5c88
Author: Aaron Tomlin <atomlin@atomlin.com>

perf ftrace: Optimise __cmd_ftrace() stack frame with strbuf streaming

This commit optimizes __cmd_ftrace() by replacing a fixed-size stack buffer
with heap allocation and a dynamic strbuf for trace data accumulation. It
also introduces error checking and stream flushing to improve robustness
during steady-state polling.

> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 6017493ff1797..6ee72ae90f67a 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -41,7 +41,10 @@
>  #include "util/units.h"
>  #include "util/parse-sublevel-options.h"
> =20
> +#include "util/strbuf.h"
> +

[Severity: Low]
Does this file explicitly include <stdio.h>?

This isn't a runtime bug, but relying on implicit inclusion via other heade=
rs
for POSIX stdio streams and functions (like stdout, fprintf, fflush, and
ferror) violates the perf subsystem guidelines for musl compatibility.

Explicitly including <stdio.h> ensures the code doesn't cause build breakag=
es
on libc implementations that strictly separate declarations, like musl.

[ ... ]
> @@ -806,24 +818,42 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>  	}
> =20
>  	while (!done) {
> -		if (poll(&pollfd, 1, -1) < 0)
> +		if (poll(&pollfd, 1, -1) < 0) {
> +			if (errno =3D=3D EINTR)
> +				continue;
>  			break;
> +		}
> =20
>  		if (pollfd.revents & POLLIN) {
> -			int n =3D read(trace_fd, buf, sizeof(buf));
> -			if (n < 0)
> +			int n =3D read(trace_fd, buf, TRACE_BUF_SIZE);
> +
> +			if (n < 0) {
> +				if (errno =3D=3D EAGAIN || errno =3D=3D EWOULDBLOCK || errno =3D=3D =
EINTR)
> +					continue;
>  				break;
> -			if (fwrite(buf, n, 1, stdout) !=3D 1)
> +			}
> +			if (n =3D=3D 0)
>  				break;
> +			for (int i =3D 0; i < n; i++) {
> +				if (buf[i] =3D=3D '\n') {
> +					if (fprintf(stdout, "%s\n", linebuf.buf) < 0)
> +						break;
> +					strbuf_setlen(&linebuf, 0);
> +				} else {
> +					if (strbuf_addch(&linebuf, buf[i]) < 0)
> +						goto out_close_fd;
> +				}
> +			}
>  			/* flush output since stdout is in full buffering mode due to pager */
> -			fflush(stdout);
> +			if (fflush(stdout) < 0 || ferror(stdout))
> +				break;
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015011155.4146=
67-1-atomlin@atomlin.com?part=3D1
