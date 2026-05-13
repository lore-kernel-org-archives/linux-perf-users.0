Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF619355F54
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 04:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778646971; cv=none; b=QKZjpuT5jM5Y9ZEwUfKIUA9axyoAiZlb8TQb3SorOn8Ne68d7iYvz97Gm8tCyMd+7ud4Xgst6ZgRDqGkmwzQ+hWb1hPbpPlvoutuDgXCL9wrkl1Ant3/Mu6nbxjBkttIB5QIGJlt8QAPmQZMyYPVzGInzZPrw1IGrPHn61TPLcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778646971; c=relaxed/simple;
	bh=6bArCr0bJW8/xO+OEf9GHy3aDb6nCNN+dpqIjiwUfzo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PclCVCVLT38HlEudVbjx+TZzyBGn6Nkhhrpv9HCcE7vYwb7pmLx2/E0xb1HVirTbLWsWJGxlC4ieQuZ6c7K9YIeyPdRE41ajYvLt3pylNKjraUh1UZJzab0Vqpqam8baHX0djfXciLbcY1YRtcMnibmIIyeGJwPO5s1VE1UbajE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsKzaY//; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsKzaY//"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99595C2BCC6;
	Wed, 13 May 2026 04:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778646971;
	bh=6bArCr0bJW8/xO+OEf9GHy3aDb6nCNN+dpqIjiwUfzo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=qsKzaY//ND3aoAdBgfiXWnoNlIxiD5/+qIf+6kh0Z/myRFVBCW9UJPmm5vwKDYAYL
	 aInUtlxJ0agQi2SvjAzI5m7z2JEhH4h8/kfv1NSKqqVTRRRJzl4w1Hzh9vU9C0PA/9
	 nYW9wB0jUescsR3SfUon39+4Z1UEE5rN7JS75NrZKafsDJPZdVMhGYBJ4Jl0ue+rJg
	 WlBpt2o0s83IVMpN812DPuQ1ZcvcNUjNdvWRRzpG1anvY42MxGGQKvIY+JcbfWqh8J
	 c0tkYlx8XyTsHMk4Ovd6msmczkUlwk0WN3rXBg1DDoTxv56BHRIXJ98B5q/Kdyp+Hp
	 RkxM4/Ulyfn3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 18/28] perf header: Validate f_attr.ids section before
 use in perf_session__read_header()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260510033424.255812-19-acme@kernel.org>
References: <20260510033424.255812-19-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 04:36:11 +0000
Message-Id: <20260513043611.99595C2BCC6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The per-attribute caps fail to prevent total memory exhaustion, al=
lowing a small crafted file to reliably trigger an Out-Of-Memory (OOM) pani=
c via overlapping ID sections.
--

commit 19eb906f7ac517fa0070cb7144ca1e4c2646e3ff
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Validate f_attr.ids section before use in perf_session__read_h=
eader()

This commit adds validation to the perf.data f_attr.ids section to prevent
integer truncation and heap corruption. It caps the number of attributes and
IDs per attribute, ensures size alignment, and checks that ID sections fit
within the file size.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c

[ ... ]

> @@ -4968,6 +5004,45 @@ int perf_session__read_header(struct perf_session =
*session)
>  			perf_event__attr_swap(&f_attr.attr);
>  		}
> =20
> +		/*
> +		 * Validate ids section: must be aligned to u64, and
> +		 * the count must fit in an int to avoid truncation in
> +		 * nr_ids and size_t overflow in perf_evsel__alloc_id()
> +		 * on 32-bit architectures.
> +		 */
> +		if (f_attr.ids.size % sizeof(u64)) {
> +			pr_err("Invalid ids section size %" PRIu64 " for attr %d, not aligned=
 to u64\n",
> +			       f_attr.ids.size, i);
> +			err =3D -EINVAL;
> +			goto out_delete_evlist;
> +		}
> +
> +		/*
> +		 * Cap the ID count to avoid int truncation of nr_ids
> +		 * on 64-bit and size_t overflow in the allocation
> +		 * paths (nr_ids * sizeof(u64), nr_ids *
> +		 * sizeof(struct perf_sample_id)) on 32-bit.
> +		 */
> +		if (f_attr.ids.size / sizeof(u64) > MAX_IDS_PER_ATTR) {
> +			pr_err("Invalid ids section size %" PRIu64 " for attr %d, too many ID=
s\n",
> +			       f_attr.ids.size, i);
> +			err =3D -EINVAL;
> +			goto out_delete_evlist;
> +		}
> +
> +		/*
> +		 * FIXME: see perf_header__process_sections() =E2=80=94 block
> +		 * devices bypass this check because st_size is 0.
> +		 */
> +		if (S_ISREG(input_stat.st_mode) &&
> +		    (f_attr.ids.offset > (u64)input_stat.st_size ||
> +		     f_attr.ids.size > (u64)input_stat.st_size - f_attr.ids.offset)) {
> +			pr_err("Invalid ids section for attr %d: offset=3D%" PRIu64 " size=3D=
%" PRIu64 " exceeds file size %" PRIu64 "\n",
> +			       i, f_attr.ids.offset, f_attr.ids.size, (u64)input_stat.st_size=
);
> +			err =3D -EINVAL;
> +			goto out_delete_evlist;
> +		}
> +

Does this allow a small crafted file to trigger an out-of-memory panic?

The offset and size checks verify that the section falls within the file,
but there doesn't appear to be a check preventing multiple attributes from
pointing to the exact same offset and size.

Because the aggregate number of IDs across all attributes is not capped,
could a crafted file declare MAX_NR_ATTRS (65,536), all pointing to the same
valid 128MB ID section?

This might cause the subsequent loop to repeatedly allocate and populate me=
mory
for each attribute, forcing the physical pages to be faulted in and potenti=
ally
exhausting physical memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260510033424.2558=
12-1-acme@kernel.org?part=3D18
