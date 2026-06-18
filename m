Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B632E7365
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jun 2026 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781799661; cv=none; b=c2E6feZ/OEAqSt3KItG7wcZSlYnSyz1Vo3ARz7uqVHMVxZamdcDAnFL/ILfVHEYDMOzbUGnwLToNdcW9Sn3nkuVz3jf3cw1I3NpkQgihIvecnVp0dkhGNI4FDl4KQID/F61aMc19/Sv/JsFH1kE1od7qr86DfHkrZ92gFU/69hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781799661; c=relaxed/simple;
	bh=a+3eRjDSRRRaw1q6U+NLSeeVwP2XXOyxVdjdzTuyths=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HF87U/YRtrp56OgOf4b2BGzCifiBeMumppFt+VDktKcuaNQjCpkbf0GVqz4JbvUTy6pEjHaNpz46qOwP5/bsm6N1Fw6kt6SUkXa6Cbp2iVpygHDBSaAdzBrq+bwPKXye1WIcTxfwEKNIUVuhyu78Ok5axUqzVA6p+sNOmFtGzn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wwmtl9W0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wwmtl9W0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B59B1F000E9;
	Thu, 18 Jun 2026 16:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781799659;
	bh=cctEe7BMA02manXpewLQT2bZRk8m2zyJOw7jXniCHCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wwmtl9W0nFoPmE0+J6x2HlgIFDybO+R6fUMiiDq+m8gQrcPILC6EBPbP1/N6RvdKH
	 Semm5wvotSFbF+mKLiSc9lfzwtcB9uh2vNWhhrE6olJyYK/4vh2/XCeObxSfsu15L4
	 hViBgnua+7p9tB80zFnseGjjXSAYbTj9xgFBvLaMc3CSztqaJUJ0bRlHUW7l/e5iR2
	 uXa8tnwCk3C2A7DT9CvUhKybsG7+DIyjuodfrFI4EFjaCdzBUrHkFJDg4S7rP3NI39
	 Nf7BuaVcNl/4+vcPSch59VUf0aPIfMPzEbXJBab74PXpzCitYXkuuQ89vCZ5hcO+vZ
	 kU/0IAsj1+y0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] perf record: Avoid overrunning the zstd output
 buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Ilvokhin" <d@ilvokhin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <7860259ac13e539dfb907489be29d0487d36aeb8.1781797544.git.d@ilvokhin.com>
References: <cover.1781797544.git.d@ilvokhin.com>
 <7860259ac13e539dfb907489be29d0487d36aeb8.1781797544.git.d@ilvokhin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 16:20:59 +0000
Message-Id: <20260618162059.8B59B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The patch introduces an overly strict buffer size check that cause=
s compression to fail prematurely whenever less than `max_record_size` (~64=
KB) space remains.

Pre-existing issues:
- [High] The safety bounds check added to `zstd_compress_stream_to_records`=
 is bypassed on the first loop iteration, leaving the buffer vulnerable to =
overflow and integer underflow.
- [High] In `zstd_decompress_stream()`, the `output.dst` pointer is advance=
d while `output.pos` is improperly preserved, leading to out-of-bounds writ=
es and corrupted output if the decompression loop executes more than once.
- [High] If `perf_mmap__push` processes the ring buffer in two chunks and t=
he second chunk's compression fails, the reference to `map->core` acquired =
during the first chunk is leaked.
--

commit 09f418a2fa19ace0234b4443e193f65fb347ed8b
Author: Dmitry Ilvokhin <d@ilvokhin.com>

perf record: Avoid overrunning the zstd output buffer

This commit adds a bounds check in zstd_compress_stream_to_records() to
prevent writing past the end of the output buffer. It verifies if the
remaining buffer size is sufficient for a full record.

> diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
> index 1955fa2431d17..a0f6572ad2017 100644
> --- a/tools/perf/util/zstd.c
> +++ b/tools/perf/util/zstd.c

[ ... ]

> @@ -53,8 +53,14 @@ ssize_t zstd_compress_stream_to_records(struct zstd_da=
ta *data, void *dst, size_
>  	}
> =20
>  	while (input.pos < input.size) {
> +		if (hdr_size &&
> +		    dst_size < hdr_size + max_record_size + sizeof(u64)) {

[Severity: High]
This isn't a bug introduced by this patch, but by gating the bounds check on
hdr_size, isn't the check bypassed on the very first loop iteration since
hdr_size is initialized to 0?

If dst_size is initially very small (which can legitimately happen in=20
record__aio_pushfn() when calculating mmap__mmap_len(map) - aio->size), the=
=20
code will unconditionally write the header and decrement dst_size.

Could this underflow dst_size to a massive positive value, bypassing
subsequent bounds checks and allowing ZSTD_compressStream() to write out of
bounds?

[Severity: High]
Does this check introduce an overly strict requirement that causes compress=
ion=20
to fail prematurely?

By requiring dst_size < hdr_size + max_record_size + sizeof(u64), this=20
condition unconditionally fails compression if the remaining buffer is less=
=20
than the maximum record size (typically ~64KB).

In AIO mode, dst_size represents the remaining space in the AIO buffer, whi=
ch
naturally dwindles. If a small chunk needs to be compressed and could fit in
the remaining space, wouldn't this check spuriously abort the compression a=
nd
render the last ~64KB of every buffer unusable?

> +			pr_err("failed to compress: output buffer too small\n");
> +			return -1;
> +		}
>  		record =3D dst;
>  		size =3D process_header(record, 0);
> +		hdr_size =3D size;
>  		compressed +=3D size;
>  		dst +=3D size;
>  		dst_size -=3D size;

[Severity: High]
This isn't a bug introduced by this patch, but looking at
zstd_decompress_stream() in the same file, is there an issue with how
output.pos is handled?

tools/perf/util/zstd.c:zstd_decompress_stream() {
    ...
    output.dst  =3D dst + output.pos;
    output.size =3D dst_size - output.pos;
    ...
}

The loop advances the destination pointer but fails to clear output.pos.

If the decompression loop executes more than once, will ZSTD start writing
at the new output.dst + output.pos, effectively skipping output.pos bytes
and corrupting the decompressed stream?

[Severity: High]
This isn't a bug introduced by this patch, but does the strict bounds check
introduced above make a memory leak in AIO mode more easily triggerable?

In tools/perf/builtin-record.c:record__aio_pushfn(), a reference to map->co=
re=20
is acquired on the first successful chunk:

tools/perf/builtin-record.c:record__aio_pushfn() {
    ...
    if (!aio->size) {
        perf_mmap__get(&map->core);
    }
    ...
}

If perf_mmap__push() processes the ring buffer in two chunks, and the
second chunk's compression fails (which happens more frequently now due
to the ~64KB bounds check), perf_mmap__push() aborts and passes the error
back to record__aio_push():

tools/perf/builtin-record.c:record__aio_push() {
    ...
    ret =3D perf_mmap__push(map, &aio, record__aio_pushfn);
    if (ret !=3D 0)
        return ret;
    ...
}

Will this return immediately on failure and bypass the perf_mmap__put()
cleanup that occurs later, resulting in a leak of the map->core resource?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781797544.gi=
t.d@ilvokhin.com?part=3D2
