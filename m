Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888A42F8EB3
	for <linux-perf-users@vger.kernel.org>; Thu,  7 May 2026 23:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778195813; cv=none; b=DcfCaiIa2nfzZ9+5rvtAj/hbRvPqqmh+73wc7LuXQ7CqmIsj1hD+EP0aOZrlKrAryZU/ULrFEqKjd7jbjDP2r/RRep85SOAz+utFo962ys5tJrIZh+8R59dV7YgjfjhUh9meQLXeJ4vQpJPIrv8F4zr0rna9LHs4MOQIpqYUGhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778195813; c=relaxed/simple;
	bh=mVodP7WHmvTu0g/jDW4ald6gvHA9GWGVFPTHFI54A7A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OdcIK8i7OOGUGAIoeFLICIjgoV9PVh5p28keMrI2jS0sFnJqV8DwEyaRlyrtEIwqqTeZFLEYUTId0DUSgYH7MtzzKHltMkqZQXMZGrd70rVrGyZX4ekeJJSd3B/qwR7oldUGvKwvXA+XksV9GrD6UDsGudtLQoejwlZDKK77Z44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/eD/mKa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/eD/mKa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DAFC2BCB2;
	Thu,  7 May 2026 23:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778195813;
	bh=mVodP7WHmvTu0g/jDW4ald6gvHA9GWGVFPTHFI54A7A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=B/eD/mKaUC9n6EBgazPqjFAmxSY/LDHF0dbh4yLR+csq3bOCOlPIs9GkrIUUPsmTx
	 /+dUxV9t7uZ18ioyqTTBSOuNQArwu7tLfFvAz4lt82K7oo8ZpQNF2h04eMFSfrvfqi
	 zY+LzXqi1qsrg94cKr0a3CSi2pBudLxwOP3RRp+havPYCjot4hMB8rl6mEybqrTXhB
	 HU5ealMH1+AqPTtKxTObB8wa4FSOevuWywGnXvuMQrniSNA+vWUObTNvCB07kLO8fK
	 KlwS9Rfx6yM6twG5hMXJOrAU5fJev3nWtMRuLYBzcdqvWo+dmRBWPthszQUMzcTKmP
	 TQLY1EsA0ZCpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] perf record: Refactor ARM64 leaf caller setup out of
 arch
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260507170622.611933-1-irogers@google.com>
References: <20260507170622.611933-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 23:16:52 +0000
Message-Id: <20260507231652.C7DAFC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Orphaned function declaration `arch__add_leaf_frame_record_opts` le=
ft in `tools/perf/util/callchain.h`.
--

commit 9201ab7426a557fd23fbb8e0f9c2a95f023a9477
Author: Ian Rogers <irogers@google.com>

    perf record: Refactor ARM64 leaf caller setup out of arch
   =20
    Code in tools/perf/arch causes portability issues/opaqueness and LTO
    issues due to the use of weak symbols. Move the adding of LR to the
    sample_user_regs into arm64-frame-pointer-unwind-support.c conditional
    on EM_HOST =3D=3D EM_AARCH64.

> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 4a5eba498c025..272bba7f4b9ec 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c

[ ... ]

> @@ -3230,10 +3231,6 @@ static int record__parse_off_cpu_thresh(const stru=
ct option *opt,
>  	return 0;
>  }
> =20
> -void __weak arch__add_leaf_frame_record_opts(struct record_opts *opts __=
maybe_unused)
> -{
> -}
> -

Since the weak definition and usage of arch__add_leaf_frame_record_opts()
are removed in this commit, should its declaration in
tools/perf/util/callchain.h also be removed to avoid leaving an orphaned
function declaration?

tools/perf/util/callchain.h:

[ ... ]
#endif
=20
void arch__add_leaf_frame_record_opts(struct record_opts *opts);
=20
char *callchain_list__sym_name(struct callchain_list *cl,
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507170622.6119=
33-1-irogers@google.com?part=3D1
