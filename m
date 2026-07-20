Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F9C3E172E
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 10:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542517; cv=none; b=dvAf0PofgsZ0NN9PnjhUGx8grxUjwebs6I4i0+hOjahY0sUkiAmXTxywRi5/aoS0m4Sb21JCBme8cl9vfZ+QqjhdffaSuGi4n4GQ7D6seYMc7ph4S5420ZepRaVMpZlN+M54q+JoxBTh3AoYVzCoHpPgcLjW4w4939WtGydW1QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542517; c=relaxed/simple;
	bh=ITi3I3Vv3Dw98B3Fg0SnUdF7WXtja/qzpBj4yzDpq5g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ln1oS6IHNszuV2hQceUXZ/P4tFQmANBkn+au9yyTKUPwGcm7v/RUAxS49RHbRxM9n450y7EyugD2lEFAqvbfzCMVeqoBGhFoqKcbFm3TKp0/oXBRJ/+k22V9r0JnAb/KACvUgkuNFjPQB7+DJ4UWcpNEoqofIdeXZSCiyRlANBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IejFtyEO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IejFtyEO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B052E1F00A3A;
	Mon, 20 Jul 2026 10:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784542502;
	bh=t8IbVYh15JS44ED2ZGKVqXkaGIHWx+yZN/mJCWkSIBI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IejFtyEOGjGdyZcVN34c/tuN5CFJmNDhkZ4NZfhB8HAG2Qs9Zi8Bx4rFV/YzGvro4
	 kIeoxBDYUCEkMD1J8NnfmZiZCSCxCii1zw1GkfL4n+wXe6L3/1CJ9YGY1GMiMEFKnW
	 NpP302H6mh+qNr/sSv70kksZumxxe+p8hNzyTjT4jFJJckE9huS4TZ0I5jxcMZ06e1
	 slLRsRo8jo5Lae/CYL9u6iX6e9XtdTeKKD0dgujzAwW9rdRkZH6GkUUoTQGyzNT//1
	 rbq/Uhfi7ZfirliY/B5OgjqiHVxMCgbem1RtnweygGkZFupz8LlH75NFX7/0LVXAOn
	 mXvdkmc3kgGZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf cs-etm: Avoid truncating AUX buffer sizes to int
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260720-perf_cs_etm_fix_big_size-v1-1-97ded24636b1@arm.com>
References: <20260720-perf_cs_etm_fix_big_size-v1-1-97ded24636b1@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 10:15:02 +0000
Message-Id: <20260720101502.B052E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Integer truncation leading to infinite loop (DoS) in cs-etm deco=
der for AUX trace blocks >=3D 4GB.
--

--- Patch [1]: [PATCH] perf cs-etm: Avoid truncating AUX buffer sizes to in=
t ---
commit 1f84d1046e544ee9b629c80e55d031135982e6db
Author: Leo Yan <leo.yan@arm.com>

perf cs-etm: Avoid truncating AUX buffer sizes to int

This commit prevents truncation of large AUX buffer sizes when returning
them from cs_etm__get_trace(). Instead of returning the buffer length as
an int, which can overflow for sizes over 2GB, the function now returns 0
on success and uses etmq->buf_len to track the size. The caller
cs_etm__get_data_block() is updated to return 1 when data is available.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 95e3ec1171acc..114b3cd2da495 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1467,8 +1467,7 @@ cs_etm__get_trace(struct cs_etm_queue *etmq)
>  	etmq->buf_used =3D 0;
>  	etmq->buf_len =3D aux_buffer->size;
>  	etmq->buf =3D aux_buffer->data;
> -
> -	return etmq->buf_len;
> +	return 0;
>  }

[Severity: Medium]
This is a pre-existing issue, but since we are fixing buffer size
truncations for large AUX trace blocks, should we also address the
truncation in cs_etm_decoder__process_data_block()?

When an AUX trace block size is 4GB or larger, etmq->buf_len (a 64-bit
size_t) is eventually passed down to cs_etm_decoder__process_data_block()
as the len parameter. In tools/perf/util/cs-etm-decoder/cs-etm-decoder.c:

		} else if (OCSD_DATA_RESP_IS_CONT(prev_return)) {
			cur =3D ocsd_dt_process_data(decoder->dcd_tree,
						   OCSD_OP_DATA,
						   indx + processed,
						   len - processed,
						   &buf[processed],
						   &count);
			processed +=3D count;

The OpenCSD library function ocsd_dt_process_data() uses a 32-bit integer
for the buffer size. The expression len - processed is implicitly
truncated to a 32-bit integer.

If len - processed is exactly a multiple of 4GB (or reaches a multiple
of 4GB during processing), the truncated size becomes 0. This instructs
ocsd_dt_process_data() to process 0 bytes, returning count =3D 0.

Since processed does not increase, could this result in an infinite loop
when processing large or maliciously crafted perf.data files?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-perf_cs_et=
m_fix_big_size-v1-1-97ded24636b1@arm.com?part=3D1
