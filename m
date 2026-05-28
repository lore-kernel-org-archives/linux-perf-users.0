Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEC964
	for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 00:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779927078; cv=none; b=Z1frhfzhLurt7sGpGtIbFzTWzRIw0XD54ZHw3ewDbh4VUH6bTx9S4Q28VGORCiaC0b9VvSOBQJ4/xRAToXAEVBtiUdpU11p400g+oonoK4R+keHMUtRV9t40p+8n/Jq/H+U/Z5P0WdI/3HfUxAO+r7xerWzf7SD/AseTTEZQbjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779927078; c=relaxed/simple;
	bh=IBoWIZ1sBaidutMaeNkOQvz2X8WBV0uTzdCGe0lgQ3k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ITh+VIObBYLtqn3frHCezAWJDbqIvfTvt0beaYsrI5791VfQwVXqtEqTifJ2bXF2gsEufIH0pVYbqEC8z1hyJfSHCvTllU/2Hj8Ze7/NwdLGyhi89aWCPHVapl4NEjH8/s3GFcPTva3uvXbEHJaK1a0XoUttSlVk0Z4PUi0W5mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyrRkNRt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyrRkNRt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBF11F00A3A;
	Thu, 28 May 2026 00:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779927077;
	bh=DAj4dxg1qUUxSrkSfKijVbSBzPAQb2ljKEhO0EfP0X8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZyrRkNRttoK+LZZcSdHN1GKke+Pgv/LlhuFE1IKPL/LIlBwdzor+TSYjsXkdIOqzl
	 N8tFnRaBbUa8o/Er+1LSmrNgKUtxVZXz8HIQf1OTYcrzdhtPwwS7xSFJQP3nrJplx5
	 NL7w0Z3o7tyD0pu+NPk6GLoixJ0Wrb7Z1iBj0iFHkLGILznSJYXxFzRMJVs8yMhBV4
	 g7YQ3UyF3eTti8W/V6h7XKtKYi60F01F7xDBkwpAJTVc6t3Ur74aFdvF17rgnNXgaf
	 YpSS/yzJo6JJIbqcQSmEFbmFfdujfOyGJzL8VkjwV9AT8D4QL3whDuYk9d95TZEqaX
	 K2AzuqtowcwRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v7 1/2] perf pmu intel: Generalize SNC cpumask
 adjustment for multiple platforms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260527221934.3830896-1-ctshao@google.com>
References: <20260527221934.3830896-1-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 00:11:16 +0000
Message-Id: <20260528001117.3BBF11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] An integer overflow in `uncore_cha_snc()` can result in a nega=
tive Sub-NUMA Clustering (SNC) node index. This bypasses the upper-bound ch=
eck against `MAX_SNCS` and causes subsequent out-of-bounds array accesses.
--

commit be394e8b7ddbe730c3fc40fb608337fe19c7b33b
Author: Chun-Tse Shao <ctshao@google.com>

perf pmu intel: Generalize SNC cpumask adjustment for multiple platforms

This commit generalizes the Sub-NUMA Clustering (SNC) logic previously
specific to Granite Rapids to support multiple Intel platforms. It uses
CPUID to determine SNC support and caches various PMU configurations
to improve thread safety.

> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pm=
u.c
> index 7c9d238922a6c..9b00d5720fb7a 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c

[ ... ]

> @@ -121,46 +142,73 @@ static int uncore_cha_snc(struct perf_pmu *pmu)
>  		return 0;
>  	}
>  	chas_per_node =3D num_cha / snc_nodes;
> +	if (chas_per_node =3D=3D 0) {
> +		pr_warning("Unexpected: chas_per_node is 0 (num_cha=3D%d, snc_nodes=3D=
%d)\n",
> +			   num_cha, snc_nodes);
> +		return 0;
> +	}
>  	cha_snc =3D cha_num / chas_per_node;
> =20
>  	/* Range check cha_snc. for unexpected out of bounds. */
>  	return cha_snc >=3D MAX_SNCS ? 0 : cha_snc;

[Severity: Critical]
This is a pre-existing issue, but does this range check safely handle very
large values for cha_num?

Since cha_num is parsed as an unsigned int via sscanf() from the PMU name,
and cha_snc is a signed int, a sufficiently large cha_num could cause the
division result to overflow into a negative value.

If cha_snc becomes negative, the cha_snc >=3D MAX_SNCS check evaluates to
false, allowing the function to return a negative index.

Could this negative index then cause out-of-bounds array accesses when used
later in uncore_cha_imc_compute_cpu_adjust()?

uncore_cha_imc_compute_cpu_adjust() {
    static bool checked_cpu_adjust[MAX_SNCS];
    ...
    if (checked_cpu_adjust[pmu_snc])
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527221934.3830=
896-1-ctshao@google.com?part=3D1
