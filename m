Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542A9377A87
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 17:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999791; cv=none; b=IJCNmPKCfhwWIJ1qm+8WR1eVA5IKUrBKRmurwwl9FCYdDtHsMp6tQe6dUC1/JUHl6Ja3YfS26aMQv2avlArZru7ECX9W8zI469zH6iYBITKRZX1S6yo8n+tyfOFu3Qd8xju/3qv9YbRTjQxdgVfBMVmWmYiQQDKQmOQ9ltXQT6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999791; c=relaxed/simple;
	bh=FrYFeNI5+M4O0ZQ++AEEehYmKpkuxHCd+bKZzbFGGCQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=kGZTJTXB1Z+HueiNy7pXZ72FvmWGlW0gR6F4EhlhazQPYnVezagHGgyEShUseenF+V89iwfnTd2P/NPzg079/gQSXYEESLs1mVgNQwAjwwSg5iY/mpQFnjMQTECbkOOwhQnrVWHUpdAar7hwHCmxaU7ze/vCVrVY71ebT2OF+sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4npUAUu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4npUAUu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27081F000C4;
	Wed, 14 Oct 2026 17:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791999789;
	bh=OjQq4zL4eOEmVpcQ9H1xzLOVkbwHiWJjV16cTdLM4jk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O4npUAUuN7RazwIpyPpwXXCpo/tc9z3i4ID7KCWzvFI88UK7N1/6adMWWrOyFLFuI
	 xaAGfiFhHal2WmqDDJwjkm9k6KbT1wpjiCN0qQNjmrwoPg53z9kfpvli4rDvAjqtq2
	 q7DWDJgmMQaMuchCnpMsBaTEbeA3MyED3zaI7KNO+X9lAyMxiW5oJi5AUCxi4TegtP
	 uc5UxwChRnQ9ph7jxR8w04pm8o1r4O9t6pcB8Z8s46Jm6C7e++/8/4FYgNx3NMRMV5
	 YMDAeyJZ+n/BUoSeseqBOVii/CYj5PJ6DHIRp1fWBZcyn3G0OFvfuiDuIQ+JitLSlU
	 vut67RX/RAedg==
Message-ID: <sashiko-outbox-171587@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] perf: zstd: factor out zstd_init_{c,d}stream()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ivan Shapovalov" <intelfx@intelfx.name>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261014-perf-zstd-v1-2-9652727886fa@intelfx.name>
References: <20261014-perf-zstd-v1-0-9652727886fa@intelfx.name>
 <20261014-perf-zstd-v1-2-9652727886fa@intelfx.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 17:43:09 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf: zstd_decompress_buffer() returns SIZE_MAX instead of 0 on er=
ror
--

commit 1d761c8689bb9c7209c96548d100b2308a92f2a5
Author: Ivan Shapovalov <intelfx@intelfx.name>

perf: zstd: factor out zstd_init_{c,d}stream()

Factor out functions to manage CStream/DStream in struct zstd_data
for reuse across multiple zstd (de)compression entry points.

> diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
> index af113660d1ce0..3af8910bb87cf 100644
> --- a/tools/perf/util/zstd.c
> +++ b/tools/perf/util/zstd.c
[ ... ]
> @@ -107,24 +139,14 @@ ssize_t zstd_compress_stream_to_records(struct zstd=
_data *data, void *dst, size_
>  size_t zstd_decompress_buffer(struct zstd_data *data, void *src, size_t =
src_size,
>  			      void *dst, size_t dst_size)
>  {
> -	size_t ret;
> +	ssize_t ret;
>  	ZSTD_inBuffer input =3D { src, src_size, 0 };
>  	ZSTD_outBuffer output =3D { dst, dst_size, 0 };
> =20
> -	if (!data->dstream) {
> -		data->dstream =3D ZSTD_createDStream();
> -		if (data->dstream =3D=3D NULL) {
> -			pr_err("Couldn't create decompression stream.\n");
> -			return 0;
> -		}
> +	ret =3D zstd_init_dstream(data);
> +	if (ret < 0)
> +		return ret;

[Severity: High]
Since zstd_decompress_buffer() returns a size_t, will returning a negative
error code here implicitly cast -1 to SIZE_MAX?

It looks like callers such as perf_session__process_compressed_event() check
for a 0 return to detect failure. If zstd_init_dstream() fails, wouldn't
returning SIZE_MAX cause the caller to treat it as a huge success,
potentially leading to massive out-of-bounds size increments?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-perf-zstd-=
v1-0-9652727886fa@intelfx.name?part=3D2
