Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB3C2D2488
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 00:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783990586; cv=none; b=srjsUJnnQwc3ja2uMF/4UIDE+MInToT3ZH999tlJBCU1jJ5CJeg5zPPSXttQI6kCLf6uoNIYaWSU5h5DuJQbhTdLEHFlKjrmdLrsiHMfYOrdCm6kBavreRYj1nCgoiPznIyUM4URCVJXlzgOd4/+DUpWa3cZQmq0VJ0KBi6PLUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783990586; c=relaxed/simple;
	bh=H3dw/oG+dS2byT0jzH1xAPxQdJSxF/+Yh9q9VBxooFk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QwM0gNV6VpGOoFU+rbWEOnDfQUbwGoBUEuGXIHZX4Z7bIAnBYwZ8bXR5z2ObLKMpUTVLEu6JWuu8qjexUcvrk/scA8AOZJ/K0itATFcP7g8AOHko++m2WLQ5SHOibX8lBw4wAZgfbhtW2yUhB0GCzJLPXbyKf8GDaLW6nkXZKJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIYCCaQX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIYCCaQX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BAD1F000E9;
	Tue, 14 Jul 2026 00:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783990579;
	bh=5aYfii1tcgOU8z7saJW2KshJJq25lPDnr3ezoizPY70=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bIYCCaQXy0ZJXPBbwLcK42+kzL2uVaeeKf6YM1DwQu2ATRdLWFNpOxrWOAEiAes6T
	 8ZESaKr3ktkyOaDzWBFe+Zud/NOxtWI8kzHkNcW6gcEfAYQuIkOZOvL3dpTAtueEqB
	 eW/1vYsjyCd5cQwbR9cfqE/68k/hPuiIdQGp2IZ/VzMiqFKrvQx4SatfR44UyrSu0J
	 f7ZvTG2FXW4Tn+blmYpXb9UKmqj7VPFfGPC/acKtPTuOWycPE4unttnU7SmGUwMgm1
	 RREx3lq8ZVAVqSUjz8SwSKtUC1woShYQiRZdC3zfu8Pzujatikc6S38NtXS0XdIsQv
	 U1L8NNAR54JGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] perf tools: Show memory region in perf-c2c
 subcommand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260714004359.179451-4-thomas.falcon@intel.com>
References: <20260714004359.179451-1-thomas.falcon@intel.com>
 <20260714004359.179451-4-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 00:56:18 +0000
Message-Id: <20260714005619.36BAD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Arbitrary upper bound on UAPI memory region ID breaks forward co=
mpatibility for future memory tiering topologies.
--

--- Patch [3]: [PATCH v2 3/6] perf tools: Show memory region in perf-c2c su=
bcommand ---
commit 06c5065732519d0c60d1739bb8a421f9120486b9
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf tools: Show memory region in perf-c2c subcommand

This commit adds a memory region field to the cacheline list view in
perf-c2c. The new field helps identify the memory region to which the
cacheline belongs.

Link: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.=
intel.com/

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index c9584dbedf77a..cba2e9f21ae7c 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c

[ ... ]

> @@ -281,6 +282,18 @@ static void c2c_he__set_node(struct c2c_hist_entry *=
c2c_he,
>  	}
>  }
> =20
> +static void c2c_he__set_mem_region(struct c2c_hist_entry *c2c_he,
> +				   unsigned int mem_region)
> +{
> +	if (WARN_ONCE(mem_region > PERF_MEM_REGION_MEM7,
> +		      "WARNING: invalid memory region ID\n"))
> +		return;

[Severity: Medium]
Does this arbitrary upper bound break forward compatibility for future memo=
ry
tiering topologies?

The UAPI field provides 5 bits, allowing for memory region IDs up to 31. By
rejecting regions greater than PERF_MEM_REGION_MEM7, valid region IDs from
future kernels or hardware architectures will be dropped and displayed as
"N/A", while also triggering a spurious warning.

It looks like the new display logic in dcacheline_node_mem_region() can
already mathematically scale to handle these higher values gracefully.

> +
> +	/* Update mem_region only if it really accesses memory */
> +	if (mem_region >=3D PERF_MEM_REGION_MMIO)
> +		c2c_he->mem_region =3D mem_region;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714004359.1794=
51-1-thomas.falcon@intel.com?part=3D3
