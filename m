Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE00639EF23
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775637539; cv=none; b=NQea4YJg5PyBoAbswvFrNVmvIEID9jlZ97OUvWyuiD6GfuDU7ATbzXhrXCx8Upakh3IhIMh9OZrnRnPzPvPGEUGK02DSq6UKF/MgMZF9rzkHgN1jFR5Gbf3wBlMKY54FbigxLu9FrXGSSH2SvVbWOmnOQ275RbPTK+CX/aN9bL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775637539; c=relaxed/simple;
	bh=7qXV1/Ahy0q0BdLNzLz/mR5r8J5+n1FVs/IhLlLM6/k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M1upD7zmHx6FDAU5yhmf+G+Oub4mnGUojV99s9kGT5wUFyBBT4MJC20sm8xw+FQkZrnrZrumQzTnp8/1uL4O7bG2tRrTcMc+Vjn+P+J8ArW1i3bRyVrBSfFT8HKe1KOnWWR6fmSuY2qVkH0FOtoPKvRwSHhxqgZEnMTdZ2F6ODk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkmcZ/bX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkmcZ/bX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B80C19424;
	Wed,  8 Apr 2026 08:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775637539;
	bh=7qXV1/Ahy0q0BdLNzLz/mR5r8J5+n1FVs/IhLlLM6/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=IkmcZ/bX/igMNdfw1qFHFo4zP+CJjmE51hkqvOlQwkj+fIq0XvJc63wKgojHcDmQ7
	 aHWMI4yR1wBHaTZ+3ZVnqPo3fOcaKUPYF6ZEah2uXD9zA2rPtg0OUo6hlVAcywJ5Ji
	 5nWgoPXb8UWcspDRNTM5XTh48OgluuKhWhpRJud8qiHJvoMlmTS5oVnqfIRlvjr8xD
	 pICx3/y33Ytq/WCCY08lZA2Aruh6AyA2xXVTs2hi6rsrBB+BPOTOQuL2j8tzpvorrr
	 gjXiKZow36ro+YVoCNjtx28EOGOzG3CMwctctA68IYpC/KsU6QQdpALGbrBOtSInby
	 MJ1bCFX+7pp0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/23] perf lock: Only pass sample to handlers
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260408072601.210837-8-irogers@google.com>
References: <20260408072601.210837-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Apr 2026 08:38:58 +0000
Message-Id: <20260408083859.66B80C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Returning `NULL` for missing callchain in `get_callstack()` caus=
es the caller to incorrectly interpret it as an out-of-memory error and abo=
rt the `perf` session.
--

commit b0949e285b802619269396d6a3f7ff0f978d93cd
Author: Ian Rogers <irogers@google.com>

perf lock: Only pass sample to handlers

The evsel is within the sample and so only the sample needs to be
passed. Remove the parameter and fix call site. Add an additional NULL
check in get_callstack.

> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index e2b585e528aca..8ccb64415d3ba 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
[ ... ]
> @@ -948,6 +938,9 @@ static u64 *get_callstack(struct perf_sample *sample,=
 int max_stack)
>  	u64 i;
>  	int c;
> =20
> +	if (!sample->callchain)
> +		return NULL;
> +
>  	callstack =3D calloc(max_stack, sizeof(*callstack));
>  	if (callstack =3D=3D NULL)
>  		return NULL;

Does returning NULL here introduce a regression where the perf session
unexpectedly aborts with an out-of-memory error?

If a missing callchain is legitimately encountered (e.g. if the user
recorded lock tracepoints without -g), get_callstack() returns NULL.

The caller in report_lock_contention_begin_event() interprets this as an
allocation failure:

	if (needs_callstack()) {
		u64 *callstack =3D get_callstack(sample, max_stack_depth);
		if (callstack =3D=3D NULL)
			return -ENOMEM;
		...
	}

Would it be better to differentiate between a missing callchain and a genui=
ne
memory allocation failure to prevent the parsing loop from fatally aborting?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408072601.2108=
37-1-irogers@google.com?part=3D7
