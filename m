Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3D233D6F9
	for <linux-perf-users@vger.kernel.org>; Fri,  8 May 2026 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778264428; cv=none; b=RKTrF6wsnS2NTMMw2cZvBatDAFMUCY5JIEPdXxF5AK6paNSr7bLkKcEdznjyY1XbcDq/SdSG1rz+XA2WZWF5Lj7gOk85PmJ3TjCiNGxJLRHfgYpHiNEqFdPNzkxMdQSEDdXrGqIgw5+26HeaASzbAFApXQbjwZjOsu5mVGeF1Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778264428; c=relaxed/simple;
	bh=7FkuwFJN2HKqQJekjFlQmaJpFSEiL6xphWm4ZO5b2yk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MfUtbc2QG96Rr3KZKFf+4K4fw8GtJBrJPK7XKxlNXolF4MMN7JDE75WrFCoMpFEag+lAH0WfCXrMZK8UZE6Ae0ySEl5XFnmF6OVXTRbnH7jlpUIR2ZB7jKmlquw4ANmZhh0h30vtXM+5dFaSJbIZIXTYgdh4BtlpYAjsNLe82Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfCmy9L3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfCmy9L3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DF1C2BCC7;
	Fri,  8 May 2026 18:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778264428;
	bh=7FkuwFJN2HKqQJekjFlQmaJpFSEiL6xphWm4ZO5b2yk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=jfCmy9L3R/UOt35leTgja/RjVcJItIq4D2xVYHnV/VAdFbaZNhS8n2xVzWCaHa4vO
	 ehnvKjt3oDNeR2WfNL0dKnVfgeuAQoyE1TpwkKK16cbMQ7SESeIOney0Hjbxsa4QCd
	 qg8fSWLEV4DL7+YuQH7V1fQ377w4NKbB4MO1ydbKePjXQkzHkTlUJbK1rgvwHeiAk1
	 OnGV+TL+GCW7Kif39ehZP9R3Nizztt/61dAgzGx8HvSi+yq5J4FgUzGuCFCUA4uc2/
	 QNGn/nlMcRbB1CztOaCSDD6TjItVs7dpPeHrHaib9UisP90sRZJtuDaU+A5hsipLQY
	 jdfBaTgoeUZBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/8] perf amd ibs: Suppress bogus TlbRefillLat and
 DCPhysAd on Zen4+
Reply-To: sashiko@lists.linux.dev
To: "Ravi Bangoria" <ravi.bangoria@amd.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260508060004.2575-5-ravi.bangoria@amd.com>
References: <20260508060004.2575-5-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 18:20:27 +0000
Message-Id: <20260508182027.F2DF1C2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch uses a value-based heuristic to suppress the output of Ib=
sDCPhysAd if it is zero, which incorrectly hides valid memory accesses to p=
hysical address 0x0.
--

commit a0f442c06429e0cbb710a06da2ee24b2a327f365
Author: Ravi Bangoria <ravi.bangoria@amd.com>

perf amd ibs: Suppress bogus TlbRefillLat and DCPhysAd on Zen4+

This commit updates the decoding of IBS MSRs on Zen4+ to add validity
checks for TlbRefillLat and DCPhysAd. It also attempts to avoid printing
zeroed physical addresses that the kernel sanitizes for unprivileged users.

> diff --git a/tools/perf/util/amd-sample-raw.c b/tools/perf/util/amd-sampl=
e-raw.c
> index b084dee76b1a7..385308c55f347 100644
> --- a/tools/perf/util/amd-sample-raw.c
> +++ b/tools/perf/util/amd-sample-raw.c

[ ... ]

> @@ -253,8 +260,12 @@ static void amd_dump_ibs_op(struct perf_sample *samp=
le)
>  	pr_ibs_op_data3(*op_data3);
>  	if (op_data3->dc_lin_addr_valid)
>  		printf("IbsDCLinAd:\t%016llx\n", *(rip + 4));
> -	if (op_data3->dc_phy_addr_valid)
> +
> +	/* Use !zen4_ibs_extensions as a proxy for Zen3 and earlier */
> +	if (op_data3->dc_phy_addr_valid && *(rip + 5) &&
> +	    (!zen4_ibs_extensions || op_data3->dc_lin_addr_valid)) {
>  		printf("IbsDCPhysAd:\t%016llx\n", *(rip + 5));
> +	}

Does checking *(rip + 5) here suppress valid memory accesses to physical
address 0x0?

While this successfully hides kernel-zeroed addresses for unprivileged user=
s,
it seems like it cannot distinguish between software-zeroed values and actu=
al
0x0 addresses. Could this silently discard valid diagnostic data during
privileged profiling sessions if an actual hardware access to physical page=
 0
occurs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508060004.2575=
-1-ravi.bangoria@amd.com?part=3D4
