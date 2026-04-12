Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53A514A8B
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 02:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775960995; cv=none; b=qPd+sWx10IdKVel9snsESqcMfYf2Qd4iM5haUabq9Rxn5XuHDTeMA+1R8l66dVM0lPxbEBcbmhe2HQJ/8/hzbGRLeju7pzObHGp3BABMvVVGahAIEW0XjCuRZmHKHT4ktjcHJRwQ94++NzhbcBu/JuJQnYihnq5t5oOvButUhY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775960995; c=relaxed/simple;
	bh=ku60EIGUdvnbRDw8EDKKB9siOmW9+FiGC6H6Bkp0NUU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dQ8CCrGaKBdFDygMiEhqnUG0VRVnX4n9OtJ35ZkRix3z2JmzL6gYj6RGllWHJjerrg/yb91EsGlaDJ0UI4YEgdMjzqTCc4Y8dBDOYHi+5bDT/nzXG8PE7YQ7QTRu5s2KIkgIEcwGTw1siIlItoSZp3BKpkexCCSbYaIfmUnKwd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MySoSs2r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MySoSs2r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E3DC116C6;
	Sun, 12 Apr 2026 02:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775960994;
	bh=ku60EIGUdvnbRDw8EDKKB9siOmW9+FiGC6H6Bkp0NUU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=MySoSs2rTYGbHY7KwagsSMcazhlPZ8C5Uv1kwenJAmVOKmMZ/bon9IJy4QwFR3BHo
	 eYzSIkXFIS7g5Q6EIrhZES2lXuW+TnpEPPCaAxpQf6VRzRZ88iPfC/mpzVOXhplTFZ
	 9IjjoHdaSgfBmIvpP0x/PAp1FuUe6n6PIIvF+3KsRBWo7IF669bOEBd9Q52DqFlsKL
	 5hBh9bLNtosEvOlF679SQS07EVJ/pm336f7VtNRfXL27m+g04f1+Cbk2D+YFE6z0eF
	 eonGkHXG+b/fpN2pPyx9U61z5hqb3ZEE1/Y19HcFQcd6A4Hq4tFCwWROAnJ92FkFBS
	 ROUsTQJPLORww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 24/29] perf kmem: Add bounds checks to tracepoint
 read values
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260412020833.641177-25-irogers@google.com>
References: <20260412020833.641177-25-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Apr 2026 02:29:53 +0000
Message-Id: <20260412022954.61E3DC116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Returning -1 for page orders >=3D MAX_PAGE_ORDER abruptly aborts=
 the perf session, breaking `perf kmem` for valid traces from architectures=
 with larger page orders.
--

commit 343c06e69ee85027cceea5dae68c1cbbcd37a663
Author: Ian Rogers <irogers@google.com>

perf kmem: Add bounds checks to tracepoint read values

This commit adds bounds checking for order and migrate_type in
page_alloc_event and page_free_event to avoid out-of-bounds memory accesses.

> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> index daf2272c73372..33585e353efe5 100644
> --- a/tools/perf/builtin-kmem.c
> +++ b/tools/perf/builtin-kmem.c
> @@ -826,6 +826,16 @@ static int evsel__process_page_alloc_event(struct pe=
rf_sample *sample)
>  		.migrate_type =3D migrate_type,
>  	};
> =20
> +	if (order >=3D MAX_PAGE_ORDER) {
> +		pr_debug("Out-of-bounds order %u\n", order);
> +		return -1;
> +	}

Is returning -1 the desired behavior here?

MAX_PAGE_ORDER is hardcoded to 11 in tools/perf/builtin-kmem.c. However,
several architectures legitimately support larger maximum page orders. For
instance, ARM64 with 64K pages defaults to ARCH_FORCE_MAX_ORDER =3D 13,
meaning valid traces can contain allocation events with order >=3D 11.

Returning a negative value from an event callback causes
perf_session__process_events() to stop processing and abort the entire
session. This prevents the out-of-bounds array access but makes perf kmem
completely unusable for valid traces from these architectures.

Would it be better to return 0 to simply skip the unprocessable event
without aborting the entire parsing session?

[ ... ]

> @@ -892,6 +902,11 @@ static int evsel__process_page_free_event(struct per=
f_sample *sample)
>  		.order =3D order,
>  	};
> =20
> +	if (order >=3D MAX_PAGE_ORDER) {
> +		pr_debug("Out-of-bounds order %u\n", order);
> +		return -1;
> +	}

Does this have the same issue as above where returning -1 aborts the
session for valid traces with higher page orders?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260412020833.6411=
77-1-irogers@google.com?part=3D24
