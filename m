Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBFA218EB1
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777891981; cv=none; b=iX3yTCN76ULuDcZGLn/6Xqk41+jIK53l/3cANHTOZrCn5nQbTe02wmAFKUhIdOSdTih3PymYjLVr0LlKEcyt4Xhdhia058S01JMrW1nCExv1SjhYtM4o4vfcjdsn+N+gS7yH/y1JEDJV4Y4en/v4IKlj+koKtFtEQ/qYvOhiIL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777891981; c=relaxed/simple;
	bh=zLs1Al8g1yiVctExHCknkfkOvKbEebj5WO8MsE1+cHs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DX0aQMkxoJPR+u0HOzSfCV3tay2Mwtd9cIaEXjH6Y/nL07r5ogSO8qZkyiVROq1JOUlfPs1LBDa+iZMI/n6DyyxoISxANv9VZFwpNvxgRA+k/oi82/D5A2v6g3SK985jPfx6oMvHIwQkVRZVieBxwc2clLBemKk6aqvurzIX5Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pq4nXuGa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pq4nXuGa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29676C2BCB8;
	Mon,  4 May 2026 10:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777891981;
	bh=zLs1Al8g1yiVctExHCknkfkOvKbEebj5WO8MsE1+cHs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Pq4nXuGaHWgxIlOcbKoJE/mi6cGswqrD/4+uydvHNPBPNubGeW2hQOYu3/OE9/mv6
	 YQ7hpghHF0EoSiypFvz4MwzBUescOKbg0OoOed9NQcGPnH12V4+NOOfttqPVPg9MjZ
	 yqdViel3xr50KbAgT8AnJXcikx94Ii1IY1U+l9ZO1n+Di1mZ0adhefBxeMqX/Mj5LF
	 f1+9SXQLRZW2Mo99aKBBOqS10vGDa/AQLDA/hdV6bcyZdnbWmtLfbYLREldcmjsEcN
	 hTOy8bHO4lQBXTf2fi8sbiTXmR2LEpQzMhr5CZ5eEX1yAaAKRqGN2XI/ShgFLY2f3c
	 IB2P9IeZB1JVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 9/9] perf debuginfo: Fix libdw API contract
 violations
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260504081227.2203848-10-irogers@google.com>
References: <20260504081227.2203848-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 10:53:00 +0000
Message-Id: <20260504105301.29676C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] This problem wasn't introduced by this patch, but the open() c=
all in debuginfo__init_offline_dwarf() lacks the O_NONBLOCK flag, exposing =
a local Denial of Service (DoS) vulnerability.
--

commit a6e339ae66465b909762a437f958cdaed424b666
Author: Ian Rogers <irogers@google.com>

perf debuginfo: Fix libdw API contract violations

This commit adds return value checks for dwfl_report_end and
dwfl_module_relocation_info to prevent potential segmentation faults. It al=
so
fixes a file descriptor leak in the error path of
debuginfo__init_offline_dwarf() when offline initialization fails.

> diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
> index 0e35c13abd04..84a78b30ceac 100644
> --- a/tools/perf/util/debuginfo.c
> +++ b/tools/perf/util/debuginfo.c
> @@ -42,6 +42,7 @@ static int debuginfo__init_offline_dwarf(struct debugin=
fo *dbg,
>  {
>  	GElf_Addr dummy;
>  	int fd;
> +	bool fd_consumed =3D false;
> =20
>  	fd =3D open(path, O_RDONLY);

While this wasn't introduced by this patch, could this open() call cause a
regression by hanging on a FIFO?

If the path originates from user-controlled sources, opening it without
O_NONBLOCK can cause the perf record session to hang indefinitely. Using
O_RDONLY | O_NONBLOCK would prevent this.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504081227.2203=
848-1-irogers@google.com?part=3D9
