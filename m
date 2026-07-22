Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E4C1F4CB3
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784721014; cv=none; b=VI6nXI/tm+Wc9RN1TuGsaO5SOedytuACwWkUp1dmjUt0w76Uor+yMqBFTtaMNBHnrhbzybKcvSw5rTxQCNfta+H7G46bIqGNgc4cNn4T9L2ESr1O6OB5GT3L3hceLO5+SpvirClMlyvUi1E0jgzR9ipBUVmk6URkELUDmf/m9m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784721014; c=relaxed/simple;
	bh=eweQVpfuK+YfkMn9F8w3PLqfGEh9q8a2ARXpbiput4w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qci4RPCS4e2e46MWbzWfv3hJm1/CJheppmvhOAyL4bSeAN2V140WciUhUshBbZS3TV0v6XD4LK2jY+KMUvD9deFJf0oOheAMaoqGJpNFZXX5gHdSskpbBK7mIWXaWGoTlSqfAhkMKXmo2f1rZGXH8MbErvbkjkZsK+3RbR9eOJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GC6kHaGD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GC6kHaGD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10D41F000E9;
	Wed, 22 Jul 2026 11:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784721013;
	bh=MMLOAsCSamS80L34j4k2n/7JBOmoZlaeKBIQaOjMw6s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GC6kHaGDQQQE+ERtXQH08xFRBKGaas/cZkBore4pQuGCnbLlhFpxe8Ap/E2LlzjQR
	 kRAT4A8RI34ec8n+kEofEjqUbA5kLMolQHZsS1+ZOALRu5N/SMkZ1E1rFMepJ9nQSi
	 P9G3wlJ2x0sgp60O4RNUOCtxenrnGM0Zs/pgOu1iHYFuI9OduWL93wsC/RGMT7UPXO
	 P7pAzCTMbzvbrJfwGuwox9IkyDP3ijbrSChImzn57Uq7md645WF3fC7Aa32rhYMS89
	 Ax+iMjEw0inmdxbXX1to5IKv5jsX6Lzx4QvkRFQiAC8iQ0rLsqKI/aB7u/pXDlVMTR
	 VOBwBf+cxo0LA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf trace-event: Fix buffer overflow in read_string()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tanushree Shah" <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260722113552.191143-3-tshah@linux.ibm.com>
References: <20260722113552.191143-3-tshah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 11:50:12 +0000
Message-Id: <20260722115012.E10D41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but integer truncati=
on when passing a 64-bit size to a 32-bit `do_read` parameter leads to out-=
of-bounds reads or massive uninitialized memory parsing.
--

--- Patch [1]: [PATCH] perf trace-event: Fix buffer overflow in read_string=
() ---
commit fd2c84f48dc9adf4455bf50d97942d8f87743ab3
Author: Tanushree Shah <tshah@linux.ibm.com>

perf trace-event: Fix buffer overflow in read_string()

This patch adds a bounds check to read_string() before writing to the buffe=
r.
It ensures that the size does not exceed the bounds of buf, preventing a
buffer overflow when processing trace events.

> diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-e=
vent-read.c
> index ecbbb93f01853..afd458cf1387d 100644
> --- a/tools/perf/util/trace-event-read.c
> +++ b/tools/perf/util/trace-event-read.c
[ ... ]
> @@ -127,6 +127,11 @@ static char *read_string(void)
>  			}
>  		}
> =20
> +		if (size >=3D (int)sizeof(buf) - 1) {
> +			pr_debug("string too long (max %zu bytes)", sizeof(buf) - 1);
> +			goto out;
> +		}
> +
>  		buf[size++] =3D c;
> =20
>  		if (!c)

[Severity: High]
This isn't a bug introduced by this patch, but integer truncation when pass=
ing
a 64-bit size to a 32-bit do_read() parameter can lead to out-of-bounds rea=
ds.

In tools/perf/util/trace-event-read.c, do_read() expects a 32-bit integer:

static int do_read(void *data, int size)
{
    ...
}

However, read_ftrace_file() passes an unsigned long long size parameter
into it:

static int read_ftrace_file(struct tep_handle *pevent, unsigned long long s=
ize)
{
    ...
    buf =3D malloc(size);
    if (buf =3D=3D NULL) {
        ...
    }

    ret =3D do_read(buf, size);
    if (ret < 0) {
        ...
    }

    ret =3D parse_ftrace_file(pevent, buf, size);
    ...
}

If a maliciously crafted trace file provides a size like 0x100000005,
malloc(size) on 32-bit architectures truncates and allocates only 5 bytes. =
The
size parameter in parse_ftrace_file() remains the full 64-bit value, which
would result in a massive out-of-bounds read.

On 64-bit architectures, do_read() truncates the size and reads only 5 byte=
s,
causing parse_ftrace_file() to process up to 4GB of mostly uninitialized
memory.

Does this code need to update do_read() to use size_t or ssize_t to properly
handle the size parameter?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722113552.1911=
43-3-tshah@linux.ibm.com?part=3D1
