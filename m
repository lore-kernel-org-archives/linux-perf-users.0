Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2A93A6B76
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 22:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778799251; cv=none; b=cYgZuIVH0gpS1xli0PgR2hVxdPX5oypXioTHbzh1WWdjnGeXGMvygPM5OK5Oan4OhofL8Udt0j4kj81bjX1MYIYf6SlgV5Szdr/DcPC7t5V/ifZzv58g33bl224GToOuE0mgfr4Cb/HpnxWdcBvUudnnG0rZ1YnXRHP2N3NPFkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778799251; c=relaxed/simple;
	bh=lN7zoIs3HX6r8iFkyEPuCLQG6+Xt3qYVUq1qcNPIhXE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jqa8kKvsyckkoVGD+mqXFaumkEYqAv4n/f76xgBZrlKb53xiaMW4LWu0uUvNWJq0s/2naHm13Caw4/ALGeGaj+3Mj6uZrbHnBgbe1w5viHZRNtF17rol6YhI1HZ9M7ObCYVc46VrfClOy8JKRRxbe1xYkk2nWH9e6f9dXnpOnz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hE4jowxQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hE4jowxQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F48C2BCB3;
	Thu, 14 May 2026 22:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778799250;
	bh=lN7zoIs3HX6r8iFkyEPuCLQG6+Xt3qYVUq1qcNPIhXE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hE4jowxQzD8V43fshlCzxv9RWETeZgWlyR7pu/3wI0VgIJGLB6QqJcEDa8QWJhk55
	 s5x2ycz6sqVgf2uWtatH26IWfUVdVn8EE2Vcs0kFMkIVS3/ejrM7f+webvTDYH4vhs
	 ex+smRgrtnhdpMHGOriul0yqYxqTxSFysZgyvLCOP2c8cqntHy93w4PzMvSVDGmTzq
	 gwcW/ovS0BcBOZnuFuAVy7IKpN0b7W3Sxdih6QScS6ZOWfKxl7LGPr2YfoN6Evtz0q
	 6NLBr3pcnvaE/SoYxg/guSz4QHFHpCc+eHJt62WBhSRhqe8aIcDUsYm5OqIkKjWb25
	 xIp12IZeCyjCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 23/32] perf lock: Avoid segv if event is missing a
 callchain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260512223001.2952848-24-irogers@google.com>
References: <20260512223001.2952848-24-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 22:54:10 +0000
Message-Id: <20260514225410.C8F48C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Conflation of missing callchain with memory allocation failure c=
auses silent data dropping on Out-Of-Memory (OOM) conditions.
--

commit f504fc10b092b537bc4ca117f60f6a8aafd36f27
Author: Ian Rogers <irogers@google.com>

perf lock: Avoid segv if event is missing a callchain

This commit avoids a potential segmentation fault by checking if a sample's
callchain is missing before accessing it. If it is missing, the event is
skipped rather than failing the entire file processing.

> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -938,9 +938,16 @@ static u64 *get_callstack(struct perf_sample *sample=
, int max_stack)
>  	u64 i;
>  	int c;
> =20
> +	if (!sample->callchain) {
> +		pr_debug("Sample unexpectedly missing callchain\n");
> +		return NULL;
> +	}
> +
>  	callstack =3D calloc(max_stack, sizeof(*callstack));
> -	if (callstack =3D=3D NULL)
> +	if (callstack =3D=3D NULL) {
> +		pr_debug("Failed to allocate callstack\n");
>  		return NULL;
> +	}

[ ... ]

> @@ -1059,7 +1066,7 @@ static int report_lock_contention_begin_event(struc=
t perf_sample *sample)
>  	if (needs_callstack()) {
>  		u64 *callstack =3D get_callstack(sample, max_stack_depth);
>  		if (callstack =3D=3D NULL)
> -			return -ENOMEM;
> +			return 0;

Does this change silently hide memory allocation failures?

By returning 0 here, both a malformed event (missing callchain) and an
actual memory allocation failure in get_callstack() are treated the same
way.

While skipping a malformed event makes sense, ignoring a calloc() failure
might lead to silently truncated and statistically invalid profile reports
without notifying the user of the memory exhaustion. Other allocations in
this function, such as thread_stat_findnew() and lock_stat_findnew(),
still correctly return -ENOMEM on failure.

Should get_callstack() perhaps return an error pointer or a specific error
code like -ENODATA for the missing callchain so the caller can distinguish
it from -ENOMEM?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512223001.2952=
848-1-irogers@google.com?part=3D23
