Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC272E0914
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jun 2026 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781799969; cv=none; b=p0OsfuLSciY5GM12OrH4xVcM2CKwsu6liJtLFTkwNXimjKY7FrzEOGwGmICqYBXM5DB7vQtiTcdVl4yF1kiucA4z3c1jgI6E192XRjO1+KpMKbP0Na3vh8c29NoyhhimxlLq/8oGkL/BweNDic9JQAzgaPpcuncijEroTCsatjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781799969; c=relaxed/simple;
	bh=nZgE3837EHUCnxOVJ6pnZzbloDuhm85UakGUGCpot/8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=phcORi9xDjiMnVAudB/fQVwMnRoSlX9+JpP7geWP6Xe/GatGZCIxkRYdcv2mWIkmOuhzj+7B7EEgG1Uhs2YEu3/Ak+wWPTUuEFijpaWAQu9sdddTuw0N6MnEPwK0toTT3i0KqUUHT+YV2io45udB2udKE7DNDWJyKPS1CLy8NAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIRjQy/s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIRjQy/s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C381F000E9;
	Thu, 18 Jun 2026 16:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781799967;
	bh=rWjBOLrV3RYEaQQ1uIKxT4etS5m/uBnvIZvEUDiSiuc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MIRjQy/sEOKthwgwzd0ZZTaqFhkDhw2YJAY/I8WOjptGL3rWX15IWXg2jo7SiiYB6
	 lpW0yiNyCVL2+jOkf+13iTUjlKlhl4uVsKkMag2Isn8rj7GJ2MRnacTq5FQ0QaYFsX
	 swSiNPBOVXxOqtcWbWoszBu+WcH32ZL/6ugs9WrMqlNKBg300JAu149Mnvr4eaCz5Y
	 vsalHxzhaWiuMDmwUCPTuX7WCPEkdbx4DqzZln1G60VNfE2C1nQ92g2+b4hqK1O2ou
	 fM6ln6yaOx4r6BwGNAHhZ/5Xrb4y4xtGMOWKSleEXbTUzaNMLTsAHMhFLr5lrmbGpd
	 i6beHUgFeWxrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] perf record: Fix multiple PERF_RECORD_COMPRESSED2
 records per push
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Ilvokhin" <d@ilvokhin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <efb81ee56e376079050d79690c00c718bbb444cf.1781797544.git.d@ilvokhin.com>
References: <cover.1781797544.git.d@ilvokhin.com>
 <efb81ee56e376079050d79690c00c718bbb444cf.1781797544.git.d@ilvokhin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 16:26:07 +0000
Message-Id: <20260618162607.B9C381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing bounds check on `dst_size` during the first iteration =
causes unsigned underflow and out-of-bounds writes.
--

commit 05c1411c44b6c31eba9854745a0f8d5ce767f17a
Author: Dmitry Ilvokhin <d@ilvokhin.com>

perf record: Fix multiple PERF_RECORD_COMPRESSED2 records per push

With Zstd compression enabled, a single mmap push whose compressed output
exceeds the maximum record size emits several back-to-back compressed
records. The record__pushfn() function incorrectly rewrote only the first
record's header to describe the whole blob, which resulted in a bogus
truncated length and corrupted the perf.data file. This patch fixes the
issue by framing each record properly where it is produced, ensuring the
sizes remain valid.

[ ... ]

> diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
> index 57027e0ac7b65..1955fa2431d17 100644
> --- a/tools/perf/util/zstd.c
> +++ b/tools/perf/util/zstd.c
> @@ -30,7 +30,7 @@ int zstd_fini(struct zstd_data *data)
> =20
>  ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *ds=
t, size_t dst_size,
>  				       void *src, size_t src_size, size_t max_record_size,
> -				       size_t process_header(void *record, size_t increment))
> +				       size_t process_header(void *record, size_t data_size))
>  {
>  	size_t ret, size, compressed =3D 0;
>  	ZSTD_inBuffer input =3D { src, src_size, 0 };

[Severity: Critical]
This isn't a bug introduced by this patch, but is there a missing bounds ch=
eck
on dst_size during the first iteration in this function?

Looking at zstd_compress_stream_to_records(), the bounds check explicitly
skips the first iteration because hdr_size is initialized to 0:

	while (input.pos < input.size) {
		if (hdr_size &&
		    dst_size < hdr_size + max_record_size + sizeof(u64)) {
			pr_err("failed to compress: output buffer too small\n");
			return -1;
		}
		record =3D dst;
		size =3D process_header(record, 0);
		hdr_size =3D size;
		compressed +=3D size;
		dst +=3D size;
		dst_size -=3D size;

If this function is called with an initially small dst_size (e.g., < 16),
process_header() will perform an out-of-bounds write of the 16-byte
perf_record_compressed2 header.

Following this, dst_size -=3D size will unconditionally unsigned underflow =
to a
massive value. This allows ZSTD_compressStream() to write up to
max_record_size bytes out-of-bounds into the dst buffer.

Could this be triggered in aio mode if perf_mmap__push() splits a wrap-arou=
nd
kernel ring buffer, and the first compressed chunk leaves less than 16 bytes
in the aio->data buffer? The second call to zstd_compress() would then pass
a dst_size < 16, bypassing the bounds check on the first iteration and
triggering a buffer overflow.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781797544.gi=
t.d@ilvokhin.com?part=3D1
