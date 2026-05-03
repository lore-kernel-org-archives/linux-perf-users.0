Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0323D1E4AF
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 00:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777769289; cv=none; b=pZAVm/m/z+3YWMlPDyYWewtPcVKRJIeeQIDs4h0N2FtJbUHG7PG3LVDXfZsRMQmjHGBFgkdlgx4MkDv9NUajfqJSEiA3bpIQCAdDaQIJaMjOTw5ghzEOk9/ZByrGU7sa69nEYiVZKu3UP2doUlS/2sixKog59+xgHmFn7VVH2RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777769289; c=relaxed/simple;
	bh=K3fYkyTaoX4bjSOQp8hjPt33Tzj6CD6OqAg6XeLTdFE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CY4u6AnyAopXtExORxIYg0UBnHTizkxaA39ZdUhygzo0INYm5lTK0gX2PI+UioOKfbXgEb2rH4nuzcosfKERaHu2++SCBumIGaXkQFdZznEuBQzFFwLApo4YzuuNNQ+BtL9XZplv9e2cW0mXnJJya++fbbVHELfrv57QIeyxU6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9t45Hke; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9t45Hke"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B596BC19425;
	Sun,  3 May 2026 00:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777769288;
	bh=K3fYkyTaoX4bjSOQp8hjPt33Tzj6CD6OqAg6XeLTdFE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Y9t45HkerR9hNTuxBjkoMmXag0CGY41x1Rk5vZdhn89nMwIbte3LD59pDbETugYT6
	 1kJyjrUiCW8WtWpA8SyXd6OLJ64Hm3p0xKvooiwB5ckxhAXoD7ueAlRdRz2amgFdJJ
	 Gvo8l3xxqtn9gnUrOvD/tUhB+7r4XomqSml+zhhSMPBUf6PMqYQ/AV7wOduBrK6IrM
	 Dnt6XasHOlr8+LiN8jCAXzxuLtCHC1VUp1roy8S12juPLJB/wDCDVW34YGrkWSYYVZ
	 hC3WMXCO3LBoZ1XHHYMHn8q67yd+KqlnGGKPUkkLQYz2/6iirZAxwPDfoVEmlnB0uQ
	 SbRvIOse0tJTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/6] perf dwarf-aux: Fix libdw segmentation fault in
 cu_walk_functions_at
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260503003552.1063540-2-irogers@google.com>
References: <20260503003552.1063540-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 00:48:08 +0000
Message-Id: <20260503004808.B596BC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Bogus parameter `@dbg` added to kernel-doc for `die_find_realfunc`.
--

commit 3f417cdb8c6fb98d5939fd0f506ef04fca29beeb
Author: Ian Rogers <irogers@google.com>

perf dwarf-aux: Fix libdw segmentation fault in cu_walk_functions_at

This commit fixes a segmentation fault in libdw when running perf kmem. It
corrects the error handling for dwarf_getfuncs in die_find_realfunc and
die_find_tailfunc to properly catch the error condition.

> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c

[ ... ]

> @@ -647,6 +646,7 @@ static int __die_search_func_cb(Dwarf_Die *fn_die, vo=
id *data)
>   * die_find_realfunc - Search a non-inlined function at given address
>   * @cu_die: a CU DIE which including @addr
>   * @addr: target address
> + * @dbg: Dwarf session

This isn't a bug, but the dbg parameter is not actually part of the function
signature for die_find_realfunc. Will this trigger an excess function
parameter warning during kernel-doc builds?

>   * @die_mem: a buffer for result DIE
>   *
>   * Search a non-inlined function DIE which includes @addr. Stores the

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503003552.1063=
540-1-irogers@google.com?part=3D1
