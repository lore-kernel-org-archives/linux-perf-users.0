Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656EE318BB5
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 03:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776136574; cv=none; b=j5/eJBaMpmcTLVZPvqVZL+HrRs5JDsX4cgB4vR7/NxaB7vU1JexeOV+46LdxlFhpaPspktZrQfAOFGVrDao5onatBYFwidE9wRT8jSdjazH+KUnwHf8eNFuIzkGBA3RPoBLrJzze2y3g5H10FTV3FpXygufpVnOt5VchKPna9ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776136574; c=relaxed/simple;
	bh=7uR0DAi+y1/9fEBbXSZ5ne1xmKLXHzlTKylEdYkIKTI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hnhFcjRBEeWw+7slbvl8YAHhvof6xEAo1p0vsMieGDjDyiI7PKGBSGeoDVQzcKvB8nK2pZpmb9kIQoS/3dwbXBJv40MvwG1DslVvlV94c6u3BE6Rse7L4MN/s+bx1aC4JCJeZ27ceDzoUD8Cnxy686oeYbnJCECypY/aKwjpur4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdFfAbVI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdFfAbVI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC82EC2BCAF;
	Tue, 14 Apr 2026 03:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776136574;
	bh=7uR0DAi+y1/9fEBbXSZ5ne1xmKLXHzlTKylEdYkIKTI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=RdFfAbVIEs+Odl/hgV8LoRIhitlrElAk6LXYW3+DxHMZtKbTdETwHp5z4OipY6QlM
	 PJFfsjxBruzHxbzBX4Fzhx3xq64kfGNLthd2W3KTSgUNXQflmLAhLnnNu6HI9gG3xn
	 vYeuckQjvtKaCYjnCgoyops98b/2+Qc06KwzSWxGWp3N6jeD3ix+gq616De7GlvB4K
	 bcx0ckX4llodUOQd39fTSllGhP9bERlgZY0cdjGbRcLV41uA2DUV0QUZnVtkIibC8e
	 BqW/ApHQyZXkwy8qlbG7bp+TyPS5iosfzA3c1MaLIfq1gDVcJT0RWCLPHhwq9Y8Wje
	 mKBRuzeWaPrgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf/x86/intel: Fix kernel address leakages in LBR
 stack
Reply-To: sashiko@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260414021440.928068-2-dapeng1.mi@linux.intel.com>
References: <20260414021440.928068-2-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 03:16:13 +0000
Message-Id: <20260414031613.CC82EC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] The patch addresses kernel address leakage in Intel's LBR software=
 filter but overlooks identical vulnerabilities in AMD's LBR and BRS softwa=
re filters.
--

commit 8dbb741871f5824e6032a6a5fa35f5db78494ff9
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Fix kernel address leakages in LBR stack

This commit fixes a kernel address leakage in the Intel LBR stack by extend=
ing
the software filtering to check both the source and destination addresses.
Prior to this change, kernel-to-user branches like SYSRET could leak kernel
addresses to user space even when PERF_SAMPLE_BRANCH_USER was requested.

> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 16977e4c6f8a5..deef81c16571a 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
[ ... ]
> @@ -1244,8 +1244,15 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>  				type |=3D X86_BR_NO_TX;
>  		}
> =20
> -		/* if type does not correspond, then discard */
> -		if ((type & ~X86_BR_PLM) =3D=3D X86_BR_NONE || (br_sel & type) !=3D ty=
pe) {
> +		from_plm =3D kernel_ip(from) ? X86_BR_KERNEL : X86_BR_USER;
> +		/*
> +		 * If type does not correspond, then discard.
> +		 * Especially filter out the entries whose from or to address
> +		 * is a kernel address while only X86_BR_USER is set. This prevents
> +		 * kernel address from being leaked into a user-space-only LBR stack.
> +		 */
> +		if ((type & ~X86_BR_PLM) =3D=3D X86_BR_NONE || (br_sel & type) !=3D ty=
pe ||
> +		    (!(br_sel & X86_BR_KERNEL) && (from_plm & X86_BR_KERNEL))) {
>  			cpuc->lbr_entries[i].from =3D 0;
>  			compress =3D true;
>  		}

This patch successfully addresses the kernel address leakage in Intel's LBR
software filter, but does it leave AMD platforms exposed to the same KASLR
bypass?

Looking at arch/x86/events/amd/lbr.c, amd_pmu_lbr_filter() appears to class=
ify
branch privilege levels based exclusively on the destination address via
branch_type_fused(). Does this mean it classifies kernel-to-user branches as
user-space and leaks the source kernel address?

Similarly in arch/x86/events/amd/brs.c, amd_brs_drain() filters branches
using amd_brs_match_plm() which explicitly checks only kernel_ip(to). Would
this also blindly accept the branch and log the source kernel address?

Should equivalent privilege level checks for the source address be added to
the AMD routines to fully resolve the issue across platforms?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414021440.9280=
68-1-dapeng1.mi@linux.intel.com?part=3D2
