Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD108625
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 02:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777773695; cv=none; b=G/sXxrkcv7bGVY68WHRHPejXhX2hIZhfu6ULbWlmcCOvZv2JqaRrgstBRz2PGjCra4X1HGv7V1C/xUip5pM9MDCYj0Ddqcuk/aeGdC1Ke8UssFb5ksfTNw4iO6klvrkO/lb2Uyt05gzUshWqjhOQpCdJo9bIMmRw8GQJl1oI4aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777773695; c=relaxed/simple;
	bh=SS+iGTxgIbRQf9Kee7ygS18qBkF70WwBTAR2S/0z8ws=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BxY1DWXLw3bJ5Vjd39G3Whn3zt2um8e/LFKTBRzS+WyOsyf588sZHHsx0nakjfWxHJ7Fi7i9tiwkqlyDwGe92Viu6WGbZfNUCu4V6cqnbOiNkUdl+F9FaEuoCCoPKN9WGSb7skSKg0Os6Wxgrr3KAzde62pwR1yH0L249U7L/zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZVtghZo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZVtghZo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55565C19425;
	Sun,  3 May 2026 02:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777773695;
	bh=SS+iGTxgIbRQf9Kee7ygS18qBkF70WwBTAR2S/0z8ws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gZVtghZoH5WORkCt/ZkbIVoQ/JlyBhLE/z6lKffdaq/F+PhZpOA+1Bs91PpRfV60m
	 mOLv26dBH6tZ4M03qAkIkyHeoMAndQu//nqYdAaqa+ESYZHHauInd25z1i37ttI5O0
	 FNu1Tp/l641+FvQaXVNb5H/oylXU0PLMnrZ5bZGMFFXzU+y1MUp2fV41vS816uRmAw
	 S1s6rxNIdxQqt74iK28qFEAUvHE0uOt3l1JlYUJvlR+l9E82Cqg2487tmGFAD5tK/l
	 7AHLPrAL79HDrm5zlaqlkj/FN3CN51/DTTJVrsrSLXkjkIYJTAIJkdsWlUlavZeTrI
	 mz6b9LihfjU8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/6] perf debuginfo: Fix libdw API contract
 violations
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260503003552.1063540-7-irogers@google.com>
References: <20260503003552.1063540-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 02:01:34 +0000
Message-Id: <20260503020135.55565C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing O_NONBLOCK in open() can cause indefinite hangs on untrust=
ed paths.
--

commit febe76c541fd0ae3fbecd6102991f4418485f2b8
Author: Ian Rogers <irogers@google.com>

perf debuginfo: Fix libdw API contract violations

This commit adds a return value check for dwfl_report_end() during offline
initialization and validates the result of dwfl_module_relocation_info()
before passing it to strcmp().

> diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
> index 0e35c13abd04..49cb7f9b715d 100644
> --- a/tools/perf/util/debuginfo.c
> +++ b/tools/perf/util/debuginfo.c
> @@ -62,7 +62,8 @@ static int debuginfo__init_offline_dwarf(struct debugin=
fo *dbg,
> =20
>  	dwfl_module_build_id(dbg->mod, &dbg->build_id, &dummy);
> =20

While reviewing this function, I noticed an older issue that pre-dates this
commit. Does the open() call earlier in this function risk an indefinite ha=
ng
if the path refers to a FIFO, device node, or slow network mount?

tools/perf/util/debuginfo.c:debuginfo__init_offline_dwarf() {
        ...
        int fd;

        fd =3D open(path, O_RDONLY);
        if (fd < 0)
                return fd;
        ...
}

Could this path be opened with the O_NONBLOCK flag to prevent hanging on
untrusted special files?

> -	dwfl_report_end(dbg->dwfl, NULL, NULL);
> +	if (dwfl_report_end(dbg->dwfl, NULL, NULL) !=3D 0)
> +		goto error;
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503003552.1063=
540-1-irogers@google.com?part=3D6
