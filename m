Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1174022083
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 00:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778717210; cv=none; b=ZN2CJfjjU6gY554FkRFcgtlsgvP3LSbsVryNYNbeo5cZjOBxlcAVn2NG5/Pc4HW7JBBlDGJZrNGEtkgu5FlcTdX+iWccjNwIAGJ444iLwyUJKQOoHaYOSao73VzETnSDSmqdORocF/MUTtx+K1trIqO8hFYT+h1sDfO4RP8YHVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778717210; c=relaxed/simple;
	bh=ArFAHaaUynJ/I+KJJq4UdsxYKETizYDa3O8l4puGX+4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OPEkqiXjDjW+1vqDjocYXz03Xhw3uA5bbrz/VDwSdAONc+Rp0VUsMRjZieRGnKGMReQR4YUP3mw5CvcM3VP6Bu8+KMSAJ8rHvkVLp/V7f234v1swuJ75glOruBfWpp/pVL91tjpgcH/4HOAYNZ3a+8Nu8f59+i2l4vOl27tfOGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYjcFH+Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYjcFH+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AC2C2BCB3;
	Thu, 14 May 2026 00:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778717209;
	bh=ArFAHaaUynJ/I+KJJq4UdsxYKETizYDa3O8l4puGX+4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=QYjcFH+YXrcaqCHLWaPDqlBJHVbBJkmmW82TEvgyZ+FjW3q3x8kGPo+Tb7TkEETvl
	 MlPypBPAxIMly/YT9oZMo7fLAyY/CWojw9dNQy6uOcrkpFCOMai/j+g6V2eP8J8SH6
	 lC7TcvFoq/aHo+zkjB+IFCfrxlFC0V+CKWYHD51K6Mgw3PsJPKpMdzvMF/XYtQXY3H
	 TrO4XCjGdDt8DUB3chdS69UqMTk1Xf/M7J+SNM275TGbgrqfznTZlLwWcWzhsi1WpF
	 8B1tpsZkV8D98zF9a8m0SQNJoLSnxgJPssgM9cncUwsmwsCT0AgAK9XoLWaBm1o3l0
	 cMWMsYz2iluTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 27/28] perf kwork: Bounds check work->cpu before
 indexing cpus_runtime[]
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260510033424.255812-28-acme@kernel.org>
References: <20260510033424.255812-28-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 00:06:49 +0000
Message-Id: <20260514000649.C7AC2C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch double-counts skipped work entries, artificially infla=
ting the reported warning metric, and introduces dead code.
--

commit 1c5f60cee04ed4d88c1c3eeee79849a9dd16ec72
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf kwork: Bounds check work->cpu before indexing cpus_runtime[]

This commit replaces a signed BUG_ON with an unsigned bounds check to
safely skip processing work entries with invalid CPU values. It guards
accumulators and usage calculations to prevent out-of-bounds accesses on
cpus_runtime[].

> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> index 9d3a4c779a41e..6e124a0f277c8 100644
> --- a/tools/perf/builtin-kwork.c
> +++ b/tools/perf/builtin-kwork.c

[ ... ]

> @@ -2032,6 +2046,12 @@ static void top_calc_irq_runtime(struct perf_kwork=
 *kwork,
>  				 enum kwork_class_type type,
>  				 struct kwork_work *work)
>  {
>  	struct kwork_top_stat *stat =3D &kwork->top_stat;
> =20
> +	/* See comment in top_calc_total_runtime() */
> +	if ((unsigned int)work->cpu >=3D MAX_NR_CPUS) {
> +		stat->nr_skipped_cpu++;
> +		return;
> +	}

Is this bounds check unreachable? top_calc_irq_runtime() is invoked=20
exclusively from top_subtract_irq_runtime(), which retrieves the IRQ=20
task based on the work->cpu provided by top_calc_cpu_usage().=20

Since top_calc_cpu_usage() already skips invalid CPUs before calling the=20
subtraction logic, it seems this code might never be executed.

[ ... ]

> @@ -2084,12 +2104,21 @@ static void top_calc_cpu_usage(struct perf_kwork =
*kwork)
>  		if (work->total_runtime =3D=3D 0)
>  			goto next;
> =20
> +		/* See comment in top_calc_total_runtime() */
> +		if ((unsigned int)work->cpu >=3D MAX_NR_CPUS) {
> +			stat->nr_skipped_cpu++;
> +			goto next;
> +		}

Does this result in double-counting the skipped entries? Both=20
top_calc_total_runtime() and top_calc_cpu_usage() iterate over=20
class->work_root independently.

Because top_calc_total_runtime() also increments stat->nr_skipped_cpu,=20
doing it again here will cause the warning metric reported to the user=20
to be artificially doubled for any invalid nodes with a total_runtime=20
greater than 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260510033424.2558=
12-1-acme@kernel.org?part=3D27
