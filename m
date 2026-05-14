Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E642DECCB
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 23:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778801558; cv=none; b=jBU/JpklZUKnxCXRd8+2wZphwHdn/ksznj3hMradDrzotFpY1zaGkTiTchzHWPA4W9pmA11slTx/9GrBG3JyxWjCOoT613n31hbARP79wsMvrG4Km1mSvubtuRSSlyuY0znO/f7oN07euQkb1vNTrQMDV55UzCoBMC2uz8qLL6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778801558; c=relaxed/simple;
	bh=M9bCEl5+NRBP0M9kovklfEDDTOVc0WXeYYWdrdaYuDQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=URMuGw+AtmfjxKs1+MsUgXqI6FV3OiZkGKwdNMst7tWsFnruw5w69ibBSJVOibPSNDwULXjH1Ao2+ikpOUszzkygPFMnmuwUJin81905D53ST1wUu0aE+w52mtsGc86TdAjPyRLSjHKQN0OLsY8jSE/GOarvO+HkjuWFamzwly0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5ssKN47; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5ssKN47"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F13C2BCB3;
	Thu, 14 May 2026 23:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778801558;
	bh=M9bCEl5+NRBP0M9kovklfEDDTOVc0WXeYYWdrdaYuDQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=t5ssKN47D5FT6NtEsZgBMZeLGUSZGVrMwobTe4I8Af7c27kojOdnT2+q8yCkPAgBD
	 ph+mrkyH909ZA1awC59kVAGtRbfOnTjMyURRU1Xqy+PMi44Oq4GxFbghVhpllNcyDB
	 6GkSvZRVFZD66GTZ4Vb0g8Hsshd1nHaA2WrefQX3eUhciBBJBxXnxpWsUFf0h+ri98
	 Z5WWtoCs1soBMpCrsEYP+rEfRJ+pAmlgKQY7wIqw2D/eJtXmejLK3lK99ZRxBut1Mn
	 No6lfHElUbPpSIt6NqtFwwGPGYg9pe99MC3Mndsz2ecdAvCoHrO+f2B+ZnfSvsyWSa
	 KsehkCwol0YbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 25/32] perf kmem: Fix memory leaks on error path and
 when skipping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260512223001.2952848-26-irogers@google.com>
References: <20260512223001.2952848-26-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 23:32:37 +0000
Message-Id: <20260514233238.02F13C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `gfpcmp` comparison function incorrectly uses integer subtract=
ion to compare `unsigned int` values, causing an integer overflow that brea=
ks strict weak ordering and can lead to out-of-bounds memory accesses in `q=
sort`.
--

commit 1006731707bc30050fb3b9abfb99177a6ebad414
Author: Ian Rogers <irogers@google.com>

perf kmem: Fix memory leaks on error path and when skipping

This commit fixes memory leaks on error paths in parse_gfp_flags and adds
missing thread__put calls when skipping samples.

> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> index 68a39f56204db..daf2272c73372 100644
> --- a/tools/perf/builtin-kmem.c
> +++ b/tools/perf/builtin-kmem.c
> @@ -783,17 +783,21 @@ static int parse_gfp_flags(struct perf_sample *samp=
le, unsigned int gfp_flags)

[ ... ]

>  			new->compact_str =3D compact_gfp_flags(str + 10);
> -			if (!new->human_readable || !new->compact_str)
> -				return -ENOMEM;
> -
> +			if (!new->compact_str) {
> +				free(new->human_readable);
> +				goto err_out;
> +			}
> +			nr_gfps++;
>  			qsort(gfps, nr_gfps, sizeof(*gfps), gfpcmp);

Could the qsort call lead to an out-of-bounds memory access?

While not introduced by this patch, the gfpcmp function appears to compare
unsigned int flags using integer subtraction: fa->flags - fb->flags.

Since the flags are an unsigned 32-bit integer and the return type is signe=
d,
a difference of exactly 0x80000000 results in -2147483648 for both
directions of the comparison.

Because both gfpcmp(A, B) < 0 and gfpcmp(B, A) < 0, this violates the strict
weak ordering requirement of qsort.

Since gfp_flags is extracted from trace data via perf_sample__intval(),
could a trace file supplying specific flag differences cause qsort pointers
to walk past the array boundaries?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512223001.2952=
848-1-irogers@google.com?part=3D25
