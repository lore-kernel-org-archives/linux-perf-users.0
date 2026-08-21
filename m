Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAB046F4B4
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306667; cv=none; b=fmKEpLfalEykoHrjc9gQUP5nrkiTnCjg6c8LSWstqZXTZYbPfboIsF3IPt8OKcRwIbHAY3CbcnRUWKITwHgc8UmhxK0NqYkTcuNvPi8t/PNl+vU7ah2/WN219MJr6ptWdEqsPrZTT4OZmcmYRA+a01FC5hHzB30wJkHWxmmavps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306667; c=relaxed/simple;
	bh=25k2JrOu3SFnCkQMJHhCOzkOUkDtFWGNnkzdsx0HafM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=trhb/hUltiMJXeL/FytOFkygJdvXNQJvOJFCbWbcvydsb0xz7Zglcgp85i8sRtqm0DL4vII4tjBFtIATjAKVgqnanMZgCimQLNH7n5FGj9h7UZuQmpBp9DVIi3qI6Erh0XBD193lQJniXKpoZXBRYK6qnW07l3OoCYyoVVTlEEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ex78/3Bn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ex78/3Bn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF5C1F00AC4;
	Fri, 21 Aug 2026 10:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787306655;
	bh=aeR/1IB0Uxj9T5ddfjEqkq5fGdvN968VmBNQWGIPNQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ex78/3Bnedg5n0+i6troFF+qM4Md0LqjtdPnr7X9D+e9G2QTLv3HO5cxMI8zHMxHn
	 VUVU5hPI6NoBzUZjBtU9OJ2CQMbotUf+LqAFQMoUQ9gs7qO57KDWKiiN8be2/gePT6
	 6iiUA+gZkxsXLB3yBVrfLTnXHel9+IKkPeKND3wE3wN6r+M8+1mnC7oY6hB45KI1O5
	 Ic/yqCpN+OuXAPYSaPE+UTe7B68YeIxbxdnOTwssP+uV/1xIjWKRvl1SzPaCL5tnhA
	 Qudr/Q5SNJlqLCtxtnqZ7L3UWOPBlWP/itZqk7/iwY5nYmgVKuA9bRS6T6BNOC7Iv/
	 IdMM+rQW0PtgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/14] perf cs-etm: Use per-CPU queues for per-thread
 mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821-james-cs-unformatted-per-thread-fix-v2-4-00c4fd0701b4@linaro.org>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
 <20260821-james-cs-unformatted-per-thread-fix-v2-4-00c4fd0701b4@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 10:04:14 +0000
Message-Id: <20260821100415.4CF5C1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing memory allocation failure checks for `cs_etm__etmq_get_t=
raceid_queue()` and `machine__findnew_thread()` lead to NULL pointer derefe=
rences.
--

--- Patch [4]: [PATCH v2 04/14] perf cs-etm: Use per-CPU queues for per-thr=
ead mode ---
commit 71df2b2d43e19498295801b34c498fd510d905f6
Author: James Clark <james.clark@linaro.org>

perf cs-etm: Use per-CPU queues for per-thread mode

This commit updates the cs-etm decoder to support multiple threads in
per-thread mode by using a queue for each CPU. It also prevents an
assertion failure caused by all hardware IDs being pushed into queue 0
when a thread migrates across CPUs.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index d423f1cb408fa..ccf886efff952 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c

[ ... ]

> @@ -2188,6 +2186,27 @@ static int cs_etm__get_data_block(struct cs_etm_qu=
eue *etmq)
>  	 */
>  	cs_etm__flush_all_stack(etmq);
> =20
> +	/*
> +	 * Per-thread mode still uses a queue for each CPU, but that CPU can run
> +	 * different threads. When the TID from the AUX record on a CPU changes,
> +	 * re-initialize the thread using the AUX record/buffer fragment TID so
> +	 * we can start decoding even if the context ID packet was cropped or
> +	 * they're disabled.
> +	 */
> +	if (etm->per_thread_decoding) {
> +		struct cs_etm_traceid_queue *tidq =3D cs_etm__etmq_get_traceid_queue(e=
tmq,
> +							CS_ETM_PER_THREAD_TRACEID);
> +
> +		if (thread__tid(tidq->decode_thread) !=3D etmq->buffer->tid) {

[Severity: Medium]
What happens if cs_etm__etmq_get_traceid_queue() returns NULL due to an
allocation failure? Other callers check for a NULL return, but here tidq
is dereferenced immediately. Should there be a check before accessing
tidq->decode_thread?

> +			thread__zput(tidq->frontend_thread);
> +			thread__zput(tidq->decode_thread);
> +			tidq->frontend_thread =3D machine__findnew_thread(&etm->session->mach=
ines.host,
> +									-1, etmq->buffer->tid);
> +			tidq->decode_thread =3D machine__findnew_thread(&etm->session->machin=
es.host,
> +								      -1, etmq->buffer->tid);

[Severity: Medium]
Can machine__findnew_thread() fail and return NULL? If so, the returned
values are assigned directly to the thread pointers and would be blindly
dereferenced on subsequent block iterations when thread__tid() is called.

Does this code need to handle thread allocation failures?

> +		}
> +	}
> +
>  	return 1;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-james-cs-u=
nformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org?part=3D4
