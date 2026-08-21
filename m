Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC342ED84A
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 00:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787272165; cv=none; b=kEhdAIuCueXN6yn8035pezXxGZTK4bB0HuaDvVKeI5+2sJCIFDcGrW2GzFlLZI1HnSZ5BVdNDpooQR8qKyxExNLBXjO5bzlLqkSVhCG20X8ass8d2+XpuWDwuKZHs0UmjcdS9hZ1KP4BciQFwjC6J8vrXoJ3ml9x/V8GtX5mJNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787272165; c=relaxed/simple;
	bh=IyNpzYk6ZL/PG8N9rVVmk9n3Vu2TCg3IcRBqlUQRQAw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NP3rZH3HhEXxjfrdt1CdV4B7GD0bl3W+UQASuw2lHeeCm4YlSfBxeRtaJzyjWVfCNYwz/+9RNfCj/VZD2XIPF7UzoG9a1TWjiN1RPpG9MNu8/S7C3+Ea3KYwVeU3EKdZwdTJxV2/7jljS3pjiUOXwKu6xRLhaBZQV5ZQaHn0aQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTgza3fU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTgza3fU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AB41F00A3A;
	Fri, 21 Aug 2026 00:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787272163;
	bh=bWGRbEnLoulvAkAMS3z9GfjNtaUyYTd2wgAXMmdOfD0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eTgza3fUkRuW+R9JIMmimHg6IizI5qDDXCmyr4iq6mQc4Lh5dDF5XoWA2HaPHPQ/c
	 bVEA2lQx0AzGR1i/PCk/TMed+ZOisrD/rv7r8K0+vsjN3cbR4Tku5M802iyh90+f2k
	 XnKf9lzC0HoVOz1YSV4aHf5CH8t7nkh9bSWyizJQl/gAB7JhAGwbbJVwa2pVO1Og1B
	 3Jiuep33fjxphQv1hHn+OrMdrhtsyL45Z7xPs+QqaVXjEMvsnJTk8NaQeqgig5edzZ
	 IrKRd7mSl9QpFeARnhjQDAbpRGqV66P9UVajRYiku7dbomuV6doSpT0SLfLN3qR/A2
	 9U+NK44+KzCRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/6] perf mem: Fix size tracking for mem_lvl's in
 perf_script__meminfo_scnprintf()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821001819.162277-2-thomas.falcon@intel.com>
References: <20260821001819.162277-1-thomas.falcon@intel.com>
 <20260821001819.162277-2-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 00:29:23 +0000
Message-Id: <20260821002923.70AB41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unsafe use of strcat and integer underflows in memory event format=
ting helpers cause stack buffer overflows.
--

--- Patch [1]: [PATCH v5 1/6] perf mem: Fix size tracking for mem_lvl's in =
perf_script__meminfo_scnprintf() ---
commit 658933771fa5b1a578c37be7178d9227ed479ba1
Author: Thomas Falcon <thomas.falcon@intel.com>
perf mem: Fix size tracking for mem_lvl's in perf_script__meminfo_scnprintf=
()

This commit fixes the size parameter passed to perf_mem__lvl_scnprintf()
by providing the remaining buffer size instead of the entire buffer size.

> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -610,7 +610,7 @@ int perf_script__meminfo_scnprintf(char *out, size_t =
sz, const struct mem_info *
>  	i +=3D scnprintf(out, sz, "|OP ");
>  	i +=3D perf_mem__op_scnprintf(out + i, sz - i, mem_info);
>  	i +=3D scnprintf(out + i, sz - i, "|LVL ");
> -	i +=3D perf_mem__lvl_scnprintf(out + i, sz, mem_info);
> +	i +=3D perf_mem__lvl_scnprintf(out + i, sz - i, mem_info);

[Severity: High]
This is a pre-existing issue, but does passing the remaining buffer size
here expose a stack buffer overflow in the formatting helpers?

When processing a maliciously crafted perf.data file with multiple flag bits
set, the string formatting can exhaust the 200-byte stack buffer decode[]
allocated in data_src__fprintf(). As the remaining size (sz - i) approaches
zero, perf_mem__lvl_scnprintf() receives a small or zero size.

Looking at perf_mem__lvl_scnprintf() and perf_mem__snp_scnprintf(), they
unconditionally decrement the size parameter:

perf_mem__lvl_scnprintf() {
        ...
        sz -=3D 1; /* -1 for null termination */
        out[0] =3D '\0';
        ...
}

If sz is 0, this causes an integer underflow to SIZE_MAX. Furthermore, the
helpers use unbounded strcat() when multiple bits are set:

perf_mem__lvl_scnprintf() {
        ...
        if (printed++) {
                strcat(out, " or ");
                l +=3D 4;
        }
        l +=3D scnprintf(out + l, sz - l, ...);
        ...
}

The strcat() can write past the end of the buffer. Because l then exceeds
sz, sz - l underflows, which disables bounds checking for subsequent
scnprintf() calls.

Should these helpers be updated to return early if sz is 0, and use bounds
checking instead of strcat() to avoid corrupting the stack?

>  	i +=3D scnprintf(out + i, sz - i, "|SNP ");
>  	i +=3D perf_mem__snp_scnprintf(out + i, sz - i, mem_info);
>  	i +=3D scnprintf(out + i, sz - i, "|TLB ");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821001819.1622=
77-1-thomas.falcon@intel.com?part=3D1
