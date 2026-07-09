Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E874347BAF
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 22:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636167; cv=none; b=chAx3a2k2RIuRgMU6nZ6c6V0uWINpn32teB6/FAsftVd47WC3q6Hl73tQxD1LXP2EKro0iX3JTROSpR5jAnV3ejVTV2rL52M4FfbFSrMHPC4XertQl2a10b68iCfP19gpg6JYQXdbuGGObce9gl49i9jwrZ/NuhZTLdkIb4dZzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636167; c=relaxed/simple;
	bh=6mXAaazDpzt/1UbwfdGzS8/CkbPD9RYH+l2jj8pPebQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sBN1KajXtJAVvTP6JSwta8TyIJVLnFP6QyCBrChpnKnajmowslxujnVfLYGL83w+WShDF6WF1C7oAAaIS/SCwB/gAOlrd93irF6Fv3PuBCOSN04sQv0JyEX2N0rLY4ySNPhGbl9VLsMLD1869in2DrAxE1oQE5H8ZddWCL/ikDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMZlX0Nf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMZlX0Nf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B5E1F000E9;
	Thu,  9 Jul 2026 22:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636166;
	bh=sJP//1b/vvnfevgmoQaCd3yo/fsCf7W3FGyQ9I8pWGo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XMZlX0NfNW77eyE7//6PvojAsfasTN/9yWjDOg5U1cV/OABa5WcQxJCbvUme+xEPO
	 4WoIEyuUcrcQZhtuYFhcDzdLKYcQFEEJ8LOFyT//jgGU2q9aWoaumhqqNBxW8SyOPg
	 ysIo2FP7eBqbVcA3AVaDZ6BhZ/tJrxynL+azM2W3aXOwRHBwNB4bd6W5QpjIaegIt9
	 nGL9UXEAKZGjKeym7GJeAnZ/f223PpU441R73Qvdr4+IRDB7Feu24R1t3VzsuG3Xax
	 u9Drw1j9WfJtJytMoVRO3veo5QEjcGdqcLU/VpT813mAvA/1kEdxBycC1lTDxIWlzB
	 HTSAf91hRrFYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] perf tools: Show memory region in perf-c2c
 subcommand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260709221736.33446-4-thomas.falcon@intel.com>
References: <20260709221736.33446-1-thomas.falcon@intel.com>
 <20260709221736.33446-4-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 22:29:25 +0000
Message-Id: <20260709222925.D2B5E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing newline character in WARN_ONCE format string.
--

--- Patch [3]: [PATCH 3/6] perf tools: Show memory region in perf-c2c subco=
mmand ---
commit 13662f60c6b5c5739b7e7fe17ff89755ab8e651d
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf tools: Show memory region in perf-c2c subcommand

This commit adds a memory region field to the perf-c2c cacheline list view
to help users identify the region a cacheline belongs to. It updates the
internal structures, stats calculations, and display logic to show this
new field.

Link: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.=
intel.com/

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index c9584dbedf77a..57e822dbd2d4a 100644
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
> +		      "WARNING: invalid memory region ID"))

[Severity: Low]
Does this WARN_ONCE format string need a trailing newline character?

In the perf tools environment, WARN_ONCE uses __WARN_printf, which maps
directly to fprintf(stderr, ...) without appending a newline. As a result,
when this warning is triggered, the subsequent output will be printed on the
same line, resulting in malformed terminal output.

> +		return;
> +
> +	/* Update mem_region only if it really accesses memory */
> +	if (mem_region >=3D PERF_MEM_REGION_MMIO)
> +		c2c_he->mem_region =3D mem_region;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709221736.3344=
6-1-thomas.falcon@intel.com?part=3D3
