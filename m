Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5747F27470
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776045006; cv=none; b=OKXydmVCQr8mx9o48zXy2HYfBnWEM8NnpNsriv3LRTps/JyWOdjLvU/fQLsBGCWQ4twPrHkfS7MkfUIqNkmkcIRAtD5OgjABCq1OFsW3rkmP49Y+vpgVdu+A5vY769+VZRhRWPix/Fgmo2yGt/MkHOq7FN5zNoOEauKOkfYuwhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776045006; c=relaxed/simple;
	bh=G3ujmnKH0Mfox1Wdlg9V5GVCf+FOLN3tyn+8Rf+ofX8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j6iCwWY63eBsi16bZ9bqzaMOUBtfPvCF4bENn4AscV/hgyDoSOwz+ge759Ucqi3j+0Q4MuPGeSgRARXOkWF5+5h7mGZOmxX+EED331II58OE7MBwJUDmWmk1BCPbaHli/orZ8SUTsiTz3RJpoW0aEfNnxxCDbImCMkVMLUWqewI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SngOzQpu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SngOzQpu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E15C19424;
	Mon, 13 Apr 2026 01:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776045005;
	bh=G3ujmnKH0Mfox1Wdlg9V5GVCf+FOLN3tyn+8Rf+ofX8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=SngOzQpuERrFOhAhZV98NOuyRKm3fEajKT//qT/dyy/G6Gv6U7nIH+0xEkbFw8Duo
	 /kRJ8XWuZnHfLLWYNHLJGqPJj6/qDz5LSfMDvcUdLEHudXc/TAYtdiFGBcZhz4BUvT
	 37Oeqrkxqe1y0RvlJtN0uubLvHOSCvcenv2942qRFUHQtjV7yzCaPpOlenvBkHKi2M
	 O0rLwx6Yui8nBp1C8RHBL+e6V3cWptGAY2u1c7cHvgNmGyNKi26Qfj/4hUcDINcFes
	 tUosq/5emq9tUnhwTh1MD051M9mqeynRUuuKn+4z6xDMf+Q5ttjj1HxVo1wCnV7wqE
	 kNCa0/Zgu2z7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 26/33] perf kmem: Fix memory leaks on error path and
 when skipping
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413012227.1089445-27-irogers@google.com>
References: <20260413012227.1089445-27-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 01:50:05 +0000
Message-Id: <20260413015005.C2E15C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Integer overflow in gfpcmp() breaks qsort/bsearch strict weak orde=
ring
- [High] Valid but unrecognized GFP flags cause fatal -ENOMEM aborts
--

commit 24b8d3629b127f6af817b78e1ca9d3a0f9e7d9fd
Author: Ian Rogers <irogers@google.com>

perf kmem: Fix memory leaks on error path and when skipping

This commit addresses memory leaks in the perf kmem tool by adding missing
frees for allocated strings and dropping thread references when samples are
skipped. It introduces an err_out label in parse_gfp_flags for cleaner error
handling.

> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> index 68a39f56204db..daf2272c73372 100644
> --- a/tools/perf/builtin-kmem.c
> +++ b/tools/perf/builtin-kmem.c

[ ... ]

> @@ -783,17 +783,21 @@ static int parse_gfp_flags(struct perf_sample *samp=
le, unsigned int gfp_flags)
> =20
>  			new =3D realloc(gfps, (nr_gfps + 1) * sizeof(*gfps));
>  			if (new =3D=3D NULL)
> -				return -ENOMEM;
> +				goto err_out;
> =20
>  			gfps =3D new;
> -			new +=3D nr_gfps++;
> +			new +=3D nr_gfps;
> =20
>  			new->flags =3D gfp_flags;
>  			new->human_readable =3D strdup(str + 10);
> +			if (!new->human_readable)
> +				goto err_out;
>  			new->compact_str =3D compact_gfp_flags(str + 10);
> -			if (!new->human_readable || !new->compact_str)
> -				return -ENOMEM;
> -
> +			if (!new->compact_str) {
> +				free(new->human_readable);
> +				goto err_out;
> +			}

This isn't a new bug introduced by this patch, but does this error path
incorrectly assume a memory allocation failure?

If compact_gfp_flags() encounters a valid but unrecognized GFP flag (such
as a newly added kernel flag not present in gfp_compact_table), it seems
it can return NULL without it being an out of memory condition.

Because the code jumps to err_out and returns -ENOMEM, could this cause the
entire perf kmem session to fatally abort when processing data from newer
kernels?

> +			nr_gfps++;
>  			qsort(gfps, nr_gfps, sizeof(*gfps), gfpcmp);

This is another pre-existing issue, but could this qsort() lead to
out-of-bounds memory accesses?

Looking at gfpcmp(), the subtraction is done using unsigned 32-bit
arithmetic:

static int gfpcmp(const void *a, const void *b)
{
        const struct gfp_flag *fa =3D a;
        const struct gfp_flag *fb =3D b;

        return fa->flags - fb->flags;
}

If fa->flags has the MSB set (e.g. 0x80000000) and fb->flags is 0, the
result is 0x80000000. When implicitly cast to a signed int for the return
value, it becomes a negative number, indicating 0x80000000 is less than 0.
Conversely, fb->flags - fa->flags would also yield a negative value.

Since gfp_flags are parsed from the perf.data file, does this violate the
strict weak ordering requirement of qsort() where cmp(a,b) and cmp(b,a)
must not both be negative?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413012227.1089=
445-1-irogers@google.com?part=3D26
